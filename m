Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF59E8537F
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 16:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CF8A83DC9;
	Fri,  3 Apr 2026 18:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W6CpU+L3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9FF840BE; Fri,  3 Apr 2026 18:09:34 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF47483CF5
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d743cd9e5bso1333531a34.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 09:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775232570; x=1775837370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Lv4NoGCFLk88KZRmetMBr3M1oKDlDJ1Fe/T+0fOjmg=;
 b=W6CpU+L3+UnyBu3TgLULdsRwW81ywGBkLyoi93xmCAfq2Za1r8vGgWJXuBtKm9Ip0E
 +WqZEUV6JtuwgQxOID89AF6ALlyenOKt+9Ju9JMTPwX+ZRoJOJFHZPlP8UL81IZudmIi
 PpCeX1b76V8Elk9O7X/f2w7vxSKvuFALzUny8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775232570; x=1775837370;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Lv4NoGCFLk88KZRmetMBr3M1oKDlDJ1Fe/T+0fOjmg=;
 b=SO1ab1c9GcO0v6kB/E9gR4xSmsLsaehe4c8E0etIV7TLoVfolE5sN+++zrpc5tBRO0
 aIJh56fKt67C98fa3lbm7HpL7bBt+SxSIqkou/8E13zFipfUUI1gw9FtfIqBqXM/2pSI
 +POrlNb6UgskNiBlrziu89BIvbMJ+n610OhJrc5PxTEgPMtlNkVR80SU3S/l77123PwH
 7Jm/Z9/yVAIJgcvG4bhOxEnZM+HOBAYrCjQV+6/ww52aSivKgI1wUHkMAreQ2GLWzXGQ
 Qq0tyw0K1EZU9zkEI6lLovan79UGDKfQisoNuwEvMv1E8m6xVK5N/Ys0VjeMOBMZGPn6
 gFPQ==
X-Gm-Message-State: AOJu0Yxclbxdl6oOeTY84GcfbRMmyy/2Kl2KeNG5Rj2/hkz34U+Rqg2v
 05hN33++3F+qoWq5B+XvkCs1PQ25VInod50BXHamGLhQzbbGXZjdoejE1//acB1gAuAhg9IB4lx
 NanRRGaQ=
X-Gm-Gg: ATEYQzxGFk96zKQInVS5vuiUxTRD/TRQfgTCQWcQYnSPVUw/eK1lhBXr+F7xy69R689
 Sd7n2XOEjNIA/WSoUhxnL47Ay/rqe6NeeudP1PlguyHOjAYiPCmv7RFJdqcPr0uY+cr8Nbzs1JP
 VKxEwmglYU1+i/hvxLkK9oKdZYtwh9+2GNkM3UpWhFZtdfvDdFkQ4ovqpRkX09JjgvZ7vUMoLH+
 A3aVertE+MTapkG7UTTWkJ7wJPwWDq/ROyZJIJkcARAcJXdm1WOFzzrXMSmjWydZ6FQ8Ex0LO5i
 MowMZbkM0C0Hoy5mTVWbM/GVW/je5N2Zx08eqy3iCdxRPuUYYtXoYkMYAo2yq8SUHmPVVnFB9DU
 rUNZKtTF5FTIdDPrEUx3WPjZs7L4todq08Oktgb9PfTcVnN+GCQi+Fls0iXcCd7rLZQRj67G7aF
 MV7+W2L4qPR0Tdiia6Fl557kGWbnN89nhhH7o15AcajJgR6pw4SQGT8uKKW19w0kA63LCFg4NnQ
 bRTDr/wpXzgzxnL3HICFxQ09QMsVohyvKI12LpixwQ2ppQ=
X-Received: by 2002:a05:6820:a0c:b0:679:88aa:7531 with SMTP id
 006d021491bc7-68220c43581mr1463658eaf.62.1775232570336; 
 Fri, 03 Apr 2026 09:09:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-680a5400a5bsm4002167eaf.3.2026.04.03.09.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 09:09:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: Mario Six <mario.six@gdsys.cc>
In-Reply-To: <20260329-mpc83xx-align-v1-1-9935d9db5310@posteo.net>
References: <20260329-mpc83xx-align-v1-1-9935d9db5310@posteo.net>
Subject: Re: [PATCH] powerpc/mpc83xx: Move alignment padding into
 __u_boot_list section
Message-Id: <177523256941.2233070.11277887998642397559.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 10:09:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
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

On Sun, 29 Mar 2026 17:04:36 +0200, J. Neuschäfer wrote:

> u-boot-dtb.bin is built by concatenating u-boot-nodtb.bin and u-boot.dtb.
> u-boot-nodtb.bin, in turn, is generated by objcopy'ing the contents of
> u-boot (U-Boot in ELF format) into a raw file.
> 
> In order to find the bundled FDT (u-boot.dtb), the code in lib/fdtdec.c
> uses the _end symbol. Platform-specific linker scripts ensure that _end is
> 8-byte aligned, which is required by libfdt.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] powerpc/mpc83xx: Move alignment padding into __u_boot_list section
      commit: 74f5e3ef30dd2f219bb545b41a0600686f567032
-- 
Tom


