Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4EBE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 20:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7560800D0;
	Wed,  8 Jan 2025 21:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P91r449L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB4788036B; Wed,  8 Jan 2025 19:37:36 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E368006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 19:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d8a3e99e32so1385056d6.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736361453; x=1736966253; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FKmFE83tqZXxsHoxDaL8x2a+qqWa0gfBtsAuhdFXLm0=;
 b=P91r449LYunM0uOOvzBVgJNlF+aRtgKYVoxqEcFsTawgM/VGXM9JOI7Q20KBtfVpAw
 BFr728B7w+Lzg285LB/S6nFqPStXFG1F9sDO9zI5pwdRdLSecG1iG+3+MByFfVXrtlIt
 B/U2JI59m1zQeaK4CnvCTtB5rapv2F3dqWggQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736361453; x=1736966253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKmFE83tqZXxsHoxDaL8x2a+qqWa0gfBtsAuhdFXLm0=;
 b=L3Fy7TK0ShUS4wEG0ncAwgR2I4OleAobi1vU8NP20skbz8CM46PqDjaB2QdQdDiSnn
 ZJDdVsypkbEHVImSiTsA+SS7cypWvv0sb4p2YKpQCZX0IXn6A/7CRjVMkb0ngxgZCIhk
 Q+Sm0wyjLoN/N1qtJLBxjTLkaezQIKz3MSHsiHrRCbNlM3vL9M1iSmfJgiXT2SZdVew6
 NUYjmtIsZuyxK873AfmLALF8Lbfl5+j9TfcbmzI4YDKsai+Z3RemTRBH226EcIXAtU65
 ryzK6eALyC17H7Jg+DxkbzxfBqrgJkoZjsVOLfGYA8e0skaNjh957xWrm6Sbb7Srbifq
 YOCQ==
X-Gm-Message-State: AOJu0Yws8ir9glyD+sSeuZ2lXreezlQMfQRUDEFrxJkyzlr7MNIFVQsV
 mno2EskJu671AQGSK64y13VUMSodVybRPb7lXJy3/0p55j2ZCHxqWZV/2Nj7vZ4=
X-Gm-Gg: ASbGncvY5qb15e5ffCGXskHj+bqSCOaa5uDZ+BKXrrjKklN2ve0lx8JjUgZkYt33LYe
 etEho7XNO3VwAN2QovXeOedOpGR9QdckqLuaqsBrysNmO2rBwef+74ffoV+hnXiU1ifX5WxnDJE
 xhIrg18BBCRfoaeFuD2nhSbs14QXGZnjYD0KUF5PqMhcQ0UTSowpS63ou4b6Rqm0z27wkUlmr2O
 JYscRlZQXBM0Uf5ZU+HPrTMKfL5yVJlv+QsmLPRimpJwBZXlerPCgk=
X-Google-Smtp-Source: AGHT+IFD6qgIXb7GhWXQ56vBWHPuXWQ5Ko57SFjOSR3/OKoJ3s7C73xI6143+9N990FA78B6bSw5tA==
X-Received: by 2002:a05:6214:d6a:b0:6d8:aeda:dd93 with SMTP id
 6a1803df08f44-6df9b285c0dmr71969406d6.39.1736361452898; 
 Wed, 08 Jan 2025 10:37:32 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6df99ff40easm11046456d6.3.2025.01.08.10.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:37:32 -0800 (PST)
Date: Wed, 8 Jan 2025 12:37:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Alex Shumsky <alexthreed@gmail.com>,
 Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Dmitry Gerasimov <di.gerasimov@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Dragan Simic <dsimic@manjaro.org>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Watt <jpewhacker@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Levi Yun <yeoreum.yun@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v2 00/33] upl: Prerequite patches for updated spec
Message-ID: <20250108183724.GP3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2nkNF7X64Pgbfe8c"
Content-Disposition: inline
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 08 Jan 2025 21:33:28 +0100
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


--2nkNF7X64Pgbfe8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 07:31:56AM -0700, Simon Glass wrote:

> The current UPL spec[1] has been tidied up and improved over the last
> year, since U-Boot's original UPL support was written.
>=20
> This series includes some prerequisite patches needed for the real UPL
> patches. It is split from [2]
>=20
> [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=3D438574&stat=
e=3D*
>=20
> Changes in v2:
> - Fix 'Emable' typo
> - Enable the command in cmd/Kconfig instead
> - Fix unbalanced {}
> - Add new patch to move x86 tables to use SZ macros
> - Use 4K instead of 4KB
> - Add new patch to enable bloblist on x86
> - Split this into its own function
> - Split prerequisite patches into their own series
>=20
> Raymond Mao (1):
>   bloblist: add api to get blob with size
>=20
> Simon Glass (32):
>   bloblist: Drop BSD license
>   bloblist: Make BLOBLIST_ALLOC the default
>   abuf: Provide a way to get the buffer address
>   abuf: Allow use in host tools
>   abuf: Provide a constant buffer
>   cpu: Provide a way to get the physical-address size
>   serial: Support info() method in ns16550 xPL with UPL
>   mkimage: Update map_to_sysmem() to match its prototype
>   x86: Enable meminfo command
>   x86: Show the timestamp counter with bdinfo
>   ofnode: Use 4K for a default tree-size
>   ofnode: Indicate when out of space in a few places
>   ofnode: Update of_add_subnode() to indicate name is alloced
>   boot: Rename fit_image_get_data()
>   boot: Rename fit_image_get_data_and_size()
>   boot: Update fit_image_get_emb_data to use abuf
>   boot: Use fit_image_get_data() to get data
>   boot: Update fit_image_get_data() to use abuf
>   test: Fix inpected typo in upl test
>   emulation: fdt: Relax condition for OF_HAS_PRIOR_STAGE
>   emulation: Use bloblist to hold tables
>   x86: Create more space for SPL with qemu-x86_64
>   pci: video: Set up the pixel-format field
>   x86: Show an error if video fails
>   x86: Support jumping to a UPL image
>   x86: Enable UPL handoff for SPL
>   x86: Move tables to use SZ macros
>   x86: Align the SMBIOS table to a 4K boundary
>   x86: emulation: Enable bloblist
>   dm: core: Clarify behaviour of ofnode_name_eq()
>   dm: core: Provide ofnode_name_eq_unit() to accept a unit address
>   dm: core: Provide ofnode_find_subnode_unit()

Setting aside the bloblist parts of this. The x86 parts (and pci: video)
are likely fine. I've commented about abuf now. I'm not keen, but I'm
not nak'ing all of the rename stuff. All of the dm stuff is still you,
and it doesn't look like there's anything behavior changing there, so
that's fine. The rest of the QEMU related stuff needs a think.

--=20
Tom

--2nkNF7X64Pgbfe8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd+xeQACgkQFHw5/5Y0
tyy2Kwv+IMoONx0gO895EDUaRs3XWniaW7i0KjtutfCcWA8y/WyJZZ4+Lt1hlXo/
g9YH71v/FKU/gmS0AyZ73xoWQvrFt5rWsnrgYRFjaDJoWNKIg1kXfLwbq4pdhq4N
MVU86sYoOWADVSFetgBqCkLiBAnh/2rwix7fSyEg1oQFk4anL7DDIN1C9TajY/6D
+5j+9FLH9tZhEFFUBVQ4MAvVhZOmsJWZ3VBNier887/9/hGIxv3o46O9GbQZ7sXF
MyIXZiZndIAlQjoBjeVJhqiD1ZCOznpYb3s6KHLOH/pEVomRtvfgdY6Fm1aBLcTt
rM4E2o5ifETYzxRYj9jC6Pvd3UoQTHma4r7pvHLABIbToamwSQTVibt4xEF3eu83
igfiqHxmVFKdLWJ2Pbyusl2qld5n98A1oAlO5pCY++8uRuP9ijDOwXnJlYaEq/Zm
fO/OZLllQdIHODQBA38Lqlg7twp/ex5nDK0qhSkaYYxfKBi0mR0l0mPc6HbC4pOn
o7M4f8BJ
=jonc
-----END PGP SIGNATURE-----

--2nkNF7X64Pgbfe8c--
