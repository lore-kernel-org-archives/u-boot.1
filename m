Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B839ECFA46A
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 02:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77258144A;
	Fri, 21 Nov 2025 03:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dgjgXk4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6548405F; Thu, 20 Nov 2025 23:21:57 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF78F836D1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 23:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=k-willis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSB2y/okIEFW074LE8YiTE28tq9PnmFbTU1xT0u7dOppFH2vmjxrxXcHxjftNHoCXJtDbxs5B1CLqQ/kDdKUzmmf1gEBpUnoSfu6VNLTkR8gbMgHmpLJJk9YXsfCTLvHahH0oB1h5bwRtQQGjDGF+mdbgeifyP9skk+47NvBBvc8w8PEgAJxTL0SyWROi16GgH3IxwoC8oUIdRpw/NBqoTqlj+X0h8+XYdN4GQGxkiBNFu71OOAgU9sJ2Qrp+2p54/Lq1YuRNKqCiQkM9M2fe8aCfVFBN1UxRS5LlgkL+enXI1uvqi/Zkl2dTK1F8gczFiyL1A/+HeXgVKfJekJncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK8FKVEGkL2RMEWyTt9dShSYc3PmK5GkmYyGFRAJ59o=;
 b=BkuqFVVt2RI97kGzouQzVc0xVXjCNH083NzgyMaXp5aMc8sOkWP1jSFLfLYMpV3y+707azptC/6dJEV+pclKQ31pl9ib3oMS7NmfcIcihwTa/dTcG3nLDpI49BfoPtLzkrVTIfnOr230tweepx/Hj3arK3m7KX0fUa0Yu81qs1MLVAQ/xqdLdt92PkPwaCfZbhWoKSMNZEWryrrW5fU2AwtmgLcORlzIwrlPcvfX1Ns6aO/NgLKlVUh9lVSLRpCVIki8shX5WhA5gEI+K/RzJ4OCTUcblXM0begEAhRsGY7o81+HQvLRL/VzvHrTZDMe5PtQQqU1luyU8c5ghXriXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK8FKVEGkL2RMEWyTt9dShSYc3PmK5GkmYyGFRAJ59o=;
 b=dgjgXk4Mb8aP1tn9yJsjT1l6tMLmohy3pmMI6KUUsxj1zTQXwFQsoZWhDqBQfQmVw5RQo+kAstbF/9TE1wZsDKRdR2VEJ1V4ZgYc5ct8ab4/3vqK8S8ET8/TPJR/t8/UNxEy+8LIC6nFoLbUu8NR8tiCHahdgMMIucB+/7945iw=
Received: from BYAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:a02:a8::37)
 by MW5PR10MB5875.namprd10.prod.outlook.com (2603:10b6:303:191::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 22:21:45 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::82) by BYAPR03CA0024.outlook.office365.com
 (2603:10b6:a02:a8::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 22:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 22:21:44 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 16:21:37 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 16:21:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 16:21:26 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AKMLQTp217295;
 Thu, 20 Nov 2025 16:21:26 -0600
Message-ID: <b2684e30-3f62-43ae-89c6-07841f86ffe1@ti.com>
Date: Thu, 20 Nov 2025 16:21:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/13] arm: mach-k3: common: Helper for LPM meta data
 address from DT
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-7-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-7-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|MW5PR10MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f848723-b9f9-48a9-a3a5-08de28832ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|7416014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnBEWUlNOW5xTkloNXV0TWMwTnBQcTRrTFNrNjRRZCt4ZnpmNEQvYys1cDZy?=
 =?utf-8?B?cEtOUy9vV1phdUJkUVpWWnFOQzJrcEhWQXdYZE8wajJlbW9CQVZWRTZaSWdn?=
 =?utf-8?B?WjRVSGdkSW4ycHoxVVpvZzVKMHVmTFc1Wk50WHM1Wk9kaXY0SmhmNVFkbzdh?=
 =?utf-8?B?UTZSQTZvVThTajhxVlg5cDNKTzRaUmx2a2doUFNRUzBuRXhQR0E3YVl2NFlq?=
 =?utf-8?B?ZGl3Z2d4WjBhNUpDanllZ3BSSXV5d1FJUmI5YVpDZkVvU2E5RGdhV3NzWTJZ?=
 =?utf-8?B?cDUvVmJvdGtLUml5VThodXdtZFVUempHT1FyMjd1Sjlqa1kxV3BBRVJ3MGky?=
 =?utf-8?B?QStXaVVoMGh3cm5oMXRUWEc3WWhVMitJUzNjdVJOWDZwanVUUnl3OGVKa0lG?=
 =?utf-8?B?Mi9hU21hV0ZUMnVwKzRDOU5mNmtxcnlIRmtKSWY1dHYrNzlTaUJkbnA0cG1a?=
 =?utf-8?B?ZXptcnFUN2lYcktwT2lIZzlZMWFvVVlQUDBvRElkcGJLdFd6YWs1VWlsMWhF?=
 =?utf-8?B?UmRqam1sa2RjYlVsOUwyRVR4NFd5VDJIbzFmeFBsaGtsMGlKMXhuekZUaEpB?=
 =?utf-8?B?QkYvQ1k2M1d2ek5nejlHUjZrbnVIUHRNTHE4K2FYakJ3MWVHRTJKbW50cU5X?=
 =?utf-8?B?TzNLZlhoOXRaRkIzcHBlcTJkMDQzK2grNURvZmlOUlZrbW14NUxvRC9TNXJX?=
 =?utf-8?B?ZUtGaGRzTyt3dWtub2ttaFRYNGNDR1c0ZmcvaWg4N1phQTUrSzRIdzYxTEth?=
 =?utf-8?B?WEcrcGtmVTJKRVFqT3c4ell5WWZ5SGtEWGNqVzJnWjlPcnZvS3pBUTNKSWEy?=
 =?utf-8?B?ZVcvZHNZQkgydEUzMkFieE9uYXZnUFp2VHVaTHlYZWhFb1YzMER6WjMxbk1C?=
 =?utf-8?B?YkxZZE1mZGFGOHQwOTJ2dTgvN1B6Wm80MjZ5a0VoUTBrT1lqRHBsaHJVdmFU?=
 =?utf-8?B?bnVKMWEzekNhbTZlZHBJbmZrYVNrYzFmTytuQk9rSllxWHUzVFVKMEFBOHF3?=
 =?utf-8?B?MU9SSXhlQkZYUEk5TmtxK2ZJUUxlZWM2akcwL2sveTBtVlM4YjQ1UWlFRklN?=
 =?utf-8?B?ZnVEQVBpbFh1N2VZaEg1V2xyd1VSM0FxakpVSFBrVmdEc3ZmWWZaRUtRRW9j?=
 =?utf-8?B?eFA3VzhpTVpCY0NBOUJZcGRXVVkxQVJnUGdHekNFSkhHTG5NWFZGZWJ1QlQ3?=
 =?utf-8?B?cTRhbnQvZnJxT1hWcHNublBFc1B2MzlPcytvM1BNYjZXaTcxcE8weVJxSVd4?=
 =?utf-8?B?aW5VNUMyYU5vaW9jNDdSdFh1dW9XVUZheDAvNTB3bWhqaVU2cmZFOHBFOTk2?=
 =?utf-8?B?MjFqUnZnallvYy9xT1krQklOd2Vnc0JQSEhOSHFEYlppMCtoa3Nhd29MMyts?=
 =?utf-8?B?bUZjWXNWZGE2UXh0SCtNamN4TFh6OWtveVJmU0wxaFJqVFJFckg2bmpvQkJV?=
 =?utf-8?B?NmVFS2JlcllZbDhSc000aGtCem5PQmE0ZnZwM2JwaFcxUS96Q2VMK1BrL1Uy?=
 =?utf-8?B?MWNmTTMyeVZNMEVzS2xPWVM2R2ZrdkZzY05kQThRN1B1VTFmdHNOajMwdUJx?=
 =?utf-8?B?OFpRMzV0RzBDQ3FoVnBoTXVlV1dzVFNYMUhGdTkva2RzYjJjcHhrS3B0T2Y4?=
 =?utf-8?B?OUNGMFZ1RzV4ZmpYYzhhWVRzSkhLSy9sdlp4SElmTVREeG9rYXF4WWs3TWdV?=
 =?utf-8?B?NmdVTnRLam9sTEU0YnZQU0I1LzhEeEFCZkhieDgzUTRxTTNpUWdYZjRYemRJ?=
 =?utf-8?B?UDR0N1ExOVVzUVJUbHdXcHduWDNCN1VRVG16em9qQ3RNU2xnTGw5bmNTb1Zq?=
 =?utf-8?B?YUZLQWUwbE1mRiswZjVlWVVZSVAvanhWaUY1WnozY0R1K21oUGpURHhSR2hj?=
 =?utf-8?B?SzNkVTYzZk1pbmNjRFRKKzRZeEFHSFFIUzZMSjZhNC9RYnRrcWZMc1JKa0NB?=
 =?utf-8?B?bzhEQ0RtZGswcEFOSkJSL25lUFY2Q2FyRk1UR3U1cUNQQW9iZXRCTGZlMm0y?=
 =?utf-8?B?cmYxK2pCc2E2ZkNPT0ZlK21vUzkzVmQwcE1xeTVzSjB1bVorRDVpb29MQWxH?=
 =?utf-8?B?Qm10cVNvQllwZkh6cm9qWVFac3hpUXdNZDl3UHBLNnYrcXo1a3pDNURhdits?=
 =?utf-8?Q?AtXg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 22:21:44.3173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f848723-b9f9-48a9-a3a5-08de28832ff8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5875
X-Mailman-Approved-At: Fri, 21 Nov 2025 03:09:02 +0100
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

On 11/20/25 10:03, Markus Schneider-Pargmann (TI.com) wrote:
> Add a small helper that uses memory regions referenced by the R5
> devicetree node to calculate the LPM meta data address.
> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/common.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-k3/common.h |  1 +
>   2 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index b28c2cd5776f29d75d54da9078e5fb17768d69c9..191254b391af68cb6c277f986069ed87211f2fc1 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -16,6 +16,8 @@
>   #include <linux/printk.h>
>   #include "common.h"
>   #include <dm.h>
> +#include <dm/of_access.h>
> +#include <dm/ofnode.h>
>   #include <remoteproc.h>
>   #include <asm/cache.h>
>   #include <linux/soc/ti/ti_sci_protocol.h>
> @@ -36,6 +38,7 @@
>   #include <wait_bit.h>
>   
>   #define CLKSTOP_TRANSITION_TIMEOUT_MS	10
> +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET	0x108000
>   
>   #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
>   #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
> @@ -191,6 +194,42 @@ bool wkup_ctrl_is_lpm_exit(void)
>   }
>   
>   #if IS_ENABLED(CONFIG_K3_IODDR)
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
> +{
> +	struct ofnode_phandle_args memregion_phandle;
> +	ofnode memregion;
> +	ofnode wkup_bus;
> +	int ret;
> +
> +	wkup_bus = ofnode_path("/bus@f0000/bus@b00000");
> +	if (!ofnode_valid(wkup_bus)) {
> +		printf("Failed to find wkup bus\n");
> +		return -EINVAL;
> +	}
> +
> +	memregion = ofnode_by_compatible(wkup_bus, "ti,am62-r5f");
> +	if (!ofnode_valid(memregion)) {
> +		printf("Failed to find r5f devicetree node ti,am62-r5f\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = ofnode_parse_phandle_with_args(memregion, "memory-region", NULL,
> +					     0, 1, &memregion_phandle);
> +	if (ret) {
> +		printf("Failed to parse phandle for second memory region\n");
> +		return ret;
> +	}
> +
> +	ret = ofnode_read_u64_index(memregion_phandle.node, "reg", 0, meta_data_addr);
> +	if (ret) {
> +		printf("Failed to read memory region offset\n");
> +		return ret;
> +	}
> +
> +	*meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;
> +
> +	return 0;
> +}

nit: Missing new line here.

>   static int lpm_restore_context(u64 ctx_addr)
>   {
>   	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> @@ -232,6 +271,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
>   	image_entry();
>   }
>   #else
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
> +{
> +	return -EINVAL;
> +}
>   
>   void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
>   {
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 3333b30b56e711b082d4da7f6773cf0002bbfe30..c579796a7a3baec12792ad137c5c03e7ea361d55 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -53,6 +53,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>   int shutdown_mcu_r5_core1(void);
>   void wkup_ctrl_remove_can_io_isolation_if_set(void);
>   bool wkup_ctrl_is_lpm_exit(void);
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
>   void lpm_resume_from_ddr(u64 meta_data_addr);
>   
>   #if (IS_ENABLED(CONFIG_K3_QOS))
> 

LGTM,

Reviewed-by: Kendall Willis <k-willis@ti.com>

Best,
Kendall

