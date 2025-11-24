Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58596CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1775783E13;
	Mon, 24 Nov 2025 13:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ExAqkU5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA0683C7B; Mon, 24 Nov 2025 07:18:49 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C469D83BEF
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsxtS122EhrFCJqDT3CYd/YlE4HR5xFWPL1zleQjc9lQVMAdMaq9cWfYC+qGhiojgvlh8XckrKiehD7oApekTrgP0exaMgYF/qoKLHQSSPvZLW3g2Qq/XquyWiwMWTGCRkSaTSj+31ajOMQMqimuHMzMAlCablg5V3DI/VNw6O/XBIpDDVLpG5wuIWmOcuhMt1zmY62F/WmWXihM5XQZVDdB5JWXz+WJMKaLTG8hC7RKyzuM/Zhkc4AXIDPBNNw0WGrzXNLsBZAbnBkgGM20uWVRaQL8urx9IdNvo/8vF8tXRuSqiRxEUB6P7eKAmo86fZlznOl/68JfWNDrDEProA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09FEy/94iHQcd5juu8qSf9gQRpnFMcxBmc803lKkmlM=;
 b=PkZTkPeE4rXOGsHs23IHmcfialVbys79vrxNOjOH6/oph0KpiEymbXkHn5eqkMD4x5N3xBGpKAqd47iH98SiVnyLexdK5K2O8vLmOmt5APy2WNPuKjcMxf92flMKNFZ0kESUnZZI5nzwQL2UKrUTZVJgP+DmFcQ/jm36nc1q94Rb3hPxPZMkxOVxuxEZrC2NIEHyMgFzwx5jgz6CfPzkdpeqLB27ih/TSgV5kuhVWoFPqPZrFhLi4X8gAfs+QEmyJVksfSLnW/msf/l+Bhb+zUizaDSlQZF2KQY0gRUIIhkOgpHf7A39Yaxd7Rtk7v+ok5b1Try4asne9+zevvVWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09FEy/94iHQcd5juu8qSf9gQRpnFMcxBmc803lKkmlM=;
 b=ExAqkU5in9JfrEW5L+n08nhrtkH+rQ9A9VHr3aN8wn7jd3Yc01oYf1rTYAtbdXlPvgYbXxbx58mPKuPTzpv+arQCWI2hyEHWKyi+TcvT1Kj8XbD2MNJHJsqXoJ4ouEFH0Byk8ZlXStEimkpYUrxgQXogHzCIMvHi4caHYP/ieio=
Received: from BYAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:a02:a8::35)
 by SJ5PPF25BED9404.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::794) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 06:18:37 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::ae) by BYAPR03CA0022.outlook.office365.com
 (2603:10b6:a02:a8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 06:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 06:18:36 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 00:18:32 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 00:18:25 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 00:18:25 -0600
Received: from [172.24.31.60] (ltd1nqfk3.dhcp.ti.com [172.24.31.60])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO6IFPp1422877;
 Mon, 24 Nov 2025 00:18:16 -0600
Message-ID: <b923eda3-46d9-4001-a976-82d7cb60d830@ti.com>
Date: Mon, 24 Nov 2025 11:48:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Chawdhry, Manorit" <m-chawdhry@ti.com>
Subject: Re: [PATCH v6 11/13] arm: dts: k3-am62p: Add r5 device nodes
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
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Andrew Davis
 <afd@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Udit Kumar
 <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-11-6dd99a7271bb@baylibre.com>
Content-Language: en-US
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-11-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SJ5PPF25BED9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 991318bd-aa77-40d7-e0e0-08de2b214d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXd3NnF0bGhyYXI5azVTSm9iS0p1TEtYank0MEhyampYT2YvWk9aTGhiZU9n?=
 =?utf-8?B?RTJFNjdMMkw3UnRURTY1V3NZUHhWMzJkelJZMGcyYTVrN05VbWkvRm5mU0RF?=
 =?utf-8?B?M2pUTWtBL1RlZDhYUE8wN29Yd1BkUCtpNmVDaFdRTVlXUCs5S1h1MlovcHE5?=
 =?utf-8?B?cXVEK3FUbGFTRkM2LzQwK1BwYWhlM3FXSlA4Y2VwU3ZVOXVpUGdJRWtOZHA3?=
 =?utf-8?B?aHlqTHdkMDdyMFgwbXZ4Y0hlL2RzWjYwbmZPaWEwM1NtNWhmK3U0aTJ2dDUr?=
 =?utf-8?B?dmxGYjYzN0JaTTV0QlJkT2d6WHlJMWtuTlh5Y3BRZGhVdmNtUENVZ29qby9K?=
 =?utf-8?B?NHJKVEhKdUdhbDRRNTl0MFE2R2hpeGZmYWx2bGRqUDFzZlUyR2JPSFZXRlYv?=
 =?utf-8?B?M3MvVE1QQkdRTU1YMXVuSFFITE9xUWpFL0pFazBqSFJKOHZNNCtQRm9qOStn?=
 =?utf-8?B?SW9SWE1ycVFhV3VpaGVGVUs3cVRPM3gzMFpnTWJYZUZTeDdmUkRWc0Rrb2VN?=
 =?utf-8?B?dURVcU44d0FLanBzYW5YQjJka1Zmc01VaUdRNkFFRXBBbDRLYklOVk0xUkNv?=
 =?utf-8?B?M3kyVXF4anFLZTRoTTZTL2tPUlFiM0toanppYU9KS28xSG8xd0k5VVZUZWpW?=
 =?utf-8?B?bW0zcGRWRU1MUUphcVFtNytFRzdiNnRhMURkZmQyaEV1YWUxMTVsaC9TWGE1?=
 =?utf-8?B?VzBNRWh0V0NSSWxmWStDRDZCQVozQnVBbjYxNGZEOCs3UFJUUXNWcEFuY2xl?=
 =?utf-8?B?NkNRclduUXdxSHVER2M0c1B0OWo0bVMyRVdxR0JvM0hmOFN5dFRLZTkzTFd3?=
 =?utf-8?B?OGx5bkdqaW9BSk4xZzNTM0w3Wk4rWHRRMklHRlhadGdGeUo5Tkd3b0Y5dWNR?=
 =?utf-8?B?U2Z4MUFNMkNldXBsaDkrZDhvVUhFVmhPUXJZVnJ3N0Y1ajY1Wk8wbnc4ZElm?=
 =?utf-8?B?SVlSVHpGeEZyYXRLa0ljcmlyRXJlalE3NlZ6UnFZYzJRSjRxLzd1TnVJTEEw?=
 =?utf-8?B?UW1tN1RvY2JVMGtEWjRpN3ZnbjU3cGttRGpYb3V6cUtUMjJwblcrdHZSNDRG?=
 =?utf-8?B?VDhlMUg1Y0lDbWhIVEJwNFUraVZYOVEzR3FBZ1RGMTEvZlRsSXZoNVFCM1VG?=
 =?utf-8?B?UjcrYlI4bzhSWVJLUEhwYStJbDdsS2dueWJEcVp1YXFFeHd6dVJDZ3M3eEpV?=
 =?utf-8?B?ZHYrd2M0VGN0YXVwVGg4R3FZK1VIbWhPNUxtWWRKT09iM2lVUW41VWRqcUdq?=
 =?utf-8?B?d3E1bnM0eEdkS3BPZzRabTlycjJLVHdYRkFnRVI1RnNTR2JBODlyQVVCZTl5?=
 =?utf-8?B?eis4UFRmaXVvdFJjT3AwYkI2L2dqN1lNZXQyaUJkWFVWWlN0MnJGWFBHQWZN?=
 =?utf-8?B?cVRYSWlFaDYyODQzY2dRUXlvMGdObDdwU3V6RnJUR1pDS3lUZUlpSlM0b29l?=
 =?utf-8?B?ZEkxL2RYUHFlNlVKUjc1Y2FTRFZ5VTNzOERsSCtxdS9DR2kwRWllZlZxenNR?=
 =?utf-8?B?YllWUjNwQmpVM1JVL3ZXdGpIUXh5SUltcVdacTdORndyQld2UXZJUC9tdzJR?=
 =?utf-8?B?TGpUZU5kTDZxOWlSZmJpTEUrSTRkQnJReEhET2xob3FNSG9CYmlNOXBhUjY3?=
 =?utf-8?B?cW5JSE5tVWtPL0ZQZjBadTdnUUR6VG1KQ1BmNE8zK1VlbHpyOXU4dGpZZVAw?=
 =?utf-8?B?N1l1M2xUVnZPNGJuMFRXRWFXemhWemJBN1pFUXoxTTdvSkpuOFJlMlNOUUhz?=
 =?utf-8?B?clBVdHg0VzZ5MnZ3ZjlvRUNvanZkMFhOenZzWDBiSSt3Z2t4cGFTREY1cEps?=
 =?utf-8?B?VnFObHVhS1BnVUlsbnZhenhoMEFpWDVXQUFxT0U1MGpPOTFXaDJDTG1GOW4w?=
 =?utf-8?B?SnFDZlViTldaKzBQbjhlVUFkOUJJMFVWeXdCMERNNlprblpDd2xWeWlGZ0Fk?=
 =?utf-8?B?YnNvSlJndURvcWh1ZEh4ZVJsNUp2ZkwwT0pNUW95b3Zlblo3aU9vT0tVNnJZ?=
 =?utf-8?B?QitIbHFsaHNab2hqZ1UxMWQ1MnZBUGZJOXZPLzNoWk1wUGNaNFZ5OGdIZFFY?=
 =?utf-8?B?ODdzaWpKWW1oQlVFNnNEYUM5MGJORlUyWnRUaG9sMHp1NW1vYXNBaHRWTEVP?=
 =?utf-8?Q?QPSo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 06:18:36.4351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991318bd-aa77-40d7-e0e0-08de2b214d61
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF25BED9404
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

Hi Markus,

On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
> These are needed in SPL to be able to resume from DDR immediately after
> booting from IO+DDR.
> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..8c2b198dede03fd77f16786f8743313a34902e46 100644
> --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> @@ -11,8 +11,28 @@
>   		stdout-path = "serial2:115200n8";
>   		tick-timer = &main_timer0;
>   	};
> +
> +	reserved-memory {
> +		bootph-pre-ram;
> +	};

Keeping this property in parent nodes shouldn't be required with binman 
anymore [0]

> +};
> +
> +&wkup_r5fss0_core0_memory_region {
> +	bootph-pre-ram;
> +};
> +
> +&cbass_wakeup {
> +	bootph-pre-ram;
>   };

same
>   
>   &dmsc {
>   	bootph-pre-ram;
>   };

same

> +
> +&wkup_r5fss0 {
> +	bootph-pre-ram;
> +};

same

> +
> +&wkup_r5fss0_core0 {
> +	bootph-pre-ram;
> +};
> 

Regards,
Manorit

[0]: 
https://lore.kernel.org/u-boot/175096060683.1879961.7350351827780463493.b4-ty@konsulko.com/

