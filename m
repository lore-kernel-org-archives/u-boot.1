Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D076F419A4
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 13:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C721083B99;
	Wed, 15 Apr 2026 15:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hWRg1PJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9754E84129; Wed, 15 Apr 2026 15:11:49 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2779983936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 15:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso54952955e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776258706; x=1776863506;
 darn=lists.denx.de; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xLRf4CzFqE5AnRGDUuzp4KHVAjNviwVGLJpMW+q2leg=;
 b=hWRg1PJRufJi2RSXXqsBflgsHO4s0TPHj5HdhjNn8ziodSJllgwEbEdR4nCRM066JH
 ljShbc5B+spAoaA2dAK7/qIS1BDklCucbBoY02s3TZnvcPM06ywM79ag68cIooVNCo4s
 gzT3AQJlTQ72ZFsl0vtk/XN1UsXxibm0IEm+/UmSgkMwZWVofrli59hVqcm9UAgWduDV
 bmaYLpL5Ou7PpI2/Y/0U9WtPi7eN2YPQ/iycwdkH9rZaDSx4wwqfmSsUvv7gQTRJVjBe
 fEubV7gOSvcnE85tDN9KURFb42oyy4fbD0nskprkCB9HNZGn6UMl847OE/W1Ycpt77J2
 5veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776258706; x=1776863506;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLRf4CzFqE5AnRGDUuzp4KHVAjNviwVGLJpMW+q2leg=;
 b=BPg1YIMDDm/AGaJc+6A7KrCA3MOA+iWQ3cVtjfhSVLW8yqbjz6CVoLUi/IvAgpZYaN
 moxiZ13ike37ADYm29ZgLC/jwhaUWm4x6CPpSzf+U46BiI7Ss96IWnMChaQk1kpO3Cvm
 5y0gw5SlQ07roPSpESf4MIs2HoymmBysIKFubGPUh4nd+21icg2NWAYCRkTWRyBdhCsP
 7Wfp4i4vgWC6lldtTmlzZDwZr8j/BfYJwx0qz8rRAvYyUwHZqtzd+slkV3j85dpMCE3u
 4ZH1gJDML/+vcvdyHgLbpXCzfl2ZFlVWeieVMhoAeC/w3TViBGnGKz4ZT1DtsSRUbnu5
 77FA==
X-Gm-Message-State: AOJu0Yz4vP3h4Wrd8CNdLjDuXhS2RkdEhf1U8wmnfYMj58Kc/pALIuC0
 6xUWLJ5Bb8jlaQDI3G282JWVrYPV0qR+mP5nj4C5LU+W+H73xavkWDmrmxCmnGDLWxs=
X-Gm-Gg: AeBDiesVoUCA3B7lwG7y5/PvS9BU3vnfDCuPrdDXWGJQRh+LZ6UhbAop6eMxbpyschZ
 OoDzOhfSIrB3wMTGSO2hdByUhMAp/J1hcPDpbXrJBgb7bM5hUd7RVy457otD1mdz0vofzAEX1D7
 WyZixwboQi29eC/t1/jbh8AceABxTBEj+8gHv99gEV4H32demHj5YdzvBxNQu8LpsOhYcfW+7JS
 U26lyfF2/0ahOoWHVV32Jv3UL2M5ncfVVeyoJRerFqCgUGBxD4QBlZJVvLPTG3M2LpKyDoFDVGN
 RJAD7PGzh/7PbdYcOi79AT2TVF1VWQZSCX7HvIBZw1xCzUaxclAxlIB++i2bfFJ3cz8WtBNQslh
 FNfEyudutNzwOxJfRWBW5feJQ+JIeZYvN+56ymR+FQnuHvtXWuS1dqmS9mUml4Hr2j6G2RioFAU
 pzvav8ITKIX8b8r9KRKKt+KygwjQ==
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id
 5b1f17b1804b1-488d685b577mr253416325e9.21.1776258706333; 
 Wed, 15 Apr 2026 06:11:46 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee038752sm133805985e9.9.2026.04.15.06.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 06:11:45 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=808cfbfe81f9daaef4da83087369d61ab9dd21fb557a635b5870f46a2ed8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 15 Apr 2026 15:11:35 +0200
Message-Id: <DHTR5NJO5MQH.HONDAFQS0QJY@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>, "Tom
 Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, "Simon Glass"
 <sjg@chromium.org>, "Anshul Dalal" <anshuld@ti.com>, "Michael Trimarchi"
 <michael@amarulasolutions.com>
Subject: Re: [PATCH v5 12/12] configs: am335x_evm_defconfig: Switch to
 upstream devicetree
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-12-4b9c7aca0e3e@baylibre.com>
 <20260413140029.798645ad@kmaincent-XPS-13-7390>
In-Reply-To: <20260413140029.798645ad@kmaincent-XPS-13-7390>
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

--808cfbfe81f9daaef4da83087369d61ab9dd21fb557a635b5870f46a2ed8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kory,

On Mon Apr 13, 2026 at 2:01 PM CEST, Kory Maincent wrote:
> On Fri, 10 Apr 2026 15:31:52 +0200
> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>
>> The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
>> required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
>> power domain driver is requierd as well now.
>>=20
>> This switches all evm defconfig variants to use the upstream devicetree.
>
> Hello,
>
> This patch breaks the BeagleBone Green Eco boot.
>
> U-Boot SPL 2026.04-00765-g42087b117172 (Apr 13 2026 - 11:59:01 +0200)
> Trying to boot from MMC1
>
> U-Boot 2026.04-00765-g42087b117172 (Apr 13 2026 - 11:59:01 +0200)
>
> CPU  : AM335X-GP rev 2.1
> Model: Seeed Studio BeagleBone Green Eco
> DRAM:  512 MiB
> Core:  201 devices, 17 uclasses, devicetree: separate
> Could not initialize timer (err -19)
>
> resetting ...

Thanks a lot for review, testing and the log. It seems the BeagleBone
Green Eco is missing a -u-boot.dtsi that sets the tick-timer. I hope
that's the only issue, I will fix it for the next version.

Best
Markus


--808cfbfe81f9daaef4da83087369d61ab9dd21fb557a635b5870f46a2ed8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCad+OiBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPv
JgEA1uO8rMzQT0emXUnTIyXxvDuWuaJ4GoXtmZcCPJHSfaUBAKafHaforj5x4i5E
O8NzwKFYqH6DxPAbUklAx6sidSgE
=ibYf
-----END PGP SIGNATURE-----

--808cfbfe81f9daaef4da83087369d61ab9dd21fb557a635b5870f46a2ed8--
