Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF439D116EA
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 00:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75F783045;
	Sun, 30 Nov 2025 01:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+ISWPnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD3858307F; Sun, 30 Nov 2025 01:07:13 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE0683015
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 01:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5957c929a5eso4739120e87.1
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 16:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764461231; x=1765066031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHanrEPZZtFitdqCIlJg4NIj8MMSP9EoxtD/vR2JDNg=;
 b=e+ISWPnUj5yriYmvvwh6cT08D+LQNXxzD/CoG2sntLIfZu/V1W7tpSs9KPH0uETMSB
 X9ABvHAZPKaJVA6T6LSfnBJDG+jaY+0rPB+pc+e891rzyeH27pUkFWGIXSyJMhh+Vf/V
 vfk6mW/9wE/lbZbzwb/09SgzMXMFi9DCl//7OFRzLNyQ54siIhxJV6ZUlyMWYApXtQNG
 cdPADy8dqH1UNA8fIl8nKGT1YNU+XUEedYWDXj2mNFcMMciSyndtW9zyEWc2SjSR1jc9
 WZQX/DFVX0YbJo36kIUlC1vG1UGOrj56mRnj5EPg+B2gUOPxFUMuvGt6Fh517H7dLjeY
 jXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764461231; x=1765066031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vHanrEPZZtFitdqCIlJg4NIj8MMSP9EoxtD/vR2JDNg=;
 b=uogo3+5hqNKixnWesopqWPyQ4IGAihiWEMkeWbETFs9ZrFXw6pHGEazNoBqtrxm9fY
 7dw2uQ2di1af7LrgcnQqLKaXG/1xYYtrfwt9u0iQESpPuNnXUrsffpUteutl/VL9rTN9
 qg4E1yJPVWjWJ74lp9GnyhZ2yVOw7O4b7uBW3bUUUNlYrTFUG5jnDasLv+f7PDZyWqhO
 fwTBnIW516486JKSnqw2nlZdIEVV8uPsySvWVNcD8/YkzjdfSh3onawtmpw/pnYDB5uB
 bJ3LsryBXrlgqZVhpawAM570VA2L5C+t4Bmh6gCu4nvujt9eQxDCuN3I1sen9md4JYy4
 YEbA==
X-Gm-Message-State: AOJu0YyWGnnlouVhaHOqe2E8I6Ys+8HotaBR+hzHsHpF1NQcSuIpY0Av
 2kCEYMiZmTUctkKwUxPNf06PnBepFtSfl4UKSty5dU3WJqPV/YjdR2+ptAlP0WFDKjZ7ivvG/JR
 VU688gBhY7Kg9q36a+3RIv3t0Q8rrbVE=
X-Gm-Gg: ASbGnctaFRr+c59iaR5mPR+XGIsokI+vRgxDJBk0xRNo3BIw1iOv6BF2hirCjNR5s0m
 ha7KWnAALqre3uYtxOmEmCE8wntMyb//87RLCKhSmPvkOEl2vwicH34cCJNd0Wj2686bqTSJuQT
 tdjszT1JHkMwJBqaREpC5JM+bHoeaBubH1G3exHo2psuVgG8Wzq79J9BWtL8iEUydYypZ/I56R9
 h+wrYLQJSAOcXc+kw7r+BfWol4do216A/JRHdlgSuXnwBIblWHz2HdEAW3aehDFtX1ieHUwC9+z
 XXTIkbnfunzLWynA93xRny9kDgY=
X-Google-Smtp-Source: AGHT+IEDv5cnsrit1jaR1e0UM4TWpYxUQOXDAEmO/ocXxUm5B9O/RSQMfxhk1Az4/n467SlQF2v9zA4EiatYmVsiA5c=
X-Received: by 2002:a05:6512:3c8a:b0:595:8350:5812 with SMTP id
 2adb3069b0e04-596b5287ff7mr6766443e87.36.1764461230608; Sat, 29 Nov 2025
 16:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
 <20251128-usb2-v1-4-25ec5ac127ff@nxp.com>
In-Reply-To: <20251128-usb2-v1-4-25ec5ac127ff@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 21:06:59 -0300
X-Gm-Features: AWmQ_bl-0yfaK9IWFKTvJt8DALr6sxj4dC9JTB-91PzCW3hLcBVf_UbwQFmsI0A
Message-ID: <CAOMZO5DisnpWRxfzwp0F7VOMPBLb+nmYE5vdCHADCe5VbP3Ejw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] imx8ulp: dst: Enable USB controller at 0x29920000
 in host mode
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>,
 Alice Guo <alice.guo@nxp.com>
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

On Fri, Nov 28, 2025 at 10:18=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:

> diff --git a/arch/arm/dts/imx8ulp-evk.dts b/arch/arm/dts/imx8ulp-evk.dts
> index 7aec1706382..fb28748ec17 100644
> --- a/arch/arm/dts/imx8ulp-evk.dts
> +++ b/arch/arm/dts/imx8ulp-evk.dts
> @@ -44,6 +44,26 @@
>         status =3D "okay";
>  };
>
> +&usbotg2 {
> +       pinctrl-names =3D "default", "sleep";
> +       pinctrl-0 =3D <&pinctrl_otgid2>;
> +       pinctrl-1 =3D <&pinctrl_otgid2>;
> +       dr_mode =3D "otg";
> +       hnp-disable;
> +       srp-disable;
> +       adp-disable;
> +       over-current-active-low;
> +       status =3D "okay";
> +};
> +
> +&usbphy2 {
> +       status =3D "okay";
> +};
> +
> +&usbmisc2 {
> +       status =3D "okay";
> +};

These USB nodes are already present in
dts/upstream/src/arm64/freescale/imx8ulp.dtsi
dts/upstream/src/arm64/freescale/imx8ulp-evk.dts

Please send a patch to convert imx8ulp-evk to OF_UPSTREAM, then resend
this series.
