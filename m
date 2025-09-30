Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B66CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F178828A2;
	Tue, 30 Sep 2025 02:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="MvgDA0vs";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMmxEWuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF85683045; Tue, 30 Sep 2025 02:18:22 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E583F81D6A
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D2C95EC025F;
 Mon, 29 Sep 2025 20:18:18 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-01.internal (MEProxy); Mon, 29 Sep 2025 20:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1759191498; x=1759277898; bh=2nI6NbeP53ISovYvxPcY8101uLw9HWaA
 NH2DkpZiBvc=; b=MvgDA0vsO9j9tYR/hyaKqh2CgVUJIW+Ed7UgKc9IKg4YqAgP
 TVp8CLVFTPbAxHjob8bR8FnpaJyFCe2BjZ4XiT9nUQ5PBlFlAkyD61Ny0WpXGXhB
 KzPdwZf4i/Awp+RWETgCNkZOWtQ+pnRY1V+BQ8e8yaPG4eYnAzHRzHVlImwGROYm
 CLNZpOVcJAXNGNXx6r0SbD9z28vu9YUo66AYUoaTIEV4xHMBTh3/0CZUX1G5CjT7
 6Qao9vQGBCWlrsipG5nJg9ktfP5CljrJ/+w4Gz5xCEHOmzdyPh/eSsNjtJfOU2yg
 DT+lX/gFq5xTm1KGwvOHKVW8bPts1CLB/fdDcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759191498; x=
 1759277898; bh=2nI6NbeP53ISovYvxPcY8101uLw9HWaANH2DkpZiBvc=; b=W
 MmxEWuW2jVtqBldkGur75zwqQcP5AZfXafaJanLjJPfiLdS2xDKFc0aFV9Hw015N
 sQnnd0cCjv9hzO/6jlCn4u63L+gL8gm5lRMRchIEveNsD5DJBhGLAQjmpglTS/qv
 U1OEvpMVWsEIuZkwhC+Fseh4m16OuPAY80y0f21eY99pS7VcP7AOi1Zq84/FT5hM
 TPsJa1Gmnddggyh6JOppxbaCG8Zr9A9cSiPkoe2kyeWGg61xN/a7ZPwriyr4ZMhA
 y9h/pRoms+kHv/DR63CcFHRD/9wDKslhtMkozEOZOKdV7tqcypiJ8o8lnnEvVhjN
 7VNRQfXDof+tFr8GW0Qew==
X-ME-Sender: <xms:yiHbaFqixYR0QeLdyZayTcu_QrJ5KAriCc-n6zUV1e4tlEwuLVSp2A>
 <xme:yiHbaCfQiaquOklT2-GC6Qd8PRjdYnGheGlzp4IfYSdb1wzH-pqLlGbXpU7ZFg_Yd
 LAl07zpvhLHVE_RQzWNGY71GwJxJ1m321GohYjGePjt9O43Z07gs8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleegvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdforghthhgv
 ficuofgtuehrihguvgdfuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenuc
 ggtffrrghtthgvrhhnpeehgeetvdelffdtjeekhedtjeegvefhhffgueevveejkedttedv
 udfgkeetveetfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohep
 udehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkh
 esrghmugdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdp
 rhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhope
 grfihilhhlihgrmhhssehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheptghonhhorhdr
 ughoohhlvgihsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepjhgrmhhivgdrgh
 hisggsohhnshesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegrshhhihhshhdr
 khhumhgrrhesnhigphdrtghomhdprhgtphhtthhopehmrghnihhshhdrthhomhgrrhesnh
 igphdrtghomhdprhgtphhtthhopegrnhguhidrthgrnhhgsehngihprdgtohhm
X-ME-Proxy: <xmx:yiHbaM6MnJHkCOHKKdLVl_rwtFeDxVWRk_MBvwqXrDJTfz0ujIjLBw>
 <xmx:yiHbaIQcRp-PUB2fydLD8xyIVRNNuQdlAKb-yO5X0gjp0VUoDEsFGA>
 <xmx:yiHbaBlc7zxpI0UfFNDF6B_DOnTp35SBvO1dpNA0INpwkky5yTtAdw>
 <xmx:yiHbaMTQG68HH7ShFWANYOi5vSfyCtz_GW_QShHWkYoBLLlHzxOxJA>
 <xmx:yiHbaOl2fc_rT1K1wAUitLzbnTPvS2hlz_OF1yQEwYbmi2tyNTqt5VX9>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4E7DA15C008C; Mon, 29 Sep 2025 20:18:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ABIvpqsO4hGZ
Date: Tue, 30 Sep 2025 10:16:56 +1000
From: "Mathew McBride" <matt@traverse.com.au>
To: "Tom Rini" <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "Michal Simek" <michal.simek@amd.com>,
 "Pramod Kumar" <pramod.kumar_1@nxp.com>, "Tang Yuantian" <andy.tang@nxp.com>, 
 "Mingkai Hu" <mingkai.hu@nxp.com>, "Ashish Kumar" <Ashish.Kumar@nxp.com>,
 "Priyanka Jain" <priyanka.jain@nxp.com>, "Wasim Khan" <wasim.khan@nxp.com>,
 "Udit Agarwal" <udit.agarwal@nxp.com>,
 "Meenakshi Aggarwal" <meenakshi.aggarwal@nxp.com>,
 "Manish Tomar" <Manish.Tomar@nxp.com>,
 "Conor Dooley" <conor.dooley@microchip.com>,
 "Jamie Gibbons" <jamie.gibbons@microchip.com>,
 "Aaron Williams" <awilliams@marvell.com>
Message-Id: <6aa43496-d104-4e72-bde3-6c1f01507e23@app.fastmail.com>
In-Reply-To: <20250929224336.GS6093@bill-the-cat>
References: <20250929224336.GS6093@bill-the-cat>
Subject: Re: U-Boot PHY_MSCC vs PHY_VITESSE
Content-Type: text/plain; charset=utf-8
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

Hi Tom,

On Tue, Sep 30, 2025, at 8:43 AM, Tom Rini wrote:
> Hey all,
>=20
> As part of working on "allyesconfig" support I ran into the following
> problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
> implement support for the VSC8584 PHY. The vitesse.c driver is much
> older and only had VSC8584 support added for a specific Freescale
> Layerscape platform whereas mscc.c is modern and been updated with
> newer PHYs as well. And we need one driver to support this phy, not tw=
o.
> I am inclined to remove support from vitesse.c. However, only 4
> platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.
>=20

At the moment mscc.c in U-Boot does not implement the particular PHY mod=
el (VSC8514) that we use. This Quad GbE PHY was on a number on Freescale=
/NXP QorIQ (PPC & Arm) dev boards. Until 2019 Freescale/NXP was selling =
a licensed version of this chip ("F104S8A").

The Linux version of mscc.c does support these PHYs, so we can bring acr=
oss from that driver.
However, many PHYs in this family have complicated errata workarounds, a=
nd the VSC8514 is no exception.

I have made some attempts to "port" the mscc.c support for VSC8514 (erra=
tas included) before, but it's errata workaround method does not seem to=
 work as reliably in U-Boot as it does under Linux.

(I also have my own version of vitesse.c which implements the errata wor=
karound for VSC8514, derived directly from Microchips own SDK sources. U=
nfortunately it's too messy to submit to U-Boot, but it has worked relia=
bly for many years)=20

> I'm cc'ing all of the board maintainers (other than PowerPC platforms)
> that use PHY_VITESEE today to see what their feedback is on which way =
to
> go here. I'm ignoring PowerPC because that can just stay on the
> PHY_VITESSE driver based on timing of changes in git log.
>=20
I'm in favor (as far as board/traverse/ten64 goes) of migrating to mscc.=
c, it is just a matter of finding the time to sit down and implement sup=
port for the PHY I need (VSC8514).

Best Regards,
Matt

> --=20
> Tom
>=20
>=20
> *Attachments:*
>  =E2=80=A2 signature.asc
