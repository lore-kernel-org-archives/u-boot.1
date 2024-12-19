Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D01DE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 10:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CA98021D;
	Thu, 19 Dec 2024 11:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s1tABsFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03158022B; Thu, 19 Dec 2024 11:00:58 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4408B8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 11:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJA0hqc293083
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 04:00:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734602443;
 bh=hJ6KKxxfrkQcOmzzMLQTSE2ICmGqhmp4OxVK3XtCTlY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=s1tABsFvXdGMZxLaLEPYINBeRpP+XyUOVn+FW1c1B6iotyFZ4TMp58SB8SpB2SqoV
 t6+zc+/i36S98wftt+vASHm7BYBKwoD+UKtQoVZ5FH4zYgvT5sSBWSaWjrmzwt0q53
 SbjdfeWqPV1ml0PMXLiysllwh4lF/vgPzOmZuHSY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJA0hTX097459
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Dec 2024 04:00:43 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 04:00:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 04:00:42 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJA0fnL020049;
 Thu, 19 Dec 2024 04:00:42 -0600
Date: Thu, 19 Dec 2024 15:30:41 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <lukma@denx.de>, <n-francis@ti.com>,
 <mkorpershoek@baylibre.com>, <afd@ti.com>, <glaroque@baylibre.com>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>,
 <rasmus.villemoes@prevas.dk>, <caleb.connolly@linaro.org>,
 <j-humphreys@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 3/5] configs: am62px_evm_a53_defconfig: enable USB DFU
 support
Message-ID: <a5pjwm63owjbpn6h2wzqf7vbfov2sgm7qjxonoucydzk2rakvp@5tzi6iiku5jv>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-4-s-vadapalli@ti.com>
 <7ac41391-b295-4601-94e5-5c18090d65cd@kernel.org>
 <ymjr6iwzuo3dbh7iyhb42u7p3gwbpu2of47eunkax5zbjtarku@dfzyblcdhnp7>
 <8d3bc864-3181-424c-9941-cf44ec0ec475@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d3bc864-3181-424c-9941-cf44ec0ec475@kernel.org>
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

On Thu, Dec 19, 2024 at 11:38:23AM +0200, Roger Quadros wrote:
> Hi Siddharth,
> 
> On 19/12/2024 07:43, Siddharth Vadapalli wrote:
> > On Wed, Dec 18, 2024 at 03:47:20PM +0200, Roger Quadros wrote:
> > 
> > Hello Roger,
> > 
> >> Hi Siddharth,
> >>
> >> On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> >>> The config fragment "am62x_a53_usbdfu.config" which adds USB DFU support
> >>> for AM62x SoC is applicable to the AM62Px SoC as well. Hence, include it
> >>
> >> Apparently "am62x_a53_usbdfu.config" adds USB Host and Gadget and DFU support.
> > 
> > Do you propose that the Host configs should be moved into the respective
> > defconfigs of SoCs which include am62x_a53_usbdfu.config, while dropping
> > them from am62x_a53_usbdfu.config? Please let me know. This can be
> > implemented by a separate series if that is what you are suggesting.
> 
> No. The commit that introduced am62x_a53_usbdfu.config mentions that it is
> for USB Host and Gadget and DFU.
> 
> Your commit message seems to indicate that it is for DFU.
> I leave it to you if you want to update the commit message or not.

Ok. In that case I will leave the commit message as it is. It seemed to
me that you were pointing to the inconsistency between the name of the
config fragment and the configs that it enables.

Regards,
Siddharth.
