Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EFCCCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 21:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41AB083849;
	Thu, 30 Oct 2025 22:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f8NtHUzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C135483893; Thu, 30 Oct 2025 22:31:40 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692DA836F0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 22:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c53038fd99so491024a34.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761859897; x=1762464697; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q14gsOfkbiPbv2NsS4PAEKzLQqa2jYMsvRfEJ46wFx8=;
 b=f8NtHUzSF8z7lDShUygPVgK3447OzezMTIRnhg59QogEzcw/vRTmqJSMMchU3C0Vi+
 kTAZ5u8PjV4ngljz/HqI/v++z2wmWnDQH1skSuXwxEEdGCPbTnSEhlqQovs36EGM3Y+m
 u/NaGqRrCmExrMsylIAEL6ns3fonhwrbI2sYcReumHYi5suBKdSOtEmHR2LOGuJ61OWC
 IsxCAeCGwqH1YqchQUWDYeDkMVCDiU2iBJLX9CzYZTl2Nml3RsvAXLkFYOXUfhPAdzZA
 vW+VgMMXf+kesB8RPndGn/xNGgnvDQgaN+ZQrYhsDWKiJ5I2c3DDrjAYf/qQaHMJ0SIc
 d+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761859897; x=1762464697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q14gsOfkbiPbv2NsS4PAEKzLQqa2jYMsvRfEJ46wFx8=;
 b=gFUDA9eK/RGwPyTcgtZfq6ekFJ52HG0lW5YvYU8QIzfBmJYCs3BcN1VtGasFrxAyP1
 NKjkV112roXC7WsKccLZTWe2AHMBIoylXXFDLumuQpFAtLK98r1e8TvUuxGHjt0jUGEo
 qdHUaVK1BjB7g41/BOEqF8CuLqbJL901J73oiKsOAD5fXau5WhBMCnhqsizIs08mwZfw
 lmXeX2AXJA4wQzYhBpvQUYtDiiabPqz5fyhS1fB5u/18bg/Psi+VmGTEfyPf8Mj98XIU
 dHTLExV2ozWT3/GI6UsuZ+PZ2OzhWKKVZm0ojamkleMyLdveeqMuewdMjDdlmsdXtG2d
 TuMg==
X-Gm-Message-State: AOJu0YwESo/fk7Vc45t0eiyzRWIvV0+HD6Wkjk0kCj9tDcbg7cT9SwkA
 PMp8BNjNXh4poMBMMy1YhFlrRh0S+k5VsFPz9di2NfMvf9fYFOcvx1371brPKbtLbhRkHGMttsP
 U9TIptLJLPhuJHT4DlTWheqVAw01LxS1i+ax0
X-Gm-Gg: ASbGncsebGfrXok5VmO24OJVew35oO96F7AzgmYEy22aT37aD+RgmnOhMbhIfNUFeHa
 SANPlpEMKUPb7jSBkJsZEJjC+odRkmL21fbpNLJZ+0rxrXI347xLy6lmn/VW9ZpXGGb3zfgU6AW
 QMiKCZCeE2m96MxXe9WsZXBDqcj+ZiyvLIUSihT28mP9oQXc6HShoJSgwsJ+92/fvaYtZxz+hYU
 lMiC648/gPV27ptUPiHO0s3Spl2pHfruW7KWyY/hSFkA4whe0ogktXX9C93t+auFnDDRqA=
X-Google-Smtp-Source: AGHT+IH5mLks409UhFgTkrrIfGdW7/IO+K05EI2KMaxQj7/rkffkROSh3a9SgT/HnBQov0sG85WSDkWt+mUbl8SDfsA=
X-Received: by 2002:a05:6830:67d5:b0:7ac:869b:3284 with SMTP id
 46e09a7af769-7c6967e1e5fmr528127a34.26.1761859897074; Thu, 30 Oct 2025
 14:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251030003359.1023-1-briansune@gmail.com>
 <20251030180940.GY6688@bill-the-cat>
 <CAN7C2SC+uJ2OX9WmU7AmUjTZ7O4rWwQY0ueYYvWcUH1GF=fgZw@mail.gmail.com>
In-Reply-To: <CAN7C2SC+uJ2OX9WmU7AmUjTZ7O4rWwQY0ueYYvWcUH1GF=fgZw@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 31 Oct 2025 05:31:25 +0800
X-Gm-Features: AWmQ_bm59fMSdNopzk0CSFmXT34owHWWSQsLRSudv-9XyuW_3qqQEdChxWNiDKU
Message-ID: <CAN7C2SDcEC+A5-rmCKMYD=vEYDFdOAfMp1G=T5SuQcXYOHDuJg@mail.gmail.com>
Subject: Re: [PATCH v1] Cyclone V Board handsoff script
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> No, this is a build script that is a must and also required on every
> clean build.

Let me elaborate a bit more.
According to the current U-Boot folder:
board/altera/cyclone5-socdk/qts
board/altera/arria5-socdk
board/altera/arria10-socdk

All these board folder files are not sure and high change to be stall.
As the deconfig boards are not only official Altera board.
As such [1] is a prerequisite to build U-Boot.

So unless there are handoff changes until the EOL of 2030.
These scripts are highly required on U-Boot, unless U-Boot
plan to remove Altera SoCFPGA from the ARM support list.

Brian

[1] https://www.rocketboards.org/foswiki/Documentation/BuildingBootloaderCycloneVAndArria10#Prerequisites
