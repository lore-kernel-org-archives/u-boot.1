Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1815F43821
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 14:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4265F84119;
	Wed, 15 Apr 2026 16:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="miey8sp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A6384129; Wed, 15 Apr 2026 16:28:12 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0F0A83B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 16:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cfe71e5d3so5329959f8f.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776263289; x=1776868089;
 darn=lists.denx.de; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xwhw+X0I8OpEYxETrkUnw0mVGdv/V2+3p0SdDbofK5A=;
 b=miey8sp+4UHGbSKyfa+q1K9xcvWYjgPSgbFlPaVhfj65HeBlPAtixAyhe8JvPnCeYp
 3/kpV/Tf4N8TamysRgpfM3Dv8U5xM+BJNc5eJmsc72Z4tozjcnOlu/KiJZJZFfQpXle5
 fVQ5DkNyW0ihDgaUFxWT7PY+GKlIwLHJIS/bN1rBgKb616bvXwEoUCLELgKq0uOk84sr
 4sJZ4QSXFsuFfwCUT6tmM8YqqEvJQ8clK+hzL9cjv5qMrIYOBr1H+UhtiYQVy2gdjSjE
 acTVM/x1YoIIApQvz/Xlto1P5Gwz7a9iQLSD8BtuGb5geCR8cLvsLZbZdAKrvxzugMon
 kOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776263289; x=1776868089;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xwhw+X0I8OpEYxETrkUnw0mVGdv/V2+3p0SdDbofK5A=;
 b=aLlMarRsvQVAasYpDAg2o0g1dbY/pfHJisTK2qujxFXEo9fOD/nwsMPLfmpKANyfbt
 ahSK0BPsXsiO3SCD85DT2+L+ApsifoUnR+sblTAj9y7Csh9E44wzTSvOnyuoi+iGi9Rt
 qqg0FVS1w8NXTZbuwSbdF9nszQ0T14FLyF9FZ77qaQN+mzcGuntt4C7eLgd9t7/HoFYN
 tpifp2SKSUzQUttUcHuA7Q3j7YBgtcHFg0I3pUbIXXT+XrIfgCeEkrGOF97G4CJXLuiK
 ascM/+paF0o9XiDT6b1pCRX4Mkc6mVFaYIMwkY/RD+3ZNi4xk0wCDc2sizbnVzmpp9an
 4N4g==
X-Gm-Message-State: AOJu0Yx+D42tt1QKwogjyCdFetemCl2LKHnFLJP7QIPSIcQn8bHz5yal
 PlFgaPuKhBfJphMHNS4hWdHT93IV4fTN/3cFW19Yh27QYf4HABaKAMmwxytg4TTURew=
X-Gm-Gg: AeBDieseoGk50gu9vls76HGTzFB89k286a00WoSabeXJnLXyD0O/LwVmTyzoMxvpFmz
 E9XUT4VeTn0X0KwCyLtLiIOgthWsVQG9TB7Lyf5aL0uO/tJfOWLrhK7tUC+ILUCGGrJt2XNqBTg
 vjyGzd6UOlkwEP1Nsbjapfe33SQWEQFPfzPFSVqA3KZruiQpownWMsDrXma+nH1mxhc6UAuurPg
 ycAbDybMufytMgpyF38kwGACjXvQYfeIoPJo2YVyb1KRorpvnVjY3+6iUz6Nj4ssGcrjdHfx+Zp
 IwODMVn4dQ99rILm4ZczKnKDSMLYig3r43PndH2W6eCvBAlPwGqPi3+5SkF0hrTE2jWuaSC0Nfu
 URVu8B+kseEF89xR5xTk/aGaaeXeWMw66kjcKzpxjbOpWxX1gVo/dGgsHoi3tNcjtweZhSWiyDl
 DtuLX5H20k44AvEGL9dtNZHx7jqw==
X-Received: by 2002:a05:6000:1a8b:b0:43d:7e6f:37fa with SMTP id
 ffacd0b85a97d-43d7e6f38cemr13563948f8f.19.1776263289320; 
 Wed, 15 Apr 2026 07:28:09 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d6e9sm5834731f8f.1.2026.04.15.07.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:28:08 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c7dd5bc499db56229f74fc69f9bb7a87ab183cbcb8204bde6c22b8ac56b8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 15 Apr 2026 16:27:59 +0200
Message-Id: <DHTSS5QSJL9L.2RMHDQ28R45PJ@baylibre.com>
To: "Andrew Davis" <afd@ti.com>, "Fabio Estevam" <festevam@gmail.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>, "Tom
 Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Simon Glass" <sjg@chromium.org>, "Anshul
 Dalal" <anshuld@ti.com>, "Michael Trimarchi" <michael@amarulasolutions.com>
Subject: Re: [PATCH v5 12/12] configs: am335x_evm_defconfig: Switch to
 upstream devicetree
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-12-4b9c7aca0e3e@baylibre.com>
 <CAOMZO5A7EG1KUV3jebrX0jQ8CvJ_QJxS4dTk5KQH0vLHk0_3VQ@mail.gmail.com>
 <2aec366c-ccf1-41e1-9fcc-242a9b525ce1@ti.com>
In-Reply-To: <2aec366c-ccf1-41e1-9fcc-242a9b525ce1@ti.com>
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

--c7dd5bc499db56229f74fc69f9bb7a87ab183cbcb8204bde6c22b8ac56b8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Fabio, Andrew,

On Fri Apr 10, 2026 at 11:52 PM CEST, Andrew Davis wrote:
> On 4/10/26 2:57 PM, Fabio Estevam wrote:
>> On Fri, Apr 10, 2026 at 10:34=E2=80=AFAM Markus Schneider-Pargmann (TI)
>> <msp@baylibre.com> wrote:
>>=20
>>> -CONFIG_DEFAULT_DEVICE_TREE=3D"am335x-evm"
>>> +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/omap/am335x-evm"
>>=20
>> You should also remove arch/arm/dts/am335x-evm.dts as it is no longer
>> needed after this change.
>
> Same for all the other DTS files:
>
> CONFIG_OF_LIST=3D"ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-s=
ancloud-bbe ti/omap/am335x-sancloud-bbe-lite ti/omap/am335x-sancloud-bbe-ex=
tended-wifi ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bo=
negreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bon=
egreen-eco"

Good point, thanks. I will add a patch for that.

Best
Markus

--c7dd5bc499db56229f74fc69f9bb7a87ab183cbcb8204bde6c22b8ac56b8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCad+gcBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlM1
yAD9HXMNnaLVUth8KLDUfjG4gLkZuMo57G70x+ja/qBZ/XEBAN4H2txWDJVnlJ1U
6a5SDAOORWJ6Sud6qzNcvKXc61EI
=5WOI
-----END PGP SIGNATURE-----

--c7dd5bc499db56229f74fc69f9bb7a87ab183cbcb8204bde6c22b8ac56b8--
