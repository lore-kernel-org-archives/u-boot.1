Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39160F419A5
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 13:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDC0841C8;
	Wed, 15 Apr 2026 15:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EGl4dRhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D872841A2; Wed, 15 Apr 2026 15:09:13 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B265D83B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 15:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4QgBGNA1Gwf29PWQuKUwLtpvenV0qd0NnWp0a40Tl7jsFCj3KaBYB8om+6mCgNgy0jiw/yCpPZK30Y8GjvSeqLB4yJtkskUwClix895eY6T4mFUnJzMpNaw+xyqamErXa3B3iErL3c5XjBUC/xIO0cFay2z1tuULEu9kIOGEOtfQNW4w50r74IfY1tT/AMiQYIBeuzbXZHOMmYsp7Mb3ug+ZqvzSSePRm0DVYpEU0JunJzoBB+GzNY0YhGruFAVazfh2StFvLlEAPFSfyOCew74LhiRpt7JNJOUfSXZpACaffgYeWbxa0EnUGQCxKVgnaA6luyv0KQiI7tLuCVjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuhlMocUHEjaVZ1PBtSvzv9PxOT4fd0/RSDUQrE/+BI=;
 b=X7PEtSlru+CQd6h6kMQchzSTlSqGBjFoMVm0zVt43nWn7Nl/lY/5Kd2C6PLw7KeEKz2/WyRsdAwyFBijbf/yZDjFj7jjw7i4KXn/M4LYKFSHQ/nQpb5uvhk6J8N+2ojsZYta0TrGyO0TAmMpDOSCgeQhkY6JSa7rwC0gdYuQ4y4v/3h+gajmjyxXfiy6UTGZSXPk0QUs7hOGeTOkJkE43VdSoMP75m/G7ebw5Vv6ZOoDM8VWHSH97Mgi0ApseAxJswAJv/kN+Abohyx/ZO9PXLg0u5QcBvrQQhTzXCbXKJjDvqHzwjxLKbYci3M2uRrI2PraO0uhgxt7YxKdaU/GIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuhlMocUHEjaVZ1PBtSvzv9PxOT4fd0/RSDUQrE/+BI=;
 b=EGl4dRhuHwsgYTic92mX3LfBzAAoV0e5uKaRyr+KP+1jFuKtnIfh/GBexhDOpbasec5iwNtD6wX4HyezLqsCFoKseMR/TS5+Ka/BUWMMGNu8pbpZuWtwCAj1dVCoUJ4N8inpJSCzsmgvFVVogdb9SXRP1iuGwS4C+TCYyudpX+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 13:09:02 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 13:09:02 +0000
Message-ID: <0bf1fcf3-1eca-4a82-810b-58f02695f80e@amd.com>
Date: Wed, 15 Apr 2026 15:08:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: zynqmp: Register alternate FPGA device for
 zu63dr_SE
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Neal Frager <neal.frager@amd.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
References: <591134b1c66701fa14a21fecac4f7a772ddba876.1775558062.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <591134b1c66701fa14a21fecac4f7a772ddba876.1775558062.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee7e87f-1714-4cd9-d6aa-08de9af029eb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: h1lsIEpoHvn633tKDXfkXxCGH16iJs3WLBDcaNCl9lXm84OPhw1cJSVLMOwwxIZ5Ky1VViEzZg+JMvU6Yx/inwWmY7oo9OJDgcx5Q3onnyaYE0PK4o6BSM/n31uqc0ZRGhHakcYueIiHa8tRnHMeaHfYYx7OWKsIO9vQdNOV1pYSVIle1MdLwb3Mf/hxGiw5G8qTKa9m5rAMJaIHQeADQZojB2ZdJknBf5DkreDkUnWfWfiVzr15mYLYlcgKTgENxTzfigFdbE5YhOoSWgNtjTjanZyhjoRkXpwGIn7cXZcy2DTaIrl/US0IqTgvbKx3Q8V7hgv+IZWUcv1d1lfgujVKr8qQOkVzh5bpv4ZGi4eF4RHp8lgDXmScXV8eIppeEzfR2pVH1k+smG9ExTAYUQATTsFXQ9oe6M3tFI8dEAxBVV6804eje5jGDWd9jmUJ4jVYHwPEgZ4tX6NLp3CNVInu5wYdL6f56drVXE8L2Whof0vSwuRy7pcKp+h+jGfv5DQuM0sIXA1Rl7r8m6ORj5jkBifwQGyhheY9ryG/IZAY2i3+i2149s3vxS7sD/RBn318x7S62qR1iHr6wiUIe4I4DZ7eJO/mZ10GLL9WfyZblOIRbVXQotJKM+kWrstkc1XbXTvvNtDBkfSLRnJuKyo5hPZUw48a39yV0M9TzWQxtd2j7iRn0p1oz573zqSyOxNa474g6rjA0iHPciyHnNwEdAHTvzpyOlDH0KZiGOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODUwaExxSUlHSDVuQXdWZzhvUUlmWmxZanVPZmVPVVUvbHFyZVlJcUh4T2ls?=
 =?utf-8?B?LytodjJ6T0EvcWVnMWtxWDlvVTZTZ2ZRQzJoNE5iSkJQSngyQ2F6L3g2RzVU?=
 =?utf-8?B?WVdUYjJueFlMcWl2ZVNXWkUwOE9vSE84QnZQUUZ0eEFCSUM3VnptY3ZJQ1BN?=
 =?utf-8?B?ZE03UzhmN0xBazlVYm95d2ErQnpiaWxBaXNFNXdzODVNVDhFOUM2OW1vRi9M?=
 =?utf-8?B?STN6NmExcEx0UFgwaEc0cHlXbndJSmJYZzR1SVdNTWk2OEZIdmVaQkdYY1Rm?=
 =?utf-8?B?Q2tRMjMxa2dZdEF6ZnJFblplY1p4T2NjN1EwOGxsVFJkVlIrV3Azd01hN1ht?=
 =?utf-8?B?QkVnbXdSZlBPRG1NKzRJTXJkN1Rpc2YxVmVkVWlHcVd6ODJZbVhGR0hiaUt2?=
 =?utf-8?B?TmcvUlNIZkN6aHBxMEx3WDAwZ0s3ZTJ2UVZZV3pyMWFGL0VLN2JYa3pUOGl4?=
 =?utf-8?B?bHVabE9vNEx1bmFxZU94cFlmb1Z5KzZEZkpWc0lZaGRVWExMYUFaY1Avd0pB?=
 =?utf-8?B?cVdzQXkwbjJqTlRNcnhoSXI5Y0dqS1pOMWI5QmZhVFdiNTByektZRkhMU3R0?=
 =?utf-8?B?VnpvaWc3ekVnMEk0WHZ5VTBPTHF5dlJWZE1HU2xzTGt1ZXg0VHlYSkY1YzZw?=
 =?utf-8?B?QTRrRDZPL3lmSThISS96aDFhLzF0Z3hOQlNrWGtXUGRYRU5sdDBrckNzM2s5?=
 =?utf-8?B?ZURjUS92YkpxMWcvcisyUlc5Sy9SbUI1MWlVUzlmWWdvbFJXQ29hMkwyeVRK?=
 =?utf-8?B?OGpITkhTN1dHQU54RU1XUjB5SWZka2dDenp5Y0hKWnI5VW1kSEwvZ1UrNHhV?=
 =?utf-8?B?RXZpZEV1QVpORWwxa0ovUmlrYXVNendPeXlMbkxUTmdpMExQNlQ4MHk3S3E2?=
 =?utf-8?B?eG5HSTFLdVBURmRsN3hkVUp0Y2d2V2ZWQTFSTkFkcXBFdzZOdUxFeXZNWWVF?=
 =?utf-8?B?Z2dNRklVdFk5MXU3bjJVOFdGY0dZMDdhcmMwZDg2NXpEVVpSbHFiR08rSUpm?=
 =?utf-8?B?dFVoOVcwbGUzSU9RS0JKT1czK21KVklqa2xjSWZIR0VDWDlkVm02cDN5U0xx?=
 =?utf-8?B?M3lXVUo5MFl1TFRxVjRTeFVzZ2dGWFNzVjFzV2FRZmk3ZDlWb3B3YUVPM2lD?=
 =?utf-8?B?ejVjZGZwUElhRlRQSDgrcFVZMDFLMk0wWnpmRk52bTA1cTZ6eW5ZSlF5cmVi?=
 =?utf-8?B?SWNObHF3Zmg0UGhoaWZyQkx0ektwODVUMzUyK0JCVW1FaHY5MUxQSE5PSmJo?=
 =?utf-8?B?OWd1L1NWekRScjh6VGRWY0tpa3JQdkVZOStoZ0M5dTRMcGF5MWt1TktQRmJU?=
 =?utf-8?B?ZG03bFBVczhxSnFnQjQzeWRpVXZRaWFIQnUwYklGWGRYZEdIa0ViRXRlZXhQ?=
 =?utf-8?B?SUNVYlBZWDR5M3dYY2oyQzloV0p6cXRtRms3RUFydEloaWUxOVY2UVVJbDE4?=
 =?utf-8?B?Z3o0WTB5VEVTSUYvc25mTytJZGNqNXZnSWdQaldEaHk3SVVQVFE4L3hzYkp4?=
 =?utf-8?B?TVFKSTFBckdCcld2RytvbXBIb292S0FYVW1jc2xMRkVWZjhUYXlZSDRjdDd4?=
 =?utf-8?B?cUJzSzhHbjgzYS8vYy9rRmJZT2ROalQxMHhmTkdiay9mcFZRdkhqUGF4TnFN?=
 =?utf-8?B?cW1Ca1JCRHlTR2R5VWFZdmRBeWxYbEJXSjlDS1RrY1BTc2thcFZjRHlOeVlW?=
 =?utf-8?B?dmNZR0xXcTM0N0tCYXZXRFgyOGVPQ3l0Zml5VU5Fdyt1Z3ZRa2RlYUNRMWlM?=
 =?utf-8?B?NE0rdVZZZ2gxaEt4Z0VvTXBtV0NJSUlZdkZVanZnUEZRWS9Pc0l1SkZGU0lM?=
 =?utf-8?B?YnFZRGdoaFNIMGtTMGlMbFdGUE01OUdlcy81QzlzanNkMURVYUlnQm5VbENE?=
 =?utf-8?B?TC9iNUpPNCt3T3QwaHlzVzR3WTgwSFRHcTFvSHdnTzU2UFI5RjZJUmgxWi91?=
 =?utf-8?B?eVVtNHlmNFRIa3pHOEpvRkFQSTRQcWt2TXJ1UDVzb0hjWUd3SWF4YTlaa20v?=
 =?utf-8?B?algxbW9WUUJTbWtvVHN6WGRMR2djRzV3eHBxdWxnOWNsb0hnZTF2SmU5SkM2?=
 =?utf-8?B?ZndMLzFNU0kzZm1LSDY5aEpERk55eHRaUlF5UUZXcmJxWXBmdGJrRHlmeHdW?=
 =?utf-8?B?QmRVQWJuc29ibVgxbUZ4bEVFTnBxYnRKeCswRHpuN0xCVGV4SjZCU2FoWWVk?=
 =?utf-8?B?THZOU0daT3VyN29qTFNqaDB3Wndrc01kMXpxVDNTbTM5dzNqY010ak51K0Jr?=
 =?utf-8?B?Z1JhM0htYi9heXdUV3NLWXhRcGxRUVB6Z3pFYjExdW5SclAxNUxzL3d2UGlu?=
 =?utf-8?B?aWxMWDlxU3BCcGdtZlNLZFR4eStLaGUvS1N4dmZMTmZicWEybURnZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee7e87f-1714-4cd9-d6aa-08de9af029eb
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 13:09:02.0763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFo8h099l2E0UwZnih9J4v9lE++9aLgBYm59xA2I/v5LzBRh9l0XOuD1M6DtLDvr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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



On 4/7/26 12:34, Michal Simek wrote:
> The zu63dr_SE and zu67dr_SE devices share the same silicon ID code
> 0x046D7093 and cannot be distinguished at runtime. The SOC driver
> reports zu67dr_SE for this ID, which causes fpga loadb to reject
> zu63dr_SE bitstreams.
> 
> Register zu63dr_SE as an alternate FPGA device when zu67dr_SE is
> detected. This allows users to load either bitstream by selecting
> the appropriate device number:
>    - Device 0 (zu67dr_SE): fpga loadb 0 ${loadaddr} ${filesize}
>    - Device 1 (zu63dr_SE): fpga loadb 1 ${loadaddr} ${filesize}
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 769e52bcfb5f..a1d8ae266730 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -183,6 +183,23 @@ int board_init(void)
>   			zynqmppl.name = strdup(name);
>   			fpga_init();
>   			fpga_add(fpga_xilinx, &zynqmppl);
> +
> +			/*
> +			 * zu63dr_SE and zu67dr_SE share ID 0x046D7093.
> +			 * Register zu63dr_SE as alternate device.
> +			 */
> +			if (!strcmp(name, "zu67dr_SE")) {
> +				xilinx_desc *alt;
> +
> +				alt = calloc(1, sizeof(*alt));
> +				if (!alt) {
> +					log_err("Failed to allocate alt FPGA descriptor\n");
> +				} else {
> +					*alt = zynqmppl;
> +					alt->name = "zu63dr_SE";
> +					fpga_add(fpga_xilinx, alt);
> +				}
> +			}
>   		}
>   	}
>   #endif

Applied.
M
