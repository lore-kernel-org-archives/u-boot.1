Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CE2C624A4
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 15:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B1F540556;
	Mon, 31 Aug 2026 15:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KjhtCSHYfxdo; Mon, 31 Aug 2026 15:57:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788191849;
	bh=MWVEejDAvtcjScdlDqnuD2Qa4Km5Y6xY7pkaqUatyro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VSI9RlWC3UwZDO61122zEDYcDbvMjeLU5gQrBqGhABSff6HxzYVIVDbzYKKOnRMlB
	 oQxvs6IhR9k98ge6vyLYBQKLT9uz0l54eFL4vAKBV9UT4KaH4RUaKMOb2AwmLFY/kb
	 +CGafIoGIEFunOMr9lA8wFlReuKiZuNR+7K+oC42nuvhDMaLzsQEu4VhxjyCb5pdZr
	 KggSS8ejjNCq6AG7D5xG/ZXNWxXLeCqIhYPpnTNsiUtUaNDuJN34BQG1tRRz7QONr9
	 XTVYIoV5BiZTDTtfMt1lDbcHVRU7PzS8bb/puSEiSMudPHOQKw/si1IaZ5EyT7hiWY
	 Fv4Z+6usX7N2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74D2B40549;
	Mon, 31 Aug 2026 15:57:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4501F2FC
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3742A40064
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VjToOlb-iM2w for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 15:57:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::a;
 helo=mail-oi2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LwjhS1BV
Received: from mail-oi2-x0a.google.com (mail-oi2-x0a.google.com
 [IPv6:2607:f8b0:4864:32::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B82214005F
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 15:57:26 +0000 (UTC)
Received: by mail-oi2-x0a.google.com with SMTP id
 006d021491bc7-6b136fad4b3so625444eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788191845; x=1788796645;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MWVEejDAvtcjScdlDqnuD2Qa4Km5Y6xY7pkaqUatyro=;
 b=LwjhS1BVND4djM15V6hdotfPWUW9E4lNsXxbi9RUsBDOpq661hcKnapR0QO5w8N/KZ
 tC5TwpEqypuPar1Rei6Lw4B20n3Y9Ks7+clCTwlcfpFkCzdFZ45Q880R92Ad3fEgcNxP
 Xdx2UPy732C0gUmXz26dvTj416cYTQrSe/vI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788191845; x=1788796645;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MWVEejDAvtcjScdlDqnuD2Qa4Km5Y6xY7pkaqUatyro=;
 b=YuxycMvRyTzeYNPp7v1RNzedlLZQU2FBM06wzTRgvYQz4CAJ8z/5b6oljc2hr2LaML
 BhEUO4qB4O3W+2B9/2OHkflKpcnmjX9CU5P24cvFchyzMSYlzIAZF3LsNJWT4hlGXeGL
 4FDjwMXo/iGdKHPR7Z5YrYxXpCYizxKclTW908CdBs2YOXqChPe9G2CkUTfY/Ht3EIx6
 aDqAR97+J9HGBr5jnEkEGCqIXV0J10bZtS3VxVf+MSWjfzdoiin9/3t74V98sLijW+5M
 2k742v5aj1TX1QW7lmbvE+h64Ao11uhu87wNI0dTXNKEbw/PUueYcHcxz9xreqyhyOXN
 hDBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNIv/IhOq4xTs5flCfHy1pq58WbsszuKUEY7hcmmZJ9lS710RtmIfd7WBeYszVDIF1WW7YD/Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mXdTIrMCjztCBNihzVWB7UQZt+/L3jp3eruMfa9Zsi+I4Xcm9o
 ldrKbPhCO04n0YssD60EP44+NEPhHLMoeBdxKFeKFybtIPwuVkbBADHEwzwIe+wjQgc=
X-Gm-Gg: AR+sD11thYz8NBd4c9i9JKiQPrKI7uYd20OgVWoj6A0gfDcyQxvBP3AiCcBLatYysYC
 nbE3APHYWCyCYAivMgzxLP9tvFVGhCc2io5YxJjXUzITgBDRLo1IWcHgzwoV1t8ho3CvnUtP+bh
 qssCj/qM+0quN5asjPL0W3yXN42fSsirtAO8bPdQocvt0oW2KAfcNXKjKdSd9NID9PYxeC/fg7g
 eXbI7bKU/9UtiRKbmWel6sehXq/FDxhoSAhFsUQrY6Nz2Wf/we3JxoilLbppm9BZwaeNvQJlITX
 KIqioYuiMms5Poj3/ln6QF2ucQQ2k8JPy4LWNxzbOQP7vP+Y0cRi3bSVYR0/Ctb7EuSCQq38Ogl
 90HDdPl2f3tekMQHFX+JZqSnHd0QBWDMrnpRMgZNb76+0leCsjFyCbx6fAFnXgNooFpU6/Sx2ui
 l7UM90/H62LSh36jMSXDWkngtXbRdeq87TdvLxfK5P+c54SBsKbhUvD4aR2cgJwdcrSH0kY6/vB
 dUpFGxBFgBToTkh+0yUZbJagCi6wreN2+TNTWzT0s07mZL0rQFiI26o87c3LayAX+ldo0UJdy3c
 cseLvB1aNKH9q1B9f9HF
X-Received: by 2002:a05:6820:222a:b0:6ac:a9c6:92c with SMTP id
 006d021491bc7-6b372d5c4d0mr1422900eaf.10.1788191845229; 
 Mon, 31 Aug 2026 08:57:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46a4b7a9f82sm7367042fac.18.2026.08.31.08.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 08:57:24 -0700 (PDT)
Date: Mon, 31 Aug 2026 09:57:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Remove references to not existing files
Message-ID: <20260831155721.GS3959812@bill-the-cat>
References: <cover.1787555916.git.michal.simek@amd.com>
 <fbb28ac69d042b60ab6b27f1cbe52a2d872b4ada.1787555916.git.michal.simek@amd.com>
 <apUuBcsqkBEIWp8g@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0vfUXJbz/t6YNDOS"
Content-Disposition: inline
In-Reply-To: <apUuBcsqkBEIWp8g@francesco-nb>
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


--0vfUXJbz/t6YNDOS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 09:32:21AM +0200, Francesco Dolcini wrote:
> On Mon, Aug 24, 2026 at 09:18:48AM +0200, Michal Simek wrote:
> > A number of file (F:) entries across the MAINTAINERS files pointed to
> > files or directories which had been renamed or removed over time. Drop
> > these stale references so that every F: entry resolves to an existing
> > path.
> >=20
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
>=20
> ...
>=20
> > diff --git a/board/toradex/smarc-imx8mp/MAINTAINERS b/board/toradex/sma=
rc-imx8mp/MAINTAINERS
> > index f7fcef1c0921..056750c50fb4 100644
> > --- a/board/toradex/smarc-imx8mp/MAINTAINERS
> > +++ b/board/toradex/smarc-imx8mp/MAINTAINERS
> > @@ -3,7 +3,6 @@ F:	arch/arm/dts/imx8mp-toradex-smarc-dev-u-boot.dtsi
> >  F:	board/toradex/smarc-imx8mp/
> >  F:	board/toradex/common/
> >  F:	configs/toradex-smarc-imx8mp_defconfig
> > -F:	doc/board/toradex/toradex-smarc-imx8mp.rst
> >  F:	include/configs/toradex-smarc-imx8mp.h
> >  M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> >  S:	Maintained
>=20
> thanks for the patch!  this one was an error in the original submission,
> it should be doc/board/toradex/smarc-imx8mp.rst
>=20
> I can send a follow-up on this, or you can fix-it-up on this patch, both
> works for me.

I've corrected this in my larger v2 (where I didn't CC as many people,
to avoid getting throttled):
https://lore.kernel.org/all/20260829015026.473134-1-trini@konsulko.com/

--=20
Tom

--0vfUXJbz/t6YNDOS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapWkWgAKCRAr4qD1Cr/k
Csz9AQCLVClfLzNrqIeQ4OQoxbIff5+QH0dLMRru6BVcEAybDQD9FEAgcSjSOxwY
UlJY1f/1w+xA1r1pAW3zN2+6F91jWQ8=
=e/Fi
-----END PGP SIGNATURE-----

--0vfUXJbz/t6YNDOS--
