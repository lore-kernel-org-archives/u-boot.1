Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1265606AF7E
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FLY7DEvS;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Oomzl/Ei
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0119A407EC;
	Tue, 17 Nov 2026 14:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykj__gwn5vDm; Tue, 17 Nov 2026 14:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 112C04064C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794926139;
	b=OnzbK0zTYUcQHA+C7f4x9O2XUTIDL94AMysoTk6c04PXhGSIplI5yZPFAsmwiYKZX2v+
	 0/m1Q+DHM5LXJnhZbjMwvSAbb8RMTScViigJv7MztGupIK7CMhjuKPGTEQ2kyy6wgv5r2
	 BefBNLFgiA3gkQpFv4UJxeyXemPQCmFabvzEZSA4hhvjwit5XOTk/3frBqIV1UJ3FkuEP
	 bcb/Q8fHG6rWqncZgDyprY2DI4iyVCQsZqmqd6Q4jl7EujPLsfoCbm9pE2iAH2rCGo3qg
	 iH49Gjz+rwzK7XnGEBuxGIHPzcDLgKThB3M4+FaAWSyLNZVyW/hY6GsBhC45yAJn/qQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794926139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vBrZ6PDkoMkUl2J4qlNr8EHmD8Se4PpjmC0bsoiTp10=;
	b=YarFRTF8XHjnixgfmsT+02aT6CJ5MctDXCfK3bpWIQmp4KCP5l3C0lYnvvXTMoQD9kqJ
	 uKBdeiO4ID4togwwX+fLsh4qAXhUZ0rfqrKfP6FXDsaHwKkzkDOwBdOULHTC5gD8lRjwP
	 TQ/7lX5hqjq8fqOOjS5xIuzyotXiel/cNV9G38E8xag2Oo4ekWpK7ql9o8Z1iQzRQ+kOE
	 TVcDdXkClRAVx2UoAoeLgkgQjHFWVY+O9DIr6kflD9khyErjQs7sKhD14GrHbQEJGEC01
	 rEjmSHEdooeiItkVZuz/Ph3em+WKBOMH/gCM/zFh10cHfqkBBWan7whSLhiP+RfmRfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794926139;
	bh=vBrZ6PDkoMkUl2J4qlNr8EHmD8Se4PpjmC0bsoiTp10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FLY7DEvS4Zla3yaF/gQh9+xteeUm42RUsUH2WhOmdTNjBrGOkgizFyoSH9juhW3Va
	 ertHBiv7Mdd+TBhFVeQrk6761alMQu2kyVV9hdGzkO0r/edATtw3SLwLiouhqfiH47
	 Y/BgvcHegAiOfA5fhrZ5V0uLbDETFwrdv7oGryQ7DZBEbLt/Fj7Ctp3drj9vC4OBS6
	 8nnUCNl0c6paeHko68H8HGWv4GjJoz9SWDsnuTNgHTQZwYQv3724pgeFj7eVHyj+Gl
	 IGr2g6DYYEocLCDjkYskJOeT3r6SJuBuB26YnTsGfRR+y9bp7YeXfRLYXrgS2MqqrN
	 3TAFKaz0YkTOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 112C04064C;
	Tue, 17 Nov 2026 14:35:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB2101E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D109D81160
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vDRDB1JsqTEm for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 14:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC2F081161
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Oomzl/Ei
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC2F081161
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:35:36 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b4c685c751so24777737b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794926135; x=1795530935;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vBrZ6PDkoMkUl2J4qlNr8EHmD8Se4PpjmC0bsoiTp10=;
 b=Oomzl/EiSKb3Xpf3ZLZU5DNRF4qxQ6RdOEMODqTt7t03RCjs6F1xg9xooVwAJJeXYg
 ZTgofuHQ6eUl0P2NVN4oxfoqd/TjceiBPLESoIg4xb4AODOg0lwy5cjUJoyphNu/JHJW
 2q17gL66E0y4IFt0V8mMW+0vnduD06B330jgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794926135; x=1795530935;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vBrZ6PDkoMkUl2J4qlNr8EHmD8Se4PpjmC0bsoiTp10=;
 b=Ofzvqq6fzFY9n2yXAJAjTcClKmB0oBeBcSRA4CXFH3rmVeQS0NvyDVQsspTsQFpkM+
 9zJuEs8kEsnmsF7UjljTTgZcy/HJLDRvFouetd3OgMKFTr5LaVP24HvABcP0KJKSDo8s
 tVec/xZAu1imJnJ4su1q4xWmSgIb20gLNdwhN8/6bFdMPuaVNUkg1CsjrJkhiAA6B1YX
 Ayv75oOV1YSKL+9c3yw/hwxJ5weY+AIycWR4BJSG4tlITmPfLtLceEszYZvZNDb73H5O
 lsduhTqE+T+O7mblIw12vMOOO40UN/Uq7flbSEvJo6nm4Vy6Ex+JzFhvxb9T0IdiQoEC
 7VmA==
X-Forwarded-Encrypted: i=1;
 AL+hErEjsDsF/JYZf3ElkU+w7/TsuMlB8nE+XLsS7azxP6AV+aZWoV0fJvpBDsGgVAFaNfwfKFwdRKs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9d/e/n+hcGnKaoPbRTcOGwBpCRcJrIEV1kZVdznWVj/bGCtljR
 wfrwnLrp7vNOUj3dwoOanRrjuncC6Q+wlb6Gt90JT//cgE6mZzlfN0e9fq6oZRPzsYA=
X-Gm-Gg: AZFdTZdKddo8ee/nK+h6E+skmLvmA/ceKRg0nGpCXhH9/jGI7bQGSVGATicJr6BRkMf
 JSABAa4pmeXnQpnfbmZ76iZ+ayK+12dKt1AlrmjpL4nuaiJfXQ9VixIuSQIbdphZ2kFsjVKb3+h
 jjOBuuE+V9hbar6zFKen3zh1EiAR8O7bCj1s3toF27QRu3227RcrWf+EuU5LmEB2Zd1lvma7Uup
 PyNm+Bj4Y06/+QiDy/qWH4/W1Q2YPHA8q9oB5SZMIsmVyHW/VYkBTuA1e5A9FqCyXZdDu8J3O0W
 F7fJLlC+2dF0SwG6JpTLdMsntV1qkTA6d9FokzbsWnXULdtq9NOiaDLBGhJ5b5HPCHXjn5SKFcA
 9JMN4TmnjV+I4kIXSSqktI3xkKARMHCu1AdrqU3pLIDEPC5TJQ4DFMvXBse8ggPDPdUVF7K2zWe
 4ZH3C+1BSzcaE3mxltrtKngEFrumFUwqpgb4BtmTUyeAQGz1qAv/08ht/1UcParUoY7SDOnfpZG
 zm6RbxxfxYNw85CTEAG1xbmhYyEblccAYL0XMCHqB8SpcUI4qvtekwvxrlfuH0M5f3X0wHHKj4B
 Xz5FYD9slHFp95fGTYrbD3XKW0E23X9UdeE0oPvHBPUe9Rd0pa3HkEKgPLcJoizsd9+n9BCNbyh
 UXz+Li8OGpguAqOo7GWGAW0rfHC+VPQ6h1QgEqtjVX3XI1Iy4FKsgHvv/rhrnYc1SfTPk0t5Lfy
 LCCpidfUEvwgCIrPZRM/Gx9SD8x0UXclg=
X-Received: by 2002:a05:690c:e1c3:10b0:8b3:1324:a74c with SMTP id
 00721157ae682-8b4aa274fb8mr39950957b3.53.1794926135252; 
 Tue, 17 Nov 2026 06:35:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4ebd4cadbsm24698937b3.20.2026.11.17.06.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:35:34 -0800 (PST)
Date: Tue, 17 Nov 2026 08:35:31 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
Message-ID: <20261117143531.GQ554944@bill-the-cat>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
 <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
 <f0352e86-58bd-4e6f-aa8f-5253a9c29a55@baylibre.com>
 <4adb08da-1ab4-4849-9001-f0b54065b5d0@cherry.de>
 <273552c3-9bc2-4b60-9a9d-6d6082369fe9@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="irFTGUSMeVDvRpyj"
Content-Disposition: inline
In-Reply-To: <273552c3-9bc2-4b60-9a9d-6d6082369fe9@baylibre.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--irFTGUSMeVDvRpyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 08:31:00AM -0600, David Lechner wrote:
> On 11/17/26 6:52 AM, Quentin Schulz wrote:
> > Hi David,
> >=20
> > On 11/16/26 9:42 PM, David Lechner wrote:
> >> On 11/16/26 12:45 PM, Quentin Schulz wrote:
> >>> Hi David,
> >>>
> >>> On 11/16/26 6:17 PM, David Lechner wrote:
> >>>> On 11/14/26 3:16 AM, Peter Robinson wrote:
> >>>>> Hi David,
> >>>>>
> >>>>> =A0=A0=A0=A0=A0 > Anyone who has worked on hardware that uses a dev=
icetree for the
> >>>>> =A0=A0=A0=A0=A0 > hardware description should know the mantra "the =
devicetree describes
> >>>>> =A0=A0=A0=A0=A0 > the hardware, not the configuration"
> >>>>>
> >>>>>
> >>>>> Thank you for this, I never agreed with describing these in the DT =
at all.
> >>>
> >>> We probably should do some digging on the mailing list because I beli=
eve this was brought up back then. I also disagree (mainly because the Linu=
x kernel will never agree to this in upstream DT, so this prevents us from =
the dream of running pristine DT from upstream). I vaguely recall there are=
 a few things that are binman-specific and available at runtime by parsing =
some stuff. It's very vague, because I don't remember. But I wouldn't dismi=
ss binman use of the DT as simply being a configuration format, I believe w=
e use some of its things at runtime too.
> >>
> >> The two users of binman nodes at runtime that I found are lib/binman.c=
 which
> >> is only used by x86 AFAICT and board/BuR/zynq/common/board.c (to locat=
e the
> >> FPGA bitstream).
> >>
> >=20
> > Maybe it's worth checking with the board maintainers if we can go for a=
nother mechanism so we can sunset binman nodes in U-Boot FDT entirely?
>=20
> That would be ideal.
>=20
> >=20
> >>>
> >>> EDIT: ah I see now reading patch 6/10 that you're aware of that. But =
phew, is it really worth it to do this incomplete split? I fear we'll split=
 the ecosystem once more.
> >>
> >> Which "split" are you referring to? File format, file location, someth=
ing else?
> >>
> >=20
> > My understanding is that few boards will need binman in the U-Boot cont=
rol FDT, due to needing access to binman nodes at runtime. Most won't, but =
the fact we cannot fully migrate means we need to support both forever, and=
 then we increase complexity for what benefit? For the sake of "correctness=
"?
>=20
> The one ARM board should be easy enough to find a solution for. The x86 s=
tuff
> will be harder since that was all created/maintained by Simon.

Which x86 boards are these?

--=20
Tom

--irFTGUSMeVDvRpyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavxmMwAKCRAr4qD1Cr/k
ClDwAP4r8TuB0z7DOLd6sRLHiQE2syjHSBk4aypbbDh+cYO+uQEA1NR+62t6VFOF
pK2eVz1Qmi1gFlN3p2n523gOGioDYwQ=
=IISX
-----END PGP SIGNATURE-----

--irFTGUSMeVDvRpyj--
