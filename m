Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2BEC61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 14:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177DC82B27;
	Sat,  7 Jun 2025 16:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tjJUlaRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5E480E9A; Sat,  7 Jun 2025 16:09:18 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582AC82B27
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 16:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7303d9d5edeso800038a34.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749305355; x=1749910155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmMo34uBxZ9cF4y3Ah/8aDcBIFmARqAw+gsugB8hCaE=;
 b=tjJUlaROQOjKGGJQVxt0IP9PwN1kEbCuUr1bJrMmQH6oy7KsOP9byrs2MJZ36Hd6qn
 ZIGAkF68KCleEi1H+fX40bq66Kp5cNCP3AY1PNSS2XWPi/d9hfJ1qgpmuEIK6ogus6VZ
 51z3mIIzvBkzjxVTyUBo4n7XWVglCvCX68298=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749305355; x=1749910155;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmMo34uBxZ9cF4y3Ah/8aDcBIFmARqAw+gsugB8hCaE=;
 b=epjowlsaicUIDRiJ81Zsk9RqwEfJpIrh60YWCh7CzSUzHWPCpeBZMTY9XoQpejlYUg
 cgZ1DKMblFhun+j7DVoFeIoiFYQ08Jk1PnmnROT4+tt+4MV9wPY7YvIeP4OOlFSO693k
 LS4f1e0zwIpbhvu3FOxKyBmwVxA+Chn11eb0582OWStJS24Ldlcra1287CACwlNjOHOP
 Bq42ENLm9AHUSh80kKWfDccTw6r1Le/x6GKUUkksAqlQwgQ94/1t4phokqlIZRF6+aP+
 iKsTHONyYrVgfoxiKzESUiSyO+6tvxX8t5s9HHVLahUHh0/6bGmAW6w/qkzwlyEb57+J
 h90A==
X-Gm-Message-State: AOJu0Yzvxt2axE4EWlAodQpWCs+T1mmUcpRJnWssIFTpJpPX6Qf8qdQs
 hjvyRZtqZSNoLgz8s2jbTBJ5zFEm9JXMR3efL3NJSPAVRfL8IVeZWYslfuB9DmKswVw=
X-Gm-Gg: ASbGncuHwju3m4/88Ia1MMkzTYvJkisVHOPuL4wvymdmp3ZMK0nr3hh8Iv/8TVs1g7Y
 CdQP5u1j/S4BCtRIY5XZitt/gEwq6k6tG8om+wA9KTqy8UZ/StIfnFJZecYcfuI2KP0c1LOe4w4
 nOO5R6vBe+LxgR41h9pSeTvrhUgDt+Joz3rwZ0aBDMCwaZh38xHNhVCJQYkBQJwRTAjvu0H4RqY
 0TsFCrKj+GWt7rbGe8yYX9JUeXF0tBCkHV/7Uq4offXAnRHFzksP1gcAwpSvLRgiyLVecoHbsz+
 PpXOAQQxWDGDgVv1Jr+b2NYMw9OCeG8LVJl+8gVC5W656EzInJ4VoIMq5Tr5YEa3ASvlliiTa1x
 T5AwEA7IMDzA=
X-Google-Smtp-Source: AGHT+IGWu2qvxvtS99JYZDuywZTWBrAi+9TwO0VqAAaDx80TTvUtgrKDciiHUC9IiCTnyTm4F77Lzw==
X-Received: by 2002:a05:6871:42ca:b0:2e9:a15f:6c61 with SMTP id
 586e51a60fabf-2ea0145f7a3mr4083803fac.27.1749305355085; 
 Sat, 07 Jun 2025 07:09:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea073407b1sm954067fac.38.2025.06.07.07.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 07:09:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heiko Thiery <heiko.thiery@gmail.com>
In-Reply-To: <20250528233050.3820722-1-trini@konsulko.com>
References: <20250528233050.3820722-1-trini@konsulko.com>
Subject: Re: [PATCH 0/7] Remove as much arch/arm/dts/*.h as possible
Message-Id: <174930535370.3446816.7462611503837131582.b4-ty@konsulko.com>
Date: Sat, 07 Jun 2025 08:09:13 -0600
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

On Wed, 28 May 2025 17:27:03 -0600, Tom Rini wrote:

> Hey all,
> 
> Taking inspiration from Heiko's patch[1] this series goes and cleans up
> all of the arch/arm/dts/*.h files that can be easily removed. The big
> challenge I ran in to here was that for some platforms that aren't using
> OF_UPSTREAM were didn't have a sufficiently deep search path to find
> files there rather than arch/arm/dts. This also showed that only ARM had
> local header files to deal with.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] scripts/Makefile.lib: Rework upstream_dtsi_include to use find
      (no commit info)
[2/7] arch/arm/dts: Remove unused header
      commit: 96e8ce71e94edfcf780cd3170aeb5c68b045dcd7
[4/7] arch/arm/dts: Remove functionally identical headers
      commit: 96d95e6a5380798a55f5d0b4611c9c19743c4d20
[5/7] arch/arm/dts: Remove strict subset header
      commit: fefc9329ea7c95e1fcdf43aaf7025796ff47b90a
[6/7] atmel: Remove local arch/arm/dts/{sama5d2, sama7g5}-pinfunc.h
      commit: 872f69257abe7228da99a512e71483bc1029b7fa
[7/7] nxp: Remove local arch/arm/dts/imx8mm-pinfunc.h
      commit: e87b5ed9d9f64c8cef9d4c01d32b57b9a77a964d
-- 
Tom


