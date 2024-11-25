Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E36D3B7DB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 05:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54ED1899BF;
	Mon, 25 Nov 2024 06:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JcePUyZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46929899C0; Mon, 25 Nov 2024 06:28:02 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184A689987
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 06:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AP5RtBw123390;
 Sun, 24 Nov 2024 23:27:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732512475;
 bh=b8CBryJV1bB+HE2GJWdb3+RKO0LZZGwPL6eQ20E8apo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=JcePUyZ2WXXVP0LAWllukxwuY3bGsO8NQZb7zpFpB5DDzkDMRNOaLRaFEc1XrqIhD
 EhGZFevgjs+8kBUJSMAH83F00OtmJvZSmTUib6rC2EqTjvmsihk7hP/Y2+ALUgx+ij
 lm007iLEtjhNG2EiwOr6iuZ1mtS7rGnDRNZAUskk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AP5RtQa038450;
 Sun, 24 Nov 2024 23:27:55 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Nov 2024 23:27:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Nov 2024 23:27:54 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AP5RrjV022019;
 Sun, 24 Nov 2024 23:27:54 -0600
Date: Mon, 25 Nov 2024 10:57:53 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <j-humphreys@ti.com>, <m-chawdhry@ti.com>,
 <rogerq@kernel.org>, <nm@ti.com>, <sjg@chromium.org>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <afd@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 5/5] board: ti: j784s4: evm: Set "dfu_alt_info" only
 if interface is Serial Flash
Message-ID: <ed5wsehr3ovr7xglukbukd7wvyrfsub6v5n7iylvaw5hqkkouy@u2yl4o2uhblm>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
 <20241124070828.617558-6-s-vadapalli@ti.com>
 <dc562c69-ccb3-494e-b5fd-5c016382879e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc562c69-ccb3-494e-b5fd-5c016382879e@ti.com>
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

On Mon, Nov 25, 2024 at 09:29:01AM +0530, Kumar, Udit wrote:
> Hi Siddharth
> 
> On 11/24/2024 12:37 PM, Siddharth Vadapalli wrote:
> > Commit a4d5e5daa847 ("board: sk-am69: Define capsule update firmware info")
> > updated the "dfu_alt_info" variable to support use-cases with Serial Flash.
> > However, this breaks use-cases where interface is not Serial Flash ("sf").
> > Fix this by setting "dfu_alt_info" only when the interface is "sf".
> > 
> > Fixes: a4d5e5daa847 ("board: sk-am69: Define capsule update firmware info")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> 
> AFAIR, DFU in general is not enabled on J784S4

Yes, it is not yet enabled.

> 
> Can i request to enable DFU along with this update.

This series is a pre-requisite for enabling/fixing USB DFU boot on
various devices. I will be enabling USB DFU boot on all TI K3 Boards,
but again, that doesn't have to be tied to this series and can be done
independently. This series is a fix, while enabling USB DFU boot on
devices is a new feature. So I don't think that the feature *has* to be
enabled along with this series.

Regards,
Siddharth.
