Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77006CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 14:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0592807B1;
	Mon, 20 Oct 2025 16:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IySTQHyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB70880107; Mon, 20 Oct 2025 16:37:36 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824C18051F
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c2948b774cso906429a34.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760971053; x=1761575853; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PjTgZRMpX21GSyJVVO+/EKc1llcXf0FDzw+RFn3Lmgk=;
 b=IySTQHyzUXaBTUhGZAV4mi4W0q+ZPovcBmFLjMEwMCZfJlUfb26jRkZknXMK9Tk+xW
 muPxujkbVJUsG7IfCUKA1eF5z77UJjrMYxg4H/beUWffRU8SwUhbl29Z8+Eqql2Z59G9
 +osOMQ6X8fMNM/4+MkSBIddUM5o67tzSFOmJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760971053; x=1761575853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjTgZRMpX21GSyJVVO+/EKc1llcXf0FDzw+RFn3Lmgk=;
 b=tSTc9p86K6k6YRs+lajbP3vAmggpUyr5HF2MHglQtL9XNNMMveElfsxqzQfIB4v371
 Gu7aAuMyaGTE+fy1N2u0jIuEdbtrWY+IRPSXM0zEchDvYNjwLUyniNsmr6aRWaUteuL7
 d5+/qTXae4TQcI+dCWcwIqMFv32di8DmAVP1qrdFDOIE/dZgEMDqeXF+edUSKHzzZRPM
 psjt8w+ZsfsVRCIm9pErfCwhrbCgpuqPIr/c8E0GHeqpR6sTayDWB2JyyQDVMa8jANd9
 ai7iBuwaaPg/8WeSXd/UerOHBBbMysNqI46nQvPQVTs1LL7krIxM6uffNttA5bjqrsv1
 e5GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUubSLzgJHH41CY6ctUEGB6QLh9TRjkAZxefyILWiuyEvAM5vU8XMEAywzcegvoBwf8nu1gTug=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp0mO9ekaKODqt22k4ehRxYxt3QbSPnxbuQV+p6mAkih2mjKhV
 du5l0CdVvQ5DAWav1xr+znuCfgx/mfiCL9yMuunDEyDlHmu0iHIIxiLPZM3D5pXNAlc=
X-Gm-Gg: ASbGnctf7sAKq1bdgKvbZlMsGb492iOB5vlD85Eda9lRCQM/ZsYplrnZIMSHtk811l1
 pfRCnTH3hkDtkD+CpSKuBVP2/l66wd/8cq4UuiR4epShzeH/9Kg8zCuQGIeOmKwP5em8ykYW9Jd
 MS1Gb//E986FIW/3t8Jps02H7N6+p+oE6S3T0tjkCdZliyMhwdQN54+MLfqoPuTxUPPvO6XEk+C
 T1Db92OI8uSxIaoB84grjoy5QNZjkOPRL/MHqVsLJA3t8YuoSwVtxO3xzyMprJD3iM+TP4ju850
 WfJ0CCJ/NVnivmbBYsFdBzTV9DiB14kZcQp8c1/Z5IJbduM5//fyC5oVx6jXW9y41lwU1rDLHfd
 oxo8enB2jB88CXWhMYZkDoOeIl4u2tUDk0XuLVV6gDwGJZEgNf8EYgo3qQg/qy5JE9YPs5oDBtH
 mZ/OlVDn3Zg7mkrR3HeL+VAW8Xq7kjgeiqhFsgcERKZd8ON5s8iA==
X-Google-Smtp-Source: AGHT+IHx4IcVGv4qU0AL/o9nGXcxsY093d9jPchO0fqCrnB4itn5aQ1LCem2G/ZoAit3L+Hr+k4iWQ==
X-Received: by 2002:a05:6830:2108:b0:7a0:239:807e with SMTP id
 46e09a7af769-7c27c985577mr6991414a34.11.1760971053249; 
 Mon, 20 Oct 2025 07:37:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2887b7c7asm2689622a34.8.2025.10.20.07.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 07:37:32 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:37:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251020143729.GW6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
 <20251020115009.532a1a99@kmaincent-XPS-13-7390>
 <20251020141548.GS6688@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OYNDy/YxSbIvPEhN"
Content-Disposition: inline
In-Reply-To: <20251020141548.GS6688@bill-the-cat>
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


--OYNDy/YxSbIvPEhN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote:
> On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent wrote:
> > On Sun, 19 Oct 2025 10:48:37 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >=20
> > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote:
> > > > Hi Kory,
> > > >=20
> > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> > > > <kory.maincent@bootlin.com> wrote: =20
> > > > >
> > > > > This series converts the extension board framework to use UCLASS =
as
> > > > > requested by Simon Glass, then adds extension support to pxe_utils
> > > > > and bootmeth_efi (not tested) to enable extension boards devicetr=
ee load
> > > > > in the standard boot process.
> > > > >
> > > > > I can't test the imx8 extension scan enabled by the
> > > > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > > > > I also can't test the efi bootmeth change as I don't have such bo=
ard. =20
> > > >=20
> > > > You can test this with sandbox, using one of the bootmeth tests,
> > > > perhaps. Let me know if you need help with this. =20
> > >=20
> > > But the question is, does the real hardware platform work before/after
> > > this, not does the sandbox test still work before/after this.
> >=20
> > It seems the bootlflow scan is not working on the sandbox on next branc=
h.
> > Is this issue known?
>=20
> Is it fine on master? The next branch will be out of date until it
> re-opens with -rc2 being released (2 weeks from today).

=2E.. out of sync local calendar, 3 weeks from today, not 2.

--=20
Tom

--OYNDy/YxSbIvPEhN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZJJQAKCRAr4qD1Cr/k
Ck2AAQC+xnmfS6DgxC3CQN1JjA/txR3Oc4GTKrChnfkHS0sd4QEAj0+kD2nLjshT
0Za8qd6cLwxH/ErGFKwJ7lLlJNdTegY=
=SpYr
-----END PGP SIGNATURE-----

--OYNDy/YxSbIvPEhN--
