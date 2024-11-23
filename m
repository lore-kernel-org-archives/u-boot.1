Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B9EE6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55247893A7;
	Sat, 23 Nov 2024 03:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KmIVZL7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B50893A7; Sat, 23 Nov 2024 03:40:55 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421EC893AA
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b14554468fso173570485a.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329652; x=1732934452; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfuqkBYVVPo8ysNMwqCrIReT/ROxcrz6t99+RYZxAhc=;
 b=KmIVZL7MrM1HAJ5E9kcQiyN/W3/gnAGqx8+ji/DGrlISkba2Crrzd3s/76N5IJ2cvg
 oHO7JZCbdV0Z4LnhFsk+S9HctW4yoVI5omUDAY2y2YtlZZ73WNFQfFY46VtwB5QW0jAF
 37VQbhj/8fpdKzZDtGZvUWuJYu1Dax+4B+eCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329652; x=1732934452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfuqkBYVVPo8ysNMwqCrIReT/ROxcrz6t99+RYZxAhc=;
 b=MBi1DrmlrGC8BaiY+17IttOQz2koMOct+66RM4Y3r2CFvVS9H9OhSXaYUHWc9a/+/I
 GQyEc7iHSPOltd+wHvZY1vUrzfCGXfSFX3SVyFmNIQDxTJNS/hlXRjIRcOLZ8jIOWWfg
 ZMTJPBk/XO4JKLUU8m2LBpzZXUqql9Ehxh+qDULNhT/lIWZEt0rfueWGqDa5GV41U5XS
 YfiYPXV2HvblEKLjIF+9b/mOXcm/giApgFEZ5fT6vjZdidulSiW0avHq15SAVb9G+zc9
 gcb9alqqPZLVyDrTa2g80HKNlXJQVCAPjH6WlNFVH0gi5nOEK6pufqI9dgDDS+5rUFXB
 jXNQ==
X-Gm-Message-State: AOJu0YzPmx4cR4JQ9M7FjJQnU52wuUvJEGEA5AcRsPpZSNETFryqTRPt
 1IluJ3Bkr+Jk24TXfY6sX8i1Y4EpW40nEfzPSmd8LVIG/TVrdsM5FbSquU5Cdn7Gnd84hLDcrcF
 3
X-Gm-Gg: ASbGncsWvxllulof6FjYh+GVrwxhUW+LHf3FOB76HdEsYn//14MQiSpmnZ/O8yCu31t
 HvmNokF+BgSF8jZiukgMh7Lbedg908HDk9UAhfEDlFoSJM8zPQVaiP0JKt9ElBc9qJOoWQkVyIT
 sYJOKrZd3WffyWWo2silE4d77FTyL5KMcTZpUFbws0LgsWUCBwpKAbeWgbg+OFrrQItOWj2Axxo
 QLlJREmPjkqW1LYsTB3SNaZic0x2nIZGqbJoRGhSukSNRui3w==
X-Google-Smtp-Source: AGHT+IHCDl7pZGj72sii5RB5X9RHzAEsvsE91ezlucOJDR++oNK06GVHqaT/5kidN0u4kcPFB+kUiA==
X-Received: by 2002:a05:620a:1925:b0:7b1:ae59:47c4 with SMTP id
 af79cd13be357-7b5144df608mr497431985a.2.1732329652074; 
 Fri, 22 Nov 2024 18:40:52 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e8esm17131776d6.86.2024.11.22.18.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:40:51 -0800 (PST)
Date: Fri, 22 Nov 2024 20:40:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot <u-boot@lists.denx.de>
Subject: Re: Odd error with cn9130, asix88179 and xhci
Message-ID: <20241123024048.GK3600562@bill-the-cat>
References: <CAFOYHZCwXSChH_rH251cUp-bgwai+e8xrOuqxepX9Dur2wGTJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/FRT0Z5PxfOlcatt"
Content-Disposition: inline
In-Reply-To: <CAFOYHZCwXSChH_rH251cUp-bgwai+e8xrOuqxepX9Dur2wGTJg@mail.gmail.com>
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


--/FRT0Z5PxfOlcatt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 11:29:43AM +1300, Chris Packham wrote:
> Hi U-Boot,
>=20
> We've hit a weird problem at $dayjob with a board using the Marvell
> CN9130 SoC and using the asix88179 USB-Eth adapter.
>=20
> The problem is after enabling and unrelated feature in u-boot the
> asix88179 fails to receive data (I can confirm that the link partner
> does see packets in the transmit direction)
>=20
> =3D> version
> U-Boot 2022.01 (Nov 08 2024 - 09:45:44 +0000)
> =3D> usb start
> starting USB...
> Bus usb3@500000: Register 2000120 NbrPorts 2
> Starting the controller
> USB XHCI 1.00
> scanning bus usb3@500000 for devices... 2 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> =3D> ping ${serverip}
> Waiting for Ethernet connection... unable to connect.
> Reset Ethernet Device
> Waiting for Ethernet connection... done.
> Using ax88179_eth device
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
> Rx: failed to receive: -5
>=20
> Abort
> ping failed; host 10.37.233.65 is not alive
> =3D> <INTERRUPT>
>=20
> Debugging a little we can see that the -EIO is actually because
> xhci_bulk_tx() hits a timeout from xhci_wait_for_event().
>=20
> We think this is triggered by the u-boot image size crossing some
> boundary (the problem seems to start when .bss_end crosses
> 0x00000000000f0000) although I've so far been unable to find
> specifically why that might be. As far as I can tell u-boot is being
> built relocatably and nothing is overlapping. I also considered that
> ATF might be preventing access to something but so far I see no
> evidence of this.
>=20
> If I turn off some features to reduce the build size the problem goes
> away. That is actually how we've avoided the immediate issue, although
> that means the problem will likely come back and an inopportune time.
>=20
> Does anyone have any ideas as to what the true root cause might be?
> I'm a bit stumped.

Hummmm. Since you note it seems to be when a threshold is crossed in BSS
size, add something to the BSS of a variable size that you control, and
after confirming that you can replicate the problem this way, grow it
just past the limit and compare u-boot.map files in the works/fails
cases to see just what's being moved around?

--=20
Tom

--/FRT0Z5PxfOlcatt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQKgACgkQFHw5/5Y0
tyxXwgv9HIZSO+nOlPTODBLxNJkUrpsI8oaRhKMP4NoXKneazYDGDbYu4N3vHEND
nE1NFEu0XazZcywAWbwwKR1MOeFa+wXR+yljxM/ZDzQhqqs69WrNkjVM1CfJIsYJ
KxGKEd+nqSeHVVZtCA2dWOyuuFGpEsRuJNppBxIbQoAzOWlXAcNc3WvfQJMydTjm
W+KjCPN6A8N5Xetg6xff5PKFYeL4tCuduBoHrQtiouMyjs+L6SNAX9L1mRQBahRN
G3MPJaIaVi9uMYw3AS73vxIjS8b/gFOZflm8BQevShey7SCHqgwPTopuZ5dV79nu
VV1FqnHvKY2zyFQ9Rtya4SKd3BBcSZGLL6f6No7uAf+uNSy6H0DGyXek33XKv1iN
CTXzwbOmV6nt086v7vDDIbhpoID6aDGO04WbRPkFmoLilxol9ZJgJusmpoWGvVd8
kXBw3l5p/9TeL2DeHL5Nt1AiLg103Ja7Xmj3jjp3Zuv1JRC+8KrkFviM4Q6qN9qr
zGpVbUss
=Srmn
-----END PGP SIGNATURE-----

--/FRT0Z5PxfOlcatt--
