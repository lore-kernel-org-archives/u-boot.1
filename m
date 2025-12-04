Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973FAD2CDE4
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEAA384159;
	Fri,  5 Dec 2025 00:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F4yax3cm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FFF884159; Fri,  5 Dec 2025 00:10:33 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9ED84057
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c95936e43cso558741a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889829; x=1765494629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kd4ioD3HqdkEHu309xzk6lIbsbn9haG3ENmKkSEv1QQ=;
 b=F4yax3cmT4DdA1CUHEDxGZycE/ZzlXfv+90W1PInd3mvRKsEgZm/A8LwHsllLBfqF3
 TTLab9a0PslQtP5vew20U/UElmHUXN0VY6AizTDcxbzPFAYzvJcQKC3h08/Ihba+rw3F
 KWHh2vN9lw57vU8TGs1hijtYG9lp2HwTBcyKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889829; x=1765494629;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kd4ioD3HqdkEHu309xzk6lIbsbn9haG3ENmKkSEv1QQ=;
 b=g/yFe8VL9TBIEKZctK1E6P9snThgSUBkTvHmkJHgAxPvbWjM9sRcWYIBh9p/9tMCnB
 b1PAo9KgKUo+DcpFbqbEQSAzGyfGCufJuTBuZStSB81Oi5k+TE2+tDsnafMKzypOpGyG
 ngGi75ZphRKoyoIdtT2GJilht62cvj1sRQKnyBZ+6K07nfvHBJYQdHSnPt/brYzu3pid
 ncwL/nWW9wE46IrYlu1GNJvJs3mCSqMILFI3PPUNeXtLin4HAfdGaMqFSWyVie6wCmT4
 PhI4GVej38HyeaU2lNcW8RfiiAXvx/IZ3g70vteMBAQqcmG0PxCKvGc46LHgFNafmeDs
 bpfA==
X-Gm-Message-State: AOJu0YzvRxc7HJpPjtX0a71tDnACQ8ZinVjup4zbCjFJsW+Aljqzo6Te
 CusHrV2YwXSfsSUigmM2D11lKouk+8FH6cQYV7JVdwj9jjspBRTol4q7HAkboDjFJeE=
X-Gm-Gg: ASbGncu20hfQudNpdAnTrGH3l2mL4pXIAtvjaYyvCvU7QlWEEA4ofAG+MWtprWWh1HC
 8p76iGSuQZ20EfaKYPGfPIaIphnSvIj/fyp6VENMaKpcEP7nt18MzC5oyEDuISGle5kRL97kK+h
 Lrg7TDsXdxUhT6B5JeIp8bPMqnayRTvbIPhbBS0bbyts57hWJmLHZugLFbILCcXnm4zS+n4Xns7
 BfECHpSYAR35PmzrQljzLm9wtRN8Utz1nWS+5eK0AJqnOgaHn83MDS3qAvx5mUIu1bOo+YeUOfp
 mr6opaXAGKlQac2MTpFr1XARYTSEWtPYUEO6kEgqhO7M9srGpDWOtQFSjiIzwyevvjgPbUIo/AR
 o0QZVbCHVeHOJKjRjYgXHD4DK8Tyn+cE4ewafmSdR+gqjcRsQzjJxMYzxxYwdk5JdyIIgSOK/i8
 ifEGjBhnh4GLp3MkVc7802QF8D/XAZPuKWh8Nu6kfHqb/wD9gT
X-Google-Smtp-Source: AGHT+IHPCUi9ZpZdNMUl7w3wdqq1RdRgwUgOQ/Z9HsASMGQYgyXqz8Sc9wI6PE9W7xdumgilFqJU6g==
X-Received: by 2002:a05:6830:2541:b0:7c9:5e2e:2984 with SMTP id
 46e09a7af769-7c95e2e2d02mr2411314a34.7.1764889829240; 
 Thu, 04 Dec 2025 15:10:29 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251202212033.2692954-1-trini@konsulko.com>
References: <20251202212033.2692954-1-trini@konsulko.com>
Subject: Re: [PATCHv3] boot/image-fit.c: Use aligned_alloc(...) not
 memalign(...)
Message-Id: <176488982841.2091996.1763416574097809110.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 02 Dec 2025 15:20:33 -0600, Tom Rini wrote:

> With the changes in commit 8fbcc0e0e839 ("boot: Assure FDT is always at
> 8-byte aligned address") to call memalign(...) we now always call
> memalign(...) rather than malloc(...) when allocating a buffer that may
> contain a device tree. However, memalign(...) is not portable among all
> of the host OSes we support. The C11 standard does require that
> aligned_alloc(...) exist and it takes the same parameters as
> memalign(...) does. Change this file to call aligned_alloc rather than
> memalign, and for the non-USE_HOSTCC case define that function back to
> memalign.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] boot/image-fit.c: Use aligned_alloc(...) not memalign(...)
      commit: abd6e0f252ee17b18e98be69d87aaca6a26e8336
-- 
Tom


