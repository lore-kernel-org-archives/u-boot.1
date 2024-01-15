Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52314C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19B584694;
	Mon, 15 Jan 2024 10:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vco0ffHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD1186FB0; Mon, 15 Jan 2024 10:30:43 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CB4807AE
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWJ+fqYfoYS3ZOcgBjV1m2fa8ptS4Bsha+Fw43T03t1a4M4U2GzcvfDqLTDLDToPc/qKeKSO/VghYa0/OCKs3z50VMsInWKP7G6wfX0EalovrNsK2wPaX+HvzIqft0kepl/gFL7QOhkaMC903vW6URRQqlHtjNRWUhABYin50GNV8EfaHGiDrZKuaGtl3bBqOC02EItEuN0amB4nd16+vJQBy3rcgf4TJ8YAyRdkGV28SJhsjG4KyfjWEb/W/2Etc+SjGoN2qKuD86S08BDgflYFsToDhBh1AFa2gBAabIGsyZCodCwZyeUiN3xgVpeosD7LKl1CCvNoo5MRfedPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7ZMP1Zyu8jRjnFXR0G7GJ6j65EpJy9yc1D96VLxJPw=;
 b=UIPp/8+kFHEV8l2Dhi+P9tVOfm8QSXnJHj2gU8lfhXXAoCbfn7VRDyB+iOy8VOzijsZ8WYVO9lwqvY+02zffoqtXBFlLB7l9DX+F+BHUJM5ru40VVHWX3pqR1UG2+C0u69dPdWgS1zlhujL1iXylzMxOf9dGgSWNlYqwvx7d9kqEfEuys5J8yT7eyTeVPKYoKqJctclm/GexYctd32UAxzcvb8HaniTamgPMFjCfSgRCuQna0tENZV2aB6SJaYM4xLKqhGA9DZtnueE7Upo+pRFeLn9nc4fXTk/W0GIyYtOtwbrQ3gqQojJkMZeRssmzP5c1TOjrKgHXggoOb4dMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7ZMP1Zyu8jRjnFXR0G7GJ6j65EpJy9yc1D96VLxJPw=;
 b=vco0ffHbykNKrqswhtcGCz/n3tZuWHMv5A+P02QINDsHCktHu4HJSPoNPQ1bZ09TiYufB4RlOnFdnUtbVRtpqOUxBw8uvKPKfJ6IggzkfSz6QHpCiK6yw3rb8WUXF+fld1EG7o+KwjwvpvZhGyz+ndDRmFfCfUXz84Sny/9Ldkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 09:30:38 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:30:38 +0000
Message-ID: <3d3a4ffb-1bfb-4ca9-9e67-77ff6904daeb@amd.com>
Date: Mon, 15 Jan 2024 10:30:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add missing description for efuse
 aeskey/pufuser
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
References: <9975c501c92d8e9d6e307dfd3f4146e08a2fc68e.1704799551.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <9975c501c92d8e9d6e307dfd3f4146e08a2fc68e.1704799551.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: bf57757e-5e6a-4180-9dfd-08dc15aca266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfuGx5bJeNqrqAeZiavOxYh3dqaiaGIGda/IGAYwZ/u7GXZfZ5CEcC3wE/ynyMuus40YL7/p1kj0bvmzmCPwE9idbyUAXDZJb3GB6uBfwrZxt4t3URDPHXK5lubHyGKyD2eQ04SYui3DnKto5YkOJa94z5SHBkuHAbsLM9t5hzq45yRCYlLO+tU8AXSjsY/CqB2x7o3ftxD0Q70BxrtrI6SXr7PWzu7QhWQzd9J1nfDos0gjTZfju2BG4B1ritAd27VvwrRK5Or9mm/3TVicQTdbp+9smcECQxsZKWJOZZwe2ss4pSSynKzNyKn7Tyo63n8gNLTJvOZvs/KulJCSqjDQiNaM7m7V17IbwIjYiIdBX5eTc++Yec5K53gYoyLq7wLillTw1h4uTnWPjNxsAZRBssotrBMoCuoi+5O67V0cOiptoK4Di0gaaEmUSCIzzto9GVdO2PknpExUdDjh+eOXalhfadBUHrV1Drhq11khKrGxLojihowYQdS0jNCqHuXx3rUHHJUso5UuVdwKDbnkP9L/ZmnWptsSe0oenNmIoNbq3Uts60lvIIsCuuQKGEiqCfwQWduz1vEyMrkK62xJSnO7p4tUqO40grUWkQJPnRNhbwiQA2Q00Q0RryRls1blA5W7fWWujK4LzBx3ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2616005)(26005)(53546011)(31696002)(6506007)(6512007)(8676002)(41300700001)(86362001)(44832011)(4326008)(4744005)(316002)(5660300002)(2906002)(8936002)(6486002)(66556008)(54906003)(36756003)(66946007)(66476007)(478600001)(6666004)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0IrakttWWNDTEVJZE5OaDZ4dW04TWtJb0tqNVVOVlJJcTFQWCsyejFyK2s2?=
 =?utf-8?B?VzRydVQ5NHV0M2VrTFlmdEpiSGhRNFJWTXJtdlAzTFUzR2M5L3ZteVRHR0JL?=
 =?utf-8?B?THF6U1RmU3NuQnBocXErSG52TG00UGN1QVBHeHcrN0FRa1plM2tmRXlQQndv?=
 =?utf-8?B?RXdIR2UwRk8zUHBKN1FkNFkrbjMrS3RVUWRXaGN0NDNSNDFHRWpVQmU3aFhm?=
 =?utf-8?B?NWVzUkZoald2Y3Jta3FxM0hJSGUxNEdFS1lDdGVmSEFoQmp1TFErSjZLdkF3?=
 =?utf-8?B?UW1uTGlyS3dUMmp5ajlac25rRm5ieFl6Wmh2TXUyRzNhNmxwenNRaWIrR1J3?=
 =?utf-8?B?M21LZHRBWFhmcmd6bzJEOFZGY1U3bU1IVzhLY0xPQVB2em5sU3E4Z05IRXc5?=
 =?utf-8?B?clNFbWFhQzdSekh3UHd3NFpVOFo1Y1I1Z0IzUndkT1dwc1BqcVBJOFBGMERM?=
 =?utf-8?B?ZlpaTEJFNmpyTEgza0t4dEdVSmY1RDhQZTRaZTl5alpDeEhYTXhweHdBSmdN?=
 =?utf-8?B?QjNBOVcxNzRCMUI5QWRhY1c5TzNyd1dkYlJlWHhTTmgycmpCeVM4Z3dyVHFL?=
 =?utf-8?B?SUJTWHNzNGVGOW9CWmEvRlhlWTFORzhOeTQzdU9oQVVnSmlTdGwvYzFlMVFx?=
 =?utf-8?B?UUFObkVVT2RSTHVoV3RtTjRHNnVPd1hvZlAvN0dyaXowc2Rxa2F6L1lBcjR2?=
 =?utf-8?B?RUp1OWdlTWlUckZ0VExVU210R3RFWjgvUVhNclRGSWt0QXpOc1BXbERpTVI4?=
 =?utf-8?B?eWlrTFBlb3I1VzdDdXU0U3BVWlc2dk11N3JIREpsek9GWUUxQ0dBSG4xRmVQ?=
 =?utf-8?B?YW1CKzI4dGQrc0c2SVYwaTlxcjVXSFBvTFFhUXVtZXIyQlhsRFZ4ZmN5VUx0?=
 =?utf-8?B?allSajZJQmdmTmRlS2pmK3NYeHdoSUw0NnZwQXFXNm9ZdGtHTU1FQURPZDlW?=
 =?utf-8?B?UkVTUFNqTDZpR2dDeG1WZm56a0VNM2NHb1FpUzhDcjFRR0M3a0hyS1FpOHp3?=
 =?utf-8?B?c0dmdzFQbEdwQzZZcTB2OWVOeEtOeCtaRVdvN2Y2aE9McUdKQjBNWk9oK2FU?=
 =?utf-8?B?L2lJRmg0WmVHb2RGK1VlbmFpcUVEbGRuM2JSOXJpS2pvRy8xcDVjTWxWVkVT?=
 =?utf-8?B?STBGU0xoU21RZTFIRWpib2pzdkRsUnpkZG9pNkdqZTNaZU9FTmhLU0Nuc0Y4?=
 =?utf-8?B?SVE2ZE5YSk9qUURLOTN3U0M5RGhPTG1qR0NUNHRObms2d3NLbXN3aENwRU5W?=
 =?utf-8?B?R21OZFhkS2tVVnRJSHA3Wnp3dzV2Z2tFQ2pzby82RkYxUk01WVFtVTBtd1Bu?=
 =?utf-8?B?eVk2aWczTU0wOHl0RmtyMjhUQ2pQZDRFM255c2N3YnJaTU1aTEN1RXZqQ2hC?=
 =?utf-8?B?SzZoZW1TMkkrdGFoYWo0bGJVOVJaOXNRMC9oNkQrK0FqVGEwM2xYZlVpSmJE?=
 =?utf-8?B?TmEzQkJTWmdmTXlBT3F5dGt1OWR6WjdaSm5EeXZsWVZ1akJxZHBicGxUNFNK?=
 =?utf-8?B?U25rQjNEcWNwNXZMcW5jTDBmeGdHOHcvbUJQa1lMcFNwTVN4eEU1a1lyaGpL?=
 =?utf-8?B?WkRxT0FCRENlamxldHJGKzlkY2txQXhHOVlUL0Q1MWRsZDMvQ2pwRy9LMlla?=
 =?utf-8?B?dCt3REpNRm9ZdytGT3h0TkYxVnhWWFRMZTNHUjluZmloSEt1VkxhekwzSXhE?=
 =?utf-8?B?SWxBU00ydGZFdi84UTlLbFhSeEs2WnZLU043eFVhQ1JZMSs0K2NURUtYREUr?=
 =?utf-8?B?VnBCZFlOQUZtVmMxekRNSHlCY0pDaUVzdWFSUzlvbU0xVXFuQkxHN0hqT0Rx?=
 =?utf-8?B?WThTRDVxYnJROTRVemVEL0JmaDZYUTQ3WlFxQUNpWllxMlB5d3dHR3ZmUlp6?=
 =?utf-8?B?K1pkZklyZy9GT1c3Y3BhUEZkZXNwcGdyeWVmQU1nTE83dVIxRkY4WjBlaTlJ?=
 =?utf-8?B?Vko1aEpYRk9MRHc0aERvWWtVbElEbExhSUJyV2RhR05LRDlGS2hwSVo0dmZC?=
 =?utf-8?B?QzF1dDFDZmdCSFJwb2swK0FybDdabW05Q2l3MlgrclZ5a0N2ZlN5RkFZSUJ1?=
 =?utf-8?B?enMvOEVmeFBORFBiZTZwa3JSWUlxcDZHOG5XdjVDT1JUdy96aENsa2ZGVmdo?=
 =?utf-8?Q?ew3JOzT2HXc4iIrS4y7oqsP94?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf57757e-5e6a-4180-9dfd-08dc15aca266
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:30:38.4875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hks9VB7XZbmMqGsyhU04Xfb0as9Cfmd2uGtEX+etVHFXpXWf2t6uhSoYx92AI6o5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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



On 1/9/24 12:26, Michal Simek wrote:
> Add missing description for efuse aeskey/pufuser offsets.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 21be909b1abe..f31f244ba77c 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -258,12 +258,18 @@
>   				efuse_spkid: efuse-spkid@5c {
>   					reg = <0x5c 0x4>;
>   				};
> +				efuse_aeskey: efuse-aeskey@60 {
> +					reg = <0x60 0x20>;
> +				};
>   				efuse_ppk0hash: efuse-ppk0hash@a0 {
>   					reg = <0xa0 0x30>;
>   				};
>   				efuse_ppk1hash: efuse-ppk1hash@d0 {
>   					reg = <0xd0 0x30>;
>   				};
> +				efuse_pufuser: efuse-pufuser@100 {
> +					reg = <0x100 0x7F>;
> +				};
>   			};
>   
>   			zynqmp_pcap: pcap {

Applied.
M
