Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F62606A33E
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rKdixkZu;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cw9feOiA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84CB0605ED;
	Mon,  9 Nov 2026 18:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SAWXtNlupv0; Mon,  9 Nov 2026 18:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DDAAB60668
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794249052;
	b=AnrBGcBEqBJ3MLZJFojZsnjiYNcQpoW1KoA3GCzka7u5oXzEnZrHlf+XIQ7+blhcJ+te
	 SLGqGSoVLDJodAPTvUL+c/mzycEOTVbC11KWM1TkA1UfdTmxUMeqtRIV0PvIL80PwAJOc
	 7y5ebrEBKDIbX506grifVgEoW5H7Z7leHLRXUfTgVVLa3Tf8jM+252cEmnyCk8JIWJ4E5
	 ocNmaMzOUhx1zCDm2ZqWNrWogkEKXGLAHBfJJSKxd1XTwXZy9JRmjJx7M5rJ718lCJwGL
	 eUCgjp+qWUpPNZ8kf3oW1oZlTeTumR/FvzzEWptOR4M280AbGsfZuq6k8er2PNyj5HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794249052;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=R8qUNg6uTeG3bqITgFUs9zd+QQ16VA85YmCV7Ls2dV0=;
	b=o/0SppzjLyswam6jP+jFlFy58MCj6CkrlJPO8Gf+Fvt6hf86TcjELcL6SyNlcE2NvXFE
	 F6Q/0pFPZsFLtiRD2aAwxNI+QSSLM1q78CVnmv00SHrkmf0VtclLjmRxgiisdhnC90b4N
	 Pv8PhSCBxWS6VRd2ekOUBzoYXQ075dyJDekydvJtYOP1JyFNkZNUgH24/m3HeOtgsiMEm
	 LsPUDXWhsu4/Dw78WHGxNTfOpMIrvwGh+ggPJdFLB9E9+yvterd6c85x58Oc3tA6la2OJ
	 6H5RX7DjeqZdeKh9MzJIN7Zyz9srpSGUWfjLdDRfCjVElu3ABjxy0gOWfmaDlm6bEXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794249052;
	bh=R8qUNg6uTeG3bqITgFUs9zd+QQ16VA85YmCV7Ls2dV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKdixkZuLFEj4p+xeMDKXZZhujzfoOaCvG9Q7zcDrWv00XctEWKj59tTB6m2zJ05I
	 bXiPg4g6P3GaHvaTrN4mwIkKqCCzuV0MvtNTavnFsPjddzsKrSv4hImyoyue9B3/xV
	 w+CgjQOMUC4EgbmSKGEwAxp4EHlHDwMU9K8etiSuTpCM+q3Y/5Rq0f/kUkHIy2GTnb
	 ML4jQEbip8qY+a45JpfKIpW6hg6CQB75otn633vlKjRNviquNWlX19gm9xws02slmk
	 aCDMSdP1b2H/cQT612WHePJYPqmST8AV1Ay4p7Kz9PP53vKaF+2YLNRw8sZ08fsKN2
	 WFJsYeZeLGg1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDAAB60668;
	Mon,  9 Nov 2026 18:30:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E1C14BF
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C74FB80D32
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:30:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8joQej4285oy for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 18:30:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2495F80F3C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cw9feOiA
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2495F80F3C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 18:30:49 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4ad881b6517so766909fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 10:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794249049; x=1794853849;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R8qUNg6uTeG3bqITgFUs9zd+QQ16VA85YmCV7Ls2dV0=;
 b=cw9feOiACvfj/ekroeCM4PiVkqYVpu/EF5FuyJCFo3HCIXYyJ6A38Nkfnizbt//PUa
 fqmZPUVp1Quddsp3IyG/EGu2nDibNiIbUvm5cJm0+iekzhpWWYJRaC/xcqzH1rQnSVRu
 xlXsZn2fI/0YZc0y46BiZLbnAvLb9Ud/ZK4ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794249049; x=1794853849;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R8qUNg6uTeG3bqITgFUs9zd+QQ16VA85YmCV7Ls2dV0=;
 b=S0rv1kn/pFrwPbbA7xK0fy7SqSJnR8GqxcQslUSdcCYLugvSrz5uHOW9Pl32Y6fO/1
 7PCsUqN07Veperoz1XahZ/lQkDnBca8wjDzE3rwmvexNLNqVgl/cpuoxM6bmwnWeg4uF
 9DIhsgt/iibb+KO87KEI6HAdN4js1WqVq1ePdde5CAV7kFqaPuPRGd9lSQRVILVOWnWB
 czKcRiDaXHDJWlfKERcUsrGD/scYJk+bhSypMaDFAYyNpISMOdR1r15xlb6oOZYmKJ5Z
 yeQFPPnv9iWgiIuxkvsFR53vQIhMaQcNKvdj/sG3+/4Ei+ps6psMI5ffhjiAmMx1zEjX
 IDWA==
X-Gm-Message-State: APuU4Z8yce0crDCBH3JeYog8pzbM35GmtUuWxEnuf4+s90KOAGvyqokU
 n8xD+1GlJ/C2RGw2OGV+4fSnaY8eK5w+8VNI4g0XTJwPj+b7dQx/o3Q2E8cI8xuUYHY=
X-Gm-Gg: AYBFou2/ORGzXpHev+7pstRsWR320JTyAPGngmp3uf6oZTz23DbT7Xt35OjENqxaQBB
 aD7Mkn2M7zwoZ0zqRsZNtn7kIX8jih56eZalz3Whs7sns/qp1MMvwSQvPoUss3dy8sYI9Bq4l+Q
 stxVq+11F3uP1IKwaX9QwTA44DFhZSDFtosNeTH1EbTl8tl8lOcekrr1mQgKjUR7IwBN3CrNP2y
 flrSR84v5Ts3k//d2OeLdyxUgaU0qMxg2AQaEvEcG46mieuu2Q4HmbD+LZhIxbsDWgbC1U2AuJ4
 v1csDQi+BDnKaRzhOWdVduWmu+0DmcDZlcpCWJOLDfNpC5xSJ0WPLYlv6HGv1BvY2nlDikU1k95
 O/XJeXlpX6H7/oSjGLg+xW4iEWgH21sbzElV5tTyiv5EkBIZzRyrJ+0jcWhKJTLbSIodRHi0VXi
 VTkCAUUV2N3RPXdBslGvZP0v2RZHxIqjHQwgBUesZ9VOtXuk47W/gnwpoIKvbtJXeUhPXQXHAfO
 RKJvgSmT4G/5rmmkBWfN1nASq+eGo1vpUVv083EGv08m84xNyZRUbP2G765IS+rhP05J/ZGZuzW
 Bf0sS9+Cx7cQTmwlHyFwecO92xnv+RHnzfu8cQJZIaM58jAR/6852i+D2BBD62sMNlKCUa+jHqN
 3p6R3F79llUJOEOsIASJjfrHUnQz+4MGT2rHWYNFj42bK7djJC+WQRYC7S/ov8R04P/ddCoP1pE
 y5r1auJFBqD92twtKCd+W3io7Ub0q6yZ7EK5yiCPnUKEopUd7YILc=
X-Received: by 2002:a05:6808:bc1:b0:53c:af69:84dd with SMTP id
 5614622812f47-5683cbf2ce6mr411168b6e.12.1794249048910; 
 Mon, 09 Nov 2026 10:30:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-568138f81b7sm5111379b6e.0.2026.11.09.10.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:30:48 -0800 (PST)
Date: Mon, 9 Nov 2026 12:30:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Subject: Re: Please pull u-boot-x86
Message-ID: <20261109183046.GU3741582@bill-the-cat>
References: <CAEUhbmUriwAm2_WHVDEB6mfwH57hzFYbPd-4M6nyUGFqPEHcPg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4YQa+PD4o1TMt5+j"
Content-Disposition: inline
In-Reply-To: <CAEUhbmUriwAm2_WHVDEB6mfwH57hzFYbPd-4M6nyUGFqPEHcPg@mail.gmail.com>
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


--4YQa+PD4o1TMt5+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 08, 2026 at 11:53:48PM +0800, Bin Meng wrote:

> Hi Tom,
>=20
> Changes for this release:
> - Read correct TSC frequency using the right cpuid leaf
> - A small cpudid implementation refactor
> - Display actual CPU vendor and device id when booting from coreboot
>=20

Applied to u-boot/main, thanks!

--=20
Tom

--4YQa+PD4o1TMt5+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavIRVQAKCRAr4qD1Cr/k
CiFKAPoDcuvYwGkLWLmdgX9a/tSLYli/rguWGudjRzjg74PE+wEAyIJ3gypZ2lGO
UQJfjEO2aTOmQMcG4cdJzhkxMMhzqgA=
=2lOz
-----END PGP SIGNATURE-----

--4YQa+PD4o1TMt5+j--
