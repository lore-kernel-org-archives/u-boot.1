Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0EACD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA988466E;
	Mon,  8 Jun 2026 16:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e7Kz7myp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E96584704; Mon,  8 Jun 2026 16:35:36 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E4D9841C2
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6f922e49fso3182999a34.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780929333; x=1781534133; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DFxZXn6oBtxVz+3M1gMByjv2X7DpCOHTv6zNpwptOVw=;
 b=e7Kz7mypJuYaU8CgSezUikqZWljOrklcY/bXnC4kZBGYsCgHz/O7iO1OQsNgtpju6P
 O3qGfXVCPc+2U+dkxN7YF5G5Jbuq5dhDKWVVfM4W2IvDA1rj7y/cFYKDaJ4Uwp6ZUi3m
 i4lMqKS5FspchdtZNSe4CMebox1olvGK1Aulk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780929333; x=1781534133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFxZXn6oBtxVz+3M1gMByjv2X7DpCOHTv6zNpwptOVw=;
 b=l4T+YLVDrxmGLJ8mVLzWAL/6RQXytgfwwKO36lEVU/Z1IFIjqsGAtoS9/mmuXr3WuW
 RD8dKVO8hu7OgkJrKc/4KAbBu4zBoDPNNbqqgwr4BV/4Fzf7b8YSdEahP+z85OuxbplO
 vn29omzpxnf/13cThq33K6zzf0w0L0qz/sh3mlZlHNE5LmXpD7v+pjosXst2srA5o+2S
 KoQZnLmA1rGutUsaQH6mutcPhETJooFYfkmLWcz6JqI47FjLN2uR8FsuXMRAhFRZgFTr
 4Dv0eSH7xhE0XieVUjVJ5F/uMqeEk8sdSMH29LMRPmTnk51wcmZq1crHxvH0OVrBfMI6
 Xy8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VjmVF5E2V0vWPNXTRykllztuX0LsGwoyp5HvNdcXtsDfTO2GuF33dM8sipV7WmEEsuzWFSv0=@lists.denx.de
X-Gm-Message-State: AOJu0YwZPSOrTZnWgmj6eHkDPB7/icuWtfo5m8O8nqknPKwQtz/3sG7h
 sx4u9Qo2YFLm1ebgKi0ifmGx+6AFc6qK8A9Fu6I6Nyk35eDdfYCtIKv0mqclZXkAF0w=
X-Gm-Gg: Acq92OHeCcMEFdX05vNg2LQaQkiOwAz8QV/VPkunSDlCbBvEe7xIl1tCLCooBopZ7e5
 NdEQN5/4b0ndQUR6lrX9yXtXmIUuvUax4s2zo71WMTAVFD/dbDmPYTVDiiKsE6KW5ht3sstqr10
 lqYvX9Chlse/kYG/DkHD1N8DwSZMoGwF+p+Iv4SdbDu1ixn1CMZxPyuqjVQoz5VXZh7qtXcHW8D
 Ccxl/WMFOb9c2RUdyIAANKXzYgfLHqJ9vnEFR1SO/zAcEIAs+SuhSnQgPTSt/Bmgnly1vtRU6E5
 dR4B72spNmkeoEgiDEyZ3mgckhZ8ZkdSunsKJtccPaue0J4tTH593s1xVmEIMG6mBmQmaJO/J/f
 gEypB+9uRdFxD1u31rL4ozhKMUon0/Lt6m0R6pA4pmT1nNCTorO9Wb293/hpf+mYGEnJnT9tXsT
 Ld2tDuJXJiRNYh72Dld8nBqDPuU2pg40VEUvALzUI4GivotgJPN7IULIj9Uw/8DFHQoRZy6NwyL
 ZJAErb52FeNS+iO5BEtgSYRj1VSnlt5nS7p+NY8weSEs3+ACV1414GrMumTC7zxWQTdlFw3
X-Received: by 2002:a05:6830:6b0f:b0:7e6:8955:c52d with SMTP id
 46e09a7af769-7e70c5addbemr9264041a34.5.1780929332667; 
 Mon, 08 Jun 2026 07:35:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e796c675sm12401139a34.24.2026.06.08.07.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:35:32 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:35:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Daniel Palmer <daniel@thingy.jp>, sjg@chromium.org,
	u-boot@lists.denx.de
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
Message-ID: <20260608143529.GL382693@bill-the-cat>
References: <20260608130606.121031-1-daniel@thingy.jp>
 <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
 <20260608140454.GH382693@bill-the-cat>
 <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ThrS9hEwe6ZfodGW"
Content-Disposition: inline
In-Reply-To: <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
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


--ThrS9hEwe6ZfodGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 04:22:41PM +0200, Quentin Schulz wrote:
>=20
>=20
> On 6/8/26 4:04 PM, Tom Rini wrote:
> > On Mon, Jun 08, 2026 at 03:59:11PM +0200, Quentin Schulz wrote:
> > > Hi Daniel,
> > >=20
> > > On 6/8/26 3:06 PM, Daniel Palmer wrote:
> > > > - CONFIG_LOADB causes the xyzModem code to get built and that code =
depends
> > > >     on CONFIG_CRC16. If you don't have something else that selects =
CONFIG_CRC16
> > > >     you can unselect it and then the final link will fail:
> > > >=20
> > > >     LD      u-boot
> > > > /usr/bin/m68k-linux-gnu-ld.bfd: common/xyzModem.o: in function `xyz=
Modem_get_hdr':
> > > > u-boot/common/xyzModem.c:388:(.text.xyzModem_get_hdr+0x17a): undefi=
ned reference to `crc16_ccitt'
> > > >=20
> > > > - Add CONFIG_YMODEM_SUPPORT, make that select CONFIG_CRC16 and make
> > > >     CONFIG_LOADB select CONFIG_YMODEM_SUPPORT.
> > > >=20
> > > > - SPL/TPL already have Kconfig symbols for ymodem support but the s=
pl
> > > >     ymodem code has issues building in the TPL phase and doesn't se=
em to
> > > >     be used:
> > > >=20
> > > > /usr/bin/aarch64-linux-gnu-ld.bfd: common/spl/spl_ymodem.o: in func=
tion `spl_ymodem_load_image':
> > > > u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xd=
c): undefined reference to `spl_load_simple_fit'
> > > > u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xd=
c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol =
`spl_load_simple_fit'
> > > > make[1]: *** [scripts/Makefile.xpl:546: tpl/u-boot-tpl] Error 1
> > > >=20
> > > > - Remove the ymodem symbol entirely for TPL.
> > > >=20
> > > > - Select CONFIG_SPL_CRC16 for SPL.
> > > >=20
> > > > - Finally, since everyone is now using the ymodem support symbols r=
emove
> > > >     the special rule for loadb in the makefile.
> > > >=20
> > >=20
> > > When you need to list what you're doing in a commit log, it usually m=
eans
> > > you should be splitting the content into multiple separate patches (i=
n a
> > > single series is usually fine/recommended).
> > >=20
> > > What I could identify (slightly reworked, which better match how *I* =
would
> > > write the patches):
> > >=20
> > > - changes made to common/spl/Kconfig.tpl with the justification given=
 above,
>=20
> And I also see a mention of CONFIG_TPL_YMODEM_SUPPORT=3Dy in
> doc/usage/spl_boot.rst that would need removal
>=20
> > > - adding the missing CRC16 dependency to CMD_LOADB,
> > > - adding missing SPL_CRC16 dependency to SPL_YMODEM_SUPPORT (possibly
> > > squashed with the CMD_LOADB+CRC16 patch above, I'm undecided on what'=
s best
> > > here),
> > > - create new YMODEM_SUPPORT symbol and migrate CMD_LOADB + common/Mak=
efile
> > > to use that,
> > >=20
> > > This makes it clearer what the purpose of each individual commit is:
> > > - remove dead code
> > > - fix existing support for CMD_LOADB,
> > > - fix existing support for SPL_YMODEM_SUPPORT,
> > > - quality of life improvement by migrating the CRC16 dependency from
> > > CMD_LOADB into a new symbol + making use of that new symbol in
> > > common/Makefile instead of "hardlinking" CMD_LOADB with building xyzM=
odem.o
> > > (which is quite honestly confusing, so good to see this fixed!),
> > >=20
> > > What do you think?
> > >=20
> > > > Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> > > > ---
> > > >=20
> > > > v2: Fix the SPL/TPL stuff as brought up by Tom. This opened a can of
> > > >       worms when I tested if the TPL builds or not so I decided to =
just
> > > >       remove the TPL ymodem stuff. It didn't seem to be used in any
> > > >       defconfig and there isn't a CONFIG_TPL_CRC16 to enable the ne=
eded
> > > >       crc16 code anyhow so maybe it hasn't been used for a while?
> > > >=20
> > > >    cmd/Kconfig            |  1 +
> > > >    common/Kconfig         |  4 ++++
> > > >    common/Makefile        |  1 -
> > > >    common/spl/Kconfig     |  1 +
> > > >    common/spl/Kconfig.tpl | 11 +----------
> > > >    5 files changed, 7 insertions(+), 11 deletions(-)
> > > >=20
> > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > index c71c6824a196..503fc51f6bb4 100644
> > > > --- a/cmd/Kconfig
> > > > +++ b/cmd/Kconfig
> > > > @@ -1412,6 +1412,7 @@ config CMD_W1
> > > >    config CMD_LOADB
> > > >    	bool "loadb"
> > > >    	default y
> > > > +	select YMODEM_SUPPORT
> > > >    	help
> > > >    	  Load a binary file over serial line.
> > > > diff --git a/common/Kconfig b/common/Kconfig
> > > > index 8e8c733aa295..0db74aa580e4 100644
> > > > --- a/common/Kconfig
> > > > +++ b/common/Kconfig
> > > > @@ -1274,3 +1274,7 @@ config IO_TRACE
> > > >    	  confirm that the driver behaves the same way before and after=
 a code
> > > >    	  change. To add support for your architecture, add '#include
> > > >    	  <iotrace.h>' to the bottom of arch/<arch>/include/asm/io.h an=
d test.
> > > > +
> > > > +config YMODEM_SUPPORT
> > > > +	bool
> > > > +	select CRC16
> > >=20
> > > Is there any reason we wouldn't want the user to be able to select th=
is
> > > independently from CMD_LOADB?
> > >=20
> > > I'm asking because this is both invisible (no prompt) and has no help=
 text.
> >=20
> > I think this should stay hidden as it's *not* hidden for xPL as it's the
> > equivalent of CMD_LOADB but it's the symbol for the library portion. As
> > a maybe clearer result, maybe the library symbol should be
> > XYZMODEM_SUPPORT / xPL_XYZMODEM_SUPPORT, to control building
> > common/xyzModem.o ?
> >=20
>=20
> I'm not sure to understand how the rename would help here? I'm assuming we
> have an issue of the symbol having a different meaning in xPL and in prop=
er.

To try and be clear, we don't have a symbol for common/xyzModem.o today,
I was suggesting introducing one as part of fixing Daniel's problem.

> If I understood correctly, YMODEM_SUPPORT in proper is for building the

In this v2, it would be for that, yes.

> library and using it, while in xPL it's both for building the library and
> add support for loading the next U-Boot stage over UART. Is this what you


Correct, xPL_YMODEM_SUPPORT covers both common/xyzModem.o (library) and
common/spl/spl_ymodem.o (user).

> meant? Are you suggesting we split "build library code" and "load next st=
age
> from UART" into separate symbols?

Thinking harder about the problem, yes. That would make things clearer
in the long term. Maybe even with a move of common/xyzModem.c to
lib/xyzModem.c (and yes bad filename, but matches the ancient upstream
its from I bet) and introduction of LIB_XYZMODEM (and xPL_LIBXYZMODEM)
which in turn selects the required CRC16 symbols.

> Also, lib/Makefile has
>=20
> obj-$(CONFIG_SPL_YMODEM_SUPPORT) +=3D crc16-ccitt.o
>=20
> which is.... odd? Shouldn't this handle the case of "missing" SPL_CRC16
> dependency? So: does it really not build if SPL_CRC16=3Dn but
> SPL_YMODEM_SUPPORT=3Dy? If it does not build, is bringing SPL_CRC16 too m=
uch?
> We only need crc16-ccitt.o I think, and this will also bring crc16.o into
> the SPL, which may not be desired (size increase).

This indeed looks to be another odd case to look in to and figure out
the right solution for.

--=20
Tom

--ThrS9hEwe6ZfodGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaibTMQAKCRAr4qD1Cr/k
CpD3AQDkTlhCyE49kiTW9K0FlPHjj/xIIhoq0Pf9R8pIg7GhBQEAwPjHo608Bl7d
nEs6MJX5kK9uqxO0862zYSGdViu/zwg=
=hQ0j
-----END PGP SIGNATURE-----

--ThrS9hEwe6ZfodGW--
