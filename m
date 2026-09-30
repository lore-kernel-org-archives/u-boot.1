Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97856CA5FAD
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 00:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D84840791;
	Wed, 30 Sep 2026 00:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QbtKw1SqhGhS; Wed, 30 Sep 2026 00:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73A1B407FD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790727526;
	b=M6fXSfpMpigoFVuZN96zFcGh0ZVwLrFuzhaR7ecX4Jagum7SSrigw4qJJXRm3mdbjXih
	 grwtOLc5a/WQ8Aa0ruSstBSd3o4ZojdAEUNty3bO+cAJW8GSeQlr9Ee6oWPovZ8OsR3WL
	 6JQWLFmnN3oKwjVpXzxudVerumlVtWBtwBhseFf3D8tgZxA6n/b1C+3PJELWplFkBnet2
	 9UUIAi+Nm9AyGJRhV0Hg9N91wq5KqboT6BylmnN5QgjQ+m5PFVvAp9Q8blOZomHMpBcmn
	 EB4vIkLEB8xeOivy99Pac7jAijUxA51XcRu06blqtGC6adR9s5FOY5xBM+LMNkAHCuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790727526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=i/1Yc5yo+rPRWOMtgk/fjWvl3GCE0iFJljOW3rG425A=;
	b=MWfUHi9CpGq6spWXjrzJ04tc/wp9ugvB6JCFPIs9JFqrwNnr/HnoypaDPtTkTbbGD4gA
	 2vPv3zYpbpIPGFoNzkBfYJLzlyetFS1C5CdZ86kuuP8fXZ6RSOp/qDTzS4yei8SlE940C
	 SL2seRyZmYYwk20nWLKe+yihakbTiioAc41I0fePHVMVpK09eRbHONdu0EKjzryXQdT2Q
	 Ch9e5FO7/23YpRs9Evy6UdYcuAoKzbxLomtMcD08fMtLPwl8euLkjRQ4KBnoLW/X8azpq
	 oWwHPHTrLqpER9BGk+SJETuRPc4vxZLG1Ezmw6bj54wlDhMNOv+f23eQueddnoMhCqw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cID5YPdO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790727526;
	bh=i/1Yc5yo+rPRWOMtgk/fjWvl3GCE0iFJljOW3rG425A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E/iR16tf0m1vCMTfxM5HY4ivvTgNBxmG894nwg54/GHEYIplbzTObtVdXfIZ0fMhu
	 YujkFLH0pxT+7VucMMw2BVsxed9vna3SeJzxdyqXVZ3/3HfFHhnt4rBupWZDclTu6A
	 hHfAthc3ZZtToea/Fd66LfXlDpm2iqYfa+K/3b3GS91+CmxaIG8lvuHX/KG7UCTOkc
	 lFTGGk/9JsPOAfG0EWAwta0W1EIIzbHx8ZKVaW6UQorkh4/3lHb02qLIBalumUdCJN
	 3JpccuZcryGcM4WXwBOJ8vSZ1tMQ96Ta+adu4THX6fJW4A09mQaF+4hvTc7VEClept
	 hDzj0fSCdKQHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73A1B407FD;
	Wed, 30 Sep 2026 00:18:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C16BF282
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 00:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2D3D407FD
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 00:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EV-9sV1LJI_U for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 00:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D954040791
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790727525;
 b=D2dlwdtxTh70uPyRwBgNKyYoHfYnvgZZLdwVaQuHZXn9YQTisF97wcEfwIaIiAl3R/eI
 2j2Slyv68IVF4IlcHgRQ+qRncLo7me7zOhbDek5nJ8qshL76mH+fpM87Js2kaIU8ckamX
 gGLBu0ARM1vC7wO/0Ehjjl9K9pEJU3rrrxbWddnOhOy5vUgM6vqjQzL+LLsDXUEENxnxd
 vbBMnwTj2IcwmJ6DNQFwlv5TOA4Lxu2fLZ/dRAphwIf/wuj2USy0sBFdHvA2ouf6sti+m
 GohKjI22EKxJzymtiWabeaz29FK8E2Nu6QYuqEkyVjujaQkNkKggQ5Vp3ZXx0/SmGhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790727525;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=i/1Yc5yo+rPRWOMtgk/fjWvl3GCE0iFJljOW3rG425A=;
 b=OieMgctazsIT/1AwBe61IF0XOSngGqEXKb54ryBfJgb+h2//zutmYBOidyZWoZsjg3nf
 eTYPjJi9e0/o780AMAd0j4uWjvy0rRU16g1U7rdoamc4nNYC5JgSD46I6kIUiiaX3Pe2E
 VGa7prtZ1giwg/LTy8GY3qTNs+sfCq+KMOeC3Cxi0C6aUvmgjg/ij4SDAvWsS4dyDVwbo
 Q9xZH3RFOIoRs9hbGScVF51EoSj8QxBMmCO5O2YVYQ59TpntwKiwr+9VTud7/mQIvfgDO
 +kE3r2TNNHeoXmv98fnKcwJZ+gd+g7O8fwRHxi8Wga1JROlZLwbKEzKKGRlJpCaPHKw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cID5YPdO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cID5YPdO
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D954040791
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 00:18:44 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-81be5042c56so2363067a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790727523; x=1791332323;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i/1Yc5yo+rPRWOMtgk/fjWvl3GCE0iFJljOW3rG425A=;
 b=cID5YPdOiDcM3BJUruJGGahFq1FUPuKpeItuSXt2gtYGXFzlaIk2Mtiqe/2Ayjqire
 SmWtfHoLj/wMCgdp4i/ARuuRW0IfpDbinedxuPdNkRxQMMSuBJbBqjfIiJhsE/fUbvSM
 5E8dhhHu2LSKRIFdWbvelpi8vh/P6cY0noOM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790727523; x=1791332323;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/1Yc5yo+rPRWOMtgk/fjWvl3GCE0iFJljOW3rG425A=;
 b=OSTaequV9Kp5ICSRxG4jFSmzXKIC2zt5cqSPmdn6ahaTQzi3VJt1mbkZoe8kx3Yrdh
 j8Ab+vyiYnTSLS6fG+PvjPEIpBBStjptivtkvQYdi4q98e6lv4rTJ7kzPDVz+2jac/NS
 3BIiZBdCgXx8EvumHChJUAlaAuWeN3iOiHH2cpbo0g+g95s6VhxZmj/HeGerRWDjNCoy
 4OPQRkMjlZvpbHObwb17bl5R+LEyTbGlWd2Fbpll8aMsj+P9ry59VIZJk6oY2veL2lbd
 BujjGEH6wDCTXKDB5z9754wh20ntLAlV6Mv81Gzqeg1PkpGdSL5IgngcmVMbGi2sSxKO
 SxIg==
X-Gm-Message-State: AFuF++nQMG8Y5joYSthu4eBXlPDx5lIxsg0hLh27pzO4BZpqVyxx6fSC
 QhtVweFySl8Yq+OdxRfMZJBsnZld+AXVTOnQpRV3Y71RBfkxtXvuxSrSDR7czbW1i6g=
X-Gm-Gg: AYBFou0j5XeFDA8jJNlwtOEYa5ZFCggdPLSmRF2DFPBdHrz93MypDn+2wrJOvApfkb4
 eIjoKo6eJNpV5HctZZJZiw1psl8mzo+KFoQezOQg2c6OvXXzH6v79oHzmF4ZdErJ+xzX0Q254K4
 nSIAlnMJ/2/Eza73YgO8XRifO7XXW7qVhVCwNy4TKxdryqGB7asolJIJY982+/KO1AL+pPM7JhM
 uFqxETHS6QhnoHoqcAzz0yif5rsZxy0eRxmhSQeUPENlRJkT2ZSvtYOAF7AAtGTTl2DZ5f794ke
 8qR1QkuxtFEaBnzXGPsnH1O07ePHSrMcIux+CxxWaiifWUFaloC9sE7xW6mai8u/AE7UlbABYcW
 E8tkc4+p6nMfFNLE1iZAsVviC+NEedUbPJPaq2FfUCiyi1+WroSSf7WtimJGUtHJqtT9rQDVH1a
 +e6e/AcRo5vx0j218IClS2nTmUOtQFnrtqaLKcGE50twkG09ojf1qeC59SV0Wqfvd+5d7WyTclN
 smgvHG6xcLzqqnMFOTcor9s04ljju3+MjdleSkq+pygfQnjoA1UmqqrSh57MMeS2du3a3d0usni
 bODH/zcwSaRZiNWaSAg=
X-Received: by 2002:a05:6830:9c1:b0:816:b03e:f9dc with SMTP id
 46e09a7af769-81fd5485872mr958428a34.5.1790727523257; 
 Tue, 29 Sep 2026 17:18:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81fafdde8f1sm1390691a34.26.2026.09.29.17.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 17:18:42 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:18:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] cmd: config: Add additional embedded text option
Message-ID: <20260930001840.GE858934@bill-the-cat>
References: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
 <20260929225108.GD858934@bill-the-cat>
 <71a56a26-67a6-43eb-a90c-71231ec2cc0a@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="auOBRUw0I0oKdM3D"
Content-Disposition: inline
In-Reply-To: <71a56a26-67a6-43eb-a90c-71231ec2cc0a@mailbox.org>
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


--auOBRUw0I0oKdM3D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 01:26:46AM +0200, Marek Vasut wrote:
> On 9/30/26 12:51 AM, Tom Rini wrote:
> > On Tue, Sep 29, 2026 at 07:31:59PM +0200, Marek Vasut wrote:
> >=20
> > > Add empty string Kconfig option, which depends on CMD_CONFIG and lets
> > > user embed a short piece of text into the U-Boot config, which is then
> > > printed by the "config" command as part of the embedded .config.
> > >=20
> > > This can be used for example to embed OE /etc/os-release into the U-B=
oot
> > > binary, which can then be used to identify the exact OE build from wh=
ich
> > > the U-Boot build was built from:
> > >=20
> > > Insert content of buildinfo:
> > > "
> > > $ sed 's@$@\\n@' /etc/buildinfo | tr -d "\n" | \
> > >    sed 's@.*@CONFIG_CMD_CONFIG_EXTRA_TEXT=3D"&"\n@' >> .config
> > > "
> > >=20
> > > Print the configuration option:
> > > "
> > > =3D> config CONFIG_CMD_CONFIG_EXTRA_TEXT=3D
> > > "
> > >=20
> > > The output is a one-liner print of the embedded string, it is possible
> > > to interpret the result and the embedded control characters using e.g.
> > > echo:
> > >=20
> > > "
> > > $ echo -e "-----------------------\nBuild Configuration:  |\n...\n"
> > > -----------------------
> > > Build Configuration:  |
> > > ...
> > > "
> > >=20
> > > Please note that this does increase the U-Boot binary size, and
> > > therefore use with caution.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.u-boot-project.org
> > > ---
> > >   cmd/Kconfig | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > index ff90a87024c..0d8b152f12c 100644
> > > --- a/cmd/Kconfig
> > > +++ b/cmd/Kconfig
> > > @@ -170,6 +170,17 @@ config CMD_CONFIG
> > >   	  command.  This provides information of which options are enabled=
 on
> > >   	  the running U-Boot.
> > > +config CMD_CONFIG_EXTRA_TEXT
> > > +	string "Additional text embedded in .config variable"
> > > +	depends on CMD_CONFIG
> > > +	default ""
> > > +	help
> > > +	  This option can include additional text embedded in U-Boot .confi=
g,
> > > +	  which is printed as part of the .config by the "config" command.
> > > +	  This is useful for example for embedding build information into
> > > +	  the U-Boot binary, e.g. content of OE /etc/buildinfo, but please
> > > +	  do keep in mind that this does also increase the U-Boot binary si=
ze.
> > > +
> > >   config CMD_CONSOLE
> > >   	bool "coninfo"
> > >   	default y
> >=20
> > Is this just intended as a do-not-apply?
>=20
> No, but if there is a better way to bake /etc/buildinfo into U-Boot binary
> and then print it, I am open to suggestions. I am looking for some way to
> finally replace .scmversion with something more flexible.
>=20
> > Otherwise, it needs a gating
> > option as well.
> What kind of gating option ? This is gated by CMD_CONFIG already.

Yes, and there's platforms enabling it today. So yes I'd prefer an
option asking if you want to add this string which depends on CMD_CONFIG
and then this option depends on that new one.

--=20
Tom

--auOBRUw0I0oKdM3D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarxVXAAKCRAr4qD1Cr/k
CjfMAQCfpojjREvpNaQLn+IiTeip7m5Xt/Rw+E5WrQ7MtFTIcwD7BTOJVrs1fOgs
N9c5ZVcMzGG8HXZRejV3fF1RQB85XAo=
=TCKa
-----END PGP SIGNATURE-----

--auOBRUw0I0oKdM3D--
