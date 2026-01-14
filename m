Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19CFD37E33
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EDD7808AF;
	Wed, 14 Jan 2026 15:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aSM1P1/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247E883015; Wed, 14 Jan 2026 15:17:43 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB0F8063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7cfd0f2ef93so98980a34.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768400259; x=1769005059; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FKCJcV/tYzQSHUcAP1/gI4LPZV+jr+kTlc6GiJYZkDk=;
 b=aSM1P1/Nd7OOrvP2XjkeP5XzWDtmlbA413rS7hUxzy3mq4o+uJ0tp/AW44iuiYOJAn
 6blK7F+ceM5sQtvtatWFM6ByM8GrNtlvB4PNwm17GmMoYupaY2SRlQi670tGlhgj/kkb
 4HzGpmMW56j8qnIupUq7SPeckM9GU0PHn0YW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768400259; x=1769005059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FKCJcV/tYzQSHUcAP1/gI4LPZV+jr+kTlc6GiJYZkDk=;
 b=RbiHRJ19OGsG+oRdBQ/k1wccIE4+BsImZuwSJCLOu6SLhtWuT/6qw3RAjXNRBwbuJ8
 el+a+qiOwxLDsfyAcnSu0iTRcnjC+rts1VMMzY/GlbtGIHbBnEu6nGkPGzalyqLtaMWB
 7J0Lx0v6e2XZziVweUh63khBTjjoqO5V4nvX6Q4o+ioI3PyMiQPWHAqtJMHKMGtpnXe6
 ExD6KQBgVhnFGpxcizAXgZQyTAsaHngYiup47fH6D+AyRkk1saTC6aBhtkIDDl7qsFD8
 +nj3VwYfZ5m2EauKegPHniE8ha1qPQicgWtXpFSLAnG0T6nxyV+qSv+9jFagmslP6QiR
 J9aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhLfizj1GzwEy3iFwXnK8lufLOTil/5duClbqLDGA3nyYeT+yMaW8FmiG8F6riJ3PbP3ItiCc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1TcSBweW0FoaYUF1YLur9Qu9pJ+Xk6+6z8Q+5UhTEcPWttWdV
 CUHv/DcvJqFhth44x3Pt1g25W51hYgLIKHz7zl8fgUV+ipwA2E4kGsjPrVwf9FNT330=
X-Gm-Gg: AY/fxX6+2T86QRVSFY2tL3TTd3Kh0gR2iQbTG39ATq0Hd/joSBe5m9lLRgX6bqSg3UP
 IFhNe57YPWeHGFKX/2h/0kZKXSHTGh3J/y4PmSMlH7vnwE0Wrz8ZkUjpolnYRb4vnPoZshUV0qg
 Qt4j+sj9wR98CVdvT8YGP2BNsOeIjF6CHxTDnvjkom4rHTzJSJj9Yr50ltY38w63BlFIdBgm/e9
 KpcG6wA4MI/mcGnN2Ag+BBOgJInx/MIMEOS0lymlV6A7suvbXrOi+WGjL+X/gCDKpMITloM/n26
 v07yjGDs+SrOhIb4PnF7p3QZ5whMB87HsAoso2Jmn5yosH4C/VyxNy84LVLnAIE8JSQLc7gNJla
 k9mo3lNoLbnSd5fgt5PDLZC28gGc0dc9OP4H7Ud2UTxh79WWwdt+CYsJrpA145oVPPQMmN1z3u+
 EDIPjyj9WRjXiOvGwfrkdGb9vJIHwEzJq4OF7/qv+AuF4u7BM4rm5xgNytJQETYsYpkP46ZW55D
 /Te0nZ1M3v2A8r81zptQtfy/gPtGDFnsaJOwVKikw44Oo+2Lw==
X-Received: by 2002:a05:6830:4d88:b0:7c7:6bb4:1197 with SMTP id
 46e09a7af769-7cfcb65e843mr1177314a34.24.1768400258510; 
 Wed, 14 Jan 2026 06:17:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce47802966sm18058099a34.4.2026.01.14.06.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:17:37 -0800 (PST)
Date: Wed, 14 Jan 2026 08:17:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
Message-ID: <20260114141735.GA3416603@bill-the-cat>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
 <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
 <20260112164854.GQ3416603@bill-the-cat>
 <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
 <20260112220536.GU3416603@bill-the-cat>
 <66ec9e5b-1488-4e35-9a56-91d4b70ff0fa@mailbox.org>
 <20260113150024.GX3416603@bill-the-cat>
 <bbbb72e7-a7f5-48b0-b3e2-fcc83d5b1658@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o7xf53nYBT3dAn0b"
Content-Disposition: inline
In-Reply-To: <bbbb72e7-a7f5-48b0-b3e2-fcc83d5b1658@mailbox.org>
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


--o7xf53nYBT3dAn0b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 05:34:46PM +0100, Marek Vasut wrote:
> On 1/13/26 4:00 PM, Tom Rini wrote:
> > On Tue, Jan 13, 2026 at 12:56:23AM +0100, Marek Vasut wrote:
> > > On 1/12/26 11:05 PM, Tom Rini wrote:
> > > > On Mon, Jan 12, 2026 at 10:56:04PM +0100, Marek Vasut wrote:
> > > > > On 1/12/26 5:48 PM, Tom Rini wrote:
> > > > > > On Mon, Jan 12, 2026 at 06:38:19PM +0530, Anshul Dalal wrote:
> > > > > > > On Mon Jan 12, 2026 at 3:41 PM IST, Beleswar Padhi wrote:
> > > > > > > > The OMAP2 SPL linker script (also used for K3 platforms) cu=
rrently uses
> > > > > > > > a 4-byte alignment directive after the __u_boot_list sectio=
n. This
> > > > > > > > alignment directive only advances the location counter with=
out padding
> > > > > > > > the actual binary output.
> > > > > > > >=20
> > > > > > > > When objcopy extracts u-boot-spl-nodtb.bin, it includes onl=
y actual
> > > > > > > > data, stopping at the last byte of __u_boot_list (e.g., 0x4=
1c359fc),
> > > > > > > > not an aligned address (e.g., 0x41c35a00). So, when the FIT=
 image
> > > > > > > > containing device trees is concatenated to the SPL binary, =
it gets
> > > > > > > > appended at this unaligned file size, causing libfdt valida=
tion failure.
> > > > > > > >=20
> > > > > > > > To fix this, move the alignment directive into the __u_boot=
_list section
> > > > > > > > itself and make it 8-byte aligned as per DT spec. This forc=
es the linker
> > > > > > > > to include padding as part of the section data, ensuring ob=
jcopy
> > > > > > > > includes the padding bytes in the binary and the appended F=
IT image
> > > > > > > > starts at an 8-byte aligned boundary.
> > > > > > > >=20
> > > > > > > > Reported-by: Anshul Dalal <anshuld@ti.com>
> > > > > > > > Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N1=
6ZO19E@ti.com
> > > > > > > > Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream versi=
on v1.7.2-35-g52f07dcca47c")
> > > > > > > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > > > > > > ---
> > > > > > > > v2: Changelog:
> > > > > > > > 1. Get rid of extra ALIGN() directive, replace it with a co=
mment
> > > > > > > > 2. Carry Reported-by, Closes and Fixes tag.
> > > > > > > >=20
> > > > > > > > Link to v1:
> > > > > > > > https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@=
ti.com/
> > > > > > > >=20
> > > > > > > >     arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
> > > > > > > >     1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > >=20
> > > > > > > > diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/=
mach-omap2/u-boot-spl.lds
> > > > > > > > index 3bb759d8a1c..5ad169a37b7 100644
> > > > > > > > --- a/arch/arm/mach-omap2/u-boot-spl.lds
> > > > > > > > +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> > > > > > > > @@ -35,9 +35,13 @@ SECTIONS
> > > > > > > >     	. =3D ALIGN(4);
> > > > > > > >     	__u_boot_list : {
> > > > > > > >     		KEEP(*(SORT(__u_boot_list*)));
> > > > > > > > +		/*
> > > > > > > > +		 * Ensure 8-byte alignment at the end of the last sectio=
n before
> > > > > > > > +		 * DTB is appended, to satisfy DT spec alignment require=
ments
> > > > > > > > +		 */
> > > > > > > > +		. =3D ALIGN(8);
> > > > > > >=20
> > > > > > > I wonder if there could be a better way to handle this constr=
aint,
> > > > > > > currently we have two major problems with this approach:
> > > > > > >=20
> > > > > > > 1. All platforms facing similar alignment issues would have t=
o modify
> > > > > > > their linker scripts.
> > > > > >=20
> > > > > > Yes, agreed.
> > > > > >=20
> > > > > > > 2. The FDT only gets appended directly to SPL binary in cases=
 of
> > > > > > > CONFIG_SPL_SEPARATE_BSS. Otherwise we do (SPL binary + BSS + =
FDT) as per
> > > > > > > the $(obj)/$(SPL_BIN)-dtb.bin make target. Which means BSS wo=
uld have to
> > > > > > > be 8-byte aligned as well as the SPL binary.
> > > > > > >=20
> > > > > > > I wonder if we could have a new make target for say
> > > > > > > u-boot-spl-nodtb-aligned.bin which is just (SPL binary + opti=
onally BSS
> > > > > > > + padding for alignment) and at runtime we modify the fdt add=
r in gd to
> > > > > > > point to the correctly aligned address?
> > > > > >=20
> > > > > > Looking back at
> > > > > > https://lore.kernel.org/all/87h65ihumb.fsf@bloch.sibelius.xs4al=
l.nl/ we
> > > > > > can use dd as a portable way to ensure that a file ends with 8-=
byte
> > > > > > alignmnent by doing:
> > > > > > dd if=3Dtestfile bs=3D8 conv=3Dsync of=3Dtestfile_pad
> > > > > > and we get a zero-padded 8-byte aligned output file, and at the=
 end of
> > > > > > that we can concatenate our dtb.
> > > > > You still need to make sure there is a symbol generated by the li=
nker that
> > > > > points at the END of the u-boot binary . dd happens too late, so =
you cannot
> > > > > do that. The alignment has to be done by the linker, in the linke=
r script I
> > > > > think.
> > > >=20
> > > > I guess the question is are we:
> > > > a) Look at $sym for device tree, and so $sym must be 8-byte aligned.
> > > > b) Look at end of self, rounded up to alignment, for device tree
> > > > c) (a) on some platforms (b) on other platforms
> > > > ?
> > > $sym is at the end, which is not always 8 byte aligned . See lib/fdtd=
ec.c
> > > for the relevant code:
> > >=20
> > > 1243 static void *fdt_find_separate(void)
> > > 1244 {
> > > 1245         void *fdt_blob =3D NULL;
> > > 1246
> > > 1247         if (IS_ENABLED(CONFIG_SANDBOX))
> > > 1248                 return NULL;
> > > 1249
> > > 1250 #ifdef CONFIG_XPL_BUILD
> > > 1251         /* FDT is at end of BSS unless it is in a different memo=
ry
> > > region */
> > > 1252         if (CONFIG_IS_ENABLED(SEPARATE_BSS))
> > > 1253                 fdt_blob =3D (ulong *)_image_binary_end;
> > > 1254         else
> > > 1255                 fdt_blob =3D (ulong *)__bss_end;
> >=20
> > OK. And why can't we make that check at $sym rounded up, and ensure our
> > build targets pad? Going back to the commit message here, it's easy to
> > tell the linker to place $sym at the right spot, but it's hard to make
> > sure the output is padded. So having typed all that, maybe we need to
> > do:
> > d) Update linker scripts to ALIGN(8) the above symbols and have the make
> > targets use dd to ensure padding prior to concatenation
> > ?
> d) looks like what we should do, yes

Poking at this harder, I'm not actually sure we need to use dd at all,
but we do need to fix our linker scripts, and then going back to when
Ilias reworked and cleaned up a bunch of them, get the changes reviewed
by the toolchain experts he got ahold of :)

--=20
Tom

--o7xf53nYBT3dAn0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWelewAKCRAr4qD1Cr/k
CjUoAP0RP5OBt0Lq9x99XzcMc/gSQw4Rcns4TfuzFffpunc2GwEA7CKzQ43DXt9m
ZraF6HujeX3bEYlapZpF3K4Mh7kFbwQ=
=yS36
-----END PGP SIGNATURE-----

--o7xf53nYBT3dAn0b--
