Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406CBCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 23:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E9582A9E;
	Tue,  4 Nov 2025 00:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n0mKmWYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3C8836D1; Tue,  4 Nov 2025 00:23:51 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094488004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 00:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c53215c3c8so5587012a34.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762212228; x=1762817028; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0ZMZY7DgZT8LMV938fr61fo2oPUR57VOuEABJ4jKKxs=;
 b=n0mKmWYqmiHkGvToZnZjdAN5DfvjS4xjH0PVtY5diN0kri6VGqTOKcGlCcp1PFSCqQ
 vqTFXD25p7763xxqtbSQluW+hpc6y0KBPpt0fEdk67wHgFSro4xQyAn8MsA/MF2BLOXF
 r3XkmdBKqEPcdIq1H3SLnOJpUNyYHPoq8WAQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762212228; x=1762817028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZMZY7DgZT8LMV938fr61fo2oPUR57VOuEABJ4jKKxs=;
 b=V5ZzVtaewP3KOvj+amNLDlOEHh3EE8irP3X2e9pcDU9l12kAhku6EIFBUY0whfWSs4
 VdclZgDD9jRQ+uvD4WaMik3FIPy100TBarMLI9FgM5Qlb0sY0qpr9Mn3+l5Zd8inIJOS
 gjWoyyxMea5jUwmFc6qMvFB24VhBd3ws2dSki3IaMM+TZAccEbnS/Tbws2rINKWj87HV
 jePFZwVMQgvMrBomwz1iWf9nXXkibgKCwHVtrCKoxm+mXFJQYne2A+uVabmoQ5gyL54Q
 nn2H3PhbgSWxlu3sfbHf5NuoTnh3hlhcDd4sIDG+Z4VLEwMQq6Ua92QvQqLuAc6IDhJy
 tsZQ==
X-Gm-Message-State: AOJu0YwF7i2LNnTf88QM5Ep46JTZ/sbEraT1dd+Flrdoxn7prHV7uMN+
 GX4dN7Ngqo2LS26PT/a1kdyS/LtURmVM1svbzPQ2Gj2fpp1UEnMzpybvJntTd48b+0M=
X-Gm-Gg: ASbGncvWFPLexWOLScwmKY3XQufsneOomtofUeCmnPzuxTdRjiovmQmUMD35Ip0V4du
 IMa6Yg8QSPyHlSMn35uHC6hMWsgKHu8Q2LNUXqx9n2ZTUHqyMNFV8bG4jQ8VlnDgvn71e2TDWyU
 27VtW/zLUajzLwwI5EW6rNb2TwlwQICHYNMZqGoebYdUf8JxsZLBagYV6UbnTw+oVScDt/mnWma
 3MG+dTeul6edxUr4ZzV1s2CTatUded/0ZGgTyqCJ5+9inSu53/YpXFvdoK0RbhkWcVaAxidRI/z
 AFhnA47molF3vEBBI76ANHV8/QE24p97IfLWetjAEQYoMYqtYFXSnK66BeyeT42k8caLlQRmEhx
 PeGDuyIoAJOcU9HdUfzWS00r8qJSyKwiKZCJLL1eAH/mq7j7BKFl9mweJjeR9O2N5M6/tA8+jrt
 T7igayfc6NFykOTbehpnoakGqmtG2Rige+enDQmc1yGKxhA4OCug==
X-Google-Smtp-Source: AGHT+IE9K5hSrD+i0xznxHT1QINAAGl+PhB73a+BcmRVQVj2oazcaYYgbdeybVyx8LPbjrXeuNJvHg==
X-Received: by 2002:a05:6830:6d05:b0:7c0:e0a2:661e with SMTP id
 46e09a7af769-7c6966ec040mr9193424a34.3.1762212227699; 
 Mon, 03 Nov 2025 15:23:47 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c24703bfsm546569a34.12.2025.11.03.15.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 15:23:46 -0800 (PST)
Date: Mon, 3 Nov 2025 17:23:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add make feature support for SoCFPGA Handoff
Message-ID: <20251103232345.GW6688@bill-the-cat>
References: <20251103222840.458-1-briansune@gmail.com>
 <20251103223346.GU6688@bill-the-cat>
 <CAN7C2SB7qeXQB5=VHZ_DaE-ov4S7OX2hSyYNhb4SWv8-k+J_9A@mail.gmail.com>
 <20251103230540.GV6688@bill-the-cat>
 <CAN7C2SCCMKfjnfB2FnH1svrSJ1dN_chtUVmsTcaP6-8_zSiEzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R2/EpcU0rvuBMKkn"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCCMKfjnfB2FnH1svrSJ1dN_chtUVmsTcaP6-8_zSiEzQ@mail.gmail.com>
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


--R2/EpcU0rvuBMKkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 07:10:54AM +0800, Sune Brian wrote:
> > Because ".config" isn't valid, you need to have $(objdir)/.config be
> > checked, and in turn that has to depend on the appropriate target (we
> > have some stage that says that we are configured, I forget which).
>=20
> ```
> make clean && make mrproper
>=20
> make
> ***
> *** Configuration file ".config" not found!
> ***
> *** Please run some configurator (e.g. "make oldconfig" or
> *** "make menuconfig" or "make xconfig").
> ***
> make: *** No rule to make target '.config', needed by
> 'include/config/auto.conf'.  Stop.
> ```
>=20
> Still not getting this, sorry a bit.

You need to do some builds with "make O=3D/tmp/somedir". But also, I'm
trying to make sure we avoid race conditions and that we don't try this
logic until after the step where we know we have configured the system.

> > > > spin with "make O=3D/tmp/somedir". It also looks like it's going to=
 impact
> > > > every board, and either fail or add some build time? Make sure both=
 say
> > > > "sandbox" and "qemu_arm" both build at least, if not a full CI run.
> > >
> > > For build time -> There could be 4 line of code to check.
> >
> > I do forget off-hand which methods of doing "something" in a Makefile
> > are cheap and which result in firing off a subshell. But for a handy
> > feature for one SoC I want to make sure we don't slow down say the world
> > build of all 1400 configurations. For a maybe useful example, see how
> > the "checkgcc6" target is handled, and maybe we can move all of this to
> > live under arch/arm/mach-socfpga/config.mk and so only get invoked at
> > all there.
>=20
> If config.mk can also do this job why not just move it.

Yes, I'm saying move this logic to that file where I think it should be
workable, still.

>=20
> Brian

--=20
Tom

--R2/EpcU0rvuBMKkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQk5dQAKCRAr4qD1Cr/k
CkFWAPsHC0XWgMsfxFaTWg1aAmuex2dwt2qyN2NYfP7QQdD9sgD/WZ+gUwgphrE4
zzW+Ii40NOgXgk1ZIfPH+2U8Mr/jdwg=
=MGZv
-----END PGP SIGNATURE-----

--R2/EpcU0rvuBMKkn--
