Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B16606A32A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ejQ5UT9V;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oBhKOX8w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDA2B60710;
	Thu, 29 Oct 2026 16:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pfOlQLUswGtJ; Thu, 29 Oct 2026 16:55:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D18C6071E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793292950;
	b=ZLrRgIoACiB4O7th8+Ls3+lULzRXLIxVDKNwgBsg2z5NJdakPMvTYirUuVcyeB2KV9C3
	 lLeQxq18Jnh1ZZOj2pPnb1LZPedl4nS2IlCGqb5q7PQM1SXYbERQOdh6inA3OAgy0uI49
	 JFsq0E9TBVRuSDNxnSDwxacOwFVrRHb+My4UgGrL7yk+eFNR9bnBFbi99jUorDkHiUoMq
	 P3xPWY/nemKlsFHz5BNVmlzTw1tmGJhlT+RcMmNCuGE+DTFKysn0jqY1o575d4VOMCEEd
	 qcTPy7bKu3dwULJNqahwXVX95CB+27/Jk0M5cLlfCgjxOmKcFJNfCB4jSSD3q7YY3eQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793292950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FhSZI4SjHXN6WF0q13YP0XrGT+1hcIzo3K5+aYDSrYY=;
	b=QyWjH8GzXSLTNMzeLAkasEqebEfiKjebjKjxMfIRuM++m00Gnx4L5KMoo3Pr/qkbwl1T
	 3FUPkpCcLUucc7qbWNxOwMbAos4RrIXX0KGJGIXkRmivD7Mqxvk+qvlhb3+cCUEY5PjMK
	 P+bP6NliPbcYxgZw16/D0DTgnRlR0XAGWM0o3Pr/fioe/t8krw7+cg2itaTJmrLJ6meWo
	 gfKEg30XJq6sdzFc85Rs/3MSsLeBRLYua6VS9t/XGun7umglMhZmeGZbLd30PgoA3OFdp
	 vWRzqs2UuFzmTSB7mbRLesWjii1/tOjTCPkpFEZujPWaw1KtDACKKcGqkUjBSAb/mrg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793292950;
	bh=FhSZI4SjHXN6WF0q13YP0XrGT+1hcIzo3K5+aYDSrYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ejQ5UT9VSHB1zMcYzd6rSBq9aiZbM4eoR/3SIcnhTSd2+FBvllvbROErZhnxFFkIN
	 9KiOf8Uf5HHbIRKvBsOQbGck5MtxbB7KoO/WX3fqVybAQq71Mz7v8WUCrvB07hgNrK
	 N2xqWO6RPz5gJ0Hrm3st7XlAQgRWym+P6NyNkvsAh1WbKfViPrLB65LoXrLADKmBV5
	 rqCji6av+G0UPsQJG6kOyE9rv98GSRJXq90CI+MHIDr21L0FdCfJgnQk1h0tp2qaOg
	 oiTTvnN0/2DnPJap5FlOq0tEEViBizNi8QRMSVeJLHTTs5vG5HTrGdTpVN3C2I0aVQ
	 NU0C3p6Sh3N6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D18C6071E;
	Thu, 29 Oct 2026 16:55:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE411DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD37A80E10
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yo9UXafOglzI for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:55:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2D3280E09
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793292948;
 b=l9mnyTTfcNbVCyVTM87HX/jhxCOhPrrUGQ4wTP+Ro5xLJi8YJtyvJlqe5X8ndyB0lhh7
 QPTy66AbDhqFpyQj5pziXg7ROsVGoTPsbkXBORCuZDqTiAkh9WLBkrP2K8BkeSSRNhVWo
 e4eR1u/9MuK9SVH81M7onWJ6XvYZBzSCAzfSSXv9Ti+8pz9wnwAq0RvH3BIbIpnBwOp0V
 nIFuHEmpew+/bGqKLwyhSc3O4QDFoKI1MPvkk4OR3/9oh0jUTSsPh4aNyjDWknXSoWLil
 5TdW99kSP9gfGVMwiGD9udRtzMTXO8CRckHsErIz7qqet5y4SmQNKCr9xd6y+VciaFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793292948;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=FhSZI4SjHXN6WF0q13YP0XrGT+1hcIzo3K5+aYDSrYY=;
 b=RgHm4gOVdVbUOaUGoqoOBhrMZEGScvVJApuXiOnVUl3DC4TE+bUxCPRXQpsR7wbD8MFi
 zKgrHem9+GYw4J6IwqY8f3y05ivrmWvTwPLutASBwzxwu/KC0eMQ1aB0LyaVCNAz9HiZF
 ShroQ9m+6MM1DGzS+Sj2QXuiTJzr187vGfJBYaQmiiJON6oe9hlReSIQ+UAp11RZmynhS
 aas5czWARrCnw04PV+/GbacUpXwGKNBLfZHgK1bJu1yPNe5XmpesmQYHQqoHcaZP4isbK
 LqlfZbpSvyEjd8ECw3PXI2Qz1uK/+F8rPwt9UZvjeUBik52d43ZD2RRTjPPC8NXBqZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oBhKOX8w; 
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oBhKOX8w
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2D3280E09
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:55:47 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4a77761ff8aso1304020fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793292946; x=1793897746;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FhSZI4SjHXN6WF0q13YP0XrGT+1hcIzo3K5+aYDSrYY=;
 b=oBhKOX8wZcvE0dJwFQNK1zuKf0JAeftVX6baLfKGPLiCuWwD/LrXvEiQchSmBk01Gr
 z4BlX0e7UhBVmbsfpZcaXudrb+gC23EONho9uNnzzemoLTUVdePPgk+DCVjkO65ILoz5
 l3GQ2CPntHDNylrwgNA7kcq05i/8zScDB/5WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292946; x=1793897746;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FhSZI4SjHXN6WF0q13YP0XrGT+1hcIzo3K5+aYDSrYY=;
 b=yutWSklpg5yNm82COqKn7pj7zLt2Nwd4I6kWPpbRx10D8aQm5zR8JBi87+688dK3V9
 fgX4ihIGPBQnAf7Vvl7ObPHasqjorzUK7CKr1VQnLxYbpOaPjQ77aXwnSkn36Hd83RyO
 pqw9ZRpnfnrI1UeP3IAKvHcmWeE68VPND18Lv9xrzgS/ISwR2ms6pQ25AIv8YjFKZrCk
 BKVjkpwXpz/+hS1/ERSZa178wMvG3Yr/b/zQD44Fc3kkXREuehbKe6yi2KHTPtRUrYCd
 ss0ZFmYzlDP+Ys/x+xkJnP2IO3h+DC4dU54HpIlxk5BUYiXpMnjuRYhioyTgOiM98vV2
 EmqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5DjMSsQ7RygYyDNjts29rT3DoUvcfbChThdBbz24pvH+VqfokFNj0J9D3tRCyD3HFolxS+Wo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIkDM6OEHMnx+ScGhgcJ/Ejr3iGj79Pk3bSBt8H/6xaTHLxyF52
 laAnC/R/fOhzZKqTdhc2j5CWZ4GuzOuZW4NCX8m5FlZd6RpZnVgbp/x+bBkPsg2duGM=
X-Gm-Gg: AYBFou1FyaoqmRHr7JJFGQr63CXsZzZo16+jtaRsAyKPNDOI7Vm9DOYbCwJjs7MZKy0
 pK3kSSbFr/kJmnEX/f2NshealAEhCGf9+i0atnpclebDYAH4HqYqHXAvaKMkC1gEK1rC5FdUzQ0
 /S7dat+iGq5eUvJ0JPZRj3AetxnHpBFSpoXCo7p4X2y1K4/IzWjWM/HlSy8chWU9M2EMTd0sWMM
 etdiYRRGjLqrbMJ0/FLCQqrctEqy2Zd03Vt2h9N+WfAAwWDd+xlZf2C7PJvfUdqTMFUNvK7MaOG
 tTcjN084dL9y2HaB1w0BVG+1zpKEwsWfh/3kT23kOaaRRbIacxm7KU/BzWcQGx4kBsbJWisBdaR
 e67tSxVjXyQR4qDtOBon9zdSCCTTmuXqrXNHbFtKBm1lTujrDCTNReR3Ag+uUr7I49vONo0aUv1
 lJtR+MSP5C0vhWfYDWznUqdt1zKc3fS2uvoBllIH+wX8Labkdc/2gnrQmg9fWW94ZIk6EBDdmqy
 HJVIyJ/HeoXDEECldejDrCi1qpgNZiMulAzP57nzCxi5T/rqOrBcsMhS1TBlZbCs01SKsMwf6wF
 0ARANCaJ6ipNmTMbWS9SrfZxv2OKw5In72ey/dqPUjPj2HJgtdQuXyY2WxNOytmAuLPN49Mh9dr
 XyRihqqPj/rkboqcQ9kGN+tDV8ZA/Eqg7IZCYcjW8yMuRLf60Zv/B8XcrzChpIj2naBNd9vuN4l
 LEb+9M9vR+hUY8LqrzP2Y76mjVrBsIK1IjuQk+gNIOvN5HgzqVV66Kug==
X-Received: by 2002:a05:6871:82a:b0:4a7:2bbe:4615 with SMTP id
 586e51a60fabf-4a8bb8c1114mr4274625fac.38.1793292946587; 
 Thu, 29 Oct 2026 09:55:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a901fe492fsm338393fac.3.2026.10.29.09.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:55:45 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:55:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 11/13] board: qualcomm: shikra: embed XBL-sec in SPL ELF
Message-ID: <20261029165543.GF2976463@bill-the-cat>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
 <20261029105746.3487456-12-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lC/WYbbZ8bJE/Avx"
Content-Disposition: inline
In-Reply-To: <20261029105746.3487456-12-abhilash.v@oss.qualcomm.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--lC/WYbbZ8bJE/Avx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 03:57:44AM -0700, Abhilash V wrote:

> Stage the configured XBL-sec ELF and embed it as a type-5
> PT_LOAD segment in the remade SPL ELF. The linker script
> places its complete ELF image at the configured Shikra
> address, alongside the U-Boot SPL load segment.
>=20
> The resulting u-boot-spl.elf is unsigned; external tooling
> performs signing after the normal build.
>=20
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
[snip]
> diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualco=
mm/shikra/shikra-spl-wrap-elf.lds
> index b2922cd2c2c..387b83ae6dc 100644
> --- a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
> +++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
> @@ -1,18 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +
> +/* The boot ROM identifies XBL-sec by the segment type in p_flags. */
> +#define PF_SEGMENT_TYPE_XBL_SEC 5
> +
>  /*
> - * SPDX-License-Identifier: GPL-2.0-only
> - * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.

Please just get this part right when you introduce the file.

--=20
Tom

--lC/WYbbZ8bJE/Avx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauN6jwAKCRAr4qD1Cr/k
CqIBAQCAmTv53Q/jvegorYE4A41pPgBSIuGiY9Yme7ZxeFx9UQD/dwEcoBuWPQFM
McjZj7QOY/OKQYdmv4+vdAXLPLKpcgM=
=DC6L
-----END PGP SIGNATURE-----

--lC/WYbbZ8bJE/Avx--
