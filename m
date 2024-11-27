Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEB9D609B0
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 09:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B97AD892DE;
	Wed, 27 Nov 2024 10:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PDXc/Qfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0029E893A4; Wed, 27 Nov 2024 10:05:31 +0100 (CET)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D2889046
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 10:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A744124000F;
 Wed, 27 Nov 2024 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1732698329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5otO2C67bAQEqVL5H6pT4uzkm4j06WU0iP/eLrL17lc=;
 b=PDXc/QfuMqUM7lQZ5kJ+q4COXi36/QO5JQU8nymH6NRicVPv58ds5/wqUZklZNo4jsXieu
 yS1A0YrdKpm5TxBNqB6nozvk9DBySYLRrWyHRDKS1UI+qdTroDdwciuIXYZw1UU77UWMYm
 8bQgkGb0fbEptpNZZO5cpOHLFwsrlhz2hKmwerWF3/261c01GpNaUP6sLT7+XH1d1lGF/q
 q5oO2G2z5iGqsgwnSJ0VmLBBzYp/Y3OA6+LYD0XgeK2mh4H5HjysYBhYWhx4/kTnMZyPdN
 GzojMIzHyx3WhNYunaXCv+zOxP4fZjGhNl2vb3Y/HILgrqwiuNRE1MqcL4QQHw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Nov 2024 10:05:28 +0100
Message-Id: <D5WUAN7HC5ND.1PMXQHYOO2PUG@bootlin.com>
Cc: "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Tom Rini" <trini@konsulko.com>, "Rick Chen" <rick@andestech.com>,
 "Kongyang Liu" <seashell11234455@gmail.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Miqu=C3=A8l_Raynal?=
 <miquel.raynal@bootlin.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: add device tree for LicheeRV Nano
From: "Thomas Bonnefille" <thomas.bonnefille@bootlin.com>
To: "Leo Liang" <ycliang@andestech.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
 <20241112-licheerv-nano-v1-2-bf75d1eb560e@bootlin.com>
 <ZzsQb-QO2YrffjeB@swlinux02> <D5QFYNC0TNVT.11K9SURYSS7W1@bootlin.com>
 <Z0RKnfpS5d4I5QbG@swlinux02>
In-Reply-To: <Z0RKnfpS5d4I5QbG@swlinux02>
X-GND-Sasl: thomas.bonnefille@bootlin.com
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

On Mon Nov 25, 2024 at 10:59 AM CET, Leo Liang wrote:
> On Tue, Nov 19, 2024 at 09:35:32PM +0100, Thomas Bonnefille wrote:
> > [EXTERNAL MAIL]
> >=20
> > On Mon Nov 18, 2024 at 11:01 AM CET, Leo Liang wrote:
> > > On Tue, Nov 12, 2024 at 03:57:37PM +0100, Thomas Bonnefille wrote:
> > > > [EXTERNAL MAIL]
> > > >
> > > > Import a slightly modified version of the LicheeRV Nano and SG2002
> > > > device trees from the Linux Kernel. The current supported IPs are U=
ART,
> > > > MMC, Timer, PLIC and CLINT.
> > > >
> > > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > > ---
> > > >  arch/riscv/dts/Makefile                   |  1 +
> > > >  arch/riscv/dts/sg2002-licheerv-nano-b.dts | 45 +++++++++++++++++++=
++++++++++++
> > > >  arch/riscv/dts/sg2002.dtsi                | 34 +++++++++++++++++++=
++++
> > > >  3 files changed, 80 insertions(+)
> > >
> > > Hi Thomas,
> > >
> > > Could we switch to use OF_UPSTREAM ?
> > >
> >=20
> > Hello Leo,
> >=20
> > Thank you for your review, I have a question though.
> >=20
> > The LicheeRV Nano device tree isn't upstreamed yet. It's just in the
> > Sophgo SoC maintainer tree and should be merged in v6.13 so in ~10 week=
s.
> > Can I keep it out of dts/upstream for the moment or should I merge it b=
y
> > hand before ?
>
> Hi Thomas,
>
> Got it! So there should be a follow-up patch that=20
> switch to OF_UPSTREAM once the upstream LicheeRV Nano DTS is settled, rig=
ht?

Yes, of course, I'll do that when Linux 6.13 comes out.

>
> I can take this patch as is for now. Thanks!
>
> Best regards,
> Leo
Thank you very much !

Best regards, Thomas
