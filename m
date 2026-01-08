Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3C5D185F3
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB90A83B87;
	Thu,  8 Jan 2026 14:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rwHiy9Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B6A84119; Thu,  8 Jan 2026 13:46:48 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azhn150100002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d91c::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E731983B8A
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 13:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPVxdelmg7tCm62dUIFK0wvG9/JGx0JsJG7NqOUBDBEfEvOBTNl+hwxtZWnJjeCG2ES1mu/lpa0/fwR8P7c0nwwUyzvcItUgpNta8hRjQLQhT7kBiqimRrkX9FhJcAPdBsYVqiV/tF01cthOnfg6bckh6Oo0kPFIRagMz8n6ik/9qQb04Uyx1OY5EVgsZl1CY4Ms3wA1B05S1xN2sQO6cspANRnOrQqT5aAxrgeNyR7spx8kLPKq4958i+Ox/ofYdXrJUygkv+bIjh3cVJvCmN2f5704SLxElV+tIVW5dsaekNsqsE6YcymkrmPxLYMn5XBFsIO7HVqxhvBDAr1vhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TYpP7Im375fQFYiQYMyMJ8/7HmEcJpsUxq/4RNGQvM=;
 b=ZmC4XeoE4SRecB5anumQCIuTZn/5tQkLnFuCQ/zL5Aa134lOOKILuzFOYsnK3yhqHaXucjT7BYZIzGO1s0qLgUkMcaFk41azZ+5f6sqAwh8mmGAGCwzkn4irjMeMqNOc0K5VWASmYGSCEE6bdynfhH3e689nAJYMWmQz4/YiY+KEv3thNwkzQW8RRA4fDtlnOUgmUR1VSL2DPEhe/Xw2MG04j/0PvIjg7piCGhjl8vLbnP6fADdH+CZgHNxdCiX3uoyV46p/E40LBI3HZ80yi+T9qmF97gM6mHQloY1hAnM4+TkaKpTvdu052rZgbsdkEtKhc6dZZjYuOtg9ibE3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TYpP7Im375fQFYiQYMyMJ8/7HmEcJpsUxq/4RNGQvM=;
 b=rwHiy9XcoNcV/Nn3zuZ6RC8wLR+5TI+uruCfHSBOBgO+DPatvl4s/imb8P2zaZn0qK0G159Wql7tyJtxQ0Bh1YQCm/NgH9HJfKxLCzKQ0f1Iw8r4eefo3ZxQNV7cWhQ7pe75Kc41O7wQhGHUqLDi93TgUsHRx6RlauQ37O5iauM=
Received: from BN0PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:143::28)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 12:46:26 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::4b) by BN0PR10CA0027.outlook.office365.com
 (2603:10b6:408:143::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 12:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 12:46:25 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 06:46:19 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 06:46:17 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 06:46:17 -0600
Received: from [10.24.68.91] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.68.91])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608Ck7hi2387193;
 Thu, 8 Jan 2026 06:46:08 -0600
Message-ID: <1a9f0176-9ad8-4a7e-8010-11940b968ffb@ti.com>
Date: Thu, 8 Jan 2026 18:16:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/13] arm: mach-k3: am62xx-lpm-common: Helper for LPM
 meta data address from DT
To: Andrew Davis <afd@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Bryan
 Brattlof" <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal
 <anshuld@ti.com>, Moteen Shah <m-shah@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Nathan Morrisson <nmorrisson@phytec.com>, Garrett Giordano
 <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, Aparna Patra
 <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, Prasanth Babu Mantena <p-mantena@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
 <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
 <a5fbd8b4-03a0-49c4-b071-742364880081@ti.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <a5fbd8b4-03a0-49c4-b071-742364880081@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e472a3-a46d-458a-f9bd-08de4eb3ef39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|34070700014|36860700013|82310400026|376014|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmc2eDV0c3BUeWdsOFNJV3VVZGRrb3kzcmtDOTRWWTc4WmZ2cFl4eFhtbUcx?=
 =?utf-8?B?OHdFNlkyNXl2RFFxUloxNDFWTTRybHh1S2ZNVW4vTXhTakVmaGNlWHhvUTA4?=
 =?utf-8?B?YkExUWQ3YktjclVyWFpvRW1nTldzUVErQ2lEazFMMk1KRUNSL2pWR2tFTTFW?=
 =?utf-8?B?bXlQNGFwS0VIaHY2Y0lWMmF6Wk9xR2hlK1F5bHZwNUlVVzhIWnlkZHdkNXZO?=
 =?utf-8?B?Rm90VU9uaWxUdEoyT2liZ1lhWlNGcFZyUFVNNVprNU1BQWJmaTBtK0FDdXhK?=
 =?utf-8?B?dnBZUTBacm5VWGEyejEwZnhlbGxqNitKRk1sUW9OVDJqY243blZEdDRucUdo?=
 =?utf-8?B?TW1QLy9wdDhkOS9JczNqUE9zWjJLcjlvNFFIU0E3Zzl6SjA1SmRxWkxIY2gr?=
 =?utf-8?B?Tzh3S0luWVZHVWtRbzAxbzcyd1lxa0VZNDZ4V1Q1RDVkREoyMU9GNVhIRjBF?=
 =?utf-8?B?dVQ1R25ITXBaR21pQXdWUFJZb2VyaEJ4cFNzcmg4MjNtamtTd3B2RmlYNWJL?=
 =?utf-8?B?VkFBb0UwK0g2aEh1VXAvVE5sMGxjZm5zUk1OU2F3cW9KUGtiR3RzdlZ5K3kz?=
 =?utf-8?B?NzlucXBjRDRqeStHZmJsRlFEcm50M3JrZE0vVWMxUUpmSFZ2alBaczgwOTNu?=
 =?utf-8?B?ZXZ5V2JVcHJFVnBBWTgxdURtbS8xZ2k3WTVHQWhOSnozVmJ5aXFRQjdXNit3?=
 =?utf-8?B?Si9EQ2hNMEJKYmVqWlhXS1dISlF1aFVsTFduNnp2bXNXRVlOMWxRZ05YTVpS?=
 =?utf-8?B?TFo3enA1Rmh2c3JaUGl0dDY3ZGR4MmFMdnEzVW85eGNQekJXcVUwRkI5VW9Y?=
 =?utf-8?B?M3d3b0kvdGZNTUQwdEVJcGk5MDJTRE42Z3VCWWV1ckVJbXErYzVmNnZ2TWhy?=
 =?utf-8?B?STh6Y3g1aERvT2lVYVcxTS9VU0I4aHlSWXFscHFRMUtnaUYzTURqQVViczdE?=
 =?utf-8?B?SGdibGgzRTc0ODZadzJNUjJzbVdSUm8rQU5acVN5dHQ4Nnd2WElIendUZWV5?=
 =?utf-8?B?RFF0ZEpsd3k5QktFYm9sNmFMLy9CV2FDNmNHQ0tOcE5Kc0RBWmV3ajBiTG9v?=
 =?utf-8?B?d0x5bFNnSjJsL1hHeU9sS1pxcWpxb1MzWStGT0VONTduUmpubFlUZXBJMjNG?=
 =?utf-8?B?cHgwQnhlSHZJUkQ5N2l1VHRLSy9lOXBxTDMxc3FzbWVVWW5YaEdpb2xWN3Nl?=
 =?utf-8?B?alBkaTd4L2JXMU5VSjJyYmZBNHoxbUZveHR4TFAxbjFySFd3amg4YzR5UURo?=
 =?utf-8?B?OFphS2dCcW5za3ZlTFVJR2d0V2JmTUZMQlFMRi9CMUdERCtDbjhXa2hVQlZK?=
 =?utf-8?B?SDVXWEZoT3JXZVB6UkVrcHNBYXkzdUlrM1RSUDkrQlpSVjVWYXFkNzVmYlNq?=
 =?utf-8?B?S1VSRnF6WHpxZ1B4QVcyRnpzYUp4SElmS0dsUVJudzlWTXBaYVM4cnI3MnNG?=
 =?utf-8?B?aVVsTnp0QkdseG1TTkNuWEZJOG40N2x4TXhTOWFkQkMzeCtlRzlVRWx1ZlFY?=
 =?utf-8?B?dzYwUUxYb2xnYktLVTRLby82R09CNXJhUVQvd2REbDJic2FyRlR4ZjNjUUZK?=
 =?utf-8?B?ZTh0Zm5LZ1JEMGc1R29iV2N5SUtVd04vRm5iNkNHeGRQSktueGxDalhiZ0ps?=
 =?utf-8?B?aEcvQ0t0ZjlIbm00c1c1MXVqblc1RExDOEZESkhGTVloYnFwVWk4R1RzU25a?=
 =?utf-8?B?RE9UdXROazJHVE1kR0I2Z1pRQTUwTzZFRXhWUlNxZTVranphMGc5UEhYUDF2?=
 =?utf-8?B?dS9CSG1tTEFZMFhoUXZqOFkzcURHdHMvWHBmVW9FdGJiMGlMZHhjVW9Gb0xY?=
 =?utf-8?B?dUxHZm94VSs2c01iUVh5bXhLWjVaaE9WL1o1K2pSR09jWDdFODRybXJMTi8y?=
 =?utf-8?B?QU50Ky95U25KRnZKOG1tS0R0elU1WkhUSGpDaTlaUThId2xRT2E5K3J6RkZa?=
 =?utf-8?B?UUVuUUtpMGQ1NkVIWDkxNlZFNEVmcTRTVzBSc2tLWXhubk91RlJDWEh5dmVF?=
 =?utf-8?B?eVVla0pnY3dJd3hBUWFiOHFhSmNQc3VldjFHcVVlNnBsVDZTMUlLcVRvVEVK?=
 =?utf-8?B?WnRFMS9UTVJtN1NkYUtKa0h1UUpzNCtUaklhQWpqT2RBQys4MFlKMmY5M3Y1?=
 =?utf-8?Q?rjFE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(34070700014)(36860700013)(82310400026)(376014)(34020700016)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 12:46:25.1706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e472a3-a46d-458a-f9bd-08de4eb3ef39
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:32:53 +0100
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

Hi Andrew,

On 06/01/26 22:53, Andrew Davis wrote:
> On 1/5/26 10:38 AM, Markus Schneider-Pargmann (TI.com) wrote:
>> Add a small helper that uses memory regions referenced by the R5
>> devicetree node to calculate the LPM meta data address.
>>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   arch/arm/mach-k3/am62xx-lpm-common.c | 45 ++++++++++++++++++++++++++ 
>> ++++++++++
>>   arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/ 
>> am62xx-lpm-common.c
>> index 
>> fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e 100644
>> --- a/arch/arm/mach-k3/am62xx-lpm-common.c
>> +++ b/arch/arm/mach-k3/am62xx-lpm-common.c
>> @@ -9,6 +9,8 @@
>>   #include <config.h>
>>   #include <asm/arch/hardware.h>
>>   #include <asm/io.h>
>> +#include <dm/of_access.h>
>> +#include <dm/ofnode.h>
>>   #include <linux/soc/ti/ti_sci_protocol.h>
>>   #include <vsprintf.h>
>>   #include <wait_bit.h>
>> @@ -48,6 +50,8 @@
>>   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT        0x18318
>>   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW        0x555555
>> +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET    0x108000
>> +
> 
> Could this offset into the R5's second reserved memory area change based
> on the firmware used? Actually this whole thing feels hacky. Why not
> just add the location to DT explicitly instead of trying to derive it.

The offset value of LPM Metadata in linker file will always be relative 
to the position of DM's reserved memory region in DDR.

Reference: 
https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L169

> 
> Actually, don't we pick this address as part of the 
> TISCI_MSG_PREPARE_SLEEP?

This is not done as a part of PREPARE SLEEP message. As DM is the one 
reserving static memory for LPM, it is already aware of the address 
where context needs to be saved.

> Or does DM do it now, either way there must be some better way to 
> coordinate
> between DM and R5 SPL than hardcoded offsets..
> 
> Andrew
> 
>>   #define CLKSTOP_TRANSITION_TIMEOUT_MS    10
>>   static int wkup_ctrl_remove_can_io_isolation(void)
>> @@ -126,6 +130,43 @@ int __maybe_unused 
>> wkup_ctrl_remove_can_io_isolation_if_set(void)
>>   }
>>   #if IS_ENABLED(CONFIG_K3_IODDR)
>> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
>> +{
>> +    struct ofnode_phandle_args memregion_phandle;
>> +    ofnode memregion;
>> +    ofnode wkup_bus;
>> +    int ret;
>> +
>> +    wkup_bus = ofnode_path("/bus@f0000/bus@b00000");
>> +    if (!ofnode_valid(wkup_bus)) {
>> +        printf("Failed to find wkup bus\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    memregion = ofnode_by_compatible(wkup_bus, "ti,am62-r5f");
>> +    if (!ofnode_valid(memregion)) {
>> +        printf("Failed to find r5f devicetree node ti,am62-r5f\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = ofnode_parse_phandle_with_args(memregion, "memory-region", 
>> NULL,
>> +                         0, 1, &memregion_phandle);
>> +    if (ret) {
>> +        printf("Failed to parse phandle for second memory region\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = ofnode_read_u64_index(memregion_phandle.node, "reg", 0, 
>> meta_data_addr);
>> +    if (ret) {
>> +        printf("Failed to read memory region offset\n");
>> +        return ret;
>> +    }
>> +
>> +    *meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;
>> +
...

Thanks and Regards,
Akashdeep Kaur

