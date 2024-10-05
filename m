Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E05CF8851
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 04:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DFF88D1A;
	Sat,  5 Oct 2024 06:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GT9p8RWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108E388D7D; Sat,  5 Oct 2024 06:59:55 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B352888902
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 06:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5366fd6fdf1so3851910e87.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728104392; x=1728709192; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGS6O/vT28hSHOYDqgzVyQr0w/CGqGKcySuZ3m+hsHU=;
 b=GT9p8RWO6j7N4H0wIcz9zwhGSmhT3Y8ZX1Ci/zO5+cjOTwe5EdLN1gWRHP3CO2TrEP
 RqtgADIW5G7qZgukf/kTN2fLRAG8WIWtLNJ1LpXddzcPdAFLeRCOTBTFvnhGWio1cvjV
 bYN4Fbvb7DXF+HBS7jPXnkhG9wRuSV6+bz+kC1P8bnYmFZFUvU3W1edjZ053nT/8b2N2
 vAfRdbdAyWHE3A6nYlqf40tU9TsyV7HmIXZM9AOsPX8dQA3y+Hm5toTEbxl+yZfUstlB
 Rm+ehTJvtqIesGgD+zFUILW9XKkYNmLSHq7isNRrL4E/79xINxbfhUPQ3Rcpg8nurR5c
 LdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728104392; x=1728709192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGS6O/vT28hSHOYDqgzVyQr0w/CGqGKcySuZ3m+hsHU=;
 b=hvdjmV8aN6JT7zEZwScA4/Y5038oDEsB0ylmEVGRtFmaOo/AemCN0SMmGz/HADUolt
 4OC9sPl9p3DwZrm2/scpPq/e2oe7j6AgmxNLdIWTFUckM5gRAAGK5jQzenZtworb2cD1
 QslS0ov4VRCBlwzT4bJh08mjV5BOP6ybBcWabL4cDkaK/hokCFnaqS3uJzy64CFDDKJw
 yM0Xov1VGZPyIgi7bHCUWZX1WJq4zb+rChfBoWmVIocljeOYNcMuN3EHK1L69T0eHxWC
 wu9mZEXiFAr/f6XgiwcY4jrHn9vGx2ljTH15rT/X20JtkMX1RyhB642chFXUb3zsl6zn
 d8qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/vwGQ59HGZlf7XlpPbIcRckc3gE1+u3F/Td+XZFqY9K0XkewGyPRmUi9tuqmvWy9Cp3dtv5M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4xF3jhGYwX925z4kwFJz6xR5n0cQOiGQJ9k9xy6Sr4sXLgWGr
 B34T6SFPWnY/CCMyDYwP4AeDoe3Zx/tKSv9vNcSyTlLZF1pst3Mu4aVoPJ49WGtXesA1GL96wr/
 ryziEyJz8K6hHBKu4YIMMIVjjyuw=
X-Google-Smtp-Source: AGHT+IGpqFWer2jDPpv9wdv0A3xmpQfrBfCw9HJ+43pEm0k/cCE72FcoMEoRlgsgArD6ROyTTc2oulroho6sa7z5omI=
X-Received: by 2002:ac2:4e0c:0:b0:530:aa3f:7889 with SMTP id
 2adb3069b0e04-539ab8c4e17mr3168192e87.56.1728104391664; Fri, 04 Oct 2024
 21:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <ZQ2PR01MB1307BD4AFB3EAB5254E979C8E6712@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQ2PR01MB1307BD4AFB3EAB5254E979C8E6712@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
From: E Shattow <lucent@gmail.com>
Date: Fri, 4 Oct 2024 21:59:40 -0700
Message-ID: <CANV2PTMT+NB9JPEAhN59LJSV1xoH_NmPdFQoL0mCHyU-SDHJ9g@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] Support OF_UPSTREAM for StarFive JH7110
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 H Bell <dmoo_dv@protonmail.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>
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

Hi,

On Thu, Oct 3, 2024 at 10:23=E2=80=AFAM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> > On 01.10.24 01:56, Heinrich Schuchardt wrote:
> > Another approach would be to build all device-trees into U-Boot and use=
 the
> > EEPROM information to select the correct one at runtime.
> >
> > This approach is selected by Wandboard defconfig and other boards by
> > specifying CONFIG_MULTI_DTB_FIT and CONFIG_OF_LIST. The choice of the
> > device-tree is made in board_fit_config_name_match().
> >
> > The advantage from the standpoint of a Linux distro would be that one d=
istro
> > image can be provided that will run on all JH7110 boards.
>
> That is a good idea. I will try to do this after my five-day vacation.
> By the way, I wanna know whether jh7110-milkv-mars-cm.dts and
> jh7110-milkv-mars-cm-lite.dts are in the process of upstreaming?
> I don't see them in the kernel mainline.
>
> Thanks for your suggestions.
>
> Best regards,
> Hal

There is not any jh7110-milkv-mars-cm.dts and
jh7110-milkv-mars-cmlite.dts patch for Linux kernel upstream yet.

Now may be a good time to do so, since Star64 was accepted and makes
use of the common jh7110 dtsi that was introduced with devicetree of
Milk-V Mars to Linux kernel. First this can go in U-Boot as the
jh7110-milkv-mars.dts is good for Milk-V Mars CM and CM Lite, with
addition of some GPIO assignments. This can be stubbed out by
including jh7110-milkv-mars.dts until there are accepted upstream
devicetree files for Mars CM and CM Lite. There are different GPIO
assignments depending if it is U-Boot phase or Linux phase of the boot
process; per the vendor sources. It is enough to pass a loaded
jh7110-milkv-mars.dts to Linux on Mars CM and CM Lite hardware, if
this GPIO assignment was done at U-Boot time and since then there is
never any MMC reset while in Linux kernel:

https://github.com/milkv-mars/mars-buildroot-sdk/commit/880a249518f72ecf1e2=
947dfeb2c66e5035fce90

https://github.com/milkv-mars/mars-buildroot-sdk/commit/042ea06598995db99dd=
bbbb252ee439c42b9c1a9

Much of the above diff listings can be ignored as already implemented
or not needed, however, provided for reference what I am talking about
for GPIO assignments 22 24 62 depending on the phase of boot process.

-E
