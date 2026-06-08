Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70302CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D3B846E6;
	Mon,  8 Jun 2026 16:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ooUMloM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DFC846E6; Mon,  8 Jun 2026 16:05:00 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471AA83EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6b554044fso3382362a34.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780927497; x=1781532297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d7BP8tOCqMkOtIPQ8oGCqqkwl8tF0i263R1hF1LUlAA=;
 b=ooUMloM0h0turJek0A/PbtRDM8SBMKlKULuj2XhpCpIGFqONu646APwpB470anrYS+
 xXEcmFoWIcPo4X2+1Zi58V6ePuw8MMK+2DRkShU4b/qJnU828m4dsGCqpZ01OORerGkL
 S13lJsf/vf2vv2kwlrT2beBOvC8q33mRlsLDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780927497; x=1781532297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7BP8tOCqMkOtIPQ8oGCqqkwl8tF0i263R1hF1LUlAA=;
 b=mXp0rIU+kJS5r2bAwfO+VLbIiBStTArG1phvua1JzM+3NmxhmTT2GSz1NuC6I2zRsM
 v/loQlPD9dlJLzq9Q7p0AEVz2lME+yV3TJmtp8aayThnSY53VzEppcGEi9LNNlvPLm9H
 fjjvBf6xNUE+SSI2PYbwuAToz6MTBBLI33Rk9CA9W/4Eu1yjqOfvTUFmQqxC/qwYcfo1
 zaUC2Q8Rrdaq5uG8jFKqBpAx+2Nrxz0bMO0DNWGnKb7ChAjviO8bKAg2L7aUJI0Gf6fU
 bNFAdQs+198o33gOjzvDmv3MxKjUjn0paji4WNXRh82sI+pSTokKFW44bk8LHqJgJixK
 Z+hA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SWJbcU9nqPF4Ycq/2RZkcZHZjgha/zpOuk0SxquhEvYlnnE3vlGzl+oaUYxdcV/eyJ2UdOuc=@lists.denx.de
X-Gm-Message-State: AOJu0YxLEqTIlGhm4ss68fqnuY2ZGxYZ+ceEcgnYUneL8hK9+PVrrvaW
 YaXuFCC8cgSmwds3TnLBw6fxoSp2XkdQ0Nz6/g4jpBcLzDPXCX7AKXRoNa0LWQQ2Vbs=
X-Gm-Gg: Acq92OFmEZuyvrqqiL7ZtRAJue52KyhIEy8Z5s3BYojJBqA+j3XTpKFB6P9YdtbeE9z
 3BlzCe1xczJCDBNWCIK+k/hXFcxYibYNREUHv19pnVCi68ViUpiJ3Jzknf8xynFXOLRHknzYa5m
 Tit2YK2YqMuKTh8LhgFkqeq3dQO358qLsKuE1eqv2f89+mw0VmJ6gjpO7E6dDv3kt8H8bNcYT0Y
 /zFkqR/MSMq06vu8AHTMQpwsir54W7fQZ89yQRpeQx7R3iqCfCwxJpl5oRKK0z+oPIaJ1h8gWA0
 5XXcLalTvXxNcMlfq4E58WhiSzzSF73TQuMvkwvR6rK4/E46WEKz3ICk+WoiUypkwDJDv2twNyC
 Fxqv99MDSO68IeggDcuxJPvIjqZqXZLW0Q8wExo73iu/FIjKvOztcLuZM7jwdiqiWjMYeD0noz/
 twS7n8mCF7V7+s+FimCt9nBAUToMwgZTO37/7p/vcbQCf9VAQfDJa2PLyDIeCBJ251VhroLSM6B
 AyYI54E8UnNerfxw1hr3qvkvvEKNG20HpTR1cI3RqUCGzBAy7dWJFWljxDbUA==
X-Received: by 2002:a05:6830:67f7:b0:7e6:eb9c:3781 with SMTP id
 46e09a7af769-7e70c7c99d1mr10464319a34.12.1780927496849; 
 Mon, 08 Jun 2026 07:04:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e7925410sm12068235a34.21.2026.06.08.07.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:04:56 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:04:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Daniel Palmer <daniel@thingy.jp>, sjg@chromium.org,
	u-boot@lists.denx.de
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
Message-ID: <20260608140454.GH382693@bill-the-cat>
References: <20260608130606.121031-1-daniel@thingy.jp>
 <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1ZKB2vsEUL4leMyd"
Content-Disposition: inline
In-Reply-To: <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
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


--1ZKB2vsEUL4leMyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 03:59:11PM +0200, Quentin Schulz wrote:
> Hi Daniel,
>=20
> On 6/8/26 3:06 PM, Daniel Palmer wrote:
> > - CONFIG_LOADB causes the xyzModem code to get built and that code depe=
nds
> >    on CONFIG_CRC16. If you don't have something else that selects CONFI=
G_CRC16
> >    you can unselect it and then the final link will fail:
> >=20
> >    LD      u-boot
> > /usr/bin/m68k-linux-gnu-ld.bfd: common/xyzModem.o: in function `xyzMode=
m_get_hdr':
> > u-boot/common/xyzModem.c:388:(.text.xyzModem_get_hdr+0x17a): undefined =
reference to `crc16_ccitt'
> >=20
> > - Add CONFIG_YMODEM_SUPPORT, make that select CONFIG_CRC16 and make
> >    CONFIG_LOADB select CONFIG_YMODEM_SUPPORT.
> >=20
> > - SPL/TPL already have Kconfig symbols for ymodem support but the spl
> >    ymodem code has issues building in the TPL phase and doesn't seem to
> >    be used:
> >=20
> > /usr/bin/aarch64-linux-gnu-ld.bfd: common/spl/spl_ymodem.o: in function=
 `spl_ymodem_load_image':
> > u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xdc): =
undefined reference to `spl_load_simple_fit'
> > u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xdc): =
relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `spl=
_load_simple_fit'
> > make[1]: *** [scripts/Makefile.xpl:546: tpl/u-boot-tpl] Error 1
> >=20
> > - Remove the ymodem symbol entirely for TPL.
> >=20
> > - Select CONFIG_SPL_CRC16 for SPL.
> >=20
> > - Finally, since everyone is now using the ymodem support symbols remove
> >    the special rule for loadb in the makefile.
> >=20
>=20
> When you need to list what you're doing in a commit log, it usually means
> you should be splitting the content into multiple separate patches (in a
> single series is usually fine/recommended).
>=20
> What I could identify (slightly reworked, which better match how *I* would
> write the patches):
>=20
> - changes made to common/spl/Kconfig.tpl with the justification given abo=
ve,
> - adding the missing CRC16 dependency to CMD_LOADB,
> - adding missing SPL_CRC16 dependency to SPL_YMODEM_SUPPORT (possibly
> squashed with the CMD_LOADB+CRC16 patch above, I'm undecided on what's be=
st
> here),
> - create new YMODEM_SUPPORT symbol and migrate CMD_LOADB + common/Makefile
> to use that,
>=20
> This makes it clearer what the purpose of each individual commit is:
> - remove dead code
> - fix existing support for CMD_LOADB,
> - fix existing support for SPL_YMODEM_SUPPORT,
> - quality of life improvement by migrating the CRC16 dependency from
> CMD_LOADB into a new symbol + making use of that new symbol in
> common/Makefile instead of "hardlinking" CMD_LOADB with building xyzModem=
=2Eo
> (which is quite honestly confusing, so good to see this fixed!),
>=20
> What do you think?
>=20
> > Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> > ---
> >=20
> > v2: Fix the SPL/TPL stuff as brought up by Tom. This opened a can of
> >      worms when I tested if the TPL builds or not so I decided to just
> >      remove the TPL ymodem stuff. It didn't seem to be used in any
> >      defconfig and there isn't a CONFIG_TPL_CRC16 to enable the needed
> >      crc16 code anyhow so maybe it hasn't been used for a while?
> >=20
> >   cmd/Kconfig            |  1 +
> >   common/Kconfig         |  4 ++++
> >   common/Makefile        |  1 -
> >   common/spl/Kconfig     |  1 +
> >   common/spl/Kconfig.tpl | 11 +----------
> >   5 files changed, 7 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index c71c6824a196..503fc51f6bb4 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -1412,6 +1412,7 @@ config CMD_W1
> >   config CMD_LOADB
> >   	bool "loadb"
> >   	default y
> > +	select YMODEM_SUPPORT
> >   	help
> >   	  Load a binary file over serial line.
> > diff --git a/common/Kconfig b/common/Kconfig
> > index 8e8c733aa295..0db74aa580e4 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -1274,3 +1274,7 @@ config IO_TRACE
> >   	  confirm that the driver behaves the same way before and after a co=
de
> >   	  change. To add support for your architecture, add '#include
> >   	  <iotrace.h>' to the bottom of arch/<arch>/include/asm/io.h and tes=
t.
> > +
> > +config YMODEM_SUPPORT
> > +	bool
> > +	select CRC16
>=20
> Is there any reason we wouldn't want the user to be able to select this
> independently from CMD_LOADB?
>=20
> I'm asking because this is both invisible (no prompt) and has no help tex=
t.

I think this should stay hidden as it's *not* hidden for xPL as it's the
equivalent of CMD_LOADB but it's the symbol for the library portion. As
a maybe clearer result, maybe the library symbol should be
XYZMODEM_SUPPORT / xPL_XYZMODEM_SUPPORT, to control building
common/xyzModem.o ?

--=20
Tom

--1ZKB2vsEUL4leMyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaibMBQAKCRAr4qD1Cr/k
Cqi/APsF6BDaoAuaTy9YuVbGujRgy37xQp+4uYAJ6kvpIfjaxAEArnUDBhyfzMI/
2imkQJ2rIgLUgW43OrXbEjM02GQ9mgw=
=DYiJ
-----END PGP SIGNATURE-----

--1ZKB2vsEUL4leMyd--
