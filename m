Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FDAD5E140
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE4288D14;
	Mon, 11 Nov 2024 09:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="fwJM6hqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9181588E17; Mon, 11 Nov 2024 09:20:29 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::726])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9248188A0A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dp4/sbQsQ4/qS24kzzMB8EPg1fCmiz/MKM3Oce/4Iwpakx3sSF5Fh8ioE4qHDaGT9l79xo0lHBh9ca6Xdx4mf9XuTtdhE3bK5++waVV5dmzO5BJI7OYQs5LcMQgBzpfNf1OS8S70NIMTXnnnTRDOnzjVSCbslnsikVTrYb5f3RvnPHTzhYmWUUzKBc9LOVKfckspYZcR3HAer6dxyC8MYwWnHLCXMUyQMd9RkJd1RtBYhe8aorc60lMdB4l2zmz1o96d00H0sIp+XDOJ8i3dsUnDQJZ8P4wcPKEvdwPxfMrfKWC1OJoHHvZBLVq65A25IFGnq7uHP5aCr30lwhJIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v605TF3g/GrzO1i1g1ijObuZmxBaqRPIFQ9bZvkYQ4I=;
 b=n1XhLMRWrLS82TlO3s3UC1VjmMRR9DwrKYFqIrVcBt1jkxxR4mYeeBPFQHwaXl1jBDZhBlrz6kRJrmHmiL0otWjNJu1PpV18CgS5cZqN7WSHI2OWI6z3OPAORLH9dPSvjjANLfmCyglUTslcjhrpKqUKQsMykgVxdN944mQR0hrzZzj0g5jhuS7cR5/ShUoOhv47dsgLLjT5IHmNGUlGr63M6pZYcEA4RCtD8Ty7L7rCwGZaeA6VF43KkaQ6whv9/OkVXPttjsE7OvChY5usA8Hp9pt20KafRcABlgshyJasox/N3F7N8f6p85VbrQ7b6KcJgLlsfaZw3VWnVHlACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v605TF3g/GrzO1i1g1ijObuZmxBaqRPIFQ9bZvkYQ4I=;
 b=fwJM6hqz9KcMnvEF8xP5u0StmLD8+oxo5zQGqhosxK8ALGuLFkwwGWYVHFGz7I8GDVKDNTKIzh5PWSqZYY3bO6iEE2qkKYIuv8N0ku9MVid15IOybVAqRD+fPchET5/MzT3Y7RJhchl1nuReDw2pDHDiOXGCSKGOuee3BuNkMwc=
Received: from DU2PR04CA0305.eurprd04.prod.outlook.com (2603:10a6:10:2b5::10)
 by AS8P195MB1953.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:570::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 08:20:24 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::70) by DU2PR04CA0305.outlook.office365.com
 (2603:10a6:10:2b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 08:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 08:20:24 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Nov
 2024 09:20:23 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Nov
 2024 09:20:22 +0100
Message-ID: <dc39488f-31bf-4c4a-9214-37bc2b164463@phytec.de>
Date: Mon, 11 Nov 2024 09:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: phytec: common: k3: Expose product infos to
 Linux
To: Daniel Schultz <d.schultz@phytec.de>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <upstream@lists.phytec.de>
References: <20241108181914.3358114-1-d.schultz@phytec.de>
 <20241108181914.3358114-2-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241108181914.3358114-2-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|AS8P195MB1953:EE_
X-MS-Office365-Filtering-Correlation-Id: c54cf296-f7de-4800-3d75-08dd0229b0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0dwcE5KZWgvQ3REMGxJRnNqUml4LzluYVN4MlozYkxKMXl5VmNNZG55QW1q?=
 =?utf-8?B?OFR2YTRVTkV0b2Z6c2J2aDFmRkdhQm9BalArWTE3OEVjN2F4dTNmOVhnTW1T?=
 =?utf-8?B?OGN3ZEduN1NuMklmRUpiUlJTRU56WWhuRVFjU2g5eUxFNndFUTlPSStuY0oz?=
 =?utf-8?B?cEl6YU9vaFBQbG5SR2JhUzlaVXZxNmVDNnBJRUJIVWpGelVIdEFUbWFiN2dU?=
 =?utf-8?B?V3RleEpJMjc1bytMQUZ4VDhPUTRpanhCeGRxSW5WZm1INHprWWI5eXFFUVZW?=
 =?utf-8?B?eG5UbWZnTXVHaWMra04rb3JNbWRwNkpkTGg2WWllUm4vRHBoOEZpclRzY2pn?=
 =?utf-8?B?UElkVGVXMkZDdWRoMWUyMStVa2ludmVpbFVOSzFWb1JhMStGMWRkQ2x1U2pw?=
 =?utf-8?B?NU1PT1FxVmFBSmd6WTBEWUNVUnpPOFZkbmJNM0hkTWZKdDJKOFNZQVlIRUxH?=
 =?utf-8?B?eSs5TWl1a3RLWVh1WFdMVjNZOUZ6YU1jOWNUdVNBM1hjYzVRUWJoWDVzUHY1?=
 =?utf-8?B?SFNOOWZ4anNHcXhxblppRXRuNk54a2NJZC9BZ3hhb2FqM0tuNmdrQ0pEeFkx?=
 =?utf-8?B?WWN5MHBHT1k4dGF4ZHBud3RUdmx5cCt4RGo2T2FFN1FNQ1lNTU9oU25wNU50?=
 =?utf-8?B?ZWkyZGdQMmZ3T3RKUDN4TkFJaWRsMXUwVlB0VmREdHA4Y2sxSll3Z2IwWnJK?=
 =?utf-8?B?RlBUaDk1MHY0RFRETDdVVzNTTllReUZTZUhxWFU1a2VtV3VBeHZkbUcxd1Z3?=
 =?utf-8?B?RTZBK3pUdk4xeEUycHcraHlDSCtqb0lPWThuWGJ2a25IOUtoNm05ckFFZmJw?=
 =?utf-8?B?RUptRy9GU2Z3VTBBRndKNW5BL3pYWmNrd2JlOXNkdEVFcnA4MjJRWU9PdS9L?=
 =?utf-8?B?U0VFZkZMWXhmRjYzOXVTNlYxN1djcm94S2kyeTFLdG5JYkd4ZkdRcVdldHdO?=
 =?utf-8?B?Z2FHTGlQcXB5cXRTWEhJOFJCQXNvQlNZeEUwc09odVB6Q00xOG5IdnJuM3Ni?=
 =?utf-8?B?M2VQSS9wR214WExBWUEyV25maUt0Ri95Mzl3MG9SSDRtQjVsUmVoOWRyZUVz?=
 =?utf-8?B?MHM5UEJVb0FjL1g0czZxUldjT1hnQUpzUERIWnFnV3hnTVZqbWlOWW9TcS9Y?=
 =?utf-8?B?dC9WSk9EL0JwS2lMOXc1bGFhWlNnL1ZtVFZhaWtvOFg5TTJJU3daQXJxV0JB?=
 =?utf-8?B?Nk5ZMGpHa01VOHFZck0zeDFSSzZ0eW5MYXNSbTZIeFR2UGhHbEVkVnJhcG5S?=
 =?utf-8?B?bUFaSmNtTkt1dVNWd1paY3RxSUF5ZjlsaE9pQ3I4Ymp4VzArV1QvWm5BYjIz?=
 =?utf-8?B?OXFxeThKOFJqTHJQYTFWcGNYcEJmN3IrZUlDWmZHRkltSDA5Ly9jUGlmREpR?=
 =?utf-8?B?Zmo4M0Z2SjVSV0dFcmZJWlhab2RkdmdPcDBQTzFNSW1kTXRqU2lQdXI5TnN5?=
 =?utf-8?B?S0w1RTU0OVkxWG96eG1SN1A3NXhKVStwRzhlV1VyTWFZZm53c09LRGdIbVhp?=
 =?utf-8?B?RzlQQ0g5M0Y5UzFHQzI5ZTFkVnhqVERrdmRQcXE4TmVCTGhoc0NnNmlXQUp3?=
 =?utf-8?B?TmhJNmoycVZ5VTZYQVZrcDdkNkUycHp0dmdqejZ3MnFIMGVzbW1XdGdHc3NM?=
 =?utf-8?B?WjdRUWYvNWRlaXJSeURqb081UXFoMDVaSWlucXRUbTN1dWRQRm9XaFBsUith?=
 =?utf-8?B?MkhMbC9ZOStPZXZWRzM0L3JKYUtWVWROYXF5RlZPNGdQcTVqTjdlNXdDdlcr?=
 =?utf-8?B?Sm5Bc0d1d1BuWnVGdG1YaXhyV3NER2lpbENzY09nbTZocldXU2IxYXhqeEVE?=
 =?utf-8?B?WSszRXZKSUZIMjlzcUV0S3FVLzRQRkhVL1E1NGpqM3BrR3JIUjNwb2hFSzBh?=
 =?utf-8?B?MzRjc2pQK044Q25pRXdyVW13Y3BVK2ZHTlZUYWtsaCtrS3c9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:20:24.0843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54cf296-f7de-4800-3d75-08dd0229b0e9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1953
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



Am 08.11.24 um 19:19 schrieb Daniel Schultz:
> Call 'phytec_ft_board_fixup' in the common K3 board code
> to expose the product name and part number to Linux.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>   board/phytec/common/k3/board.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
> index 3d7e090ccaa..14a10f34e53 100644
> --- a/board/phytec/common/k3/board.c
> +++ b/board/phytec/common/k3/board.c
> @@ -99,8 +99,22 @@ int board_late_init(void)
>   #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
>   int ft_board_setup(void *blob, struct bd_info *bd)
>   {
> +	struct phytec_eeprom_data data;
> +	int ret;
> +
>   	fdt_copy_fixed_partitions(blob);
>   
> +	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
> +	if (ret || !data.valid)
> +		return 0;
> +
> +	ret = phytec_ft_board_fixup(&data, blob, bd);
> +	if (ret) {
> +		pr_err("%s: Failed to add PHYTEC information to fdt.\n",
> +		       __func__);
> +		return 0;

This return is not needed. Other than that, the patch looks good to me.

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> +	}
> +
>   	return 0;
>   }
>   #endif

