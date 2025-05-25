Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD89C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 19:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C33B82B37;
	Sun, 25 May 2025 21:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mEU8VaMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548AD82C79; Sun, 25 May 2025 21:49:33 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB28E82B33
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 21:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72fffa03ac6so856800a34.3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748202570; x=1748807370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XPHuQDe4VCi2K8fD1DVF5amfX5x3l6t0fjpkKlDhn4=;
 b=mEU8VaMKwDX+ia0XZ9dyq1iB2TMRtwlYwIrwyuDsOzWsz9IkC9f5CIKcVVBJdJvX3h
 v3df/dpHgIagtFDCUF1PAffTt4chD2kb+/bw5MjGv7bL52gIQchNhbWSYOb9FI4O7pew
 yx/zyTnKyqOKZDjTl7VE4adR5Bdcm76XBXAq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748202570; x=1748807370;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XPHuQDe4VCi2K8fD1DVF5amfX5x3l6t0fjpkKlDhn4=;
 b=A95Q9pjJ9fzLd89TMDoxegt3yGWXnhhrl6ff0beVuv0SOu/P+xf6bWp5U1CeI2/yoU
 hvqyABKnZ2ylnjwx+FEVuJ6YwCPKZbSzAFmX4MGT8xKzO9MfKgr9qYzOr5T+zGBL1ziP
 BPaO4Rmqjj0hz45J6Kg1l/fyH1kNShYa3tX3auIrMdtOUxfzbDDZQ+vK/bWyAU/nfH0O
 QJuFbZjqqyXDtO8ObAf7vlw5Vk4VncdqU3BpuePAxSutaUipkFHx6t+cEBdfO6/NKKGn
 Kzp/GuSgO/SGwDbaNOMiVYuILrpWnIlAE+csFbHy+0d2/wwNsWbVMzKKmk0VcKz9Tuda
 AIYA==
X-Gm-Message-State: AOJu0YwazyCNWHc+YKGMSrQ3C8uAN2ZgRR9YGzHrEU/V9OUpJamgXBIB
 DwxFIf/urbQlMM3MJaiohThUppKy5rOtCZ4lf1O0pBAQLsvwyv+35f32Umut/oh5yrQ=
X-Gm-Gg: ASbGncsB1FQUbq2tuZekNDIUf7n/RhdZwHWyJ/g7fvL7T1IixaH8a/f9V51rahgJnJb
 ArHQdrRtXMLJE+WNUpTChrtZLE6SL1ESSNvns7dztt/Zi7IY/4lk+kHjE1d0LphytKKz0Wz6zt1
 4Llon2Vr3NNQGdmb/zyOtl5xjFRfdmE8vMkDL/GM479CdmN8XT7vuJ55qYQPE2wGqY5kOAsexh9
 F/Bqwsw8edLwzOacVZtxuTlsPyeLye71yeImnmeJ3Q7ImH4K3cLG4YdOtSkWaOODGPCEt+bnybA
 AUHpBn3iNivB3JOPXDjJtqKSMrla5R2+oD2PsjKjmtKwPBbkA94gWgNRnvIjbk7dsHa7VuPPDZ3
 t7K52jWApET4=
X-Google-Smtp-Source: AGHT+IHHD/qG6oWpoAz/+N6HpAPGhf7AMViiC33BbDJKElSceUmfysG5OBYa/cbTjOcoVT6W/6gCmA==
X-Received: by 2002:a05:6830:698e:b0:734:fcd4:d1f9 with SMTP id
 46e09a7af769-7355d13ebd7mr4100164a34.23.1748202569755; 
 Sun, 25 May 2025 12:49:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a4b1d1sm3715577a34.10.2025.05.25.12.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 12:49:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <7c08e63f-3008-46dd-9a7c-bd1d4bb376b3@gmx.de>
References: <7c08e63f-3008-46dd-9a7c-bd1d4bb376b3@gmx.de>
Subject: Re: Pull request efi-2025-07-rc3-3
Message-Id: <174820256854.2599391.3141238678395207834.b4-ty@konsulko.com>
Date: Sun, 25 May 2025 13:49:28 -0600
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

On Sun, 25 May 2025 12:52:59 +0200, Heinrich Schuchardt wrote:

> The following changes since commit df2ed552f0b05591090369a7fe7ddc92439dea5c:
> 
>    ext4fs: Fix: Read outside partition error (2025-05-23 10:42:49 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-07-rc3-3
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


