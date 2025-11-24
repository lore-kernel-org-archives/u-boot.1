Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC59CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED2A83DA8;
	Mon, 24 Nov 2025 13:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R+8DkC7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B03883BF4; Mon, 24 Nov 2025 04:56:27 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC5B683ABA
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 04:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5JW+Ioj0bybSC0E7e0OVQhqMGhnJWKvQ8165in8+6+UsFWgzx3IpOXLmKmz24A7GdREcZaJ6RD6gmkMnVIbVt0+CIZwjLZg9YwHlfvRTcgp4Ork0x3MD3itS5Nu38+bim5CzK0qvRqIZFPUDlKetvd4Z3WE8eRUkkcX7M0qcuR2GM+C9nK4hxMwCuz30BZEw3v/boYobnm7pstOo7hX795/6Me+xyiKYV4iusUJSSCZkHePYdHlOM6DhTLQUHRjgOeItcKkPonsq0R+n1gNY4uq773402gZLJ+Hm49ojYrrwfivwcqiNMJ4Z6qapx3uT9JJ1o2Glmss8JGe/STWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb41NgOjJ881rS49uZda2BoWKjXYeQZY4mbDhu3AcP4=;
 b=zLeDeDT+ex6QHe11KnkXsZHfF+ufKtj/DFGTIuzXMakv1M15UmlX5v+BXT4SxPoR21BHIrPGVtRvm/gOH2ojKTa70AG/cJ1wOa5ee7x4uykLSBvacK1qzgxDy5uNiKtwOyf/ac8A7xIkYREVDxaNxckSxHfSZi4RLcIuZcWo/OFFKX5ZFG+3gvjQRHiN0vw5cJDjU6VnFKmZFvqMHs+f6Ljq/csThTVQAttbQADifTG8Kxl7LrjsOUEEZUL3g5yYobTwA3gmwI4k6Qiv9Gtg0FIoIxWN2FaWv+Y87V7Bs2yRL3X69vV9dF2zZXBUAIxahJdt7o7i7HEa7m56bxOKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb41NgOjJ881rS49uZda2BoWKjXYeQZY4mbDhu3AcP4=;
 b=R+8DkC7kscAC9yB66iUyPHAHXXLD6zjqinRd2DWzKPh3mafxMivwfb4OpkcL+pQ2r/m1jXlB6jHlLO10sqFh9ej/KhPhLZVX79DOjrCLF7LkYkg797nD5C02c35n42ho1ZqaBFq1xUklMeMmY32RqEPA+B6Uf1za4eenVB1Czxs=
Received: from PH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::10)
 by BY5PR10MB4322.namprd10.prod.outlook.com (2603:10b6:a03:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 03:56:21 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::98) by PH5P222CA0008.outlook.office365.com
 (2603:10b6:510:34b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 03:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 03:56:19 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 21:56:18 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 21:56:15 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 21:56:15 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO3u5a91247183;
 Sun, 23 Nov 2025 21:56:06 -0600
Message-ID: <080e5761-a21b-4ff9-b6bc-6c287b048351@ti.com>
Date: Mon, 24 Nov 2025 09:26:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/13] ram: k3-ddrss: Add support for DDR in
 self-refresh
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
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-3-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-3-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BY5PR10MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b6608c-831c-49f7-b249-08de2b0d6cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVNyakFXcnVwK2lIbUF4VGxYVWZLUnNML3RSQkhtc1ZaU1V4dld4akVsUXVD?=
 =?utf-8?B?T0o2cUhKOE9iV1BZTy9oQVVyN0xhdFFKNXV4M2F3Mnd6TG5IOVFTM3ZybHUw?=
 =?utf-8?B?Q1VudS9tMDFHUmtSai9weFNud3hqcDJMSzhzOWhHdDRMQnBHUURiWW9NRGUy?=
 =?utf-8?B?MjlESTlUUEw1ZXBYSlZhZHlsS29KSndBSUcyT09VNzVPMXQ5RTNHNE5rTFdY?=
 =?utf-8?B?Y29vNlZwZUZ4RDFXUEtKZ3BTYVdGWkwyL1JpVVY3TEJJcWU3bTBXSEVKc1d1?=
 =?utf-8?B?UGh2eVFLSlJid2JyTndJVjJ4bEdOWXRWaWhlMHpMSXBxbTVuemVLeFA1Y0Ja?=
 =?utf-8?B?Q2pRMzhWdCs0N0owM0hkUEw1QnpTMG5BUUhTWnNEbnpCYkhZZUVhMCtrV1M4?=
 =?utf-8?B?dW9iRmVHOVlqNHQ4RTljV3BlanhFb0NrbDlBRnZWU0VaK0hyUHpZbTU5bHN4?=
 =?utf-8?B?dEk4djVhdW9yTHRwRzNxM2lSQTdEdkovbWNsNmhNdFNMbUVocy9LTkUyekE1?=
 =?utf-8?B?L2NNSnBGRmYzWFp0VmxCWU1KZEwxd2Z6YUJ3K0tpcFBlMms5bFMrSUJkRlBT?=
 =?utf-8?B?RnU0OS9PZ3doK29FN1pmNW5sNGF6akJWang3amE2ejVGS20vcEZrYmc4SUdv?=
 =?utf-8?B?SHUyQWhDV2kzM2d3UE1EK084cTNueERsT1lRL0Rxb0hRRnN4RDNydERPa0ZY?=
 =?utf-8?B?U3R2K0NoVjFMWUlobm5vMElMOFMwNkcvNWkxQmhVZS9YZG9od0hWalg3T1hr?=
 =?utf-8?B?N2x3cGxIKzJUY0plWjF0aTRkeTZzdUNxV0NGbnJFZmlkREovcmNsbStrVEly?=
 =?utf-8?B?bHhpODR4TWdmc3ZlUmJkVkFrcWhvMGsxSDh5aW0yK0lYS2tSblYwbE1CQzQ1?=
 =?utf-8?B?b2U4SndkK0p1S2Z0OVEzL0oxcW44cFQrSTFJd01uNFQ5cU1oL09Lbjlvc3Mw?=
 =?utf-8?B?NGlkRSs3SnVVa2gzN2FQcEdNZ2l4OUJ1VEdqZ1dMUHVJYkU1VTlSK0hOZUM2?=
 =?utf-8?B?bHBLTGVTOW9UZG5oemIzdEVpZ0cxeDBuOVZ2WndpWXFoYUc2Um5pNGljQ1JQ?=
 =?utf-8?B?NkhCcXdOczFPVVFvUGVYeXJ5MW1DYkl0R2dqZUFsNDkrTGNUUGVJZ1E0N0FP?=
 =?utf-8?B?SExtOXMxaHFBRWNQRmhkQk12a1NwMk4rbFpDamd6b1gvZEhsUG5kTXhTWCtT?=
 =?utf-8?B?aStDY0cveWl6elk0VlBVNzhURlFtOXdXVGdRRVFuTHJ1Z3RwNjdHOWJGRFZ0?=
 =?utf-8?B?ZzcyQ0RQY2ZRL2FmVTNwZ0MvTzNOVkNwRDVuVk1NSFI3QlFnVUUvM0FUaVZk?=
 =?utf-8?B?WXNoRVZTa054Vy9FNXdmNEdyV0ttSVFkQWgzMTBBNVVXbVoyL1hIWms1WVdC?=
 =?utf-8?B?N3pRK1prb0xlODZ0YVFaQ1YySDNGc2dWakttcTJFQU11cmtUcHVkWFN1RUhp?=
 =?utf-8?B?MW8vR0lWelpHVDAyRS9SZ0o3SGlDWHpjUHltdzlsdTRjclA0SWh4WlJwSzVQ?=
 =?utf-8?B?N2QrekJSV3VuUGJmWGRiVGJCTEkxeCtEL3VmTDJodStyaWJGU09DU3VwekNS?=
 =?utf-8?B?MExyUFFDRlpSTWlvK3FydGRhKzZncnRPT2hrdzlQVEROZGR6aFpNdjNBeTJI?=
 =?utf-8?B?UUZMamhpcFNodzNtZExjdkRxaWdJSnBVSE4zRUJrQVMvenIvYXFMTEt4OW9l?=
 =?utf-8?B?VnNJdTU4WDhxTERYTEdmRXR2aUNYZUVCQlBtMjVSTGdORnJOdDVIUzJwQmkz?=
 =?utf-8?B?NTVlUGRGZkNuMW9hWWdWaGVBcGpCVnNSaDRtZ2dyVnVFRUdQZmQ0YXExbXht?=
 =?utf-8?B?WDlHblVRNHBJVmNPbDBqREtyekVUWFdFQm9YVUJOZFJCRWpxZTRRUW5xTjRQ?=
 =?utf-8?B?RWV0Zms0QkRZS1JJbGpZZkUyek9KNHovR0Nvc3hYVnJMVmxqRHc0bXdiVjRW?=
 =?utf-8?B?OUZnaHJUYkNReWNlVHFMcmRCUnpnMjJhOWl5MVNsTGVXdGZqOWRLQXBDck9y?=
 =?utf-8?B?VXpjYjA4QnFkMFNCWkx5Nys0RlNBV0lDK0s4VjdGYldUSnd6OHg2QkFXSkxG?=
 =?utf-8?B?YlhZSTh2MmoreExGRzl0N3dtbFBPVkZKVk5rMk0xV3lmUTNmelU5ZHd6NXB1?=
 =?utf-8?Q?Hsfw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 03:56:19.1330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b6608c-831c-49f7-b249-08de2b0d6cbe
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4322
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
> In IO+DDR the DDR is kept in self-refresh while the SoC cores are
> powered off completely. During boot the normal initialization routine of
> DDR is slightly different to exit self-refresh and keep the DDR contents.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 180 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 180 insertions(+)
>
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 5144470b931384534e78fbfcea5e66b7083c9f07..e049b36519521213260da7aef933236b62a2b33b 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -57,6 +57,19 @@
>   #define DDRSS_V2A_INT_SET_REG_ECC2BERR_EN	BIT(4)
>   #define DDRSS_V2A_INT_SET_REG_ECCM1BERR_EN	BIT(5)
>   
> +#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL			0x430080d0
> +#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD		BIT(31)
> +#define K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK	GENMASK(3, 0)
> +
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x4301830c
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
> +
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x43018318
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
> +
> +#define K3_DDRSS_LPM_TIMEOUT_MS 5000
> +#define K3_DDRSS_RETENTION_TIMEOUT_MS 5000

Please move add LPM related code into different file.

Here LPM and DDR code is getting mixed into DDR driver.


> +
>   #define SINGLE_DDR_SUBSYSTEM	0x1
>   #define MULTI_DDR_SUBSYSTEM	0x2
>   #define MAX_MULTI_DDR 4
> @@ -211,6 +224,32 @@ struct reginitdata {
>   #define DENALI_CTL_0_DRAM_CLASS_DDR4		0xA
>   #define DENALI_CTL_0_DRAM_CLASS_LPDDR4		0xB
>   
> +#define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
> +#define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
> +#define K3_DDRSS_CFG_DENALI_CTL_21				0x0054
> +#define K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE		BIT(8)
> +#define K3_DDRSS_CFG_DENALI_CTL_106				0x01a8
> +#define K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT		BIT(16)
> +#define K3_DDRSS_CFG_DENALI_CTL_160				0x0280
> +#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK			GENMASK(14, 8)
> +#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY		BIT(9)
> +#define K3_DDRSS_CFG_DENALI_CTL_169				0x02a4
> +#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK	GENMASK(27, 24)
> +#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK	GENMASK(19, 16)
> +#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK		GENMASK(14, 8)
> +#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT		8
> +#define K3_DDRSS_CFG_DENALI_CTL_345				0x0564
> +#define K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT	16
> +#define K3_DDRSS_CFG_DENALI_CTL_353				0x0584
> +#define K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT	16
> +#define K3_DDRSS_CFG_DENALI_PI_6				0x2018
> +#define K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R	BIT(8)
> +#define K3_DDRSS_CFG_DENALI_PI_146				0x2248
> +#define K3_DDRSS_CFG_DENALI_PI_150				0x2258
> +#define K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN		BIT(8)
> +#define K3_DDRSS_CFG_DENALI_PHY_1820				0x5C70
> +#define K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT	16
> +
>   #define TH_OFFSET_FROM_REG(REG, SHIFT, offset) do {\
>   	char *i, *pstr = xstr(REG); offset = 0;\
>   	for (i = &pstr[SHIFT]; *i != '\0'; ++i) {\
> @@ -864,6 +903,132 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
>   	writel(val, base + DDRSS_ECC_CTRL_REG);
>   }
>   
> +static void k3_ddrss_reg_update_bits(void __iomem *addr, u32 offset, u32 mask, u32 set)
> +{
> +	u32 val = readl(addr + offset);
> +
> +	val &= ~mask;
> +	val |= set;
> +	writel(val, addr + offset);
> +}
> +
> +static void k3_ddrss_self_refresh_exit(struct k3_ddrss_desc *ddrss)
> +{
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_169,
> +				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK |
> +				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK,
> +				 0x0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PHY_1820,
> +				 0,
> +				 BIT(2) << K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_106,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT);
> +	writel(0, ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_PI_146);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PI_150,
> +				 K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN,
> +				 0x0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PI_6,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_21,
> +				 K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE,
> +				 0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_20,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE);
> +}
> +
> +static void k3_ddrss_lpm_resume(struct k3_ddrss_desc *ddrss)
> +{
> +	int ret;
> +	unsigned long timeout_start;
> +
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_160,
> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
> +	ret = wait_for_bit_32(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345,
> +			      (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT),
> +			      true, 5000, false);
> +	if (ret)
> +		panic("Failed waiting for low power command %d\n", ret);
> +
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_353,
> +				 0,
> +				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
> +
> +	timeout_start = get_timer(0);
> +	while (1) {
> +		if (get_timer(timeout_start) > K3_DDRSS_LPM_TIMEOUT_MS)
> +			panic("Failed waiting for low power state\n");
> +
> +		if ((readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
> +		     K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) ==
> +		    0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
> +			break;
> +	}
> +}
> +
> +static void k3_ddrss_deassert_retention(struct k3_ddrss_desc *ddrss)
> +{
> +	int ret;
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0x0,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
> +				 0);
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0x0,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
> +
> +	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +			      K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +			      true, K3_DDRSS_RETENTION_TIMEOUT_MS, false);
> +	if (ret)
> +		panic("Failed waiting for latching of retention %d\n", ret);
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0x0,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +				 0);
> +}
> +
> +static bool k3_ddrss_wkup_conf_canuart_wakeup_active(struct k3_ddrss_desc *ddrss)
> +{
> +	u32 active;
> +
> +	active = readl((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
> +
> +	return !!(active & K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
> +}
> +
> +static bool k3_ddrss_wkup_conf_canuart_magic_word_set(struct k3_ddrss_desc *ddrss)
> +{
> +	u32 magic_word;
> +
> +	magic_word = readl((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT);
> +
> +	return magic_word == K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
> +}
> +
> +static bool k3_ddrss_wkup_conf_boot_is_resume(struct k3_ddrss_desc *ddrss)
> +{
> +	return IS_ENABLED(CONFIG_K3_IODDR) &&
> +		k3_ddrss_wkup_conf_canuart_wakeup_active(ddrss) &&
> +		k3_ddrss_wkup_conf_canuart_magic_word_set(ddrss);
> +}
> +
>   static int k3_ddrss_probe(struct udevice *dev)
>   {
>   	u64 end, bank0, bank1, bank0_size;
> @@ -873,6 +1038,7 @@ static int k3_ddrss_probe(struct udevice *dev)
>   	__maybe_unused u32 inst;
>   	__maybe_unused struct k3_ddrss_ecc_region *range = ddrss->ecc_ranges;
>   	__maybe_unused struct k3_msmc *msmc_parent = NULL;
> +	bool is_lpm_resume;
>   
>   	debug("%s(dev=%p)\n", __func__, dev);
>   
> @@ -880,6 +1046,11 @@ static int k3_ddrss_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> +	is_lpm_resume = k3_ddrss_wkup_conf_boot_is_resume(ddrss);
> +
> +	if (is_lpm_resume)
> +		dev_info(dev, "Detected IO+DDR resume\n");
> +
>   	ddrss->dev = dev;
>   	ret = k3_ddrss_power_on(ddrss);
>   	if (ret)
> @@ -895,12 +1066,21 @@ static int k3_ddrss_probe(struct udevice *dev)
>   	k3_lpddr4_init(ddrss);
>   	k3_lpddr4_hardware_reg_init(ddrss);
>   
> +	if (is_lpm_resume)
> +		k3_ddrss_self_refresh_exit(ddrss);
> +
>   	ret = k3_ddrss_init_freq(ddrss);
>   	if (ret)
>   		return ret;
>   
> +	if (is_lpm_resume)
> +		k3_ddrss_deassert_retention(ddrss);
> +
>   	k3_lpddr4_start(ddrss);
>   
> +	if (is_lpm_resume)
> +		k3_ddrss_lpm_resume(ddrss);
> +
>   	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
>   		if (!ddrss->ddrss_ss_cfg) {
>   			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
>
