Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7EBE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 21:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A90688E18;
	Sat,  7 Dec 2024 22:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KRU48541";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 050B488E39; Sat,  7 Dec 2024 22:27:57 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD8888E00
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 22:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6c3b1ee59so76631685a.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 13:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733606873; x=1734211673; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VmjD3rKNxQTmH3OVmGPbisctjXLGDbAbdtDq58Fe2f0=;
 b=KRU48541r/h/IOfhMZaEq/j9hzHeHo8ihseIjvgIETp1f7P5ycZoeH8OL2HGVKcjM8
 EKNdh4zrkLotPhx99XiOlEgZxqkKSYIpvSLXyRp1TM1ZbmupgxwwHm0bIJF8W69WXE1T
 w0mv/xRNVYLkCjaLZjBzZsqLy79aFMu7ZGr98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733606873; x=1734211673;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmjD3rKNxQTmH3OVmGPbisctjXLGDbAbdtDq58Fe2f0=;
 b=nlEB8bDAabxqIr7Ozyp60IpkG+XjHLGCZFSPf9lwVrEKSpoKDneb5zhMcQElC2e9ac
 kNkEr9vPBJqiHShIhVryXiC0P9Szao5I9kHx04aqDXp3yW8fyriM7rfLQtCFab/8rTpX
 8KkIZ5QuTECDDwrtKTayEmvka6HDqwVmHvTCVoBReRR6r8VQUUgG2WdFfEzL5qjPiCjW
 d7u6mF89u/7UNVFxVXAUguVGf50LQABkIRBEIrtJmqg/xkYguNv5oYtuV2mpmmywPINN
 knyZNRESVhaL5+0WO0GBeCznxJVvWdHvN+zDS0+UaJGCgk8gcFyPowytPLTc1CdQT37F
 OMTg==
X-Gm-Message-State: AOJu0YyZo+wM/NdgGfw/w6ezUR30FWExsMckDOHHVcveEO8rCHGV0mUG
 Sn9fH12JuAi8Zm8jW40jXnVC8tSXBAUuJJAhpsPeqgi7FIghfw2PyULn0bZ156g=
X-Gm-Gg: ASbGncv6FGR00PVw+q+GLI2Aq2XUOyKOBUdqHvMvhE1qPywml93yBnmMM8nIAKka2sh
 jABphgE5lIv23s4t3lBimBN45nLTJoKP22G9Hk4cio0moe6ZH/wYbkdvrahI0AXi+aPfp1FBM1h
 ESrXhAFUbSv6DW42xtx2jdtxTrpvRRrWb9D08ero3N4UTHVr4v5bFcvsnh8g2PUyAMkD3eBlcPV
 nL5bRnXtcVGpt1nWdCoktPXcv9Zt1WD7u7Y9//uuimyr5dvIig=
X-Google-Smtp-Source: AGHT+IGXI+BB9JU9YyeOcqujLyuAoS/f/o2FP5mJ+VStuOlYexAnl/nVpeB9Afg/+a+nwJfqgR5qyA==
X-Received: by 2002:a05:620a:6018:b0:79f:1873:5463 with SMTP id
 af79cd13be357-7b6bcac2222mr1276938685a.6.1733606873531; 
 Sat, 07 Dec 2024 13:27:53 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6b2291sm32563706d6.58.2024.12.07.13.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 13:27:52 -0800 (PST)
Date: Sat, 7 Dec 2024 15:27:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: UEFI messages on startup
Message-ID: <20241207212749.GF2457179@bill-the-cat>
References: <CAFLszTgnwTtUdgSHu6-1AC7cFU-oBNSp3oHAFTzisG5LmWs4gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rsat3pvSkz82z7IQ"
Content-Disposition: inline
In-Reply-To: <CAFLszTgnwTtUdgSHu6-1AC7cFU-oBNSp3oHAFTzisG5LmWs4gQ@mail.gmail.com>
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


--Rsat3pvSkz82z7IQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07, 2024 at 01:48:41PM -0700, Simon Glass wrote:

> Hi,
>=20
> I see these messages on startup with a rpi_4 - what can we do about
> this? It happens on every boot.
>=20
> ** File not found ubootefi.var **
> Failed to load EFI variables
> ** Unable to write file ubootefi.var **
> Failed to persist EFI variables
> ** Unable to write file ubootefi.var **
> Failed to persist EFI variables
> ** Unable to write file ubootefi.var **
> Failed to persist EFI variables
> ** Unable to write file ubootefi.var **
> Failed to persist EFI variables
> ** Unable to write file ubootefi.var **
> Failed to persist EFI variables
> ** Booting bootflow '<NULL>' with efi_mgr
> Loading Boot0000 'mmc 0' failed
> Loading Boot0001 'usb 0' failed
> EFI boot manager: Cannot load any image

Please elaborate on what your boot command is and what's on your SD
card. I don't see that with just "bootflow scan" and I think an older
Raspbian on the SD card.

--=20
Tom

--Rsat3pvSkz82z7IQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdUvdEACgkQFHw5/5Y0
tywUzwv/U9JKHTiBQwvaJ/qesKmiEx8tT/v7UIvSY/zrpCMckzEWuUOkJfXm7qGs
gFi+wDHyYVE0fCREfDN7I9xvtO9o4v29UJo2uGHHLlneZfdeT28CwRy2iUNwTnHO
HnNbrNxF/2R03bEoxUAq/mNGPPYCnYCDmDJA7hmM9JYJt7g/acRpWa3ygSLkpHik
SFppNUn4K6sJk0AMTmbqzhVUt9xCwEzHwURX/2iFdMUaTy0i7m5lZ2GB9ZOVVPQa
1eHZdrY695EKA8xydtBieXNC+rlYZfpXZZctam1akwPnSJVUZuVevH19cSmu1wJi
DGiQede5BmP6+6EN2U4NimBR+RcHXCx2kcgy0eJpaNtWzu0BgJvDS8Q6HBc881XD
wEDKHBTOOX+bcQVKphTEkygkiVVGImIrukPpMG/OVNPV1d6v8C/AvonBZqHnEv5T
1q80IiI7PENVa0sEb890YhbBE1mhHqOgLjc178qmoiDyYVEj7F6t3c7HLRnE6/rs
TDgJ/ONN
=hlAq
-----END PGP SIGNATURE-----

--Rsat3pvSkz82z7IQ--
