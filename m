Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EF7CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F8083A5C;
	Wed,  8 Oct 2025 18:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tfgXVUkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB26A83A61; Wed,  8 Oct 2025 18:28:15 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4969683A5C
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7a7d79839b2so19545a34.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759940892; x=1760545692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IH+efmJnXZpHCGhTpmkS5GPrYQ5ckulI3ISPYjDFfBo=;
 b=tfgXVUkEwlCnV7vg3GhiQlNmYtMNSm1iEVodWE2XON9+6b/7ObQL88jtkvZPyIeWB/
 zpHl6YakKsPKMAV6+4IurBu55rlG7gnGyzmp0gIoPZIaRgnqLGpLA7p9jMNqOTiXw3wT
 8bb9hUZjs+hKtvi6sMRqtC8vcyrRgU2D8SU8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759940892; x=1760545692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IH+efmJnXZpHCGhTpmkS5GPrYQ5ckulI3ISPYjDFfBo=;
 b=pTn9ei72O/PBnVOM1/ln5aFyQtlkWhhFDSzmJy1/M8rJOqh+QqSkyjdgoWrJJYEUuC
 FvRT/jfdnVIGjaoeojN56VF36sdZozJNBMWXBThqtuwcqJRcYWbvJxMhs5llFQH4E8nI
 ohHZf8B9HfdOUC/hnqrjAL74QpuEMKd94z58bV/j23Gfll/jgAEGXCySKg6+6SOOVXvn
 dNIq5vWN8PvlYHYHn9HF56otcdjAVDe0lZXrlrrklmdikhw+M+w+Tg7i/H5JzMdGqK3/
 nVqaA8V3dapyYPAaUp90DpHfyOUJH534RnNCeBXCYAC/9MqvJfM+ZSrfDQDL6DrQVBdI
 Z3jQ==
X-Gm-Message-State: AOJu0YxfVvoABNDtrbZkkBBdEYklc6hXcOKYUGNA1Y6rAUeVu9ckYvcI
 YjI39LKCE1n9bHn9sYo8Gydn2sqvMUARd9IcKlHmNk/d4+FcucrgINzCELce5nIZJCw=
X-Gm-Gg: ASbGncvQS3rmvE6kw48hUD1cG7ccO6DlAZj5p/qHPt7dkczlToTujmx2Kpd2972ARwE
 XtZVrpVQ8HoPAjwVoLFkduIn4X0LJW36WKnacSpLZsKgZV1waEfVVaFPukRGh60HmowMV4AyBz/
 zVHV/izVt21GDFv07JB55xK9OZYn0DISaKBqpwotV4RqI1LYh7RQ2hOX2YQv6Dbbx8iOhSPmfGP
 Wj1QLVssKhBvnbHAoFnq22ayG6TbSJvxQQjH6oDaQAiAMlPivWJmKtLL0WTXOodVq7uATFYyuE2
 99CPxkOnzELbIRg/5fudK67DbNEfi4onWscPoB3TKaqDKk2wQ7nFNCXxGZCN8iYJehP5KEvb3M4
 UfFHetqkiuxCI4REMka/ddy3CwaXzly0Pa2Oxgv5z+DSyIWnVdJn8vm4M9/js3tGMyXl4Ngbg1g
 rK9oTLTUVB+Q==
X-Google-Smtp-Source: AGHT+IHmaZ1SNB+ljuHyklhV8HcNNgt1tuOa9T37lZE3MLMHbAdPT/6ULLCKwPMZvkrx7kyAhs2/rw==
X-Received: by 2002:a05:6830:3c8f:b0:756:7eb7:ea9b with SMTP id
 46e09a7af769-7c0df7e4364mr2029406a34.19.1759940891914; 
 Wed, 08 Oct 2025 09:28:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e5b04ccabsm3698565eaf.22.2025.10.08.09.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 09:28:11 -0700 (PDT)
Date: Wed, 8 Oct 2025 10:28:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
Message-ID: <20251008162809.GB298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
 <20251007181356.GO298503@bill-the-cat>
 <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
 <20251008143415.GU298503@bill-the-cat>
 <CAFLszTh=jWE0pefvXCpxvBZUtWWuJVem7f5HsYeJU1C7dkvq+g@mail.gmail.com>
 <20251008145734.GX298503@bill-the-cat>
 <CAFLszTjTOU1J=JPzDj-VV+mrewwAG4i04e22WQ+pKU-gND1pBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P9I2btZqya3i+HC5"
Content-Disposition: inline
In-Reply-To: <CAFLszTjTOU1J=JPzDj-VV+mrewwAG4i04e22WQ+pKU-gND1pBA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--P9I2btZqya3i+HC5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 10:20:43AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 8 Oct 2025 at 08:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 08, 2025 at 08:45:54AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 8 Oct 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Oct 08, 2025 at 06:53:44AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 7 Oct 2025 at 12:13, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > At present when one bootmeth fails on the final partition, th=
e next
> > > > > > > bootmeth is not tried. Adjust the logic to go to the next boo=
tmeth,
> > > > > > > which is the more natural behaviour.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > My feedback on v1:
> > > > > > https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-the-=
cat/
> > > > > > was that we need to do a documentation change when doing a beha=
vior
> > > > > > change. And I cannot recall if this change here is because of r=
eports of
> > > > > > problems or not.
> > > > >
> > > > > This is a long time ago, but I think it might have been an
> > > > > inconsistency that I found myself. Otherwise I would probably have
> > > > > mentioned the person who reported it.
> > > > >
> > > > > The documentation already implies the logic in this patch, as I s=
ee
> > > > > it. But please suggest any changes.
> > > >
> > > > OK, I guess it's because the commit message doesn't explain the bug
> > > > clearly enough. Is this a correct description of the patch:
> > > >
> > > > At present, normally when one bootmeth fails on a partition, we mov=
e on
> > > > and try the next bootmeth. However, this was not the case for the f=
inal
> > > > partition due to a bug. Rework the logic so that all partitions are
> > > > treated the same.
> > >
> > > We can certainly say that if you like. It is fair to say that the
> > > algorithm is still being evolved as new things come up. Most of the
> > > behaviour has been driven by new tests that I've written. The global
> > > bootmeth is the biggest change since hunters were introduced, but I
> > > suspect there will be more in future.
> > >
> > > I'm heading out later today but can probably send v3 series (with the
> > > tweaks you've given) tomorrow. After that I'm not sure as I'm on
> > > holiday for two weeks.
> >
> > Peter's feedback should be addressed too for a v3 (and not just set
> > aside).
>=20
> Is that the email just received, or something from a different series
> that I maybe missed from a while back?

It was yesterday:
https://lore.kernel.org/u-boot/CALeDE9Ovemog2AGN_Li8Ju12QKHOC0D30V2=3DKG00f=
0KsQ5aPkg@mail.gmail.com/T/#m34f6e2c51fdfb275ba9930bfdc2ff349ee542b51

--=20
Tom

--P9I2btZqya3i+HC5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOaRGAAKCRAr4qD1Cr/k
CsGVAP0UCnyzQJABSky+fxf9prvikxNxtZXoA23Gv+oYtNicDgEA7KlZj0cJuPwt
BY95yYEI21bgRV5Pc+trZkKRxpOeZwQ=
=rzxM
-----END PGP SIGNATURE-----

--P9I2btZqya3i+HC5--
