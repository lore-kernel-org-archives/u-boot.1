Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCDBCC6B39
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 17:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B297F40807;
	Thu, 15 Oct 2026 17:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNCge0sBbWeP; Thu, 15 Oct 2026 17:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5DFA406E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792083800;
	b=Sb2OI9iEyK4pw/Wmhu9Mey0tRe+8kD4ICrxgGa6CbjIFFilkMUsi1Wa2NsLULjs9K28u
	 jHB1VIWUT/gF26dY77ja63d5IxCswJ4J7MRRYISwQnb0y4JocGsNC58I1c04A4oP9pqAx
	 Ys2joCXa1SE8VgOGTVFfHlDQ2IhYeRzYAN1EOZhIcY9oCJO4OkHZCGYmEW6aUoCmZ9y+8
	 uq6wjgUiqRVBC7naas34Ndk5WawIe6osgXtzpE2ZXaQ1Ievv9K+q51oG5bObu5ii8LISR
	 +IzqUc6DIQwbAPn2vaJr+puPcSf3un5ILjCtc3ux7HVrEiTRbKFYHWjkmZY/cij7khA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792083800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XE2SS2u8PLeXkyQyDlJy73nltGLsGgh8XeDlA6l9s3c=;
	b=iE5fso7DXwET2gY85U3Q/sEE6o7/r6UswX063kAW2p6O77SP6guqG3wzTeV5VrplYIGo
	 vOegG8FjZHzAYDjsd/ts7h2NGMXh+rjaHNhq80BuFWIZqrtzFEDmx1lXzgw3mlfKC/MA4
	 pUeNvdVHaBhb8Vzmjg4yNeoy0BlttcD5inDqxFGQHB8Nrv3mVnAsDY2lVkSZKAd5ehFTZ
	 0XdL5nRrgzzg5urLG46c7y7xbY5pYL98sN/ayYRoIFl5j9UswFc53Hp4SkgVMyaGvzyaZ
	 7HyqkBjFfxA9W2Gf2UdMJMvgiJhPqVEXo6g/+2OQ9+dHopJMbdAaQfFz+kFU12pIGOg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792083800;
	bh=XE2SS2u8PLeXkyQyDlJy73nltGLsGgh8XeDlA6l9s3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D25S+OQi9BtTvJHcSQPr2Ty84NHMRk0cfK3woa0DB/K77BNlmMywzJEpkEaSr5aUb
	 jYo7PkAGgppS+J07C4oceOd43d1cXCmLzZN89Vioxee8Zx1g906aWpemFpwT0qylfC
	 hQkcspD4nw/NoDFxm8pof6AjqOhKnyEqQoJYx+qNx5RbSOuyvwB1nsGEyRTBrN+EzI
	 nLSPUdMXEnELYCNWdAYOuAH2qLQzdNtYkrhDN3Wj+xDdYlVeKEN98JPyHr+3FfDvYd
	 T/yozg2GJYPkAbru/xKy0ORtQTlVdLu1z9K5Zg4fAa+fQ8cjfRyKjOSz11Xu2n+dQ6
	 mE61qpimxQMIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5DFA406E0;
	Thu, 15 Oct 2026 17:03:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB623263
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 17:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD4FA6086C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 17:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4Vj8gCR6tVj for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 17:03:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6398606CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792083798;
 b=CmCU3DSSvMRaZUvHlabTyyNwwV29eCv9OLRkYgdqNeD5rAO2JfFzwrRSoVXw7YnDbeQF
 V7TfIOrVdv1B39fM/qe6DurKbq5mdiijO1VtJ9HcXXOzsvoeYfJ4G43I8SRQoSq6j6AeY
 D55lcmlIme6XJodzbnf1c73ISfNxOyZrPDqN1PcqMKLsuo9F1g9XBNGpRLp2AY6yCuTLJ
 HbY7gfETLuya+KHnP6jAOdurLTP892r+vOVp/fjhS3MlJzKMYvRe7c6irc0xry44AuoxP
 Bh18xFSdayDDfT0UMNErZSNJU9IWXAaJnDXueMuMuzdJELDaC6bwqZST9LPTed0KsxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792083798;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=XE2SS2u8PLeXkyQyDlJy73nltGLsGgh8XeDlA6l9s3c=;
 b=LLDeAGhZkGR3tqC7xYXZKueK/Xofgn1wQd+fd6kw7uBDImNNprRWVDlE8IBACLP2Z8/5
 meQEUgWA5tqVydvLf0OST8S9dqtEeiNdyDQjXJ7R7pZe5zZFWIpOSjB1vWyBgR18ABTce
 KMQUgoDgBNkPgx3LwN7KaPJvwC4ROzgg3ele1fCoDaD80lLk8nLSvxlm9o04KNfQyGGYz
 V4vkTFQqm0K0Chp602d+9JdI9+MZnQngZrkuFRnxvMJTduFMMUT89qzmiiMnlwvb6zTR1
 ZrWGSq/1JREmXgJ4JhiNpV2ECokxLTEU+v1ctuDJqUzlDFXgRCO/UIoGlT1s151gyKg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OrRTgbL3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OrRTgbL3
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6398606CB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 17:03:17 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6de08b2e447so2439682eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792083796; x=1792688596;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XE2SS2u8PLeXkyQyDlJy73nltGLsGgh8XeDlA6l9s3c=;
 b=OrRTgbL3mfZ0MedseDq7P3X0bdSXd4/zp2SRx+pXCleHdgftxPRLd88tNfUDXxL9y0
 bv5Vi2X57csKrAMjAioUBIcatqoJKhW3yMQnDFuM6ri1tdrYFQMkER8qGA2zo/Ys90X4
 BaBZ3HA09GUd32xkl0XODF4El14fYQLYxlEl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792083796; x=1792688596;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XE2SS2u8PLeXkyQyDlJy73nltGLsGgh8XeDlA6l9s3c=;
 b=bHLbieTjHJNThES6KcqRq55usSnKw8DFSiaqDfni4r9zpi597IjTJbFAaKXHKOwR4q
 SUgQHG8quVrelf+iG/Oq4hzMvldfzVevpgHxTQcIMa2i8vCm3Nue55cPgrRPFOKmVlwU
 ZY75ELL3m5z5NONgKPKpoliL50K70J0p513xmftr7lB3aYqt1j/F7upuntUGfMEnGlB5
 YxHovHd1zcM0CsYTuQnRLLw0oQz6JTmlrkjhXnpRpKVfkmRpjJ9i/o62SUYAXIxA63TM
 xZgyQ+q7QMO2P1yR8raE1Ho0B3IG42HtpgD2jut0bogkcK7+lSWshd/fl8eyt/A/sRRq
 5rIA==
X-Forwarded-Encrypted: i=1;
 AKwUvByOi6zYcK0ajSx7nuyFJ9xPmanyN/cZ9rYts8tKjB0DvWN9TBuCf5jHXuPaks6/tgBrruSpAjc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLGnMV4Lhqc3Bv7uuYykmuucOsErodLP62Oc/PBdkjNuKNUlBFu
 gtDzXnb5R9ZJbNEhWGWY1w2wCiAz8g5RnrUdpbO5aft+atag+UALrW8MculJk36B2to=
X-Gm-Gg: AYBFou37uq2Fu+p+Jx+IL9KGuRYLJK3NBNwz2LxMwy01IvZZIcRIwV85CutzISnxk4k
 jlu9ARc3QPXXyepy4QzvlQKTe73Krq4tkJFgaPaRubsif6jn6B3mo5X6wDwPtYB0a3FIOnbSMDQ
 7hbE6Gv0ENjuwMlzYOq3DdRDz7etjBwP2pIvkDYIYf9zk25OVDFlI7U5akRWnRETFyOGiEKInZy
 gKmj3dJnjfLI/DRFM5ckqbnTzmj2RptnwyMeVoDNtg2nepisZWAmjDMLGMu0R5BtAt8KOK3EvFZ
 ppL2Pvdh9rmTujngpwpgmjtbiOtn3iDJGERQenR3byR7htuYYjUHR+my9ZO60/WcBSNV7wsVZcU
 O0t4oVdxqU2QA75oOnk6u+LbveA5yiK6Eknt9WhDknm4ZAqiqBV1CtOMzC1QzyXi/zfzkT+pCWQ
 fuRaGyenKp7nOZx1qyHKJGxGpFb/xh7U1U3PTruTuUXsVF8A3Zsv6OJuHRHdPdF1CvYMscK5+fJ
 Jp4EeS0/dalXl0FnfoOfwNqGf1edQETvnw9KlGaxO1IO68QrOfh8tL4NBZWsVnupQqPokvsQQfl
 61w+BrF80T36X8M6GeI=
X-Received: by 2002:a4a:e915:0:b0:6dd:696d:b21f with SMTP id
 006d021491bc7-6ef08e71c1emr14831481eaf.2.1792083794841; 
 Thu, 15 Oct 2026 10:03:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8424306dd20sm133479a34.22.2026.10.15.10.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 10:03:14 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:03:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Filip KokosiXXski <filip.kokosinski@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/8] core: skip parent device nodes without a DT
 reference when looking for dma-ranges
Message-ID: <20261015170310.GD259661@bill-the-cat>
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105615.1E6E668C4E@verein.lst.de>
 <20261015183907.50298c31@rocky.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qAyVp3MilOY2SYQq"
Content-Disposition: inline
In-Reply-To: <20261015183907.50298c31@rocky.lan>
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


--qAyVp3MilOY2SYQq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 06:39:07PM +0200, Torsten Duwe wrote:
> Dear maintainers,
>=20
> (PCI in particular, but also RPi5 folks)
>=20
> This problem is real, and I have exhaustively searched for solutions.
>=20
> Recap: device tree descriptions often stop at a bridge device node.
> PCI enumeration then finds a device hanging off that bridge. It will crea=
te
> a "bus node" named "pci@0,0" or the like, and connect the found device to=
 it.
> If the bridge has a non-zero offset for inbound accesses, dev_phys_to_bus=
, whose
> job it is to return this offset, will fail to do so in these cases, becau=
se
> it looks only 1 level up. One level up is the bus node, no DT association,
> so no DMA constraints.
>=20
> I found 3 possible ways to fix this.
>=20
> Solution A:
> search up the tree further than only one level, as patch 1
>=20
> On Fri, 25 Sep 2026 12:56:15 +0200 (CEST)
> duwe@lst.de (Torsten Duwe) wrote:
>=20
> > From: Torsten Duwe <duwe@suse.de>
> >=20
> > If a device node got created dynamically, there is no guarantee that the
> > parent node has an associated device tree node which could specify dma
> > constraints. Especially PCI(e) enumeration adds intermediate "bus nodes=
",
> > also dynamically.
> >=20
> > Try harder to find the correct configuration by walking up the tree unt=
il
> > a DT association is found.
> >=20
> > Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> > Tested-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  drivers/core/device.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/core/device.c b/drivers/core/device.c
> > index 6024534ff93..86d73b8222d 100644
> > --- a/drivers/core/device.c
> > +++ b/drivers/core/device.c
> > @@ -459,7 +459,19 @@ static int device_get_dma_constraints(struct udevi=
ce *dev)
> >  	u64 size =3D 0;
> >  	int ret;
> > =20
> > -	if (!CONFIG_IS_ENABLED(DM_DMA) || !parent || !dev_has_ofnode(parent))
> > +	if (!CONFIG_IS_ENABLED(DM_DMA) || !parent)
> > +		return 0;
> > +
> > +	/* Look for the first node in the parent chain */
> > +	while (parent) {
> > +		if (dev_has_ofnode(parent))
> > +			break;
> > +
> > +		parent =3D dev_get_parent(parent);
> > +	}
> > +
> > +	/* No parents have a node, bail out */
> > +	if (!parent)
> >  		return 0;
> > =20
> >  	/*
>=20
> Solution B:
> clone/link the bridge's DT node on bus node creation:
>=20
> diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
> index 4bdd1f7477f..af383475c82 100644
> --- a/drivers/pci/pci-uclass.c
> +++ b/drivers/pci/pci-uclass.c
> @@ -780,8 +780,18 @@ static int pci_find_and_bind_driver(struct udevice *=
parent,
>               find_id->vendor, find_id->device);
>=20
>         /* Determine optional OF node */
> -       if (ofnode_valid(dev_ofnode(parent)))
> +       if (ofnode_valid(dev_ofnode(parent))) {
>                 pci_dev_find_ofnode(parent, bdf, &node);
> +               /*
> +                * For devices enumerated dynamically without a matching =
DT
> +                * entry (e.g. an NVMe or a PCI-to-PCI bridge below a bri=
dge),
> +                * reuse the parent's OF node so the device still has one=
=2E This
> +                * lets device_get_dma_constraints() reach the grandparen=
t's
> +                * dma-ranges for dynamically-enumerated devices.
> +                */
> +               if (!ofnode_valid(node))
> +                       node =3D dev_ofnode(parent);
> +       }
>=20
>         if (ofnode_valid(node) && !ofnode_is_enabled(node)) {
>                 debug("%s: Ignoring disabled device\n", __func__);
>=20
>=20
> or
> Solution C:
>=20
> demand device tree providers always correctly add the bus node, maybe usi=
ng
> an overlay file or EEPROM.
>=20
> Solution A seems to be the least problematic one; it enhances U-Boot's ca=
pabilities.
>=20
> Solution B is more like the Linux kernel does it, but without allocating =
its own node,
> which makes it look a bit hacky.
>=20
> Solution C would be for an ideal world [TM] ;)
> Nonetheless we could at least for the RPi5 craft a DT overlay and send it=
 upstream.
>=20
> What do you think? Who is going to decide on this?

Is there a case where some other platform (and their DT, and not just a
convoluted counter-example) would only work with solution B and not
solution A? Otherwise, I think A unless Neil or Peter has strong
opinions.

--=20
Tom

--qAyVp3MilOY2SYQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatEHSgAKCRAr4qD1Cr/k
Cv4YAPwPKnqZkiaHqp14ov/4OpiAsBCZOpZXQWrrgOBJ7cZoGQD/QhOrpn8hYWPD
fz4aApJ8XeLly03kJd8zuBUPR1yiBwc=
=VEIK
-----END PGP SIGNATURE-----

--qAyVp3MilOY2SYQq--
