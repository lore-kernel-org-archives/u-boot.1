Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A768CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 20:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6806683B9D;
	Mon, 17 Nov 2025 21:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="18BwH97X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3016983B9D; Mon, 17 Nov 2025 21:00:10 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A7483B99
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 21:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so751344866b.2
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 12:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763409606; x=1764014406;
 darn=lists.denx.de; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aP7B8Poi5JsQonx3hZEaZfIvElw/D7tuNODzZf7I+ek=;
 b=18BwH97X+l/m5ljwp+h2f34NKnj0Fa9GxChBzvWc3mjC31HvMGIE0y4RfOYZFOFMZ/
 3Td/BDgdwVhW/P79rhwPXsFrHePpQbspVfmgExTewwwAsbhy7WKKSisdsotfSCMeyQfl
 sR9VCyjc6Zp0oeSVPqz0rDrj21yDdv3TstwXqOSjOljYVhI+9DIEk96yT9hKuu17QgFy
 bKiQg5yKy3bzksGmLO0gMK0XkfVOAe6M5WVpbx3t/4x3bfu8EG0TJMT/bGXX/MCavkjV
 uo+gmTScEY+17rWqsW/KN7PEOB8LqAEoMqH+tTOplZAwlbUuHD2SyGLs+Gl0V78wYIqE
 ECDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763409606; x=1764014406;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aP7B8Poi5JsQonx3hZEaZfIvElw/D7tuNODzZf7I+ek=;
 b=XaRSsvVyHRT5YnOKZ6ZkV3WIBCysdiZd1jUsddeABNexSr5GSVJ/81gC9rccA6oyIk
 qiVfpcUo6tMORvdU4/jcK/tozYnxAidZ2/Sain4MjsmmhEGHDD/D7SXMPCU77YkrZC78
 I7EeRsNI4AEEEmFym4Oo4ckAS5LQVFWI9ZUQGJXuR1JMwztTxjxgu4x7HhE5wTKPurL/
 BGZEHq/D8uGphfCAkVVCy62kDUNg0F4vRL3YGwMXCUPKO/HOhAN07JoHpFkiQycsLosH
 KbbUuLSmiw9RMVXG8a6uCZ+6TSg+9WcRndED1I/4CbPv6e92lJSAsjnNyuUp1G94fVoN
 +loA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXruKHogNYxVr4PAGGIT1MxWN/qtVKYABIh60NcrnsJxylyxu6P645XUmnmdopoJ68jpauyct0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg8D8E/567Um5DIcs26wPxwZTbsHecrp3yy15965sjlYzbPOiD
 2QtYJ7/m3smUKM7Jz/r35v8XNTnjXttJk03FDI7MOgdV6+KeEv7/u73+NpZsx/RDu9s=
X-Gm-Gg: ASbGncsrIGhU2GlkocDe2sge3P3jLxJNziV/aahloWjedp0nXL6rgiyJwx//eSe9/F7
 srNXkAstIvIZOru//YhsRu+nCHUaJ1Jg1hufvBeFDwECW6Zam6SYg8Pt5Ns+tjQBjW7YeXhB4GH
 lxxHt+W8Xlre3INzAcnsV6jwH/b+WA+lNyrosJCSG9Bjr7zdQ8RU41kep+YJ+k18Ivu04b8l5mf
 hAjsQHrhskhSPZd1yzfjeMrpB6phoRDa4JFTN6PmZhElYUrVcGJtdxp+a/nnn/FsXq3cGsZB6WJ
 kJ4cKKc3knH9SAO5wKTvIu4id0zcOlUsgL8WCDZBBoAwGL69sulPtdfVyPBxiubZbFi5Ojdl/bA
 b2RBQZspkIw0azfZ0rnmo+yp63m8JzZ/lJLwmVM5V3wzNdRWQV69IXyRayzvlxH9spgQXTA==
X-Google-Smtp-Source: AGHT+IEYSoZ8hgG+0xibDk1WPkcWqSZWjGWcCmBvoY4vj9R/+PDBQzeEECyvREiuUo4NXBxMc6LIxw==
X-Received: by 2002:a17:907:1c86:b0:b6d:5262:a615 with SMTP id
 a640c23a62f3a-b73679628b9mr1707981866b.41.1763409606552; 
 Mon, 17 Nov 2025 12:00:06 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fa80afbsm1135430666b.11.2025.11.17.12.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 12:00:05 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=33105d678f4ff4952e5fd017cb3782961143442afe6b34308f2085165f65;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 17 Nov 2025 20:59:54 +0100
Message-Id: <DEB8J4DXE9QT.1U8RYJB4CU0N8@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Maarten Brock" <Maarten.Brock@sttls.nl>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Cc: "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>, "U-Boot"
 <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH v2] board: ti: am335x: Do not call disabled PMIC functions
X-Mailer: aerc 0.21.0
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919001117.GA974973@bill-the-cat>
 <DB6PR05MB455171F726E8D6E540141BAE8311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919141058.GT124814@bill-the-cat>
 <DB6PR05MB4551C51511978A6DF29228188311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <DB6PR05MB45511C9367B93E1E788A543F8312A@DB6PR05MB4551.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR05MB45511C9367B93E1E788A543F8312A@DB6PR05MB4551.eurprd05.prod.outlook.com>
X-Mailman-Approved-At: Mon, 17 Nov 2025 21:51:15 +0100
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

--33105d678f4ff4952e5fd017cb3782961143442afe6b34308f2085165f65
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Sep 22, 2025 at 11:22 AM CEST, Maarten Brock wrote:
> When PMIC drivers are disabled their undefined functions cannot be called=
.

This patch breaks boot on at least am335x-evm if not more am335x boards.

>
> Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>
> ---
> Changes in v2:
> - use IS_ENABLED instead of CONFIG_IS_ENABLED
> ---
>  board/ti/am335x/board.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
> index 4ada8b534c1..712818ec235 100644
> --- a/board/ti/am335x/board.c
> +++ b/board/ti/am335x/board.c
> @@ -283,7 +283,7 @@ const struct dpll_params *get_dpll_ddr_params(void)
> =20
>  static u8 bone_not_connected_to_ac_power(void)
>  {
> -	if (board_is_bone()) {
> +	if (IS_ENABLED(CONFIG_PMIC_TPS65217) && board_is_bone()) {
>  		uchar pmic_status_reg;
>  		if (tps65217_reg_read(TPS65217_STATUS,
>  				      &pmic_status_reg))
> @@ -332,6 +332,9 @@ static void scale_vcores_bone(int freq)
>  {
>  	int usb_cur_lim, mpu_vdd;
> =20
> +	if (!IS_ENABLED(CONFIG_PMIC_TPS65217))
> +		return;
> +
>  	/*
>  	 * Only perform PMIC configurations if board rev > A1
>  	 * on Beaglebone White
> @@ -426,6 +429,9 @@ void scale_vcores_generic(int freq)
>  {
>  	int sil_rev, mpu_vdd;
> =20
> +	if (!IS_ENABLED(CONFIG_DM_PMIC_TPS65910))
> +		return;
> +

If I understand this function correctly, the functions used for tps65910
in scale_vcores_generic are not depending on CONFIG_DM_PMIC_TPS65910,
but on CONFIG_SPL_POWER_TPS65910:

  obj-$(CONFIG_DM_PMIC_TPS65910) +=3D pmic_tps65910_dm.o
  obj-$(CONFIG_SPL_POWER_TPS65910) +=3D pmic_tps65910.o

I am currently not able to test the TPS65217 parts of this patch.

I will probably send a fix for am335x-evm tomorrow.

Best
Markus

--33105d678f4ff4952e5fd017cb3782961143442afe6b34308f2085165f65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaRt+vBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOI
+AD9GhZPzZk6Pe7hToj4NO5kmyfQy/dX3RirgJ4ylLawo3sA/RRAWrdEFd3rSPBR
aNvTdbxgbAhlUqE1Z9UcXyz3aqIG
=uwlX
-----END PGP SIGNATURE-----

--33105d678f4ff4952e5fd017cb3782961143442afe6b34308f2085165f65--
