Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6BCC27C78
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 22:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9719988059;
	Sat, 22 Jun 2024 00:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gFbVjM8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 161D987C69; Sat, 22 Jun 2024 00:12:16 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9D5E87FBC
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 00:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-254aec5a084so1331522fac.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719007932; x=1719612732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G/GyCOeWrloj20LoCUfjUNyANeC849oxm99WXZ/zkSI=;
 b=gFbVjM8SUOPTIVWJgMVBJ1F2OEbzAwAp5ZDEGHNs8mk3XnJq/D64LILAGjtoTwjX1K
 aXphVrop4OqTiHrptysrJlWdyz2xSAiZmDKKIKqtN8hIp8ZoCxDiP51ibcwv2cYdOfaS
 JBo+FewdpNUUEglUQ2iMHKiV3yDYbP2u8TPFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719007932; x=1719612732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/GyCOeWrloj20LoCUfjUNyANeC849oxm99WXZ/zkSI=;
 b=mMn2C4MDrmJM4HkhU8xecqXhxc6/udMRECyWe7bJDnb4PiWLFtvpFs8W6MbFp0VASf
 DSX4BB3Tpc3e3sjIrg+LV4F4Zix1j4KYhb0CIb/e979Ug8uaeetQ25xPxQWfzusjsm77
 +DTSy9jNMKQ1WX6OHTVljz8eKLBylmjW+YPJO/thFcNREEfd/eVFwwkYH/9t+S7Ybf55
 897hHSuj4bIezR3O6GO+kWwC3eLH4tg5q9Irw8Ebz6AgozarOll3XnMFIUOQJJ686q31
 ytKYMhnm5Wmrm4sQj3xFc3KVsV4DL11v4Gxpn2BxXShou42a9QKKY2K9BpMnZgn4llUJ
 jfTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGWf8AY83spyiyDHZ8N48ejqWfRC1vN/hDjJZnB76IL+E8zCuLev3mn5BHsMhLo7AilPVBHfau3WlTOj8iVPHKB1TKCQ==
X-Gm-Message-State: AOJu0Yzqg4/u7pM6u7FL+JPy6nVAmrp0KCnMcQKqeqZL4XH5cFZoQZzS
 QpskYLSl2IatvL6pEnllRGPXP+DIcLfvMGMNAGA2nfhPa6ySRTw2WFwICN8KmT8=
X-Google-Smtp-Source: AGHT+IHuhXdrX8OgUvzPo7K6RZMtEdm1H3NXFyIYn7RjrUc9x2EuotPhw347g2vR6doCTplrj/zxdw==
X-Received: by 2002:a05:6870:e2c9:b0:254:c16b:10ad with SMTP id
 586e51a60fabf-25c948ec9d2mr10530455fac.9.1719007932389; 
 Fri, 21 Jun 2024 15:12:12 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd4b832ebsm596847fac.46.2024.06.21.15.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 15:12:11 -0700 (PDT)
Date: Fri, 21 Jun 2024 16:12:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
Message-ID: <20240621221209.GD68077@bill-the-cat>
References: <20240618141524.GO68077@bill-the-cat>
 <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
 <20240619153207.GF68077@bill-the-cat>
 <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
 <20240620231943.GT68077@bill-the-cat>
 <CAFLszTgA6Gc1T55v07skZQ3U=_JuM7yW9aTxmAtXsoLTbSOtdQ@mail.gmail.com>
 <20240621160514.GY68077@bill-the-cat>
 <CAFLszTi45oeCoLRQK_noh2dHXTMGGteadT83M9Ce9cC2fcR9wA@mail.gmail.com>
 <20240621191915.GZ68077@bill-the-cat>
 <CAFLszTjdDSVsMPTU0OU09JrD0Njxb6NXmb_KKk4gUXC_JAgv8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oECOVSKXMeI/AgEz"
Content-Disposition: inline
In-Reply-To: <CAFLszTjdDSVsMPTU0OU09JrD0Njxb6NXmb_KKk4gUXC_JAgv8A@mail.gmail.com>
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


--oECOVSKXMeI/AgEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 01:38:07PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Jun 2024 at 13:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jun 21, 2024 at 11:55:42AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 21 Jun 2024 at 10:05, Tom Rini <trini@konsulko.com> wrote:
> > [snip]
> > > > Yes, I very much do not like guessing about 3 numbers instead of
> > > > guessing about 1 number and using the standard mechanism we already
> > > > have. Please use BOARD_SIZE_LIMIT as this is the standard mechanism=
 to
> > > > enforce size limits on U-Boot itself.
> > >
> > > If it were that easy I would have sent a patch :-)
> > >
> > > Here is the map for this board:
> > >
> > > ImagePos    Offset      Size  Name
> > > 00000000  00000000  00800000  rom
> > > ff800000   ff800000  00001000  intel-descriptor
> > > ff801000   ff801000  001ff000  intel-me
> > > ffef0000   ffef0000  000999f0  u-boot-with-ucode-ptr
> > > fff899f0   fff899f0  00005554  u-boot-dtb-with-ucode
> > > fff8ef50   fff8ef50  00000000  u-boot-ucode
> > > fff8ef50   fff8ef50  00000571  fdtmap
> > > fff90000   fff90000  00010000  intel-vga
> > > fffa0000   fffa0000  0002fc94  intel-mrc
> > > fffcfc94   fffcfc94  00000000  private-files
> > > fffff800   fffff800  00000070  x86-start16
> > > fffffff0   fffffff0  00000005  x86-reset16
> > > fffffff8   fffffff8  00000008  image-header
> > >
> > > What limit should I set on what?
> >
> > Is this a trick question?
> > $ printf %d\\n $(( 0xfff90000 - 0xffef0000))
> > 655360
> >
> > Of course since we're less than that today, you can reduce it by
> > whatever other magic numbers I'm not seeing but are part of your assumed
> > sizes.
>=20
> That limit is on u-boot-nodtb.bin. Even with a size (for that file) of
> 634816 it doesn't fit. I need to calculate a size based on the size of
> the dtb and the microcode...which of course can change.

Yes, and you're able to assume some size for them, which is what you
put in the dts file?

> > > - the U-Boot is the thing you are wanting to limit
> > > - the dtb has microcode added
> > > - the ucode is empty in this case
> > > - the fdtmap is variable in size
> > >
> > > So this all seems a bit backwards. The actual limit is that
> > > (u-boot-with-ucode-ptr + u-boot-dtb-with-ucode + u-boot-ucode +
> > > fdtmap) fits in the space available. Note that some boards don't have
> > > intel-vga or intel-mrc.
> > >
> > > With the other patch I sent I can have a sensible limit for all x86 b=
oards.
>=20
> Did you miss the comments above?

No, I saw them. They're similar constraints to other systems.
>=20
> >
> > And you can set the same sensible limit with the existing mechanism with
> > the bonus of it not making x86 different from the rest?
>=20
> I understand that it is possible to set a limit for u-boot-nodtb.bin
> but that is not accurate nor sufficient in the presence of blobs. The
> solution belongs in Binman.

Your series puts reasonable estimates on the size of the blobs and then
will give a failure such as:
binman: Node '/binman/rom/intel-vga': Offset 0xfff90000 (4294508544)
overlaps with previous entry '/binman/rom/fdtmap' ending at 0xfff902e1
(4294509281)
Which is not as nice as (I just threw in a limit):
u-boot-nodtb.bin exceeds file size limit:
  limit:  0x927c0 bytes
  actual: 0x9a810 bytes
  excess: 0x8050 bytes
make[1]: *** [/home/trini/work/u-boot/u-boot/Makefile:1359: u-boot-nodtb.bi=
n] Error 1

And tells us how much we need to get back size wise. Aside from when
using the actual blobs (and in which case a real error will be shown
when trying to use them), it's always about making an estimate on the
part of the system that we control.

--=20
Tom

--oECOVSKXMeI/AgEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ1+rUACgkQFHw5/5Y0
tywMYQv+I6zrswOPqW3jUNjW6NivNLsc3B4mzDmeFUAO5g8ua/wBGv9zZ6+jDo4z
DlqHfJ9xbqEh56zKQfjOQximtF4apEZOT5MXTzuj7R1x15lhySWpiT17ccRJ8G11
wu3lv9ekJgOxSY0xZs38GE3Lf0cfQFJdkTrgvOu+csotGWotZoVK3v0IfC1Z0NHL
uauTXYmYxxOv+12A5DGM+TcdDHGqtfhU5N5xtPGk4Vzwz3SDw9mcqsHznvXGgtvA
uzrtG73NSr9veM5iXJBcABZvjFrt9ikYgRHvBV0PhRryU4hJK3sdG8Zjt6FE+t+8
cPCJ6id5/tDNbzkLzYAiYAh2EPY/CuJYMXtzzra9b+c+8jPFEl7WUq1shdHGVbsf
cV3gBrBlKrIhGcIxr79Fb8vlHJMz06ZX6AmoiuTgNVVXFLnLYJrY68iczc5cJky3
v2mdbG3Vmr1ftbt9hvOdz+X7vEe/Mi5YWQfzOU8OtMdJC8OOPsfvpMjF7td92MuQ
ZncArhEg
=YUts
-----END PGP SIGNATURE-----

--oECOVSKXMeI/AgEz--
