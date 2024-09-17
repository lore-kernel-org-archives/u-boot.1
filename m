Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC591C3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 00:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88EB288E42;
	Tue, 17 Sep 2024 02:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="WZY5Tgav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8020788E61; Tue, 17 Sep 2024 02:24:16 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD2A87BF4
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 02:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-502b408a381so1126244e0c.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1726532524; x=1727137324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vgLXiaSclXdeJ1Tmm1D9UqOYXpvrfrvonv2QFsxkr6E=;
 b=WZY5TgavAI4G4q6Hq7IEFYzKWSLKK7lX1GApRzU1IJrBrnnycE7QeBxsSv1R+EPORR
 3abBEQK+pVkQgUJLYhxkqxqHYXPcxN6zkXyf//TOn95YXH/JY9gcTQ52US5w1y9t1xFD
 e+NhP0z4HftdROp6cEwFmMu6gXCu3u9RYEIV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726532524; x=1727137324;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgLXiaSclXdeJ1Tmm1D9UqOYXpvrfrvonv2QFsxkr6E=;
 b=fIvCcLveNZSUdnEKYJePNjzANPGMUL73F0EtzYDu1dhCpfo4buWgtt1cl+rP4ia/6a
 drYrry1VHNLXIZ0/sgvOjH562b+o1sLU6LGMWvMub82w28bQ9MIikkotm/Q8VBn/l35E
 sjZpkhWm94f8loO6Ur1Dqt6QVPbC2XLY2gSBZPhCnYa0V8lZLdyAOME006Vdjl+/WFgr
 ebQ4hvJqqZyIUVIMDzCJAwaWUKieElJ4qmUb/aK2+fByCO/PAyN7Pi91nDOvdwNCv8fw
 XzHSTqLkoZ6X8eh3yZoLZ/jwXWX+kPHLVYMmRsJdb4hLvz8q9+tO52smyT4rQRuWKJgH
 XtOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQRYrWuN649T88lq3gHc+T3uuDa9xe33FBh6RmkFDRbLmLYgrYJnSzCaF3PSPDDgiyYHJouNs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4rzmlyQcUecZrxb1ltjEMiDBS4ef/7ow08RoKKiGQic3C1AF6
 XGrv6XzSEVNefeMNg6S0Jn/LpgEw71wUaDsI7iM0ZKn1zF+HYrUZWNR/eX8U3Tsf5L0T7KJcSAg
 2FrU3pgsE8tJthO2oNmrJ9i6hZlQ3iSB20FEY
X-Google-Smtp-Source: AGHT+IHCTbL882Cmch2Fv4uKvJLrLq6r57ymfmWa64exqhdkuxyorw9iUOxweB/wP7wOc5tHWxfUKgOfX1Z7IlrMCWQ=
X-Received: by 2002:a05:6122:3687:b0:4fc:eda5:634f with SMTP id
 71dfb90a1353d-5032d3a664dmr12137598e0c.4.1726532524323; Mon, 16 Sep 2024
 17:22:04 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
 <20240916-brcmnand-fixes-v2-3-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-3-08632f64c8ec@linaro.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQES+R/HTbMR/ti/GhYZxlIU8W7clgIxd6hvs9mxEhA=
Date: Mon, 16 Sep 2024 17:22:02 -0700
Message-ID: <f75b41253f3f3677d11827d8b6c306d3@mail.gmail.com>
Subject: RE: [PATCH v2 3/7] mtd: rawnand: brcmnand: Fix potential
 out-of-bounds access in oob write
To: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000d2904a062245ad6b"
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

--000000000000d2904a062245ad6b
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
> Subject: [PATCH v2 3/7] mtd: rawnand: brcmnand: Fix potential out-of-
> bounds access in oob write
>
> From: William Zhang <william.zhang@broadcom.com>
>
> Backport of upstream Linux
> commit 5d53244186c9ac58cb88d76a0958ca55b83a15cd
> "mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write"
>
> When the oob buffer length is not in multiple of words, the oob write
> function does out-of-bounds read on the oob source buffer at the last
> iteration. Fix that by always checking length limit on the oob buffer
> read and fill with 0xff when reaching the end of the buffer to the oob
> registers.
>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-5-
> william.zhang@broadcom.com
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 46a4107a83a9..60d34bd21f53 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1334,19 +1334,33 @@ static int write_oob_to_regs(struct
> brcmnand_controller *ctrl, int i,
>  			     const u8 *oob, int sas, int sector_1k)
>  {
>  	int tbytes = sas << sector_1k;
> -	int j;
> +	int j, k = 0;
> +	u32 last = 0xffffffff;
> +	u8 *plast = (u8 *)&last;
>
>  	/* Adjust OOB values for 1K sector size */
>  	if (sector_1k && (i & 0x01))
>  		tbytes = max(0, tbytes - (int)ctrl->max_oob);
>  	tbytes = min_t(int, tbytes, ctrl->max_oob);
>
> -	for (j = 0; j < tbytes; j += 4)
> +	/*
> +	 * tbytes may not be multiple of words. Make sure we don't read
> out of
> +	 * the boundary and stop at last word.
> +	 */
> +	for (j = 0; (j + 3) < tbytes; j += 4)
>  		oob_reg_write(ctrl, j,
>  				(oob[j + 0] << 24) |
>  				(oob[j + 1] << 16) |
>  				(oob[j + 2] <<  8) |
>  				(oob[j + 3] <<  0));
> +
> +	/* handle the remaing bytes */
> +	while (j < tbytes)
> +		plast[k++] = oob[j++];
> +
> +	if (tbytes & 0x3)
> +		oob_reg_write(ctrl, (tbytes & ~0x3), (__force
> u32)cpu_to_be32(last));
> +
>  	return tbytes;
>  }
>
>
> --
> 2.46.0

Reviewed-by: William Zhang <william.zhang@broadcom.com>

--000000000000d2904a062245ad6b
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKfkkns10btPFbeAZoFbAIpfKELq
lh4RLU4Vat1hxgZdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDkxNzAwMjIwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBfPJPL9gkL4XENSwCMN3SPExcX54Zyh519LvWxBHqVFvFJ
8HDZntoiJsMGZo8gcGOubWU2GCzce8qBifHd0E+jsFVs9D2seqtGX2uwTAeEooVRVgKVpGLJqQnx
C7pM6DDFMw62vDKE7P38gAv9gk9Eg37UbHbjN10wLnXYi8+8LEb7NJ08Uc3a0GYi5mORChO9CW+6
o9eVRNpFlKLnRQDfkzwXU/k2EgNBA/+9TrZln43rHI8TuE+c2NvQv2E4ZA4T6P+fpI9yGlHPv0tx
mSbHIZKAtwLJaM2j0VOB70o3i3rXtrrU1md+8FNb8/teX9iiVfwC5JWpOKPQpxXSTrLq
--000000000000d2904a062245ad6b--
