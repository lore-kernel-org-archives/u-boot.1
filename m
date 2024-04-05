Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF23FC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9D688488;
	Fri,  5 Apr 2024 10:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bDYC+bjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E74A88495; Fri,  5 Apr 2024 10:33:26 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99C1883EA
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4358XDY8037315;
 Fri, 5 Apr 2024 03:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712305993;
 bh=pF3DBCazql5RPyptK/tL2RbyumyrRkIYpDD4ZJcqIVw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bDYC+bjC3Iyc3INjNft4Gun19MsiZBcs42E/tQk2oESlTgmeZ57oF2D2Zw2vdGj0k
 A2C1M3S2fhrvjv+4Fl0x5nLCAPkNmosRK4ltimdz/ECTVBVabXrx8ZOFwf4BCryDtt
 MmxiXsTENz/95/zqx0mgOZwaENchvVOp+curbo+E=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4358XDV7100754
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Apr 2024 03:33:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 03:33:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 03:33:12 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4358X6Ux050849;
 Fri, 5 Apr 2024 03:33:07 -0500
Message-ID: <19f73ffb-9147-a865-ce80-57fc8a602bd5@ti.com>
Date: Fri, 5 Apr 2024 14:03:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/5] net: ti: icssg: Add Firmware config and
 classification APIs.
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, Simon
 Glass <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>, Christian
 Gmeiner <christian.gmeiner@gmail.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240404070803.2455207-1-danishanwar@ti.com>
 <20240404070803.2455207-3-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240404070803.2455207-3-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 4/4/24 12:38 PM, MD Danish Anwar wrote:
> Add icssg_config.h / .c and icssg_classifier.c files. These are firmware
> configuration and classification related files. Add MII helper APIs and
> MACROs. These APIs and MACROs will be later used by ICSSG Ethernet driver.
> Also introduce icssg_prueth.h which has definition of prueth related
> structures.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ti/icss_mii_rt.h      | 192 ++++++++++++++
>  drivers/net/ti/icssg_classifier.c | 376 +++++++++++++++++++++++++++
>  drivers/net/ti/icssg_config.c     | 406 ++++++++++++++++++++++++++++++
>  drivers/net/ti/icssg_config.h     | 177 +++++++++++++
>  drivers/net/ti/icssg_prueth.h     |  83 ++++++
>  5 files changed, 1234 insertions(+)
>  create mode 100644 drivers/net/ti/icss_mii_rt.h
>  create mode 100644 drivers/net/ti/icssg_classifier.c
>  create mode 100644 drivers/net/ti/icssg_config.c
>  create mode 100644 drivers/net/ti/icssg_config.h
>  create mode 100644 drivers/net/ti/icssg_prueth.h
> 

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
