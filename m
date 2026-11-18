Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA160A2603
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UdkWP3w9;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=tYLiv2Y5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6752D40A13;
	Wed, 18 Nov 2026 14:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fv1rHm5ZwXmE; Wed, 18 Nov 2026 14:27:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CFFF40A09
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795012038;
	b=V8R87kIEwRR3f6Hrb86Kn8dc97ZOTY/0oE4HDyBynktP3dVwlzDsL1gayNT9NoWRqZdt
	 LxRY0zhcipSgbUSXFO2l28FMElblyvFe68oWHBOYk5RnrjK9t/BG+QVjCTsqjYnn2b5bR
	 Ge5K/Wv0FW84GXdruBdw2nRKrONjizZsscO7tlRM2Vt5TnZMrZB4htGeINlFs1lmvDS0Y
	 MFYuKrpzPmFa9mHfEvuVX5dfnswLdG8X46cm0be9aZPQE1xZZN6deco1U8Uhn8idXJ5Ad
	 sOthoGi4ckUfz3Zjlk/FbnluuzkN5o8pH6rvvkJ2Uve6R8cu/9QtVXEIez4e4/D0Ovg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795012038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8pTBllbNrkI473ewIXmC/Z4YOimsT1UyW7x+TnvgO3U=;
	b=UPCWcQHenUQKDLhI5lrB8FEhGMY72ifvNNtc5sp/J1AEhHa3wSvzEZAdctAENdl1nk+p
	 e2sE7hfJRzUR9WepY4mcfz2RHioizwZSBDve+I13TS4BVWVh2FTmLzPRB0uzkJ0MTR7ac
	 3KDsp1J04JPVORR8A7Z+kDW074Xg4gq6cvr7VTwt5iB2aRKw50/n2kxjueKkb1t+Pisuk
	 PYz/ezbS36P7DNrFSfsFlw12rkknS/aitAAHDMHmCQwXx2f7Xx7jSPdfrIm6AftiMAL61
	 c+a1NzYz3gDoZItLWnHoiv8Bg6HmSF6/mhQcE+jf2ni+S+akbhTiLoZ/cos5nxFPNYA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795012038;
	bh=8pTBllbNrkI473ewIXmC/Z4YOimsT1UyW7x+TnvgO3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UdkWP3w9QwrFzxYP71hC7uhRkie3/ZsES8Mk+TqnKFWp9hGUaeGFQWF/j7kmsk8xF
	 Bsu5iNy68AUumHWA6Veo9h1J4G1eSYC0oqnta3C9a+j6a4uh54w0s5F6SpgySeC/HQ
	 Wxe4bVb6xd+7KsZW6CBGZeo79QaL2hj8Exwn4wPtyiypb3jTo8vCIAuLdxwYiuVkg2
	 1Exyl2riCLbtfe1NjNGIXGgsNGkEiCxJ1ywmvjOGskm2CXC1Jh70VayB8200CpOOuo
	 DZtLHhO6kNJdRVJRNKEqdBNDDaBnSN/FTfEz8FtTQLgpa331peebQtPZ1a70+uQl57
	 B7lvgJq9f6vGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CFFF40A09;
	Wed, 18 Nov 2026 14:27:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E1D7B49B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2F8040481
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:27:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jn9xtTfzF9NQ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 14:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DFF3C4047D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tYLiv2Y5
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFF3C4047D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:27:15 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-48ed188ee81so579737fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795012034; x=1795616834;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8pTBllbNrkI473ewIXmC/Z4YOimsT1UyW7x+TnvgO3U=;
 b=tYLiv2Y5NzcSPSCqP1xtrGB6hbI6giu7BkXcXhtY+S0sGXsLLhWD6WrEzkmvngeoy2
 KMw4HGwGy/ufeSgUI2OiTEzoJX7RYH24Gd8594uQM+X3+6NH/dOi+Qa+gTOE7bG8csfj
 g4ImHA4IJlWwrX+7UeA8Y/rren0z1OpsFAj2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012034; x=1795616834;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8pTBllbNrkI473ewIXmC/Z4YOimsT1UyW7x+TnvgO3U=;
 b=jJkyoBfogdNTk5hetJruIx9yaYIktFjYfdEm/Gkfw4qxi2askqM0x1HhOUkp5/mSiZ
 Dg8jCDkvs5EfKjd9A8LYATjiETowRVp36zY3Wp+tgKtnBtx6RKa5jGBG/6ISYQJJWemV
 FgmtMRdJ8CPlc6q/m0CID7VsvM8SUOlzCsmZkC5pVjSkZaiGxkQhE1F6WHPoGDU3nu2N
 K8t5f76z99VT6mzgpm8kp1GK7lHCjy88byyECOhw3bHLWdOmTTAK0A1T17L2O+P9Qfb+
 snO1uzMR+dWz7QBxtWGYfWa4vA2Jh7ccI0mnz2tt6klD/XR97in1jls9Yx24zNFIkGNU
 AiOg==
X-Forwarded-Encrypted: i=1;
 AL+hErGxG5jakqhb951jMW5ExZ8W2RxDclq6FsDEQ3xHLNs4cWZ+AyP+0H5owTPWa52ZGmmqg3SGx14=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9l3xhtvlbdMzSN/OzklrlHj1EwzIuxIzEKNoo7E9Ci3UzaD0fO
 FWg8c10KhhOgRMPxYc/i8p7FuYp6OAguokmsCuZMczsM6a7hdQxMesiDmTSFlRnb/yz5kv6UI6+
 Mqc/Z59hLqg==
X-Gm-Gg: AYBFou3gYTHtNA1Q1vnIG4z8qC7XaA7xwhRLUAdFRB1cwetu+0M0ZTAReua72Cic7qQ
 UwPi4JbwOqk4xHsMtTBM3aOmvdzMcfdp1r2MCcOcasxxKPPir2RvjkJO0IKCWGUBqmlyLvMYesj
 62QhGDAv1W0vzgZx7w/RDNa/VRWCRFW80rKMX3F5kkydh7uVvxMOtrWFDZIhQ4V4iqc9L93OrFh
 6h0sJpDLqmEghuIXHc3T8iOWD+16PFTkpQrs6VmFhCAX71qoWnnIeyG6+nfeFGG8aWbukt+kOUe
 bf4l7JlwAn230DXNskHy2Nk5z6IIcm+4ZKZhNaLBB0AkY0a1A781pToGwhWgquwpFLbwwRo0alD
 Jr7B5E/b35V8hvEeYlqd9XAclWyDkQYUUgpD9atbkDCP7nA1Xy7OQpX5VASi5qLsAZPS+dgNG5C
 Ag2oCycZwCDAO6PnkYwcbPhLuvT6jCZ9TRVIa+E9NtjcUoCyRsOhiCvYe4mGUQh34lv47wXQOeL
 rNPsB3elhkME2CUVxlqj0vPBFsfEFBbRwjGLc0PGOzhzEkgBrw+TS6+QsWFVAU9IC5tOvgZDNj+
 dIMguOkmC1S0qHiC83Ltb3Xa1w0btjh/OIho5UZobyo925EN8vZ8JUe2PhtLqgeK+Anf3zWt2Uq
 EsOTGqn/t4tLnf+Yso0vB0uNwgWLJf7vPVQj9F4+rCC5ffZP7Hg2d5S9xkF1dxnZSkZ/kfb+k6Y
 w4+l8aKM8dNLlvTMt6EpZ0z+uk0fK6noU=
X-Received: by 2002:a05:6870:218f:b0:49f:80bc:ca7d with SMTP id
 586e51a60fabf-4b75c376507mr2216291fac.10.1795012034337; 
 Wed, 18 Nov 2026 06:27:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b744c14fe9sm2459214fac.13.2026.11.18.06.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:27:13 -0800 (PST)
Date: Wed, 18 Nov 2026 08:27:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 u-boot@lists.u-boot-project.org, srk@ti.com
Subject: Re: [PATCH v3 6/7] arm: dts: k3-am654: add bootph-all to gpio@38 for
 daughtercard detection
Message-ID: <20261118142711.GV554944@bill-the-cat>
References: <20261116055029.3493551-1-s-vadapalli@ti.com>
 <20261116055029.3493551-7-s-vadapalli@ti.com>
 <20261116161209.GA554944@bill-the-cat>
 <ce0cd06a-30d0-4ab3-9c5a-2c4f51eef7d7@ti.com>
 <858beb70-8ee6-412a-8f0b-7de15e23803c@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kcoJDh5IMyDqzoln"
Content-Disposition: inline
In-Reply-To: <858beb70-8ee6-412a-8f0b-7de15e23803c@ti.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--kcoJDh5IMyDqzoln
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 10:50:08AM +0530, Siddharth Vadapalli wrote:
> On 11/18/26 10:10 AM, Siddharth Vadapalli wrote:
> > On 11/16/26 9:42 PM, Tom Rini wrote:
> > > On Mon, Nov 16, 2026 at 11:20:06AM +0530, Siddharth Vadapalli wrote:
> > >=20
> > > > The GPIO Pin 38 accessible via WKUP I2C0 is used to detect the
> > > > daughtercards mounted on the AM654 Base Board. For the daughtercard=
s to be
> > > > detected at the SPL stage, add 'bootph-all' property to gpio@38. Th=
is is
> > > > required for the PCI-USB2 daughtercard to be detected at the A53 SPL
> > > > stage followed by A53 SPL updating A53 U-Boot's device-tree by appl=
ying the
> > > > device-tree overlay corresponding to the PCI-USB2 daughtercard.
> > > >=20
> > > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > ---
> > > > =A0 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 4 +++-
> > > > =A0 1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > What's the status of upstreaming all the bootph parts of this file?
> >=20
> > I shall post the patch for having bootph-all added to the GPIO@38 node
> > to Linux Device-Tree mailing list shortly and will get back with the
> > status here.
>=20
> I have posted the patch to the Linux Device-Tree mailing list at:
> https://lore.kernel.org/r/20261118051719.691715-1-s-vadapalli@ti.com
> and will follow up to get it merged to Linux.

Thanks.

--=20
Tom

--kcoJDh5IMyDqzoln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCav21uwAKCRAr4qD1Cr/k
CkndAP9QwugPIDYssSSJe5eXqpVIfKsGEE9fT076XEeDAi/mAQEAgvKnLxL8EWAv
Yj3TNKLsKIypGfVarGuGTQeGxqcfVg4=
=Ua3l
-----END PGP SIGNATURE-----

--kcoJDh5IMyDqzoln--
