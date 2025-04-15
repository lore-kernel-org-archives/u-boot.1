Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34A4C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 17:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3FAB82102;
	Tue, 15 Apr 2025 19:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JtmjIDyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4281D826AD; Tue, 15 Apr 2025 19:13:45 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F5908209C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 19:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-54996d30bfbso5222657e87.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744737222; x=1745342022; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifcCVUFprZgLD4ltacJKFr291Z0zKXLCcWJZmO/2MDY=;
 b=JtmjIDyFIT/W3iJWJArH3CsEbC7DIWbsukr/y6YJvOKczp67yOUNlA9wcQwyK89Z97
 53EoKgdgMiq4/hEic93IpSUIxPnqxzq+BgBRBvpWEkblUvrUnkZU6JFBe6N0zi8lFtkT
 mDw5/Dzf6WrDkW0CcnYAO+9wO/Ie5+67RW8LY/dSNpaU6vuQLwpSHBo28DFmGuPbzAAq
 IFPoF436+7YIrPIh4mD6DInvUIErVr5bHhl3tymmQA3Uks33U6HmbYusVIbZ7/3EwWlj
 3B3DQHEtXRVaJpohsUxu8SWnQbPugpZtJ7v2sSEegpt6+b/NGpzY77qf6T2cj4a9To7L
 JbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744737222; x=1745342022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifcCVUFprZgLD4ltacJKFr291Z0zKXLCcWJZmO/2MDY=;
 b=R9XZb/0eA1J/UMhXix3M1wDdoqhfFjY3vol8pyj1g+v4MBVwrTipKFuOWy8I/jZmF/
 Duc3+kwy+qiNG2pNriFfWAfl/QxW/8WYwLpteg6ZGu34kfrJiFmispM/xErbW3hu6ICl
 eU7x8xhLdSwfH4c3Z/lJ5A4wqwai5bv453DrcAphJAWzsv0dY6DBC/Y3l9BhTn9jUGDU
 lxdFs5dhJ0B/OSC1eI3sWPXqD5Gta/SkqHXGin21eVPjhizaUQdFZ8OO/spzlSMqA3qF
 JKlksg98D3Ho//gey7DSFIJlokTGASm9NhlM/GA6nwLVGdF1hSnRk81ReB+6YgpTCGRK
 0Nlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeAU7q/o9Dxqc+lRSy6v2gJQ+EzRyQcrgVta02aZzNyhf81+ghTPqXT618XYxomyYYQsXZKJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YyKc63drMl2Q/EyfYDl1ASqFonT14bZUztnEr698MH2siqI2tUt
 +p9o+qA27eLG7XCgTH9922/zwSQ6/YnJ8592twXjdd+YzudbBzNFYa6encqzYTlb2x/wnLGx/0s
 hzlzOOmjia5BXDkaND5bj7/HKhEM+mUm5
X-Gm-Gg: ASbGncsK+kvF4U7lePLdj0I4B4hFNhMMFRc6GmaQXWcKecrMZ62iqDGQSvvFiOyFRaA
 6IuzB/NZRVVlotOavnaa+2hjTZBLngletMqk7ow9tvECp6xchHmzZYU3mGIvnx+EY+TwhTxZwtr
 c+sA8yObaSb6NB20RnGA9BR21gK/TqRYqVD7Pbdno8wOijiwBTr//ZKA==
X-Google-Smtp-Source: AGHT+IE0dpL9Fq9F13e3kAKtE1HnQpONAnHzzfN0p7c51dprk7CMW7k+yJEzl6nuHmS85okkf8xQIMhvoZRP6wnF9h8=
X-Received: by 2002:a05:6512:158c:b0:545:e19:ba1c with SMTP id
 2adb3069b0e04-54d452947e4mr4636135e87.19.1744737222041; Tue, 15 Apr 2025
 10:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
In-Reply-To: <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 15 Apr 2025 14:13:30 -0300
X-Gm-Features: ATxdqUH3S49XW7sOAjBZwdfD7E25eNEBD03umQZK_s6MyrhwFeSUrpxNLnbgxIg
Message-ID: <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Marek Vasut <marex@denx.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Adam Ford <aford173@gmail.com>, 
 Fabio Estevam <festevam@denx.de>, u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
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

On Tue, Apr 15, 2025 at 1:55=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> Do you have af9cdd1ccd2d ("Revert "arm64: dts: imx8mn: Include 32kHz
> oscillator clock in SPL DTs"") in place ? If so, try and revert it, does
> it help ?

It seems I have not pushed the "Revert "arm64: dts: imx8mn: Include 32kHz
oscillator clock in SPL DTs" fix. Sorry about that.

As Francesco is using imx8mp, then I guess we also need to do the same
for imx8mp:

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.d=
tsi
index 96a6df94c6cf..6cc910ee9835 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -68,11 +68,6 @@
        bootph-all;
 };

-&osc_32k {
-       bootph-pre-ram;
-       bootph-all;
-};
-
 #ifdef CONFIG_FSL_CAAM
 &sec_jr0 {
        bootph-pre-ram;
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.d=
tsi
index 6de9ab5d37cf..35af412f01b0 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -37,11 +37,6 @@
        /delete-property/ assigned-clock-rates;
 };

-&osc_32k {
-       bootph-pre-ram;
-       bootph-all;
-};
-
 &osc_24m {
        bootph-pre-ram;
        bootph-all;

Does this fix the boot problem?
