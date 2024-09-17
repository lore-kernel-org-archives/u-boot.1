Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89914C3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 00:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2682C88785;
	Tue, 17 Sep 2024 02:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="KLyABXea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C026988785; Tue, 17 Sep 2024 02:23:37 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E07C88E6F
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 02:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-50108a42fa9so1068731e0c.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1726532551; x=1727137351; darn=lists.denx.de;
 h=to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=56QALE1tMN0/W3ih0cEQKzFNzx3eTujFxoEAjtih5PU=;
 b=KLyABXeaOLJc6DUzSsMpurN2VvT4cpTFUetj4GORi12aOycrReUQ4Y6jYeFqayg399
 UKSbjBy0FXY0UPQglFufVxA9g+R4ys31fNrWDn6goeL6jExOvqS50OmEaiWgNCc0s7SQ
 kLPhutfGr6ZEnkC3L/Kyz1Kmc+goUdWNWL/wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726532551; x=1727137351;
 h=to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56QALE1tMN0/W3ih0cEQKzFNzx3eTujFxoEAjtih5PU=;
 b=kB8kozYUmeh4FNoG1tRufY2s3VGe9kI8+NY3NgSW4BeGmIIRPF4cZCDMXrh5NDGkFY
 9ciBVpHDcZi8tHolXKODPDqP7on/WwSb06TbjkVpxF8A8T+TX/+nSkvi2KzQOHlPvFHR
 qYOaMWxLzjhUBMZpqLVIbApflJnwyO/1V1DVgHiVUZGmvllApYv43c+MX1XZY0EGuC/C
 MAB/fz4FO3xI1xcyXdIiBlHzAk8asDC8hu9QB2L0cM4AQmkFir9QSXz7NwQR4j/yBOqI
 XvMYuJL0JapU3ZKfjitm4G5WGek7ofJZ6CSmzGXcjYrVtbXgF+K+v0DfpV5CAUB40Vbh
 cRlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcb/2aIbnwi9bXPSS6qrlhRCBGvNM9fEBUw6w7sM+GFiGnvpDpSWHDUgOHz66ZcmlKRASRcVY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywsbvq6v+RrSR4rGjr/yJL6axx6OqAX5gmDEJgzGpp9NQoz8JiW
 bKdNf2qOHMIrbyGwN5aYd0gpeOeSRN09uXZhujxG/jlRb9UFtZov7kvtCgymAScWdHZQNuD7GFE
 Ezj+3Ggm5cevxbJKEroauho3NltG7bIQMyA4w
X-Google-Smtp-Source: AGHT+IESG5H+FARHem2RThaMBO7KTDpLCGfkLgNy7v8VkZK3o2VA23tr5+M0cHdbOla03/LRfAQTjRQ0MJFtjLGTjTw=
X-Received: by 2002:a05:6122:2517:b0:4fc:e4f5:7f83 with SMTP id
 71dfb90a1353d-5032d4bb92dmr12154047e0c.9.1726532550954; Mon, 16 Sep 2024
 17:22:30 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
 <20240916-brcmnand-fixes-v2-5-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-5-08632f64c8ec@linaro.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQES+R/HTbMR/ti/GhYZxlIU8W7clgE+Hqhls+FMIlA=
Date: Mon, 16 Sep 2024 17:22:29 -0700
Message-ID: <852cddc291181376d193ece84aecd066@mail.gmail.com>
Subject: RE: [PATCH v2 5/7] mtd: rawnand: brcmnand: Add read data bus interface
To: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000069aa21062245afc9"
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

--00000000000069aa21062245afc9
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
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Subject: [PATCH v2 5/7] mtd: rawnand: brcmnand: Add read data bus
> interface
>
> This is a port of the read data bus interface from the Linux
> brcmnand driver, commit
> 546e425991205f59281e160a0d0daed47b7ca9b3
> "mtd: rawnand: brcmnand: Add BCMBCA read data bus interface"
>
> This is needed for the BCMBCA RAW NAND driver.
>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 20 +++++++++++++++++-
> --
>  drivers/mtd/nand/raw/brcmnand/brcmnand.h |  2 ++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 552b239b95ae..2f786584a1ae 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -769,6 +769,20 @@ static inline void brcmnand_write_fc(struct
> brcmnand_controller *ctrl,
>  	__raw_writel(val, ctrl->nand_fc + word * 4);
>  }
>
> +static inline void brcmnand_read_data_bus(struct brcmnand_controller
> *ctrl,
> +					  void __iomem *flash_cache, u32
> *buffer, int fc_words)
> +{
> +	struct brcmnand_soc *soc = ctrl->soc;
> +	int i;
> +
> +	if (soc && soc->read_data_bus) {
> +		soc->read_data_bus(soc, flash_cache, buffer, fc_words);
> +	} else {
> +		for (i = 0; i < fc_words; i++)
> +			buffer[i] = brcmnand_read_fc(ctrl, i);
> +	}
> +}
> +
>  static void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
>  {
>
> @@ -1812,7 +1826,7 @@ static int brcmnand_read_by_pio(struct
> mtd_info *mtd, struct nand_chip *chip,
>  {
>  	struct brcmnand_host *host = nand_get_controller_data(chip);
>  	struct brcmnand_controller *ctrl = host->ctrl;
> -	int i, j, ret = 0;
> +	int i, ret = 0;
>
>  	brcmnand_clear_ecc_addr(ctrl);
>
> @@ -1825,8 +1839,8 @@ static int brcmnand_read_by_pio(struct
> mtd_info *mtd, struct nand_chip *chip,
>  		if (likely(buf)) {
>  			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
>
> -			for (j = 0; j < FC_WORDS; j++, buf++)
> -				*buf = brcmnand_read_fc(ctrl, j);
> +			brcmnand_read_data_bus(ctrl, ctrl->nand_fc, buf,
> FC_WORDS);
> +			buf += FC_WORDS;
>
>  			brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
>  		}
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> index 6946a62b0679..3a1d60471361 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> @@ -11,6 +11,8 @@ struct brcmnand_soc {
>  	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
>  	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
>  				 bool is_param);
> +	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem
> *flash_cache,
> +			      u32 *buffer, int fc_words);
>  	void *ctrl;
>  };
>
>
> --
> 2.46.0

Reviewed-by: William Zhang <william.zhang@broadcom.com>

--00000000000069aa21062245afc9
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICjlL13GvUZ2zi6JyVaGTXXHddJG
OZsyhZOZIhIqVg93MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDkxNzAwMjIzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQDCTWUc9mI31/RcAT+qFJDj1/yfOrVz2vVt0GlsCIjxIJwD
plrwMsryZn7dFkLRMCUXHAaFsB66sj9WCexB/d9oeq72DOcIFW15QM7HGxaZqqT00oXf3D/PXaf6
37nnkU+S/LCgNcFm1MjvmxYTipHET1cvAnQIKUXsQHrJVdAvHjHVo/CIFKBy5po4Y1tMUAGTD7Od
uPPD311eI2G9mKprPuAfcHRZC/J9hlxS7J38WgRvAXdKenVehlKbd3fppdg80XQulJxkYK4QuLG3
pDcgwLZwoQCTkEEH59+k2/ywR1YuJ1wHwe5jJkcQUhj20DdXOvNffXQh81flLJjq23fF
--00000000000069aa21062245afc9--
