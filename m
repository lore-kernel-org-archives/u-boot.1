Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553BBCD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 21:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3420849A3;
	Thu,  4 Jun 2026 23:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bZvMG+6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5EBC84944; Thu,  4 Jun 2026 22:29:55 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D8183EF9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 22:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-39677234558so11330721fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 13:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780604993; cv=none;
 d=google.com; s=arc-20240605;
 b=Hr73bLttKIjWY/vH10IuIv4bgJHuagqcZJV7ecMKEmvt5nslXtzXQY88KM0fhJ0t7h
 +V21B4skOj9W8AGKrEoyLTQRioP/JbuxYva7IiZj4NL63shiexM/1DPvD+BDgD4igSYK
 ls47gvSkQNuitFN71ZL8eDJQ8TXxD7tMpCMwuF0HDYSiVjyQw7EtARDEBAWs4TS2wLwZ
 yL9mLaMBRZ2Y3F0Md9Md3jSqMgkX95e4Of8nAsr6UOsd4xEj2zfszLCiLf6+FGfo8v0r
 WVgrVwQPvHekIk3bPAlZmGkBnYlRTBUI2Nb6Z1vSh0ZmPsus0mQxjz/T3vYuufvs43qV
 WCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9hPwsg66SzqypCI+fT/9Mu070SvzFid7nVI4LTFWgaE=;
 fh=Alpg3sg3nkJCpPYw3uIv/2bxRJAQNhrU/XdwvKzR4s8=;
 b=F2oM0+/Xejf3ptz8Dv0Z+ov/SVT110uYMLQBfctX9QwV1cgLVFOw65UzwJW3ItjZ7/
 wMw5g8uxqcXl/rW9hoUaR4FanL5fgEBUlfjWVZPf0OjZLfapsxO3iuGRbSLu/ylV+Fvh
 /LkxLktgC766bcQwPrsK+NlXbfrZaLBnRHJ2xQC5AHp25/aRINDmxrayA3p0MvALab6C
 68omh0/FBVPmky3gsQ0f5tc++F7iIq/fX080WzIzLVPXkLB574x8rnHxZohxYE+kj20d
 srzU6J6mX2ASxDNEW14W3oqBQ5alkVQi8qJyUsJjBQZXTDFrpXp9afEmHTv7yyrgcXuA
 JdwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780604993; x=1781209793; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hPwsg66SzqypCI+fT/9Mu070SvzFid7nVI4LTFWgaE=;
 b=bZvMG+6pbOZCaKvsW4CWmaR+5tI4rtHoFd9g0kSHXa8fTWLoOvHqqdmfYVjgeVcXBq
 K3onrH0Q3BABesa0ekLewTsbbPE1+A4+lLUSGFm7a5+AfnA2pu9mbsIgwkZqxx3OTwe2
 vgesBkNnQLCQm0gSuZOPoZ2B7p26o16Bz/B+FQa97vNb4HAoUnUcXS5yL0e0tbxpKrTs
 LS/4+PBMkKLnFioJz8O1GAGYEJwOVFYEZGSoBQ6Y7JrKtu3UBhodGUTdKFbigP8a0wKd
 qssQO0zchmdQnOiXZ7sbJWEk4CHDXV29ZWgj6VbFOxKASu2RiIRZSS2qzWIHNsrRehB8
 f9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780604993; x=1781209793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9hPwsg66SzqypCI+fT/9Mu070SvzFid7nVI4LTFWgaE=;
 b=W0CDFnz1dsBF4oNxOcaxn24JDH0AUVpLQXJMSvGYOjXYTzNvws1PTDRX3uAgToh3NC
 eCo3YLH1p203khUr1Ujq01Mkofm8a8CPvusLqpgI0QiZorCOdIOJiJUntYfdA/4taXic
 YMa/523D6fhdeEQ1XiTveg2Vv7cryXQXcPD/yY/55ZGK+LiUwCzMo+qKEZBY+bxqBjpm
 ya4i4fXqfv6D3wvROIr2MZh76Q19PQNIEJa0jlf2QQKov7NCtZKW95Uk3OxN9mD/U0iI
 zIE3L+A4AoWtf3xklUGC+4snj3qxwIRLvbSlj8VR8w00W/ZgR4xBZ+KW30SzO00WFWYF
 a1aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/s/EFUfIdU3oVCSotSU1hH13w6GnZ5Z5RwjerAzj8LlzrsLx47oFffjjziLtEINdciHABRz7s=@lists.denx.de
X-Gm-Message-State: AOJu0YyBiK8baB6gCcSmD5+vqY2CGHk/A6aCUY7zRHLdjOwIfqMtBIZh
 YgDoF/r6wm2ZNx8WbVIO3MWJehtWLQOZrhZeH2Bn/OhK5sCCB7/B5p+1N/7CrdDW0SBMIrUK+I3
 pQpWXjZED5dLErRujzdMX4kFWinRIAig=
X-Gm-Gg: Acq92OHfR+RJg02FZhA1l74OdRJHzeKHEF+803+VWFLm3VZJwMWKkb8uKc04rd9kx4p
 n7HxJm0zmW3M7YV4q62MDBebDmpDWSKhHGvYNY77cUfRydhqfuNpA8WdIe9cg5eEkeeziYko1cz
 pwDRtZnHClbd+atp/nw5jsWiJDPScHUrUvMyboO7HLf1nOCpw0+CxnhEEVnT/rAE4uFez8AXU/7
 gTebxXvsuroHCmcaO1Ld9lNk5gqVpShGaXrXKeZYnRpwu+7fvq5IPHHWKFOCszjqJ179ffC0s2p
 uU4/x1Jv+d3YgjanSVGCSlvAwTHLT21hPz3Vc5MZiAMyW/5FrIOHhBdLySajX0/elH67LkvHMPN
 089mxGg==
X-Received: by 2002:a2e:a591:0:b0:396:800d:ffea with SMTP id
 38308e7fff4ca-396d094f212mr547841fa.23.1780604992680; Thu, 04 Jun 2026
 13:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
 <PAXPR04MB964406C7D2205192B8BC6747E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB964406C7D2205192B8BC6747E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jun 2026 17:29:41 -0300
X-Gm-Features: AVHnY4Iyg-EzwXG2sbdVDBEMh_6JiPvkpSJ0QyclhQwE2ECIDPgepcRi30pWpMc
Message-ID: <CAOMZO5ABns9AWUPFb9xSdnY6WpSJCqKeEy7Y0QqH9P1T_N2ESA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] imx: Switch watchdog addressing from macros to
 devicetree
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Joseph Guo <qijian.guo@nxp.com>,
 Francesco Valla <francesco@valla.it>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Ye Li <ye.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>,
 Paul Kocialkowski <contact@paulk.fr>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Brian Sune <briansune@gmail.com>, 
 =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, David Zang <davidzangcs@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 "Ross, Fedor" <fedor.ross@ifm.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Simona Toaca <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 04 Jun 2026 23:15:56 +0200
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

Hi Alice,

On Thu, Jun 4, 2026 at 2:49=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> Hi Fabio,
>
> May I kindly ask if this series can be considered for inclusion in the ne=
xt branch? Thanks!

I'm currently processing the u-boot-imx master changes. After that,
I'll process the material for next and will apply this series.
