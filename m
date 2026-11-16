Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C7606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PeM5kHGz;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WKTvToRx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 717B0606E1;
	Mon, 16 Nov 2026 20:10:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hWULfPL05Yql; Mon, 16 Nov 2026 20:10:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9386C60739
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794859834;
	b=N98DDbyHv9gJd1cQ0R5v9N7+FBeqH4LpKM+i4vfd+DMTzenDZzPuXmlVH1brkVt6j9fc
	 EnaBvdgaY9u6/HMM4eRrbpNLutcBKcOzk9W47pGkalbJRyGfbRmqKqztcr0P25YVo0U52
	 NnXCi3v/7gAm0/tJ/55Hc3G9+bmmqrzGkNecga4xL8CQ3f0imXYvc4XBfiFa+nhBloPxu
	 ouN6VBjcnJlB+YD4ta7jsp8A6LQZGYVZnoQJdJL3AR01yflcdh+1eDOi33FLLRkdH1eWa
	 gE7lYc5hFnTGYzeJmcW925V/mEKm3C8yvK+628uPaAkcEyl6RSgfHoPFqqXencHpmmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794859834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SGrYFaJijg9NiSMfMhFbNYoFwaQ16Y7g3GSVNOXxsUs=;
	b=OyrZWuMEsiYzmQCWT/gU8bh5EU82UxO4ekdW/3lvjze77OGRRfwVfLHrU+LnjprGsWbg
	 sq2c+DAk6HzNoyNXqaH4bgCP6eyozUajUbwD0RIqQHG14MbB3RCsNLKmhGAax2o3wEBzE
	 G2ijNWNIghdqZLN2H86Ynx7Gjtxg1SpFAzfU86d6xdQIYEDzZJZVE9nk0g3JuLJwQbhij
	 G1FrxN7dKioEeW5W6ZkRIFU4/Zhv6cmUeys8t3WbF1AZ0uFeS2Y00nIq43NoDmLG/2kAV
	 IA07H/J8rYAwukVc/YK5zxEvxlb/jMMkoIbn5iGjGeTLnA6g8wlI+dU5T/GJC6mSbOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794859834;
	bh=SGrYFaJijg9NiSMfMhFbNYoFwaQ16Y7g3GSVNOXxsUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PeM5kHGzQNkr94YZjhSifbIFU4zjvrAK2K6w/sjvNx8f5BCBEV5+hUkyL8+gV3iRI
	 bAcIXHHjNh3ULg+862ukoHW2+6idLoBUupZD4W2v7S3kcUu79g4yghWkjAeEjQBgah
	 Z1U6SIDXRvDYd9CYpmrQeIcn/EuqhOZIt96a6HwwQmVaFEJhpr7612/00DroLSY3pW
	 i6gwmn9CqAXc6G2H5gNyVKntHPsdk0do+67LjV6hmTjg65z/+7AxHlYC+dAuabkkzx
	 CjbK9TMwv89kF949tds9HCeSdd82bG9mVWuoB5/lwsjwaT2tootZDyVLUOj+4V3srR
	 qlz+0MX6xTw7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9386C60739;
	Mon, 16 Nov 2026 20:10:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08D36109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF16F402CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:10:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cdi_QJhGthNe for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:10:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0FC63402B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WKTvToRx
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FC63402B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:10:31 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-862b3a39d0dso990924a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794859830; x=1795464630;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SGrYFaJijg9NiSMfMhFbNYoFwaQ16Y7g3GSVNOXxsUs=;
 b=WKTvToRxk+chxzafxlZxMwAV6nC8fbQwSJKCZ93yPlb/rNosdFPuQbOwYz/u+gCLMo
 EKDXJSvF6gdkR9csRigLzdHsgYSnZq/gqRDUwWxY795TzEzceniQoyIDUmFoOno1yGqa
 oRJgc5wTNSM/DW8fZiIfym8Po1+UJ44N/Hw8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794859830; x=1795464630;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SGrYFaJijg9NiSMfMhFbNYoFwaQ16Y7g3GSVNOXxsUs=;
 b=1fo6NiDab7+sSPA27RsirtvbEUq87XclbzeVS32npr+/Bbo2LozAQu31e8XU0nW6Qv
 QxMV20U+ZD02E/LT4gPfnC5jsDRU97cQ1dtfbR/QfIuFbRca5lSXDBVvSHmiYatByM3x
 xBn/eNje/lQ5hAeHjKckzEXB6aFgeDEYAwnGX8egRk2GNiYc67MtCGpeZ+rYKwzhF90g
 5Yo1cCaWwQ2lpgLkiai85bPfotMq9QnG9RER/+Oz/TT64ZYuP57aUbOjRVnQff/wAvwh
 xIVWPadmS85COxIgdPpBcOtNTh1tEH+x196PAJEMqr5ZlTzxD9YHdCn+ZOKfNQeb3AUl
 xb6g==
X-Forwarded-Encrypted: i=1;
 AL+hErH2QkfpIh1RQ/Xf6YE3PuQpqm0JZPaQVnG5m2mQAUsR0IP7yrwvtMbswB+yuFarjnP5OTA/KsY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/wylhm3S2XSVKQCa3lBGHMhBX0rYoeHhGwNDEWnhzHQJuPi3vt
 PbwZMJBI5arttugsrf6D2FVQxNuCoZE8z8qh8tS3HvEvFP/5hXiUbQGzwyhCjV/kQ0Y=
X-Gm-Gg: AYBFou2WeaVaiQijHehOAQ8sP473vVaj6LVFqebtEanciMmrJ9zx3MEtsEGw1lKc4tI
 0Df9neJavn+/d4qluV2fAScJC9p4I4B2F18ejcr63hr/0H8q45yqTPNE3Tq95DlJle1QUvisoMI
 /cOd5tLlMJt7Cs6AJhzfIMEzwxIllkXW+jJvUzoxQXrq3ouNLS//lhtPhelAqe5XW+SwmYT48Y1
 8sicHjDRyTm8wuOmzjKw9Oi4Vc8qLG8CsmO9KMnEGNDxvbst08Mh4DQXrY+qaW+A7pcshmrYDaj
 MNE1R/4513x2NYk5BEyiwkGJowvF92d++Flk+k/joOS6KHDmtsWJeRW3VkIG2L7wUxSVWY/9YkK
 YwurvliYVG1sGxoFDw1sOJGq95DPKKSpLji8S2lIuIpJTMVYpeuqQ3YQL96vmngbl2rp+aFUSiV
 FuQ2wJTMNY9qZm58bgEOCGWRE+myRMvWTzs8vcmqcRg1FdNu/zte/CyPvaKntZo9Ki9WAm7o2wI
 /DQ7JTAjImDxlcVcE8+uaKuSo6nMReg3eiHOusV4lQYCxvpgyyZ998WMeofhpt934yKAmIg3VAY
 NRvKCdCSsfyRq7EUqscCfs+6CxMX9tBcPC1VBoE8Ao9bPFeWM7hmi9VxzYdtzL4en2zrL3cZNyb
 VE0R7IiFiNpdXM0boCmJbMR0GTLvaMTE3LRjwsmMWoq3rXH64F4FD0KRIBUTyYg2dnNlL3Xx09v
 MXT1MJmyVggEF1brjNw1T580nnDVhfcCjQmWd2mAQ6jKDmrzK2Giyg4A==
X-Received: by 2002:a05:6820:c3c3:10b0:6da:29e4:35a6 with SMTP id
 006d021491bc7-71ab51123d9mr5390099eaf.52.1794859829890; 
 Mon, 16 Nov 2026 12:10:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab4338765sm9644499eaf.14.2026.11.16.12.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:10:29 -0800 (PST)
Date: Mon, 16 Nov 2026 14:10:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>,
 u-boot@lists.u-boot-project.org,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v7 00/22] arm64: FF-A runtime transport for EFI variables
Message-ID: <20261116201027.GJ554944@bill-the-cat>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
 <CAC_iWjJJdWmZGE-bn+NZhY6Uf9PVkpVLB4i+Oj+mMtLz0MAxSA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I9RNkVMZ3+62A2/i"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJJdWmZGE-bn+NZhY6Uf9PVkpVLB4i+Oj+mMtLz0MAxSA@mail.gmail.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--I9RNkVMZ3+62A2/i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 10:00:23PM +0200, Ilias Apalodimas wrote:
> Hi Harsimran,
>=20
> The CI is broken on this one
> https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/pipelines/2=
063
>=20
> We are already in v7 and skimming through the patches I found more
> things that will break EFI runtime. I'll add comments in the patches
> later this week. We are on v7 and I'd like to start making the
> patchset smaller. You need to break this down and send a series of
> patches that are already reviewed/acked (the ff-a arch parts?) so we
> can move it forward.

And I'll point out that CI is long documented and available:
https://docs.u-boot-project.org/en/latest/develop/ci_testing.html so it
really should be thrown through that before posting next, too. I know
Azure is slow, but it's fine to push at the end of your workday and
check the results tomorrow.

--=20
Tom

--I9RNkVMZ3+62A2/i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtjMgAKCRAr4qD1Cr/k
Cup+AQDq+rvltRjwxPq59gSmp1sa6wgKxoU+obzBlBz+iNWUbQD+LNq5uXtU1Ht0
roqblgx2AYdle5i4bZwswyzm4RX6CgI=
=qMGX
-----END PGP SIGNATURE-----

--I9RNkVMZ3+62A2/i--
