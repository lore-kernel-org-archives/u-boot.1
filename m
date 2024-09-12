Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698F6EE57FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00EA88D02;
	Thu, 12 Sep 2024 03:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="eA56SJCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3F988D01; Thu, 12 Sep 2024 03:33:01 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5741588D23
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-502bb7cc965so129703e0c.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1726104777; x=1726709577; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2suXdsOhp2Qp4zCx0aZBcV4wCdmb+dq8sH+U0SxRsHE=;
 b=eA56SJCl/ki3nOUdWP6yMaZiK1U/xQynOSeoo1kIvBJQCQ3sYnwujAmAQNn2fDxDGD
 QOjGFXjt0iOAVVfe7E89VLKYiQdK2Wt+ZB91edmpMHzqj0cjBqxLxPmu9OETQGQMiYjy
 d+3iJxcJ2YDbCqt6Ug07/hpYmrnMkzMU+su4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726104777; x=1726709577;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2suXdsOhp2Qp4zCx0aZBcV4wCdmb+dq8sH+U0SxRsHE=;
 b=dwvmisQECDYzXn0JyHVfDvj4i6bTHB0dGy0PyyC8be6OjGgcF971LYz9WIlSN3bsmJ
 crFbT5ZuJh3RpiQ7/ysh2uDYdbpA01seed2ebGbyZNuNEFQdzvoxNugaO4CbQmf217CG
 A0K9nwq6PnpOpBEzfkMy3fbqacAIbCxZR90pn54uZ5Zja2urn1PlguHUbrDDTgo+ltCH
 EzvEotuzIqG+yHBXBWVA/o1ER0g7nqgX5Cr1JOFh0axxrOAMJOxE3pRmQnJesD+fqxh+
 eOVIWkfRuPgP8D3Rw0Ic1hA8fmOzPf/lGACk+7lpCoHvtdybnTNrKOv7Qa7MKLwJ/RJ7
 PBSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqVEY9pBcGwbW5y3fyVNeVwpdJbOtu0Sj2J5nX3Os17ZKMTVxeY53ARJ39AmkvygWJQLuBKIo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxx8bF8szemhHEsMe8irnMPSCM0iaJ7kCIV6Iy9IJc8JqYKRqVy
 se29/Qfe0iVGCAnC8Vy2FvhY76KRfDu4s7kjcfketHTksE1ypEWhKa969bi/xr1zyI3k+1iHaZM
 XaEZp4r1evKC+j4xAVC2NPp9FlbzmDEjaNzHg
X-Google-Smtp-Source: AGHT+IECCJk9s9ztE17NAE9+SiRdQGV7xiqVeYeiNlDwCrB6FlgTLNXtMfpRvN75aRG5hcN3MED2zd+c3sKS/AI/MlA=
X-Received: by 2002:a05:6122:1d04:b0:4f5:2c0c:8528 with SMTP id
 71dfb90a1353d-5032d54dfb9mr1228655e0c.11.1726104776579; Wed, 11 Sep 2024
 18:32:56 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
In-Reply-To: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGk0aZcPU5All9ASVJP8xH8NxMfIrK/wZ7g
Date: Wed, 11 Sep 2024 18:32:55 -0700
Message-ID: <d27e92a5ccecc302a1b2ca7ff55b8c3b@mail.gmail.com>
Subject: RE: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
To: Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Kamal Dasu <kamal.dasu@broadcom.com>,
 David Regan <dregan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000141a4a0621e21654"
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

--000000000000141a4a0621e21654
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Thanks for merging the patches to u-boot.   We actually had something
similar
here locally but just didn't get the chance to upstream yet.

We will review and compare your patches to ours and get back to you.

Thanks,
William

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
> Cc: Linus Walleij <linus.walleij@linaro.org>; Florian Fainelli
> <florian.fainelli@broadcom.com>; Miquel Raynal
> <miquel.raynal@bootlin.com>; Kamal Dasu <kamal.dasu@broadcom.com>;
> David Regan <dregan@broadcom.com>
> Subject: [PATCH 0/7] mtd: nand: brcmnand: Backported fixes from Linux
>
> These are a number of assorted upstream Linux fixes to the
> BRCMNAND driver that I have backported in an attempt to get
> BRCMBCA working with U-Boot (still not there).
>
> This patch set lowers the hamming distance between the Linux
> and U-Boot drivers a bit as well, while we deviate quite
> a bit it is still possible to bring fixes over thanks to
> exercises like this.
>
> The set tries to prepare the ground for the BCMBCA driver
> which I have a port of which is however not yet working
> as it should. This is why the read data callback is included.
>
> These patches seem to work fine for me with my devices but
> I know the maintainers have some nice test farms so try to
> put these to test and see if we can merge them. I bet the
> Broadcom folks has this on their TODO list anyway.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Linus Walleij (1):
>       mtd: rawnand: brcmnand: Add read data bus interface
>
> William Zhang (6):
>       mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2
> controller
>       mtd: rawnand: brcmnand: Fix potential false time out warning
>       mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob
> write
>       mtd: rawnand: brcmnand: Fix mtd oobsize
>       mtd: rawnand: brcmnand: Support write protection setting from dts
>       mtd: rawnand: brcmnand: Add support for getting ecc setting from
> strap
>
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 206
> ++++++++++++++++++++++++-------
>  drivers/mtd/nand/raw/brcmnand/brcmnand.h |   2 +
>  2 files changed, 164 insertions(+), 44 deletions(-)
> ---
> base-commit: 5f044932413694475422d4b16607dfcf9aff8781
> change-id: 20240911-brcmnand-fixes-dabd75230a63
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>

--000000000000141a4a0621e21654
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKQRgld/vSe9Yj62F2Je+dDIRXzN
cdp+R47tJRxGU2K3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDkxMjAxMzI1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBvGzIyZYgrlb7RtQ4uDKm7qUCX+ctARHRzC4Y1WFGwIgMa
nm0ucNBT5baMzQ1sKBtqWB4i/92w9QTEXTqlflK3cUjl/KT+W28JuTwxFOqtFrSt6DjLuMQJIsyP
c1DTU4/d26QwUc2XMRbTrCxFsPK6FXQ+F8c4NOVnnIGKd2JRWtb0OV6gEzU3Hs5L4fPvLJVbj7c6
xkVppZ0ygI7yabtN/hPHnnzBdtcKLy8WDGiOXe7WcRW8n80u5M4LCNNyBpBp1WmkwQuOC+M0+1vi
5pLjDVj1ukSUq35Zn84zosZbjUgvwFe3XYAjzgkC7VCuVxMFKsVWRkxywQg4PY9z82hL
--000000000000141a4a0621e21654--
