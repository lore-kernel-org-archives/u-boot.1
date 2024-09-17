Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D8EC3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 00:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6347888C7B;
	Tue, 17 Sep 2024 02:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="KXdpszkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7BE88CBB; Tue, 17 Sep 2024 02:31:10 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E9888B0A
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 02:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5011af337d4so791608e0c.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1726533066; x=1727137866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IJ268ielcEh2JR00Mdk9kOiPOYM1T94p5rIDN6GEQsE=;
 b=KXdpszkcYt4wh9myoWp8vWtKU5nGfexRRWv6HoKY0b8bVt/QcpQppRk2HHYZKE+7WJ
 +nfeWF0J+GkzwgywXdRH2+LreozkJ6EK4ctKrVr6xHDhLTC4ygn36hUAuJnpDdgZaSu0
 KIni0HlTRhv+E+CfFjHB2x0IQv7oZNjwFRaVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726533066; x=1727137866;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJ268ielcEh2JR00Mdk9kOiPOYM1T94p5rIDN6GEQsE=;
 b=YHzfhnEAzCdGKayr/y1S6J1eHPbV4NM7Jkraf+Gde/LmTCTamrVc6T4E673u+E8/6e
 hYN0TDhyT1n/7r27EeQPJz0gXIgydEZwauJu97rBkboRKcsf5gV4pZiwmk9oQicwnQbQ
 96GiiM4Jszakf0ts7ppZDOigrlCJlzcCROqIuR82ecib8JzRkfCz7qgWVSoJq+/PFa/Z
 jJaUOhKHMCS17ztz0iREfwOfaI65trmOeELzayj7GM3p6aClLS9h6tDLjuFKAlCEeZfq
 oHx645QYFcRwZLneEPUydnwXTxUvdAqz7uEjM8OvsfJUJr6e+Ku41D64S8jjoPnTHIWs
 2m9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/hRn2BjJI1k8yuOCjkBQJ/LbIlnxLpZl2pi28XzZ1H9UKLgaFj5jdC+QE+yXgCHG5L+4J//k=@lists.denx.de
X-Gm-Message-State: AOJu0YxvHo7bmEHYcVXRSWbhkodDGUfWIpdEIyHnKyfCQjwdtLG54HVH
 M3HXVhw0m5XcA486vZkI/a2VbnV/bzLNV3L66FDkBIt824jC/OCGlBrKXa6p27vUEQYAoO9GdYS
 rlVDesvZp8j/rVcsnqstCn6hyE5MxLOfwc1jN
X-Google-Smtp-Source: AGHT+IG52kQpLyb3H9kTd4o7AJDpK3gE+sqCzWx3PAYRUIxiWZ5nazAjTWhS25ME1atQxj413JWPZZk7h1Pe82th7XU=
X-Received: by 2002:a05:6122:2a4f:b0:502:873f:13c2 with SMTP id
 71dfb90a1353d-5032d73c3a9mr10308463e0c.13.1726533065703; Mon, 16 Sep 2024
 17:31:05 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
 <20240916-brcmnand-fixes-v2-7-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-7-08632f64c8ec@linaro.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQES+R/HTbMR/ti/GhYZxlIU8W7clgHTwgyks9yhB6A=
Date: Mon, 16 Sep 2024 17:31:04 -0700
Message-ID: <93de047a13ec9ca18ca3ceea1f25ab2f@mail.gmail.com>
Subject: RE: [PATCH v2 7/7] mtd: rawnand: brcmnand: Add support for getting
 ecc setting from strap
To: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: David Regan <dregan@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000018ed97062245ce33"
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

--00000000000018ed97062245ce33
Content-Type: text/plain; charset="UTF-8"

> -----Original Message-----
> From: Linus Walleij <linus.walleij@linaro.org>
> Sent: Monday, September 16, 2024 2:59 AM
> To: u-boot@lists.denx.de; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> <michael@amarulasolutions.com>; Anand Gore
> <anand.gore@broadcom.com>; William Zhang
> <william.zhang@broadcom.com>; Kursad Oney
> <kursad.oney@broadcom.com>; Philippe Reynes
> <philippe.reynes@softathome.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; David Regan
> <dregan@broadcom.com>; Miquel Raynal <miquel.raynal@bootlin.com>
> Subject: [PATCH v2 7/7] mtd: rawnand: brcmnand: Add support for getting
> ecc setting from strap
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
> index 071b33951648..749553c9df90 100644
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
> +	use_strap = ofnode_read_bool(nand_get_flash_node(chip),
> +				     "brcm,nand-ecc-use-strap");
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

Reviewed-by: William Zhang <william.zhang@broadcom.com>
Tested-by: William Zhang <william.zhang@broadcom.com>

--00000000000018ed97062245ce33
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII6Hp6WakAifr7IjEaqybtSuqnsI
0nlCDxN35Q+Z4+N5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDkxNzAwMzEwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQC3UgWBTDpA7gLFOdPxiyPu/6MaIc3cfyc2fmONUa2LhKhX
TTV8GhVLDskUkJm2APapNoDfGalOOb5XCpKvXmjoLiyyzNLurADAeDKF2jrsXXIphP5QWHtAyWua
zn9RsgM4RmUhXDGZc5blT8iSYLLudaE8uFagCXlb/9RZP3ZgthREtdSDenzb7Zp5D1bw9uWMK8dy
nD7qLpoTxsUPest/FRdYWYIwyr0MkvHJhhy4SvTI0jhpHrWGQweD7cH5xi0/KYFhCzII6DmkiMXi
/+T9Qzd2nTaK/v4IdX3Ab9B5G+g+NGsckFJV7rSwL6E7X1sYgu/BE8joTL+n47vQDCq1
--00000000000018ed97062245ce33--
