Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C1EFA0C32
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 05:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2621E838BB;
	Wed, 15 Apr 2026 07:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NCMATeZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D3E83936; Wed, 15 Apr 2026 07:56:26 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A68080077
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNBRDn8aCp1uvT/KT0Ba3potR3M5Zclx7xmmclTSzXJdN9PuQXZpthVX5xYsDGdo+Ljgteo16uB/RVr7ilDReaRSU+Q2MEmKKtjY4B6YcOWTiM4gMgUsCDeEb8V0KGJ/4OKDI96afDUpel8mISsrwCnSAHwc2Vky6j3Zy/QL1X+2Plp5HfjQiU0gn/GWVC7OIfT5EB+JV5S/wJmUdi8Hzl89T1VU8lL7sYOlQwGb1Fkx9qrq3riqbag5k+QrEw+a7gUmpso+2Gtx1WupIJwoXA2ysVgxxCoisYVY5cT7OfxY81QOkYGpBACUEt4uKxMQKHazKnejfqxs2OQrpIcxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNEWsYdUBN/YO5P7Dc/TjJ5HsNCMc/AVp83oMnzhYvo=;
 b=GrtOJN3pm2PFKZe72kMxx945fBQU/FG7cyjg5I75Z/oNTBCHpCO7mdONS69k1SAdU7ABR3GGo9eTIpTVle73Oos2ne0jncr0DEQ0ExiYsrwsabpip4nM15yHXb/NnKvONcWYjN5QOdrJqM2Dk64lRqInRdCgNW3lu/EU0Gitw8Oy7msISQo+cslv6d0QIc3foyPEUHG1/DPczw/lXOvw1CzWpJoB/Z4yyy46YdkxEkD8BtzjtixKgFl4EzjWdJBmmaqU7JCSHN9xDuvjyuE9S32EEudzvq8FrDr0Pddd0nFqauV7g396jDgQwht9cbvBZpsi+FxIDNxe5XXTsU/bbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNEWsYdUBN/YO5P7Dc/TjJ5HsNCMc/AVp83oMnzhYvo=;
 b=NCMATeZqjIkziuNsrdvk3/Bzm+hJkEAJx0D4Xdht2dZzlQd56kNO0QSB4AD7p83LW/6hd2aRXj8t85VmvvED/7nJaPoSGO5vZQpDtiYpQs/E56xjVMYRR0JelFLkv5BiohhXMl5CiYvhu+JBWaGTBWdP5y/pvD4SN6sahx2bbeQm/5Nfym7MCWKMXjJ5ZaxiNDroOZxrnnndASf28og+20vHuyM0mhnQ/l24q5lO/fyqOrCiTO0nS28EdTgYZ9NC4IPpGxhHntjy96rcqnDwgOH29fRlzUZRR8/JbIKy90aXcuHA7iTQ0bWcY2sTGaW2mD95Z2ZEbSEw+e3dPJZehg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DS7PR03MB5653.namprd03.prod.outlook.com (2603:10b6:5:2c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Wed, 15 Apr
 2026 05:56:20 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 05:56:20 +0000
Message-ID: <01fd5b84-a1c6-4dec-aafb-1a6acc0747dc@altera.com>
Date: Wed, 15 Apr 2026 13:56:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm: socfpga: Add SPL fitImage config match
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
 <20260304033029.10825-3-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260304033029.10825-3-dinesh.maniyam@altera.com>
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|DS7PR03MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c438418-1e4f-41b7-50bd-08de9ab3b76e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J/yG/P/qAcXT0BOwzZfV2J2D0ntUe/SNLqGuAeieG5Iak4kVt7EyQ6B/U6fct6PAAHEuQYo9E/SMJVuOfQyCMOu9SVXYzgcFFvlLBn2IYYQRMi+Q08X7ULCx5EQgBE7u5Ujnhv3ZYcgG9I5SMBn3V+B3jBHy1dlxXLtuH9N1a39B8TDlM+YjZrfHHX8L2BK6iCYyNwReSczy0dsnL5/KSMjXUDILsdG097CXpc5GA1K4weNoeJFMifcuvQW1AEKJ61HexMT4QXkZS/c9GoCkml9Rrf/dApkPxwnR88Z2sZtHceBCNZjeTHXtp2unFA/lagHtvOBx6nLHCpaO3LHdR6frNRkID4bdmCg+A5+O/UOQX0TMwGYbo33WfR9c0Cr3PzKtZn9Dp3FCo6afZwwvYPFHVOWHXqQ6En7HKL5s1rvoOu1NuRIdEsfX4WpjrF3So10Ig/xWwMzJJW7mbRnMcEsjyD2MROlm1JXG9aOkENjLieA3zVNPMntW85lLB731dvESUCHRYFLVSDL+pbSNsusp63wzJRgETQ1x6DxGTuZ2HLBfeHzTq5EF9nz/KQWNA0OC/v8fS/IOUNxp20UmknJWtyXWJhNBqRNQ4O/jmdvuRU+OhKl2vbapElWVZWCiL99aEcy2m02Xotl82unz7A82F42LVQZURNNHJ/HOmJe2F2glb79CNzzYyAEEspgmrlg9+2Q8ojjjDSG1tOXJUexMWXxLE3yFmyYj2BKw7Lg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djM4N3RDWU44Q29SRDZXWTFFU0JWZFpYejBrMlFIWnQ1M29BYzlHRi8zQldP?=
 =?utf-8?B?cGJaTDFCUktGVFpqY3F4NUh5ZGpLMkVBcUFTRnB1T3pkVXlaM1FmZE9WakFh?=
 =?utf-8?B?OHRmaFlvaUZ3VUlMbkh5alRJTzQwT204MWl4ekM4NE1EMEFNNlh0V2psdU1s?=
 =?utf-8?B?cUpTZzJtY1F0aWZ6eWhEalJSVUt3MjVaRXcxOFpzd2VtRmVERFI2Umd6MVQx?=
 =?utf-8?B?aUlzKzJDZmlRNkIwTWFLMThGYWxvZjU2K0NHeVJKVXIzNFpuNVlneVFJWHpU?=
 =?utf-8?B?OG9HcUsxSTV4amtObGx3cFpFK2NrS0pMN2wvTmlUUTVXSVMzL2oxY2J0STdL?=
 =?utf-8?B?R3hVdlpJd1RJci9DTUZoQlk5V2lCdzR2WjJQZkk5V1dSTS9oNnpJbnE3cnhV?=
 =?utf-8?B?WkJOTVp1clgrRGVtei94QzlLUTN2M1VGbEdlaDBmTWRrNmtrL3FwMEVLSk1G?=
 =?utf-8?B?R2ZwSGpzdjJNN3VrNnFVVmVRUkxnWjF0dGxMUkk4d1UrWWpGc212MFR4OW9a?=
 =?utf-8?B?bURhVzBTaUwzemRNWG5Ld1JRQ0l4eEdzeVZNRmFlcjJFdEM2eWhGSDQzbFhC?=
 =?utf-8?B?ajVscHMxRHdlRTBCaEZNUHlHdEJ2b2NmeGExc3QwamwybytTTkc2dThkdjg4?=
 =?utf-8?B?VHMrU1k2UzNSRTNMWFBWNkpCOVY2SzRZamtGQ09HdkZHOUg0ZVI0RUd1MnBY?=
 =?utf-8?B?dEQ2bjNJMktWUUxDT2Nza09peTdLSTJ4Z1ZQTlhEcUV5VFhtVjJpbDk1VE1Q?=
 =?utf-8?B?K3R0ckMzMy9lMHNUSDBvWDlnSlpRTEY2WUV3dGRSbkU3TzdxdHRXTnhVZlNs?=
 =?utf-8?B?L1RnKzdjNjRBNmdzNVVvYURDcm42TSt5MDlzMHR0RGludU1Yc1dyU1pqU2RO?=
 =?utf-8?B?ZzFBR0VjaGEreTRHNVZuTGIrUTVTR2tPbER3MmpzSnY2Kzl6WDlSclpEaC9R?=
 =?utf-8?B?endyQ3JnOEQ1Mzl0R0VoWUhWU2JoMm5qVUc3bjg1UzVtYzBENVJjWlFGUjZl?=
 =?utf-8?B?enV1RGwxQ2Fkc2JKWEMyZXNEa09hekd0cERtL1JBZ2lCSndpRWtieEJVU0Ft?=
 =?utf-8?B?NUJkNXpRbWpqSzU3V21JZFVQM2haVjdMaUdlWnZVZmhiK1F3VFA1QUxoaTVQ?=
 =?utf-8?B?L1N6UGd3WERhN3ExbUpZb2MzSXpxeDh3bVQ3SG1mZ0s2dnYwU0Q3eGUrbnM3?=
 =?utf-8?B?dUcvOEVSblRzbmFaUFF6MGRLMGV6ZEF2MGt5MGJTZkpVUEVuSUsvcS9BaTc0?=
 =?utf-8?B?Y0ZjSHVxeUpaWno4aldxRnhaRmlWdC9UWkRWdjBVcEZnQ1owZmowcXJPTkFD?=
 =?utf-8?B?VDZ1WFQxSHFpdUZLdVE1R2FuTXZxN0l5T200UEcrRDRianIzTFE3MVVtT2Za?=
 =?utf-8?B?WVB6aWpNb0MydERSNVBQeklVNzk3ZFU5NFE3a1kvVUhvc3ZZV1JlMHA0RHNy?=
 =?utf-8?B?LzFyRXNwSnNwOGVLN3VYNXBybi9rK0xTOWJUWm84dHoxQkljYUNxNUlJUTl1?=
 =?utf-8?B?cGtSaTk0VDY4Ylc2MnVYdVVkWURTWTBVWFBDV1pJT1YrVUYrcTM2NUUzWmRr?=
 =?utf-8?B?VzdlOEJIait3NEorcWNuRmpqT2Y1RW54Mi9oTUNxbklVbDR3WmZMU3pZdGlO?=
 =?utf-8?B?d2FOZ1N0QU9zVXcxaWZSTWxWUG1GRXIwcCtZWTJWVy9zdDJPcHJJSWpveXZZ?=
 =?utf-8?B?VjhkdXcvQmNlM1A1L1ZiZjF0UnFzNXFRbVRkRTJwUk1KVEYzVFYwSndmYjBh?=
 =?utf-8?B?QjkzZldEaVlzcEVGMVhYa3NxZUsyTzZVRkRjRmoySEdFSmNaZ3kzbU16c2VR?=
 =?utf-8?B?ekhaTUplZEt5aGVZS2FSTjRMZkdic0owWm9LQUVCRVJkWW96SjJaSW85a3ZO?=
 =?utf-8?B?Z0RRUnRkeTNmTDVzamlJNlJHTVF0aE1JdXEveVR3eGU5cGR3VDJqZlNhV212?=
 =?utf-8?B?UGVOOHNZUysyYkwyT2FzdzNleTh1WEMvUUliZ1FIYXdlRVlGU2NjVFZBSlNS?=
 =?utf-8?B?bVAzdnhIaHJVM0tlS2k4cUtJcThHMkRJZ29ESW56eFovdFBpY2N3enBVTTBi?=
 =?utf-8?B?RFVYZE9LR1puSm1mdUZ3dWR6NHZSZkhVdmFXWndoaVJldjhrQWh3dTlKSDBl?=
 =?utf-8?B?aXViU01zY3ZYR3k4VWhSN2VIM05NNEYxSjJuWW1TbXNjOWRiR0hyTldGQlEw?=
 =?utf-8?B?UXlmZzhZTkUwMi9qWm9JN2VQK0ZXVUIrUkR0S25HUzFMM3g3ZnRNa1hZVEwz?=
 =?utf-8?B?d1owbDJib3l5eU1LNWxHUXNibWxZYmZLSmUxYmtIVkxyaDRqUGl6bmd3ODA1?=
 =?utf-8?B?WHVLbS9JblhVZHZ0VW5KR0JqOE9pbzQ0T0lYTFVQeHV2UHNua0NhVnhSSEdo?=
 =?utf-8?Q?+8NvbZKwJDfZ2K4Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c438418-1e4f-41b7-50bd-08de9ab3b76e
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 05:56:20.3860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l/ji6LXcHLVp2Ej16SdwFlysZE5A7rcRNKY/XURT3ak6YXFpEHR91PKryWyirxb/tzCvaNtAgcgYgksHp3dMMOA+Kfc5QDnavjb1AX7G4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5653
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 4/3/2026 11:30 am, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>
> Add empty SPL fitImage configuration match. This can be extended
> if there is ever need to support multiple boards with single SFP
> image.
>
> Signed-off-by: Tien Fong Chee<tien.fong.chee@intel.com>
> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_a10.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
> index c3fd90de8c5..f2f82716ae2 100644
> --- a/arch/arm/mach-socfpga/spl_a10.c
> +++ b/arch/arm/mach-socfpga/spl_a10.c
> @@ -295,4 +295,12 @@ struct legacy_img_hdr  *spl_get_load_buffer(int offset, size_t size)
>   	else
>   		return NULL;
>   }
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	/* Just empty function now - can't decide what to choose */
> +	debug("%s: %s\n", __func__, name);
> +
> +	return 0;
> +}
>   #endif

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong
