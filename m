Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073A6CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 18:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F91C83BCF;
	Tue, 11 Nov 2025 19:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CC4qh5MR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73EE383BEF; Tue, 11 Nov 2025 19:04:56 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E30983BAD
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 19:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c6da5e3353so37888a34.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762884294; x=1763489094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=irWvRe/60NK9VNnOo+V/X6qjqcs1kYW12XX50UsB8aM=;
 b=CC4qh5MRvMJqvKv9wcxeLR24C/j38dExUGquh84wuLQuVjh/RcMUyHlxVdxS9H8q8e
 qbjdas5wxZgTXFGRIbTcZaJ9Nvf3B27rlrgBPOX6JT/837ss1F7+4bHKG0EDfebIIW58
 UMK2rjc9Du+H6OmzAowG5v9fMh8RQynQpSiA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762884294; x=1763489094;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=irWvRe/60NK9VNnOo+V/X6qjqcs1kYW12XX50UsB8aM=;
 b=GAdaoUJvNPfcueVUR/gPkDW3ubhfTJPVqueYqG5DBduQ+OdZL0Ymz5RaNDvsQe/7vj
 HyLCCpdcYUuG42bV+1ZQUeW0ce3UNZyozKXVP+NrFvOLpk4jkEZXU9lycFZ1GDSKyabv
 6SpG2jelp/8mzPBVobdISF8wMCGOE/U6T7nDqs99i5tKz2W72KwzXG9i56GYRnNeUiO/
 ue8ggYPACBZ662VhCr2DKCEJDvBNorawlp690FdROFh4hqlnDvsCGOnC/fbY9QOjHlBO
 91hh0PivjRPeNbP9DobrohfKDS0pJC06LfNM50ngUoPlls/iHdhP3k0xm9ZoIstFfr81
 AoKg==
X-Gm-Message-State: AOJu0Yw3iNSyummSn6XoxYEV/7lKhwVsDCaF7qs4PPVWZakOs5CA986T
 UQwzDJLuC/HgPPmsvnvv9tL2ESwMvhlTsFyDwTwrDSD6g05dmYH9trCTIVwnDVj/8ZOOMR46y3Z
 8bDlo7klOsw==
X-Gm-Gg: ASbGnctXuPd/H41H1/8h14MSR930CKL17M5oaq8g1kJuqnfzbwHGN5+UZYzQFxgH5Z7
 q9c3ZLlUC6d4nJeKxhGj2FLSq/NEnFxYqjaUZbK6iDnV89l7NV1+LKAffeGikhRBq5OIfvCkqa9
 TBcusYgpuRjdZAES2SBC4L3MIrqyL2nXKPnIQ+IgQrt0ZiKaGy0/0jTMeyqTTct3sS8ZLqTG7VJ
 nDkxxkY/c9rICPaZzgS4UjIeDpkCne8aRpROliHSr37tLg063oHDy9g2RReup/UOPKz7Mk2pfi4
 3yyPHm51hP2bcqHO2i4WECv0xaVZ53cKNWrElrHgD4tcDNG4aNJeyBBxk1Cve5QTPVCzRhVSkdt
 /TMVSjpBvz8hOy8XmBqysC6Vo0bG5Ty1r0Fy4zpoBzaj7DdpOhuHEa3VPDIL5rjQaCYXK3pRyiV
 gJMuzK45U52MBNbZYtWAkAaqfQObQB9cuODMO/mw==
X-Google-Smtp-Source: AGHT+IE/Hxu03BLXNRQaJoHoZvFQpQPU872vHft1AOJF7spi7Xfr4QPO/i6X6o5tYLqZvZkrMSwcJw==
X-Received: by 2002:a05:6808:2512:b0:437:eaf3:4ec1 with SMTP id
 5614622812f47-4507443db69mr20516b6e.24.1762884293998; 
 Tue, 11 Nov 2025 10:04:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656dc45c3a8sm4537501eaf.1.2025.11.11.10.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 10:04:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251104215509.2371164-1-trini@konsulko.com>
References: <20251104215509.2371164-1-trini@konsulko.com>
Subject: Re: [u-boot-test-hooks][PATCH 1/2] labgrid: rpi: Rework the writer
 to be more robust
Message-Id: <176288429328.704109.1370869590271011066.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 12:04:53 -0600
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

On Tue, 04 Nov 2025 15:55:08 -0600, Tom Rini wrote:

> In order to always correctly write the correct file to the correct location, we
> need to first ensure that our newly generated config.txt file is readable to
> everyone, as it may be accessed by another user during transport. Second, as
> this is a file for the first partition, tell write-files this rather than
> assume it.
> 
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/2] labgrid: rpi: Rework the writer to be more robust
      commit: 009950585aba0d2f71d7ebe042383df50874b033
[2/2] labgrid: imx: Add a writer using write-image
      commit: 9aafb471284e2c45f69f1e8763a42bbb81a22c4b
-- 
Tom


