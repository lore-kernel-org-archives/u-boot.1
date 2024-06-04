Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F02C25B7E
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 10:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206AA88479;
	Tue,  4 Jun 2024 12:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="4OdGNkgr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="CjnjtU2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3945688481; Tue,  4 Jun 2024 12:45:32 +0200 (CEST)
Received: from wfout3-smtp.messagingengine.com
 (wfout3-smtp.messagingengine.com [64.147.123.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E71E88476
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 12:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id A2B7D1C0019D;
 Tue,  4 Jun 2024 06:45:24 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 04 Jun 2024 06:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717497924;
 x=1717584324; bh=ZNfwGC5Y4XPdd51yUcKoRfmubdjIawQ1y2qrMaSMDX4=; b=
 4OdGNkgrK4VA05DxMGth4ZFZakk+ITnTLSZ0092cYa+Z9M1/Q6E8XK49cajjiZuI
 kfOD274NICcuO2zhBKN/AyCCMCg43xfR2COA82ONMQt+HQYDF7DT92gxlwpEajP1
 abt0qHVRMVohxQXuU6B1IJTi343WPogyRIX7pvLkcLvpIa06TOn5CepKBA6HDRw1
 HYgGSkEV3t1tsh21fRUFPapAY1fDqU69wlVIv63WkZjB0pwNKDcEAN1CpJvLcaD3
 EYkHxv49iY58fCevBOBPtR1aK/N+bbUGmUG4wGITgp8JHIjK55/dNBdwtIzhQ5Ry
 k2zVdOdLiX31YG4HFA2B6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717497924; x=
 1717584324; bh=ZNfwGC5Y4XPdd51yUcKoRfmubdjIawQ1y2qrMaSMDX4=; b=C
 jnjtU2dUSIYwuKVmZ9KKK6xqA5lbnsM/fqdVo30e3gABqA8rfz6Mw42092NFz3JG
 O2Q39mkCFiXX1gulJZMNGx/4kS7UTs2WRYeL4AyDFMJ7E0+zAPl7hvzEGOZYoiKo
 bRKXM5+PWZ3scxMMzZzAtUcgsNRCvuY3cjB1GQoornnUpAn/JIlMv9vFVd6oo99P
 iRZkScOx8iZ4+0FNpdhdwXBOCfPinVvKpCpYULr3sk+vTRw0lfK4y83qvqo/cuDb
 yvWM1FeNLGF+Epb/6MwyMYUDgLX5OLTq+jEh6Jzs/325UaMBvMLJDZsVBX6sEq2H
 +C1Hpf2qMKArEM88vRoDw==
X-ME-Sender: <xms:Q_BeZkWhw6EcixtMc4hhR0Zk3H0waL613VrVHglqi0oHcFiwvio6vQ>
 <xme:Q_BeZonEwWzRlVX4UEoppd6M-4j0uWf0uaIkJlQTu46CsvoKKLH71kabGIaBo2Ui1
 f4Lq1lowciV62fvN1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Q_BeZoYcwFgKBEa49L414lgg22VM2FBWloojnm6dVAKRi7xYqyfIPA>
 <xmx:RPBeZjX11yf7v8RYwQ7EMb1uSVYA5lyXYRSO5YBSxgMDGJM1FbL2ZQ>
 <xmx:RPBeZunJYDw6UvGMT8Zkgu5bTT8P3ARJ3R8vtdx6xC8eRwOD0dolPw>
 <xmx:RPBeZofqT1ybDB21oyixZ87BmLJPKiPGa_tw_XouxKxhkDKNGR_JFw>
 <xmx:RPBeZltwwEwGAT7EXmaA2D5HOpnNEKBSfTLvDa3hJ_uoIwX3JB8c55jx>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D81DD36A0074; Tue,  4 Jun 2024 06:45:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <a6bfb319-203f-4909-9548-b1a8d5bd5785@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2406010323210.23854@angie.orcam.me.uk>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-2-79096e3ca3b3@flygoat.com>
 <CAC_iWjKKyUm=4NJVuWgUqmFR43TNcuxFKmaBJLAFKC2CQYbxJg@mail.gmail.com>
 <7160e2f2-358c-4f3e-9865-1632ffea7975@app.fastmail.com>
 <alpine.DEB.2.21.2406010323210.23854@angie.orcam.me.uk>
Date: Tue, 04 Jun 2024 11:45:05 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 "Daniel Schwierzeck" <daniel.schwierzeck@gmail.com>,
 "Tom Rini" <trini@konsulko.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Subject: Re: [PATCH 2/7] efi: Allow runtime relocate to be disabled
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



=E5=9C=A82024=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=885:37=EF=BC=8CMaciej W. Rozycki=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, 21 May 2024, Jiaxun Yang wrote:
>
>> It's nearly impossible to run MIPS OS in virtual (or paged)
>> segment. All MIPS OS and bootloaders are running in KSEG/XKPHYS
>> segment, which directly mapping lower bits of virtual address
>> into physical address. So I suppose set_virtual_address_map
>> is unnecessary on MIPS because the mapping for U-Boot is
>> always here and can't be disabled in hardware.
>
>  Surely it's possible to run a MIPS OS kernel mapped via page tables, =
it=20
> is what KSEG2 and XKSEG segments can be used for with 32-bit and 64-bi=
t=20
> configurations respectively.  Both CP0.Context and CP0.XContext regist=
ers=20
> support placing page tables in virtual memory too, KSEG2 and XKSEG=20
> segments respectively, and a nested TLB refill exception is supported.=
 =20
> Only the TLB exception handlers themselves obviously have to be unmapp=
ed.
>
>  These features have hardly ever been used (original MIPSCO OS reporte=
dly=20
> was an example, perhaps unsurprisingly), but they are there and it can=
not=20
> be stated that it is nearly impossible to make use of them.  It is not.
>
>  Note that the MIPS architecture does not have a real mode, but its=20
> purpose is served by the unmapped segments, which are also convenient =
to=20
> use for various reasons by OSes that otherwise do virtual addressing.
>
>  Also for the record there are SGI IP27 Linux configurations that run =
from=20
> XKSEG rather than XKPHYS (running from KSEG2 used to be supported too,=
 but=20
> has been since dropped), via a wired page mapping.
>
>  I guess none of this really matters for U-Boot, but let's get the fac=
ts=20
> straight so that people who are not MIPS experts are not led into fals=
e=20
> understanding.
Hi Maciej,

Thanks for your insights!

I was trying to implement a mapped kernel on MIPS M5150 and faced many
many issues like wired entry + FTLB is not big enough to hold page table,
thus I came out with this conclusion.

Thanks for letting me know it's possible!

For U-Boot this is irrelevant as the main concern is whether KSEG0
is working after hand over control to OS. Disabling KSEG0 is impossible
without SegCtl.

Anyway, nice to have you here.

Thanks
>
>   Maciej

--=20
- Jiaxun
