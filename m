Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E08C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 16:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2514340816;
	Wed,  2 Sep 2026 16:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9SgrhCpZ4Zf; Wed,  2 Sep 2026 16:45:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788367553;
	bh=1319s+3Stu8JBBFvysMTwn0RMcoQHced4XQuaN4r9wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CYdlfobXJMsYJje/wIMWMmPwi3WW077sfeDPJwY8ouydPPGN8Ecd/z5uYBi9cqEeQ
	 DAY6DXlRBUrve/YEMWep/owaPha9kkB6DTgKia0TfF2jEvU53UV1ks6/jqEAyUzCs1
	 xuerZc5YDBBZPECbJ5Zmb5btW4XRKEN2PA4Ycp9o36oLJfjFmuB2VDv2KlyH0CpPzg
	 YZSkO+cRsA/5BL/+v5uc5VqXPkqk7P8Sbvh5bB5nvwQ0rljDLJIGthsYvM3bqDF4nG
	 2Kv8buZMVhclNNAf51rGtWQ65vlKFfZtdXrAELypcKbOTJLZNxtyVEaQrKODXJplEa
	 aM2QmAWIVtnWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A0B440815;
	Wed,  2 Sep 2026 16:45:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 838AE498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68F4080F06
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:45:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LhP6E8ujOpeV for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 16:45:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gvqWCv4C
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9FEF80D81
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:45:50 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7f69672e369so889681a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788367549; x=1788972349;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1319s+3Stu8JBBFvysMTwn0RMcoQHced4XQuaN4r9wc=;
 b=gvqWCv4CM/AA9cyr0HDlzuxRwE/QtkmY3U/ihqMXBVpCOrONyKEyz3FiTCVlw/RuLi
 ZarC8mRjRrFPfW3nazx4cclR61+xJdilIasGP9f3MTXThBSMCgzh6LAJ53GvJIt8WAD1
 76uE0aQIFS6yyFEwZfwaIi6vaZg/bhdeMvPmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788367549; x=1788972349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1319s+3Stu8JBBFvysMTwn0RMcoQHced4XQuaN4r9wc=;
 b=f6xIMYkXY+hVcicNtvB+gnjFr0KIyyovFVA05QtOYwJrIlMTnfWw4oRJCcXMtx7qmB
 HKH6pBnLpFSvR9ZBjpUMh9/jacMG3rK8mI14oEvNwwPszazVByUBPXKapg+gPa7Vb3XA
 kft4V7f+oprRMyM/tCzdIrHx05H5BrI3q/7Qln2z5NC8CuCUMpMGNyHT/7gEkX07Eq+J
 h+Z5IhKILNJ3/PKQFUEIKekUFIO/3bzs8uss8oGCbtJEQJp93IjAY99tiZc16e4/4VSo
 JHWmkUxRLoRJWcv/42MAwC/CbAz2BTqk93DOrA72MMJpD5ytYrOa8Xk1KeIjyAhUSt5I
 nYXg==
X-Gm-Message-State: AFuF++m6N19O/tyLe0E8yXyEKy9J2OuswwDQjeAPNvl3ksWyoXLGcXj2
 f42ReD3x3wqqTI2q0cCCvSirmC1aMxdnqE72ehqItTNyEECd8p2Yi3rBcbyi6n4pbgSJWHjf2Zt
 ZPtVtLGyu3718
X-Gm-Gg: AR+sD11GHO9oZFBrCXeNYr86KtqmvMJ6j2CSX7CqGwCDgKUVlgGYDxEcHRwJSsnwwlh
 sZ1n92Z4PlfGPabRB6ZWbzRkQEhWTeD3tq2dHLFrAb2QQU1oy5TzC3pCY/o1K09z32brI14sZfF
 /NkGCvl9WnGWlKXtaHUeqQlRNxPQU+/FaVfDftGmPitR5Shz4Fbx+R4GuZnZ+5E4IzWK5LTd1Ip
 kZx60mnOIDCQPyQuwGPWAi8BYx8F6eSmEpjGdUti9uiR7G9aqz4LqugvbjgB5CyMzfrrnCs+JjH
 vfPBDFVLDBeaJV8sA9VKoUHU3RD+RJMKSWaJ922MF9xsAHwyHLwKujnc8DXN6kbJhscMCqJqG6n
 lHsGP5Ld9M7E3gg9KTQJy5+8AmX6KSV7Tbl2fyop2ZdMc2EMj9YEyONQ+bsuBRCqN5WL8mpSJ/G
 oVLstp5QVyRI/Pj8pnox2K9PeDlWPC1idFaPIyAredEwavouD8T5r2Kf4RZ5ZFa/jBCZ3qUOjU3
 I9W4bb6SsJh5gq9O5FTX6fPSu3JSeVidOCkX63hJ7/jwDpCij05VhLhL/e/0RkRGientnv1f4kz
 Of3aKKxlNA==
X-Received: by 2002:a05:6820:61a:b0:6b1:6462:7e4a with SMTP id
 006d021491bc7-6b47f51cbd5mr4788147eaf.13.1788367549335; 
 Wed, 02 Sep 2026 09:45:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b40f92004fsm2963397eaf.15.2026.09.02.09.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 09:45:48 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:45:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] u-boot-config/domain-map: Add Qualcomm domains
Message-ID: <20260902164546.GE1764417@bill-the-cat>
References: <20260902164006.1719873-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l8ZKdT6YcGl/y/az"
Content-Disposition: inline
In-Reply-To: <20260902164006.1719873-1-balaji.selvanathan@oss.qualcomm.com>
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


--l8ZKdT6YcGl/y/az
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 10:10:06PM +0530, Balaji Selvanathan wrote:

> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  u-boot-config/domain-map | 3 +++
>  1 file changed, 3 insertions(+)

Thanks for the patch. Do you need me to re-generate any of the old
statistics pages with this, or just use it moving forward?

--=20
Tom

--l8ZKdT6YcGl/y/az
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaphStwAKCRAr4qD1Cr/k
CuUxAQDiSRWXUPyLS50Efr7+Mr57gf0huMt8aQIVCglKZSQpEgD/Qfb/T42ph9Bw
LrxRpjyxf1N1ye9LEFFnWr2zpEvTkgA=
=4QXk
-----END PGP SIGNATURE-----

--l8ZKdT6YcGl/y/az--
