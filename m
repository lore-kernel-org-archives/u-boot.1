Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C064BC9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D771C83B5E;
	Mon, 12 Jan 2026 14:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KPi5B3ME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B4E83D07; Mon, 12 Jan 2026 10:41:16 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B03483CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8722834679so66264366b.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768210873; x=1768815673;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QSi40K8spaEjs8SF1qOXCb7DR44WpiqJm/ebXKiJ9j8=;
 b=KPi5B3MEFGZGz4qEIELyONAxuML1/JKNzFUYUU2okbnV2dRPVG46tnGQGMfV0rSXzk
 VM8C03d0iyJFlcYB3sHXzyafJq5C+mw/kwKHi3cj3pyUj7748M+hsD89dTFmEXKr/8tG
 PGbe6wza1fm/Avm2U0Dc23rTPs5AWnYL3ZtsodeDF6QAw6914ivO7LBJFu9SCf729lo1
 uFmmqGnzjEqEgm5VqKvLbPO/9mFI/lJUA883X01X7GKy7xx+nTcCDeKq35xNsa/R0pOD
 dIhOLrSukEH4PiZTXpF6m4qPrXSgJDPhaOV6csL1JPHJpx+VpbKoUcLQoBeh/OfCQsDH
 yi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768210873; x=1768815673;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSi40K8spaEjs8SF1qOXCb7DR44WpiqJm/ebXKiJ9j8=;
 b=Y4zdkiXgautBsrqia0MYQEzKfBqLnbRDXfMuWZ2cD0NcCJC4r59z+vuObjXJL7O4fG
 1rL/lKt/ywn2svQjomBw5tSfXRBSbMvVe5OszY7y8cXNBZ2I4d+i1Cys01k5AMYjwA2M
 1x8G7IH2QEfczxewCRVeocx+YovQKAY6JbMB7w+fU9fi94ENeRzjpW1R/0eDqscGOwb3
 0FVDsDecC+H9xFSb+/GPYTemGx65ZRB4FBIsVSHaPMLzU3Y/nbCEscg4YVRQab4er+bI
 pNnzZMS01EpbY8xHZBJQhWp0LmLywONmgNbeY6WXglGG1G+zO3+d1QbI+LghczLW5A1m
 wSZg==
X-Gm-Message-State: AOJu0Yx6Fb4CbxJahr5PYjCMUtwRco7BdwtRQlnY48mAKIUYAYSwXYFd
 3i+G98cGmI7C3guVdrlaELmTQLN1Je3TWto3Mrt4RNbi3xoxkREpK0XXMCXaIqxJl6A=
X-Gm-Gg: AY/fxX5guueL7rgU+Ddn1WKfbaOuyC7iyS5HXRn+kXtIStVeNt00fz3Oy3eW4/FfsaJ
 nJUBHXbzmbCUO8KYTpcxPCro3aD8jlG4StQDmCvsGXXSddVpiCYc4hSqoGefOTeOJaBMGh0ryQC
 CY/EgQlIyco1WpjWNfxWaH2OM5rwPGTpOHHYz5ORbD2mLp/4lLPKN1a9ASh3X5pA/Y+SRnnvMZx
 E15djgBmm0B8c7nUGzEzgK8fD19G3Llij70wf1JtG9jF6RvsF2yI8G8fiGb2jSsaRYui7wcEwlK
 UlkAtml5cTts7QcVG6NbdT8JBL7sqxQyFqwVtbg+kKqv5o4H8FbDv1m7CqDBicYSHKZRaShuQcI
 vFbcIYxw9fIGw8E73XLZtaxkI946lyfntDFgleSO41QaI7/3HHvLdbaDJH1yPJen4LeBMnk7WBM
 8cyvg=
X-Google-Smtp-Source: AGHT+IF/kNeLm9g/lYkS5s/Egi0EhOyJpoiojbhkgpmpgo02Ln8X30r3gSPCdZabo1HNwh0dxILjPg==
X-Received: by 2002:a17:906:308a:b0:b86:ef1f:6d19 with SMTP id
 a640c23a62f3a-b86ef1f9987mr452663066b.59.1768210873261; 
 Mon, 12 Jan 2026 01:41:13 -0800 (PST)
Received: from localhost ([195.52.31.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm591387466b.30.2026.01.12.01.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:41:12 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=271058f774bd6ad13b9e4c07a3ff1c23d6447a8e660ed1252a70325ff526;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 12 Jan 2026 10:41:06 +0100
Message-Id: <DFMIFU4BOO56.2JLE2KW94BW4@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Mattijs Korpershoek" <mkorpershoek@kernel.org>,
 "Tom Rini" <trini@konsulko.com>, "Marek Vasut" <marex@denx.de>, "Andrew
 Goodbody" <andrew.goodbody@linaro.org>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Christian Marangi" <ansuelsmth@gmail.com>, "Dinesh Maniyam"
 <dinesh.maniyam@altera.com>, "Heiko Schocher" <hs@nabladev.com>
Subject: Re: [PATCH v2 3/6] dm: core: Support multiple drivers with same
 compatibles
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Simon Glass" <sjg@chromium.org>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
 <20260108-topic-musb-probing-v2026-01-v2-3-2a47c6e0e73a@baylibre.com>
 <CAFLszTgEbo8c7_wm4DRZ-R36Pj_R6YsYx+4Ug_-SGv9zUSz0_w@mail.gmail.com>
In-Reply-To: <CAFLszTgEbo8c7_wm4DRZ-R36Pj_R6YsYx+4Ug_-SGv9zUSz0_w@mail.gmail.com>
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

--271058f774bd6ad13b9e4c07a3ff1c23d6447a8e660ed1252a70325ff526
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Simon,

On Fri Jan 9, 2026 at 12:36 PM CET, Simon Glass wrote:
> Hi Markus,
>
> On Thu, 8 Jan 2026 at 04:17, Markus Schneider-Pargmann (TI.com)
> <msp@baylibre.com> wrote:
>>
>> Currently once a driver matched the compatible string of a device, other
>> drivers are ignored. If the first matching driver returns -ENODEV, no
>> other possibly matching drivers are iterated with that compatible of the
>> device. Instead the next compatible in the list of compatibles is
>> selected, assuming only one driver matches one compatible at a time.
>>
>> To be able to use the bind function to return -ENODEV and continue
>> matching other drivers with the same compatible, move the for loop a bit
>> to continue the for loop after -ENODEV was returned. The loop had to be
>> adjusted a bit to still support the 'drv' argument properly. Some
>> simplifications where done as well.
>>
>> This is required for ti-musb-host and ti-musb-peripheral which both
>> match on the same device but differ based on the dr_mode DT property.
>> Depending on this property, the driver is either UCLASS_USB or
>> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
>> function and returning -ENODEV the other driver can probe instead.
>>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  drivers/core/lists.c | 65 ++++++++++++++++++++++++++-------------------=
-------
>>  1 file changed, 33 insertions(+), 32 deletions(-)
>>
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
>
> I would like to see some discussion about performance here. It seems
> that all you are doing here is not exiting the loop early, so the
> impact should be small?

See inline.

>
>> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
>> index 9d1ca38212ee7f53b8894f964f096611c8ec20a5..3d9f9bc93954efdd624dddb1=
833f3a855c3c28de 100644
>> --- a/drivers/core/lists.c
>> +++ b/drivers/core/lists.c
>> @@ -235,50 +235,51 @@ int lists_bind_fdt(struct udevice *parent, ofnode =
node, struct udevice **devp,
>>                 log_debug("   - attempt to match compatible string '%s'\=
n",
>>                           compat);
>>
>> -               id =3D NULL;
>>                 for (entry =3D driver; entry !=3D driver + n_ents; entry=
++) {
>> +                       /* Search for drivers with matching drv or exist=
ing of_match */
>>                         if (drv) {
>>                                 if (drv !=3D entry)
>>                                         continue;
>> -                               if (!entry->of_match)
>> -                                       break;
>> +                       } else if (!entry->of_match) {
>> +                               continue;
>>                         }
>> -                       ret =3D driver_check_compatible(entry->of_match,=
 &id,
>> -                                                     compat);
>> -                       if (!ret)
>> -                               break;
>> -               }
>> -               if (entry =3D=3D driver + n_ents)
>> -                       continue;
>>
>> -               if (pre_reloc_only) {
>> -                       if (!ofnode_pre_reloc(node) &&
>> -                           !(entry->flags & DM_FLAG_PRE_RELOC)) {
>> -                               log_debug("Skipping device pre-relocatio=
n\n");
>> -                               return 0;
>> +                       id =3D NULL;
>> +                       if (entry->of_match) {
>> +                               ret =3D driver_check_compatible(entry->o=
f_match, &id,
>> +                                                             compat);
>> +                               if (ret)
>> +                                       continue;
>> +                               log_debug("   - found match at driver '%=
s' for '%s'\n",
>> +                                         entry->name, id->compatible);
>> +                       }
>> +
>> +                       if (pre_reloc_only) {
>> +                               if (!ofnode_pre_reloc(node) &&
>> +                                   !(entry->flags & DM_FLAG_PRE_RELOC))=
 {
>> +                                       log_debug("   - Skipping device =
pre-relocation\n");
>> +                                       return 0;
>> +                               }
>> +                       }
>> +
>> +                       ret =3D device_bind_with_driver_data(parent, ent=
ry, name,
>> +                                                          id ? id->data=
 : 0, node,
>> +                                                          &dev);
>> +                       if (!drv && ret =3D=3D -ENODEV) {
>> +                               log_debug("   - Driver '%s' refuses to b=
ind\n", entry->name);
>> +                               continue;

So for performance this continue is the only new way to continue this
loop which wasn't done before this patch. And that only happens when the
driver returns -ENODEV. All other ways through this for loop below
return in some way. On error we return, on success we return 0.

Finding the right driver has the same continue and exit conditions as
before.

I will add a short paragraph to the commit message as well.

Best
Markus

--271058f774bd6ad13b9e4c07a3ff1c23d6447a8e660ed1252a70325ff526
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaWTBshsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNY
CgD9HkBIDYOA0pN2dhClH5IhBGyB7Ha1DbqhJKLahkRSAU0BAPyO7NIAdzDMDFBD
0oA3xQavehPdOdDQMGmHDk0OnW0P
=InpL
-----END PGP SIGNATURE-----

--271058f774bd6ad13b9e4c07a3ff1c23d6447a8e660ed1252a70325ff526--
