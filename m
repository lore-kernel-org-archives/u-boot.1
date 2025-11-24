Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52A2CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EFA83DFF;
	Mon, 24 Nov 2025 13:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QG3msLC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E1483BF4; Mon, 24 Nov 2025 05:09:37 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF5C983B72
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpgAJbjXEEmUYtG3/GQqt7PzXF8k7IUxtwbYSeLtxwyZ8OkAfD1mjfWEpKaOZEx0FZgIuApxnySB2gMlROk1Kn4CDfxyYKnSVdaGo+FbR3nLL7lU62+0vHjeTpKRRCOCCMw7B62ZHlA4V2fCZfmz8/ukGcSnCop0aiGlsiVsDSn7Dk41KYCYvvG18Vj+oJgoNUWWPt2TyBI3BqAXBo47oGzJwgJAAoa9FMDl7VthWhgnD866xWD556FxS0lmoqyGAtJ/dJNVNtfdz9jFGevODYCxVU92Zq18GpO4+197TJJUh3jLW0lBC+x4swTTVl6aUox7n++6zsgbSrFjvpnSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U33n1ZEggnyxFXi628Un2hFgjWtE7+yQW67qHmtMzWk=;
 b=Oc6uvvQ/CRWBogFmPdXD4eCnGUKAw8jacbOzL+45Lq5G55JvPbqaXNU/qNBxw9EqobRliTBMqk8awjsLhSk+UJqablyyDqqkS/F2VIx3dEkcgsTz/YFYvdOKJ7+oWdQMWHDCdv8LLTeEHO1CmVGYA6gUwahHeWN3sR104lz3v3NHQaH7LzhJ9nVfYf9CmbpBnJuXz7hCwuxrrZDuLZGn3VUCLRzjoq027lObYbDwRAI0pHao7KDpeuAh8/NpGdfHhlJI/dH1Io6VpwCJA3hrFd8I0URtCTfP25BZ9/QIHen7D5wphIZ2IAuU91+abdSurP0oilyH8qlouOQvvXz+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U33n1ZEggnyxFXi628Un2hFgjWtE7+yQW67qHmtMzWk=;
 b=QG3msLC/WmkitCIEUJCsRO3T1cXo39X1XBIb0JgPqCUcKWSWUZKxDXD0V+wY2hAaM1DGjrOfQlOQGrbjVYZv7mMfFEyAfmmnnFn5d0BF/ZsifT14TNARF9rK5b5G2plLtnt5HDoQVauTIgezHYbOSnRKzUNlsrsjMWeHYWPi6z4=
Received: from MN2PR20CA0038.namprd20.prod.outlook.com (2603:10b6:208:235::7)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 04:09:31 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:235:cafe::8c) by MN2PR20CA0038.outlook.office365.com
 (2603:10b6:208:235::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 04:09:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 04:09:30 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:09:29 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:09:24 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 22:09:24 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO49EVh1263312;
 Sun, 23 Nov 2025 22:09:15 -0600
Message-ID: <a2fe0e50-3db7-4764-9591-c482af41b8f0@ti.com>
Date: Mon, 24 Nov 2025 09:39:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/13] arm: dts: k3-am62a: Add r5 device nodes
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
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-10-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-10-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3eb150-9a37-448f-5e98-08de2b0f4456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEFPTDJuRUkwSGRDQ3lUNjBrek9aRTBabittbWMxeFlsby9SRG0vS01wT2RI?=
 =?utf-8?B?Ym1XMkdOcTNqa0l3RVJLVGp5QzFieHd5c3NuTmJldm9DMTdVdGxpN0RrSjVo?=
 =?utf-8?B?VG1NaUE0V01pemFVcmtGN0xOSUR0bzIwaEhRSmFyV0FRdTZLc1Q2K1JYamR6?=
 =?utf-8?B?S1BiaVAvTklqS3dMNTZUeHlDUlNmWkVXdTh0c0w1SGFyVFlvbGpyckVyeWNy?=
 =?utf-8?B?YVVCZzd3Q09qZEY3a2FRQm1EQ3JIU25naFNlMWl6cHQvdWZ2ZHhUUHc1OXpl?=
 =?utf-8?B?WnViUGl2VisxV0hxaGlhTmRCRG5kNGtrOWdvOUVrRTZPd1dLU1E4aTdVUWRB?=
 =?utf-8?B?ZTF3YzJOdVJRbjBqdjFDdUJyZGpRTUE3Rkd4RVRrejRqNTBEa2ZtWVpCYWhF?=
 =?utf-8?B?NGVQWm1VNzhLK3BkcHdwcEkyQlpvSkVGWDRENEFJWmFXSWhkZzcwNFhza3c1?=
 =?utf-8?B?WklTUTQ2Z1Z2bXlwTEtFNzU1S0s0SmgxUjNwaVRhaDNqOTUvcGNUU3pDTWZp?=
 =?utf-8?B?anc5cVkxanlqd3hUUFd2dnZhWG11TVYydi9PWW5NaWRTbUJteTg2WWJaSkNB?=
 =?utf-8?B?ZGxybTdmTXFhMk00WFlyWHBTUksyWlFvZ1lYTVU1VkJTZGhKV3hraGE1eGUx?=
 =?utf-8?B?QTF3dHdEQmtCaElvb0ZmMVNiNDNvVEEzM3N2Smk1a05TNnVObGR4amZrM1dm?=
 =?utf-8?B?bm1NM0J2ZmszcS93SE0rM3VmamFVSzBjemlMeGhZQi9uRldSQWhZUmFMNW9n?=
 =?utf-8?B?M2hOY0JudkdZVHdTc0pjd3JPaTJpOVdscjl1c01TUHRMMlRTL1J1UWJuaDM1?=
 =?utf-8?B?K0xsY2N2ekhiVE05aUhteDhzcXg2SFBhd2d0TlUwV0ZxZjhUUERhOHhKdWdh?=
 =?utf-8?B?Zk9CZ2U3NzJtV2ZGNlJTRkhxWFI3Z0hseFNpT1YyeDgyclp0cGVBeFpBeGdv?=
 =?utf-8?B?enpTZE9MQlNXZTVWVWFLd2svOVpSSzdaaEVNcjRORis1UW1nRHRmRjEwMmR3?=
 =?utf-8?B?c1YzOXJ0NGpOUlpVK3RrUVFQZTRZU0t3U1hTamVpQVVKMkdlUU5pU3lYR3NF?=
 =?utf-8?B?dWw1RnRSa1NsU2ZROFdlRGRnc0V0OFVhV2hNcS9Za3g3K3hnMFBXb2FkM1Ba?=
 =?utf-8?B?ZUIxeGNrQUtVQWxOc05VVTQwbVRsb2MwMjBTaC9ZOFhLMnZIanpwczkvbVFV?=
 =?utf-8?B?ZVRtR2JwY2t2UnJpVE1jZUJYbHIvdUxheUJBaTFqWVRyZnFhN2h1ckJaTXpk?=
 =?utf-8?B?a0J0bjlWekJZdmxiM054MlNGT0RiQnhDdzR1Q3FHVlZZNjJybXFCZFUxMDh4?=
 =?utf-8?B?SUdTZ29pZ0lyVjJiUUlieDJmNnZaTlBmZ3FNS254Q3c4ZHJjcFVzd1hiWUsx?=
 =?utf-8?B?QTFDa1gySzV3OVJIWkhXdnlCV1ZVRGFxb1FNSWZ1aUhxd1lXT1FnNVl3aVZ0?=
 =?utf-8?B?cTBxMSt0b2VsakhiMHRDWjhUSlpsYUNoWi9IQUNZSXpjWTJvZmZOdlF5UUt0?=
 =?utf-8?B?dnd2RWRrY1VLZmFzamxoaUI0ZXoyT1JHRlpJeEg5eXorbW1aS2RmYnE1cXVl?=
 =?utf-8?B?eE9zOS9MWU9IbGxTMytjbVBLYXpmN2huYm1rVVU4SDM5MS9yOCswZzdKbHcr?=
 =?utf-8?B?Q3FtUFNhbnJNUmt5RG5wdWVxN0E1QUJ2aVcwbGE3dTNlTy9RN2hhV0RaSFB0?=
 =?utf-8?B?b2xuOEt4MENBcndHYXFQQ1k5Y3p3L2J5QzBHd1NZbEIyN3BPbi9FbTZ6MjV0?=
 =?utf-8?B?UmtBRk9xY0Y4V25NaGp1Uk40RnZpcVJ0SnNmQkxqdjFEelEwV3FEMnRCeGtR?=
 =?utf-8?B?NmIzd2d3Nnp3L2FzZC9ySHRWZjQ2aHpxUngwVldnajRoTVhoUFJwZWxsakpy?=
 =?utf-8?B?dk9nNUEwQWhMNmNpMTFaZWc2UlUwZUlac0p2Wlh6VytXZEJyRS91RmI0eTYw?=
 =?utf-8?B?aDZod3VLOWtQUDdzRk1aUEw2Q1lRRU9LOFpSalpHZmhYbFUxbGJPdEpENFlk?=
 =?utf-8?B?aE5aRGpLcEx5L3d5QXVrRjVDWk1scERrcE1RcGdOcHZsSUxRMGRrLzFZRkM4?=
 =?utf-8?B?WkE4STduTTJuUVpnTS9GOGtKdW1xeTNHR1FrQ2RkejQwREVHSHBTQjNUZUor?=
 =?utf-8?Q?heJY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 04:09:30.3031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3eb150-9a37-448f-5e98-08de2b0f4456
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Mailman-Approved-At: Mon, 24 Nov 2025 13:50:30 +0100
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


On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
> These are needed in SPL to be able to resume from DDR immediately after
> booting from IO+DDR.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> index a70fc88317e04de032e4da1428e25eb78ecc30cf..7e6a76f72b2a63bf706c3839189b6213aee4497d 100644
> --- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
> @@ -14,6 +14,14 @@
>   	memory@80000000 {
>   		bootph-all;
>   	};
> +
> +	reserved-memory {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&wkup_r5fss0_core0_memory_region {
> +	bootph-pre-ram;
>   };
>   
>   &cbass_main {
> @@ -68,6 +76,14 @@
>   	bootph-all;
>   };
>   
> +&wkup_r5fss0 {
> +	bootph-pre-ram;
> +};
> +
> +&wkup_r5fss0_core0 {
> +	bootph-pre-ram;
> +};
> +

Above bootph-pre-ram can be pushed to kernel device tree


>   &cbass_wakeup {
>   	bootph-all;
>   };
>
