Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F373E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 05:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728558021D;
	Thu, 19 Dec 2024 06:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f6pf6bho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7164C80241; Thu, 19 Dec 2024 06:43:49 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA5D8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 06:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ5hTqr122775;
 Wed, 18 Dec 2024 23:43:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734587009;
 bh=5TomC2g6Supk3RLlZm6shOTOgxRZo9XgLzsvP0stu7Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=f6pf6bhoiAjSFxtHpIlK30QoXR3S1X0yk0B7NjAqt8rbk6+KorpHsiHnvkyMtdyfV
 6d5UH/qTQjt43y4ddkUDTDdXyj7MbuL/wxZns0bSTM8TQAqF1/eej1nsJd+XXSZTUZ
 Dg/9su/ykFrQS60rKlxlBQyPqc9K72a+eTzFwCBU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ5hTSs015813
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 23:43:29 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 23:43:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 23:43:28 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ5hRE6024858;
 Wed, 18 Dec 2024 23:43:28 -0600
Date: Thu, 19 Dec 2024 11:13:27 +0530
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
Message-ID: <ymjr6iwzuo3dbh7iyhb42u7p3gwbpu2of47eunkax5zbjtarku@dfzyblcdhnp7>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-4-s-vadapalli@ti.com>
 <7ac41391-b295-4601-94e5-5c18090d65cd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ac41391-b295-4601-94e5-5c18090d65cd@kernel.org>
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

On Wed, Dec 18, 2024 at 03:47:20PM +0200, Roger Quadros wrote:

Hello Roger,

> Hi Siddharth,
> 
> On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> > The config fragment "am62x_a53_usbdfu.config" which adds USB DFU support
> > for AM62x SoC is applicable to the AM62Px SoC as well. Hence, include it
> 
> Apparently "am62x_a53_usbdfu.config" adds USB Host and Gadget and DFU support.

Do you propose that the Host configs should be moved into the respective
defconfigs of SoCs which include am62x_a53_usbdfu.config, while dropping
them from am62x_a53_usbdfu.config? Please let me know. This can be
implemented by a separate series if that is what you are suggesting.

Regards,
Siddharth.
