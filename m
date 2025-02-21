Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA284C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 03:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA348006D;
	Fri, 21 Feb 2025 04:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cWPFSXzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5F88007D; Fri, 21 Feb 2025 04:28:34 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163CB8007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 04:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso2542110a91.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740108510; x=1740713310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqOkkW/f2fs8B0EAlhf4U/uRbZryXP+cUVu3lggVE0Q=;
 b=cWPFSXzitNdHjrB3V9OITWbUnhZANAcqkpWJO+l7ZF+CCsUolmcU8P0LdR75lQ8cWI
 n+Ylz/zTm0McTv1r15fc7W/1eUchXM6jxPwIE0Nwf458jijssG9MD0rNGCHVIhkeKSeu
 hjsukGOu9Lsr7RolpkYYnBRNGeSotKzsjMq38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740108510; x=1740713310;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VqOkkW/f2fs8B0EAlhf4U/uRbZryXP+cUVu3lggVE0Q=;
 b=Uh88GsPqdBoEW1VeWw4PgF6u8cBtfOFXdO89zaE01P1PlzZrlHOOZZ9hfmhsL3OoYV
 C7sySGJTabt45sBM+8skCuzu2FXhxerFEl8fN7tFAHAZWszPwW28ubCUG9pO0g2gnfYu
 nklERANDXTZYDFJYKJUJUBcFxM2Ka5ZHw3k1a8imM4XlLEhTxEjuBRNZd7KpWzgyvyM5
 gKZ4Pxw+YESYGBt24EPNvLV4FVwhlPIKU57iZEE2ZgD7Wp1/DSawpoAgv0M4BPhBMt6Z
 Yv+NtOcRkMtTl1Zs/iYkSs1fCn/oLiNnW1HXOOpDx+F3kr3h5sErKD81x9HX+uG+EFj7
 9GxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj0FY8666kVoYr7A0S6DAJwa+8TiN+HPZ/bG3HmV3+tLxxhu7myDnJppO5nuaft0qHVYskTnk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx17PiONTESY7Sao12VbYKqibsGWxAQDx8LS2juuJNDouku8M1f
 QCMTmuHHVBadcYH5xKW+FF/h39I2bBDbz0PBtFTU8DHwLBdDFHRCKlXh2u5oQCbJ/GD0yMG1v/i
 5h2Q=
X-Gm-Gg: ASbGncuH0ry1LXNHJfaBRGyzOQq7Tk18Kv7z3bCtdrW/H9HWPtQjkI1QztBzezs3RJO
 msqeOoyRpnzxyuc8dofAiEHjU5aZNI2k203YF5sujydPOxqpxPN10TunnOQaz56fOeKKaH+RIYW
 PicZjlCW2lod04GbATjfJbbgAYu95bfW54Uef8GfR2FuNpb09jvZ6O7XQzdDz1nDSqMdWmE3Pw2
 vmUB4xTymoYG1sr1LHFse1qhLTn56a94rQ7wfMocl5Fllw1jeqIeC4mOTNMrfPmsyVSL6H69KFZ
 zK9vqUQLltX17g5hfN+T/D8=
X-Google-Smtp-Source: AGHT+IFj2BxJWf9SL04oFYBFKK/ms0JoefFpJRuA/P1yXAyAZFS1IBvyymPaM4ov9VT8H28dmDbM9Q==
X-Received: by 2002:a17:90b:4c8b:b0:2fc:a3b7:108a with SMTP id
 98e67ed59e1d1-2fce76a2756mr2880572a91.2.1740108510653; 
 Thu, 20 Feb 2025 19:28:30 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb06539csm197351a91.28.2025.02.20.19.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 19:28:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: upstream@lists.phytec.de
In-Reply-To: <20250210152548.1263498-1-d.schultz@phytec.de>
References: <20250210152548.1263498-1-d.schultz@phytec.de>
Subject: Re: [PATCH 1/4] configs: phycore_am64x_a53_defconfig: Enable
 ENV_IS_IN_SPI_FLASH
Message-Id: <174010850953.2983272.13556300050375907043.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 21:28:29 -0600
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

On Mon, 10 Feb 2025 07:25:45 -0800, Daniel Schultz wrote:

> Enable ENV_IS_IN_SPI_FLASH to read the environment from the SPI
> flash when booting from it. The oftree, kernel and ramdisk sizes
> are located in this environment and therefore required to boot
> an initramfs.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


