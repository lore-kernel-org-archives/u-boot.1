Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067FCE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 05:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48BAD8021D;
	Thu, 19 Dec 2024 06:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N/TQC4NQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7146C8022B; Thu, 19 Dec 2024 06:37:55 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E5C8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 06:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ5bgB0065898;
 Wed, 18 Dec 2024 23:37:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734586662;
 bh=YXoAhR3Nhu2FA3ncKVZxEX0G5uUziDIPWZswh9KSXDg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=N/TQC4NQOcaTp1aZEdo2zuzarXfUgeMhKW0y/Gjr3CTXfox1Y+oGE+E5rMQd8UcZ8
 eI08sQxk1NYzwwEQAaOr77RN/mT6i/vCseZ7TJ3+GcFIR1WuVTHUyhb+e4UY3CQ4AF
 Hny81Sscm7EAmcWJOpv/ws0nUb4F9rD1Lq30UMq0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ5bg2W116467;
 Wed, 18 Dec 2024 23:37:42 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 23:37:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 23:37:41 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ5beir018410;
 Wed, 18 Dec 2024 23:37:41 -0600
Date: Thu, 19 Dec 2024 11:07:39 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <lukma@denx.de>, <n-francis@ti.com>,
 <afd@ti.com>, <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 0/5] Add support for USB DFU boot on AM62Px
Message-ID: <ssafodrc4on6hu5pg5dejkqa6qow3mhv3cew5gwwwpnpxd77qx@46csgzd7zkr6>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <87bjx9w3ie.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjx9w3ie.fsf@baylibre.com>
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

On Wed, Dec 18, 2024 at 01:59:37PM +0100, Mattijs Korpershoek wrote:

Hello Mattijs,

> Hi Siddharth,
> 
> Thank you for the series.
> 
> On mer., déc. 18, 2024 at 18:15, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> 
> > Hello,
> >
> > This series add support for USB DFU boot on TI's AM62Px SoC which has
> > two instances of USB Controllers, of which the USB0 instance of USB
> > which is a DWC3 USB Controller is used for USB DFU Boot:
> > ROM => tiboot3.bin => tispl.bin => u-boot.img
> 
> >
> > v1 of this series is at:
> > https://patchwork.ozlabs.org/project/uboot/cover/20241217131658.2920799-1-s-vadapalli@ti.com/
> > Changes since v1:
> > - Dropped the first patch of the v1 series since its equivalent has been
> >   posted by Jonathan Humphreys <j-humphreys@ti.com> at:
> >   https://patchwork.ozlabs.org/project/uboot/patch/20241217204835.3312765-1-j-humphreys@ti.com/
> > - Based on the feedback from Mattijs Korpershoek on the second patch of
> >   the v1 series, the patches in this series have been updated. More
> >   details regarding the changes have been described below the tearline
> >   of the respective patches.
> > - Collected Reviewed-by tags.
> 
> I have tested this on the AM62Px SK EVM. I did *not* apply the
> dependency (20241217204835.3312765-1-j-humphreys@ti.com) and it worked
> fine for me:
> 
> I did:
> $ snagrecover -s am625 -f ./am62px-sk-evm.yaml
> 
> Boot logs:
> https://paste.debian.net/1340393/
> 
> Also tested that I could enumerate the board with "fastboot".
> 
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Thank you for testing this series. The dependency that has been
mentioned is for USB DFU *Boot*, while you seem to have tested USB
DFU *Flash*.

Regards,
Siddharth.
