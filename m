Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66032C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 15:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5EF2871FB;
	Thu,  9 Nov 2023 16:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="h+IGVnlg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB268721A; Thu,  9 Nov 2023 16:21:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A1D58718C
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 16:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mripard@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699543292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0dHZVAFltTZpwmYGYfD0XNYY1izTLti2XnQcY4oWg0=;
 b=h+IGVnlgnU55GEg22gL6huL9Q/k1TQmjDMmiE75E9g/f7COeY6jdr98gQFVnAUaJB+Pjym
 FolWFyhW609PGwR6t8UVw+B3if3d1RQiZYSk7bhNN+8K76vaDWcujx8H+xy4gpF/d6gtV/
 ThN1cAEs2eHr4LZ32c+rb5USdt2ipEE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-r-NtGuiYOnqgyJ-yyLChww-1; Thu, 09 Nov 2023 10:21:26 -0500
X-MC-Unique: r-NtGuiYOnqgyJ-yyLChww-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so82015066b.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 07:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699543285; x=1700148085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0dHZVAFltTZpwmYGYfD0XNYY1izTLti2XnQcY4oWg0=;
 b=k1TFqbMOgL9/JCqk8FKuMN7ZTaMi7HUT7wP2iS6K4zMaJy2avLYXPGHr1xVe3wbm0U
 JWEvR0Jnj4pDGL58kCTDWM+JtFfnKeI3QShmOfLeeqI0A5fhe8yE769u4Pe9x4g/mbd5
 3c6j6hv8X3LqWs5CkvKZcM5CnBHvssC6z716mq4yBXwIIiCsPJrBYCxNRWuhaVBf4hCy
 /5W+SLp8Y545aAiTR/0HDhcyuv8gEdXH5HZK9qMk/xDG9UJj5RME1Cpl+/zXOaE/53TL
 fzVMeDAtzjQJercNxeDIbPyJpSrHCP+iy2fIOgRGoDD4uaohNdPUtXl4I3BKLQBdHpqt
 7Xqw==
X-Gm-Message-State: AOJu0Yxthy9rErWf7jQc5OmGdD870q/+6huRv9OWpeFDPjNkl7FH2Fjk
 QBk1uMfo6avutFrdzi1hW7/ewSOkHF5jtlLTByete/iLqEjp5OZEZ+ydBItyyEkVamAQlfUNTes
 ex4d+t3nJs+fpvQ==
X-Received: by 2002:a17:906:4fd5:b0:9be:d55a:81c3 with SMTP id
 i21-20020a1709064fd500b009bed55a81c3mr4393342ejw.67.1699543285411; 
 Thu, 09 Nov 2023 07:21:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGydS2/50oBFicE2J38jNoV/m/auba0pr7lRVhW9pBfmtWTySA7ulTumjgn2stQZukz+m69Nw==
X-Received: by 2002:a17:906:4fd5:b0:9be:d55a:81c3 with SMTP id
 i21-20020a1709064fd500b009bed55a81c3mr4393326ejw.67.1699543285053; 
 Thu, 09 Nov 2023 07:21:25 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05600c21cf00b003fc0505be19sm2336005wmj.37.2023.11.09.07.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 07:21:24 -0800 (PST)
Date: Thu, 9 Nov 2023 16:21:24 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Nishanth Menon <nm@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: eMMC broken on SK-AM62
Message-ID: <yrm3rhhpwvwt6pkxtigw6wkotxuwv3cmx2sgbo2l2i3oxeuf2j@qdv35rseuwq7>
References: <hsk5wejuf5maoer3aodjyndmyft56gag4cepfjep7lfthmwrcy@r2yoebb7stk6>
 <871qcz9q4i.fsf@baylibre.com>
 <20231109122303.fakyjjb7df7c7spk@handheld>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ermwwgkbhq5sydru"
Content-Disposition: inline
In-Reply-To: <20231109122303.fakyjjb7df7c7spk@handheld>
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


--ermwwgkbhq5sydru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nishanth,

On Thu, Nov 09, 2023 at 06:23:03AM -0600, Nishanth Menon wrote:
> On 11:29-20231109, Mattijs Korpershoek wrote:
> > Hi Maxime, Nishanth,
> >=20
> > On mer., nov. 08, 2023 at 16:05, Maxime Ripard <mripard@redhat.com> wro=
te:
> >=20
> > > Hi Nishanth,
> > >
> > > I've been trying for the last few days to get an SK-AM62 to boot from
> > > the eMMC user data area.
> > >
> > > I finally got the jumper configuration to make the CPU boot from there
> > > thanks to Mattijs, but it looks like the 2024.01-rc2 release doesn't
> > > support booting from there:
> > >
> > > U-Boot SPL 2024.01-rc2 (Nov 08 2023 - 14:11:12 +0100)
> > > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.5--v09.01.05 (Kool Koala)')
> > > SPL initial stack usage: 13368 bytes
> > > Trying to boot from MMC1
> > > MMC Device 0 not found
> > > spl: could not find mmc device 0. error: -19
> > > SPL: failed to boot from all boot devices
> > > ### ERROR ### Please RESET the board ###
> > >
> > > It looks like you tried to fix it with 0f1c1e8b368b ("arm: mach-k3:
> > > am625: Add support for UDA FS"), but it looks like it's not enough.
> >=20
> > I confirm I reproduce the issue on AM62x SK EVM.
> >=20
> > Beagle play seems to boot fine:
> >=20
> > U-Boot SPL 2024.01-rc2 (Nov 09 2023 - 11:24:04 +0100)
> > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.1--v09.01.01 (Kool Koala)')
> > SPL initial stack usage: 13400 bytes
> > Trying to boot from MMC1
> > Warning: Detected image signing certificate on GP device. Skipping cert=
ificate to prevent boot failure. This will fail if the image was also encry=
pted
> > Warning: Detected image signing certificate on GP device. Skipping cert=
ificate to prevent boot failure. This will fail if the image was also encry=
pted
> > Warning: Detected image signing certificate on GP device. Skipping cert=
ificate to prevent boot failure. This will fail if the image was also encry=
pted
> > Warning: Detected image signing certificate on GP device. Skipping cert=
ificate to prevent boot failure. This will fail if the image was also encry=
pted
> > Warning: Detected image signing certificate on GP device. Skipping cert=
ificate to prevent boot failure. This will fail if the image was also encry=
pted
> > Starting ATF on ARM64 core...
> >=20
> > NOTICE:  BL31: v2.8(release):08.06.00.007
> > NOTICE:  BL31: Built : 11:17:33, Nov  9 2023
> >=20
> > U-Boot SPL 2024.01-rc2 (Nov 09 2023 - 11:24:30 +0100)
> > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.1--v09.01.01 (Kool Koala)')
> > SPL initial stack usage: 1888 bytes
> > Trying to boot from MMC1
> > Warning: Detected image signing certificate on GP device. Skipping cert=
ificate to prevent boot failure. This will fail if the image was also encry=
pted
> > Warning: Detected image signing certificate on GP device. Skipping cert=
ificate to prevent boot failure. This will fail if the image was also encry=
pted
> >=20
> >=20
> > U-Boot 2024.01-rc2 (Nov 09 2023 - 11:24:30 +0100)
> >=20
> > SoC:   AM62X SR1.0 GP
> > Model: BeagleBoard.org BeaglePlay
> > DRAM:  2 GiB
> > Core:  98 devices, 27 uclasses, devicetree: separate
> > MMC:   mmc@fa10000: 0, mmc@fa00000: 1, mmc@fa20000: 2
> > Loading Environment from nowhere... OK
> > In:    serial@2800000
> > Out:   serial@2800000
> > Err:   serial@2800000
> > Net:   No ethernet found.
> >=20
> > Press SPACE to abort autoboot in 2 seconds
> > =3D>
> >=20
> > Note that Beagle Play does not boot tiboot3 from UDA (User Data Area)
> > but from mmc0boot0 so the boot flow is not exactly the same.
> >=20
> > >
> > > Thanks!
> > > Maxime
>=20
> There is nothing complex here - sorry for the late response, Sync DT
> with v6.7-rc1 should take care of this:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/arch/arm64/boot/dts/ti?id=3Dc412c2f26eed08b1836ccf79f5547b67c1b55d5d
> Vs:
> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/k3-am625-sk-u-b=
oot.dtsi#L93
> (notice no sdhci0 with bootph properties)

I backported that linux patch onto 2023.10 and 2024.01-rc2, both work
like a charm.

Thanks!
Maxime

--ermwwgkbhq5sydru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUz49AAKCRDj7w1vZxhR
xQndAP43ID342w+MwSPV/BF4XAlRD1bWG3LVuimsgRzEscy6awD+PDVakdI+9fqi
5dBFbO4sp6vMJqgQObMMz6e3j0VFPQM=
=+pD8
-----END PGP SIGNATURE-----

--ermwwgkbhq5sydru--

