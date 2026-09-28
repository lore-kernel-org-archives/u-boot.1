Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057F1CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 21:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2C73606F4;
	Mon, 28 Sep 2026 21:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GxRJBxuaQW09; Mon, 28 Sep 2026 21:15:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F167B60638
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790630112;
	b=OaTQKqSrv6E4PtnUfix//lo0QOn+wa4oVHR4KUPmU55MZ7ZATTiWr4iXA9SHdNcg2JGB
	 6CrLNH5JhEf40io9cIuoYtKxFEncPFVyBRKwYsDgRah/MS0OfBje2BxJ1nw7IAUhnNfoq
	 9CSqfybqdQaQgbc4Vl2NLHxWbbck/i16PJSyxqk+ZgoRrvpSzhbLxUVoJLsVdmYGOBzLt
	 Cl2bGVEPuPPac418QMwBKju7opydHtZMIK2HE7PX2CmhOwItw7ItQRke4tx11L85PZBVa
	 IeJhIwwP9uMRBM0x9OZLKijLVM/zgpOB1Fu2fKhfJQk98LbAf/+re3+j0ef9ejTj7og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790630112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=D2/JPSfrsdM4i2olznc9cFo+J4DcKtgPY1SSQIvw2C0=;
	b=TvytsGuBBC2k6wNYJ4BYnQqBaDyLItGlZUVA0F1L/0zxnZhOD1uBVGwiMdyhh6buFHNA
	 8514I5YWNS//iJ/mba/GS5hnxrqkAQIReDzh/R/m1snSbrXhMcXQ1gUfKalZWYXTczrLH
	 M5Dv3LmVLi1gZCkJB9wl2w33UI5PBszOdlyAFpNsiugRy8bWv5TFshSvqGsT7va5G6raD
	 4jweImBza9QPdWKqigxi4vOIxqXSfSbVC0C3Qz77eRrTdt6LPFkOiKnEV5s96s09ZKZia
	 dWXN9F3XYxcoImnFgGBviZOHzgK+2ar+quuvKZ0FwU1XaPyDZWYg1W0kTcgV7BuQ25g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790630112;
	bh=D2/JPSfrsdM4i2olznc9cFo+J4DcKtgPY1SSQIvw2C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dwvYZXAecQQvkDAcqGCHuRO7MZf3j6jn+j2vAbmnTlbnz3/PGsioGIFeEwSgU9U2d
	 0XUwr3wD2XP3HfWqn8wc7HqxKAuu3TJHhTWWH/2xU4q/pSyIkoPREumHDf7FQs3dlv
	 HpvwqoEbmvC7LK98ti9EMnJNHcohLWNwHd5PRM5OYRjiIZXO8dJGpJMruzJ001INNJ
	 z5luS8EEmkU35IdWdpTLVKKnZQV2CJ1XAS6l0o5spg485aJXQMCR2WPsiBvM9jfdHl
	 yQZ7p3v+sFGh19zf+dpYmlCAKOGNhnNjVgNZvO/S9TjUQVb8hYKL57MUBnyJK8tQoZ
	 c2jrwESQjrJ8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F167B60638;
	Mon, 28 Sep 2026 21:15:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C20E72
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C90780AF3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:15:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O2BXRAP6q19W for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 21:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BADEC80A9F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790630110;
 b=jWvLGANZGHhHSIsZfIOVe2f5NvPFtjeRCtvvtJRXK6xpKEsuzrsSsmm5hHfHr6iaJQ0k
 foLRHQPLeDjcYVPDCUWkkfJKAlac9z9p6D9KVzQc+KvqIaJbguTx22L5kWCEBGq8cNaD9
 bX88UceuzBOc45Ty1OJdR5ORHkpZNilabrp0CvVrdswUmT1AbCgUdRon4Is6rimgfTpnM
 NojxP5ikNhV1RF+RC2UrWhR6Ufq/zu7ZC8QiZr/2vjNDEs7ZkvN9z82w3O4OL9dL97lKC
 9NSxJd9UP19+zaW4tlj6pbpDgkThDbK0KeRB0BKfd+9z1+TEEooKqKOsLUcntWZ7evA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790630110;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=D2/JPSfrsdM4i2olznc9cFo+J4DcKtgPY1SSQIvw2C0=;
 b=YMktkOE/fHWoCIdZxSXVjg+OaRyz8OV5aZKslES+p/EoUemXXd2uw9+le8e+jmJ4T1Uh
 0IWb51k4T5VOWlvCcRjnM0qgd3JyOXC+EwF1KcUOgpnbUo7peJU/a+DosngiGr3I4AbOx
 B5SBj6FbtUnaiRktXK2S7h40mH7jPNT7EAPgf+5PcZM7s/UpdZUshyX2wChFVbNM+Icbd
 8McWQhQV7yfyuHZLS5KIhE+cwifIQMaHFJmbpBuMyveRACsiqi8Okg0jHPLcwx4XYwMvH
 YqKQlrK5xlB/P558x0pifnc75LlQND7UUad+n4KEAkiqvAVZoKZ8CMJM18ho/zKXIeQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="l/Haj7IO"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l/Haj7IO
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BADEC80A9F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:15:08 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6d817a94799so782917eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790630107; x=1791234907;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D2/JPSfrsdM4i2olznc9cFo+J4DcKtgPY1SSQIvw2C0=;
 b=l/Haj7IOamliwfn8u+Jv3aCuOYbdcrOrTaovDkj2snBnA8eKSEXI301F/fMZLnbIbU
 ki1YUfuQLvIlCkoqEbZ+/4bxTaH4XzXwS1Sl6EMXoAn6OKC2NPJR2VjLK2uMNzvIRYA2
 z3dewUl1922E17YOABeQSLjZNvTUvGPe45y68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790630107; x=1791234907;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D2/JPSfrsdM4i2olznc9cFo+J4DcKtgPY1SSQIvw2C0=;
 b=IOjiomLR4PQPasEVjUj2qaajgBfglfc8HNtcbiBClu6HRrOnNPNoTHEfXeePhQDAZU
 2fTdtWe9Urf5g+hOkZlMxDcUVM/vKa/SYupTk2SzXi9TRJH+nCz9/94ZfI7klQIdB9Te
 qZ1BVWlZm9JXJ3inLveLrjtXLQ6Bv6fGUuQtIL3/yInuLAmXKBZnK823nd8PBcIlqYwW
 clFGES/v3W0QIETJT9w4HW4PB+gOVFfbkO2TiJ92R0LfPPFTwpzP7bFpHaglKk4MvEBD
 C3FE+kNdgA//FHEZVTrdb1Nf/4hKVd9jSKmhZZ1rvEaRDwj8aQrOFeKChTAhtXfFJ0+U
 UDNw==
X-Gm-Message-State: AFuF++k4k4JbyLU1Gu1fdIEOBZ+CuBzA73rcW+mr87JxmCLHeSGlHHEF
 TfwOxUXB0r4dmTMAB6BGTbOr9DMvhJRo6V7GYNZtr9fSw/IFXXDNlcErC91DBlBY5xc=
X-Gm-Gg: AYBFou0zIpGiMrYPRF89WCmLuBk4RyYM8VVnyuznOvp/kbjuOe7bOPrycZi0qEBmPu5
 +AWdMTWnL17PyFfht+HvpXcEQn94JIL5NYH0HhQkNq2DjyniHoJNLcEOihJHzneZI1x7ydrW2al
 0/cfT2x1kLo7K5jtBXOwxeVTALrc8vKNzLb1NZD1+OD7056mb+YpJ5Q5/z7VVlkOhOMXoh2ZgEo
 9bpmC3G3hBrus85hqoJg3IAzyWj3gV9fM4GsBAVJ2z77wFRgliMRJ4Ct6S99jcYWzMhLNSkhA6e
 W2XGuGGzDdLadL0EHjYUE2YN5Gm92O2TVomTW+cuRxqQaqHrGWYj+Dqymfv1k8iQ5MY/uKRAyOl
 xl4MqyeeUeECssDZJqpkxE14VE2ZpfSX/8UClVnMcESG9I0HDz2GeA3XHCSW+/hRvDy1WXeBA7E
 gWRk2uJoEhR8Al89Xa7KIJIxmL/24zNLqQAMtxWsopMFwLYMC6SM1sxs/OB5iSpfBSvPEtJwYvS
 SYZTBGKZyyskUezHFurSINdjWNEIsBAPWxi+nwK5P0GM3c3+YBiaR0+92317kYSp4NEtlqhikw3
 lJgk10oCqj35n9sQziw=
X-Received: by 2002:a05:6820:1798:b0:6d8:3caa:a468 with SMTP id
 006d021491bc7-6d83cd96f72mr4740973eaf.77.1790630107405; 
 Mon, 28 Sep 2026 14:15:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-493356565b6sm11261330fac.9.2026.09.28.14.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:15:06 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:15:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v4 00/10] board: lx2160a: runtime SD 1 lane configuration
 for LX2160A boards
Message-ID: <20260928211504.GR858934@bill-the-cat>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928191412.GN858934@bill-the-cat>
 <arrVGH72xh8-bFIh@L30177.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QjqQ6Wimis0w1TqN"
Content-Disposition: inline
In-Reply-To: <arrVGH72xh8-bFIh@L30177.local>
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


--QjqQ6Wimis0w1TqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:59:04PM +0200, Vincent Jardin wrote:
> Hi Tom,
>=20
> On Mon, Sep 28, 2026 at 01:14:12PM -0600, Tom Rini wrote:
> > On Mon, Sep 28, 2026 at 12:13:19PM +0200, Vincent Jardin wrote:
> > >  .../cpu/armv8/fsl-layerscape/doc/README.soc   |   7 +
> > >  board/nxp/lx2160a/eth_lx2160aqds.c            |   4 +-
> > >  board/nxp/lx2160a/nbxv3/eth_nbxv3.c           |   3 +
> > >  board/nxp/lx2160a/serdes_split.c              | 588 ++++++++++++++--=
--
> > >  board/nxp/lx2160a/serdes_split.h              |  16 +-
> > >  doc/README.fsl-hwconfig                       |  61 ++
> > >  6 files changed, 556 insertions(+), 123 deletions(-)
> >=20
> > Those two doc files, has anyone asked you to please convert them to rST
> > and then update them? And, I don't hate the idea of doing that as a
> > follow-up, but since we have people touching the files that understand
> > the content, this is the time to convert. Thanks!
>=20
> ok, I'll do it, but after this serie ? I'll emit a set to convert
> those from legacy to RST.

Sounds good, thanks!

--=20
Tom

--QjqQ6Wimis0w1TqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrY1AAKCRAr4qD1Cr/k
CqOZAQDEa599C0Flum/+YHBf5XSRHNh4v0HzqDXmfY6pzfF6SAEAhgQC0zpM+qPo
+1eOML6J7p0LNFmjszQ6pSBDckXFNAk=
=Bj7G
-----END PGP SIGNATURE-----

--QjqQ6Wimis0w1TqN--
