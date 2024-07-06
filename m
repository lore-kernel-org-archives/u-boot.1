Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8E5C2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8430883C3;
	Sat,  6 Jul 2024 22:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efJXaZQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 583A6884FB; Sat,  6 Jul 2024 22:49:36 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B6B0881AD
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52e9d61a4b4so300457e87.3
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298974; x=1720903774; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/FJ8sW0ThZPlDHfi9GuV0z2sS6WhpfekNcmH1SnAyk=;
 b=efJXaZQoylmJn4ubMYbz+nbnDIY/9VKB6D7mUaLHXYwjseU8Yaxwv8azkTsY82VOdq
 IMIfLcdUTkFHJ4sQiGvs7yg7XPUFq+2WvrpVwmeB4ZLyPhWA8DsGglZTimIAHt4QWOSH
 Z4kxnfi6AWfwnnUJa4fx5Y7KNHXItQZkvt10sppnK3s+BYDq0XVieMYvpVbZ89S1KChr
 fNWBxWhHDQgh+f2RHOPQtP0ARrSgIGS3K5hY8D54iBx7ltN41FfCBjcP4paRJYuOufc7
 tsQVtOhnVJFavYCrKqm9XjLdTDqagRPjO0dNXfs+LzuDkwKcjUS6Cxty5BwBYjyRtr6w
 XFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298974; x=1720903774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/FJ8sW0ThZPlDHfi9GuV0z2sS6WhpfekNcmH1SnAyk=;
 b=CN+2LBiG8smEN4EZCFIPNgAIW8YklnvyBT4+Gm7IrII4WEzQ5JIcBPz+Ln2Y7e0ibN
 9j7JpozLXp7l0tmcvA0uRETH+om0Ay38/YDUhCE4GxTal7J/9eugBVjKnTgDEdCLBy1h
 BBsK4D3ifphOqFbcQeRYqbEn03BHalSragGbJXjFQcaLYD5VpZT0xzXDtPDsVWw2XVG4
 XK+khz7YAlwR6oVJQPh4cdcjlMU9D3bTDFj5YXXCvPvuPB4eW9wMqPW3oKPm2dm0Kyen
 seHwyTY69e/vcr6scJHARRP0MB4pZ9J4Yfb8cs0HImN4xNXfPO1NQXX+R+Z7hPTJ2hKC
 p1xw==
X-Gm-Message-State: AOJu0Yy/fyWMkTLEVbUKE2hkLty8Yhd4Luv4P0UWJv71T2353zn2U2WM
 Kh5wEqFk9HRiO2Q21ePbI8dmxMoPw9y9ESj64s60D7oPyEjxVXMthyXtTsFNW6C8LCqi0viq4S0
 h20OG08MPNVL5nJbkXfcEqJouf9Y=
X-Google-Smtp-Source: AGHT+IF5gvV9wWwkLt/UF46oQZxtRyaEQViESjpTHjKm1V0SkE5WkLNmXcSHHZclTA/ACLvkM3T2k8fLcMJzMKGGbok=
X-Received: by 2002:a19:ee0b:0:b0:52e:7498:118a with SMTP id
 2adb3069b0e04-52ea072e954mr4276395e87.4.1720298973389; Sat, 06 Jul 2024
 13:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240627001403.279340-1-marex@denx.de>
In-Reply-To: <20240627001403.279340-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:49:22 -0300
Message-ID: <CAOMZO5A8pr83P64CYYU+YvCKjds6tRDD+QivrNZVNd2ozgczPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: imx: Enable PCA953x driver on DH i.MX8MP DHCOM
 PDK2
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Wed, Jun 26, 2024 at 9:14=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable PCA953x GPIO expander driver in DH i.MX8MP DHCOM PDK2 configuratio=
n.
> The PCA9539 GPIO expander is used on production DH i.MX8MP DHCOM SoM rev.=
200.
> This is already enabled in DH i.MX8MP DHCOM PDK3 configuration so align t=
he
> two configurations.
>
> Fixes: 9de599ec3d59 ("arm64: dts: imx8mp: Update i.MX8MP DHCOM SoM DT to =
production rev.200")
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied both, thanks.
