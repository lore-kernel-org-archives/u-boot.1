Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF34AE7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 16:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 198BA8036D;
	Fri, 27 Dec 2024 17:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TlozIYMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A8F8036E; Fri, 27 Dec 2024 17:19:25 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6148035E
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 17:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so580554585a.0
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735316362; x=1735921162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IG2lfSqlYZBb2HgzrY1RiUnqmO1p+5FOgH53hZ6HIlA=;
 b=TlozIYMdKzelu5tnd5B2uVK2ML15qW+ntkYF8wE7/XWkT0wF8JWBhDGwNAKA1Ii9gS
 6XJCob+Zs6XweWOQHz7jnO/e/nWCZD2/HvqoxjJ/3k05CZqsQ0zrzrK+0UcQ2RvKb8p8
 GJ+TTYBkryyD6sG2/OTDKC5wmBcsJOuPSx+aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735316362; x=1735921162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IG2lfSqlYZBb2HgzrY1RiUnqmO1p+5FOgH53hZ6HIlA=;
 b=msoVB7Q3oeJkvaTlZuZiMwdHrjj5bsh3EOxShWhny/D3Zpfo1YLn38H7MpS2ea245y
 z/h4/f1d+HwYxdhyksiMYZa1VWB79O0e3sJGHMDiejDG/DK+VZHGlKhOhM4OLl83OED6
 JaKgL3CYFKni550IwhtjVc134whOjQIR56IUAQL2jaOtKnddQVBzKuAPzrD7da3od+K8
 evQ1Qz0WdMVfpnSTpRr2Mwphbl9dsZlA4TLeJ6Oq1JCUODQsQxLXJ6mGxQ376GSvl3IX
 mjvpmTytOJOgBS2SX53CBZhL994A983hiTc8+YuXc6oee7uSwuSBKMulMdkC/Q0VkxDd
 Vn0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS9G94xz+v/sigh24mQ+gF3OUK1Po/CtnTR5Pf7iQ2bEoGgiAx8vSAO/aGkcb78T0J0ebpz9I=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7jE2mIJbb8rb0uiwRyyPjCRVUgh51VZqS+kZZUtVe26s0XWIo
 rFL4A4YW6H+zzarfOdq298+UtckH5wG9no6g4Ye2xaYozX7uekA4ue7v0p8eZ9U=
X-Gm-Gg: ASbGncsKJeZoUnljOxAz4voF/MKmWjnoEoe4XEQfQ1AabejObya57hsWiXVWZM39dJ2
 n00f6CJueJyCT1F+OejISvW4LfVLQM5vbwGY9FvSPYiSlfsDP3QLbOT8CtxpORtS3ctOC9KTAkA
 aevmPTf6F6P3METasewIsBr9XnVYTMZOgji4ermpuMSVCKYgf+1fvOhRt4V3xq/irCfsC8mGz0b
 D+oCjEddHXpraGWf6ZJk95ue51htdNWqD3u5+Hzoq/vmz+AYNFOY2Rnvg==
X-Google-Smtp-Source: AGHT+IEEJbcpx1fCoJUAlqLkYMHA+KjJw3g2ppqPDjHDbO/FZenVBmVLFeuiPLIMtXoh+sCcnFHrPg==
X-Received: by 2002:a05:620a:3904:b0:7b6:d9d2:d279 with SMTP id
 af79cd13be357-7b9ba7eae3amr3802948985a.45.1735316362402; 
 Fri, 27 Dec 2024 08:19:22 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac4cd55dsm709356385a.116.2024.12.27.08.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 08:19:21 -0800 (PST)
Date: Fri, 27 Dec 2024 10:19:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: David Feng <fenghua@phytium.com.cn>,
 Linus Walleij <linus.walleij@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, nd@arm.com,
 andre.przywara@arm.com, manish.pandey2@arm.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] board: vexpress64: enable bloblist for SPL handoff
Message-ID: <20241227161917.GD1505244@bill-the-cat>
References: <20241218153933.37649-1-harrison.mutai@arm.com>
 <20241218153933.37649-5-harrison.mutai@arm.com>
 <20241218163126.GG1505244@bill-the-cat>
 <8eaca7d1-2cce-475f-93c1-4023ea30a843@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s/GM2Nvmo/qqOTpZ"
Content-Disposition: inline
In-Reply-To: <8eaca7d1-2cce-475f-93c1-4023ea30a843@arm.com>
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


--s/GM2Nvmo/qqOTpZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 04:04:04PM +0000, Harrison Mutai wrote:
> On 18/12/2024 16:31, Tom Rini wrote:
> > On Wed, Dec 18, 2024 at 03:39:31PM +0000, Harrison Mutai wrote:
> >=20
> > > Enable bloblist on vexpress64 platforms to facilitate information
> > > passing from TF-A using the firmware handoff framework.
> > >=20
> > > Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> > [snip]
> > > diff --git a/configs/vexpress_fvp_bloblist_defconfig b/configs/vexpre=
ss_fvp_bloblist_defconfig
> > > new file mode 100644
> > > index 0000000000..dcc87db872
> > > --- /dev/null
> > > +++ b/configs/vexpress_fvp_bloblist_defconfig
> > > @@ -0,0 +1,5 @@
> > > +#include <configs/vexpress_fvp_defconfig>
> > > +
> > > +CONFIG_BLOBLIST=3Dy
> > > +CONFIG_BLOBLIST_PASSAGE=3Dy
> > > +CONFIG_BLOBLIST_SIZE_RELOC=3D0x10000
> >=20
> > I wonder if this means we should also do:
> >=20
> > diff --git a/common/Kconfig b/common/Kconfig
> > index 11066ec64315..cca33ed28f32 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -1087,7 +1087,6 @@ config BLOBLIST_SIZE
> >   config BLOBLIST_SIZE_RELOC
> >   	hex "Size of bloblist after relocation"
> >   	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> > -	default 0x0 if BLOBLIST_PASSAGE
> >   	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
> >   	help
> >   	  Sets the size of the bloblist in bytes after relocation. Since U-B=
oot
> >=20
> > Because in this case we do need to set the size of the bloblist we use
> > internally to non-zero?
> >=20
> That makes sense. The relocation in board_f will fail, as reserve_bloblist
> relies on this value being non-zero. However, if CONFIG_BLOBLIST_PASSAGE
> implies GD_FLG_SKIP_RELOC, then the relocation may not be necessary?

We don't need to worry about the GD_FLG_SKIP_RELOC case really, it's a
corner case of the ARC architecture and nothing else. We do want to
however copy the bloblist from where it was passed to us (possibly in
the middle of memory for example) and move it to an area we can reserve.

--=20
Tom

--s/GM2Nvmo/qqOTpZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdu04IACgkQFHw5/5Y0
tywQKQv/QnnjgG96N6gUDjvtlUbXPrvkjQ2ZITyQuWuXL7lDLlqevJs9lAfmZSnz
8M3xmzd23iyERvI0fPAoTWyIMDwILIiQpjTLfBdlA2jbL0TWT+jLjQUiI/xBqT1S
wQmHLUC9w5m45dYWjnof2i/V62c7mXoBHOZTem7hG+aZFoYTljBbknuQ0vx5JXA9
gV/OBmY5L/8w1Se+fPgKbB2l1bPsQChZ5dDwP+SRTnItxy33G5DW8ddev1TRSnSh
oCREYuRd0xp/HLVnOHHhqesgd+8C50jcn0/Mq1BaSVTXLD/CAvJOcyNsZ27XBUdP
DU6DauPI9J87VsfB2RBexudXqIDo7kap08VSPx0pTTncg3/56oMPJwyp4eScy0sH
E4lRdTFi5k/pGnNnCVawwxdKTKst6EZi/spp3ImNs3y2r39vEPOQHx6DVHl3yepf
abDgY+dF9h1mR+IcTGnf7QRCsleqZ0ryI9lrbhqQBSCogpTDxLBu2o2LNIbdy/5v
hWf7v1lv
=Nlz9
-----END PGP SIGNATURE-----

--s/GM2Nvmo/qqOTpZ--
