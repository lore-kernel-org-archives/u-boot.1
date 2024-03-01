Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9E8C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 10:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8D58812C;
	Fri,  1 Mar 2024 11:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="scykq7Dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F18F8812F; Fri,  1 Mar 2024 11:16:18 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0780D88129
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 11:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 421AG5dC011605;
 Fri, 1 Mar 2024 04:16:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709288165;
 bh=0DJLEBfXsMmRAWH35hNbVGPRkPUkVWCCEfY53ZIQ1c0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=scykq7DzBU/zbDWvBtnl3djj6k6h/zMZJhof4pmJGqVchQFKzq/1W8Kaua01p85Ce
 n6oFivJ1gBjzeENqaKbDB3OcBWJR6K4hdzZ0DMU0gZ7VjbXgPMSygVU7vZc2sFNNRy
 A8Z7Zg1lTh91q/9c7ph79g51+nuSyA0QPAZ1dDpQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 421AG567062310
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Mar 2024 04:16:05 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Mar 2024 04:16:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Mar 2024 04:16:04 -0600
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 421AG0dF052384;
 Fri, 1 Mar 2024 04:16:01 -0600
Message-ID: <1c9eff98-3615-7779-3e47-8dc1df8a4573@ti.com>
Date: Fri, 1 Mar 2024 15:45:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] net: am65-cpsw: cpsw_mdio: Switch to proper
 DM_MDIO framework
To: Roger Quadros <rogerq@kernel.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom Rini
 <trini@konsulko.com>, <nm@ti.com>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <vigneshr@ti.com>,
 <mripard@kernel.org>, <dannenberg@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240228-for-2024-07-am65-cpsw-mdio-v2-0-f74f972eafeb@kernel.org>
 <20240228-for-2024-07-am65-cpsw-mdio-v2-2-f74f972eafeb@kernel.org>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240228-for-2024-07-am65-cpsw-mdio-v2-2-f74f972eafeb@kernel.org>
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



On 2/28/24 4:05 PM, Roger Quadros wrote:
> Add a new Kconfig symbol MDIO_TI_CPSW for the CPSW MDIO
> driver and build it with proper DM support if enabled.
> 
> If MDIO_TI_CPSW is not enabled then we continue to
> behave like before.
> 
> Clean up MDIO custom handling in am65-cpsw and use
> dm_eth_phy_connect() to get the PHY.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> Changelog:
> 
> v2: no change
> ---
>  drivers/net/ti/Kconfig          |   8 ++
>  drivers/net/ti/Makefile         |   3 +-
>  drivers/net/ti/am65-cpsw-nuss.c | 190 ++------------------------------------
>  drivers/net/ti/cpsw_mdio.c      | 198 +++++++++++++++++++++++++++++++++++-----
>  drivers/net/ti/cpsw_mdio.h      |   2 +
>  5 files changed, 196 insertions(+), 205 deletions(-)
> 

Tested dhcp and ping in u-boot on J721S2-EVM, SK-AM62B
Tested-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
