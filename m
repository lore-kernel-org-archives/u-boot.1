Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D35D3408E
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801098410D;
	Tue, 27 Jan 2026 17:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MYioV2XL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6425B84088; Tue, 27 Jan 2026 17:01:27 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762A68408D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-40438380b88so1491657fac.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769529682; x=1770134482; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3o1esGae27cQoI5k9qo2UX5laY9WxfzeTg/GzjLJNg=;
 b=MYioV2XLJYDhVyuINcvfVO+Ffu75yCIU9LEUpMvTTGm19SPn/PRc9nYDxwysZILUmk
 xSWKXez/xEUkfy/VLKyDe0SoYQRJ708shlJmpc4URXkRd/wjUwk4ydDVbLREdNq9ZbXk
 zUyZs5mC4GTlDU0VYer2bdpznVunvP5phKefg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769529682; x=1770134482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3o1esGae27cQoI5k9qo2UX5laY9WxfzeTg/GzjLJNg=;
 b=k7tMZjpY8I0kTV/GDvOypm922+pF7KZOwbajU/ZXplzpApri5VfMPG6M4gUl8XTzCy
 Zo56RZTRAVK5ErWIJQnoItSdY+qDLj/hsYzrxtS3Yi/fRN/MAqF1I4nPm73t1h7SYeDl
 yW/IiJlTUZQztORmBu8U7hJkeOA9ucZQy78vL9PeQ4lVQHDSzestk4k9NwkyP2oMProw
 INEX/B35iyTmrm5OQkkwV/wKA06P6JhmhfhfRgyw4HuIRPGFEtNmVz7zlvXEwg1Plsld
 CnmO6+gd7okM7QFzOYuju2feM2YYHVhqMlDYSZRRsjQCnpb1nLaAU7YzdoSXGjzlwTAN
 LUuA==
X-Gm-Message-State: AOJu0YzsaU+S6L3G2IzErIhpTLnTGw3m7t6D05zDc635eCUAhhm7lwQ+
 FgvL9Ot+3NLc5uIc6xlSEMZxeDx4BTrLpUcrcWVIl5RKbsxSIGZFU//6dBJ3cIfB5SIboHy16Bj
 T7v3p93o=
X-Gm-Gg: AZuq6aJ9Aqi+RTQTYf0wz/ziOrEizrRcwPlWa06Hr9M83D0GZQJ6hy21VAFmnWKyrdl
 /sHOmBciUnPD3Ir41rfi9jwxS7XAHegmKxna5Fl16e/HVUB1v6vXF7D0+HRUMI8am0Y9iSzxxoH
 LgRKUke14+ifn9h5dj9bbcfIuqnwNJkt1t5sTtMWvhN4wV5RcxaW4x/XB/DyDsL5N1OZyjKTLGo
 99/0NSq7pNdL/nWr6UBY6vZBgqXO9QoMEB9GCBp6qZddX79lJckXIiLWL0Njrn7DOsB3m8Ha/IS
 bf3Z9eccLjBTCcxQhJjpbSrSi6Phm2X/Y9qrWcCx56qY6nvl4/+wrYcgo+M0Fr48XZ0oB7Gjy3Y
 EqWbr4lTf+KdsDbXTF9DvN/1VpQNADo8K0Dm/bQRVEFfVy3tow4Wz3902GP2uzYHPBV96FaWuAY
 UcyKfZ7lyiRaSdYD3qH6ScLVWWIe9WDpnxx1HmCQAIjiCwd+65VLhd21Oe/uBdi07Ci8SB9nPlJ
 8hpo+F/0vm52MjnGlJqQXch2u+vfA1UTexFVs0=
X-Received: by 2002:a05:6820:488d:b0:65f:6994:314b with SMTP id
 006d021491bc7-662f21722b0mr938395eaf.76.1769529679481; 
 Tue, 27 Jan 2026 08:01:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409570f63b4sm68979fac.3.2026.01.27.08.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:01:18 -0800 (PST)
Date: Tue, 27 Jan 2026 10:01:16 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.04-rc1 released
Message-ID: <20260127160116.GC3416603@bill-the-cat>
References: <20260126204548.GX3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YthzY9gyCkgJrGo+"
Content-Disposition: inline
In-Reply-To: <20260126204548.GX3416603@bill-the-cat>
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


--YthzY9gyCkgJrGo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 02:45:48PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and I have tagged and pushed things out.
>=20
> First and foremost, this is a bit rougher than I would like but I hope
> that doing the release will underscore the urgency of finishing some of
> these fixes. We now require for our own use to be given a correctly (8
> byte) aligned device tree. This is done in a lot of cases. However:
> https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437-1=
-b-padhi@ti.com/#3640858
> is needed to ensure that platforms that use a FIT image in the SPL phase
> work.
> https://patchwork.ozlabs.org/project/uboot/patch/20260120153314.95091-2-j=
amie.gibbons@microchip.com/
> needs to be addressed further to fix the case of platforms which apply
> overlays in FIT images (SPL or OS). This series also shows that if your
> platform does not boot then SPL_MALLOC_F_LEN may be too small.
> https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.com/
> contains some of the discussion around the case of SPL *not* enabling
> SPL_BSS_SEPARATE and so having an incorrectly sized empty BSS appeneded
> to the image.
>=20
> So, that's the important state of things right now. Some platforms are
> broken. People helping to test the proposed fixes, or if needed, picking
> up the changes and posting the next version of them, would be
> appreciated.
>=20
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYz=
YzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWM=
wNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=
=3D89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group=
=2Ecalendar.google.com&scp=3DALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> January 26th, 2025. 9am (GMT -06:00)

My apologies everyone. I did notice that Google changed the calendar
link when working on this email but did not notice that the meeting link
itself changed too. The call was relatively short and just covered the
above issues, that we hope to move to OSU OSL hosting for infrastructure
soon, and that Marek is working on something for streaming larger files
via network and writing to storage. Also, Marek (and SFC) will be at
FOSDEM if anyone else is attending.

[snip]
> In terms of a rough changelog:

=2E.. this was wrong, and not updated from v2026.01-rc1. A correct
changelog (which I need for the final release itself, too!):

- Lots of platform updates, including but not limited to: TI K3,
  NXP i.MX, STM32, NXP Layerscape, Altera SoCFPGA, various AMD/Xilinx
  families, MediaTek, TI AM33xx, Qualcomm, ADI SC5xx, Allwinner
- Lots of subsystem updates, including but not limited to: EFI Loader,
  Networking, UFS, DFU, MMC, Clock, Power, Documentation, i2c
- Assorted code and testing cleanups
- CI is now running on Ubuntu 24.04 "Noble", and also now supports "make
  allyesconfig" as part of the build. CI now also has a limited set of
  hardware platforms supported again, via the "Sage Lab".
- We have re-synced with upstream dtc v1.7.2-35-g52f07dcca47c and in
  turn now require 8 byte dtb alignment ourselves as the spec requires.
- Much of the legacy LED code is now removed, with just a few more
  things left to verify before final removal.
- FIT image signing with some proprietary hardware engines is now
  supported.

--=20
Tom

--YthzY9gyCkgJrGo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXjhRQAKCRAr4qD1Cr/k
CvTTAQCeyXn6zcP3Azx2rlC0lFrvH+rRUwXopX/EfyYOZkQbVgD+K8RIw2CNyjcJ
fhug1cbPEwnb09KjKrM4/nDFn72g6QM=
=Wbnw
-----END PGP SIGNATURE-----

--YthzY9gyCkgJrGo+--
