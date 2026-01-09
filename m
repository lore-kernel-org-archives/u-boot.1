Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB59D26D85
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3083283C72;
	Fri,  9 Jan 2026 19:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U9RaJ/DC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFECE8436C; Fri,  9 Jan 2026 18:07:21 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazhn150130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d918::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8F584206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 18:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1DA8XrFKTxOM0PLu614WO2XihHunYVttH+qvSf50oSerbFb90A/wa5q0uyE3vv+e2dBqR5TMsCn1pOAt13uYoFg/iTtAhkPmAMAWdCOY5bd5RoQIGBoqiyTTlWYxqV590Ft7vWTnauMqyrVN33bQMe06EQ5CK6fZ+OXJdQKyQfZekFn4CYkwA3OH4ztCEc+20yE/z28ufDH7BXA6w7ZaL62EGFBcyRCleU2aDUzPS4SuqWBPleuJK7KkY77/TazzvlbX43putAtKdkxOLMGfn9aaiEwcBqkCRESOMv/8Gwcwe4eZ/KXF+/ZFDx5F0j7RuUKDI+0pWcBLKRRSm2PMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHZrINx2hULrqTNFEZKm7YgdhY/Bq/RrKgqDm1c6/gU=;
 b=w/ZspRfJJm+ZpJEOpeToQDyDDPDPnXBS3uVStn/6FWdRTmQ1y6vQn4LRGuOdnsehPyYvf0pyEBvg3TFv5Hs5fbfSWHcZMzFc1jZ1MCkkox/s0Ww560bu7qgICtooVpbzqdsaTZcL/MBKSJYkDKRVYmFlzkv7AtKhGfe7f1YsCB2HMGRzwtiLufDolAlorpBmJedZusZzOuoJjk2MpHyi+AVgkm+Ry+0uayr9chIr8gjlYIXDK3TOJ1kATFxW0hPuRYlHV7uPom8wS4uGZZ+2YKXP70OE79JmCfn3TDTWBQum7tJ5rNE0xhpQwdXcd4kq+Yv50td73P4IkI0BbhBgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHZrINx2hULrqTNFEZKm7YgdhY/Bq/RrKgqDm1c6/gU=;
 b=U9RaJ/DC6o5QvbVTfmYuH79S69s0UA7Qq2mSo+loQrcHiJ4dUh0MrRU1L0U7KHcZdEKY2gTPDdIG4q52lpdVg2QkC0v2HiWSWDgx1WYKEhf2qHSGxL1iOg2vMykFKjF9BQEritenWhmEz93pPjhM1V8vCFd1X5jplGmyZlbBMuY=
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by PH5PR10MB997734.namprd10.prod.outlook.com (2603:10b6:510:34c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 17:07:15 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::fb) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Fri, 9
 Jan 2026 17:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 17:07:14 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 11:07:12 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 11:07:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 11:07:12 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 609H7B1A380957;
 Fri, 9 Jan 2026 11:07:11 -0600
Message-ID: <814c211f-a9eb-4311-bb84-165b1a69755f@ti.com>
Date: Fri, 9 Jan 2026 11:07:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/13] arm: mach-k3: am62xx-lpm-common: Helper for LPM
 meta data address from DT
To: Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: Akashdeep Kaur <a-kaur@ti.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Vishal
 Mahaveer" <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Sebin
 Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Moteen Shah
 <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Chintan Vankar
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
 <1a9f0176-9ad8-4a7e-8010-11940b968ffb@ti.com>
 <20260108143944.c3opoz57n6tyje7b@bryanbrattlof.com>
 <20260108155132.x6fcqc5zahftvcba@bryanbrattlof.com>
 <20260108162703.ovogvs6xcjgewyyh@lcpd911>
 <20260109131802.woj2w7sjonntngjp@bryanbrattlof.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260109131802.woj2w7sjonntngjp@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH5PR10MB997734:EE_
X-MS-Office365-Filtering-Correlation-Id: 4737fb99-fda6-4f9b-1529-08de4fa1896f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUJtR3g3cVQvdTBKOVcwY2RFemFadXZJbk8vTkdnekdmZGhoMmxsQXdKT0JE?=
 =?utf-8?B?dHo2b21hcExHaS93UW4rZjdVRXVGL2tKSkE5M1MxY04rUlpnMlVFWUs1VUVk?=
 =?utf-8?B?ZUZiUCsrd3lYN2NCRnRhYllzSXFpM1V1NDN1WDBDSEd5N2JUd3l4dHpZMkJS?=
 =?utf-8?B?M1NuUTRTd1MrQjFEcjZtNXlLaEx1cXZ1Q2pTc3BFck1JcGEvL3U3ZnA3Z25y?=
 =?utf-8?B?Q2pyNTZOdXcySDFXcTQ0VlpBUU12VHlLdDNETTlDcGxIR0gyYm9ocFVwa0kr?=
 =?utf-8?B?WTZydkJhUklwUlFTN3ZuTzRwOE42VVo1dm5jbWEzZ0ZZc2t0eTd1dFhmTFBP?=
 =?utf-8?B?cVVicTlZays0bzN2T25STTdaeXpvN0N6c0xuRHU2bnRFSFBtb1l0cjlLSEds?=
 =?utf-8?B?cVc1c3VpR3l2a1MwL0dzY3h3cHNZUnl1UXFPSWpKVGx1MkNJT3NoYmo0czlL?=
 =?utf-8?B?cW9tMUdKODBRbDlXR1h0UXluUyttWDJlTUxsQlZDbDJMVmhRbTlrc1VkZVVh?=
 =?utf-8?B?UmdLMjU1YkIvN0hPODJuYWFZMExNRUR1bUVJajI0dVljQS9HTDgyUEdHZHBY?=
 =?utf-8?B?bm5wQlQxNXBET2tGdWJYSzZ3MzJDL0hzUUJLUUFwbHNoblNCdDhsWi9VT1Zy?=
 =?utf-8?B?empsdm9rWHVqTTNPQUJYaWtCWDl3RUx5RU1KTDY4TjQxRzNJN2ZYTHgwRnJT?=
 =?utf-8?B?TmhDZ05BUUcrejNyNEJsbnN5TlJLVUp5a0xhbkpCSXM5c01Mc2t3SWZieE5y?=
 =?utf-8?B?Y0tydStMcEhUK3NldkRRWXFNZWVheUYveit5VTAwT3FFN3I3akV4WVo0N2ZB?=
 =?utf-8?B?QmpUcUNOSFd4U01Ic0lVZFhzZTlqMm5SeWorWXZrb255ODdONjArVG5rVDg0?=
 =?utf-8?B?OEN6dngwbXBIbHJIUHNiOGRibU1QakpMdFJXRTVmREZUSTMvbys0aVIrbVlV?=
 =?utf-8?B?d1JPSW9BYTZidG5nNE5NRGZUQVNZeExHN2EwQXRld0dzUk9BaTliYUpMZmpY?=
 =?utf-8?B?WWtldS9aU0RrNFNxK2djcUV2MFZuL2NiaWxQTEwzWE9lVXJ6UVkrb1NiZ29V?=
 =?utf-8?B?WTZLUlQrcVEzRHhLWElnck9RTFVnL3h5djdzSm84UzNuQlc4TUhRQWgwaWps?=
 =?utf-8?B?RHlRVHBQNndJUEg1azJ5UWVGTFZpZnU2K0JPeE1xTnBHY0JHMVp6cnNnZTlq?=
 =?utf-8?B?SktneFlnL0dOb3U4QnN5QlJVSmxIYjNVY2FsOVdIazNqaHkvRG5WV1BTcmVj?=
 =?utf-8?B?aWJiTGxsQXdRLzJzTG1VaDlMbnM4a3NBWjBBd29jb3dTZ0JjTkh0YmZvc0Fl?=
 =?utf-8?B?eUtPMUJUaFBKL0U2WEdya0JIbGUzSTRwSFA4SHREQnRnVHFaeGdXUzI3OWxm?=
 =?utf-8?B?OTFJa3ZlbnFubENHQlhIaVJIWDhhVlFxN2U5SXZBcG1VMkptNFR3MGtLSjFx?=
 =?utf-8?B?U294YWJRbFJpSE1uWDhqZms5VC85ZDZHMkhEcjVaTWQ5S2lsWVVSQjJsY2s2?=
 =?utf-8?B?QlI2dTNzcGFSQUxaYW14R0Q5dDhBRTh3M2RJeGFTMmgvY2hibTkwUUZZVlNM?=
 =?utf-8?B?cURyTHpoWUFTZGpWaXhWZDMrekRlNDg1c2U4ak44bUhERTE2VzRTZkZtajlm?=
 =?utf-8?B?cEdhZVdmcVpLQ3Y4amFUUlFobFFFa0tBWlViNFBDOHdVNURiZ1h5LzlGUnhp?=
 =?utf-8?B?ZnZ6bmtMdzB1NkJTM0NBdUp0QjVKNXd3TkdNWSt3ay96ZkRzNFAwTFNIdENv?=
 =?utf-8?B?L0tiVm9vdEZHV25WRndjd2ViNllXWHFvUVVzajZQNWtXNHl2WTBCb2dZRFNK?=
 =?utf-8?B?emo2L0RKejA4VFFZb2t1cVpVZS9BYkhzOXd5SUs2NnlaQUNRdFhnQVF1VkZI?=
 =?utf-8?B?OW8zc0hYSjBub3VFOFphaG0xek94b05neEJnL1B4bjFOaG1rSTkwWFozMUNC?=
 =?utf-8?B?czkvYmZtbWZJU3JwT2c5WU1oZTdqMGpnL0Vkc1RNcFl4TlVQMUNYQjloRWxh?=
 =?utf-8?B?TFB1QVhsckNMRSttdy8zVlhkN0hBSkxIU2hxc1lyQytkcGlRZm1XL005Y0Y1?=
 =?utf-8?B?NnNRSThwUXhqR3VQTU1FSzJ0LzhWalRYZy9KTUFPcFFoRlVhaXlNNWRFT0Vz?=
 =?utf-8?Q?sIz8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(34020700016)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 17:07:14.6080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4737fb99-fda6-4f9b-1529-08de4fa1896f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997734
X-Mailman-Approved-At: Fri, 09 Jan 2026 19:36:35 +0100
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

On 1/9/26 7:18 AM, Bryan Brattlof wrote:
> On January  8, 2026 thus sayeth Dhruva Gole:
>> On Jan 08, 2026 at 09:51:32 -0600, Bryan Brattlof wrote:
>>> On January  8, 2026 thus sayeth Bryan Brattlof:
>>>> On January  8, 2026 thus sayeth Akashdeep Kaur:
>>>>> Hi Andrew,
>>>>>
>>>>> On 06/01/26 22:53, Andrew Davis wrote:
>>>>>> On 1/5/26 10:38 AM, Markus Schneider-Pargmann (TI.com) wrote:
>>>>>>> Add a small helper that uses memory regions referenced by the R5
>>>>>>> devicetree node to calculate the LPM meta data address.
>>>>>>>
>>>>>>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>>>>>>> ---
>>>>>>>    arch/arm/mach-k3/am62xx-lpm-common.c | 45
>>>>>>> ++++++++++++++++++++++++++ ++++++++++
>>>>>>>    arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
>>>>>>>    2 files changed, 46 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c
>>>>>>> b/arch/arm/mach-k3/ am62xx-lpm-common.c
>>>>>>> index fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e
>>>>>>> 100644
>>>>>>> --- a/arch/arm/mach-k3/am62xx-lpm-common.c
>>>>>>> +++ b/arch/arm/mach-k3/am62xx-lpm-common.c
>>>>>>> @@ -9,6 +9,8 @@
>>>>>>>    #include <config.h>
>>>>>>>    #include <asm/arch/hardware.h>
>>>>>>>    #include <asm/io.h>
>>>>>>> +#include <dm/of_access.h>
>>>>>>> +#include <dm/ofnode.h>
>>>>>>>    #include <linux/soc/ti/ti_sci_protocol.h>
>>>>>>>    #include <vsprintf.h>
>>>>>>>    #include <wait_bit.h>
>>>>>>> @@ -48,6 +50,8 @@
>>>>>>>    #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT        0x18318
>>>>>>>    #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW        0x555555
>>>>>>> +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET    0x108000
>>>>>>> +
>>>>>>
>>>>>> Could this offset into the R5's second reserved memory area change based
>>>>>> on the firmware used? Actually this whole thing feels hacky. Why not
>>>>>> just add the location to DT explicitly instead of trying to derive it.
>>>>>
>>>>> The offset value of LPM Metadata in linker file will always be relative to
>>>>> the position of DM's reserved memory region in DDR.
>>>>>
>>>>> Reference: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd#L169
>>>>>
>>>>
>>>> Does this work currently? Linux today doesn't have these properties in
>>>> the Wakup R5 node and from these linker files[0][2] they look hard coded
>>>> to addresses we do not have a carveout[1][3] for.
>>>>
>>>
>>> I'm sorry I hit send a little to quickly. This is starting to make sense
>>> to me now.
>>>
>>> DDR and DDR_LPM_DATA is covered by wkup_r5fss0_core0_memory_region{}
>>>
>>> and DDR_IPC_VRING_LINUX, DDR_IPC_RESOURCE_TABLE_LINUX,
>>> DDR_IPC_TRACE_LINUX is covered by wkup_r5fss0_core0_dma_memory_region{}
>>>
>>> Can we use those nodes?
>>
>> Yes, and that's kinda what we're doing :)
>>
>> *meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;
>>
>> The meta_data_addr comes from one of the reserved DT nodes.
>>
>> r5f-dma-memory@9c900000 + The offset 0x108000 gives us what we want.
>>
>> Is this approach acceptable now that the idea of this offset
>> is clear, and that it's not some independent address on it's own that
>> we're #defining here?
>>

Who is "we" here? The MCU+ team making the current example DM firmware
are part of TI too, let's not act like they are some outside force we
just have to live with their decision to hard-code this..

Nothing is stopping us from telling the DM firmware (at runtime even)
where to put the LPM saved data, or we can have some mechanism to find
it from the DM firmware itself.

> 
> Yeah I don't think I have a better idea. It looks like quite a lot of
> stuff in the MCU+ toolchain is hard coded and incredibly brittle. This
> being so brittle and hacky is an unfortunate side effect.
> 
> I wish there was a better way :/

Zephyr :)

It isn't ready yet, but Zephyr based DM firmware isn't an impossibility.
And many of these limitations will no longer apply. All I want to do is
make sure we do not bake-in the brittleness and random hard-coded offsets
into U-Boot, especially when it may not even apply to future firmware.

So to solve the problem today I'd suggest, instead of assuming
r5f-dma-memory@9c900000 + offset 0x108000, make a new DT node specifically
for storing the LPM. The address of the node can be the same as firmware
hard-codes it today, here you just read the node address directly. Then
should that node disappear someday, U-Boot can go down a different path.
This gives us a way to identify that future situation, while also just
being less hacky IMHO than using hard-coded offsets.

Andrew

> 
> ~Bryan

