Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721FFE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 17:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AADD08005B;
	Thu,  9 Jan 2025 18:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CDQTlehf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93943800D0; Thu,  9 Jan 2025 18:22:26 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2C008001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 18:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b6fc5bf609so85269585a.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 09:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736443342; x=1737048142; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FyUefC+oKlFBO8vTzs4yRc/3e73kNrJIDbi9EundWLQ=;
 b=CDQTlehf8ljE+cktUoL+oR7U7d2rSFnJ0lMcL/o+F+nOBs6S+lTlH6s54Gs192cAnN
 U1KpmOHtDcamHVYmMv1WhMVwjxA8vEx5Qugb06zrhdJ9bCCRfZnVJpT0CDNR4mXersiW
 rBD4+tp0caIYyxec+cacB1DSorS9zJLTn6yuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443342; x=1737048142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyUefC+oKlFBO8vTzs4yRc/3e73kNrJIDbi9EundWLQ=;
 b=Ob23gRiWqJBcldZBMyryq0no+VmjdKdDwt1dayx3GGPD4eEjLGJ12BGxE39UOZYRb/
 hMDipFTa+jYF/NNwzD5l7lVIWruExOmkJE0Ix/2KGBmkYkNhev8r5pz4BGLn/HF4+/Nq
 2FHagUbO3e05Zb58GiugFPPqYHFDPPhh19o2lOeTgIwhn6KJGbhX3nKHXL234fvmTc4t
 ZMJbnfP/PXax74NKC248O9NSOhj/8MYJ6jgn11OXmSDvGjxdlowbQMD6q8pkeQ32Z+m/
 5CSg4Hd9O6RAOa7AVdtDYFwtsNeptdgf2XrMwPTmGlNGZ1YCEeWZleKZoIDQZEzGCJ7e
 8nxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdH9RfTWThSltw32/i+p2y+jL2hjISDpFP5x9K+WM4IxMZYmxHdKyZ8+ywDcvjX/o1Ky1cs1c=@lists.denx.de
X-Gm-Message-State: AOJu0YzDgHSm2zv1/Mgf//juXoFAvOm+fixRjZISzKgU0t/cOTMgeXsc
 WDFHHHQw2Fc6fNJKzSehOnOuoijAUd8FB37lpaO4TuvQDMzZfoS3kzk/Hgd26f4=
X-Gm-Gg: ASbGncuTgWA5Mc9C5WTaWAkNUY9pY1IHJnOjCnQAWjITMlOvYRGbqaY3R3R/yF44nVd
 XeziNaPtYUNjqgcPxd6c/Wn5Fxy9m0Zt7LV1EeTgdWbxz/MWPa15DHF/oLn05Ko3xFGwBrWX1om
 2KkoyP4UJtY3BO8Cmg6CBHyEwyPWapVupPDXopAehbXr/ImLUvA7dBcLMXZuRhTYXl0WT3XI7+9
 D+FHffXC8P28UXQN9QHUAALxZ1ID3JGyyHSEVuXFFAWrWQxTwKhgDE=
X-Google-Smtp-Source: AGHT+IF8XZDTIKz5QfDBMJsfGn2t2cRxI9ACb5BPkQ6c08Cti4nwJR/KGkfShVZLcwhwd49SG0wJYw==
X-Received: by 2002:a05:620a:472c:b0:7b6:c543:7e54 with SMTP id
 af79cd13be357-7bcd973e241mr1196472185a.22.1736443342543; 
 Thu, 09 Jan 2025 09:22:22 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce324875fsm86707785a.47.2025.01.09.09.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:22:21 -0800 (PST)
Date: Thu, 9 Jan 2025 11:22:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Frantisek Rysanek <Frantisek.Rysanek@post.cz>
Cc: Syslinux <syslinux-bounces@syslinux.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [syslinux] Purpose of 'localboot'
Message-ID: <20250109172219.GB3476@bill-the-cat>
References: <CAFLszTiT59PBvpxtpwMXcX3f-dbAfkZ=2xW=bHm6LrGAAe_TrQ@mail.gmail.com>
 <677FEBAD.16689.1CC4743B@Frantisek.Rysanek.post.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4HJ39Rv/FB9SS11y"
Content-Disposition: inline
In-Reply-To: <677FEBAD.16689.1CC4743B@Frantisek.Rysanek.post.cz>
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


--4HJ39Rv/FB9SS11y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 04:30:53PM +0100, Frantisek Rysanek wrote:
> > Hi,
> >=20
> > The documentation on this feature[1] doesn't quite explain how the
> > system should actually do a localboot. Is this for BIOS / x86 only?
> > There was a recent discussion about this on the U-Boot mailing
> > list[2].
> >=20
> > Is someone able to help with how / if this should be implemented in
> > U-Boot?
> >=20
> > Regards,
> > Simon
> >
>=20
> I feel that you actually understand the whole point :-)
>=20
> Syslinux is a bootloader for the PC's - those have a BIOS and=20
> nowadays a Bios Boot Sequence (BBS). And, a specific member of the=20
> syslinux family (package) is pxelinux, which loads from the LAN.
>=20
> The "local" boot means, that while the PC is trying to boot, in a=20
> particular step of the BIOS Boot Sequence (=3D the order of bootable=20
> devices) it has loaded PXElinux, and now the user has a choice,=20
> either to chainload some "payload" (e.g. the Linux kernel + initrd or=20
> some such via TFTP), or to hand over to the next entry in the "BIOS=20
> Boot Sequence" - effectively by calling an "iret" at the top-level=20
> function called by its respective BBS entry, which is effectively a=20
> software interrupt... which will end up trying another boot media,=20
> the next one up in the BBS.
>=20
> Yes this is specific to machines having a BIOS.
>=20
> Not sure about UEFI, the bootloader loading mechanism is different,=20
> but Syslinux never quite got there with UEFI, so I believe this point=20
> is moot.
> I haven't actually tried this with iPXE, there doesn't seem to be an=20
> explicit keyword for this. Possibly if you "let the ipxe boot script=20
> fall off the end" or by calling an exit... or possibly not.
> https://www.google.com/search?q=3DUEFI+exit+ipxe+and+try+the+next+boot+e
> ntry%3F
>=20
> Now compare that to uBoot. Who typically has just a single purpose in=20
> life, and a single option what to boot: the one kernel and initrd,=20
> typically from a NAND flash MTD (or sometimes NOR flash for that=20
> matter). You can possibly break normal boot and try loading something=20
> via TFTP...

So the reason Simon is asking is that the syslinux / pxelinux file
format is used outside of just the syslinux project, but it's a little
unclear what the authoritative source is (systemd used to have a page,
but that moved and then got dropped). We're hoping to find what the real
intent of the keyword is, so that
https://docs.u-boot.org/en/latest/develop/distro.html#boot-configuration-fi=
les
can say the right thing, rather than the few stackoverflow examples of
how people use "localboot" within U-Boot today.

--=20
Tom

--4HJ39Rv/FB9SS11y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeABcgACgkQFHw5/5Y0
tyynIgv/eN0r54DCyrUOLSz4trTlcq+huF+E70JkoS6tHCx4EOHzIlyPxY+73BL+
JflrnFSfj08KjIxBFCSM1VM0PenYNaTmiVQZuZrggGT6abjjaIPwvUVWO9ZxRF4g
qrjhZbqXh0z2fGuXsRC20HO0nZyFBXTXfDd3t00+61mwwOoK6c10anauiCe/BZhy
+9Sx8oC9/nPq1fh2aU1mUsbdBA3+sTnhqaun1S6ZptG7gy9QCfdVRrcwsNtsyvYL
R5m+ohp2DC4veQJ4N/56wWqllyPJyo+OBhuRzZKMJEByW0IQRggLxaZrOtH7muX0
pWYz5xtAO0FZJCTncHT4fUuTwDYGiFpPtE4U5usvP54GAkjfUhD0q/GwAPqUEREe
2/5Hbkb3J9d+Ms8tc0JN2+HBE2OmeSLVjPMbbBvI752q2ZztZnGSetpIDAf3kaFH
WgaXd3NBB6iPawGufIexmHU61kHsTqfVmWeQG2SmN9+78LxV1HqRCsOoD+6er5Xh
JNYWm+mc
=ee37
-----END PGP SIGNATURE-----

--4HJ39Rv/FB9SS11y--
