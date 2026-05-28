Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D38CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F16AB8404D;
	Thu, 28 May 2026 10:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PRcZKrbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A738469D; Thu, 28 May 2026 10:35:49 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AC580087
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INyzO2jWGPa/c231rZwQXM28Dw89OsrPT30aeZ+zqfPZKAp0iB/hrknUPoaNWJQgMDvG/x8sCjitZUbAGKiff7zYqK6Y7GgEB9y7QYtpV+9mV50IhTfK1uHyPVY7AcZxpcu5r9sAV4kZbz47fVCA25G3m9elJdftJESWXAbRuzBCgibAKQh4pLQi3Rh+MJXmnd834AMS7o1HfdwuSBlt2adwRKkXyiOB2X3tY+QfQO8Ng+oeCbqR1fjKoO3NKILESQnBalWN3c4sSnx0FAExhs7kSuPFrK7xvv0qhVU2U3Uwb7cJR0P7FRVHSV2J6C4qgFhewU1ws+0pgPTKvZha1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+C8ts+GWYRsqD4l7O5znDYHLjwPxQwZxsg+Ldq+3L8=;
 b=FA5xEJxP96BIbY7AO57KszVbtpmi9QP55lXp5MGASlRfJcbS24m856HulARCEdGa3hlYCqzUjLsy4MBmHSz/+E4fqAtM20LHjTGWSkmVjpjLdmNQoOdlNCo4pdnfjUTQx3KdmlQf6D//Q5rar5DVRH88vhiJatz83V8BMoJm4WD7xlgBYmrRz1DviwWUbGsakUXtF9HyGq/GPoy7bRD68STlZfbVY44RdjmSkgBGo8Mst2sIYJeJBqnBtFpzp2T2M3GGLbc6SQ9XKviWcZjutMBifoLi29OedQHo7QNJYSIWlMccUwZyuMeJ02CCwHamxm3QeREklwFcyRonQH922Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+C8ts+GWYRsqD4l7O5znDYHLjwPxQwZxsg+Ldq+3L8=;
 b=PRcZKrbf22EVOnBsqttuZ6bvKBcRRmhFaZIjJh4aN+O1YlLJGVujxPj4F2Eu4YBRp8G+fVlROuAMjFISjNta29V3PoReRgh0yZI7iW1gnuh2mQbXe27bbH9w4Wc1EWyS5GnnSEkURnGe6/mQ3CIXHgkgp2MHEsqTfjEHTaMQw9E=
Received: from CH2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:610:53::33)
 by PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 08:35:43 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::a8) by CH2PR17CA0023.outlook.office365.com
 (2603:10b6:610:53::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 08:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:35:41 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 03:35:23 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 03:35:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 28 May 2026 03:35:23 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64S8ZMTw1693560;
 Thu, 28 May 2026 03:35:22 -0500
Message-ID: <7ec4fc82-ab5a-40b0-ae7c-6f40f6481673@ti.com>
Date: Thu, 28 May 2026 14:05:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: hbmc-am654: Use dev_remap_addr_index()
To: <peng.fan@nxp.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20260527023726.3121176-1-peng.fan@nxp.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20260527023726.3121176-1-peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|PH0PR10MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 741f2dc3-3151-41a8-64e2-08debc941a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: OY/lJWmvzLkcPhyHL1F1vr7uMRT4XoBJ4FW5J9QPKCMp2faHpUpRBGObBRX5b9gojB6839rCsSVJGvcR+lGmfAAQdDN//xMcQjoR31D/G02z/Td1dVkfOBuU2sq5dWNhpSDRcTAwO/7XQdJNBROZWkX4SXVeSa5pF105Jlpl4nvZ6BlkZfC0oD4ARULX8fvFx4BQJmBMBvI6I0QweB8/OkBMavHLGItUSaklFrhMPXnOH0KZvTzyFM+SkFbTjmFiMLyJYt1GxP+rqCenF1QHrbW3oU5nuW03YSswiWLDqiBfPq9Roo3UkMcAqkxaCdlFBO+NooKz4wJtpcLLZ9cQT4tBnSxfGmiYvLFZ0qjiXX9dF77i0imoNNwWLcTrWZW28w8z08OADhyDKY75R60JhYTJf2T0+rg45Vq/y09mb47WuHiG4WKUAWK6CS2E6x1F2AINGYG6qEmQ7Tzp0IaP+acRFUEUMf2iUIHFh1GXAAFZ3cNEu38uM96RND5T3Md1VeHl0//f/gj5siXnvvb+O0cpn4vEQB3N5pNeYpvuX3/dmpLSQMmjuO+B/7WtRUNITo0RMrzKxga/O3k/Pb+Kbf9jFdtM+/NRAtHvPgQ7GVNHIHK+3Q8oDfBme1TumLch5ZaYKzgQdu/7s+rzlYbGU2tpPFtr+niMAaZ5388zycbCNrOa46CwVr7e8D0C94OVGsnR47K6ZbB/k/VkR/iHrOt9zWgOnumI7kRBV16eLHY=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FjfAMTnd1pTVGhcQbczfEMS78mgjXaUZ9O6bSFTgzNssqUXwA5DUiWUPcxn7TdxIJFvviK8vGhcVMnNsvKo9JgtRgL6PpaIjLxjtG5C++KwKzUaEN002a8qxyEvaca3bDyfo9taZMQI2Sv4R1POJVzegW1xzcM2GTSVyyieTDTktuxppIla7UnBFqUE477/CFPKHYdOE9vfyjuOWQScJaOpNiznxXsG4kUHyA22MwsYg5Klpvk77gg8kxEGJGtB+4105LQ1UIH7qluglDyNUj0CYSAW1x9Zxml8t0vbO2jfd39rF1NOdO30ZjXZOS68DPW1YA0gm0STxFYRV1glYLtQm8khsao+rNods779iuXP8qjPu8pYec1nAnKJsbfFWI4QB53xIEF+HXQ1eaj9Oeolvg5M9ipDi0Z7u8q1l9xq7NxoxN5GtQ87h4/5f9/0R
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:35:41.7235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741f2dc3-3151-41a8-64e2-08debc941a73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5777
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



On 27/05/26 08:07, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_remap_addr_index() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


>  drivers/mtd/hbmc-am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/hbmc-am654.c b/drivers/mtd/hbmc-am654.c
> index 98988a8e24d..1e71e91e0d1 100644
> --- a/drivers/mtd/hbmc-am654.c
> +++ b/drivers/mtd/hbmc-am654.c
> @@ -71,7 +71,7 @@ static int am654_hbmc_probe(struct udevice *dev)
>  	struct am654_hbmc_priv *priv = dev_get_priv(dev);
>  	int ret;
>  
> -	priv->mmiobase = devfdt_remap_addr_index(dev, 1);
> +	priv->mmiobase = dev_remap_addr_index(dev, 1);
>  	if (dev_read_bool(dev, "mux-controls")) {
>  		ret = am654_select_hbmc(dev);
>  		if (ret) {

Thanks for the patch.

-- 
Regards
Vignesh
https://ti.com/opensource

