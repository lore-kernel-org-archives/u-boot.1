Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3014D5A6DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 06:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0C88933D;
	Tue, 26 Nov 2024 07:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RA0fDOlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB6458933D; Tue, 26 Nov 2024 07:32:55 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A32589BFC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ffbea0acc2so21628501fa.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732602773; x=1733207573; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E2ZNJ7fJhhfW0H7Nhq4MvoP13ZqBCQ8M5S+siMjHj0=;
 b=RA0fDOlUOUhbv+8+11EHGKm2Ufx1yCnLpA0vblB2ykrkoRvzyzu3DbXQdAvrfRWsF+
 sNqA/1RT7lxgLbkD/aXvOtOquZiMusil+o1C9W0luFnuPbbvg4E/ZqNjHhU4FKzQyCoA
 VKXHgx/dHYLEVsw2gCfXH3zjbKiDHdU/QRRJNC71ugxQXDNH1IGDsTF9pOdeeeVRAp3v
 ideOJSLPyEIACoAyWHSOXad4jcK3429AsgjabbtzMMaRJk6yrY43dSz2NXJ/bDAdN0tK
 BfOGj2sJbTrLtclvpZKpa1CxhyMJUksmITTULi6BGLLfffnMTcYJVFu1AWrbMC1pTlUU
 wgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732602773; x=1733207573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E2ZNJ7fJhhfW0H7Nhq4MvoP13ZqBCQ8M5S+siMjHj0=;
 b=WnRycJhMz9PqaoA6iYe5z4svIAYUhvm4G78k0grf9q5XxrLcolSNm/ZUJB2OwaOnRa
 yMzBMrNz3QCAMCWHJJ33LtFgtvbh086beAjvqN95sXYXBOgfPwPrflJc0cL++ZLMrUR4
 yqgWDnkvqKQS+950jtrCASjKE/FBsAFAmGBYnDsEy3R7uQhb3DIFYVGVnNSBVmF1kNK2
 0m5+qxqg5cc3WN2KWhGPwnwe+BtVYiRxQefElHOWkh2/ZyEctT3EzQ7WwibJ9nsfPa3H
 +XHir9xSIm8Psw0lJx5qOE0iyU8X/upkbPF8oFFMUeR4f2hyJZZipus+dxbS7lkam4JI
 QhoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOeEJlvbX7Np+pfREaQlv04T9Pe1IwW8ha/iW5k+88eM1wxT8Qjc8++jRplEGwd+JLExyZ5iM=@lists.denx.de
X-Gm-Message-State: AOJu0YylbEr6/G+MluJGT1XcfOYdix6JmjSIMGLUh/J7kXIHjWKT4lXj
 f7oG1r5XOHA2IKos54YYCi4JY2CuSjBU3VJ39+dTUgsm+tDyvmUBpPGaAPFoEmaUy2KMCL2cq8z
 mh+KSRts4H0Z2dvCVfhwXMcBmTvU=
X-Gm-Gg: ASbGncvJfz9p5Gj4CvHWjSYqvMgf07TVyBOvBVN4MQoc7uZyW8Qgn2zYawRBtt6Tw6M
 efkmZA6MA1u1CABB5efYa6hbY8cE6cLMv3Wr63VSrp5CWIPeZrqP45CT5RVDbsbp4Rg==
X-Google-Smtp-Source: AGHT+IHHdaq5rSKKXbT+tptY3k2ldSyjhE6peNATkKoh5rJzAs6qwzO+pureB5Ga7Yki5RhkSe3Db1bXd95GS8CREHM=
X-Received: by 2002:a05:651c:12c7:b0:2ff:5645:1265 with SMTP id
 38308e7fff4ca-2ffa7206d75mr64314491fa.41.1732602772529; Mon, 25 Nov 2024
 22:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
 <mvmjzcwobi0.fsf@suse.de>
 <e6eadaccaeef3b902d15dba7f634a7225318f1bb.camel@suse.com>
In-Reply-To: <e6eadaccaeef3b902d15dba7f634a7225318f1bb.camel@suse.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 25 Nov 2024 22:32:41 -0800
Message-ID: <CANV2PTNJScKtwS-u3FL6jeZM1xhXnF-+OWn8Z1q8ABRTiLg0Dw@mail.gmail.com>
Subject: Re: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
To: Loic Devulder <ldevulder@suse.com>
Cc: Andreas Schwab <schwab@suse.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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

On Fri, Nov 22, 2024 at 6:33=E2=80=AFAM Loic Devulder <ldevulder@suse.com> =
wrote:
>
> Hi guys!
>
> I played with latest openSUSE TW image [1] for VisionFive2 and I also had=
 an issue but not exactly
> the same Andreas had. Booting the OS from an sdcard gave me the grub cli =
but not the menu. With
> Heinrich's patch I was able to boot on grub menu as fully boot the OS as =
well.
>
> Tested-by: Loic Devulder <ldevulder@suse.com>
>
> --
> Loic Devulder <ldevulder@suse.com>
> Senior QA Engineer | SUSE Software Solutions
>
> [1] -
> https://download.opensuse.org/ports/riscv/tumbleweed/images/openSUSE-Tumb=
leweed-RISC-V-JeOS-starfivevisionfive2.riscv64-2024.11.10-Build1.19.raw.xz
>
> On Thu, 2024-11-21 at 16:24 +0100, Andreas Schwab wrote:
> > On Nov 21 2024, Heinrich Schuchardt wrote:
> >
> > > Our MMC driver for JH7110 boards only supports reading to the low 4 G=
iB of
> > > memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_BU=
FFER.
> >
> > That doesn't change the situation with the booting problem I have.
> >

What was this series supposed to do and how to test for it properly?
I did not see any difference, still just failure on 4GB and 8GB DRAM
... is my testing method wrong?

-E
