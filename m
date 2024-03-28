Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47D6C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A23E87DDE;
	Thu, 28 Mar 2024 10:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711617657;
	bh=GlFe8AqFGKXdawLx/Ys8tjmqXH4IEfHv1jvs7pBET4Y=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yu/4WQDqS7bjfvdk+CRFgatf+GhGSVFf5IUSG7fJ//Cs+2CAYzGW00aXqgUsw5qP0
	 wzmKCIWtQ4mvV7DILyv0e/KfQ2lA3pq79idpriEnbsr9ukVKjCr3c3agHKcQahjtUu
	 1bD2hB5JGQ/A96hY/W3fnh2tSdd5M3Hp7NGcgrUGflBOyLTmniauNuenu0gtF35LJM
	 53J+JIlW+GwxBp4Us64OndQEBV/Hqj/956mqPAlSTsOP1kJ/kjIJAj8J8V+AzkXnWl
	 gxN2RHo9jXIYKGUloNY38u2GFya+9TIqz4QFXnNPSZV85PftFGywaPJeMKvKq7Jj8e
	 /aefh/j522ndA==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 118178772A;
 Thu, 28 Mar 2024 10:20:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711617655;
 bh=GlFe8AqFGKXdawLx/Ys8tjmqXH4IEfHv1jvs7pBET4Y=;
 h=Date:From:To:Cc:Subject:From;
 b=rJJrLoQ+aiieC/Y77kd2tz1fY+5Q5RkAJwN8hwVBqy3oXyyfeLUspoUScNklxrsQ5
 LU6g5eCUZCqFdeC7PdKofHyG9rnmrOeIMGlLr6aJ4CLvj+MwzDyhYDtsdPXjrnGeTM
 S98X+WKQcur+Pngmx1Zf2j/OolywCTzuRVxOJtEk4W+XdXmKQ47U+hCEYK1dIP+Jt+
 QrUKzc1xHmZqc/OGSXkFZlyc/ZgAsrYbLwUU6823jYqFv1+YSXTr5yYJ05KELEGsB1
 XU6WOx/x6iu2vM3JiHQY49FSH1om708qyUaN6gqvhleJzrtDrqzqFrP7jJW8Yl+ZTk
 yD9HE7SwCP4kw==
Date: Thu, 28 Mar 2024 10:20:49 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>
Subject: Thoughts about U-boot binary size increase
Message-ID: <20240328102049.10108d5b@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hYnHKOq4xVPVVS.h=_NQBj4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/hYnHKOq4xVPVVS.h=_NQBj4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

I'd like to share with you some thoughts about growth of u-boot's
binary size for SPL and u-boot proper.

Board: XEA
SoC  : imx287 (still in active production)
Problem: SPL size constrained to ~55 KiB (This cannot be exceeded).=20
	 Board design constraints u-boot proper size to less than ~448
	 KiB


When XEA was added (2019.07):
	- u-boot.sb (SPL): 37 KiB
	- u-boot.img 	 : 401 KiB

Now (2024.04):
	- u-boot.sb (SPL): 40 KiB
	- u-boot.img 	 : 427 KiB

(With a _lot_ of effort put to reduce the size)

Hence, the question - would it be possible to take more concern about
the binary size growth?

Maybe CI could catch patches, which enable by default some features and
the size is unintentionally increased?

I'm open for any feedback and thoughts on "stopping" the binary size
increase.

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/hYnHKOq4xVPVVS.h=_NQBj4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYFNnEACgkQAR8vZIA0
zr2J/ggA4ZGjeWSu63xyLJZv7/a1O+GAuBtOLgMMeIvyJzKXiPK9moXO7A1CeC9n
ylcA7qGTx3x3c8PqOVPUl6lCgOohvamQEL4HY1FMvR8BOpknRtzvQ5ja4BvxkrWg
2FJxMDjBYalfuZNseJfnnvvECSRWJ7rCeVCDiZXnyCPCA3AoLnPlwzJgxMOv+7QE
/QUv6AQhTkd4U8xialr+LGupdIJKs+ilQtDTqIofVO7IaQJJ6qZs94gf3+b6o3nK
UexdsLDXy2qU6BE4Ge37wSnbFVYaZTRhPw6ZA0hpMQBmUO985iRFXve0SFnQTKkc
BTs9fl/SRaYPT+0h32dVSQZYOAbQLg==
=2E6m
-----END PGP SIGNATURE-----

--Sig_/hYnHKOq4xVPVVS.h=_NQBj4--
