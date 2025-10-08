Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4861CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 17:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C64583927;
	Wed,  8 Oct 2025 19:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cCdUyn0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06F583948; Wed,  8 Oct 2025 19:48:17 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3AA8391B
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 19:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7bdfbc6ba5cso51686a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759945694; x=1760550494; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TB/KjrLsAKLYmOnf3lbNfN+A9Q/fjmNhqF4XS6DEQ1E=;
 b=cCdUyn0tmH9QWx2g5z1fbcWDdu3Y/lFOnEX0cedxEP1aXUNPjgCAgzGAq5q3PUOL53
 YmwUGkD232TXTdtMQynmnNL+3eHzB/nL+7/Zowf55mGD09jlZbb82VFM5ah1+P9ZW3H4
 RPwdlsKr7LnKge99mr91afieq1yN61I81kyBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759945694; x=1760550494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TB/KjrLsAKLYmOnf3lbNfN+A9Q/fjmNhqF4XS6DEQ1E=;
 b=aRQg+qR+vHqrgCkKjMsnB+YuXMiucstl90Vp5v9k/NMbAlm+OHbsqQkxgH35khB0eQ
 Rc0Mh7pIZHsRxskbVmAvt9WVGPwt4MvjUnyNhicAEc7b68Q+Y0bovzQtb/wS5m4e08sm
 Y98xeNVLniSGlSIMtE8Pp6Q0vl3X+ApLDz9kMzmTT2SnaXUw788w1fhwevlFlu0DZbZJ
 hYZitqVW3Asost1zDmduC5nts2Jbg1TRrFfdnOendMnwbOp8pIyC/1eAuP1qTkfEGLRk
 Byh/ABpSwBNbq5MJ8KIIgYqdsHbaHUBDRmZm5QJyvXkgprqpMvymkMf1JYbqHJWdChKW
 zdRA==
X-Gm-Message-State: AOJu0Yyz+xfcrMg1nLqNtev9f0SmGb7p+PvG5imnohqXE/hSJyxRTTnO
 jnkrC5QhtKGk7Zi7dLyWsGcdRytSWZue2vfwTcWXA9Obbgcy4LedbdrZmTcV0dPMDTjBxem7fyD
 3GovQJaA=
X-Gm-Gg: ASbGncuVS5wCIYLIj08ZOyTsWVQ3IcaluNDEc7nu7peTjqdwI+R1Ohx0EYy273rTyrN
 DVHVitXJUqgsmruhUNNiz9dOJxNOSTUH4fFdxdd+YSTQwRwalp7DHRXXFw9VSFdmiB5oIfLTUmM
 pKOC+vW6gJEArPxPq/YXCn9IJPl0Nmj8dSQWCY5F78eR0LCRlfEsXJvR7O2UL2N2hHsg3XL+33s
 rP8CCq9Sw5B7sjefTTvuBSM3DlOT4QOyI3u1498R5Yj6r3h/6Fbh3P2QyanezMysVMLuQKEml2l
 NKDx5WHZ+mdt6rq4LG6YfnawkkbkZ4oftM6NnuEyvzhDAfIJyWnGuzqPBnJHJnuAIS01UJt8MNd
 T/s2kRX27H2k9O6rVbxRFmoFQSajXusAqswH2isGS5VPj1oel8BcqvCKppMslKuS6JM6AOvx2S1
 oU/78q/yGDsCMdrvTb/YeM
X-Google-Smtp-Source: AGHT+IEx/7aoBWNXlTubO03gO5X2n7q/aiehBpmWKQuiLfq+VNpDDWZrU8fAQZjEqbDmnhXV4TC8Qg==
X-Received: by 2002:a05:6830:3591:b0:744:f0db:a1a6 with SMTP id
 46e09a7af769-7c0df7e9962mr2595820a34.34.1759945693807; 
 Wed, 08 Oct 2025 10:48:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf435edd9csm6003390a34.34.2025.10.08.10.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 10:48:13 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:48:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
Message-ID: <20251008174811.GF298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
 <20251007181356.GO298503@bill-the-cat>
 <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
 <20251008143415.GU298503@bill-the-cat>
 <CAFLszTh=jWE0pefvXCpxvBZUtWWuJVem7f5HsYeJU1C7dkvq+g@mail.gmail.com>
 <20251008145734.GX298503@bill-the-cat>
 <CAFLszTjTOU1J=JPzDj-VV+mrewwAG4i04e22WQ+pKU-gND1pBA@mail.gmail.com>
 <20251008162809.GB298503@bill-the-cat>
 <CAFLszTjCqi8U7s8NgGq+ZpXf-Cqe3=fK2rLTY1UVMHqvkyrvDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GvVkzW7SGVkuIzmP"
Content-Disposition: inline
In-Reply-To: <CAFLszTjCqi8U7s8NgGq+ZpXf-Cqe3=fK2rLTY1UVMHqvkyrvDw@mail.gmail.com>
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


--GvVkzW7SGVkuIzmP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 10:52:17AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 8 Oct 2025 at 10:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 08, 2025 at 10:20:43AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 8 Oct 2025 at 08:57, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Oct 08, 2025 at 08:45:54AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 8 Oct 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 08, 2025 at 06:53:44AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 7 Oct 2025 at 12:13, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > At present when one bootmeth fails on the final partition=
, the next
> > > > > > > > > bootmeth is not tried. Adjust the logic to go to the next=
 bootmeth,
> > > > > > > > > which is the more natural behaviour.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >
> > > > > > > > My feedback on v1:
> > > > > > > > https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-=
the-cat/
> > > > > > > > was that we need to do a documentation change when doing a =
behavior
> > > > > > > > change. And I cannot recall if this change here is because =
of reports of
> > > > > > > > problems or not.
> > > > > > >
> > > > > > > This is a long time ago, but I think it might have been an
> > > > > > > inconsistency that I found myself. Otherwise I would probably=
 have
> > > > > > > mentioned the person who reported it.
> > > > > > >
> > > > > > > The documentation already implies the logic in this patch, as=
 I see
> > > > > > > it. But please suggest any changes.
> > > > > >
> > > > > > OK, I guess it's because the commit message doesn't explain the=
 bug
> > > > > > clearly enough. Is this a correct description of the patch:
> > > > > >
> > > > > > At present, normally when one bootmeth fails on a partition, we=
 move on
> > > > > > and try the next bootmeth. However, this was not the case for t=
he final
> > > > > > partition due to a bug. Rework the logic so that all partitions=
 are
> > > > > > treated the same.
> > > > >
> > > > > We can certainly say that if you like. It is fair to say that the
> > > > > algorithm is still being evolved as new things come up. Most of t=
he
> > > > > behaviour has been driven by new tests that I've written. The glo=
bal
> > > > > bootmeth is the biggest change since hunters were introduced, but=
 I
> > > > > suspect there will be more in future.
> > > > >
> > > > > I'm heading out later today but can probably send v3 series (with=
 the
> > > > > tweaks you've given) tomorrow. After that I'm not sure as I'm on
> > > > > holiday for two weeks.
> > > >
> > > > Peter's feedback should be addressed too for a v3 (and not just set
> > > > aside).
> > >
> > > Is that the email just received, or something from a different series
> > > that I maybe missed from a while back?
> >
> > It was yesterday:
> > https://lore.kernel.org/u-boot/CALeDE9Ovemog2AGN_Li8Ju12QKHOC0D30V2=3DK=
G00f0KsQ5aPkg@mail.gmail.com/T/#m34f6e2c51fdfb275ba9930bfdc2ff349ee542b51
>=20
> OK, I replied. Would you like me to send the 5 separate patches he
> mentions as a separate series?

I think given what Andre said on the call (and that he'll test v2 to see
if it addresses things) and what you said to Peter now, there's some
misunderstandings of what the issues are still. So yes, splitting just
those patches out to start with (and not reposting the rest) would be a
good next step.

--=20
Tom

--GvVkzW7SGVkuIzmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOaj1AAKCRAr4qD1Cr/k
CuePAPwL1DxC53QzeSc0Y4d9iqW+ptMc4FTnVn5NMpIkcTGTkwEAico0KXeNXj+X
Q2Y+0KDGBjVPUlfj9/Pbzr6MiAb92gA=
=jbuH
-----END PGP SIGNATURE-----

--GvVkzW7SGVkuIzmP--
