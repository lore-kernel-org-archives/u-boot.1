Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDE606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pt8/sypH;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IrclxMds
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F4EF80E76;
	Mon, 16 Nov 2026 20:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aG2HMwSb14Kk; Mon, 16 Nov 2026 20:19:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF14380E7D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794860361;
	b=pfYsA1SqYtimVwFWGK3EFpROZDhOPmcXWQ3YX7xmJSKpOmmHqOtop6nRa9yWN/3CtKSj
	 RT1iSLqdGP8fuALGa83+ACo/QmNXM/2ZNh6Oj7C8Cjor3Vx98RDjVDoOu5c+IpCd5K5+S
	 dffJv/oYFuPHLlpU3i7LPgjBbG9xtfvdX6aRU34bv8Bxl85ELiK2DJDEgOuk0N+cjWGHT
	 0pYqnlAfFRgSLf0xvx6Di7oXWjfR1HHB/F5TmCqQWrMV2ANvWM99VfFUnw/7TeljnEd6g
	 jFsTZurUPNbgd9B/vEp8fAdCAORBZE0oYeCopa9s3B9nQ9RB/ziCqRntKBV0ihsf1qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cQ2kCsVzsMAtQ564G1AqL8B9F3ZNPc4/0JVflnSMwfY=;
	b=S44qf5bc0T0VxRWwF/CM7hICpfrCA2EptgoKw9BKWqo/fE9Ll3YJdSPy7PIw+ywd42vN
	 S3j1M/U279PGWqZ2QFAhaUdO16h9/AqxtYiff+AmhnG7wSrA2bOgGZAbMSBvq+9XkQc7q
	 0/znSpuTa/cX1PYyyKqogF2jbuH2Zh6SiS+Rru5qpxGYW7LzwYowXEysX7hgF5/lZhRGd
	 uooN+ez3aprdpomx6xgnl+kAgLWYUOyIArJ/BAimOVz16njQxasbbZgboKAh+vXmat+vu
	 YMhOI4G6OtaSGPpcnBdpB/5Z+PBDLEkc7QjJqdpk/Swk52SX9amPN5b0sjxpg5pzBDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794860361;
	bh=cQ2kCsVzsMAtQ564G1AqL8B9F3ZNPc4/0JVflnSMwfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pt8/sypHNCYLrQNERcLQG7U2lkoQgjF0vLCjYUAmQ3HP65wduhQ6x1KInUgopgi8Q
	 eCJbTWY6hWLYgbWt4RTH1JUNaVvZUYBCOlb9nwLYMvGjeZ1EyYYAalVdIsB7pKD03q
	 q52tg7daMZo/oEoKvdxcAPGXG7qjcoiuvIFsOzBTCU6NrFC+qgmGKqInE60tNImlqA
	 Wx1z4lJec+8DueBA56FAAV2gre5eJO6h5yEEVSA9Xw7hQjq23EFEs7NG53Bp40CiE+
	 cpquZfy6UjKFAJl3mm8lke0uLoHw6WxbqF5WoMpw7iJj7+197KosynEm/jC+NzX2zY
	 je/EmHrgRBPcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF14380E7D;
	Mon, 16 Nov 2026 20:19:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D318F109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C500140437
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A2PRdu6CWZ9m for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:19:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF00440588
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IrclxMds
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF00440588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:19:18 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6d68de53053so2596090eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794860357; x=1795465157;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cQ2kCsVzsMAtQ564G1AqL8B9F3ZNPc4/0JVflnSMwfY=;
 b=IrclxMdsj5yym8f6MRetSDQfiXxyDh7OQdoUXmjnwJgtIubPbJtI+CliWBJ71kDi09
 h1uRBC4Uc5rBUc3tmpN+9nNlCu5RTUjCghNIP3fcJ4nKYWuu5yHEUAIq0w551aPmiZw7
 +lp9oeUyyw6BRnH20iEBE5AfvYNWTrJQnvK2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860357; x=1795465157;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cQ2kCsVzsMAtQ564G1AqL8B9F3ZNPc4/0JVflnSMwfY=;
 b=xsMhFRlCfrs9t3OcgdnDCxBN7/u0KEHfzsaCAv7Nq4v8vqaZydvaGkm0bjmd8wo5f0
 C8mXWrr7ZyDZs79m+B2h2sNITJebRkCy7yNXfgft93ShuOnB5FEz7dt+BkUppZJ1prbj
 1MkigMCVjJIOLL4dbpOqI3Nv3J4lRPsnRTF2Nq2B+uDg/mn80uIu6Ej5UUjKQjTdeaVK
 Oim8dAfrbWbNPHM/x5WFPABNTbkRcfG2pBw1IE76vUhWIjQ3IYr/lzi4oX9aQryy/8rG
 KaR/P/EWggXMMw0V5ouFOI+/fMsw1kfT26URAnQXWgJQ8kw/GvBkkNov2Epi0wpOk37S
 dMHw==
X-Forwarded-Encrypted: i=1;
 AL+hErEDsO901Wve5M3UeF209fOPieejttppqhC/9iyzSt4UTNllrb5YdUddJsETlo1dTiRAqW5NWOk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9lo1ecYKsF2djbxVlliDGVwA5+v8dXbUb2NWHTAHF0XLEPJfsQ
 qWAvI1omi5O2BOK8sVPKzAnl87hB7DiyjDhiGq1bZ7j+wBfX6q2ljTjDnww4eUyHHIdLaDzwq1d
 bzZ22BJ1a1Q==
X-Gm-Gg: AYBFou3CHI9/8FoboiDyMDJIIdRUZ/OOjJbhuFYgsQTF4BBSfP7wSM64NVz6rxjDisJ
 SQBlfwlX27ZHghgtRRunmuBFL/wD2e1X5jYpVWlWHN+mNSWWQ5SoT5XE/kNCdSDVQKxsWc5Tm74
 fBbIWicnQ6Bh9dCF0Dzgt3M5zI09UO6fFqPXhPMXFc40b0GESrmDVdHhFvfFnb16Nnzy5gV20aW
 FdLQgjNotadjF6+rYL9D8JBUCMH4UGIq6/t2guVLM+OkCcyhcSJvRiR7Rh76iwzpJ/Jz3NWHCXl
 DnVWYsRTH+dYYJEqK18ByjfpEhVN/fR22a8eTUioPELJChCtZ5JwdHoYbHr21d9sl8OcN5Dcyj8
 si8WkiS6opZ3bG6Qil5uo/PFy3dTm8/pMFHSdTHKO6xYRbi3yl2X1fCWpqBZTGe3GC3paghpdht
 14KM8DpDz5pKKGRhHcbAwWrE7qQiTqEO8hQLSzNO1RpWf4j75ot8C7FYStAz/YS5B4ubLsVIhNn
 sncgVliFNXVrP1+pdZcmlleHtcN1q+QuMn5IARKTlLgPBdqNxDXiLR63L/2EXK+VRWorpsF5Wh+
 hSSY7pyDd41kk3LVmDla1v3sQnCKdtuYh6BPS9f6IkWLJqpnIyHgPQuk9t6QgoOblv650Kn9OWS
 1zQWWKQQVshYhXovRrrRBiqG042I2oFw6NBIKk39LeB3uVAIpMRPRbioLYmtoNLCPzqgl8wNHc0
 TKKU/vMLYDh84O76w2ND7CxrkeNrilAgk=
X-Received: by 2002:a05:6820:4189:b0:71a:f498:303a with SMTP id
 006d021491bc7-71af4984467mr2273970eaf.48.1794860357056; 
 Mon, 16 Nov 2026 12:19:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe2288f59sm7530004fac.9.2026.11.16.12.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:19:16 -0800 (PST)
Date: Mon, 16 Nov 2026 14:19:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Dilip <dilipchowdary21@gmail.com>, u-boot@lists.u-boot-project.org,
 joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 alchark@flipper.net, kabel@kernel.org
Subject: Re: Five memory-safety issues in U-Boot filesystem/partition parsing
 (coordinated disclosure)
Message-ID: <20261116201914.GK554944@bill-the-cat>
References: <CAPmzV5kAUpHf5fGDHmQXnyDJxs=Kvgtks2ztva88pG2wj7m9qA@mail.gmail.com>
 <deff7930-1571-43fe-8f05-0c576e115c5f@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i1pZa65uO5rO6vp/"
Content-Disposition: inline
In-Reply-To: <deff7930-1571-43fe-8f05-0c576e115c5f@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--i1pZa65uO5rO6vp/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 06:44:56AM +1030, Qu Wenruo wrote:
>=20
>=20
> =E5=9C=A8 2026/11/16 17:24, Dilip =E5=86=99=E9=81=93:
> > Hi U-Boot Team,
> >=20
> > Thanks for all the work you've put into hardening U-Boot's image
> > parsing, the 2026 squashfs/disk crafted-image series was great to see,
> > and it's what prompted me to take a closer look in the same spirit.
> >=20
> > I'd like to report five independent memory-safety issues, all in the
> > same threat model as that series: U-Boot parsing an attacker-controlled
> > filesystem image or partition table from untrusted media (USB/SD/eMMC/
> > partition, and for some, a netboot-fetched image). I found them by
> > source review of master v2027.01-rc2 (commit ff8a9bc4), and each comes
> > with a minimal, self-contained proof-of-concept.
> >=20
> > Reachability for all five is an everyday operation on attached media,
> > `ls`, `load`, `part list`, `cramfsls`, `btrsubvol`, or distro-boot
> > scanning,=C2=A0 with no signature verification anywhere in the path.
> >=20
> > Here's the short version of each:
> >=20
> > 1. squashfs: out-of-bounds free() in symlink path resolution (CWE-590)
> >  =C2=A0 =C2=A0fs/squashfs/sqfs.c : sqfs_clean_base_path()
> >  =C2=A0 =C2=A0A symlink whose target has more ".." components than its =
path depth
> > drives
> >  =C2=A0 =C2=A0free(base[i]) with i negative,=C2=A0 a wild free of heap =
pointers before the
> >  =C2=A0 =C2=A0base_tokens[] array. The `if (bc < 0)` guard only runs af=
ter the frees.
> >  =C2=A0 =C2=A0PoC: ASAN heap-buffer-overflow at free(base[-1]). Trigger=
: /s -> ../x
> >=20
> > 2. GPT:=C2=A0 integer overflow in partition-entry-array allocation (CWE=
-190 =E2=86=92
> > 125)
> >  =C2=A0 =C2=A0disk/part_efi.c : alloc_read_gpt_entries() / part_print_e=
fi()
> >  =C2=A0 =C2=A0count =3D num_partition_entries * sizeof_partition_entry =
is computed
> > in 32-bit
> >  =C2=A0 =C2=A0and wraps (even on 64-bit), under-allocating the PTE buff=
er, while
> >  =C2=A0 =C2=A0part_print_efi() iterates the full unbounded num_partitio=
n_entries,
> > heap OOB
> >  =C2=A0 =C2=A0read + partition-name info leak. PoC: ASAN, 512-byte buff=
er vs
> > 33.5M-entry loop.
> >=20
> > 3. GPT: unbounded header_size drives OOB CRC read (CWE-125)
> >  =C2=A0 =C2=A0disk/part_efi.c : validate_gpt_header()
> >  =C2=A0 =C2=A0efi_crc32(gpt_h, header_size) runs on a one-block buffer,=
 but
> > header_size is an
> >  =C2=A0 =C2=A0attacker-controlled le32 with no bound (Linux rejects hea=
der_size >
> > block_size),
> >  =C2=A0a multi-GB OOB read before the CRC check. PoC: ASAN read past th=
e 512-
> > byte block.
> >=20
> > 4. cramfs:=C2=A0 heap overflow in symlink/data decompression (CWE-787)
> >  =C2=A0 =C2=A0fs/cramfs/uncompress.c : cramfs_uncompress_block() (+
> > cramfs_uncompress_link)
> >  =C2=A0 =C2=A0avail_out is a fixed 8192, unrelated to the malloc(size+1)
> > destination sized from
> >  =C2=A0 =C2=A0the inode's declared size; a crafted block inflating beyo=
nd `size`
> > overflows the
> >  =C2=A0 =C2=A0heap buffer with attacker-controlled content. Present sin=
ce 2003.
> >  =C2=A0 =C2=A0PoC: guard-page SIGSEGV at the allocation boundary. Trigg=
er:
> > cramfsls over a
> >  =C2=A0 =C2=A0directory with a symlink.
> >=20
> > 5. btrfs:=C2=A0 heap overflow in subvolume path resolution (CWE-787 / 1=
20)
> >  =C2=A0 =C2=A0fs/btrfs/subvolume.c : get_path_in_subvol() / list_one_su=
bvol()
> >  =C2=A0 =C2=A0strncat(path_ret, tmp, PATH_MAX) accumulates the path acr=
oss the on-
> > disk ref
> >  =C2=A0 =C2=A0chain with no total-length bound (strncat's size arg boun=
ds the
> > source, not the
> >  =C2=A0 =C2=A0dest)
>=20
> That's the biggest problem here, unlike kernel which has VFS layer handli=
ng
> such overly long path, here we don't have anything that limits both the
> source and destination length.
>=20
> What we need is strncat_s(), but it's not provided in the current code ba=
se,
> so you may need to create a dedicated helper.

Is there some helper function currently in the kernel we can borrow?

--=20
Tom

--i1pZa65uO5rO6vp/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtlQQAKCRAr4qD1Cr/k
CtTcAQCNJ6djyogTFD2bW44kFmFgl5aCsGbnKSuO1Lty9alIgQEA+PVdfukvi45D
JrnTwSIqbwh0odTICiPudDqM+8vJJwQ=
=W7ym
-----END PGP SIGNATURE-----

--i1pZa65uO5rO6vp/--
