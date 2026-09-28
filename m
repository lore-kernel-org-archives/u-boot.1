Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CF3CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3B2780E09;
	Mon, 28 Sep 2026 17:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVSXjOb1ETzP; Mon, 28 Sep 2026 17:01:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B555680D39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790614914;
	b=LvlelM9OS+gSHGnV0PlrAwgXBiY7PzBbNqOrtHqEFO76XkpP0v2vJVveICUUuJttDgXl
	 LJL+rQIoKN8fZioyz0g2kbyIAk3FbaoCMmEgNe6ybrT72LjoJ/EXRIES0okb10ME63fff
	 R7SleUxUZlxAyAm+fSMn8XLFI9ALig/XtYUKmQeMlCFRT9OqA8aSPvJb8WQak14JpN2G1
	 hqA7H8pBuXHOPVBL/fvpUINY8ADw4YU2Xc3iV+Bf/4TyViKRWL7SkRP96bV6WNtjExLz0
	 Qbbs3V66+vRUaSbPfeOmfuwLCgImRyzc7BxLU3ltNyn+5oLTxw2OX1BSXENfU02eaDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790614914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uIe6E9rUxPtcA4nRWUZzQU8szb2oa+oj0DPZqBuoRrQ=;
	b=IMAfnQNA9cbprgpMWkXj5unYXnBEF2QoHrRXv1Zdrl50dGXDpP/TahUSVPY3uGjL85ir
	 OvFTKiJR/AevW7lczd91/XVEHmpdfYq+ih1CifP0RrZvqTOl1vXCyT+LUUXcn1aKFwlSK
	 AO+DOyWUPtqVesnhs0r6tbP0V3A4ZoCfq/ZKntn6jdyFYFpd+Y67M+qAOGl/+pypzFtzQ
	 uyXo2FTtf8dw5kwvhkLgZiFca2ICG7a4fr7uYwe9hGnsHpvv82PUPWl2LW1o/a12caIFt
	 BgxLmqIA2hxgGVjUG2QL5VuiAaIEENMcD5Q+NGON9w8qJ3K0PRsKXjebg9rNBfHTyRg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=tlwPIQYB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790614914;
	bh=uIe6E9rUxPtcA4nRWUZzQU8szb2oa+oj0DPZqBuoRrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lu2neDnhVBoxfzexpvkw589fhG05AMF7LZyXxJlYK4MHPSPpzM0sRjE6H0ufqaw2R
	 mW2YOPwmNWUPb8QRk9XeyyNY43PYin/LNtJsT1tXTjyguE0hoFAsq+aK+GKap8ZffB
	 ZDmGX3BErz1yF2CZ/bwy8NrobCD8QPrOp/b8w4aSldRUaIMcadmtWXpJs9kzZp+YW9
	 6LykpQntCXn7Fa4HvyynKWUMHzl/c2hXHBA8hLVeGpXS9f85SmlfbsUpIsAklpDdkY
	 tBjmZ2DrPw8PTjG7NbfMCITus8L3EXfLzHIO35ltqX1po3sLh4x8v8ZsjND5X+76vX
	 MM5B4qvN1+AUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B555680D39;
	Mon, 28 Sep 2026 17:01:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 086ED72
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4D9780DEE
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F8Q3gdgjBoXF for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D35680D39
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790614912;
 b=fTuWeR2dq2i7WJ1+8h4EhxX//HLuGSx2m2tJwpkjnhfFBjdniduEwOvvYAQEgDuLYu2K
 Fxp2gW8/vkXZYthq3hwOlt4rOui+LjOnZUl9ssY6V+TF1gScvvcLBxNzcVy64781ZIlSt
 vj1rCEfWpA2mOJgtknVgnd3A5RV5rJGUhsiaUs87ewUWIj52hMcEeeCt/fncqccUdKFpD
 r82PFue6s7teojqkFHj5kGY+vCl9J6yhJYbnmk+bMNa/JEetoyBlfju21NOxZsc2q3Nbt
 XcVI3L6GKNBe5yjGvPwrCrFkoVKg5LVIDGq+3G3xErtg6LdLsPdZjMTSHf4eIP2JLLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790614912;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=uIe6E9rUxPtcA4nRWUZzQU8szb2oa+oj0DPZqBuoRrQ=;
 b=krxZyhD4ZXUIV1/Li/1As9qqC56Yn1+UDeZZn9qqkK2x7f5ZA46vhRlCUcEsJvKvV5mR
 Z9FzhzpbckdMzRRGPn+t3JTgQRynTv9tI8y273x2OKQe9Q+wudIR3vCVXwQNpNsxY0cTG
 b5jVCEpZxc+AkhMZXxYyJEfeZqqbwvqFKoSM2nQLTPTK9EKZE5lt7u+cyxmkIvDb3l5Eg
 o7RwvQYqWpDdgA8l6Kz+gkYkR8rWeE3K2T6JuUQ6F3uESbYFwfh1O/zu272LYMZfT+Ggl
 JF1kJ3Wnlf3rXHalbSMVoJN7CVu/1zuPe3sGd6rmioFusclGONnHAgrr+z96/vcSrEQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tlwPIQYB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tlwPIQYB
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D35680D39
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:01:49 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 006d021491bc7-6d771dcaf3fso658934eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790614909; x=1791219709;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uIe6E9rUxPtcA4nRWUZzQU8szb2oa+oj0DPZqBuoRrQ=;
 b=tlwPIQYBt931tNTIw5G+wZ54F7fVVZ4jGgXCnCfq2f3jGbRyPr3I5WSNo6Le5Nw32B
 aFQNLq5k01q0gO1Wi+PSeCtxn9BfshdytLxJMGpwUbNu9ScEWAbrtT+t3C4gRdF5dG/m
 YK+bwkV8H0jQoqcFFwXt5cjAZIRFyFfQUIL6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790614909; x=1791219709;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uIe6E9rUxPtcA4nRWUZzQU8szb2oa+oj0DPZqBuoRrQ=;
 b=WSJl1CHUgwXuDI2YgsZfWShsNLuMN7Ktilb8tKqVvAui03zkVYVUuACzmvz0W+OtM+
 exwmC/i9FiwvCcGoAHdRLxeMSypEFqi635Ps86hFOkzWL8G8ECEq1h5DD1fYJP5+DzNb
 tvbRnoYxZqXOnO1Y7rUsR2/Scyx2RdDzDoErR41Q2FCvqoE/aJSrhKCRjcmMfOa4qQjg
 iI/BZV9o6ETXdoIFYhIme4ahHMOibSfgUWcTE3g3xI773x+ZEVT1Spi6IPgWUQYf+KYb
 U4RnejiikjsqBJLizLdcu7ZZHVH65JDp1ZL7bZ5Rf/eBm2blbnxPtQHAwDYEbShO588o
 4BRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7VE+XjkYGx9fyOghlFZ5aHddDGbbqauV/TmOuO+/UcM7K6DRDEOlOFXDq7Q/XIi8qNO7esA8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k9AdXuTc6kiYjR+0Cw9F7hXN2/P5cs4D4KBOIdzwkGq+4EN6on
 GeQBWxR1HwRzbcID6jsgQt8M2hfNTTPMggEpc3/9XPIF3zI1hFB46GU5ZYuJgltWTuw=
X-Gm-Gg: AYBFou3vWKI6fOZVR4eMVcaXCIIrXX0bGOcekoj+5OOffbfy1xKPISEpJKTMfFvPZm5
 9UK/lqftV2mp/dmyxwwv+ZEonclmDZGOhfBAop4w4IQqxFKjHOsNdWLOqWwze4MnPHfPgGIJ4/q
 WFIyPeX4l6RJsPO7EkWo4PruveH1UzTy6pxOhNBAFRkrXTq1pJDohrHoXBmLunPpul06ZvWYdSi
 jkIenvoUhI8OTFafKZjmM1fJF8Nwe1aNG9GMpYYbo0kcEX4R/LNUJWJ2jzCHZaZO0NQE5O693uw
 c1i1cbMX70yNzbWbnpKGTYr2/sPyFyykXjjWTYxd+5jllnSIV+H6qPGrjE6D0edmlU4LkQMEGic
 Sisog0q8yZ6+v+nUqHqkcPyNAYXAfTH6VlTO/nFCtxwZXUr1cVtxmVAXcj9+YwXzngwZTsm+YH0
 QSQYeGRJziv7RuhE/mx0NjvTAb69AQu+b0M6BBGJx8+9v8uqFm1gVqdl1xx62DvCsBNVQGd2FJX
 R4KQBev05ocqlCWffYolbZLdlqT4267KhBibNyDkvZlOKfBM/nJHDBN7ywddwPQIsKdbVNwBo8N
 r36NBLGuGMzNNbzMf31DbipOuZ97Pg==
X-Received: by 2002:a05:6820:88b:b0:6cd:3fcc:96d2 with SMTP id
 006d021491bc7-6d440b0c2dcmr13084755eaf.80.1790614908553; 
 Mon, 28 Sep 2026 10:01:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d58f113b0sm2044606a34.21.2026.09.28.10.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 10:01:47 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:01:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add HINLINK H28K
Message-ID: <20260928170145.GL858934@bill-the-cat>
References: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V3Aar9BpLIMvrGdB"
Content-Disposition: inline
In-Reply-To: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
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


--V3Aar9BpLIMvrGdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 08:00:00PM +0800, Chukun Pan wrote:

> The HINLINK H28K (LinkStar H28K) is a SBC with the
> Rockchip RK3528 SoC. It has the following features:
>=20
> - 1x USB 2.0
> - 8/32GB eMMC
> - 1/2/4GB LPDDR4
> - MicroSD card slot
> - 1x 1GbE RTL8111H Ethernet
> - 1x 1GbE RTL8211F Ethernet
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> Link: https://patch.msgid.link/20260610100006.366963-3-amadeus@jmu.edu.cn
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>=20
> [ upstream commit: 5fd91b4f3ef20ecdc6db7a9e5c831209c7042c08 ]
>=20
> (cherry picked from commit 056a3d3a36a2f0bbcfc9019b57dbbbf9ee33929e)

Thanks for pulling this in the right way.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--V3Aar9BpLIMvrGdB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarqddgAKCRAr4qD1Cr/k
CjedAP9HPeuwvhKouwZFyD+g5aJlH2vOp1LddvhccDm55iqb+wEAxjeA0l7zkhLB
6vsbZ4IySCfmjl8Nh1SXcC6nls/y4Qc=
=zPlz
-----END PGP SIGNATURE-----

--V3Aar9BpLIMvrGdB--
