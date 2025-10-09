Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BF0CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 19:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2995C8423A;
	Thu,  9 Oct 2025 21:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WRq7xrbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19CC8423D; Thu,  9 Oct 2025 21:36:48 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59AE83C94
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 21:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-36a6a39752bso12867031fa.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038606; x=1760643406; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5OZO9zx5c5D4AJhERenEW9ZetaxubxbChIJIhSsMIQ=;
 b=WRq7xrbSZVw234PsCQM5xggSKs9QDZe9TGAhVxd9FXKx0OultCd2Wkv5JYJyl51AFk
 bo0IjEFL3NeMqu9AgFDo8zpU3Zgqzvd+TO5Z8p8APo8eu40W+wSY49XcODyfF3qWIMBv
 9Ruwj4oegiC6/ykJSzRN+fI4r8OLSd8kj5YxAgB54FGPH51pnvxCR9rJCMQ48an3hHPp
 1VzwI8cRGzDUuusI5M9pi/H9Fyg1WcFpvKPmdiuHxHsyEswXVssYZtc37LiXYl7STz1j
 06Yv9yGCesX4IMAWVE2XCF5HdFS1ZmjdNKTU92MTk1sG20dMp1lDIQrMB6R6XuSJ08XK
 jBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038606; x=1760643406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5OZO9zx5c5D4AJhERenEW9ZetaxubxbChIJIhSsMIQ=;
 b=SrpH0t9UZbaYwL8eK5soir5N6dMKOjL20ea2wtubrKi2UAtBURHVBLHnw2n1Gn2q2f
 q7fg/Lg8uxIdjZFRfnSXrlPvmQ5gxZmlidc8p3Jg46MMNUXVksw+vxguN6wWdjabyT3B
 ARtOt9bm2+5ySVvdUBcFIJlq5Ct1I9MVNJnT6S5LfUc0AG0PtdNPQHOrSIGL+LI8zs2A
 FRPFfxSR7yduMIjMQ1OMIWExTjYi54Qu3Pw0BG0XpdgZvjpZooXFMWRCp6ISj3X39PXN
 RiIeO3xwhbhEnDGeT3eDWPwRwrwfxYfiZnbRk0WzSnsoN7FKH+iDKikkSGBrzKB9woo+
 RWCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs/brbVqXLq0aW7shNuO7ArE1D+yfmplEVh98G0Ok2XKNGHDhzOhIGedrBiVeJ+x3aie1AjPo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz76XDBkMl5S+ePPZ4f1+/pKwdaqxdpugNvsexhOuZ/uDfVirSe
 S66mXDVJCc4OytnUSGki1JkDmxyLWTSID7+nHb2MnAWNvLtmr8mYUdsZhvzcrV/cGEuHe5qJu+Z
 cvIvVtLZY7TobDaQGAmYR5lYt8Sj/xPY=
X-Gm-Gg: ASbGncv0Kri2vaG1WEO/FfqcB6k46W74663lMOAKNlAAgrGbmpCJF7JX0Y4k4ZiVfKk
 67+yrE15y+SA/I2cakKs7KA59bpFwuRkIv4HCHnAlCT3niDDitq8gUibIoxP6nk0gKF5aYyhzdL
 ecm4Y4WhyGOPCNnrBEXhRzLsqyDOIcHOcgvNiZvP9U6jVXpHm2dncpO5o8g3fopXw2URCX9xZw+
 16qn1UD31OFMrrR96QlgE1+VuxhhAPyYLRXwIBRe/X3f0xzyK9oGDzj4Y9+V+M=
X-Google-Smtp-Source: AGHT+IF/ZpJAvkswYFeNoX3T7f31CugMd7y8o0udBpNo6Ow2Nk5PVW6pwbiIsoYIP4zkz2VEmcE4FH9e1GxNLDChvRU=
X-Received: by 2002:a05:651c:3608:b0:364:f7e2:3908 with SMTP id
 38308e7fff4ca-37609e0fbbcmr23966781fa.26.1760038605417; Thu, 09 Oct 2025
 12:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251002-wip-config-imx8m-bootmeth-rauc-v1-1-e54d43a6fd70@phytec.de>
In-Reply-To: <20251002-wip-config-imx8m-bootmeth-rauc-v1-1-e54d43a6fd70@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 16:36:30 -0300
X-Gm-Features: AS18NWDb23vyxetSUahDs7OJVuOHdqVdCLTP5AZ-WSa6terLfg30-CGSeG_qoZc
Message-ID: <CAOMZO5ARMyp7HEOq1Qk6x-G5+NqoYArByEhQfPJeA8ZVmgsU=w@mail.gmail.com>
Subject: Re: [PATCH] board: phytec: phycore_imx8mp: Add rauc to bootmeths
To: Martin Schwan <m.schwan@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, u-boot@lists.denx.de, upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 2, 2025 at 8:21=E2=80=AFAM Martin Schwan <m.schwan@phytec.de> w=
rote:
>
> Add rauc to bootmeths variable if BOOTMETH_RAUC is enabled. This is
> setting a proper default for RAUC enabled systems.
>
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>

Applied, thanks.
