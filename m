Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFFA606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=twmiNyGP;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UlEZlHp3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD65F81E86;
	Wed, 21 Oct 2026 20:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGSUqcIBSlOz; Wed, 21 Oct 2026 20:57:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00FD581E79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792616247;
	b=eEarzUgvKHOw7lxmv2ryo3ATIA28cm7waWMZkvYFJSwFOlJjXHp9FtCc//9rUtwGWbf7
	 xxKpSdcY8jct0AYPwakMFMsLivbSGaE1B303tA0/iWwXp3iE/54truNVQD78/OivkJZLT
	 oR6twBe1gmwoEEamPsU89dpvYD2mNBq5PveUAp9Nru5NH62Hmv2YO9M9pK0HzXcBWB3eU
	 cK9LsBQVVQNZGZ/j5ezOuVZQSHuXi4RKPFd/WJp5eEnq1a+A8khk8pa3V3Xn6BlLhKuT8
	 yqrF5yU/lgeltlPg9W9J8gyF8QO0v4McJr0hhD5gHmKx7cn5qiY9e9tvhgt7HwZyR1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792616247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eyo6g2ZaIDqdU33w9VO/vudhebyRznwda6u0Q9xdE5I=;
	b=B3ToQmvo+IDItLjA9ftetpZLTz+YYn5qRK5kOfvjLG4etFjmLywSmkpgFiGlHgUnrH/e
	 wzGYe7RbxktRhfh0d7v/iyQOvALfB1mhfYqdbD1nqdaPoPBhpfy1e5u/qLg1zaChfZA5R
	 ryf642pL4c70TDv6YS4XVWxU2o5CW/FCTJ+j45MpdGVIhqml3TACtsSUCzt3r3VsJY4Yn
	 LqS8GR6+QgiHXuNdLI0sh0M9Cus+HhT1Bhbu7cbvGy+O8j4GsIGxNd6XzBlRnEhjbCDqZ
	 tibAsj7uEgEc6hTubmsPm7uk8hgQdfh8GUbJtn75F7/DTDL6N8kX5QPEq2wUshybTrw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UlEZlHp3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792616247;
	bh=eyo6g2ZaIDqdU33w9VO/vudhebyRznwda6u0Q9xdE5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=twmiNyGPzEtUR2h5cU4NtRK9jXAeNDoOzc/hiAT3xTHXPycdYrUIE1aG0Di4fJ8sE
	 zSnbpuFKuaJq0lpnV0K6cNQhT2w2nJUxdpvSrOptZ4Mn0D1C1n7kDSb9u2r6Sg8HI8
	 r4XamUiXbsvwTpWH3a3caHbEcv5L+VPEiYlcLEeiYZnoCAFD302Z6oTssctOtVsIS0
	 /Slb7xYuFGRv61+WGcO/o1YKT0I7SPdcG1x7/TbZIz7VjGoWtzw+89OVPGiKaq062N
	 jmCiZZJimpHE9fiLK/mhUq79zh3W/gX3tD4jkXu/HtpEj2F8fHKuOJ8EVWaUVOqZPm
	 JOGZR3lm0r+hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00FD581E79;
	Wed, 21 Oct 2026 20:57:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B5EB769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 20:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CAE981E79
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 20:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 90T8Twak9gjx for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 20:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4F0F481E74
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792616245;
 b=cIUysCInzfckO3rDosqJ26hgpFIQMNh9gIAfg/ygAk7VBIGsUgE8syPUMMBWeqp3pF5/
 Yesr0at2dqYFGRDI7ABlb6BU/k8dFyxPyOLMCnhXphTD1Q9wmolIk3R6RXkMxyEWodkrc
 R/xOSAVO7c72FxwF97sL0zpdxztz+eLtM5PBvMDTidT8E83TLzy0fqTzOXdYpPWFuVMGD
 iZqnFz2WIevYqOBIDpUWbEaA0KDCGWY8uxfHxETkm1ascQ+Z9g5bhl1wRE8ZjEBOu5z6C
 IkgvHeYkk9f7tFHU0xSa7nf7McsXgUDvJzYLY0WJNfBl9zzzxy6BVcnrNHINA22pRDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792616245;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=eyo6g2ZaIDqdU33w9VO/vudhebyRznwda6u0Q9xdE5I=;
 b=SJ6E22+ja+Gp3UVnq0GiMNCYyztEuaZ2smLhYbcTZwAdFGoL0m0hCO1zoIcK476kssEa
 BrDz779B8F9IDQ/aua+ecjcHf/2MdT0NQYtC0TZnt8ljtgCewuHJOJHRLEX+YxCwx52rL
 5DWKQ8wruqqVchqcNxx2RmU2FJjy+DGaGKGg0ZhLBZDUYassq9yWi9XfFsZpBkAY5t8rb
 NrBONGbM2763PGjtkO21mZkrh7aRkHgaTOn691TPb9hHpaUnvsye5/0aeayBj2mvx1nkD
 TAPrND6b5EaYCBdz9T9PibeCBDIHEWw0sC6t9/mWO0AcbOxMIC7nUeaWuBatHPjFa7g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UlEZlHp3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UlEZlHp3
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F0F481E74
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 20:57:24 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-82109f51565so528918a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792616244; x=1793221044;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eyo6g2ZaIDqdU33w9VO/vudhebyRznwda6u0Q9xdE5I=;
 b=UlEZlHp3Ppd0T1B1vbyhwVQje0H4o7Sv8Bwe+z7UDfy3ZzPOzS5zUOFXQ+FsVbNQxw
 WKp/WUYWDIo9RB5+oAt4ZwK0Q5F3Fc6vS+vqbWrL70vB0upNl0CbK0ZCH4rlvTLJFF4h
 R7A3wKT+3zvUsl3HQkhjuIoMQOIOs3hGPyCx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792616244; x=1793221044;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eyo6g2ZaIDqdU33w9VO/vudhebyRznwda6u0Q9xdE5I=;
 b=j++NqpCSh0On9adXzeJF/Zt+cWzZbjgkWdFj/M0u5JqmKYVo1iHeSgyVICvBG/7Ycj
 2e8LFtNFZXgoyAwGD1rPs+ADNL4bbRh4D5OwHOsfQRT7SCvImti3zJV24j+YfR8Jyq21
 a6GwggGLRMBKY7znTWLswnVSDe3HQajKlJbqlButXWjES2rNPfUv93Gt13xl+RbZGrPq
 cgsOfWL8qLW1Ijs3Xc2rCN4ExTaJccLEvH/flAr59R3avgD4QIvEA9a3ILNpV7KPe/ui
 Ve7fnEXm4GP42++FWDtT5/Hd5ex+EXS10uZ5GF72n5+Q9pWHMNzdEBnwp6Wg22HroUu8
 Vj9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6oYCGMFjLxYk8geTEDNxzYpz5D3ktAWX92ZUXeNr9ZgQ+WiSRFZDm90FtbwZUwSw3mc/09Oc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIkl0MZU7cTwiarGMyT7/fZNGEHf1m8Xkj0VEO3X6ZeI7r6suL1
 6oAdAVhMVYps1gEh98mdPoaaTNdUtHl0Yhl2mFeykgoAa6IwDH4TxfyPMxfP+o8b7zs=
X-Gm-Gg: AYBFou3+u5GIXFkJH662llRKDoIB6X2hzWWiZE3cSlOg7s1iuVPFX54oxZPKOj8CtcX
 +LiUppQg4Gql2rtp3vu1TC1a8TzpTvQoMZsyxJ6JvJKVF0RgbIpq1S2DVjiOivr0q6VggDbr09Z
 Ni9qnFJIruCI6YKHhAuhTqeKbFqTA16i0MbLP7s5pcqmU2aKM1O8bUnJcSOqE/HKJ8YVWYWoLvO
 NPPlxY1GYPPo+CZ07SpIiHp26wzlL5GjUCiDnLqKzD8uT8jJQ1dxKQEx0ynN9jEIg/vIOyLaomg
 IRiA/CcpJyexyuTpMmh9gyDthXvAD8np676w/czdRoweP+emICXSAGwPlbjTrnhiu+aKBMwNDWK
 Hwc3QzOF+LyPgskqGfaLaWPHbfh+b7UBdh+EzYWemGodo0kI9AJ6+QCiGKxmndOeSGVDwjYHYOw
 guB/Wp7wWg7834s0562ZQh5zs3szAqMhsXvmoaLd3qpUHhn+L5B2o5ArKQYf5BwioSorh1MfsK/
 tKu4g6DzCFANp6Uqz5bLIpxrt4Yxh5fhUoJr4DnCcb9bc6JYWBa8xPrSATMBHSNKHizfnisK0K0
 mAegSyrLM7+fyBtFpr1fNWLXutdy0lv5ReDZeytyeU25ps15n3O4LQgxG9uuNUaPSUrQXFfymJd
 P
X-Received: by 2002:a05:6830:681c:b0:822:e94e:349b with SMTP id
 46e09a7af769-84d09a103f2mr2547339a34.30.1792616244027; 
 Wed, 21 Oct 2026 13:57:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd7d5330sm3297806a34.21.2026.10.21.13.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:57:22 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:57:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org, Vignesh R <vigneshr@ti.com>,
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: Re: [PATCH 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
Message-ID: <20261021205719.GA3366009@bill-the-cat>
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
 <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pw+bB7I/NZ6HHluB"
Content-Disposition: inline
In-Reply-To: <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--pw+bB7I/NZ6HHluB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 02:00:35PM -0500, Anirudh Srinivasan via U-Boot wro=
te:

> The designware spi driver doesn't support dual/quad/octal modes, but
> the driver still tries using these modes when it sees a capable flash
> chip in the devicetree. Add a supports_op function to this driver to
> prevent this from happening and force single lane operation.
>=20
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

This introduces a failure to build:
+(socfpga_secu1) arm-linux-gnueabi-ld: drivers/spi/designware_spi.o: in fun=
ction `dw_spi_supports_op':
+(socfpga_secu1) drivers/spi/designware_spi.c:707:(.text.dw_spi_supports_op=
+0x18): undefined reference to `spi_mem_default_supports_op'
+(socfpga_secu1) make[1]: *** [Makefile:2131: u-boot] Error 1
+(socfpga_secu1) make: *** [Makefile:189: __sub-make] Error 2

--=20
Tom

--pw+bB7I/NZ6HHluB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatknLAAKCRAr4qD1Cr/k
CjuYAP9Q5LTVb44Xq5EpUAU16ucmOQfFTWlDNsF2wzXC+/VUUAD+PygEKojjspGa
Zhm6y+4Z8FnGH1I6t0GbXN6JZGE3OwE=
=0SKS
-----END PGP SIGNATURE-----

--pw+bB7I/NZ6HHluB--
