Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BF5606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qbInR5Ca;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=d+hNLlIg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0A21407C8;
	Thu, 29 Oct 2026 10:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5LisYegYtV6X; Thu, 29 Oct 2026 10:22:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C92BC40763
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793269347;
	b=P2hUzyfiKX6YJnfE/ZaTZlwIUBpvbvbiPRLCEGUizGxseZg1MyjwpSeHsnZDsgfOtbqY
	 6nf3R7vUOsX1OLLhmlKNQlnVcYKjQDT4H05alUObQnllGmuKIdsTYG9CqYUqfyEejpoxd
	 zfwTIgU+WT7wHP14244EFFl43nsmI69/sk03zx4UBLx8jSPe9i/TbDb+dMXWu4NMl0T4v
	 08WM1tTmqga13LYb9yM3qXy1d6R1ECWoKJMWgkw/+Mr4C2lMXCNPxBxLalnAszB4GjsiN
	 MgtNSjmxKeHblUW+K3ohu8pBuf7aqOZNDjrlTDF4kQXJGMhslEARriEOaIP6AyurbSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793269347;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Virus-Scanned:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p0XKDkyWMy5S+XpddgisV9BVZcC6U8hCI0hLkZ2yzyA=;
	b=tRI02anYaTTIH4XL+cehR8V57sWnCzvwJCCUK18utQJ0Ha7E71/Xk/QX+1+CCTQorcGK
	 NFB8ooGAzXZCX5ivNlISTMbFedTFnyUVY8xfgMQzcYEWDc9gH8RkU19N4L9ARm4HPLyD2
	 mGRsnoC9xMz8I+6qvr7apkT4YuKswJMVfvTgb+gJDfjhGzZwfXG4r1tFgMRKgb9CQ6Pgo
	 Vjoi/FIDYTpnDoBnI8CB/Y4vHm8zvW47Vsl8b0q/n4hUOp9hwycQOdn8BW+JkUGsY2mms
	 +hSKCmBs7qtVLh95s10WZ/ZeLx0m7lFgwXQiQlkQ7/fIj9030lFfJJiRCwYhzvHbTLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793269346;
	bh=p0XKDkyWMy5S+XpddgisV9BVZcC6U8hCI0hLkZ2yzyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qbInR5Caom79D1DEIz3MjAQivhfrxLoBfMb136FgahBbAAMprxfqJ10HKOmrdBgUQ
	 UrtAhPGQ01XcGJt6uM91z8m093uv2boCjqS5yZMYQEErCqA9qf/FtrDWdGFw8ApknQ
	 LoKkcm4DjhtLQDUEPxC5cggv+qWfs5aCw71Tu5uxY7hUs2rUeSVwAp9/GMDtiLiVmw
	 x9rguW1wDsXOOSSckB+pmddde/w8hWnoFqRWnCiGpXHBIP9rDoqWgyBt+8c6VdxPKw
	 wdm/tlMjSJa7RW6N9fsOlDimdHmDsraptMfvKkk1GqEPqdXpoPtCwKrSGz2icMpLUf
	 vKY3FuM3am0+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C92BC40763;
	Thu, 29 Oct 2026 10:22:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D323529
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F0FA40087
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8w04a8ve-ot9 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:22:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1A55F40024
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793269344;
 b=OxE9sKtC87c8DMKC+Pb5ocQfaHeYgGy560eUSJlVPBJcC2aPWagtc0NifNhV0glQAZ9R
 fywS9yNeNuBVdXoAKz7+nTu8wnLWkrT6Fu8QtzGhDxLusGpDkOkMAdeL8kDN2WWc1aEFY
 9fYWiIlTOEUWlcjORkw9AHrBIzJ1DiD3Nx3BeoCZjic8rfWs8PZC8JWhhA7W4SL3cyLRz
 /zty+bNnzChyFYOMZqgCOe0y20seUEQ46lZhrQfQ54axBioGNSlIFnDKvVoEGqf62zQ4V
 R6dOS0LoQr1hXrZaQW9ou9iIakdwHCGo/esiCYkR361xPfLGGVUlf8c1OahnnOyjRtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793269344;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Subject:
 From:To:Cc:Date:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Virus-Scanned;
 bh=p0XKDkyWMy5S+XpddgisV9BVZcC6U8hCI0hLkZ2yzyA=;
 b=hhr+SSAtl85v3DIjz0Q3KdaEeLT9pfLhUUBBsCq/ruqcWdfkj0qfDgD0h+3Yr7ZC4XVi
 UBSMmWVdCAztKgVko+BJ9yChPE0g8dvW2HZYYZE31wFKbjDbh/LbOdIECeWvJxbOxRmbw
 UCsyQ9b4TKMW1caAieS8xKXbcPcpFTrQEPinUDCdAViZhsL4GOFNFoXvjbhzIee6Dd4Uv
 GCMq2sYFVB7udx4Ze3PfLlNePJzIZIG0PIlY+GLVa0OB04oU+kPutAqtxeiUln9dHyPHC
 fGxgprDQ7iPRjFEiECeIg/d2/Dh7a97IoQpDB6YAepEw68azXdZNYwt/RjJtAC2gf4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=d+hNLlIg; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=d+hNLlIg
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A55F40024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=p0XKDkyWMy5S+XpddgisV9BVZcC6U8hCI0hLkZ2yzyA=; b=d+hNLlIgn/PsVkAqQexzgCsKh4
 TYJQ5NzVH1TzItysMIpbeia14frEQHNgob6jdUl5floeRI4d+uIX4AlpJdmazB9Oul1JrbVahxQCk
 TGVVNnOHek8BkfWoPIMBsnwyK/Ik+opUmS8QT4zfDgyayn01ARvhdsbGrUzFbCEBIxycqbTRIJ7B1
 wLIn/vxYMdghiXr0WMJPGRuU5vnw2Q26IJjxluMuMCamFrTPvPO0Y0/m6QblR76G/SVwoUivKoFuX
 oprnEcUYXM9cru/pzffdySf/yBOWILyBQF/37yuShxdAopJQ+nwKyf5c6jyMnNxUpH5h19Jq0VlwE
 5Kp1kzQQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xMNGy-000CSQ-2o; Thu, 29 Oct 2026 11:22:16 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xMNGy-0008iX-0g; Thu, 29 Oct 2026 11:22:16 +0100
Message-ID: <3748221b0fb1cb6d64e587829ad107a52b95a5b3.camel@ew.tq-group.com>
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Marek Vasut <marex@nabladev.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,  Tom Rini <trini@konsulko.com>
Date: Thu, 29 Oct 2026 11:22:15 +0100
In-Reply-To: <79648af2133070a0f6fd9273b7b5870c79fdf2b6.camel@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <9a416f0664c8594c0af0573b5385dc4cef7e2dcf.1793091394.git.nora.schiffer@ew.tq-group.com>
 <523b0b3b-f260-41bf-8455-b58acca52b03@nabladev.com>
 <79648af2133070a0f6fd9273b7b5870c79fdf2b6.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.6/28168/Thu Oct 29 07:24:16 2026)
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 15:54 +0100, Nora Schiffer wrote:
> On Tue, 2026-10-27 at 18:25 +0100, Marek Vasut wrote:
> > On 10/27/26 10:39 AM, Nora Schiffer wrote:
> > > On i.MX6/7, VBUS enable and OC polarity is configured in the usbmisc;
> > > there is no PHY driver handling this. Always run usb_oc_config() when=
 a
> > > fsl,usbmisc exists.
> > Would it make sense to add usbmisc PHY driver ?
>=20
> Having a separate driver would make sense, as the usbmisc is a separate O=
F node
> with its own compatible.=C2=A0Thinking about this again, maybe not a PHY =
driver
> however, but a UCLASS_MISC - on Linux usbmisc_imx is a (subsystem-less) p=
latform
> driver too and it doesn't really implement any features that would fit th=
e PHY
> subsystem.

Hmm, I'm unsure what do do about the !DM_USB code paths in ehci-mx6; I assu=
me
these exist for constrained SPLs that require USB support? Having a DM-base=
d
usbmisc_imx without DM_USB seems undesirable, but duplicating code between =
the
existing and the new driver would make ehci-mx6 !DM_USB support even less
maintainable.

Best,
Nora



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/
