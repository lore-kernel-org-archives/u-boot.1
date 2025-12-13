Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF5BD59F76
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7AC83A2B;
	Sat, 13 Dec 2025 15:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kMnKGhmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C958307F; Sat, 13 Dec 2025 08:00:35 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E99807C0
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 08:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8xt6JmBF0ffjpxbOHBKDWMgr3qpM46LQ1ZSzA9MWzpNjSf/K4C2APofYvUmGIjvrWvJ3UjMtnWlbm6PLtqZ8SfFhGDWrw0jE9y/mSjPsWspTvvEionmgFjAqhWTwAo3f+LwIL3EYXzR/LBGwS9E9QWvCAQCvmwHf/P0aGkcfsoNsZCQOy30D+Q4ktyaXkVV5qM+JFx7jx3YOPqJy6Ng3j/4C6R3Aqbs8A5XjZkN/E3uaShvSJwQ+idQLHkWfFElNUAAOcG5Vt2TTGj3DHP/Cz1B+AZFjb4VaenG4eBmERUMNFIF703Ai0YJcIimxby9nCpTdn9PFf2lvJzophBq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OpjViL5PunrQh9WogCbk9enm6UUFVRAe6OCgWgzvxI=;
 b=qhPFftMZjOouWXNyC1EW4CRyeFy7cZDFAXSV8mWq8eh48uNWiEFR3XGaCc7PtDJd4C1MxIGuzG/QUMt4ayMiiX0Yz6tGz3mhac8thfiVQl3a4zoPhQd+o5hBK2dr/b5BVaOls7cQN1LeUNj5A3BsuQNDJQxycLhyz1rUx0ksFMPSYKBCxSwXKOp8CH3qjDi2QIHeRszstmeZAzk5ur2C2qhpgfgvUeZ4vTUKkbISIzqxCQwjp3Yt1xLanhdEn7LRodFL8+ANyPGLZhdg8C7Zbs+6Ti2ah/D+bAgQhNrcCOHxBgqm/6xbasJw6yuZkwGD0YKoSEVy3DqCxhtORw8hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OpjViL5PunrQh9WogCbk9enm6UUFVRAe6OCgWgzvxI=;
 b=kMnKGhmo0sXcP2RsBLrNefb62QG2gmDd7z8YWwbmlQfIT7G0x+sW9duKkGPr7E7DvMdo7qCdKFid9j3uV83croN8c64WvXbznOkqwFzzDUOjkPre9sD7O2oeGawTZl050v6RSzmTNGIyQUx7QZHxQyFbQJJkOxNfql05M61vtTk=
Received: from PH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::9)
 by DM6PR10MB4156.namprd10.prod.outlook.com (2603:10b6:5:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Sat, 13 Dec
 2025 07:00:29 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::d2) by PH5P222CA0002.outlook.office365.com
 (2603:10b6:510:34b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.12 via Frontend Transport; Sat,
 13 Dec 2025 07:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 07:00:28 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:00:25 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:00:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 01:00:22 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD70COs3395513;
 Sat, 13 Dec 2025 01:00:12 -0600
Message-ID: <1c8e5d19-bc1f-4110-9e2f-56dcdcb7454d@ti.com>
Date: Sat, 13 Dec 2025 12:30:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/13] configs: am62ax_evm_r5: Enable IODDR resume
 support
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
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-12-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-12-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DM6PR10MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 28956892-4d06-40b3-099c-08de3a154c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk04RkdHWENxUmgwSE9yaTJTRmhJdUpPaFA4WU5Geis1M2hlMDVvendEd2xM?=
 =?utf-8?B?ZkNoWmRJbzg3azc0WFU5eDJyMlR1aHVKNFhlVDQyNm9xcWFhSUZ3K2h2RXhj?=
 =?utf-8?B?OUIzRzA1TnZCazVhNXoyWWJHbHpuSS9QQTlhdWxmUnlJS0gzUStoMWpOcWZ6?=
 =?utf-8?B?QUtSVDZ0MngybDZsZVVQczVRQjFDSlZXc3ozZ1IveSs5eDYzanBIK1BnRksr?=
 =?utf-8?B?NnN4eHU3VnpNVWJ0QW44MUpLWXpERm1HWW5WUVoyODZuUTJ3d2pHU3RQdFox?=
 =?utf-8?B?UkhzbmE5TTZqbGhFNHZ4WjgweU1ad2xFVCtYTndzZ04zcGQrQkt2ZWV1cU5T?=
 =?utf-8?B?RTZwdkhTUlduN1Uycm92ZUQxMzJ5Tm9xbkFzRzdENzBVdlRoUUtqaFdSekE1?=
 =?utf-8?B?bzJOZVB2MGtwemZ5cnNnK1huOS9xMkV0cHpwQldQWDVWM1YzZ21ZOE1VL0Vl?=
 =?utf-8?B?cjJac3N0VENZR0xjS3cvVzZIV3AxTWJUQ1UvYTg4akdnVEUraWJveE9SNkRm?=
 =?utf-8?B?NW9sMTkxRFNDbGd2SXJxVkNmeDdsc2hXOGJmQVA4eU84eG1rcFdkVzg0Um5q?=
 =?utf-8?B?WkxOVjdnVTlFcHFaYS84bnBuYlg0WWk2dU01U1pCSmFPbzExSmR4MkRmcHp3?=
 =?utf-8?B?eUQ3SDdKVUQwZkZ1aU9GeUhnYWpMSmQxeCtwcEZPTDlvM3VGb3pRWUcwdzZL?=
 =?utf-8?B?bjNjczB3UkV5MVFJbU12eTFaTWJmU3FadnN1aW5ORjk2M1oraWh1VHptVjA5?=
 =?utf-8?B?SUYwM1Q3eHhSanBBeHpNL1RRdlR4ZUZMU01FZHJMNmRVOHUwUVRaT29TTFJ0?=
 =?utf-8?B?NnVNeVVGOUdPSGJJSEdIQm9Ka2N1Tmw1d05udGNPMEM4SEU0Y2lkczhPNFg2?=
 =?utf-8?B?bkdZSmViVmtIMGlMOHV4RmdtQVJ0cVEwby9VaGZ6cTJjYU9LZ09vMldSV3VQ?=
 =?utf-8?B?UGFnNWtyeGtvQ25Uc05YV2tzcC9qQmp4Wmh1ZC9vOVNkVXYzVDZ0NThxSzMx?=
 =?utf-8?B?ay9rZndrVWNLRFc1amQ3Y0poL1A1ZXgyd3hLRXlHdjBPNDhTRUVRemNFSVBj?=
 =?utf-8?B?SjJSUjJOS2tIem5BeXlEZWdESm96ME9NL1dORlNoaG9zM2xLNjdVUS9rdEgy?=
 =?utf-8?B?RGNobjVxNmdZZGF3YkxPbHVmcmtFcVNmek8zWEtUeUFLeEdpbXRxMzdtK0V3?=
 =?utf-8?B?TlQyblA5Tkk1dkVBSkl5R0NxeC9DdHhSekJBM242b3ErWG5jcnNIeHpqbGda?=
 =?utf-8?B?bG9TN1Q5djZKV3hUdlJ3NUdIUmJxdUdpNDhRK0J3MXp5NlBIMlQxUE1MUFVn?=
 =?utf-8?B?WkNQaS9HS1prcGVwUTZzWW9raW4zZDByMVZDM0I4U3Ntd0VabHZubm9IaHpK?=
 =?utf-8?B?eGVVMXBxZjFZSitnc3k2U3J5aWhBSE8zUVlNRTlMb3hsWVNxazlpenF5aTdJ?=
 =?utf-8?B?enBYQS8zMEtLT0RCYWlLMllkTUNFTzR3U0V5cEk5K0grNCtjNDN2QUNzVWN5?=
 =?utf-8?B?K0FUSXhubDVYTWVaMm51d1JrTlpYd2xwcWdJOEMvTmtSZHpVN2R1TU1uSDF4?=
 =?utf-8?B?SXVSMEg3Q0JJWkFBNVZxMVRneVcwVmZtc0U2OVVnWkkvMjVTdHQwOFB1Szk2?=
 =?utf-8?B?NmxycW9kZ2hwY00wOWRZczhObkFEYVRHRU5WbjFMSHpzRU5lWWlkdmZPY2pS?=
 =?utf-8?B?cU90bE51L0lhZlJjMm5wc2VkNHVzVzkzZVFLZ0hLRTl4Wmx1OFFIQ0JFUk8w?=
 =?utf-8?B?cFNiVURLRm5VMFg0ZEYzM0hDdUFUUmJZejlqc1pGNmNJUVUyM3U3ZG5zeG5F?=
 =?utf-8?B?dlQ0WnFtczN4SmNNTCtIbmxlVUR2MU9Vb0RyUkVvT0loSmZxYU5aMWREeDJ2?=
 =?utf-8?B?R3c5enBZb0dJM0hkUmloMWU3ZkNtdHVXRzBKRlBXM2o0M2lWMFkyZEZJaUZO?=
 =?utf-8?B?ZEFST0ZOMllsc0xLb1RUck5FUFA2WEhMTzBITXc2dWhpK3NpN0JEeEd5RzlI?=
 =?utf-8?B?eStncWlkbXZJYm43U3FOYUVYYXV5cTliUFp4Y3h6VGRhNitvbVNJQ1J2bk5i?=
 =?utf-8?B?V2EyUXI1RWxkSHhUeCszR0tYeDViSU1FYjNDdm9BeE5UbDA5T1dtaWFNb00x?=
 =?utf-8?Q?6hKw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 07:00:28.0942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28956892-4d06-40b3-099c-08de3a154c42
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4156
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
>   configs/am62ax_evm_r5_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
> index 64886986c4264a5d9272228e468f7057c195593a..3a9f382193532dc3b712a1bd3fa16a9c0de3fedb 100644
> --- a/configs/am62ax_evm_r5_defconfig
> +++ b/configs/am62ax_evm_r5_defconfig
> @@ -106,3 +106,4 @@ CONFIG_SPL_TIMER=y
>   CONFIG_OMAP_TIMER=y
>   CONFIG_LIB_RATIONAL=y
>   CONFIG_SPL_LIB_RATIONAL=y
> +CONFIG_K3_IODDR=y

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>
