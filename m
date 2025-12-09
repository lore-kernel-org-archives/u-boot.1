Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D6DD3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 15:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFE5801CF;
	Tue,  9 Dec 2025 16:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mSWm6U+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3F583C5A; Tue,  9 Dec 2025 16:50:29 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C13A801CF
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4557e6303a5so148609b6e.3
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 07:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765295421; x=1765900221; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O7/jlsv8rEMLvnO1eRCMjsWND8Hs7Wh+Dk3bX7NkLq4=;
 b=mSWm6U+yPxZyaQJSpoNWVH6sbuJuAG4s7Kg/N+/hPi9NJDcL1uEYLun2cb2hytt0aL
 vygCnY+agv+TfdxtY16cWe+w+J6pMvACSEVrRtyJLWiMWDGLTDY6DfyPMJTNCl95kleW
 BwHlXNd8Qelfx/AVhNnHKBwglOGxGEO8MkBq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765295421; x=1765900221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7/jlsv8rEMLvnO1eRCMjsWND8Hs7Wh+Dk3bX7NkLq4=;
 b=EvVm+4kDKrZoymOih6gR3FF2GBhlcDbBzy57OynoIIHe4papEIE7kSArLd5iDWZZEu
 ZgY08+UZfwerMKMeX6ZtJyVkjtOr0tRfHoXjJKXWUgtOIvc5AuzgIwAMVjfE/MCrSdTr
 JcAq4/YssYEhEH7Uxu41HppmPfXDRZh87yAuW3k91iv9NgszPvTKwlEkc11AbNhVkflf
 Mrx27ENDr4VSlnzxTqctWicqtif8oEjvObp+embQ57GI0dwGAk9pa/GT6mx0HcA6r1oF
 lZ/EoBPdC168kMJWzkYFMM3EaMeMVkAvWAxhXp/eFwtKMh5HC7Bytpmxve5jl7S3uVTn
 Gaog==
X-Gm-Message-State: AOJu0Yw/XUAxa8P+LYfzaLBlDppJcgeOHYNwTVngJMAws7hbrXLhIx47
 ZkigE/ay3tctx43cYRytR0Gqi+eru4UMDAgqMc79f8/REwTXpZx9O0TLpbmz8YfMjFY=
X-Gm-Gg: ASbGncuYgtW57ZoYq/M0Lm9f7kos8ZO7XJrWi4T4uAY5xWiKOKHiTEPUCQbwUgWjflP
 HK0w6qgCkCx2h0RxTx8bKfPNUjOSZ4ptyGtCGzny6NcmukGON2y1d47/Hy7a1kdpcKhRx60kWQv
 izLoWjVxFzM+a1SQuj/XWfV1vPeoC/egLGf3/8Z94jsstoPzn0wFyxjz6F4Iu1gaO9DCcgPa8Nj
 UlN70z9MZ+v47fvpvNiYAk7uEduM3cS454uJtSwewWfr782xuEaTbec+1v79Y4IkRDa0+a06455
 Pd1CYztCzHdJtxCxCttghXNHcLSFtvEfS8F+auM5r8ouffe9Z+qP2JRcuQUIXj1jykK70M73Q9v
 6yD5HjB2Iak64FwFd2cNXri393ud6+Ef/EJ6zo31u0AQ1xvekhxe/cnQ7OnDXZowPg0LDxpjbns
 0wQnmBnvRzXZyTDsM7uD5hzbE8Ix+DCv+l4LryBZGjBFwvAXWn5w==
X-Google-Smtp-Source: AGHT+IETEAGv/hJ0Zxo9Zwdsjhz0LEmkKyP7Ws8b422ztRnPKj4nf2sFJ55Q4BvicRgl/mXodiHEWg==
X-Received: by 2002:a05:6808:6b97:b0:44d:a531:456 with SMTP id
 5614622812f47-4539e0aa02amr4010907b6e.52.1765295421082; 
 Tue, 09 Dec 2025 07:50:21 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45380e9bc0fsm7635554b6e.1.2025.12.09.07.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 07:50:20 -0800 (PST)
Date: Tue, 9 Dec 2025 09:50:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Pranav Sanwal <pranav.sanwal@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] arm64: versal2: Populate DRAM banks before page table
 size calculation
Message-ID: <20251209155017.GY303283@bill-the-cat>
References: <beb76794e4982085944bf167f242e6f52588dc44.1765289863.git.michal.simek@amd.com>
 <20251209144347.GX303283@bill-the-cat>
 <306c06a8-f8ee-4d18-97e2-7f1d21854d6b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QTy5Suz2m2vXVkvL"
Content-Disposition: inline
In-Reply-To: <306c06a8-f8ee-4d18-97e2-7f1d21854d6b@amd.com>
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


--QTy5Suz2m2vXVkvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 03:57:50PM +0100, Michal Simek wrote:
>=20
>=20
> On 12/9/25 15:43, Tom Rini wrote:
> > On Tue, Dec 09, 2025 at 03:17:45PM +0100, Michal Simek wrote:
> >=20
> > > From: Pranav Sanwal <pranav.sanwal@amd.com>
> > >=20
> > > Move DRAM bank detection from fdtdec to custom implementation to
> > > ensure memory banks are populated before get_page_table_size() is
> > > called during MMU initialization.
> > >=20
> > > The current fdtdec-based approach populates gd->bd->bi_dram[] too
> > > late in the boot sequence, causing get_page_table_size() to be
> > > called with unpopulated DRAM information. This prevents dynamic
> > > page table sizing based on actual memory configuration.
> > >=20
> > > Parse /memory nodes in dram_init() to fill versal2_mem_map[]
> > > early enough for MMU setup. Supports up to
> > > CONFIG_NR_DRAM_BANKS (36) non-contiguous banks with high memory
> > > regions (>4GB) and use __weak get_page_table_size implementation
> > > to estimate page table size based on the populated DRAM banks.
> > >=20
> > > Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > [snip]
> > > diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> > > index 120393426dbf..5be9513f5238 100644
> > > --- a/include/dm/ofnode.h
> > > +++ b/include/dm/ofnode.h
> > > @@ -1886,4 +1886,6 @@ int ofnode_copy_node(ofnode dst_parent, const c=
har *name, ofnode src,
> > >    */
> > >   int ofnode_delete(ofnode *nodep);
> > > +ofnode get_next_memory_node(ofnode mem);
> >=20
> > This function is in lib/fdtdec.c and so we should have the declaration
> > in include/fdtdec.h and while it doesn't have a kernel-doc comment
> > today, it should. If you want to in v2 make 1/2 add the prototype and
> > comment and 2/2 use it in mach-versal that might be a good split.
>=20
> We will do. And do you have any issue with logic in this patch?
> Pretty much we don't want u-boot to be relocated inside the memory bank
> where it was initially loaded and we didn't find a better way to do it.

It sounds like it's a bit of a generic arm64 problem? But this is
probably the right step forward until a second SoC hits it and maybe we
see a better place to change things more generally.

--=20
Tom

--QTy5Suz2m2vXVkvL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaThFMgAKCRAr4qD1Cr/k
CkY2AQCskESsT5YTkm7jum26PzPmHAftk6axGsVrXMtyw3FK5wEA9EyB0FMDFW2z
5fbJ66jXzDIjMJKCqAU2cjPginmwVgk=
=FpDz
-----END PGP SIGNATURE-----

--QTy5Suz2m2vXVkvL--
