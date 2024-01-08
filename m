Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07851C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 340B087A99;
	Mon,  8 Jan 2024 18:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZI1vLPM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA8187A8B; Mon,  8 Jan 2024 18:28:06 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC18F87A7B
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7811db57cb4so172948785a.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 09:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704734879; x=1705339679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=79gpbEIZ30POMFchkyZt7j4Z4kbT8jcRym5yYbGtqcM=;
 b=ZI1vLPM+dw9N+3bVlynpgu9Mrzmk+6FPVELnsq5oJJCNRJmaB38EOjBSyGg7KFEJuM
 mCwt8otnwn1BamHGwQGjBUJFUq1VCLcv5Vb9Xt2WehCxDFRjru1Ag9OuFe5UYqZ9KInv
 g1QdKsK361OzjqZCFhCyYXSb2BXAI6jNWePvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704734879; x=1705339679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79gpbEIZ30POMFchkyZt7j4Z4kbT8jcRym5yYbGtqcM=;
 b=xUJH5nIiSfwAV6Uc8mWdoUC8dNBtYooqgEgXaypDplHXavvYFRejV3/gRVqKXwAGA/
 wwrNKBXPN/zmYVNRFe8B21fDV7UiJPUV+LLGybMp4JV7/2SeubT23l9owZD5R8WOZz9D
 T1vC9D0LKcOMWUMpL9MUnuMcRTLfjENKsZLTbxyraWYUSZKKthqyq27I7ZGbgCBftqhs
 +zQzDeWELfnMH9/QL+lxS83fvUDmWNL6H1xeIVdGwpn1fxd8XDIky17jxWtJBIsQC6j5
 nSCqS0+10zRzsy9xeh67Tg29SYEuRqXs/8BQWFbFVX1ybGKv4dAlm+0RGUce/2kquJWt
 EV1Q==
X-Gm-Message-State: AOJu0Yx8j3hykFKBrmEmgLiGGDanwlU8VrhIND51RZBXHA7X4kDmN5By
 1vLU4U0sLl/5A9KcI9wCEtx3NqWQOrgJ81ICMDIqyXE2zNY=
X-Google-Smtp-Source: AGHT+IG9O0rkit5R07NoMdpcUdRbj+47AycKhCvSqg0aJobtbACqQ9whahahKtP1OJZetvB2lRRKhw==
X-Received: by 2002:a05:620a:2a01:b0:781:9e55:b34f with SMTP id
 o1-20020a05620a2a0100b007819e55b34fmr143901qkp.4.1704734879441; 
 Mon, 08 Jan 2024 09:27:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 f4-20020a056214164400b00680b3818c53sm129988qvw.141.2024.01.08.09.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 09:27:59 -0800 (PST)
Date: Mon, 8 Jan 2024 12:27:57 -0500
From: Tom Rini <trini@konsulko.com>
To: E Shattow <lucent@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: booti usage offset requirements for compressed kernel and initrd
 with dtb
Message-ID: <20240108172757.GI1610741@bill-the-cat>
References: <CANV2PTOD+cY55ES5HDrSZuGjqee3fvfXKORWg8bJFT64mFdg8A@mail.gmail.com>
 <CAFLszTiEfCDGTRHiVQDzb+9KqpKi-EQuS77bOK-LYThZxTTb4g@mail.gmail.com>
 <CANV2PTPXDfZ84PGxEvwqRHnScMcwwy-Amgmg-eJxq0R_b4Gn=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9hl4y2qkUwZQOXPI"
Content-Disposition: inline
In-Reply-To: <CANV2PTPXDfZ84PGxEvwqRHnScMcwwy-Amgmg-eJxq0R_b4Gn=w@mail.gmail.com>
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


--9hl4y2qkUwZQOXPI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 06, 2024 at 02:45:47PM -0800, E Shattow wrote:
> Hi Simon,
>=20
> "If this [fdt_high environment variable] is set to the special value
> 0xffffffff (32-bit machines) or 0xffffffffffffffff (64-bit machines) then
> the fdt will not be copied at all on boot. For this to work it must reside
> in writable memory, have sufficient padding on the end of it for U-Boot to
> add the information it needs into it, and the memory must be accessible by
> the kernel. This usage is strongly discouraged however as it also stops
> U-Boot from ensuring the device tree starting address is properly aligned
> and a misaligned tree will cause OS failures."
>=20
> https://docs.u-boot.org/en/latest/usage/environment.html
>=20
> "The device tree blob (dtb) must be placed on an 8-byte boundary"
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/arch/arm64/booting.rst
>=20
> No mention of dtb alignment requirement at the similar documentation for
> riscv64, but there is this mention:
> "The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned for
> rv64 and 4MB aligned for rv32)."
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/arch/riscv/boot.rst
>=20
> Perhaps then it is both a dtb alignment issue (not mentioned in the
> documentation?) and the spurious extra requirement after the transferred
> data length?
>=20
> If yes, how much is enough to pad after the end of devicetree blob?

One should not try and aim for the smallest possible memory region here,
but instead pick good defaults. Practically speaking, if I recall, 128MB
is an implicit limit in uncompressed kernel image size, so taking one
128MB chunk for the kernel, and the next 128MB chunk for a decompress-to
location is reasonable. Then carve a few MB for device tree next, then
initrd goes after that.

>=20
> Thanks!
>=20
> E Shattow
>=20
>=20
>=20
> On Thu, Jan 4, 2024 at 8:02=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>=20
> > Hi,
> >
> > On Thu, Jan 4, 2024 at 5:19=E2=80=AFAM E Shattow <lucent@gmail.com> wro=
te:
> > >
> > > Hello,
> > >
> > > There is data corruption when using booti on a JH7110 (riscv64) board=
 to
> > > load (over tftp or ymodem) a compressed kernel, compressed initrd, and
> > > device tree blob, when the data are too close together (even though n=
ot
> > > overlapping). In the adjustments I have tried it seems to be consiste=
nt
> > but
> > > not clear "why?" by how much for each adjustment is needed to observe=
 the
> > > failure versus success.
> > >
> > > My question is simple enough, what are the intended offset requiremen=
ts
> > for
> > > loading these data into memory for use with booti ?
> > >
> > > For example:
> > >
> > > setenv ip 192.168.2.216
> > > setenv loadaddr 0x60000000  # default from Milk-V vendor for Mars CM
> > product
> > > setenv kernel_uncomp_size 24193024  # uncompressed size of
> > > vmlinuz-5.15.0-gpu117 from file command information
> > > setenv kernel_comp_addr_r $loadaddr
> > > setenv kernel_addr_r 0x61712800  # $kernel_comp_addr_r +
> > $kernel_uncomp_size
> > > dhcp $kernel_addr_r
> > > $ip:mars-cm_debian-desktop_sdk-boot/vmlinuz-5.15.0-gpu117
> > > setenv kernel_comp_size 0x$filesize
> > > setenv dtb_addr 0x62e25000  # $kernel_addr_r + $kernel_uncomp_size
> > > dhcp $dtb_addr
> > >
> > $ip:mars-cm_debian-desktop_sdk-boot/dtbs/starfive/jh7110-visionfive-v2.=
dtb
> > > setenv initrd_addr 0x62e31d7f  # $dtb_addr + 0x$filesize
> > > dhcp $initrd_addr $ip:debian-installer-netboot/initrd.gz; setenv
> > > initrd_size 0x$filesize
> > > booti $kernel_addr_r $initrd_addr:$initrd_size $dtb_addr
> > >
> > > Waiting for root device ...
> > >
> > > (and nothing else, this is a failure)
> > >
> > > If 0x62e31d7f is replaced by 0x62e31ec6 then the boot is successful a=
nd
> > > dmesg from debian-installer shows the additional information:
> > >
> > >  Freeing unused kernel image (initmem) memory: 2196K
> > >  Run /init as init process
> > >    with arguments:
> > >      /init
> > >    with environment:
> > >      HOME=3D/
> > >      TERM=3Dlinux
> > >
> > >
> > > So in this the kernel boots and all works normally. Even if that addr=
ess
> > is
> > > 0x62e31ec5 one byte earlier it is a failure.
> > >
> > > In other attempts I would change the ordering i.e. so the initrd is f=
irst
> > > at $loadaddr and then kernel and DTB, or DTB and kernel. If I learned
> > > anything it is that compressed initrd must be loaded to a span of mem=
ory
> > at
> > > least the size of its uncompressed length, and this is also true of t=
he
> > > compressed kernel vmlinuz even though booti documentation vaguely inf=
ers
> > > that there is an area of memory specified for decompression - so a
> > > compressed kernel needs two times its uncompressed size is that corre=
ct?
> > > Also there's no hint anywhere if the device tree blob has special mem=
ory
> > > constraints but if it is not starting on some 16byte aligned address =
at
> > > least my superstition from observations in testing is that it is not
> > > successful... and now, where it ends (in the above example) and initrd
> > > begins seems arbitrary.
> > >
> > > Sure I could pad things out, they tend to work that way, but I would =
like
> > > to know "why?"
> >
> > I don't know why, but I imagine that Linux finds the initrd in one
> > case and not inthe other...does the kernel log give you any clues?
> >
> > Also, can you use U-Boot's 'md5sum' command or similar to check that
> > the initrd and DT are the same in each case?
> >
> > Also, you could use a FIT [1] rather than booti.
> >
> > Regards,
> > Simon
> >
> > [1] https://docs.u-boot.org/en/latest/usage/fit/index.html
> >

--=20
Tom

--9hl4y2qkUwZQOXPI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcMJoACgkQFHw5/5Y0
tyybSgv/Tz2CigdtaYb9L4ttjsERU3kSBezzdV6BdzYCjOpcoZi4OIpNApdk61sF
eE90aPFNEl6mb10tybzaUzelS+SPgymnrqaRlAC7agtM9/9w1/0Zb/MjQJoMreaa
4TAeT3aBnR9y8RYW8B309XY852VXKUVFZg7c0tI3Ct8YukOzDywbhFLk6cKgDW+L
lOPzQFqh+fOLSLzCFVy+P9yRtWKjXmXPd6zipZcHNuMJUlHM+5WWOK2S8plpwmVr
xsl+KgTu573DoIjFrIlZ+uBT3zEhui1fePfs3GOOAL7ZzrRD0ZtbL8SP+BJz5q/1
9EGVsFgptALbLIkIDPjV1K2S6JkKmj318JR6esNbvGdhG/9qWhGaZGoLMRyvjw5E
3tdVxzQ42sVwZ5607nt5hr5AooyZ20Xc429RCuKdHHSkkI9XkNWOrbSVjkPGgHur
NRPX2k5EpAmBjpuAD3Vz2sFAy/QDIkBVJ09wRDVKgDafDJrC1X9+DPJW55y3jH+r
t0d7xYha
=SuyB
-----END PGP SIGNATURE-----

--9hl4y2qkUwZQOXPI--
