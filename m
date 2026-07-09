Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48751C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 17:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B64284B8D;
	Thu,  9 Jul 2026 19:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TNpbp9K/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E92F984B9B; Thu,  9 Jul 2026 19:17:12 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D825C84B73
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 19:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPp6+Rr3ujk6u6w6iIkrvRN7xbGrd5umbELtUXkEoZxOmVWCOn80YxPvzxrkvdl1NtbpKazfa6hoDnAL7C8miCgn8f5TZjo2OAGq80MGh/R4jV1Het6wqaKeNCkE68/0p6MoDkSfhefxD5hPoC+81pVtdS001lWHKFv8BvZPmWmVHw3pWVsaVzv6BZvVQO7hwE4iHGkzruw79h1LT8V4Xh6w0miUxmh+lw7yVhlXw1Gdtx1R6WcOa3yFzcLl8Ule+gewFsSrwtUFxSTLk+IF77+EsjX6apQPbAmRjAme+HeZo34mv2szF4Nhx7SRIU4iNsc/68ohYF6Vd9i0owHUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiSgTmoSGdGw99m8wfP6zxs73eoLisIKKjrhd1BN2N4=;
 b=spnH1Y0locfjdUa2R6Z1NW6A8thzkjtqXuSnfSBjiRMgFrJ/qzUPU4Kshye9//b+Ys0T+1GitZnoXaDcV7UEzhpUdTk1i0hpeNbFhkrfk96+jMfdaqfdneU3Gi00ZQkGjrS3EuRELjmgPHtUc5H1CdYUqig6H8AdBY6/wEuoDmYnl6n007+z9/ZMl9wdnu1fBdfT+pNkd4rL75yHcYO3rsOyobyncqMnTY0x+FgVo73TZc1tKEgZWmtedfAt+FbCvo3e658SntrFO4zv6UlwVMgfgoYA+0nbUDFr7Es86UFfHs1XiNrYqPIKMgGG/fZF4Q/8bL51V2CtQ5F4c8lP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiSgTmoSGdGw99m8wfP6zxs73eoLisIKKjrhd1BN2N4=;
 b=TNpbp9K/wsEvrzNAg7RiC02x0DtLDcFUmKXP/UIijQ3djyZffmCVI08DdqRjOzX76ivtLPg6NjLdmhwyghD6MfwvPsu3bqReFZz8zLWb1tT8oCBkK4NmjWNMqPLU2R15vAJ6hhQySUDKG8f/vR16spt24RlzoBRW6/Bux8VZSfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8626.eurprd04.prod.outlook.com (2603:10a6:20b:429::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 17:17:07 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:17:07 +0000
Message-ID: <578ce91b-56a2-47e1-8acf-2f4b7e78c3f3@cherry.de>
Date: Thu, 9 Jul 2026 19:17:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: set M.2 NVMe PERSTN low in
 spl_board_init on Jaguar
To: Jakob Unterwurzacher <jakobunt@gmail.com>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
References: <20260625-pub-jaguar-puma-ringneck-tiger-v2025-07_nvme-v2-1-c57bf1020d63@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260625-pub-jaguar-puma-ringneck-tiger-v2025-07_nvme-v2-1-c57bf1020d63@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1PEPF00005B7B.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::613) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8626:EE_
X-MS-Office365-Filtering-Correlation-Id: fa92ec22-50e2-400d-00ef-08dedddde764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tRw3bFCgfZ+IELygpc7orosO7WwRmMlh406tp8T8EEkF1CAWDrTF5Y7ZHlm0vcfpo0dFIfzHJKj2aKtomp6G8nb7VDoevgnrFX36TyYd0mKMAQhVz3su5fviqArfYq56tcSWkpgxKyQ75sbdbhUHekcYLjvJ2JXMZuLLzqPWBEvCjSu0bUteHm8juT0jcHXByGhT3Y8KvlNJkNnYd1bNOyUliLxCOFtqHUhEv+MYTQQvAvvn2FKgpN/uT0BC6ETbewsf5+hdhfYSYhVRKLzSRyM6Z3IQuD957/W+m03IKR23kwvYFbB24sCayvP6AtG++tEIN+515cFGF2+F2OSOyr5nVeL3ludDT2YplLyYz20mBa2Y65yx9IphEbs5XnbpbjCaKTcY+H9ErnN0bRbmfnUm/NGjAN7BWmko+4k5CA+FGc26azC5eheDeUQL6XYrTmtDkifbti/LQAGGWBXTOiTwU1mzqmpFdf9+jrne1uFOvf0uWwJZH1IrP+Rrig/O62rVdQUU58ySX2TFO8DGlJsghEJBmFXz8/uvj7o+VGZwHi6s5sbgJIyhvrki1XNj1si2xBq8YpJvLeDa3qggXguokN4rMCatVHLqeE8OLdMxWqm/ZUc9ibPYEUThh3Zf/bPQDoyH4fJ8ma04z8IA3tyabD8oLcSWyKIhlAfuO2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFWOHZuenFtYStoVTBOQ3E4QzZwbDBBTUlHTFlTTlM0U3g2U0VkSWlyRkJX?=
 =?utf-8?B?N0ExK0YxL2xkVTE5VGU4LzRoWFNiQVhqRFdLVVhYa0JhTkJwQlZaVWs0aHFQ?=
 =?utf-8?B?L2NmdUZOY3R6RWNlNXJYMUk3QzJjc3JqaDJyY21nTStlL1FxcEdNSmFIMzR2?=
 =?utf-8?B?aXhuOUxSTExPWXpyQm5EdUdJWmZzUHJKT2NXbHU2a213bWR4dEI0TVFqU09r?=
 =?utf-8?B?MVBBVUt2TkdHMllHcXZLOExyMTRoU2V0Vi92N2gxTUIxbEZyVzBvd1k5dFhZ?=
 =?utf-8?B?RFFaSW14V2Y4NG5JMkJpY2s0OE5nbTBhRVdjSnZZUmRkWXd4VkJCQ1pVOVdN?=
 =?utf-8?B?YUpoamRWd29MbTV5TEZoL2cyYmtzN3ppVkQ0Vm5RUmdyOEVqMEJMNW5uOGVN?=
 =?utf-8?B?VnRaczRxUXUwbWxBa3RMcGxzQ24xYkY4Q3lFSnQxdURlWDJ0Y0l2QytzM1hO?=
 =?utf-8?B?Q3BMejVnNnk2a2lEdXhEOHJVVjAxYWYxOENhOXZocUlLTWplaE1UeWVBZTJD?=
 =?utf-8?B?ZWw0VUNnMW9VTSsrL2U1NEd1UTNsSWNyblgwNmdrOWN3ZVJYaHVydGpEZ0xa?=
 =?utf-8?B?dXNrMUZCZkdBVk4wUVdoMmRFa3ozb0tIT1Rqbys1bDdYZytMQnRhVy84NVlE?=
 =?utf-8?B?aGQvMjhHb25Mc3hIR25wYncxK0dUakEwcHpvMWhSYkpOZld6OFZxMVgzWGJ2?=
 =?utf-8?B?UzViOTA4M1o3YnhXeCtnOSs0aEFXZlNnZUFXL1F6anVCdWo1dDJ1cklDMWJn?=
 =?utf-8?B?a2ZjWFlqaGQvRk84ckdIalNyRThqZUtQVWZud1VXellIenpKbEN3MzFCNUM5?=
 =?utf-8?B?d2hTMjFXS2dmOGNBbFFJNzl0ckl4cXU0QkY3MVZNZHE4S0lXNmR0Zm9meUhF?=
 =?utf-8?B?V2xTQXBxa25COW9ldG1zeGl0ZmExT0VJaS9PbVhUUVlIS3REMVhJRVZhdndK?=
 =?utf-8?B?cGxrQy9qN296MmhrWnpyak8rVlp4eElKV2EyejBKS21JcGtDczFLWU14NVA2?=
 =?utf-8?B?OE5wakp3Z0RhcjJsbVUwTEU4QUFxZUVpSk5DL0JMVjRRaTVmSmlOcUNMSndO?=
 =?utf-8?B?N0U0QVp4Zm5iWnR3QmNLS2c3eUc1YTdVb2N4MnJsa0kza1hUczdDb2VQSlFs?=
 =?utf-8?B?UEI5UFBvYU1pakk0ZGlJYUVaVWVtbnJ4bndVMStmcDUxRHhqQm5aeDJvN2RV?=
 =?utf-8?B?cWV3bXZuQklxSnJ1djFHbURlQTJJM0p1VThYMDFOY0hGbDl0aTF5OVI0VTNY?=
 =?utf-8?B?L2NCQmVJSUdKYzh5UEFMSGZ1dlZ4RS9hWXZTMDQ0V2RVWWxzdHNoNWdvT0V0?=
 =?utf-8?B?bUI1TzNxVyt1bUV0VlZObG82YjRyT3dGU0ZXYWNKQkJYNFhaNCs3U3IyanA3?=
 =?utf-8?B?OHQzeHlUTC9GY0NhTXMzVURmc1cyT0FxRDdFdFg2WnVwVkRuTjF5ZFNvdVV2?=
 =?utf-8?B?VVIrMFFJcFhPczY3S0NPbFpwYys0eGZBcGVQN0g5T0dnTTNvV0lLQi9IQlha?=
 =?utf-8?B?V1UwSzVPWmY0S1dGdTNzaVVXZ1VLaWluVHd5eGk3aHZUZUJlZzBETU9DZ3RW?=
 =?utf-8?B?UHR6N1UvY0FaZlJxZkwycFBucHgzaXpJTHBOUVlzMytOSk1QcGIxNVFHa3NG?=
 =?utf-8?B?ak05Vm10VklDR3F3QUo5MzRVY1NHbGoySUI3eHhOcnlKZVBGUTNWZjljbzVw?=
 =?utf-8?B?aFExVVZLUS9pZ0VlWE5rSmxWZkNiRkRGdjBFSG5nQjFiemtZd2JUMTlpZjdu?=
 =?utf-8?B?ZWNrTytnMEF5TllrZE5DY3ZvOGw0ZzJXSi85N0dzVkx4R1RMaTMyRjR1eXhp?=
 =?utf-8?B?SHp3R3dCV0lXRlFnK2FJUXBTVE9GUStpZ3F2My9td1ZSMWhFTVE0bU82RWJB?=
 =?utf-8?B?RFV4b2RUbVJJeXA5YzBJa1lYeDRmUUg2NklnZkR1R2Zwd2g0cnZ5bkFMNE9z?=
 =?utf-8?B?VzZYZVhiY1ovOTRZZEEvenkycmhacDJMUDhhVnV3d0ZpVUI4QjhLSHkyL3k3?=
 =?utf-8?B?Z3psMVVVREphNXM5ajlnQVVqY2cvaTBIbW51TFhQRlg1RTlEV3J6ZVo4RjNr?=
 =?utf-8?B?SW5QZGI2cnhIVTJweElPR1ZHSTdSQmxIbVU4MXhZVVhXMnMwRGM1em9JV3RI?=
 =?utf-8?B?Y0lDNU5rd21tdGhEK3FwV3Y1QUgyOENaNjN5YWM3Z1BlemhpRW1hTU5HZFhZ?=
 =?utf-8?B?MWNycVI2RG85TnlGV1FaNys2OXcwRHMyLzY0anlEbXBhaTNrYkU2WTZVcVBP?=
 =?utf-8?B?UnlabzBuV0ZXVWZoT1BINHZaZVlxdVhZNG13bDdyZVFBL21IRHR0VDhTRHQ4?=
 =?utf-8?B?WUdqKzUzeVlsMU0vTW5zN2NrSXBNVDk4YzdKS252aUxqcWRwY3dhZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fa92ec22-50e2-400d-00ef-08dedddde764
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:17:07.5393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkIVqMDndWNFnLcP7KivQK+OnZsp54Oe+5cFuEHN3mkQ/OVOSFHtqTVfqRbZcOm4NNyI061oIdGwWuR55TnqVm1XJQaLodfPj7H16s8bQxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8626
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

Hi Jakob,

On 6/25/26 1:55 PM, Jakob Unterwurzacher wrote:
> From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> 
> As it is, an NVMe's built-in PERSTN pull-up fights against the
> SoC's built-in pull-down which results in an undefined logic state
> on the Samsung SSD 980 and likely others.
> 
> Fix that by forcing PERSTN low as early as possible, which is SPL.
> 
> Both Linux and U-Boot (via "pci enum") set the pin high later
> as needed and the NVMe is detected fine.
> 
> Oscillocope shots ("x" means undefined logic state at around 1.5V):
> 
> Before:
> 
> 	3V3     ____|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
> 	PERSTN  ____xxxxxxxxxxxxxxx_|‾‾‾‾‾
> 	PCICLK  ____∿∿∿∿∿∿∿∿∿∿∿∿___∿∿∿∿∿∿∿
>                      ^U-Boot     ^ Linux
> 
> After:
> 
> 	3V3     ____|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
> 	PERSTN  ____x_______________|‾‾‾‾‾
> 	PCICLK  ____∿∿∿∿∿∿∿∿∿∿∿∿___∿∿∿∿∿∿∿
>                      ^U-Boot     ^ Linux
> 
> With this change, the power-up sequence conforms to PCIe specs,
> except a remaining short PERSTN glitch. The glitch is about 400ms
> long. It could be shortened by moving the logic to TPL, but
> completely fixing it is only possible in hardware.
> 
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
