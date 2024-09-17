Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014D0C3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 00:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4718588CC7;
	Tue, 17 Sep 2024 02:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="HwC6lguB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0CF88CC7; Tue, 17 Sep 2024 02:21:22 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFCE88B88
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 02:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-49bd27b3507so1579753137.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1726532479; x=1727137279; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qYVtQnecU/F5+DxSXn4/k4RZ2FVBNnENizopno9J3dI=;
 b=HwC6lguByK0u638bnjN+3KDHZ+k2lCOwZuNqcBEYYJVvJP7AVtQgnpsjKXXMPz5+K2
 8XwlArDZizvu0gmfOajpZy4fv/Rv6ue5BM6s3nkwDvu7vSHmF61uDaoOfBhWpHKLdu5f
 RfR1k9MUyE6qwmoKQOGsxsQNBF+1ldz6+99bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726532479; x=1727137279;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYVtQnecU/F5+DxSXn4/k4RZ2FVBNnENizopno9J3dI=;
 b=EbVuvnirC+0xf3nhD3k3sfYkFTvNYkwP1iWZxDbN+Bh80Q9FWEaMIDwbpGh+pgjYTk
 p4n7MI1xe43zesai57boxCQ+SlcT2xBRUWEcjTFj14s1HJ7GkFXpqy4baym6+Ew3dLfY
 aObyUgj0FOwPQFoYnAHKjhhHxu5RsIdH8D6e50KpwLH22W8/Off08VXmRMgELCVOpTO9
 kTsmvEjXCd4zWRouNtOLS6ldsrFtfG2IV1wxHfBYx3pwd7ZcARwa5IQPWq1nj8QyX3y2
 whb/nI9TlIr/YTyO2pilhJZTvqsTzbtELRkaamu/EGcIJdhv7olzd5iz/8iWqW71Y82z
 H9rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYT4bGZDiSR8EIis73l6eH+jfklLWaBKqXjOtjoeOQZbuzKsbGgQjDFlVkpw3990qxhXCAQrs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu9Mb7cveipFjDrpXJYO4zNbhT8OvhzrY5TlmIHrSZhdwUCDzw
 3p/nXhZMZGpxXTBkCF/it+o4eYmrvwQnt74srv1LFUkGG2JzDV0odSWRMfEvgZ2yJ3QqJAUbFui
 kMYIZztQY0fGp7KdS/+9HqfQO93jebnveGMy2
X-Google-Smtp-Source: AGHT+IFZmBp3Q0ziN19/tCj8YIXsUVpSayYTkclX5xvy5q7oLe90bwXZ3YJ5im7iQaYBQZsWv6uFbm7PDi7onv3nUjo=
X-Received: by 2002:a05:6102:418e:b0:48f:42c8:e0a9 with SMTP id
 ada2fe7eead31-49d4157f636mr11916410137.26.1726532478734; Mon, 16 Sep 2024
 17:21:18 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
 <20240916-brcmnand-fixes-v2-1-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-1-08632f64c8ec@linaro.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQES+R/HTbMR/ti/GhYZxlIU8W7clgLih3C+s9QoV/A=
Date: Mon, 16 Sep 2024 17:21:17 -0700
Message-ID: <09d4a91fa25bae6d22f31f66878d1545@mail.gmail.com>
Subject: RE: [PATCH v2 1/7] mtd: rawnand: brcmnand: Fix ECC level field
 setting for v7.2 controller
To: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000001cbf9f062245ab90"
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

--0000000000001cbf9f062245ab90
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
> Cc: Linus Walleij <linus.walleij@linaro.org>; Florian Fainelli
> <florian.fainelli@broadcom.com>; Miquel Raynal
> <miquel.raynal@bootlin.com>
> Subject: [PATCH v2 1/7] mtd: rawnand: brcmnand: Fix ECC level field
> setting for v7.2 controller
>
> From: William Zhang <william.zhang@broadcom.com>
>
> Backport from the Linux kernel
> commit 2ec2839a9062db8a592525a3fdabd42dcd9a3a9b
> "mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller"
>
> v7.2 controller has different ECC level field size and shift in the acc
> control register than its predecessor and successor controller. It needs
> to be set specifically.
>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-2-
> william.zhang@broadcom.com
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 74
> ++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index b1af3f717d43..700d1122639f 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -218,6 +218,7 @@ struct brcmnand_controller {
>  	const unsigned int	*page_sizes;
>  	unsigned int		page_size_shift;
>  	unsigned int		max_oob;
> +	u32			ecc_level_shift;
>  	u32			features;
>
>  	/* for low-power standby/resume only */
> @@ -544,6 +545,34 @@ enum {
>  	INTFC_CTLR_READY		= BIT(31),
>  };
>
> +/*********************************************************
> **************
> + * NAND ACC CONTROL bitfield
> + *
> + * Some bits have remained constant throughout hardware revision, while
> + * others have shifted around.
> +
> **********************************************************
> *************/
> +
> +/* Constant for all versions (where supported) */
> +enum {
> +	/* See BRCMNAND_HAS_CACHE_MODE */
> +	ACC_CONTROL_CACHE_MODE				= BIT(22),
> +
> +	/* See BRCMNAND_HAS_PREFETCH */
> +	ACC_CONTROL_PREFETCH				= BIT(23),
> +
> +	ACC_CONTROL_PAGE_HIT				= BIT(24),
> +	ACC_CONTROL_WR_PREEMPT				= BIT(25),
> +	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
> +	ACC_CONTROL_RD_ERASED				= BIT(27),
> +	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
> +	ACC_CONTROL_WR_ECC				= BIT(30),
> +	ACC_CONTROL_RD_ECC				= BIT(31),
> +};
> +
> +#define	ACC_CONTROL_ECC_SHIFT			16
> +/* Only for v7.2 */
> +#define	ACC_CONTROL_ECC_EXT_SHIFT		13
> +
>  static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32
> offs)
>  {
>  	return brcmnand_readl(ctrl->nand_base + offs);
> @@ -675,6 +704,12 @@ static int brcmnand_revision_init(struct
> brcmnand_controller *ctrl)
>  #endif /* __UBOOT__ */
>  		ctrl->features |= BRCMNAND_HAS_WP;
>
> +	/* v7.2 has different ecc level shift in the acc register */
> +	if (ctrl->nand_version == 0x0702)
> +		ctrl->ecc_level_shift = ACC_CONTROL_ECC_EXT_SHIFT;
> +	else
> +		ctrl->ecc_level_shift = ACC_CONTROL_ECC_SHIFT;
> +
>  	return 0;
>  }
>
> @@ -844,30 +879,6 @@ static inline int brcmnand_cmd_shift(struct
> brcmnand_controller *ctrl)
>  	return 0;
>  }
>
> -
> /**********************************************************
> *************
> - * NAND ACC CONTROL bitfield
> - *
> - * Some bits have remained constant throughout hardware revision, while
> - * others have shifted around.
> -
> **********************************************************
> *************/
> -
> -/* Constant for all versions (where supported) */
> -enum {
> -	/* See BRCMNAND_HAS_CACHE_MODE */
> -	ACC_CONTROL_CACHE_MODE				= BIT(22),
> -
> -	/* See BRCMNAND_HAS_PREFETCH */
> -	ACC_CONTROL_PREFETCH				= BIT(23),
> -
> -	ACC_CONTROL_PAGE_HIT				= BIT(24),
> -	ACC_CONTROL_WR_PREEMPT				= BIT(25),
> -	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
> -	ACC_CONTROL_RD_ERASED				= BIT(27),
> -	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
> -	ACC_CONTROL_WR_ECC				= BIT(30),
> -	ACC_CONTROL_RD_ECC				= BIT(31),
> -};
> -
>  static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller
> *ctrl)
>  {
>  	if (ctrl->nand_version == 0x0702)
> @@ -880,18 +891,15 @@ static inline u32
> brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
>  		return GENMASK(4, 0);
>  }
>
> -#define NAND_ACC_CONTROL_ECC_SHIFT	16
> -#define NAND_ACC_CONTROL_ECC_EXT_SHIFT	13
> -
>  static inline u32 brcmnand_ecc_level_mask(struct brcmnand_controller
> *ctrl)
>  {
>  	u32 mask = (ctrl->nand_version >= 0x0600) ? 0x1f : 0x0f;
>
> -	mask <<= NAND_ACC_CONTROL_ECC_SHIFT;
> +	mask <<= ACC_CONTROL_ECC_SHIFT;
>
>  	/* v7.2 includes additional ECC levels */
> -	if (ctrl->nand_version >= 0x0702)
> -		mask |= 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
> +	if (ctrl->nand_version == 0x0702)
> +		mask |= 0x7 << ACC_CONTROL_ECC_EXT_SHIFT;
>
>  	return mask;
>  }
> @@ -905,8 +913,8 @@ static void brcmnand_set_ecc_enabled(struct
> brcmnand_host *host, int en)
>
>  	if (en) {
>  		acc_control |= ecc_flags; /* enable RD/WR ECC */
> -		acc_control |= host->hwcfg.ecc_level
> -			       << NAND_ACC_CONTROL_ECC_SHIFT;
> +		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
> +		acc_control |= host->hwcfg.ecc_level << ctrl->ecc_level_shift;
>  	} else {
>  		acc_control &= ~ecc_flags; /* disable RD/WR ECC */
>  		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
> @@ -2225,7 +2233,7 @@ static int brcmnand_set_cfg(struct
> brcmnand_host *host,
>  	tmp &= ~brcmnand_ecc_level_mask(ctrl);
>  	tmp &= ~brcmnand_spare_area_mask(ctrl);
>  	if (ctrl->nand_version >= 0x0302) {
> -		tmp |= cfg->ecc_level << NAND_ACC_CONTROL_ECC_SHIFT;
> +		tmp |= cfg->ecc_level << ctrl->ecc_level_shift;
>  		tmp |= cfg->spare_area_size;
>  	}
>  	nand_writereg(ctrl, acc_control_offs, tmp);
>
> --
> 2.46.0

Reviewed-by: William Zhang <william.zhang@broadcom.com>

--0000000000001cbf9f062245ab90
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMaUYvZTCysH9hqoNetSCyUABtpC
cW3ltXNNPRx4cc5dMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDkxNzAwMjExOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBD6ny0x+r0TT49p8Mp6LYmruB3cdAoSDJRMU5rsF6T4DrB
TIHB8QfZMJmNRWcFI4Kfq/hQ8Q4REuV4OL7La5mErLu97n23bgFiJ5hT336qGh8edb1MU6cTbfFZ
RoXqTwpK6YksQaX7nPJJAuNPWO7KqMp7cqJozMjUqXaB8K8eR4kB++V/1H6OmbNsnSPmig6U9RlN
r9C1ZVKNPNtY5gJG82K0+hBnCy8YZu0q3mGThkIMDD2KD8pmZzFUoXF+O7WG6xo1CuttTUV2+oy6
RypJ+XRhY/ZZww7t/iEr5cAfw8h1T7Oz3RcpXzrKxncH4LEUT9+Lb8xgWPNv6722rNwQ
--0000000000001cbf9f062245ab90--
