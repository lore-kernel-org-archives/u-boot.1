Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C9C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 05:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC2088E66;
	Mon, 16 Sep 2024 07:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="MOqFDF1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07CF88E6A; Mon, 16 Sep 2024 07:43:27 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E444D88DEB
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 07:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-49be2ef28aaso1158816137.3
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 22:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1726465404; x=1727070204; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=khdId8ItcBHh8JNyocjsTge4P8aFaFO6UQJWg72E4rg=;
 b=MOqFDF1h4fs/cnEU/m/fWd4FlGFNYe8apfKeIR9LyB4gwBrhb1ps77tVGuiw49GKEm
 upWeiyopmERho+JRGbX7pYzJHcir2y/zhGgCQ2Sd9F3K+9hBNDpT7UG3ax8wNh2GPeXw
 i/pjO1h0EMqhfUC8Z6cUKNX0k2Jx6DEYP5fqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726465404; x=1727070204;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khdId8ItcBHh8JNyocjsTge4P8aFaFO6UQJWg72E4rg=;
 b=pGx16NaKEIwsyUCWiivmPu4wR0mv+13Ew1ze7y8j5GKiS7BNpvFdBZx8hnEiVG+kUw
 uITO0ycrcaZEFPYBSI/kB5P4QKEgfn9P7Kj9RnS548BVHWFeeqdP1SMc1SDhzaYvjbga
 G87PXlBHPkRa3gOjxOVE2sBu/TkycWoWwbHcvMymDVzCunVpkffB/2DWGWlSu5wgNP1u
 0sDDgaoNXG3oXeXF+Bo2U85/7A8UgT/Yiz+55+hOUxn2Omq7+VgxucwXtkNKlKICWzO4
 4Adm57F5tlnQM5MLy8EOiKhdBClk7wQ1LT3oebsk6j2+SatbJq6UxcQo5ap41PO3Brgs
 Gdrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiTlJGK3nOEpNCvYdzhWJVUyXAg56HkJkVaRLGTkc6nQGQTDi+02Xts+3hH4tEOwdGQTVXa8g=@lists.denx.de
X-Gm-Message-State: AOJu0YzzkqEmaETpVG1zB36tmWDx5xE3OFld11YeD4ChZ0uJ/QU5XEwY
 FvVT6kUASjeyqSZT+IybWZYi/FM+rfjvwuIlAQnfcvXX2zpHY5iR3pWGrTUI3XegALTsY1ANr1/
 u3vTCsC4Rl9urW8lFu1pW8PCwjB1lm4UAq3Hc
X-Google-Smtp-Source: AGHT+IGBoOBekMTsEglJZNdeHbv2U0MYZ0Bl75QglTI18BfED8qOOJ/xx/bBbPy29Wm/seAGoogLZ4vQi3w369KL0fk=
X-Received: by 2002:a05:6102:3a0a:b0:49b:c414:8a98 with SMTP id
 ada2fe7eead31-49d4158028fmr9981905137.29.1726465403597; Sun, 15 Sep 2024
 22:43:23 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
 <20240911-brcmnand-fixes-v1-7-be112a20aaf1@linaro.org>
In-Reply-To: <20240911-brcmnand-fixes-v1-7-be112a20aaf1@linaro.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGk0aZcPU5All9ASVJP8xH8NxMfIgF7V+nKsrp4R8A=
Date: Sun, 15 Sep 2024 22:43:23 -0700
Message-ID: <b2b4064af0656af2986490d9996979e9@mail.gmail.com>
Subject: RE: [PATCH 7/7] mtd: rawnand: brcmnand: Add support for getting ecc
 setting from strap
To: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: David Regan <dregan@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000002059fc0622360d47"
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

--0000000000002059fc0622360d47
Content-Type: text/plain; charset="UTF-8"

Please also consider to update the  brcmnand_get_sector_size_1k code based
on
change in the linux driver so we can keep them consistent as much as
possible.

> -----Original Message-----
> From: Linus Walleij <linus.walleij@linaro.org>
> Sent: Wednesday, September 11, 2024 12:11 AM
> To: u-boot@lists.denx.de; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> <michael@amarulasolutions.com>; Anand Gore
> <anand.gore@broadcom.com>; William Zhang
> <william.zhang@broadcom.com>; Kursad Oney
> <kursad.oney@broadcom.com>; Philippe Reynes
> <philippe.reynes@softathome.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; David Regan
> <dregan@broadcom.com>; Miquel Raynal <miquel.raynal@bootlin.com>
> Subject: [PATCH 7/7] mtd: rawnand: brcmnand: Add support for getting ecc
> setting from strap
>
> From: William Zhang <william.zhang@broadcom.com>
>
> Backport from the upstream Linux kernel
> commit c2cf7e25eb2a3c915a420fb8ceed8912add7f36c
> "mtd: rawnand: brcmnand: Add support for getting ecc setting from strap"
>
> Note: the upstream kernel introduces a new
> bool brcmnand_get_sector_size_1k() function because the int
> version in U-Boot has been removed in Linux. I kept the old
> int-returning version that is already in U-Boot as we depend
> on that in other code.
>
> BCMBCA broadband SoC based board design does not specify ecc setting in
> dts but rather use the SoC NAND strap info to obtain the ecc strength
> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
> this purpose and update driver to support this option. However these two
> options can not be used at the same time.
>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Link: https://lore.kernel.org/linux-mtd/20240301173308.226004-1-
> william.zhang@broadcom.com
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 70
> ++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 55d5d27438a8..1ffd6cfff98f 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -980,6 +980,43 @@ static void brcmnand_set_sector_size_1k(struct
> brcmnand_host *host, int val)
>  	nand_writereg(ctrl, acc_control_offs, tmp);
>  }
>
> +static int brcmnand_get_spare_size(struct brcmnand_host *host)
> +{
> +	struct brcmnand_controller *ctrl = host->ctrl;
> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
> +
> BRCMNAND_CS_ACC_CONTROL);
> +	u32 acc = nand_readreg(ctrl, acc_control_offs);
> +
> +	return (acc & brcmnand_spare_area_mask(ctrl));
> +}
> +
> +static void brcmnand_get_ecc_settings(struct brcmnand_host *host,
> struct nand_chip *chip)
> +{
> +	struct brcmnand_controller *ctrl = host->ctrl;
> +	u16 acc_control_offs = brcmnand_cs_offset(ctrl, host->cs,
> +
> BRCMNAND_CS_ACC_CONTROL);
> +	bool sector_size_1k = brcmnand_get_sector_size_1k(host);
> +	int spare_area_size, ecc_level;
> +	u32 acc;
> +
> +	spare_area_size = brcmnand_get_spare_size(host);
> +	acc = nand_readreg(ctrl, acc_control_offs);
> +	ecc_level = (acc & brcmnand_ecc_level_mask(ctrl)) >> ctrl-
> >ecc_level_shift;
> +	if (sector_size_1k)
> +		chip->ecc.strength = ecc_level * 2;
> +	else if (spare_area_size == 16 && ecc_level == 15)
> +		chip->ecc.strength = 1; /* hamming */
> +	else
> +		chip->ecc.strength = ecc_level;
> +
> +	if (chip->ecc.size == 0) {
> +		if (sector_size_1k)
> +			chip->ecc.size = 1024;
> +		else
> +			chip->ecc.size = 512;
> +	}
> +}
> +
>
> /**********************************************************
> *************
>   * CS_NAND_SELECT
>
> **********************************************************
> *************/
> @@ -2323,12 +2360,33 @@ static int brcmnand_setup_dev(struct
> brcmnand_host *host)
>  	struct nand_memory_organization *memorg =
> nanddev_get_memorg(nanddev);
>  	struct brcmnand_controller *ctrl = host->ctrl;
>  	struct brcmnand_cfg *cfg = &host->hwcfg;
> -	char msg[128];
>  	u32 offs, tmp, oob_sector;
> +	bool use_strap = false;
> +	char msg[128];
>  	int ret;
>
>  	memset(cfg, 0, sizeof(*cfg));
>
> +#ifndef __UBOOT__
> +	use_strap = of_property_read_bool(nand_get_flash_node(chip),
> +					  "brcm,nand-ecc-use-strap"):
> +#else
> +	ret = ofnode_read_bool(nand_get_flash_node(chip),
> +			       "brcm,nand-ecc-use-strap");
> +#endif /* __UBOOT__ */
> +	/*
> +	 * Either nand-ecc-xxx or brcm,nand-ecc-use-strap can be set. Error
> out
> +	 * if both exist.
> +	 */
> +	if (chip->ecc.strength && use_strap) {
> +		dev_err(ctrl->dev,
> +			"ECC strap and DT ECC configuration properties are
> mutually exclusive\n");
> +		return -EINVAL;
> +	}
> +
> +	if (use_strap)
> +		brcmnand_get_ecc_settings(host, chip);
> +
>  #ifndef __UBOOT__
>  	ret = of_property_read_u32(nand_get_flash_node(chip),
>  				   "brcm,nand-oob-sector-size",
> @@ -2338,10 +2396,14 @@ static int brcmnand_setup_dev(struct
> brcmnand_host *host)
>  			      "brcm,nand-oob-sector-size",
>  			      &oob_sector);
>  #endif /* __UBOOT__ */
> +
>  	if (ret) {
> -		/* Use detected size */
> -		cfg->spare_area_size = mtd->oobsize /
> -					(mtd->writesize >> FC_SHIFT);
> +		if (use_strap)
> +			cfg->spare_area_size =
> brcmnand_get_spare_size(host);
> +		else
> +			/* Use detected size */
> +			cfg->spare_area_size = mtd->oobsize /
> +						(mtd->writesize >> FC_SHIFT);
>  	} else {
>  		cfg->spare_area_size = oob_sector;
>  	}
>
> --
> 2.46.0

--0000000000002059fc0622360d47
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPkeDPraNDeysIQhJCAZDmYMEJdw
eX9czxFcUAvAwPXIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDkxNjA1NDMyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCWHaBqr28iospzsy1S3TKy8oXKg/G42FL6wm3JZtLYjwzk
EmqEyBjAJudh+JGIwDff6CHGFisCH08GmIgrWLxeJfcxf4l7EMkzkuqLIv8v1w7XvPpNc1G+aQ7Z
kThgGmmZ+GKgv/vjq7mq+PzT3bVfjw+iAEylJ9eiewS+VfSGoWo179tRqNGPx8OI5Tm45d0fLD/Y
9gmX4SIDSNjBv7XPkLPaqY0xGVoJZb32uD4huunFhNMDsfRsHuGTj97xlZuP3WPCj6kestvcOY7a
4C126pijFAujZNtjho2Iy4o+k3AYZX8V5VltmTlP5zBzZESxhjsYzRJACpYCEuMvYfg0
--0000000000002059fc0622360d47--
