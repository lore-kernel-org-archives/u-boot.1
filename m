Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FF1F43828
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 14:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5760083B99;
	Wed, 15 Apr 2026 16:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ooXP8bXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB09083C2B; Wed, 15 Apr 2026 16:26:45 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A71DE83936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 16:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so51196785e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776263203; x=1776868003;
 darn=lists.denx.de; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NeGl8MxCGZ7p22oMooilcGf9AvB6Q1po0H+owuQT4pA=;
 b=ooXP8bXYKZ4KAzyFiCit7sgs7iTMEaHKv7AqE59TjGOu3EmXPjZE3CGX+KNmhReswI
 yyNjImm0r0LYDGiR1WlUlVxIT5t0LEeO+xTEeVai/ObPeLcHIl3vAlxHxMV374we34pv
 6l1+c1NhFpM0MibKtNG/YpC4pDh6f2g3rlpf+hkVQK7hhTDLhi7K/iCr8CSGpu1jEett
 OzSigh3VHOcvykuo4mWNmlj10Rq/NfrpyqDpC9P5E6ixpd6OltKyIE4O6hL3oKbrGKJB
 Fjx01F0z2P9T7G98gv6axkhfbF1j5OtUj+WtuODNDY3/+YF4i9tYc4+9AmTxlr1DdxvF
 ENMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776263203; x=1776868003;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeGl8MxCGZ7p22oMooilcGf9AvB6Q1po0H+owuQT4pA=;
 b=aV6Z/FBwR1ZAJTMH3HqxLYs2sP+ndIqbLUSH9KbWPGLPbi4WTj0mMJVAtph9J4bpt9
 4+e6LBQAXbzvncmWWFTHfEh5+v+LJ48Fq4Z2m30gf2gwMAyZQ1I+7kiOaIM0a99wE/ma
 imQJ434NwCTwv1/BRhv9G9UEAEQmI4TE1pBub5mZgxntigFsi38H6gkZ6kMsZ8yh8Y8f
 BQ3mGGrXNSkL7UtjhZ6nrdADDsM9xbYg+eT9N4Nf5XRKtpXcrw0srL0A4B6uS+5lyHus
 w5ykmC2v9KlEd7I7AUfUg87TZntnUxJR1uXinZyOoc4HjCpX9JwjjYj0+xyU3fQOR4mb
 2Dng==
X-Gm-Message-State: AOJu0YzXVKgomu2cnhwXbuC4c2FXlBO00DWqlDrmrx73zs9LJgfW1Nb9
 J0WyXeTWGF60iOVhlbQ7FcBg8AyM989dcLjcbHffo/e/csA6e7EHQTv2q7K2DF22mioRi+T7u2P
 kBbvBPNY=
X-Gm-Gg: AeBDietvFbFWlVjTbD5yS0uIo9ouGhYg7ey9iNrAtFpp65F9RuIGbTJX73v61puwrAI
 yQczvf/JYxS8Lnoxxg9Z9bCZ9ayhIv7pNcik1Z0nzOhYVTFGtIsmZ9ZYL1Iey/bMO6mGul6v+uQ
 X2+ROtsPGLCJ7ljLTRhG3TJjzTAES8f4HKuEA7M1zoPEAh6Uc7Y8803VqqUB/qTZRNwDZmywxA7
 LnGV0IOh2uR4UaQ5RqkKWoeqynm1h+60q7y0YfAzytCMkZg1l/fkFcIJJ3eqMA7P26is0EsgVg8
 27rjpaS71CRFkaWIv59vuK0I1D9t/r+QT4szahR/T0ITLzESRj8ohya3FtYGpVDYgyGArQcqK76
 Tns5vEbGvQ/OKEb1IHkVp75F8/lkCTPTbl/ivGBEoeEh1J9ZGdLReNwC66CSG8xS1jneq6cOs7+
 hVLzQ8EvsElMLRVWdhg+zHWPlOjw==
X-Received: by 2002:a05:600c:64c4:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-488d686892emr272409645e9.25.1776263202820; 
 Wed, 15 Apr 2026 07:26:42 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f1e945d0sm65049115e9.12.2026.04.15.07.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:26:41 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b4cf69f32bb091d9a277970d19738ab0ab7cc57023cf92d925e1100f09d4;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 15 Apr 2026 16:26:31 +0200
Message-Id: <DHTSR106A1QA.9PMRZXTZVZ8G@baylibre.com>
To: "Simon Glass" <sjg@chromium.org>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>, "Tom
 Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, "Anshul Dalal"
 <anshuld@ti.com>, "Michael Trimarchi" <michael@amarulasolutions.com>
Subject: Re: [PATCH v5 11/12] dm: core: Split SIMPLE_PM_BUS into phases
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-11-4b9c7aca0e3e@baylibre.com>
 <CAFLszTjbgkiXO_Tj4Whnz6hjo8XzeA9ohoY4vfcq=-4maq8NVQ@mail.gmail.com>
In-Reply-To: <CAFLszTjbgkiXO_Tj4Whnz6hjo8XzeA9ohoY4vfcq=-4maq8NVQ@mail.gmail.com>
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

--b4cf69f32bb091d9a277970d19738ab0ab7cc57023cf92d925e1100f09d4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Simon,

On Sat Apr 11, 2026 at 4:37 PM CEST, Simon Glass wrote:
> Hi Markus,
>
> On Fri, 10 Apr 2026 at 07:33, Markus Schneider-Pargmann (TI)
> <msp@baylibre.com> wrote:
>>
>> Similar to SIMPLE_BUS, create a SPL_SIMPLE_PM_BUS additional to the
>> SIMPLE_PM_BUS. Most boards will not need SIMPLE_PM_BUS in SPL.
>>
>> This is currently needed to reduce the SPL size for beagle bone black
>> with OF_UPSTREAM enabled.
>>
>> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>> ---
>>  drivers/core/Kconfig  | 8 ++++++++
>>  drivers/core/Makefile | 2 +-
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
>> index 5419bf65b5d653464f8bf958382ede30954d6402..0471e2977d0a993afcafee11=
874d43016d6738b4 100644
>> --- a/drivers/core/Kconfig
>> +++ b/drivers/core/Kconfig
>> @@ -342,6 +342,14 @@ config SIMPLE_PM_BUS
>>           Supports the 'simple-pm-bus' driver, which is used for busses =
that
>>           have power domains and/or clocks which need to be enabled befo=
re use.
>>
>> +config SPL_SIMPLE_PM_BUS
>> +       bool "Support simple-pm-bus driver in SPL"
>> +       depends on SPL_DM && SPL_OF_CONTROL && SPL_CLK && SPL_POWER_DOMA=
IN
>> +       help
>> +         Supports the 'simple-pm-bus' driver, which is used for busses =
that
>> +         have power domains and/or clocks which need to be enabled befo=
re use,
>> +         in SPL.
>> +
>>  config OF_TRANSLATE
>>         bool "Translate addresses using fdt_translate_address"
>>         depends on DM && OF_CONTROL
>> diff --git a/drivers/core/Makefile b/drivers/core/Makefile
>> index a549890c22b997a8c3e7cd6ab08b2ed2ac7994b2..1073c26b2ed0009e15ccca0b=
ac93a64d882f0df9 100644
>> --- a/drivers/core/Makefile
>> +++ b/drivers/core/Makefile
>> @@ -7,7 +7,7 @@ obj-$(CONFIG_$(PHASE_)ACPIGEN) +=3D acpi.o
>>  obj-$(CONFIG_$(PHASE_)DEVRES) +=3D devres.o
>>  obj-$(CONFIG_$(PHASE_)DM_DEVICE_REMOVE)        +=3D device-remove.o
>>  obj-$(CONFIG_$(PHASE_)SIMPLE_BUS)      +=3D simple-bus.o
>> -obj-$(CONFIG_SIMPLE_PM_BUS)    +=3D simple-pm-bus.o
>> +obj-$(CONFIG_$(PHASE_)SIMPLE_PM_BUS)   +=3D simple-pm-bus.o
>>  obj-$(CONFIG_DM)       +=3D dump.o
>>  obj-$(CONFIG_$(PHASE_)REGMAP)  +=3D regmap.o
>>  obj-$(CONFIG_$(PHASE_)SYSCON)  +=3D syscon-uclass.o
>>
>> --
>> 2.53.0
>>
>
> I'm assuming that this doesn't affect any existing boards.

I checked the configs that use SIMPLE_PM_BUS at the moment, I don't
think any of them needs them for SPL. There aren't many and none of them
have SPL_POWER_DOMAIN which would be needed for SIMPLE_PM_BUS to work in
SPL.

>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks for reviewing!

Best
Markus

--b4cf69f32bb091d9a277970d19738ab0ab7cc57023cf92d925e1100f09d4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCad+gGBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOE
SgEA6zzMjzKyWsswWDY+sU84up0T6NZpXlHrYY8blvazh9QA/jYvRCmN+3t47by7
lmzE0+pNYG9yTT3R3xerlQe8rBYA
=dJoF
-----END PGP SIGNATURE-----

--b4cf69f32bb091d9a277970d19738ab0ab7cc57023cf92d925e1100f09d4--
