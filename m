Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0744D5AE41
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462BF83A41;
	Sat, 13 Dec 2025 15:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sKABpH9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C13830E4; Sat, 13 Dec 2025 08:02:36 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14578807C0
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 08:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVIF4aW0k2ctVVXpnleMRpeyqih8KAdnIXIdeZxsHQsBQJgYLXPsMMXs1aZyb5qPQUIjIYgoE934bpezYmY8j3lcnT04GgMutoaliXHRLKVX4SP52bvVnSO0LMpI0hzY94O8CSRMkxWloSAnD+1iMHZm/UqpeCNtmliT/EB9+vjCmXwUnN28A7xZT3iJoHSaK54mzykvKnhsTgek4gPAdZ+ArDQfqcaGDpsdDQewt7NawObS+F1E7n03M5grU/Xo+qTw22jRhl/a82pbTxAD95JyOX2QOW9hug0Oar7IMxxdFVKknCPiPMjpu69HOgXQHEqFKudC+WnJ5A514DY1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEHvvTK9njOOdKyyh7CSrDr03Spha92b0sNVV6JSj2c=;
 b=PBJ1cbjzAE8l6YKmvrZc0ofA+Nyb6NxzBTFVFFxoW+J3NSlnHKIC1h6yhQN8ITSjIPv/dCLqzSPM4/ayVLUrhnN9Le/1rpWKzxK848SrO7/upiu7yauBg/lIMK4oRL1susbzvPYGlB6DgqCRAtxvfPBHfQXij7tfX8gpc3xMUHuxxmZgcpOBmG+fsw1cI/8gexr2MKC7W5/A0IkBEEpGrhSdLzK9o97qExvCwCtUoif8GYbXVni52vZOAHS0TRuRJnt7brV5fOcio3NQsU4vY34RXi0NFN7EWRU7T8+eF7zaoK19KHnbZEacebNVh0+L/6DVXA/Vm19EspBxuNg7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEHvvTK9njOOdKyyh7CSrDr03Spha92b0sNVV6JSj2c=;
 b=sKABpH9YJHANOaDkbQoHnd1ouFnemGHXN04Y12qZtyLVR2FxTBz/zwcrHPlg5LgtYQwlaMAw3KdSfg20ue3L877Xw49acGCu68Ys9A8dB+B5oCAgd0dJmmp4BMr8LP1WgaKfDakDSnfwBGF2IewWHrpK45PPKgb4+K+ZaqOEP2k=
Received: from BYAPR02CA0072.namprd02.prod.outlook.com (2603:10b6:a03:54::49)
 by BN0PR10MB4998.namprd10.prod.outlook.com (2603:10b6:408:120::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 07:02:31 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::75) by BYAPR02CA0072.outlook.office365.com
 (2603:10b6:a03:54::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.12 via Frontend Transport; Sat,
 13 Dec 2025 07:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 07:02:30 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:02:24 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:02:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 01:02:19 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD728qK3398362;
 Sat, 13 Dec 2025 01:02:09 -0600
Message-ID: <2b05e173-7dc1-4c04-ae97-e74431766648@ti.com>
Date: Sat, 13 Dec 2025 12:32:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/13] configs: am62p_evm_r5_defconfig: Enable IODDR
 resume support
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Moteen Shah
 <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-13-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-13-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|BN0PR10MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f7b197-1a15-4758-8897-08de3a15951a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFBVSU5YRElNVEpQZmFHbnZEdzAxYWEydnZrTXZxMXEyR2t2ZUpNSGl3VWRj?=
 =?utf-8?B?U2pkTzRJcTZOTUlxaDB6ZzRoQXhIaEpJYU1xRFZ6a2JodFRuZ3IvN0dsOW9Y?=
 =?utf-8?B?b1IzdWNlcUk3QmdwclRrdlJtVkhVMStxZ3A2SEk4UlVMY3NBR1Rza01XSHZY?=
 =?utf-8?B?K1RBQjhETlNKQWpQOVRybU1nUmkzS0xkdWx4K3ZaOWJvUmdBQWZ4NHdRNkh4?=
 =?utf-8?B?NVVKdWdLM1lvNEZBbHVQejdUdlhuYnF0MVA0d0ozbVBaOEV4c1hyNXJaUmlD?=
 =?utf-8?B?RzJ5bWxiMFJwMi9odFlKRjZmcnVzb0lQQUUrOWFwUXovY1FYeUpzcjNoRWV5?=
 =?utf-8?B?cnVWSFpQWUc5c3dEYU1NVkNVNG9pbDhtMCtmSVpodzJqV2ZhTFh3Y2l0U0k3?=
 =?utf-8?B?QjdoQmpZZ1dKQ2J1UzlTWWQrKzEwNGp3cmpseU9sRnJhMTl3Y3NIdTJOMyt0?=
 =?utf-8?B?NVRhM2kyOFdvejNXcUJQOHBNZlJ2Vi83NUxnOUYyZWd1RE1MbC9jVDI2SGFS?=
 =?utf-8?B?YlI5Mk5yeUFtTTVhU1JKMENveE5IcEswRkRwSWNWWlBsblJySFIzYlkwbWNE?=
 =?utf-8?B?WjllQzc4TU0zMVRNMVkzTTJIOVJjQkNmQ05aakV2VWF3bjVZVmw3cmxTNXgz?=
 =?utf-8?B?cWtReEVJSzk1aFhnNWJmdnpkK3drNDV5RVFJWWJ4cEloWVk0WlE1UVZBdXZz?=
 =?utf-8?B?RDc3NitEaWUyZ2RKeGdSUkozZHdUQmpuSUIrQmtNcUpNZ2g3cHA0WTl5VUQ3?=
 =?utf-8?B?anV5UklxTGZLWUVqcjFkYkJkejFyOGxGZlk2NmxVOWNkdWkyNWkwNWNuN25B?=
 =?utf-8?B?ZEhRSTgwT0tVb1BLNjNmZVo5OXlnNkhzSmd3STJib0RpckVibU12OXJ2alhV?=
 =?utf-8?B?WlRYR1YzbnR2OTBVbTlsc1hPUkw0V0NiOGVOUitOcW1nazR5MVg5U1VCUW9t?=
 =?utf-8?B?SU5jSXRWYS9TREVwV3lkRlJOOWp5dnlSYlIvY0RtL3Q4eXVTbFZXWjZWaWZ0?=
 =?utf-8?B?TXNzOTcxK0I3K0RpZVl0cVo0OFZuZnEzM2lIOG1iUXl3Smx5c2lUR3l3RTk5?=
 =?utf-8?B?YzBXdS94NWoxR2xybWZWMnBnMUVUY0doK003ZE1Bbkd0Uk0rSEFIdU4yY1dj?=
 =?utf-8?B?aXQzTVN3VDFNK0Nva3cwYTFiL3M4VHFjOVNwRkFVR1I3N0VmbXN4VVNJNGRu?=
 =?utf-8?B?Um1POCtrcUppN09leHQxanQwWmtiNnJibHo0aXVyN1h2TGZlTStSczl5TFNm?=
 =?utf-8?B?M1BsU1IwMDFSZHcxOFBZciswZndTVmJRTmRhajhuNEdVQnRKYkh2M25GVjN5?=
 =?utf-8?B?Z3JOTkxreEg0bjdnOEdFMUdTY0NjeHFNaGJNbngxUnZ5YUVnOTltUDQ1OGJl?=
 =?utf-8?B?NkNlekxOTXhCMW54ZzVoWDZIdFR6YnhwK25veWFmcXZGNW0vYXBzNGpqUUFv?=
 =?utf-8?B?enBHd2daTjFrdVExekYwQ2tNWm5lcXhhK0R2aGJyVk9tTEs2VVMxNmlyWHBT?=
 =?utf-8?B?bTg2VWUrTlZpVkZXRXlwdTRUaUZSaTF4TGs2a3ExRnVhSlF3cVBlQVhwRitR?=
 =?utf-8?B?Z0kyWGlnVUhhemJDN1lqdXhtVm9EYzM0blVxeTVXOHIvV0lRYXB6RHA0UHQ5?=
 =?utf-8?B?cTU1aTRleXFEc1VBNFRCczdCWVdNVXVxby9tajNVc0Jtck4wS1FXQlpjbXQw?=
 =?utf-8?B?ZnhDWTBBU3BFb1JGMSsvWXM3a0F5bVRHdmxoWU9DeW9TQXhGREh4c0JWNXZN?=
 =?utf-8?B?VmJZSFJjMG5kS2ljTW9haXFIeW9PNEx1Y0hUdWNzNG9aY3c0S1B3K0d1QnQv?=
 =?utf-8?B?QWJ5YjlSSnpwTWZDNXpqTWRxMWE0WXFEY0JaWExDdHBVVjVhWVZ5Umx1TkRa?=
 =?utf-8?B?S2hEdXN5Y0xyS2wreU5PcHpsY0YyN3RRN1VBaFJTcUk1bWtwMzQwWC9ZbEFr?=
 =?utf-8?B?Mlh2RG9nNThhSE1TYTdBdzZpN1dWTWpFQ0RpNytYWkw4Zjg5bHZwUkszNW5I?=
 =?utf-8?B?eitMRHcvNDdCY0QwZm9TMms2N0ltNkw3dXhtOUtHM01JdGVYanIwTXhUTXNE?=
 =?utf-8?B?S293V3lDRFVUUHlmRDBmNGJMVXRkZTFrUU4rV3l3cXBxSHlQbDZxb1RQM2kw?=
 =?utf-8?Q?8Oho=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 07:02:30.1772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f7b197-1a15-4758-8897-08de3a15951a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4998
X-Mailman-Approved-At: Sat, 13 Dec 2025 15:04:07 +0100
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


On 12/10/2025 7:39 PM, Markus Schneider-Pargmann (TI.com) wrote:
> Enable K3_IODDR to enable support to resume from DDR after exiting
> IO+DDR.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Kendall Willis <k-willis@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   configs/am62px_evm_r5_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
> index c9592d7b6c4cc037a886fe81385791269a825aa3..39e8093597352e6ed3fb67ac59e0494239a51352 100644
> --- a/configs/am62px_evm_r5_defconfig
> +++ b/configs/am62px_evm_r5_defconfig
> @@ -123,3 +123,4 @@ CONFIG_SPL_TIMER=y
>   CONFIG_OMAP_TIMER=y
>   CONFIG_LIB_RATIONAL=y
>   CONFIG_SPL_LIB_RATIONAL=y
> +CONFIG_K3_IODDR=y


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


