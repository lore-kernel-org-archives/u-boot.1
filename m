Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF00D5E392
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B58892ED;
	Mon, 11 Nov 2024 09:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="BGgt9OEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C8F289300; Mon, 11 Nov 2024 09:35:15 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D0688AE8
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cphv/eyHlJZH2U73/RLLai99z3LFfdPVKLve+2W6dkz/XcdmFSbHPMQyepwT1wLE6LWMlOq2P5wi7aKnbYD2YKgAG3I1kF2ZDPu8FAwsYgv3g2SqguUHsJ6T+IH2pYjxFHTnvbgtp4uLM6VJjHCAFev1eqbfLebhvnb24DqLxFBtIuBl+Z5NMRnT1TXEaWz9S9W3D0muq3rJ8dsH4JquUtdGsLM+QqefoqWhOdOAQCI2mpRQ02f4/o7VqT4pkwzCiZoOuDofF7tZCyzKuZsGNL+2/GkuJSSbFVbBLVBCPyhmBv+xPSisbLCcWKMAlEKFcWvq1r9bOXY9pCara0x10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+33k28MNBDLLqNp1ISDFDpoxzU9pwtn1FVmej0UB9rU=;
 b=vTT5FtN4rdhV2/+/hCWcTgiBvkel0BOaykHznZwAv5lJ1ddqROpdbFJxx4k5qvMPO47hm3l2WQRzM1QomLPZF0EAOqquFbC+LpwHPqqmnUu4s/izFbfscAx0YYe5+NHLpe8Mu33PZlzjwxZ00wgCNXcuX3SAC5ErEnYRz482lNxEyWz9orjNLTkJZjNduiHfxxifIOcFjHTkFMptjZfdQYVtOnFeajRnFl9zZdBr/QJFGQhL8w7NDL6OJ60Wa19R4rQNKz3kT5BLZSo2JJgjPSIZQdbiGbUXbDQZBn9CZuGzRs8onhAbtgd56F90cL1X5a3knkuRBjhg3hvrhh05yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+33k28MNBDLLqNp1ISDFDpoxzU9pwtn1FVmej0UB9rU=;
 b=BGgt9OEU/qYn3gQ6+WvLUNrQqroFcMqVln2UXdgOSXhaB34ndxgreTKVluR3qVleSGhxr7Iy6ORovp+xHJzOfE4vpprMiOhsS2BKbkfzNxGOuTbSU2Tqi4fzCpj3KD0kj8i52KkrpOSPe1RiWfpSLD2Q1zy6b2Ar6AO0lvIEpXw=
Received: from AS4P250CA0029.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::19)
 by AS8P195MB2189.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 08:35:10 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::db) by AS4P250CA0029.outlook.office365.com
 (2603:10a6:20b:5e3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Mon, 11 Nov 2024 08:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 08:35:09 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Nov
 2024 09:35:09 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Nov
 2024 09:35:08 +0100
Message-ID: <45c4a3dc-61a7-4dff-b2a9-722ea83c0b6d@phytec.de>
Date: Mon, 11 Nov 2024 09:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: phytec: common: Add product information to FTD
To: Daniel Schultz <d.schultz@phytec.de>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <upstream@lists.phytec.de>
References: <20241108181914.3358114-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241108181914.3358114-1-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|AS8P195MB2189:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ddd3738-52fe-4dae-d4f0-08dd022bc0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0tpQ29jMjVXNTEvWGlhc1JXYWtNWjZ3K3E1OWpHZFptQ2RoaWlxYzhGcnoz?=
 =?utf-8?B?L3h4MnhNcElUaWpxSjhvTmsyTnhSdEdWSmdqNE9uZCt5NDBreWlocTNVelpN?=
 =?utf-8?B?cWRDL3pwdkd4TEVKNXRlcTYrVXpGOFV4Y2dRaXZLYmh3Vk9YMEZ2RW1ENkdK?=
 =?utf-8?B?cG54ckVJcklWR0IwUjFnOGd6VXk5V0ZqTUVoQlFHTEhXOVZCZ3ZXaTlucWZ1?=
 =?utf-8?B?K0czZFBLTVZQZVFBZ0ZtbEtRSklsd1pRZVNFMmhDOXVIWlloYjUrd3ROaHVu?=
 =?utf-8?B?eVpUZks5a1dlL05rYzlUdjhoaUZuUlE2U2NJVUt4SlRlZ01ldGtldjdXNk0w?=
 =?utf-8?B?MStuWHlCMUdLVTFPRnhDV2E2ZkhJZWwvc1hoM3ZRQmswTDcvY200Sm55VXhT?=
 =?utf-8?B?MWNlQnJGK0xWWVpCMXhGVmI1NncvaXVCdDk5Qm05WXpNczVYSHMyZ1REZFRS?=
 =?utf-8?B?TmdxcG9HVzVkMXY3aGlIQ0ZmYmxkM2MycTl2Nk1xcS9QMUd3QklTd3NVRFlD?=
 =?utf-8?B?U0FPK21ackZjOURSSnI3MzBnZ2V0QUVkOFpDUU5CYVJUUHZJOEdSNDR1ejEz?=
 =?utf-8?B?WkZreUIvUWt0VTQ2VkZWVTBDUUpOLzNFUStIU29WbUVLS0ZUTDVqRXlVWVlu?=
 =?utf-8?B?QUhnWXo2MkhpRTBXaHAyV3RqN2JDQy9kVjBJUWNlVWkwWEhrMW1BVXdUdU9m?=
 =?utf-8?B?UGxoS1l3b3hOYXcza2RBL1l2Sk9rWkhxb05zbjZZUEgxWnV3d0dvMmRNYUpv?=
 =?utf-8?B?UDl5NmdzZzA0bVAxK3lST1BvS0hVbzdDV1ZBdkNFbDl5Wk5pSTFZUWUwb2Nw?=
 =?utf-8?B?aURRVHZncHZMeHFtMUF1UUt2b2ZBci9VQngzMHFoVVpYRmFJbFpEcFNzV3hX?=
 =?utf-8?B?S0Q1NTFEVG5CTGh3a3RmaTR5TjBhOFVFdjY5S3NaTmZuUE1GVmtndnExWmZJ?=
 =?utf-8?B?N2d1M29nZHp4T0poOWV4enZ1S0ZPbVd5di9iOE0wanZWbVVPTFZjYk5DTFQ2?=
 =?utf-8?B?dE9JZk5EMDZyVWJVVjNSNTk2TkxaQWU2RWFVTm1SK2hib0tDNkV2QTZrcTBT?=
 =?utf-8?B?dmRHaDN1SmFkV2o0M041dCsySkhWUkpDY2NZcFg1YldiSVN2b0VGRDlPU29O?=
 =?utf-8?B?WVZpSVFNQzJKdzlUaGJFRDlpd1lsSCt5TEVIZmZGWDRSYUZ2dXZjUE52Umd2?=
 =?utf-8?B?a0p5UDAvY1U1ZjJDRE41WE5BZGE1NWJIUW1wWTRTYWt0QVZBVER4cjlSM1Zw?=
 =?utf-8?B?aWlDbm9ld05CdnRaSW5IQUJ0bmUxMHVWTUNVbXJBZjdDemRCNGtRSlBrSjVS?=
 =?utf-8?B?aGpza2RucDd4N0tiVFphVmU4OSthVVgzQ0VjWStkNkZsR294bmZTVGh3Nnpz?=
 =?utf-8?B?S3hLcWZRUlVDN3grWlVpQnRMdVJ2M2h5S2p3Y0FZU2xsU0dnZ1FKTllQejFi?=
 =?utf-8?B?dXhrT2NHVXBhTFV4RVVyWkhEeng1QWhOaVlnbHlhVjFtS2U3dVFGc3dsZEVW?=
 =?utf-8?B?MlVmNCttS3NpS1B3ejFCa2s5MFg0aWU0OG9QSlRkS1V4YW8zTU9zL3lNZDIy?=
 =?utf-8?B?Y1k4NlorVzJpVit5cEZpY1RkM1pvRHBBYUpnaEJnekZtK0tNWHpKKzNoUC94?=
 =?utf-8?B?eG43YnRPbk8wVHNDUGIraGJwUEYwOTc0SVpWc0JoSjJmRU9FUGVGZGtyeFVJ?=
 =?utf-8?B?ZFNDaDZDM0wwNU52aWIzZzhJVzhYQ3Z1YVVqOUxudVRGVUFGRXpSTFNyNWRT?=
 =?utf-8?B?b2dCVUtHZkdNazFkdmtQeVFaakxrRlp1TzZKa3pZNDVpZ0RFdDZVS2FlQ29i?=
 =?utf-8?B?MWNuQWdReHpxMnNkbFJ0RUxud21zd09SeWlUOWtieGJQcGNISHlzT3E2L2hj?=
 =?utf-8?B?OE1sRkxHcnc0c2hxR2ZvTllTRURSdisxYWw0NVBqWEJrS0E9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:35:09.8844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddd3738-52fe-4dae-d4f0-08dd022bc0de
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2189
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
> ft_board_setup inside the board code allows to alter
> device-tree during the boot process.
> 
> Introduce a new function for the PHYTEC SOM detection
> to read the product name and part number from the EEPROM
> content and include both into the device-tree as
> * phytec,som-part-number
> * phytec,som-product-name
> 
> This function can be called from the board code when those
> values should be exposed to Linux.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>   board/phytec/common/phytec_som_detection.c | 204 ++++++++++++++++-----
>   board/phytec/common/phytec_som_detection.h |   7 +
>   2 files changed, 168 insertions(+), 43 deletions(-)
> 
> diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
> index 166c3eae565..ea439be5163 100644
> --- a/board/phytec/common/phytec_som_detection.c
> +++ b/board/phytec/common/phytec_som_detection.c
> @@ -271,11 +271,126 @@ err:
>   	return ret;
>   }
>   
> +static int phytec_get_product_name(struct phytec_eeprom_data *data,
> +				   char *product)
> +{
> +	struct phytec_api2_data *api2;
> +	unsigned int ksp_no, som_type;
> +	int len;
> +
> +	if (!data)
> +		data = &eeprom_data;
> +
> +	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
> +		return -EINVAL;
> +
> +	api2 = &data->payload.data.data_api2;
> +
> +	if (api2->som_type > 1 && api2->som_type <= 3) {
> +		ksp_no = (api2->ksp_no << 8) | api2->som_no;
> +		len = snprintf(product, PHYTEC_PRODUCT_NAME_LEN, "%s-%04u",
> +			       phytec_som_type_str[api2->som_type], ksp_no);
> +		if (len != 8)
> +			return -1;
> +		return 0;
> +	}
> +
> +	switch (api2->som_type) {
> +	case 0:
> +		som_type = api2->som_type;
> +		break;
> +	case 4:
> +		som_type = 0;
> +		break;
> +	case 5:
> +		som_type = 0;
> +		break;
> +	case 6:
> +		som_type = 1;
> +		break;
> +	case 7:
> +		som_type = 1;
> +		break;
> +	default:
> +		pr_err("%s: Invalid SOM type: %i", __func__, api2->som_type);
> +		return -EINVAL;
> +	};
> +
> +	len = snprintf(product, PHYTEC_PRODUCT_NAME_LEN, "%s-%03u",
> +		       phytec_som_type_str[som_type], api2->som_no);
> +	if (len != 7)
> +		return -1;
> +	return 0;
> +}
> +
> +static int phytec_get_part_number(struct phytec_eeprom_data *data,
> +				  char  *part)
> +{
> +	char product_name[PHYTEC_PRODUCT_NAME_LEN] = {'\0'};
> +	struct phytec_api2_data *api2;
> +	unsigned int ksp_type;
> +	int res, len;
> +
> +	if (!data)
> +		data = &eeprom_data;
> +
> +	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
> +		return -EINVAL;
> +
> +	api2 = &data->payload.data.data_api2;
> +
> +	res = phytec_get_product_name(data, product_name);
> +	if (res)
> +		return res;
> +
> +	if (api2->som_type <= 1) {
> +		len = snprintf(part, PHYTEC_PART_NUMBER_LEN, "%s-%s.%s",
> +			       product_name, api2->opt, api2->bom_rev);
> +		if (len < 11)
> +			return -1;
> +		return 0;
> +	}
> +	if (api2->som_type <= 3) {
> +		snprintf(part, PHYTEC_PART_NUMBER_LEN, "%s.%s", product_name,
> +			 api2->bom_rev);
> +		if (len != 11)
> +			return -1;
> +		return 0;
> +	}
> +
> +	switch (api2->som_type) {
> +	case 4:
> +		ksp_type = 3;
> +		break;
> +	case 5:
> +		ksp_type = 2;
> +		break;
> +	case 6:
> +		ksp_type = 3;
> +		break;
> +	case 7:
> +		ksp_type = 2;
> +		break;
> +	default:
> +		pr_err("%s: Invalid SOM type: %i", __func__, api2->som_type);
> +		return -EINVAL;
> +	};
> +
> +	len = snprintf(part, PHYTEC_PART_NUMBER_LEN, "%s-%s%02u.%s",
> +		       product_name, phytec_som_type_str[ksp_type],
> +		       api2->ksp_no, api2->bom_rev);
> +	if (len < 16)
> +		return -1;
> +
> +	return 0;
> +}
> +
>   void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
>   {
> +	char part_number[PHYTEC_PART_NUMBER_LEN] = {'\0'};
>   	struct phytec_api2_data *api2;
>   	char pcb_sub_rev;
> -	unsigned int ksp_no, sub_som_type1, sub_som_type2;
> +	int res;
>   
>   	if (!data)
>   		data = &eeprom_data;
> @@ -289,50 +404,14 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
>   	pcb_sub_rev = api2->pcb_sub_opt_rev & 0x0f;
>   	pcb_sub_rev = pcb_sub_rev ? ((pcb_sub_rev - 1) + 'a') : ' ';
>   
> -	/* print standard product string */
> -	if (api2->som_type <= 1) {
> -		printf("SoM: %s-%03u-%s.%s PCB rev: %u%c\n",
> -		       phytec_som_type_str[api2->som_type], api2->som_no,
> -		       api2->opt, api2->bom_rev, api2->pcb_rev, pcb_sub_rev);
> +	res = phytec_get_part_number(data, part_number);
> +	if (res)
>   		return;
> -	}
> -	/* print KSP/KSM string */
> -	if (api2->som_type <= 3) {
> -		ksp_no = (api2->ksp_no << 8) | api2->som_no;
> -		printf("SoM: %s-%u ",
> -		       phytec_som_type_str[api2->som_type], ksp_no);
> -	/* print standard product based KSP/KSM strings */
> -	} else {
> -		switch (api2->som_type) {
> -		case 4:
> -			sub_som_type1 = 0;
> -			sub_som_type2 = 3;
> -			break;
> -		case 5:
> -			sub_som_type1 = 0;
> -			sub_som_type2 = 2;
> -			break;
> -		case 6:
> -			sub_som_type1 = 1;
> -			sub_som_type2 = 3;
> -			break;
> -		case 7:
> -			sub_som_type1 = 1;
> -			sub_som_type2 = 2;
> -			break;
> -		default:
> -			pr_err("%s: Invalid SoM type: %i", __func__, api2->som_type);
> -			return;
> -		};
> -
> -		printf("SoM: %s-%03u-%s-%03u ",
> -		       phytec_som_type_str[sub_som_type1],
> -		       api2->som_no, phytec_som_type_str[sub_som_type2],
> -		       api2->ksp_no);
> -	}
>   
> -	printf("Option: %s BOM rev: %s PCB rev: %u%c\n", api2->opt,
> -	       api2->bom_rev, api2->pcb_rev, pcb_sub_rev);
> +	printf("SOM: %s\n", part_number);
> +	printf("PCB Rev.: %u%c\n", api2->pcb_rev, pcb_sub_rev);
> +	if (api2->som_type > 1)
> +		printf("Options: %s\n", api2->opt);
>   }
>   
>   char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
> @@ -379,6 +458,38 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
>   	return data->payload.data.data_api2.som_type;
>   }
>   
> +#if IS_ENABLED(CONFIG_OF_LIBFDT)
> +int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob,
> +			  struct bd_info *bd)

You are not using bd parameter. Please drop it.


> +{
> +	char product_name[PHYTEC_PRODUCT_NAME_LEN] = {'\0'};
> +	char part_number[PHYTEC_PART_NUMBER_LEN] = {'\0'};
> +	int res;
> +
> +	if (!data)
> +		data = &eeprom_data;
> +
> +	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
> +		return -EINVAL;

The checks above are already made in phytec_get_part_number() and 
phytec_get_part_number().



> +
> +	res = phytec_get_product_name(data, product_name);
> +	if (res)
> +		return res;
> +
> +	fdt_setprop(blob, 0, "phytec,som-product-name", product_name,
> +		    strlen(product_name) + 1);
> +
> +	res = phytec_get_part_number(data, part_number);
> +	if (res)
> +		return res;
> +
> +	fdt_setprop(blob, 0, "phytec,som-part-number", part_number,
> +		    strlen(part_number) + 1);
> +
> +	return 0;
> +}
> +#endif /* IS_ENABLED(CONFIG_OF_LIBFDT) */
> +
>   #if IS_ENABLED(CONFIG_CMD_EXTENSION)
>   struct extension *phytec_add_extension(const char *name, const char *overlay,
>   				       const char *other)
> @@ -458,6 +569,13 @@ inline struct phytec_api3_element * __maybe_unused
>   	return NULL;
>   }
>   
> +#if IS_ENABLED(CONFIG_OF_LIBFDT)
> +inline int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob,
> +				 struct bd_info *bd)
> +{
> +	return 0;
> +}
> +#endif /* IS_ENABLED(CONFIG_OF_LIBFDT) */
>   #if IS_ENABLED(CONFIG_CMD_EXTENSION)
>   inline struct extension *phytec_add_extension(const char *name,
>   					      const char *overlay,
> diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
> index 5e35a13cb21..db232cdec48 100644
> --- a/board/phytec/common/phytec_som_detection.h
> +++ b/board/phytec/common/phytec_som_detection.h
> @@ -8,6 +8,7 @@
>   #define _PHYTEC_SOM_DETECTION_H
>   
>   #include "phytec_som_detection_blocks.h"
> +#include <fdtdec.h>
>   
>   #define PHYTEC_MAX_OPTIONS	17
>   #define PHYTEC_EEPROM_INVAL	0xff
> @@ -17,6 +18,9 @@
>   #define PHYTEC_GET_OPTION(option) \
>   	(((option) > '9') ? (option) - 'A' + 10 : (option) - '0')
>   
> +#define PHYTEC_PRODUCT_NAME_LEN		8 + 1
> +#define PHYTEC_PART_NUMBER_LEN		PHYTEC_PRODUCT_NAME_LEN + 14 + 1
> +
>   enum {
>   	PHYTEC_API_REV0 = 0,
>   	PHYTEC_API_REV1,
> @@ -86,6 +90,9 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data);
>   char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
>   u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data);
>   u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data);
> +#if IS_ENABLED(CONFIG_OF_LIBFDT)
> +int phytec_ft_board_fixup(struct phytec_eeprom_data *data, void *blob, struct bd_info *bd);
> +#endif /* IS_ENABLED(CONFIG_OF_LIBFDT) */
>   
>   #if IS_ENABLED(CONFIG_CMD_EXTENSION)
>   struct extension *phytec_add_extension(const char *name, const char *overlay,

