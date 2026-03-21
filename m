Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4E91094489
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 17:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7252C83FF5;
	Sat, 21 Mar 2026 18:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J/uneoPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B9D83FFF; Sat, 21 Mar 2026 18:06:32 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF5D583FDC
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 18:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-466f1c3c627so983173b6e.1
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774112789; x=1774717589; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o02BGGkLGtaUx5MgCxITSkF51syaQ9cJjKbGhapQsgs=;
 b=J/uneoPi+m/iWMYFSW13nhYmVUY70kMutmwSv5woXqfPdtnK3Hl6B5iJv8DIn/H9QR
 qkLgvylljRaR+ryPIWsTzt85gTuuZ4AAu9Yiz27TvDblbpUxMO6PMicBrN4pZj1+W/zZ
 aQ2ETGMfLLafunubdIMbtAQaVkiFGiPj0tIzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774112789; x=1774717589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o02BGGkLGtaUx5MgCxITSkF51syaQ9cJjKbGhapQsgs=;
 b=rbKJNMMy3ZLrmmXrJ5reYTrwTf9oF9mQHS9l8J/DsM008s3/7Qtt4ikMBOmaFO4/Fx
 edoT/NRzOHTOx1x8lCrQa8BPfHWajlP3ffSXjAxPh/FhuyFXvJpvwE/FU/ha5Cc2BPcc
 tcXzSpv2NhRLrGVfeW9lPDhG6bEguxNPj0Cmzcp1+CFk5sXfGCQn3JY6tDJtKaxPr5L8
 iIWMow5u78Kbj6KO5uUj0+R39wGUkxJOMV4f09U7OyncMR2vkfxm90TvD4vOrTzyj8VT
 9/xR+/2ZLo+9jngjqjiQ8Tr4ZxD8/MMOHgvQZ2LWRpDrTcZTQytVmNOFrIXLPixn35qS
 r8dQ==
X-Gm-Message-State: AOJu0YzN20AS7/a2mBbOjPCvDrUj85TFjfpWPcC1RR9MmcQiq+Fi8zRX
 JYb68lgwNH1L2BlnEfbsN+6TCaV3SLVBT9AGfukFPbzsQJ5zCjcRK/XzD+UfGyCHPsk=
X-Gm-Gg: ATEYQzxY/BO4X/V4JUxCRRyErssTTG2jgqdx/SiJSbKB2s+fFuBp/DKhwnJXbPdhgEt
 6CYYndGA/tFMOaemma2bknQyDyFIHIl7z6vZI3WEhAkzcw0cPYwJuy/46MU0CMDA6bOTQVG3mAv
 Qn6iPdubOVzHHNaGZJG96WmtGIlejxkciSvMcStF8mrOYTXcLGlbmG7L1SL5hAUI/F16rvZXRsF
 go46U7FQQYrZ4wAqsIH7OpUMgJgkp8ukwwJw8ACMe8rYf75Eb9uOVUQhuvapW/2Pn+wbdcdqGbz
 5G+naJqpYFXM+bGbqq7wyS/rk0/R8lTCAVqGJFVNad/w7RL6b0pKkivct6t1pUuIRS67sWLhvnG
 p8x0bghnF8pdTQc+sIuW+XeO8v9nTkfZ2MPdWroK+ZJemCPz+4h91RdAG73DYQ6VRkJfrVqE26t
 xCxrCfEkvRqU6k8fVqzxQ5N7eYwiw2Xm+HqDXkanp/IwaquXIfh0g0zO4zsns18I9htAwZULAoH
 +vte9tk9fg+8HiPGQKLzhOCvDfbXVOYDPG0ZpN9+wKqd6G6
X-Received: by 2002:a05:6808:c2a9:b0:467:2418:ced9 with SMTP id
 5614622812f47-467e5fe309emr3476094b6e.50.1774112788641; 
 Sat, 21 Mar 2026 10:06:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7d4bdbdsm3591421b6e.7.2026.03.21.10.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:06:27 -0700 (PDT)
Date: Sat, 21 Mar 2026 11:06:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] usb: Correct dependencies around USB_EMUL
Message-ID: <20260321170625.GE502704@bill-the-cat>
References: <20260320205353.3789127-1-trini@konsulko.com>
 <f6ffc6db-c59d-45c9-964f-7fa56c320047@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SbMfKvYR6hu/aLvW"
Content-Disposition: inline
In-Reply-To: <f6ffc6db-c59d-45c9-964f-7fa56c320047@mailbox.org>
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


--SbMfKvYR6hu/aLvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 02:24:04AM +0100, Marek Vasut wrote:
> On 3/20/26 9:53 PM, Tom Rini wrote:
> > The symbol USB_EMUL is how sandbox has access to USB. It's
> > implementation however enforces a few other requirements. It must have
> > SCSI enabled, and in turn that means it must have BLK enabled. Finally,
> > we should not be using SANDBOX itself as a symbol to decide what to
> > build or not build here, as SANDBOX is selected for COMPILE_TEST builds
> > as well and so may not have enabled the sandbox specific USB support.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Marek Vasut <marek.vasut@mailbox.org>
> > ---
> >   drivers/usb/emul/Kconfig  | 2 ++
> >   drivers/usb/host/Makefile | 2 +-
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/emul/Kconfig b/drivers/usb/emul/Kconfig
> > index 279f6c6d7404..8ba372453e37 100644
> > --- a/drivers/usb/emul/Kconfig
> > +++ b/drivers/usb/emul/Kconfig
> > @@ -1,7 +1,9 @@
> >   config USB_EMUL
> >   	bool "Support for USB device emulation"
> >   	depends on SANDBOX
> > +	select BLK
>=20
> The select SCSI and Makefile change I do understand. But why do we also n=
eed
> BLK ? I can't find anything which would interact with BLK in the sandbox =
USB
> emulation ?

Ah woops, I was fixing too many problems at once then and forgot BLK is
select'd by SCSI now, not depends on, so indeed, it's not required here.

--=20
Tom

--SbMfKvYR6hu/aLvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab7QDgAKCRAr4qD1Cr/k
CjtGAP41eyFT/Mvqm4lY+KT9sGMBe0xiZlHPW/XuNkbqZ1LrPwEAtrcR1c5TaMh3
B2EMboJdRscbhK9K3Sa9MnN9z6Bv+Qk=
=Ao+/
-----END PGP SIGNATURE-----

--SbMfKvYR6hu/aLvW--
