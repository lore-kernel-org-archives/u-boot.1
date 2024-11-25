Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63056D3B7F6
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7A789A0E;
	Mon, 25 Nov 2024 11:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA80189A08; Mon, 25 Nov 2024 11:00:18 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91AF89A06
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4AP9xupx049734
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 25 Nov 2024 17:59:56 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 17:59:57 +0800
Date: Mon, 25 Nov 2024 17:59:57 +0800
From: Leo Liang <ycliang@andestech.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Kongyang Liu
 <seashell11234455@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal
 <miquel.raynal@bootlin.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: add device tree for LicheeRV Nano
Message-ID: <Z0RKnfpS5d4I5QbG@swlinux02>
References: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
 <20241112-licheerv-nano-v1-2-bf75d1eb560e@bootlin.com>
 <ZzsQb-QO2YrffjeB@swlinux02>
 <D5QFYNC0TNVT.11K9SURYSS7W1@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <D5QFYNC0TNVT.11K9SURYSS7W1@bootlin.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4AP9xupx049734
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

On Tue, Nov 19, 2024 at 09:35:32PM +0100, Thomas Bonnefille wrote:
> [EXTERNAL MAIL]
> 
> On Mon Nov 18, 2024 at 11:01 AM CET, Leo Liang wrote:
> > On Tue, Nov 12, 2024 at 03:57:37PM +0100, Thomas Bonnefille wrote:
> > > [EXTERNAL MAIL]
> > >
> > > Import a slightly modified version of the LicheeRV Nano and SG2002
> > > device trees from the Linux Kernel. The current supported IPs are UART,
> > > MMC, Timer, PLIC and CLINT.
> > >
> > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > ---
> > >  arch/riscv/dts/Makefile                   |  1 +
> > >  arch/riscv/dts/sg2002-licheerv-nano-b.dts | 45 +++++++++++++++++++++++++++++++
> > >  arch/riscv/dts/sg2002.dtsi                | 34 +++++++++++++++++++++++
> > >  3 files changed, 80 insertions(+)
> >
> > Hi Thomas,
> >
> > Could we switch to use OF_UPSTREAM ?
> >
> 
> Hello Leo,
> 
> Thank you for your review, I have a question though.
> 
> The LicheeRV Nano device tree isn't upstreamed yet. It's just in the
> Sophgo SoC maintainer tree and should be merged in v6.13 so in ~10 weeks.
> Can I keep it out of dts/upstream for the moment or should I merge it by
> hand before ?

Hi Thomas,

Got it! So there should be a follow-up patch that 
switch to OF_UPSTREAM once the upstream LicheeRV Nano DTS is settled, right?

I can take this patch as is for now. Thanks!

Best regards,
Leo
