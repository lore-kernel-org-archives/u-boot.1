Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4504E6F090
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 13:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2506D83F63;
	Tue, 23 Dec 2025 14:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XMP2UEg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA7A83F4C; Tue, 23 Dec 2025 09:11:23 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E8083EDF
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 09:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0z9h9KBap4K2pb2gf4lS1UK4tlWNKDrmdhUeeEow7+1O4yuC9HQHIHE0RvtVbByzWzWCjW+I/vf9bpqQXmVd725PDSvxm1oVdAdkjXjCl/IMKaZhCI0RPV7jAlQhmfOQ3hHZe7//6Fo9G+5pol3XBYHheYwmsVI+KUevRSjuJG4ZurGwzSM9kMk+wihXMTwrgg9cnra3dlMDZDmRm4Putz6f3QicukbY6I6Lbau/48adJT+OwOrrEaD6FxFN8BegBOVixj1SXnemla1KSn5KZAUvVrhhVqGu6V4lqHnqj49qrJKvQwgv/ftLGb0AE4HIsmBK8BijACeUHn7m2xg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o+afcOkFyMMBHjANO+cSt9v5gSB09fPd8ZyC+frwLA=;
 b=smgoHa5/Y2Z1NxmXmCDnS3zebN0slo03Mf/Tzsd78OZzC3FdjAXWYjgh0CzMftf7Dlz26Ach25mIZ95AxJa1iEjx+7NXgK0hsvXAMeq3WklT/BC5v67NczmHtnJCI4C9xTq+dIJ1bkO5AoacGuIY1KrxlWX4tny7hLXsbc+tiEqiQ8vJnZF1R/wAuWYqmGybxpGtCjxil/gs5zKQ0XLSkSj4x4MnPXh2238w6GWL3hLFh0EvYadonik0BJJfidfHyMJDFehFeGstaeFLXptHru0/4HqqCKLk4fX9PUCFWOou6b8fUSPZwLvhyPilEYVXVbup6+YVIrDecVwLPj/LNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o+afcOkFyMMBHjANO+cSt9v5gSB09fPd8ZyC+frwLA=;
 b=XMP2UEg6cEpmaAlCw1Tn3p0gECwYQJaetMb2MuLyYlioILSbVy0rOi0XRtkttdvFco+Jj8iwcij328rpqUWjxk76HkVM5ylL7VGbLl3MIyI14mv5QKTgTRLLdoCDvF6X40fx1U1SttsAfLibsTX6Ex/RDts0gbWSJrZHTnC1B74=
Received: from SA9PR13CA0133.namprd13.prod.outlook.com (2603:10b6:806:27::18)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 08:11:17 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::56) by SA9PR13CA0133.outlook.office365.com
 (2603:10b6:806:27::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.10 via Frontend Transport; Tue,
 23 Dec 2025 08:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 08:11:14 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 02:11:11 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 02:11:08 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 02:11:08 -0600
Received: from [172.24.31.151] (lt5cd2489kgj.dhcp.ti.com [172.24.31.151])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BN8AwZ42798597;
 Tue, 23 Dec 2025 02:10:59 -0600
Message-ID: <094bbc1c-8a97-4f75-992f-c53615f22d46@ti.com>
Date: Tue, 23 Dec 2025 13:40:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
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
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
 <20251222-topic-am62-ioddr-v2025-04-rc1-v8-8-e70fed16b166@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-8-e70fed16b166@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|PH0PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0fdd46-20b3-44ee-4703-08de41fad770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFlFR2hZV1lhS2JSWGx6NWI5T2QxbG5SN1ErODNLYkk4ZzI2K3FjV2dWSHBJ?=
 =?utf-8?B?WGw4K3V5L0tWRHRMVmo0a1EwSUdzTTFwc2pPSlhhQkJSVXBqSldTSXpyWW0x?=
 =?utf-8?B?d1Q2UU1CM0hpUjBkQ2t0Z0Y0b09jSklzbzQxTVVaUjNQczFhRE1zcjBYWEtM?=
 =?utf-8?B?a05uNnMrczRHUmQ5TTdnVEt2M1I1TnJvOHQyYytlWm5SS1plcytCbHpkcmVv?=
 =?utf-8?B?YWpHa0F5YXZmczBVZjNRck00KzlSdUxnaHYvWlVQN2JYeldGd1JxalhueGhv?=
 =?utf-8?B?TjYycENiUk9mZUkyS3Q5NnlOTjdhUTNlWHZ5WEhCbDlmR3NXRUlldjl5RUpZ?=
 =?utf-8?B?SXNoREFKNGpYRmxTQytONG04QUgzQU1RNkZyTWJhTTBoQnhER2I3Zm5rMklo?=
 =?utf-8?B?K0ZJc1ZVTW1aUjNIMXVQdXBOZUtPaHBONnZqa3hnOEo4MUhCZnQxZkhoblpu?=
 =?utf-8?B?c3JreWtZQjVoMXdyQzc3RW1uZS80RnlNaklMdEpiR1Q1dUk3OXh5c0hEUEMx?=
 =?utf-8?B?dC9RNGx6UVhNNDN4UjhjRkpUajFiQlE4RFRwOWVJR2hDRW1iMzhIMTZWemFT?=
 =?utf-8?B?cXY4WER3Sk1IZnd6Y2txcUpDeWIxQUx2ckZRQk1ObHJWT2VLeCtLbHY4a2FN?=
 =?utf-8?B?SjhLQXluTHdSbzcxMk16K1hzTnBFUWFPUXRvUHhOdHh3Ykg0b1F3eld2ZTFp?=
 =?utf-8?B?V0d0MWpaN08xaGsrRDZWQTN5VTQyOUJTb2FmQU96UmRucU80NGdBa2l5THJC?=
 =?utf-8?B?MzRueW5TV3BySmxJbWFINzJqRG1qRjBxTUtNOEtLODMzSWlLMGkrbS90OUQ5?=
 =?utf-8?B?cExDYzdBK3NyaEhvTXpWR3RLSTlmT3pBTEtTcGpTTTN3SlpJWUhrbHgrdS9I?=
 =?utf-8?B?OEpEMHAwVmdlRm0zbDhnaEtpdmw3RkxJNHlpSHArMXdYaVhqVGRweFBhRzRJ?=
 =?utf-8?B?aTRVeEczVGRlOFVNYjUyVjUwYjREaXd0NVhHWExGemZmSE1XWlEzT0xlMThE?=
 =?utf-8?B?Wkl2STNqRHhWNFNaeTdqdFFscnRnZDFDVXh1UnJFMERINkZIYVdvei9keURy?=
 =?utf-8?B?R2JHUHdHc3pRR0FSZ1dhT2xFazdycHA0MkVDdE91MGtNTGhXdXpHNTc2VG52?=
 =?utf-8?B?TkRLQWhFcFlUTHh6S3Zjc1dtZEdxWndLVGIwTlpzcFdsNi90U3lkRDJZMUhH?=
 =?utf-8?B?aUdNcDM0ckp2NEwxRnYyRTNaam5vYXk3Z0h5cWt5d2t6QmhTZE1hTm80YXNM?=
 =?utf-8?B?OHoxU1lCdkNNblpCSmtrMjM5YVV5aFBoR01nbXZWZzRjVmdMMXQ0MXV5T3RL?=
 =?utf-8?B?dU9UdElDMlRvcHA2bVNrSUVzMSt3MmRJNVFEaUFJYWYvNU9WZklueDJRU2pl?=
 =?utf-8?B?akVLeXVDRERkYk5KUTJaV2x4TmpiMUtkZ25KTkovM2ZMaEJoaTZoNllucFpR?=
 =?utf-8?B?MDcxTnhlbk1Ed09ycXVGZ2RsMTJSQXlqaFBtMDFndGdBbFVhY2xJeE5jbk5u?=
 =?utf-8?B?MHd4c3BOcXdTM1VqUXlvWkQxZHBGd2R0bHRIREFGSWdZQndWd0tqMHpTeXVK?=
 =?utf-8?B?S0NwUmNWWnpTaW9CMG5sU1lXeHN0YlF5enA5VVlaOU9CQWcrSnNqaTIyRzlY?=
 =?utf-8?B?R3B1cDE1VWFzYytwczhoQ1I2eHd6RU1tbEtxQWhQMzhZemgzL05Wd1NpcG9J?=
 =?utf-8?B?amxwc1QyTjdHa2t2K3l2eXFMRElsN1dUeFZNZU1lSm9mZTZodjZ0Zm02d25a?=
 =?utf-8?B?amhGYlp4VVJiY2YrZTNpZ1JBZVZjM2NMV2FSUzl4MXZqREE5OGU0azJxcmRP?=
 =?utf-8?B?Z3U4YmxQNXcrMVRqUFEzU3pMUTd2ejc4OFlhYlllSTFKM3VYcm10alNTcEtN?=
 =?utf-8?B?ZHgrbE9hdkVobWZwbHBFZEJzRGxVamxiUko0ME5OQTk4UnJ0Tkl4blZBL3ph?=
 =?utf-8?B?SVJRejR5SXJMTlQ4SjBFdEIwVDA1d25kZDlPbk1LL0owOWNVa1RkVVNSdUxs?=
 =?utf-8?B?Rm5LTWs1RHdzNHZsRFJjTXdyakFFZDJqa25ybG5TdlVTbks3M0lEcnBLU1pZ?=
 =?utf-8?B?NmJBeVdCZ09NdjlPQnFxdGZYNUNXaXJEVElVeHA1VHdaVGFuMUlhTGRpS3Bk?=
 =?utf-8?Q?AaG4=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 08:11:14.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0fdd46-20b3-44ee-4703-08de41fad770
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Mailman-Approved-At: Tue, 23 Dec 2025 14:36:20 +0100
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

Hi Markus

On 12/23/2025 1:31 AM, Markus Schneider-Pargmann (TI.com) wrote:
> When exiting a low power mode with DDR self-refresh, we can directly
> resume after DDR setup is done. Call the common function to resume.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index c1c7d669a45f53b7528c80d44bf9b914fed1cc10..51b0386853b065d62cd0ecac589e316de5ab4038 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -198,6 +198,15 @@ void board_init_f(ulong dummy)
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>   	if (ret)
>   		panic("DRAM init failed: %d\n", ret);
> +
> +	if (wkup_ctrl_is_lpm_exit()) {
> +		u64 meta_data_addr;
> +
> +		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
> +		if (ret)
> +			panic("Failed to get LPM meta data address %d\n", ret);
> +		lpm_resume_from_ddr(meta_data_addr);
> +	}

Could you help, how qos will be set after s2r

see 
https://lore.kernel.org/all/5058275b-a198-43b1-a040-df330775f695@ti.com/ 
as well


>   #endif
>   	spl_enable_cache();
>   
>
