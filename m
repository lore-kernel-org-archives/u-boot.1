Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CDCC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 23:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0FBE80FBA;
	Fri, 14 Aug 2026 23:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5bKg1I16NDL; Fri, 14 Aug 2026 23:20:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8E1F8100A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786749639;
	bh=3JmDHSnA5vNAXk8UJRnJAa+wqyWJPsdHMxVJlW6OXpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kR1RpTDWmFUoTmlloaHKGBmJaLlEIzAjugidl4N780fjV/xvgc/SHrqnu2xbNMdbt
	 AGvpg6lfCZb8NUSUfrMsHJGcY98v+oNH55Y362jTqJRSsWTQNMweGXyRcpw7lcU+cV
	 c40uOCCtueiOzj4CFJoR8NwLZhbJdTyj1hw1gm1xWUCCyonmFfBvL/6hpoA0NwVSg5
	 oG/cjSkLzcebpPEfnFZjJEcVKGa6VpZl5OkIQUtsk9G9wsb7DPSux2iIFi3yb3uaqA
	 HECrECs3Bn7dyf994UkLEWnAoekVD6ntUPVGhYPTwZZDYa2XN2x1/PBaB7bhPbqTWN
	 fYlqukeIhermQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8E1F8100A;
	Fri, 14 Aug 2026 23:20:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 07E1C3DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 23:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDF1540B19
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 23:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pn63EL_rlzCZ for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 23:20:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 388E740064
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 388E740064
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QtMHj/2Q
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 388E740064
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 23:20:37 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-459281bc13bso910408fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786749636; x=1787354436;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3JmDHSnA5vNAXk8UJRnJAa+wqyWJPsdHMxVJlW6OXpA=;
 b=QtMHj/2Q3m/Xuh8n+5xDG9PHmHB8xIzXfQerw1QZ5TDEhudgzveKswOwc2y2qC2euW
 lnRkULPQ31h3d6UdM8g4f4hiuaNmuCt9ZfV7NNEbO21V+GuVyHS0kFD/g/Qr3w5XiiBq
 57YOYPhERNrART0+yijhLhRG5E1D4+pZ32flg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786749636; x=1787354436;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3JmDHSnA5vNAXk8UJRnJAa+wqyWJPsdHMxVJlW6OXpA=;
 b=gm6b7pLqZ4bc8wBxfrwAXShiJ3l+vdezsyoeKibentlrIlKnQeUsIIplq0wdwqTb9P
 OQB4tYr2GUnQELAPdt+PGhS8UDA8RUh/YtmJR1c+mfuBxPuwkRzjC4NF3uKPP99asJQX
 L10gaaN60+bA7TdlCOUIv1yAGaG1SL5YCtbtj6Pwo2LX+8q52GQyDdycnMPYtJ9tYnVo
 NXZh1FT/BAb7hMuSgIPPf1f9ydl+dgmaX3I0dtKbIJWEUXpo712MHGA7Z2ngVpFAccFA
 A361Fwc/+dlFXNsfBfeZ7YYpu0CHfS5l4z/KUAATb7e61XpcsORcDl3vBVv8u1MquQTQ
 4zXg==
X-Gm-Message-State: AOJu0YzsJEMjIdvtvJkiFnTyLn/jqAOI/i5ZDfQZt0vrgaGIT7o2++en
 L9YsN7y7vpLtRQVz8I0fYQtTpbcl0El1Byax6ilygTYSgxbkGpL8giE82Vs6xjg113I=
X-Gm-Gg: AR+sD10kUjXGd5mOUuH0aJisIfq2ha+MftZhD1MgdetMtMel2Pqeru/xj3HN3V+PTPU
 /xx+jlx0KTRI+vefElu1qrORpYsE5NG0QECNGXwJHTpx8uFUq1jHawgbFDN37W6K+KgLsUxP4xR
 JpmFMRalpBrvtW7+mJe833W791TUqYO8L8EHhvLPGEuUaDqNA6bSeW9B0TSCvkzYLPmu1l53w3f
 mkqDC/X+ZpTrAIV/5qZpOcRtrsF0wVnH9aNmFSozxxwuJp+zbXV3wipSJeuyn06sA6qE2GcFVyF
 uoRdteaNpavXCetUIowaiUqGWT8si1cB5vfhU7isaN/1ufWn0Lc64bntDXqfwcu28aEPbUZdijg
 0nN9uymz2md10v2trJGpSePxuflfW/6PlbZnN8ByXWn2vFIxmPRXfj7yPvL2Bt7gEG4h1UAWokw
 /STrf/zGSBRpEOd04hWfIMPsz4zqn2ElmXz+FQewRjOArqxZmTyUBtL+wQoJqpSobn/mYxyUX+F
 NZnPrW6mhJjYWgE3vnV20g/lzBiWMRuM75FR+3PA5ddkZjg9TIbAH1P4sqrVyRfIywDyzuyt6Y5
 9EHlJSHGSA==
X-Received: by 2002:a05:6871:82a:b0:442:175:cea7 with SMTP id
 586e51a60fabf-45e91d4b138mr7836957fac.1.1786749635992; 
 Fri, 14 Aug 2026 16:20:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e8ff3172asm3338014fac.18.2026.08.14.16.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 16:20:35 -0700 (PDT)
Date: Fri, 14 Aug 2026 17:20:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH] lib: zstd: update to latest Linux zstd 1.5.7
Message-ID: <20260814232033.GM3297518@bill-the-cat>
References: <69502f5a39ab3f07b7872cc6dcbf7e86f7e7d42f.1786670589.git.Munzzyy1@proton.me>
 <dd01c4b5-ed45-4fc7-8670-026aa38ee284@proton.me>
 <20260814185328.GK3297518@bill-the-cat>
 <259e9abc-603d-4a07-bd6f-41b357abef49@proton.me>
 <20260814210646.GL3297518@bill-the-cat>
 <08526dc4-5e28-4ecb-950d-e9ced9de721f@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KEUC49Jx8T7XMaGz"
Content-Disposition: inline
In-Reply-To: <08526dc4-5e28-4ecb-950d-e9ced9de721f@proton.me>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--KEUC49Jx8T7XMaGz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 10:37:00PM +0000, Cole Munz wrote:
> Thanks, buildman -B localises it well, and there is an easy win in it.
>=20
> Almost all the growth is the new Huffman fast-decode path in 1.5.7. turri=
s_mox
> and mvebu_espressobin-88f3720 give identical breakdowns, text +1896 rodat=
a +24:
>=20
>   HUF_decompress4X1_usingDTable_internal                 -    1508   +1508
>   HUF_readDTableX1_wksp                                  8    1312   +1304
>   HUF_decompress4X1_usingDTable_internal_fast_c_loop     -    1092   +1092
>   FSE_decompress_wksp_bmi2                               4     316    +312
>=20
> Upstream guards that path with HUF_DISABLE_FAST_DECODE. Adding it to the
> CONFIG_ZSTD_LIB_MINIFY flags in lib/zstd/Makefile, beside the
> HUF_FORCE_DECOMPRESS_X1 and DYNAMIC_BMI2=3D0 already there, takes turris_=
mox from
> +1920 to +236 bytes against 1.5.2. Sandbox ut lib still passes 133 tests =
with 0
> failures, including both zstd cases.
>=20
> Trading decode speed for size is what MINIFY is for, so it looks like it
> belongs there rather than on by default.
>=20
> Want that as a separate patch on top? I did not fold it in because it cha=
nges
> behaviour for existing MINIFY users, not just the library version.

It looks like HUF_DISABLE_FAST_DECODE is a new symbol, so yes, please
respin with that being used under CONFIG_ZSTD_LIB_MINIFY, thanks!

--=20
Tom

--KEUC49Jx8T7XMaGz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCan+ivQAKCRAr4qD1Cr/k
CoO7AQCdZNHctc6COlqCMv8rYcqEiXnB1QbEb02jei1YXtkqfAD/Y3akHgzAv5c6
0YxO7Y9BtBELZ/US+y4A/KKLpngENAI=
=WcVX
-----END PGP SIGNATURE-----

--KEUC49Jx8T7XMaGz--
