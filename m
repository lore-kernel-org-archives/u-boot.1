Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DA606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ek0Bos4/;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Cc1ue8nK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2EC5406CF;
	Sat, 24 Oct 2026 18:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22G2dCGNzdSU; Sat, 24 Oct 2026 18:35:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05383406E1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792866954;
	b=Vh9Z+7c/PHNH4x5ZBBkNUICWxOBLtvHDRfgk/Dps9EzmdxWu/b8hTbEU4f2fC+qJCWis
	 vt4hNAEsiRJIUj/EXag0CgawUzrzOqlas2nIYCVqSYiFjkSx8XYqh88CASgJwpJQcunsb
	 WPtm0mznjrewD5Qnm8QSorMXeXLhop8NoRgXj7VNoyq1f9fnBWUC0bL6WwCWIOWHN/TtA
	 BDKVVWTZG5E4vMYmh06lf/CJkHrL1gmdg9DAg71bkv00YlFHvWh8RXwD4pwPqP2ptyhui
	 bt5acYCNU1FTXX87hU1yCwR30Lqz0rVzlBw2hlgnjjSYBlPzJLhlI4tPP8ZGqJQgZFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792866954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LO2g/2xV9xJrIH6HA28dVdWjs70+D/IlVZBAra1bpic=;
	b=oD9xkAjV/n+5/ZbtwXCtC7esb9yk5BTjuQqWf6DzOniDAfpFPVvI4kbCTdjWPTdEi6Iu
	 rp5fXpg3VlVtkm6Via2lvN6+uuWbt4yVG0x4ZWJ8DMFDwb735crLh6vm0D8BHFhsVrfY2
	 GD/95tub8axgNQOoYWaw1xmbi7dGkukMhsh0mpxoVILQlix4lkLAU4nVd6oFBLsR1UING
	 8pO+VPMO0i+OpQMNEYFhvl3sBERn3q48Snmz50In0SRi6pi3sS4boHfMDbSPsQR7IpDpX
	 8WC6yhdPCAzK+CxdHBwqX//r8HI5SlrSYwjlAd3CLOWN8bFsnTI/VoNYXMVvM0yTKyw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792866954;
	bh=LO2g/2xV9xJrIH6HA28dVdWjs70+D/IlVZBAra1bpic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ek0Bos4//SPWA2rYIi4MOXf18TRtizlxYDZvjMfxRP8Fwp1r8yLaAgHnDP+2c7jCB
	 TkqRgxjefQr7k8ev9/+J5T50ggtmHyRiTdvDwvVLENsAYahUyjKtFifE6w9GQZSjyB
	 jHkY+7KKi9CrObOCOkmExPAiU7KqyGX/vUxVT0BNm4K73LUQ+OhdFKOW/vrq2GQkGs
	 5iUmEEpDo0SVz6gx2hZS8uZQ6lYyb/Q2mbLaFqkl3YN19xewxhVZM3GuJO6wm8dHC/
	 f+mdWr2b6Xc4wMVAOeCPIqitHcFAelOiPZ5QBvqYEoQtrxFAx+Y6bfbrvHxgkngY5y
	 oF5gT7eWxAsqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05383406E1;
	Sat, 24 Oct 2026 18:35:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F68D43
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81E3A4009F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3D6Jao5ZZmUB for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 18:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BD00F40049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792866951;
 b=KCOWp74RyA7fcm6VJOs+jKPDFFKedHNBI1k+dvl0KzkoyptdxtYDHRxPfNd3T/vVGMI2
 KoB2OvA1tAUptTPKVIo+sDHZGbyr0ZSDEj0HGDca3Fbf9lVBspqBrhEdYOKHoEHOpnY84
 yj4AdPw9ZtR57PAyPL4lxYIrBVQ1wSI3zWYx4HkYU/2sKpWkoyGMKunYm3Nn8inUKgMbI
 2m3DYyoL3/OmA8IBQryqR+Wvq2Xjub/foatSVe+NIs74JeW/GsLMegCPQSVQj9wv9AAyb
 pCBCJd+lkxngj1ud1PzANXMhdOue6zV4JIWsVtiYjftHiRk3BMqSFkdZj0JFTkLPuIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792866951;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=LO2g/2xV9xJrIH6HA28dVdWjs70+D/IlVZBAra1bpic=;
 b=oqc60jAW3eOM4fsiKu54zyGdigswvkR2xdx4vsViNn4iZc2uipEzbBmdQ9XuI4iFyCvp
 bI/vLHx9dIPSdC7vYQI4uI1jdRNK0VSWg4+anG5tOt50/d34k02iedZWk0mEL2F0Kbx2w
 3qqLLq8aeoaZTDPsw77ahw8MrCrTc9RSM9gIQ3gDRkW2tKveZr/IOaykNMs2zf7c1F97F
 slRl5QLq9ULPG+6n6y4vVDQyLV3GCPYEQ5aYQ8gei1CJ0VNPgccH74jLdXoDSJ+TrfJhT
 XZ74vt2PtNG1fVApevF2pmZoVoBWePS4JQoJlBFBxJwFS6CdX3wAF6vUJWtLgAJqzYg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Cc1ue8nK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Cc1ue8nK
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD00F40049
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:35:51 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6cfed5dd083so1323374eaf.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 11:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792866950; x=1793471750;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LO2g/2xV9xJrIH6HA28dVdWjs70+D/IlVZBAra1bpic=;
 b=Cc1ue8nKK0N5vpjDH6diyh+qoJINZcZzQyFEuZLR27q5IpFpFdZm3Oo5EYRmABV46f
 QV/Z4YTa8z0RYkHhX/W2imwQXD0wEi8LNtceErY5ZJKfY6U645+XoiTwHqrglUKMRPEi
 4q4D7Xe3RmLzVzoaolQKPvlfdICfGl9qx+woo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792866950; x=1793471750;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LO2g/2xV9xJrIH6HA28dVdWjs70+D/IlVZBAra1bpic=;
 b=ydSfbY88EkuB38y1KHJS3HHfTYP/A+n/V1NPQY3APheoAyKz7IiLwyt7L31tT6xptP
 8kJ86IEqnKfKERV8Q2BbzqWrp/dLnXGyIG6VyZalg1bTxDwvgvTR7Iv7pRj+TWDkT41W
 qakiWduTnIxPSwSXtqiVCWpUFs9F79qvhJZlDt64bd+ESygkYlPDX70fkvWyV9z2qcJD
 bOWIX38MA6CUFld+cmMyJ0XcUA+xnKDBB9uP5FcQ0TqT3LsAQ/qoZDWdF0rcz9Yzjfiq
 zK27LspATrUoZLnDkKrFKWAfNZcDdwDNJq5vHQc6OFLM2OIDaz9487RVm+dw1oc0kQm9
 Re7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2sB2kX6K+w/Ds31nxlGv3X5wryc5rVNPz/dzyNYZGvJ7OLK32FQyAvwV8DzkXXWQlAgosqpY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJPjZY8rK+5zyUk2SmbCArsaTJ5sXMHc+H/7VhOnk4u+R1bN2oI
 UQ9opt0kMogHkGguX4Six227QG0Af8Z7AliCWoscptdFM1y6AOexTytRY0cADuj+N/M=
X-Gm-Gg: AYBFou0b1+gd0G3YCQzA3ZDQ/S8E7o2DH2nwOcAhvqFgToreAGvdl6aVc3Z7GhZOqTl
 7WI65Mzgdp/pFDk2cfRn/40pmK2gv7TAm7X67rDhEX358aA4UEKYlX1dpZ6/soPX5TOGzp5C0GJ
 6x935/k4WkfGurnRi9oHlbNwSQtciNVdpV+w+emP+4UlpQyu7fvz0/v0Ajq1aF0DLRSLJDU/zbo
 r33oNAH+KbCAR24y6fcgybfvkXaIq1wtUzeWrKBQIqvvstIS5xvbiFYSq4Td4u33Oro6Zx6brjm
 qYIS/5aAzhyb9LVI193v8XzaNtLJvG1WHGPQQWlxWWw8dj4cNU6DoRiBMfAfA42OyMEFbLHYri+
 YnJtFmY1mVJoQWsNblXaB2zq4gqBegVvspjLM1dh6v1nH463frj9aPwMTuJCxbiyycLv+53xnKE
 DCWTJB8YKU6jJOp9nay+p6eWyGf432usI0o6hG36NzvXgR3UfK/ufSUwc7whaaLdZlYKGWfIgBC
 SB7uYMLW63NyhXnURsAn57204kf335GFFyTXF1HZeg04wMQFkeWJhPtUj0PxAVh6gSETdfU89FF
 sJSZ4oYCu7+2yZ/VBDsk4nu3DuJO8MCmiYuGaRe0LZCy6A5IlR73hd7WJBPZKjsBjzh+I5i7OH8
 hdC70tyJvTuDBRJgxmEfE867CYrN7ZgVTdcjmm4MhazIaAgn5+ENVCPpZ/A==
X-Received: by 2002:a05:6820:3407:20b0:70a:2478:f607 with SMTP id
 006d021491bc7-70ba0e314b4mr855387eaf.46.1792866950448; 
 Sat, 24 Oct 2026 11:35:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9df05055sm2840228eaf.3.2026.10.24.11.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 11:35:49 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:35:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 xypron.glpk@gmx.de, nathbappai@gmail.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, sjg@chromium.org,
 aristo.chen@canonical.com, jorge.ramirez@oss.qualcomm.com,
 smoser@brickies.net, ccaione@baylibre.com, vincent.stehle@arm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/4] qcom: Reduce boot time by avoiding unnecessary
 initialization and probes
Message-ID: <20261024183547.GN3596691@bill-the-cat>
References: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9g3OgV9TX8XMt+WR"
Content-Disposition: inline
In-Reply-To: <20261024173749.3509050-1-aswin.murugan@oss.qualcomm.com>
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


--9g3OgV9TX8XMt+WR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 11:07:45PM +0530, Aswin Murugan wrote:
> This series contains a set of boot time optimizations for Qualcomm SoCs,
> targeting unnecessary initialization and device probing paths observed
> during boot.
>=20
> The changes reduce time spent in memory initialization, filesystem
> probing, and redundant SCSI rescans, resulting in measurable boot KPI
> improvements across Qualcomm platforms.
>=20
> Boot time savings observed:
>=20
>   - Disable malloc pool zero-initialization: ~74 ms

What's the guaranty you have that the memory is already zero'd ? Or have
you audited that everything calling this early is doing calloc instead?

>   - Skip redundant SCSI rescan for capsule updates: ~34 ms

I'm not a fan of adding new code to special case this part of an update
path to save 34ms, please drop it.

>   - prioritize ESP during boot manager default-file search
>     to maintain fast boot performance: ~170 ms

Assuming it doesn't subtly break other use cases, this is likely a good
idea.

--=20
Tom

--9g3OgV9TX8XMt+WR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatz6gwAKCRAr4qD1Cr/k
CjDOAQC3GLl5bqvl2YF2At9E37jyfFJ7CUKy4m8xOL6Z2/qhXgD9HedX+HEESpAB
6OBFhSsm0vbVTMlpffbthlLg0IkUZww=
=3+Yj
-----END PGP SIGNATURE-----

--9g3OgV9TX8XMt+WR--
