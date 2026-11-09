Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8F606A322
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x6wjKKH1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lzxfrlxI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DA2F40756;
	Mon,  9 Nov 2026 14:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEc9eXT4lPGs; Mon,  9 Nov 2026 14:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 964264075C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794233991;
	b=qEqrIR+r5sXhkYvW0Y1cGnSzwTp9fwDj1ttnCvEyHYnOplTYXWYkt4z3108ne1Rzg08p
	 wKz12MrwJYgwF5ttR9u8mhaQjuek2ErlpozgfeEI/lydeevDIL2YNaOdMELF747jjUWsO
	 OKDST5T1O2WgsOHkTQlhOwJKPS+e66ZiA+DBWWxZ2HtnfQR71j/JrRspozWaYDaz3Zlf1
	 Xpw7m1dFtF6unluy6zcAUaUarVkEhWhJcz7ZoNts/fkk75q0vtnCaZEtbkWXKFDDDvMb3
	 80mUs6rwQsMJZbELWWUdCWvrDV1i/eWWnnWcQ9RD3JkLITuokXRq9DNqkGTAKKXf4cQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794233991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hKpz6r/+EAEmDKXn33HrWp9CACv/iLC+LDDoGrn375Y=;
	b=e9o9MoCPeIPomrMJ6NgyIQZ5nZZqhTuBOgS/CvyMlqg64GHtlAK+VkjotAAq4q3cBHGt
	 3SYC6So2Jg3W4EN6/anpD7bm3ABFY8Y+p3FKv862U/lpllafSH2ircmZZA4+f3Ok8v3hk
	 m3Sw3EzR1gcDkVPIkOWyjAhP2BMjFb0/jf62jAKywW+wZAysU4ygntMPKUkXp35jrOky2
	 /MEM/CuhiWrHofqBTGxEAxjcfV+NJCv5VWdZSSLYwRyJOSOdJt5/Fdp37SorHIv8CMT/Z
	 UTBPL/YyCHReajdCie8zZ1+aUpwZmRtpTTJj2rGdmIToLy32DGCHoC8Plcccej1ilrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794233991;
	bh=hKpz6r/+EAEmDKXn33HrWp9CACv/iLC+LDDoGrn375Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x6wjKKH1VsF1ufOV7KkrlESSgiXj+v5wNpL1oF5P2ywrArLbrj0DkmJbCAwB9+qFz
	 Il3pJzioxCnczKhdDS8ZxpGlr4H+GEkD4IVYTcQOW2OSABPuK7uJUsPUOxp+HAjjHp
	 drj2YEBIh/Jvxu733hj/9Iv84RrBhWUtskCG9jphG2UnFJoIfuDsU0eppKWE/dLTsf
	 KrdurvTR1JGmJjJxlrV+/78HUaNzAYGdBwNcIm1SYhbYChxbE4I26WfzWBYpYGV8LD
	 b3lfq7pSohuGE9SkuF8Ks1YYQBwO1Cmub3XiatTb9S3ylajHkyFQS6tDBSjJ+/JKv9
	 9obpPexomnf/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 964264075C;
	Mon,  9 Nov 2026 14:19:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F0988111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E255680F91
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocvcMcn8I8ax for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:19:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED08480DEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lzxfrlxI
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED08480DEE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:19:47 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 46e09a7af769-820ff812cd8so293148a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794233987; x=1794838787;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hKpz6r/+EAEmDKXn33HrWp9CACv/iLC+LDDoGrn375Y=;
 b=lzxfrlxIK8kZb8KuBmBxdfDM5zt1qaMuVfJli/B5xql7zT7qZ5tlhW1tl0XzkN9BHH
 OJb/ShKJLBXNqrEQtcCK+fMP92Gx6D5uA7tpyoz5WODdihqvqUP3hg8s6y4zzV3LpIh2
 bQklOsTo935wkLOngRFNuyfE0VFMxoVokzFZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233987; x=1794838787;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hKpz6r/+EAEmDKXn33HrWp9CACv/iLC+LDDoGrn375Y=;
 b=BIUQXjqxsBtR8zVgKVDkexvtIjva2MdWw2HWrM8Soy86EQ+GJ0MiSQHv8Ab+wU45ry
 RcK7D0kEZrqiw+B8yNOftsrgno2p8q6iv1BtbKr8D2v+shh6vE7r36MQqh8JY/XivaNg
 kG2dc5HmtFDDE9gBqdIX1kOCBlWjJTC1FiDnt8LECp3aHayJhEJhvb52/V/Ywcew13cf
 VWYEDRlI5WE0J2fsRuU9egaPTsLHQwPfguPrMRESANlWy6nvQhWgxpC+aSR7yHhZ4+pk
 nIbXSi77z4jZAH27rQAeqdzBLoH/zxZXNY1hjf/weu7KfO+U9ZUvvDu0EdGpbYtB0wPE
 kHAw==
X-Gm-Message-State: APuU4Z+Gf0kQkzQMBF2pSI9cWrcnDxLAgEBmpJHR7vwNsEMnsWAOMiYv
 6V9Ja6ygGGhog2UyuHPqlvdqIfEYQT/oJ55b7LaxdsBvd7i2HOMr5A0NLB/JC+fGxh8=
X-Gm-Gg: AYBFou1rzDryHz48N9toRDWVIkMGT3SwaAcboTnvS6cAYrgGzQgKPsp7eYmY/J8Qpsp
 jfah7zVLwM44NtAHheqMkPXdtMzwOZN6okua9iPSVnAnOZJdWTGwy+YlUJfsja49Er5UdK02bTK
 zUjy9blCafDsXTX/7tSZlBnwKdeEoriDHdBO1u8n3ztiXymN75nyhO8ujrgNBv5wDNfuply9aad
 z5zHzV3hJQ3v27oaM5H5LxdbEuShN3igKeZ8TymgLIqd2IBGxty8Fz4hlos6lVl5+uDYvidrtcg
 rExBgdO00m4mp8mkD27if3n4WWb+deqlzuk2bE87E3v/klhkDB88V8sU3pYRMmbSq19i4UoCrDD
 4oJhfwHhdIgwfPwhWkSW7oq2PIs48K6KdLDi0F6s+iVvMSxvzRr1Ec6nnzgPUQTyZByEbVKGOfm
 xvHkS+QJcgvJNB7/nh1pVmszVwC51YXBCEi02/u7mnSNazkgat8WpVZIRDh4L13Guq+N1K3GuMc
 DRVUW6wxD/CwdxtLiGgy0WMr1XfG2t2hu4rJTMZ7VbnL3Y/ha/sMrqwktaEE2PPUSWz5MqMtoUh
 bsMjWad2PkKQ55NnBAy2zdjz++jH4ElOyjid2g9hpJkR8VyNwYL2EroMgWA0cV5L4FY/Pbfva/L
 C6rarsJbOoMAmJyFN7i+lHR96Gf+covE8PfZr9vKS3JZPktwW8KGNRPfPM+aqmgIjWgVdLMS9S/
 AH71posd8FvLs4Nrv89/EYCMlD7O22zQ==
X-Received: by 2002:a05:6830:6815:b0:81e:b1d2:95f with SMTP id
 46e09a7af769-85f508a969cmr3518435a34.28.1794233986874; 
 Mon, 09 Nov 2026 06:19:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f4fbce9cdsm3734033a34.20.2026.11.09.06.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:19:46 -0800 (PST)
Date: Mon, 9 Nov 2026 08:19:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Subject: Re: Please pull u-boot-x86
Message-ID: <20261109141944.GK3741582@bill-the-cat>
References: <CAEUhbmUriwAm2_WHVDEB6mfwH57hzFYbPd-4M6nyUGFqPEHcPg@mail.gmail.com>
 <20261108161357.GJ3741582@bill-the-cat>
 <CAEUhbmU-HyCr7DuQUQvz5NX3PSzvyGYoem07VnquHzpBVw9SDw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7z/wMdxMI8tsfSkk"
Content-Disposition: inline
In-Reply-To: <CAEUhbmU-HyCr7DuQUQvz5NX3PSzvyGYoem07VnquHzpBVw9SDw@mail.gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--7z/wMdxMI8tsfSkk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 09:37:59AM +0800, Bin Meng wrote:
> On Mon, Nov 9, 2026 at 12:14=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sun, Nov 08, 2026 at 11:53:48PM +0800, Bin Meng wrote:
> >
> > > Hi Tom,
> > >
> > > Changes for this release:
> > > - Read correct TSC frequency using the right cpuid leaf
> > > - A small cpudid implementation refactor
> > > - Display actual CPU vendor and device id when booting from coreboot
> > >
> > > ---
> > > The following changes since commit 934995f642a21ca7f35fa9aed5f061394f=
cba243:
> > >
> > >   Merge tag 'u-boot-imx-main-20261107' of
> > > https://git.u-boot-project.org/u-boot/custodians/u-boot-imx
> > > (2026-11-07 12:04:01 -0600)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.u-boot-project.org/u-boot/custodians/u-boot-x86
> > >
> > > for you to fetch changes up to a7f22b345ab311488b7fbc242e408e97eca4e9=
3c:
> >
> > b4 shows a mis-match between the hash here and what's in the tree, can
> > you please re-generate and re-send, thanks.
> >
>=20
> Weird. I regenerated the pull email and it's the same. A git push says
> everything is up-to-date.

The error I get is:
ERROR: commit-id mismatch between pull request and remote
       msg=3Da7f22b345ab311488b7fbc242e408e97eca4e93c, remote=3D11ad9f8b15b=
983054ee7a3ec6ada1fd4e0194d6d
which I think is because the PR doesn't say what branch to use and your
changes are just the tip of "main". It's a best practice now to put
things in their own branch / tag. I'll grab this one as-is, to keep
things moving. Thanks!

--=20
Tom

--7z/wMdxMI8tsfSkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavHWbwAKCRAr4qD1Cr/k
CvTrAQDTYdQsApgUiDIrImLiGseMMQuGtt4Dqmb99dwI91fdlwEAhQcdjzt8JbDp
CCSG9P27GOY6bUTnYJmJqH7SdLa4mwE=
=9IPJ
-----END PGP SIGNATURE-----

--7z/wMdxMI8tsfSkk--
