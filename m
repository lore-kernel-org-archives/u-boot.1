Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0730606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZyoNSzCB;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=acHmGtdF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AB8E60619;
	Thu, 19 Nov 2026 15:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ni_IuljNF360; Thu, 19 Nov 2026 15:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AD50560AA2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101253;
	b=IBVfzlpj3T/31Ec+8RWpUWxgwig0bU9HmLqSU6ptZ6NuXB1T0AJhj27tGfO99EQEpiJF
	 caKipSDUUeCbkBDoIfCL6eqmr5qnmsBTw3/EELLysNEQvYj3dNLZqzXDytW2mSqdqJYAO
	 OoMWiE1fHk6r3do95VEV3yzB7fQSaC5l2NDH6sSXYwOPezEyn+vSQzT8NioK5uiut1Drr
	 4eeSO9Kg2c8zCLxvshQilokzAl+HoPJdKqMC6gM4i/mMt/GYJxYTVVTy5RCMu9PWKkc/X
	 TPbCUF+AF6aOO+0KsXMUs8vv0Bf2US0PGJMGoWWFzQc1jNhKYQqY9BECDMdX4vL3ZlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5IlChqsiR7p4wnSw6XtjouCa5B2akG7Q2tiqYQvDp7U=;
	b=QM3aRBGYUa/qcrGeCnsp07ZmL4vWdSN3VyEN1HCT4+0YjmQbsZSKFwKPr+dhiQrwK5Fz
	 BsPKCQsoCJcGMJ7RgTg0rT/WidjYKTGhpSaT4hHKetjGP+lLF0OjQkOzdE2MNb8jBmCYM
	 3eh2QXT2jCt5BL2+293pgSBWIdLHg3de01P3ybNzg/y6ejdWvC2X5cFtsajipR6/2un0K
	 oXuBjVLnMtKTzE6/+M81CuAY3ftW2IoCl4Zn/maBhWcrKqC4B3MnsuFfjd/0RiWKxTteq
	 Lr6f/3ut2rvk/3uQp4V9W8qSli0XGGKuGw2cmj7sJon0S4myZACXm8Jujg+yBKfoIGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=acHmGtdF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101253;
	bh=5IlChqsiR7p4wnSw6XtjouCa5B2akG7Q2tiqYQvDp7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZyoNSzCBFh6I8FZSs6s/owNKf93/sLtYQbBxzwCumHyNuxY8UZZ6glzEHljejw7Fr
	 8fnNOQemO4syrmsIUiP0z1VTxDDj9eaGcdYFKB5DivNG7pp38wgFCO4h7Ygik3hcY8
	 1Hf0uOMQyzipBh5b2JuY9GQsBcFpl5u5A95A3n6GyPWkBwibsTAzlpH51Rsgk6JYFG
	 0dVXzDvp/Mb9hOYUjMG6Muv+ud/WJ7POxJh6QtmdOFLLqh7HkMUK8+R+ipGFE6sz9T
	 Vy4+JhDciV6Drg/ysX0arvgqXxCUUYEJBDM8/XcHCPYoGalUbcETTzud0BxTVGG9Xf
	 YY/G/SiuejwEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD50560AA2;
	Thu, 19 Nov 2026 15:14:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FCE9465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9FA160D94
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYKKM1NfmMMI for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF22660AA2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=acHmGtdF
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF22660AA2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:14:10 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-70b875f6f1fso2031788eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795101249; x=1795706049;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5IlChqsiR7p4wnSw6XtjouCa5B2akG7Q2tiqYQvDp7U=;
 b=acHmGtdFX+zoAtUI++02ruZxBWtWp9EL9xImBJ/8CTWmTv7lXbRoNKk+b9CYtg/7WP
 VDtoGEljeM6PqeLPzMjNbO5h8j+DBZ+cXubAgro2oTwyaqDljEmLDTlYzdKSUjzZkYt2
 x2KDcapwTClT69MijDjRIV5Hs3YwDcGlqfTGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795101249; x=1795706049;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5IlChqsiR7p4wnSw6XtjouCa5B2akG7Q2tiqYQvDp7U=;
 b=dUpp4vQ3efQhVkh/cj2O8DDqhSKQrD6K/G6WjYm4RvWLjTdZcr52yb7dM+t+RtsXxQ
 Jc9yZflqftZK/QPr1HFgXVCCrusBTxfQJYd/A66Ptmdew+K+1tuJnAntRdmWWsXNlDFX
 WiweeskjmcAwvdcyxzu0h+Ll3tSZjIsQsuz1AgYyUd85J7RSwOY3/SvgyTeeomr3cDEE
 aBFAlxndZLV3I/neQdvDHCltZiw4NxyXXfa5oRq6DuvQJ8zEFNWw6ZRQxhERd38FphEV
 wK7aCKQdopDuBUf+S/F9Es88qrEt903LZHRbWVloiGCthG0T7WFZYDWV00F1ecKl2cF2
 V86Q==
X-Gm-Message-State: APuU4Z+67VPM9F/ZoF7RQRQ1ODimXoMTDl0Gscy3CfrfK/ALkp184XFW
 I0jRW4wCxfkGu3BbNitL/wJf1OG2w8e6JJUWcHaa5X/dp+6Rz511H3EC7bgO6z/3aWw=
X-Gm-Gg: AYBFou2RLMkaOhe4krU/PzYHuzZMx6Y/+VGhefYiw17eRLQ0O39la8DMyRC6FjKodu9
 mmxEszckR6ZyYKM1pL8rJqZyd+K30BYTr5tbW7uo+amhY2Ow7LH/YQlLNr7hUwYiSf9gPmqKgsX
 yplQDDWczjNXwcjrlncV6wqFUTKsILNKWahtdd4cspHSYzu7+iDyuR+7XUZ5woLcwC8nSM4EO+5
 YrH+Lu4BaLDJYVAUw/tbT2YMbTEMrYJktZunQamjQhf5tfKBzQzm2wphcZJ9rGJ97WKhvXOJPmC
 mSuN/1uTxw+vMWjBpU799jGNBiecFkThZ8hYX9ocj942xyYtbctbwXnVV2ti50YnNSHu1laCrTT
 Z98QnY2L7z/K6+LDhKlAUjcdArtx4ntjYae9Qs1XARg/7xH5BaEt75VhcyqzwrCEwT2IX86nI2G
 1XzGoLikV3XQtjzajWGt6ZTPjwWfqLmVJD62JCqLxGEVWtJd5N68PeMGacOIil1eeyuuckqRUAg
 KoxI036Ughb2xvLZNHImbSSpFfH8UyQBqtyXDk8kGwFIhEaEJHRKfR3E/6MDwAXVgHszBipVcao
 4LGXP7EP1ICpBMn6WCDyqthQnrhZDes0hwjX0+y8ajDfkjOF4Oc1KxcWIHuU8dGt260hEu3Z07Z
 arOuY9ZIpC+M7jshgFCL5YxeqPnB5YRWzoePmpsD7ljszars8wTW/oXVIyTmaXhQLsJiLGKqK5M
 CmBWveLw/DnwQQkiJY9jOL/CcTknU+qaQa1xAcYxOodGq7s4laz81GHQ==
X-Received: by 2002:a05:6820:a789:b0:71a:deda:68b5 with SMTP id
 006d021491bc7-71b1882cc75mr3499884eaf.84.1795101249464; 
 Thu, 19 Nov 2026 07:14:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01381f5sm4534382a34.3.2026.11.19.07.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 07:14:09 -0800 (PST)
Date: Thu, 19 Nov 2026 09:14:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, E Shattow <e@freeshell.de>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: Re: [GIT PULL] Please pull U-Boot spacemit-main-20261118
Message-ID: <20261119151407.GA3402451@bill-the-cat>
References: <20261118213954-GKA165669@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VoxBOxnQrTBDd/3l"
Content-Disposition: inline
In-Reply-To: <20261118213954-GKA165669@kernel.org>
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--VoxBOxnQrTBDd/3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 09:39:54PM +0000, Yixun Lan wrote:

> Hi Tom,
>=20
> Please pull from u-boot-spacemit into main, thanks.
>=20
> CI for this pull request is available here:
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipe=
lines/2088
>=20
>=20
> The following changes since commit 8ea02c99391d2d922810065206721ead2863f0=
75:
>=20
>   mailmap: update entry for Viacheslav Bocharov (2026-11-10 14:57:48 -060=
0)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.git/ t=
ags/spacemit-main-20261118
>=20
> for you to fetch changes up to ffdf122644c936510b74a26390b694ed4cdfa1c6:
>=20
>   riscv: dts: spacemit: k3: adopt com260/pico-itx 8gb memory override (20=
26-11-18 07:56:25 +0000)
>=20

Applied to u-boot/main, thanks!

--=20
Tom

--VoxBOxnQrTBDd/3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCav8SOwAKCRAr4qD1Cr/k
CqeRAP91kobs8YAjK2E1bQXAOBWHeYxhKbVLn5ynuS19WyUh2gEA82lSuYwltUNo
jWaIFz17o807uv0A5/JGfKttMu3LIgA=
=2SIH
-----END PGP SIGNATURE-----

--VoxBOxnQrTBDd/3l--
