Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DF6C87FCC
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 07:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02D882BA1;
	Wed, 30 Jul 2025 09:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IngtvIZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2F5D82BA7; Wed, 30 Jul 2025 09:40:38 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6041781FEE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 09:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56U7eJnE3196241;
 Wed, 30 Jul 2025 02:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753861219;
 bh=KwDdBEP5XJsJp1mJXjHBV1Uox/pjplDydBJHFT8/yrE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=IngtvIZ8wcml11mr2TE9FdvX7Ozrqd5lvfLVk1Ok6q9lKChNJALAPvDgTZVK/XLG1
 5up/BTVzEL7xkNYSiyb6/pzRIhrU4rRogP+ExJIZ1PsnDoaqInrdI5kh72IuZuWq6H
 L/+ozZqazgYJvq1jQ33sMG0RaqmB3+0f3MOZRflw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56U7eJ7l1742008
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 30 Jul 2025 02:40:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 02:40:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 02:40:19 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56U7eHT2882199;
 Wed, 30 Jul 2025 02:40:18 -0500
Date: Wed, 30 Jul 2025 13:10:17 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <marek.vasut@mailbox.org>, <quentin.schulz@cherry.de>,
 <kever.yang@rock-chips.com>, <alexthreed@gmail.com>,
 <ilias.apalodimas@linaro.org>, <pbrobinson@gmail.com>,
 <paul.barker.ct@bp.renesas.com>, <romain.gantois@bootlin.com>,
 <lucienzx159@gmail.com>, <skylake.huang@mediatek.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <nm@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3] net: phy: Support overriding Auto Negotiation timeout
 with env variable
Message-ID: <18f0b0b1-747f-463e-b341-e2e9fe1f19ec@ti.com>
References: <20250724141536.1222764-1-s-vadapalli@ti.com>
 <2ee1be9d-7c8c-4db2-a10c-bb9dd9e87d49@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ee1be9d-7c8c-4db2-a10c-bb9dd9e87d49@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed, Jul 30, 2025 at 09:23:25AM +0200, Jerome Forissier wrote:

Hello Jerome,

> Hi Siddharth,
> 
> Replying since this patch has been standing in my queue (u-boot-net) and Tom
> asked me to give my opinion.
> 
> On 7/24/25 16:15, Siddharth Vadapalli wrote:
> > The Auto Negotiation procedure between two Ethernet PHYs consists of
> > determining the best commonly supported parameters among Speed,
> > Duplex Mode and Flow Control.
> > 
> > The time taken for this procedure is not only dependent on the local
> > PHY used, but also on the link-partner PHY.
> > 
> > While a timeout can be specified in the form of a "CONFIG" on the basis
> > of the local PHY present on the device, since the timeout also depends
> > on the link-partner PHY, it might be necessary to modify the timeout.
> > 
> > To avoid rebuilding the bootloader for a given device, just because it
> > may be connected to various link-partner PHYs, each with a different
> > timeout, introduce an environment variable named "phy_aneg_timeout" and
> > override "CONFIG_PHY_ANEG_TIMEOUT" with "phy_aneg_timeout".
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> 
> This looks sane to me. Based on a private email thread where various
> options were discussed, I think that:
> - Modifying the tree-wide default value for PHY_ANEG_TIMEOUT is probably
> not a good idea. Sure it is a timeout not a delay, so increasing it will
> go unnoticed for board that succeed the negotiation in less time. But it
> will have an impact on boot time if it is expected that one phy times
> out and another phy gets activated for example.
> - Making the default different for TI boards makes little sense. This is
> not an arch-specific thing.
> - Therfore, allowing the user to override the timeout via an env var for
> very specific deployment cases  seems like a good idea.

I agree with all of the statements above.

> 
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thank you for reviewing the patch and sharing your thoughts, and also
for the acknowledgement tag.

Regards,
Siddharth.
