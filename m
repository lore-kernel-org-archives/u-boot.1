Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5037CC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 22:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D3A940699;
	Tue, 15 Sep 2026 22:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G89ySb6sxPRG; Tue, 15 Sep 2026 22:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 091184066E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789510376;
	b=ip3LA/Cw58QJhNBwU7hFsvX21YzNfVVDHOMjxbU/H3saR0YemWgooWn0QAXpMqbaheQO
	 bksnwpQPbTsEC8p58S6EkfWIuuXF8jtkO0NL2DM786CA675ogTcMiGy5hLqYQo9ASBV3e
	 XsViA2vAKkmffeY+gEvdmI8ljtA9cFhZiosmWAOgRY+aUXrprP5/0X/m+pTupcyEitDxO
	 0wj3yZ/0xpzR4rquBdBt0mLVYBSBoByNb+lwvTlcPq/Nm81X5uHHcnLfCoV3PF5wB9n1i
	 DOklnVoOW9jCU2BR6+McieQoYQeYotsiRZUrZMx1w9TpnlElOByxl2K5C2vjnU4w/bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789510376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h9woqSKLd0AJFmwUZd3aGkp3rqz/8jc3QYl73JPHcvI=;
	b=sesjiGGFBAmF+pOQiBWlhFlLQ7Ql1+iQHuZkDB3JYmSES6Fa/XBMt66ljy1qVywa/mJd
	 44R0tFn26C5dcHgryQsaPwCS1zacud1PedsF3FnrexxCKzsS+15t4fARfsK6Zxeer/6dH
	 G0nuLS9SbOEp+zmE0JC2TK1Bk0F2XhljJYb9OVwWsD7gJM3i01zZvDHNmLN3EGdGe6/3X
	 inLACjLjMxlxNIFRI1+G5fCBtEH3M8DHbjqYCdEiOPpL9Hk/VQBwUvv4V5skgUW+kCz2+
	 U3+b1wLAJA+3UCT+2UVPYbJlBd7qWUJNVtscuchYwobJDKa0M6rebTpapvQ2+Jzd8FA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lAKHOZjS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789510376;
	bh=h9woqSKLd0AJFmwUZd3aGkp3rqz/8jc3QYl73JPHcvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P+Wubyten6RHBsYrLGQv5vxctH3wI8mFmY3MSBlUHzQR/dtFZ+KBRm1RbVpelEDyk
	 zNGFqWF38SGxhO4anBS2HAoFqB5QW6GmxT6QOfsGtVyzcelgvVBHxw3JBfwDIDAFUn
	 RbYje/b2gZiBGnxn6fWvBGTepOA2ydYJJgVAdm2PCeUquL8/b9HSu6zeooXAKtUPLn
	 IaEKFq6DbdF1z9EFUQXk7tlKEa6KiMeHwnUHLXrGm4if2loeg6nsq84Zy26co18bR2
	 Ht1QgP+dOahNjqbOMHCgJUEiNU4Nf4qRVUPslvI23lYg9Z7iVp8FrJb5dQ1vxxxAcP
	 FDvbrorffjS+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 091184066E;
	Tue, 15 Sep 2026 22:12:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1A50352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A327F4066E
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1paE_2QRG3Gb for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 22:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84E61405BB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789510373;
 b=M7cuv/6Cd4I8xDA2m1gl+vW4Mlu3CSnxezEa65/2SHwjALDHtBzJ4BoJHPCI32IZM8YB
 YjrAKmvEs73rdQLXGuPSjII5ky1WR34EbACOCafWWrdhCC3O8tkCADVJPNrm7Bq/941w2
 iDOlhKr4gZVbUWX7mJK2QUtNO5RbhL5+KkElOY2BsaF8V4+bSjx26uWX11HBw4zoaNvxC
 mWeDPVON2Hvo/oYpyHZQC7ZC+eHcTXMSygNVwevUCp5VnGMdJam1Cp+xCTXjmsr9jmnb1
 rP0bCXctXEPTZvLc+yBW7lM4ETDwso0H6M0+L1vzTd7L2ahGycDKLw4v02vIJC44H6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789510373;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=h9woqSKLd0AJFmwUZd3aGkp3rqz/8jc3QYl73JPHcvI=;
 b=mXoS1JwB4OkgmtrM/gHhBCshueHTCD4gFna7rHMPRgPQSHNMf85+1zsuxHqg2YDJ/U11
 B5FnOV2pmHiNtWYrFbzV5UlNDcz8cyyE1LlmG9KRuSz3ZYxVqLzeW/T3Q+QIDsFE7O6BK
 tHZvIzLbcSu0EJccHQ/3oh0XxIlpu8Qm1Nk7tM54SKvQYa8uUqhWLm2QVWdJ6BPTHb3Cs
 d6NCehHdVXCUofDOaFWjAH6GrEh7hLg0YPGPUAjMXk8UQ4JPcP1VVP4ApwC/FKGCa5aha
 L3yvHpczHlOa6cYp35ZZk0fjyVG4YUidfdKCZbl9VF52sxhsfBxdO7+1lZm/rwx2GVA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lAKHOZjS; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::8;
 helo=mail-oo2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lAKHOZjS
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84E61405BB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 22:12:51 +0000 (UTC)
Received: by mail-oo2-x08.google.com with SMTP id
 006d021491bc7-6b12d30261cso1454182eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789510370; x=1790115170;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h9woqSKLd0AJFmwUZd3aGkp3rqz/8jc3QYl73JPHcvI=;
 b=lAKHOZjSqP8UEYk7qcMlvain3zSSDUGlCRzT64biUeCfwCljx68o3hPJlXlX1WtKuP
 nm8eIJBrKssJPTlAhnsO7qY/UTWRihkhhAMeD+9MyxSCm8gfPZ/YnLQ3BcuYW1qX1t+9
 AE7/oxVb0kNN9xpgrvwfYaFDW95GJbJ8acNyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789510370; x=1790115170;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h9woqSKLd0AJFmwUZd3aGkp3rqz/8jc3QYl73JPHcvI=;
 b=NFCEhAdd8ACs6n36KxQhGavK4esYAMBGdPIdJPgJZ2CAhHPiIB3uRzijHHtPFxPgNL
 KH8WmQHWrVSfpDhZRrYejaggk28tBNiPCFV14/nMHdm3LdYfCtxEPghVpwziwlnNKfnq
 xBo5KkTAr+ILZMTb+W1bPaDW3SVuspEcNOE6N/LHnejWaVjWQwoQSToXlbXbpcRq9P5p
 pIXUbrPIqAn1oeW9AaAQHRP/4odgIhAqORQiLfy6tD4X+dgbbNmw/0Y99zk9KplNKRxF
 8x5m+3DTClfR/cbPNKB/zv43VboTgFwat8hciG0PwBMRAZ3Itxgb3CGn1chD2nL/GxKI
 RjdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfNFD2w8AFRtGQugFGMY4jwry1ryDz59aQgaLbFkcPHZgRelZcx3P9dlEQyY5NHLCJ5J2N9+s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k2AC5knxTFbn0qso3GrGfydkCFrVF+yEEF7CRUp2H0ax8kUpgL
 QVYhD/6VcKyKdDiBHZtosEhB/GmeidwRX4NcWK04JKiRvPyKPHezJJQHuhGhn7E3hrE=
X-Gm-Gg: AYBFou2B6ifj70kJP0GBGNWW8N4Ofky90Ozo2ETPM8IPydtPIeVDUi0Rc/iPXlmzAeB
 C2qUANOo2h7Yw3z05wYVinOVIMracUQigqqLfGoPB8TqXyVqX05dSA555xfe0cjIrwG7tbhaB1w
 lhJQQJ4MVImEGZnE/9vCrWwqkN7GkTveLx69jqHctfxoMuvnSFwzjzgi4+k0qQZKvwbHPNrgGAP
 ad1uj2RqLECs1B2OGMjb5JCY8Loft6S6q2i8OuB1eK+XXjtSCMDVq4FivAfH2YnRi6UVHyb0I1w
 hZcKQveifAVGedICj3K9F+/ihF+cBK8auj01hettGZOVoCCBtf0BmBrUER27oEnALExhDl73I1E
 WrMA3uqGAnCZqNh8c6zLFg5r8GlMObuMlULhPBUPJd3KZqGV0gQ5DynM82i/XV2wZvXrk07TcRh
 NPYTs8sUq8oIHUQ+z7H1tskcXZPBeLqQtT+L8YYWxBJFSx1cQfVP5gZMDj0aMA2YOYTIFKuSog4
 GHoZtu6GFJ/Nf9FLMkiL7PW1P69k0EYhB0EPWplp9b6sG0MEoQTJyEs2qSZIZ/id6eB9YQz/GPY
 6C9fbJ0rBaKOaJeqVDKs
X-Received: by 2002:a05:6820:f028:b0:6be:31b7:e684 with SMTP id
 006d021491bc7-6c7d36fa75emr451869eaf.34.1789510369973; 
 Tue, 15 Sep 2026 15:12:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c7a7dc5668sm960658eaf.15.2026.09.15.15.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 15:12:49 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:12:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: Tony Dinh <mibodhi@gmail.com>, u-boot@lists.u-boot-project.org,
 ankluemk@microsoft.com, v-dmunic@microsoft.com, jerome.forissier@arm.com
Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
 counter
Message-ID: <20260915221246.GF858934@bill-the-cat>
References: <aqm9WMSA/H8sJzhT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H+40WO4HfzyVzpPa"
Content-Disposition: inline
In-Reply-To: <aqm9WMSA/H8sJzhT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--H+40WO4HfzyVzpPa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 02:49:12PM -0700, Sriram Sriram wrote:
> jerome.forissier@arm.com; ankluemk@microsoft.com; v-dmunic@microsoft.com
> Bcc:=20
> Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group l=
oop
>  counter
> Reply-To:=20
> In-Reply-To: <CAJaLiFxMbEO1hk0o6ja6w1SKN-hVK4tGkvUo90uO+eFgAc631Q@mail.gm=
ail.com>
>=20
> On Tue, Sep 15, 2026 at 02:23:12PM -0700, Tony Dinh wrote:
> > Hi Sriram and Daniel,
> >=20
> > On Tue, Sep 15, 2026 at 1:52=E2=80=AFPM Sriram Sriram
> > <sriramsriram@linux.microsoft.com> wrote:
> > >
> > > From: Daniel Munic <v-dmunic@microsoft.com>
> > >
> > > ext4fs_update() iterates over all block groups with a signed 16-bit
> > > loop counter:
> > >
> > >         short i;
> > >         ...
> > >         for (i =3D 0; i < fs->no_blkgrp; i++)
> > >
> > > fs->no_blkgrp is a uint32_t. On a filesystem with more than 32767
> > > block groups the counter cannot represent every index: incrementing
> > > past SHRT_MAX is signed overflow (undefined behaviour) and the
> > > comparison against the unsigned no_blkgrp never terminates correctly,
> > > so the bitmap/group-descriptor write-back loops misbehave. The mixed
> > > signed/unsigned comparison is also flagged by static analysis.
> > >
> > > Use u32 for the loop counter, matching the width of no_blkgrp.
> > >
> > > Signed-off-by: Daniel Munic <v-dmunic@microsoft.com>
> > > Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> >=20
> > BTW, since you are testing this ext4_write, it might be worthwhile to
> > see this commit:
> > https://github.com/u-boot/u-boot/commit/53cc4332b3b37218a7cdab8bdb953da=
57eec2668
> >=20
> > Thanks,
> > Tony
> >=20
> > > ---
> > > Changes in v2:
> > >  - No change, rebased onto current master.
> > >
> > >  fs/ext4/ext4_write.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> > > index 1abedcede72..2fba2197c19 100644
> > > --- a/fs/ext4/ext4_write.c
> > > +++ b/fs/ext4/ext4_write.c
> > > @@ -67,7 +67,7 @@ static inline void ext4fs_bg_free_blocks_inc
> > >
> > >  static void ext4fs_update(void)
> > >  {
> > > -       short i;
> > > +       u32 i;
> > >         ext4fs_update_journal();
> > >         struct ext_filesystem *fs =3D get_fs();
> > >         struct ext2_block_group *bgd =3D NULL;
> > > --
> > > 2.49.0
> > >
>=20
>=20
> > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
>=20
> Hi Tony,
>=20
> Thanks for the review.
>=20
> > BTW, since you are testing this ext4_write, it might be worthwhile to
> > see this commit:
> > ext4fs: Fix: Read outside partition error (take 2)
>=20
> Thanks for the pointer. 53cc4332b3b is already in the tree this series
> is based on, so the read path is covered here.
>=20
> What caught my eye is the note in that commit message:
>=20
> 	Looks like we also have this overflown problem in
> 	ext4_write.c that needs to be addressed.
>=20
> As far as I can tell that is still unaddressed. ext4fs_write_file()
> has the same wrap you fixed in ext4fs_read_file():
>=20
> 	long int blknr;
> 	...
> 	blknr =3D blknr << log2_fs_blocksize;
>=20
> and on top of that delayed_start, delayed_next and
> previous_block_number are all plain int:
>=20
> 	int previous_block_number =3D -1;
> 	int delayed_start =3D 0;
> 	int delayed_next =3D 0;
>=20
> which makes the casts at the put_ext4() call sites
>=20
> 	put_ext4((uint64_t)((uint64_t)delayed_start << log2blksz),
> 		 delayed_buf, (uint32_t)delayed_extent);
>=20
> ineffective, since the value has already been truncated on its way
> into delayed_start. The fix would mirror 53cc4332b3b: lbaint_t blknr
> plus a separate long for the read_allocated_block() return and error
> check, and widening delayed_start/delayed_next to lbaint_t.
>=20
> I am happy to write that up, but I should be up front that I cannot
> test it. The largest medium I can reach here is well below the 2^31
> sector point, and since this is the write path an untested patch
> risks writing to the wrong LBA.
>=20
> Would you rather take it yourself, given you already have the DS116
> and the 4TB disk set up from the read-side reproducer? If you would
> prefer that I send it, I can post it with you on Cc and leave it
> pending your Tested-by.

Hi Sriram, your emails keep having some header looking content at the
start of them, what are you using for an email client? Thanks.

--=20
Tom

--H+40WO4HfzyVzpPa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqnC2wAKCRAr4qD1Cr/k
Ct8WAP4+qGFfU4lU2i0dvMbXClbsHHywfa2IgCu6tZbZJGpNcgD+L3CHFGq8OeKe
U/xCoZwAm51EWWMxyF6m9ynfZqJ7pQs=
=I+Rz
-----END PGP SIGNATURE-----

--H+40WO4HfzyVzpPa--
