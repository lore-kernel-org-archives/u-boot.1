Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCC1D5D69F
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 02:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EA288B8F;
	Fri,  8 Nov 2024 03:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="UkdgMHBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977E888AE8; Fri,  8 Nov 2024 03:22:49 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73ADA88C7E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 03:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84fd057a973so645834241.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 18:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1731032565; x=1731637365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qGBEQHtB+opgCa7kSrQvUIm41VNo04HFZwilRSuzYZ4=;
 b=UkdgMHBtPfSIrfKK4+To/j+thaV6TRYnaxOGaP3t2HkEtkP8p7CZaxIj+zzT2J9Uvk
 bKaIQKspMBxg4xn/IwrRUwjjKLC5Bx6eXu1kwS0YS5JGEkIiNDlBvOL1s87VNZbBUj8a
 0CqhEXnqho/bXeoNjbzRc2n9HKq6M/qIZep2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731032565; x=1731637365;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGBEQHtB+opgCa7kSrQvUIm41VNo04HFZwilRSuzYZ4=;
 b=B7vh2ZtVs5vZrLFkEhDKWFV1JGabf5hf0kXu7ChtfNxca7NhJaEmiR1Lb3fuD+tLbN
 4md1Y53XvOP+ovBGJqgpAZNIUsckcf87ZI5tXngqRnedHXyiAo9wQ06FODR6ePegOOL5
 jR/wzUTu6VD2sZ7WtMUZDl/0TcyHWWjb48wSRzCI/R8s4JbFnf5yub9M/AeajWEiy8yX
 8ujndCZVG+8SGBjEphEKe0KZnqU2xl7PQFNviP+YO7fMt0yeCvEQIv6idNWkGAP/9ILT
 SqtmLfAfWxdEnZlD4s5LMJI98K7/AZPtzuY/OcY+3EMcICuqvw1Il5QcAlwXiakXCmaz
 HZSA==
X-Gm-Message-State: AOJu0YyGmYLJQgxpHqI23lTdhW5gwAZNGjX8M6GD60f/ZKrf8jeE4aOX
 Rm7QDBLUN5bbxu/bKQr3ibChMR60tE5rsCa7EGwQoPbcf+Zm52jhCU4fpvjppMHu8nrvHU8deFA
 EcNJAMFFCLvatWmewbINM+BLGx4Z64953zE/2
X-Google-Smtp-Source: AGHT+IGgraYbfP/rdDLZxNA2qcs8WfoIochR2a3ZGDliWC6lkzbmSvzU71FfUxDk0oesa6HDDZlR5tShjH9yvI/XvMA=
X-Received: by 2002:a05:6102:c0a:b0:4a5:b0d3:cbc4 with SMTP id
 ada2fe7eead31-4aae137c16fmr1836838137.8.1731032565260; Thu, 07 Nov 2024
 18:22:45 -0800 (PST)
From: William Zhang <william.zhang@broadcom.com>
References: <20241106210348.218507-1-dregan@broadcom.com>
 <20241106210348.218507-4-dregan@broadcom.com>
 <CACRpkdYt64S=X2_-VO5h=0kgZ5hcoVWOnzYRK5k39AX0cMkD_A@mail.gmail.com>
In-Reply-To: <CACRpkdYt64S=X2_-VO5h=0kgZ5hcoVWOnzYRK5k39AX0cMkD_A@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEQKFBmavgO2qJJDwqKBpsruZiKagGFxcGqAlpun5i0I7RAcA==
Date: Thu, 7 Nov 2024 18:22:43 -0800
Message-ID: <50f852ca0d50e518dc40b1545bc78d38@mail.gmail.com>
Subject: RE: [PATCH 3/4] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
To: Linus Walleij <linus.walleij@linaro.org>, david regan <dregan@broadcom.com>
Cc: u-boot <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@mail.com>,
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000292e6406265d6dc8"
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

--000000000000292e6406265d6dc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

> -----Original Message-----
> From: Linus Walleij <linus.walleij@linaro.org>
> Sent: Thursday, November 7, 2024 6:16 AM
> To: david regan <dregan@broadcom.com>
> Cc: u-boot <u-boot@lists.denx.de>; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> <michael@amarulasolutions.com>; Anand Gore
> <anand.gore@broadcom.com>; William Zhang
> <william.zhang@broadcom.com>; Kursad Oney
> <kursad.oney@broadcom.com>; Philippe Reynes
> <philippe.reynes@softathome.com>; Florian Fainelli
> <florian.fainelli@broadcom.com>; Miquel Raynal
> <miquel.raynal@bootlin.com>; Kamal Dasu <kamal.dasu@broadcom.com>;
> David Regan <dregan@mail.com>; Tom Rini <trini@konsulko.com>; Jiaxun
> Yang <jiaxun.yang@flygoat.com>
> Subject: Re: [PATCH 3/4] mtd: rawnand: brcmnand: Add BCMBCA read data
> bus interface
>
> On Wed, Nov 6, 2024 at 10:04=E2=80=AFPM david regan <dregan@broadcom.com>
> wrote:
>
> > The BCMBCA broadband SoC integrates the NAND controller differently tha=
n
> > STB, iProc and other SoCs.  It has different endianness for NAND cache
> > data.
> >
> > Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
> > and performance improvement using the optimized memcpy function on
> NAND
> > cache memory.
> >
> > This is a port of the upstream Linux patch to U-Boot.
> >
> > https://lore.kernel.org/linux-mtd/20240223034758.13753-12-
> william.zhang@broadcom.com/
> >
> > Signed-off-by: david regan <dregan@broadcom.com>
>
> The patch looks fine, but shouldn't the existing brcmnand_read_data_bus()
> in drivers/mtd/nand/raw/brcmnand/brcmnand.c also be replaced with
> brcmnand_soc_data_bus_read()?
>
> Maybe this is a problem in the upstream kernel driver though :/
>
The upstream kernel driver is correct because it uses exec_op to read the
parameter
page/ONFI data but exec_op is not available to the u-boot code base.  So
this new function
brcmnand_soc_data_bus_read tries to do that in generic way to handle the
endianness
difference between platforms. But I agree it causes confusing to existing
brcmnand_read_data_bus.

We are working on a better solution and will update.

> Yours,
> Linus Walleij

--000000000000292e6406265d6dc8
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICqtqEsLc8pWfQ+f6FWl3ZGnYDP9
e5Esn0FNviAkAFKHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MTEwODAyMjI0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA12xFq0SqM5u5DUldqgO+u3ut8aPbvDkjmK6/bczFdLHUo
Kh94JMTKw+T+vlq3wYdpfXzVGuS1e1a7GAfUDAkJYnXptu6uW2L+dCC6kTO7L0H6qmSRek7dhyL2
goiIAVnXj1som0eMyfLFQnBzxUGz9rYfXDXWQL2/LjISM70K8u0LBc1rWkAf24IiGP7kTPxddTZW
2oRAVrmECuzbAmKIETX87Zwyal2DULPpBOWt4L+w+WSYI+RKlOvMP69qEcGRvCXqdv6TZcjDeGTN
kEtYYoGexTOfCOanQFPk7+54hCfMOOb/sysm9c1V0iFrvVrUJE2/2/60+2MeA3kFX2Gt
--000000000000292e6406265d6dc8--
