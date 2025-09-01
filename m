Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C030DCA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 14:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97C083965;
	Mon,  1 Sep 2025 16:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="esBgtuT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735EF831B4; Mon,  1 Sep 2025 16:55:04 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876C283990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 16:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-437f7046a7fso1129907b6e.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756738500; x=1757343300; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VFFRBoxau+8v3EEsFwar98E6f32uKP64xIjGKO/Ua2s=;
 b=esBgtuT+xf0lxw4mNRqN63RKU9WwzlnPgsDn2/cOrKn5z+PtBOvekfjpWpX7LF+KrP
 NudifZklD2FTQLgk7X09PZYa54pe0oStNIBYYts4J4dcdVfZwO/iVMfMgNTFGVwZWPW4
 AbThG7nlcAvRtlg1i3rbXRe2IShekHIKKhGak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756738500; x=1757343300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFFRBoxau+8v3EEsFwar98E6f32uKP64xIjGKO/Ua2s=;
 b=HlhJY0lifj/ZicMgfH2dhlP035K0DN9E7F4qe4PRuK83489nwgzC/as+Vbn/boGiZd
 CFzXAvBioUa+oXJig8F3YsntjZeo5+iFtBPjZ2ER5AaT+iuA5gYjU0Zhr/zemZ5kogZ+
 hzmkHYwIpZPqXzc+gK6vsWGkqgwjpzts2WepiXOk66DYce4DfgrZZwc7kIZF5an+KRE+
 2oowWd0TISb/CWv7833yvdrOekSr2FnNYt2zUSS6YDb5W0h/JGOThM0ENwpV8a2etsnQ
 vaLsGWdsQbMzweV6g1T4BshTcqkTXimhNazV8/uJOcpXVVrxGC7UeWLyTGdCY6eKTD9u
 B3Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3hQ1Ll8W/tIGkdsLX3mkg7FBpcS3ugrvm06ftncuq3sjJVgjF5g8DgWHXvscjZJ/Rl1eJO5Q=@lists.denx.de
X-Gm-Message-State: AOJu0Ywn9ZbcEd0wuVSp7/B5rk880I6fessBuDdIC/9Vo/RndAls3Kgq
 5Sl4cr0iSOocY80ZXkLUu+6FixsD3aql24SVm3DhflEi2oEQljwQf/LEV4nQTbfz1MY=
X-Gm-Gg: ASbGncsjihQ4qjBn0M+3jXHv7lGTF8+HdmH46S3v0atYP0SZ4oHeFqh5ySUcKlyOBOL
 UkPY10SEogbX4hoIILIF++MoXCB/uv07lR4CyMBG3S6rR9+bPl3ICU1dU5LBlQ4Une1wxwKZObl
 nxtWEY+sTUP8W6hBaRmB8nKy/9pN9wbEstXz9cl4fX+5aEtsNwcmNHZ9X/bl3Q4GyhgStoVKq8T
 XT8RdEQg4HfcbzIbLN0NwWzMaabhkhNqThzCgbJpSUHAc4UcpbSCX4FGxvMBbC+aEMmRaYF0RcQ
 /0UAYAs8B8L4EN2nQ6QDnbEtfcULFOYJxJz5Y1Tj3VnfmLc/eeEAT28SyN4KSFYcPh5bqDZn7TS
 EM3m+MK4Fz1eyKuN3JNJXrf/KNGW63IwvdHHEoNSXNxqRAl4k4kg9VRuN
X-Google-Smtp-Source: AGHT+IGBcG9Bsp6hoRUcSfRz8eVFbiOUwE+/CIC22z5s8LiGj+bxkuDKvNShzmPKUl6+xA8XyO3M4g==
X-Received: by 2002:a05:6808:2f0d:b0:434:ecc:a922 with SMTP id
 5614622812f47-437f7cd7470mr3498872b6e.6.1756738500074; 
 Mon, 01 Sep 2025 07:55:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-437ffea7d07sm919834b6e.1.2025.09.01.07.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 07:54:58 -0700 (PDT)
Date: Mon, 1 Sep 2025 08:54:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull mmc-power-next-2025-09-01
Message-ID: <20250901145456.GA124814@bill-the-cat>
References: <20250901050359.GA31200@nxa18884-linux.ap.freescale.net>
 <6c8ae3a7-858c-4d1c-8e05-9f7ad766bd93@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nn6qvs2mTttiP2O2"
Content-Disposition: inline
In-Reply-To: <6c8ae3a7-858c-4d1c-8e05-9f7ad766bd93@kontron.de>
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


--nn6qvs2mTttiP2O2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 08:52:32AM +0200, Frieder Schrempf wrote:
> Am 01.09.25 um 07:03 schrieb Peng Fan:
> > Hi Tom,
> >=20
> > Please pull mmc-power-next-2025-09-01
> >=20
> > ----------------------------------------------------------------
> > Update compatibles for PMICs used by exynos devices
> > Support system reset and reset status for pca9450
> > Fix for pca9450 LDO5 registers and drop deprecated sd-vsel-gpios
> > Two minor fixes found by smatch
> > ----------------------------------------------------------------
> >=20
> > CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/275=
36
> >=20
> > Thanks,
> > Peng
> >=20
> > The following changes since commit c9ffeefeb3efedd754e3ffa3440bfeb15cea=
00c3:
> >=20
> >   test: Update logic for video test (2025-08-31 09:32:17 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-powe=
r-next-2025-09-01
> >=20
> > for you to fetch changes up to 140562d3a2b447079499d773a7d21ec1728692cb:
> >=20
> >   mmc: core: drop space before newline in trace printf (2025-09-01 10:3=
3:10 +0800)
> >=20
> > ----------------------------------------------------------------
> > Andrew Goodbody (2):
> >       power: regulator: tps65910: Cannot test unsigned for being negati=
ve
>=20
> The change above has unresolved review comments and IMHO it shouldn't be
> applied as is. In patchwork the status is correctly set to "Changes
> Requested", therefore I would expect it to not be included here.

Yes, sorry Peng, I was just expecting a PR of power-related changes for
NXP (layerscape and iMX) related things, not everything that's
outstanding in Jaehoon's queue. I went through it over the weekend too
and marked that one as Changed Requested but applied the rest of the
series, for example.

--=20
Tom

--nn6qvs2mTttiP2O2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLWzvQAKCRAr4qD1Cr/k
CoctAP0ZdeYpVvL8bvdYTgKrD5Cvu5YfMmranp8ASCQvrNVnVwD+KNiyKffuTkMX
vt9dM/+3cuVF7QRVqjKdtI0UZCiR/gA=
=GvSq
-----END PGP SIGNATURE-----

--nn6qvs2mTttiP2O2--
