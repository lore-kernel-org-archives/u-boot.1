Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8BDCD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0AFA849F7;
	Fri, 19 Jun 2026 18:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tr6/MUVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2883849EE; Fri, 19 Jun 2026 14:15:15 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2AFC849E4
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c07c246ad7bso215140566b.2
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 05:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781871312; cv=none;
 d=google.com; s=arc-20240605;
 b=S+dbGA1k8/hStFCisz6AgiD7ba0qWlx+7n6iRbc/TyYm7hdt3VOQerN8apA79/acIH
 +6oger0Fu5KUqASyXoBbiTP8ppDAMnbfV3Wqh60pMZg4IK0KaDaOmJUnhj7Sz0VELX1W
 JQnowUg1sJ4swGkSNqBpsxcDitoK5V2fzshqXIXCydOw2tI+kh6zBERcWn57qp8OoZY6
 AjE+OMlydrAiY8I/fkjW+T+MB+E2kaZMs7WhlfuvUTLn5u4cH5isYgWP2GDNGaas8Xoo
 roCQ9vR+j6K8Ja6vsJ/LzQc2OZW9E5vy0AGIv7HK+yZV8i6mMSVG3zAv8RM9pcJ2zaY9
 crJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=34+M5Ypf0r38iWNbxI2TS8fsIPiwcy1WHlVS657k9i8=;
 fh=cGbkB1gSdVXOC84nKkk1tOGrLgUOp8IPv9WeMZyLdSc=;
 b=QP5bJ0J+1UEBjTIEpP/AURN+UO3E+xkjhfzYrF2E7iGTP6xfOyUS4NUY9CT4HPXoYk
 NNvXGU5J9o7UW/DLnmndxOOcLXKkKA1S3LdgTpFu1hIomAYrBlh5sX2W4CTbc4eS06ur
 M75qb+sG09m11TQt1r2V982z6pqD8teGY3ZUd5ygLDRQRDi19zql7/aUP8NylozpSVdg
 9NtizcBYdInB6IwTjU3dCoabrHiG7U/Gz2xD4jGk5Pd6yMO7bLQzbzsQ/8z9p79pfYfl
 EE/XaZE1YlcxEB2Zf/gXMwqHk0sk5qO4qQOlNZKNH0Sk/UCUolAQX4vDjbUzZxkiOdXh
 DX4w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781871312; x=1782476112; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34+M5Ypf0r38iWNbxI2TS8fsIPiwcy1WHlVS657k9i8=;
 b=Tr6/MUVmVmQoRlrqV8UvxsGX/b/8FrLranRWt1k/NlbUNV4m+FskDeZlCjGfxf5w0i
 TqyShIJhhGHQwhYPPuW5JvVyRBYLQQoTcULWAd+8rzYdRZ8hYhsdRpps+ugZILZsYK/1
 /ymsvQF53Zu+946XJmmZOCnaKsRgaznqjxA7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781871312; x=1782476112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=34+M5Ypf0r38iWNbxI2TS8fsIPiwcy1WHlVS657k9i8=;
 b=fv+NJOfYp94CO32/OhCP7yOC7ZYo1EpMVPEq/GLuOVTCU8ravq0PzwwcjkwgbThuHz
 5/WorxuVHEo+c6BCcfNzJ+cACANj86MffWfaLKoxzHzn2AmgO660Tz0+/Tm4R/QEWv8Y
 WNii8UNhIpbW/BNVAJ55Cbd75Q/ywiUK98FkJZwRC6zsU5ojeatu7EB0eYotyxnkzZOn
 ZiUo9bhG5BApg5jnCreQd0pu7doL8x4OPvIAzFwpMqMx6ndZZY8cXmr22B9lCWiQJnx5
 nDHNihAtWWtMhIQuFiaPZvJgh892IoARLofrR/8MdfpN1QnMzJP163PsZM5M/HNCb/hP
 aqXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fE/TQN5PC3qx+GhnmT+f+aAgfjPIz437mbt6D77i7uOGl2+p1VfPsnh27uQfA3w69kmTEm5A=@lists.denx.de
X-Gm-Message-State: AOJu0YwvoB0St3k1xkmAS1mHTGTvTD2luSklE7JiwOAWPYQ8urF2lqpH
 jIF4PAjZDqB5CC87D+WabK9p9JUNBje9EXbBXdeQ4QbNa9gkbA5lU7sEJfO3KEY8ewDBsptYKaj
 Ob6GA3W+y9dZxqtioJukpi0ppGDof3yKB62h4JpUA
X-Gm-Gg: AfdE7cl5u4rOUKjw3s1eyG2lEXqzfQ1DKofXuRdFJjcK8siPWpLFAkXn4nqBfUS/sM1
 39u+PfkrqWLnE3Xp1gJXu9fq9NCp3rhzEjsrDJmvoFb6OtOOwCrvRoNP5nFaU4O74RfXTKl49Q6
 A3h0CXNSRhkx71iGJFKOdPraB0BMjMBDIYjT0zTQtObxbW6NxMvAh0A/fMmU6CYmJy+84R5DO+7
 Sw6gv2J80gvsKjghRb8ayTY9IPnwPiEtO+MogMDSKmYK+oDA2H69eVjalQvbfCYHDanTnQrZA==
X-Received: by 2002:a17:907:5ce:b0:c07:e025:154d with SMTP id
 a640c23a62f3a-c0990ae342bmr180374466b.52.1781871312153; Fri, 19 Jun 2026
 05:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260617101812.299586-3-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260617101812.299586-3-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 13:14:56 +0100
X-Gm-Features: AVVi8CeR1WGu_X_ChvpoTJcvSeLuiacTrDPMcCNnb84FqVJ8OX-Tx4LdfBxP5pE
Message-ID: <CAFLszThw0BNAqzJuqWNRwViyTi6-Ez1e=d2jnV9QhWbDrGQgRA@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] binman: qcom: Add type definitions for Qualcomm
 binaries
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, sjg@chromium.org, 
 alpernebiyasak@gmail.com, tien.fong.chee@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com, 
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, mkorpershoek@kernel.org, andre.przywara@arm.com, 
 afd@ti.com, h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com, 
 luca.weiss@fairphone.com, adrian@mainlining.org, danila@jiaxyga.com, 
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com, 
 ycliang@andestech.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 n-francis@ti.com, david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 bdklingerman@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 19 Jun 2026 18:31:25 +0200
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

Hi Varadarajan,

On 2026-06-17T10:17:59, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> binman: qcom: Add type definitions for Qualcomm binaries
>
> Add type definitions for Qualcomm's
>
>         appsbl  -> APPS Boot Loader (U-Boot)
>         config  -> Board/DDR related configuration
>         lib     -> Library of proprietary routines
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
>
> tools/binman/etype/qcom_appsbl.py | 23 +++++++++++++++++++++++
>  tools/binman/etype/qcom_config.py | 26 ++++++++++++++++++++++++++
>  tools/binman/etype/qcom_lib.py    | 21 +++++++++++++++++++++
>  3 files changed, 70 insertions(+)

> diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_=
appsbl.py
> @@ -0,0 +1,23 @@
> +    Properties / Entry arguments:
> +        - filename: Filename of U-Boot MBN (default 'u-boot.mbn')
> +
> +    This is the U-Boot MBN image.
> +    """
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node, 'qcom-appsbl')

Not quite. blob_named_by_arg looks up an entry-arg called
<blob_fname>-path, so the actual property is qcom-appsbl-path
(matching what your doc patch passes with -a qcom-appsbl-path=3D...).
There is no filename property and no default. Please update the
docstring to match the other two new etypes.

> diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_=
appsbl.py
> @@ -0,0 +1,23 @@
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node, 'qcom-appsbl')

qcom_config and qcom_lib set self.external =3D True, but this one
doesn't, even though u-boot.mbn is supplied via -a qcom-appsbl-path=3D.
Should this also be external? Otherwise a missing blob produces a hard
error rather than the usual missing-blob warning.

> diff --git a/tools/binman/etype/qcom_config.py b/tools/binman/etype/qcom_=
config.py
> @@ -0,0 +1,26 @@
> +from binman.entry import Entry
> +from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg

The Entry import is unused - same in qcom_lib.py. Please drop it.

> diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_=
appsbl.py
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0

The rest of tools/binman/etype/ uses GPL-2.0+. Please align (all three
new files).

> diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_=
appsbl.py
> @@ -0,0 +1,23 @@
> +    MBN is a Qualcomm=E2=80=91specific signed firmware container that pa=
ckages
> +    executable images (typically ELF) along with metadata such as hash,
> +    signature, and certificate chain, enabling the secure boot chain and=
 Root
> +    of Trust (RoT) to load and authenticate images.

Just to clarify - the doc patch shows this entry is fed u-boot.mbn
produced by running elftombn.py over u-boot.elf, but the binman node
in the dtsi treats it as an ELF (fit,operation =3D 'split-elf', os =3D
'U-Boot'). Is the input actually a raw MBN container or the wrap-elf?
The docstring should describe whichever binman consumes.

> diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_=
appsbl.py
> @@ -0,0 +1,23 @@
> +class Entry_qcom_appsbl(Entry_blob_named_by_arg):
> +    """U-Boot mbn image

New binman etypes normally come with an ftest entry and a small test
data file. Please add coverage for these three.

Regards,
Simon
