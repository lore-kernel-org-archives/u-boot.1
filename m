Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39A606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MIGGM3GW;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pOyhDBu3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4789D605AC;
	Wed, 25 Nov 2026 14:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NGy7DbmwJD5T; Wed, 25 Nov 2026 14:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9365D60891
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795618463;
	b=e8k/8HC3FVDeUcQ8izKDrTiOzL8eyAPNVokAHxMs2E+j7tAdNEhP7Vw80T+VuC/jZJd/
	 ZyY4DQBaU7RV1/dik43ZFD0CmpuQWPeA6wuC+GL2Wy1uAe8NYul4+1I3KCZYTheUg+MgE
	 9WwsN9NAOtiS4eFkGJ7A0Y1JfsrWAGd5P/hZTVdxGGfIw6nuqSzX1/S4oW5DTqcAb1sow
	 ALZ21FmZmXoD+Pb+8LTMkoE+Dp2TJEvgMGi4boDTBsReh/+sPKTzwWIhKgKAu8+pxcAaC
	 RtRzCq0Xj6tkKk/d57u7I3CbWQhbzKocSgizi/uq7ZwhRH2J/bO6g0EdWm+KqhBcfUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795618463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KK29wMGDsVqVqmcxJFm1RzMBqJRmjFuigDtI5Ryeh7g=;
	b=f/KU2EsBpip/VrEgR4xPDJgpesvYvGRyt8OyYtBVBN0ZFBFW1u2/+GkK3Ssz5rUjmpTX
	 vmpCQC9Con1fSD+/fSVmutu24pwJ81OTA0j0GQI0Y7UbA2FXqcyal0QOkKmudu+hTr+XE
	 pc+pNxn24znAe5vKnzkVDvxuKCFbpecfdNKtzsBAlEkzcDqsDyGhx4xlYiCJTi5dR/GJG
	 LhnzolIIG6A0ruEhif+lRn2GYXoPTzMvw7eNtgxug+QWGg6pQ4jEMz1xM0/2YIt8Iq8AX
	 2fmGgqdbq5YykoQQzS8u18HCm0jXKOwXuYfjKnyi6Z1b9guW13nCxmjJUHkta9gLjkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795618463;
	bh=KK29wMGDsVqVqmcxJFm1RzMBqJRmjFuigDtI5Ryeh7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MIGGM3GWjwzqYW2RDmtNy+1XXPTEjNBx3o/voZp2G9A+Im/8SSKbkfCp0mYpjtyK7
	 9+Yba01hyZVtQim2XcAPR88+aIXoQRtpi50Z2a/jHRxqDxIPQALqPuU/vY75Mcn4BQ
	 CViKTZLRLen6IEqB0jaQ8qSEanbhUCO615id+Hulkv+65ifwsZ0PnB4c3cGmr6rMyE
	 mjwwAsRVDr2baY+z1dUsUq6luFDGd2qRPqi+WF02AzUedm2idFqpZSCjcoP5YGtW3X
	 vwaX2x9zJhKlQIcW1fxMzAHSu4xXngyXBS3DdK1CBIpDp6ARKKoPPd50q6U9WDHnMP
	 VaAwA8CuNliFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9365D60891;
	Wed, 25 Nov 2026 14:54:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43E3022B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29A3B80AA6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:54:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qYq828Pj9S51 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 14:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DFEF80A87
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pOyhDBu3
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DFEF80A87
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 14:54:21 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-717080a2d50so5418834eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795618460; x=1796223260;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KK29wMGDsVqVqmcxJFm1RzMBqJRmjFuigDtI5Ryeh7g=;
 b=pOyhDBu3F2hSBTc70etT9BGMOdT15FUfprquOFOAec1UHDRHqFhFzmhb+3qiuY1Oax
 zg9T/BW2DhZyE9SxrdezAs7+ku7HpJHhJLI2E+g+j6jrldVlynJpEvZ0bnaseSRcoZ/a
 mNyN0CTzUViaoycGZAM9LTokKh0jt2rmahzVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795618460; x=1796223260;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KK29wMGDsVqVqmcxJFm1RzMBqJRmjFuigDtI5Ryeh7g=;
 b=XbQMnUz8f0SFakwRiraCQJsaymhrzS7NlmEGYwu2CxaAe2ND3nwSnak4Cv+8Ke4Ya5
 /IOb3gVMvC4Asdfh8iANeG1+lzCqRiDTchUkqE39MneSvG+1rCinfkSoZGTuXSgmPOLa
 YXumx3f7t9dxjyBNtiinw8VZpL0r2O2L3wfPFTqkqmxS76OVfIFDZWpbZqQQWcyyAplM
 UcCC6wzrC/uTTs2R82F/93eEb577qGs2dW0op3DumVYls99K+HqzHMrUEw+nKSfiAGyY
 ZrtHJIoWQZ2jQfaAHgKgAHtTlL2IHyabhWH3IkRoKWXPMhzcr2dQIRcyrgN06wVEMZzI
 g/Zw==
X-Gm-Message-State: APuU4Z/CfOrv5WdE4AfM7HIyCK+W9L++adkvz875H1ZJK7rNkDxnDrUG
 dIxxoSS01u26Je8XeCOaYIchTa8m8DgLzO6OXYksVJxlX02FBZf0wh6KJEX2aaBr3VqjcT/66/M
 4374xEIx1+S9U
X-Gm-Gg: AZFdTZdrGeP7Yuvdj4fYy3EUccm2k6kOHlue2yWQjW7J+qA+LoNYuLmYGdK9WWhLK98
 FDTtixKWZDOLc4Jm4HjwZoLgkcpkgOF7ulipFG4iSPbV4JqqX4kNzmhhu/vrZWXxmeIJFpu25+k
 MEW7Y6HDDDfaxDUT3yqXrnurzX2VHGWyaFvib5nbEeKTgYgZquCSriR/6pzel1AVD8tJz2483CY
 DUkIZjo+COXVntrchX03kA3raF0mulBDD6dq+7r4XcAgh8W2t/bTMsFSKwkbSWC67hxzQXISPqm
 eFPeLnqI6OGPDI61Uu7xc9D2N99e6rsZvEtJ1slLhwyI4FG1RtkruD+Qs1vSo0O4YQYl7bZJEWc
 v+3hB54vDILBwrjSuNIvAERASNjt8T4MyYO1OgaSXALQ7NyVAepnEidRhyEOkhmd+2q39sGw6r5
 d+FbI2cHAuCbYCfebnXR2qPK3JZyJoW3cDR1LCgvwfCqbq7cZv7XobvmJxMewj6e+VytWJg7Ii7
 YzDOPs0lRTZvDG0P79g/5VquRUClI96hgUbYlnjiC/WowR6oeLNCwrutsbgz5SxWJH8cffDnC06
 nwEzwZ6xysPMapwDimBY7G6cwmR2aB+THLVk1L/owJM2pzEJmND+VaVtvLY4RAM+8lKCtwlZ7LS
 wgEHI9k7xwNg/fsUeCoTFhzENxOSBz2FYt+NE5RhJTEUI/vd5OC/3I5rPaiSs1RkKi0GRtk/1AT
 b4XWioeXnAE4t2aK5FB0IrCdbc6C5Ma4g=
X-Received: by 2002:a05:6820:a501:10b0:6dc:3be3:bb81 with SMTP id
 006d021491bc7-71b39484c93mr10642436eaf.35.1795618459967; 
 Wed, 25 Nov 2026 06:54:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b3806ef20sm11749542eaf.7.2026.11.25.06.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:54:19 -0800 (PST)
Date: Wed, 25 Nov 2026 08:54:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/3] Dockerfile: Make downloading toolchains more robust
Message-ID: <20261125145417.GE3176972@bill-the-cat>
References: <20261125134317.2479815-1-trini@konsulko.com>
 <20261125134317.2479815-2-trini@konsulko.com>
 <a75c9fe7-d630-47e0-b3c7-a2f2c892b108@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4HO7O3zQbA7u4TiW"
Content-Disposition: inline
In-Reply-To: <a75c9fe7-d630-47e0-b3c7-a2f2c892b108@cherry.de>
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


--4HO7O3zQbA7u4TiW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 02:55:59PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 11/25/26 2:39 PM, Tom Rini wrote:
> > Currently, if we fail to download the toolchain our loop doesn't exit
> > and we continue the container build, with an incomplete set of tools.
> > Fix this by making the loop 'exit 1' specifically if there's an error,
>=20
> question: Are you sure this works?
>=20
> We don't have set -o pipefail so anything but the last piped command fail=
ing
> will happily return success. I'm assuming that tar will eventually fail on
> an empty or incomplete tarball so maybe that's enough, but that's a footg=
un
> :)

For better or worse, once I added --retry-connrefused, I was able to get
all of the toolchains, so I didn't explicitly get that part tested. I'll
go drop that part and keep the failure and confirm.

--=20
Tom

--4HO7O3zQbA7u4TiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawb2lQAKCRAr4qD1Cr/k
Cjk6AP4lyJeNQTYgk8b2SUjEvebEoI5lRSRwp7xXWtm6T/t6WwD+P3mzvoLo91Tu
sFguYr66dAyiuw5hqK8Ru5/9x3iDXg4=
=Okpx
-----END PGP SIGNATURE-----

--4HO7O3zQbA7u4TiW--
