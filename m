Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E44CC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F68D84694;
	Mon, 15 Jan 2024 10:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KXDDPSqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71032807AE; Mon, 15 Jan 2024 10:29:27 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B2686308
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC0b6XC7j9PgZjsUphWN/MJ2vt59gvEJJfZ7y1n0o9WY9aqLPVzfATGgMkXNDMROI+hoiqV2rgWFGUMB6jw51dPBUV+LgXtBndel2Xu+KJkwipVRBFrsrQETeaxyUStwQGgo5k1DeTOqgzinaw3kJqdNG+glm1dppAztfODGPPtWJKGTCc0d26k/9odpVGr4XjJSKaWfLUycBy/rBtueL3AGfMgOMpQmJUJN8gOTK3qW+W0/5gXjV/TD2e+4PMWDNVCCZn4JDuWgxxNS5WPD5C+sZaYBEPjNLcx1L2S8KfSqkv71lNQKftSpLFJyW0GFcnxq71kPrHRZU2a4pFAF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlFYVfIZjmw8tx+d6LDhjdItomstFvNR5vj4eaoE4HY=;
 b=Ra/c53/SE5Ofmp9zRFRJBUa3qBmkkbp9TjvLuMh9zKCIyTEbK0iQI7Df8IqjNLsmnfzUR2mWzz92lzENt2HNZX3K/gNXr1E53pKzsTV9jOrzjD1sefHiv7S3Y6rpjSbuafUhJAKQFpD+mhuh2rMxNDb9jlwR15pM++8w2szaq/vlhsXY66KDKZ0xdPnIv4KjkzC6+1APOdE+a6p42nTOOUoVRcybaflomrVoJK0SVZ5oSNFT7JN/a8yJON0IJFAO8yzTK/Chc9NA6RM40jq+TyjrA6dwdYAr9YoJduMpwB3Anlq/yVJTL6polzVCj3Wm0PUObTS9wcBb0a0Yos69Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlFYVfIZjmw8tx+d6LDhjdItomstFvNR5vj4eaoE4HY=;
 b=KXDDPSqdQwnFN1slL6DlWM3PLMWNMufvfq4cPSiYTLVsdiH4Azhqm4WXHB9KmSjrcp2L4VPDoCvtViYOGGsj9ZlmM+lx32eIz+jDmpFCclZozgeO1BNoV3c8DGvrCh5CBz2OEwUwuzYCcMS5HcYkXQdi8yFZVZzKlSyvflmdnYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 09:29:18 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:29:18 +0000
Message-ID: <e093edda-875a-4cdf-bc58-a8f26d9b1891@amd.com>
Date: Mon, 15 Jan 2024 10:29:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Replace '-' by '_' in fixed clock nodes
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Harini Katakam <harini.katakam@amd.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Neal Frager <neal.frager@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Saeed Nowshadi <saeed.nowshadi@amd.com>, Simon Glass <sjg@chromium.org>
References: <3979167636f0a5970a9ab642a4e0ea6a46b3f8d7.1704705872.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3979167636f0a5970a9ab642a4e0ea6a46b3f8d7.1704705872.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: df158169-9d5b-400a-1382-08dc15ac72c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jx349Ro8PAq8he5cYX/7tIC5h1XT2x7fHHf8B3KkqL4Pb4nnR96S+uSq91crgATtjzOVIw+bbAtBBzSIn/dlsDApZwd2joyFofuEi5oJUbd/KKpFJpsBWRiB8xEcXbjl+n0nXDAt+RnC+08g7nCyazK6fjXbPPSJGzBVshJZII2xeg5vJKYabcPgM23dS1SLzDTxhUIKmLqWmdsf90gJy1SqJ+YnS4hUJTD4oUeAOxBACty/ofmkWc38tFzBAj0ywSijm2lLGNGjThms+zcPVqCVtCzYGouKxgveLKdjsQUU3X1uPJhtFb5BOZtpzitaOlxoHsXUwDxCYv9zFNRsgp77exGq5JM3hAAvxAkn+eMF+FUN532FZGl1TmocxVWKBG2OHCo+W1PqZhPfrQ039WGJd7GGTV0ba8EoUDChO1tbbGmA+O2+f/BsWnzgB2fApVp0rk5pJmcFs11ZuTpzdh0vdxNyUroN4oZmnIMgfRrbVRMvT5bc2S6mM+bDStcdncuXY/UPUQiYYgrCjvaWrkcLQgDzbVoJ95MogEipH/pEaynIGZGekAphBoKts9SagvYxwAfgLdxE5e4/c+MmlhsNL1Jxcpbyg0sXDLowYmLUvnsy7tLispc0+1fx3CoedmbqwUVZoBlgGKsbdW9ZOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(5660300002)(4326008)(8936002)(2906002)(83380400001)(26005)(2616005)(38100700002)(31696002)(86362001)(31686004)(53546011)(6506007)(6512007)(316002)(36756003)(6666004)(478600001)(44832011)(66476007)(54906003)(66946007)(66556008)(6486002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdVUFBxVjRWenVQKzg3Z09ubkVmeE9wQis2Vy9HMGJ0aVRvNnI2Ukk0Q2Qw?=
 =?utf-8?B?OVcxMFNROEQzZncybEYwYW1vbFVpNDdCOGRlaWhXUjRWa254c2NZOGk3cUxE?=
 =?utf-8?B?WlFTTm1vL1B5MUI3ZGFpV2ZpYnVGNXpTUjBRaTAxREpVVHFTdlhLMzA2SjE2?=
 =?utf-8?B?MFZUYmNhTmxmQjBPeENFQkM3dDhaUFlYMlRUUW10LzN5OFovUGZyY1JZY0xt?=
 =?utf-8?B?ZDZWaVJ1RzFKZURiNDh1R1JQRUpTcXRYT21TWGdlbFN6L2tSQktxaXRwSWxT?=
 =?utf-8?B?OUJjUERkZUdSdzcwWERsU3o1YlYzQi93VXZoMC8zSFpRS3JtZDlLUkNDWHY2?=
 =?utf-8?B?b2JTTCtiak5KK01rcHJ1eDNMZU5KbDRQdFVZSEtDVjk4SVhNUStaUHFVZHFw?=
 =?utf-8?B?RXVMemM0UHdDL2ZFL1NTdC9ERWs5elNhUEtXY1p4TmRUc08vdTROb2NFYnU0?=
 =?utf-8?B?TU5YTzRYSDYzZ0xQbHBLdWtpSHlkL1ZKMHNEQS85dkpva0l3dlA0UXloTEFx?=
 =?utf-8?B?MFZxdi9EcG5mWEJKTGlDUzBkblB2aGcwMk9XcXlIZkxLdVlqSSs3dENxM0lu?=
 =?utf-8?B?b1NRZFM5cXRRWEhtajBROEl4Y1Z1SllkZXR0ODJrOGRZU0hLNTk4VFpEZHBj?=
 =?utf-8?B?RUR1eDg2K1BOYVBHTVh3NW5BRXdaOEhLVS9ZVFQ4LzhwRUJ0NFVacVQ2TkRT?=
 =?utf-8?B?OFVPZU5maS9waXkvQ3lzeUNPNTBxWXdVNEt1Z2hhSFFuVytqb2pWTDFXc0lC?=
 =?utf-8?B?N05WWjY1ZStnbjJDTHJMVlQydGd6QTJKai9vdVF2eDhWUkZxbmlnSzJUakd3?=
 =?utf-8?B?MEFHQ1FabllaSU05RkY0WTFIVE9GbTRJSFA2dGtaQ0VkejBWZE04MXVkbHRt?=
 =?utf-8?B?S0pPeGNkU0dNdisrNmJXbCtBTlA1UzJHQjh3dzhnMXYxditqaks0VzhTSndP?=
 =?utf-8?B?STBBSUNWL0xhbHhWQWVDZFZjQ0YzL0hEZjh4UStsckZiUnZ0OG5kbHJpWmJN?=
 =?utf-8?B?YnlsM2NmSnNsTHVrWFFGTTRyQUhPWlRhRDdtN1pnMjVxOE5DbGlrZzgwaExS?=
 =?utf-8?B?ZG1raUo1Q0h3akJ6REw2aVUzOEhkdlRVTTA0clJ3T0NjckpWekZFd2pKbmpK?=
 =?utf-8?B?aEw1UytXV3d2TFAwNGNiMjNvY1R1WlNoN1B1bDU0c1JjKzhqbGJkc1BMMk1J?=
 =?utf-8?B?dTkxM0lydmRJL3BtRFlXcm9qaTRueWpwbTFtaEdhTXFtd0lKK0oxaFF6bmpV?=
 =?utf-8?B?WFJqL01uUXl4bTVTdzhoSWhUcGFOOUFJcnE1SWtMZHlCV2pKOEJXdWdjMG53?=
 =?utf-8?B?cG9uMGcwTjZlSGIzakhweWxtR1FyM0JlQi9OZkY4UGNJMkJ4M1AvTUJ1RWdK?=
 =?utf-8?B?ZG9TbUhPSnFiNm1WcWVzYm1wLzM2Z1F1K0RQZ3RiSFg5a0tjNWhpVWFXRFVl?=
 =?utf-8?B?TWoyZWk3QUFHTWFWdDdGOEd5c1UwWUdibnVoY2lyRUZaUkoxblA5WnA3NjVy?=
 =?utf-8?B?eXBlTmF5SjM0MXR6clhQQzRhSVdRMzBjRHArUFE4UlU3ZnAzcC9FOWdjR21W?=
 =?utf-8?B?emtZUlo2Sy9td1UvQm5VUm1vTnA1bHlJZUVoT0RvcFdWSlRpdVloMzlYdmtm?=
 =?utf-8?B?TktPQ2tXR0VHdnJLcEZQTGlnOU9CRDlsbkRiUHdmT1BRSHp0eFJxa1pkOHM0?=
 =?utf-8?B?WTBHTWt0cFB2YlVsSThwTlpmYU5zNENJRFVkNlZ2dXdrcEpVOENPbHdSWWE4?=
 =?utf-8?B?ekpjTnF4Rk9nbElCQTdOdFBRdjEvZWhBK3NHamdyMHpxWnRzbDhFNlBNZDFZ?=
 =?utf-8?B?ZEc2cWFKSXBkeWJPTUVFK3Z4NWlmeEIrdnJpeUZTb2tKTUFPc0NkOUk5MVN3?=
 =?utf-8?B?ckJ2c2FKZm1KaVRMRnlBa0dON2RKU0RkNVdwMENYaU5yZXhPRVNJOW40YWFD?=
 =?utf-8?B?M0hHdk5jb1F4MGt0ampwck52K3g1RElNOE8ydUZJTGVtREZNeUpFZTM4UlU2?=
 =?utf-8?B?WkluVCtKRlNJQ20rQkZPek13Y1RGVWVIcGNrMVVBbDlwYkJKKzZDcEw4Umc5?=
 =?utf-8?B?YW5NWlNtZ0Z4ZkltNlRWWFlTM3QwY013N2FPTEgwcDBCY1RCN2VpU21ZckJu?=
 =?utf-8?Q?fAa+nLCnmifcUtZbrziF/bKdJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df158169-9d5b-400a-1382-08dc15ac72c4
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:29:18.4357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmEAv6jypZ0svXcxH9NRwPEgdXELLaXmmmUcDkbBwUM/1vLOsfMpUJNz8Q7O2ZRY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882
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



On 1/8/24 10:24, Michal Simek wrote:
> Using '_' in node name is not recommended that's why convert them to use
> '-' instead.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-dlc21-revA.dts         |  4 ++--
>   arch/arm/dts/zynqmp-e-a2197-00-revA.dts    |  2 +-
>   arch/arm/dts/zynqmp-mini-emmc0.dts         |  2 +-
>   arch/arm/dts/zynqmp-mini-emmc1.dts         |  2 +-
>   arch/arm/dts/zynqmp-mini-qspi.dts          |  2 +-
>   arch/arm/dts/zynqmp-p-a2197-00-revA.dts    |  4 ++--
>   arch/arm/dts/zynqmp-sc-revB.dts            |  2 +-
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso     | 12 ++++++------
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts |  6 +++---
>   arch/arm/dts/zynqmp-vpk120-revA.dts        |  6 +++---
>   arch/arm/dts/zynqmp-zcu670-revA.dts        |  2 +-
>   arch/arm/dts/zynqmp-zcu670-revB.dts        |  2 +-
>   12 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
> index f737004d7943..9dabee3f9985 100644
> --- a/arch/arm/dts/zynqmp-dlc21-revA.dts
> +++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
> @@ -43,13 +43,13 @@
>   		reg = <0 0 0 0x80000000>, <0x8 0 0x3 0x80000000>;
>   	};
>   
> -	si5332_1: si5332_1 { /* clk0_sgmii - u142 */
> +	si5332_1: si5332-1 { /* clk0_sgmii - u142 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <125000000>;
>   	};
>   
> -	si5332_2: si5332_2 { /* clk1_usb - u142 */
> +	si5332_2: si5332-2 { /* clk1_usb - u142 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <26000000>;
> diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> index cc57c2a1b0be..f1b0a4aa65dd 100644
> --- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> @@ -43,7 +43,7 @@
>   		reg = <0x0 0x0 0x0 0x80000000>;
>   	};
>   
> -	si5332_1: si5332_1 { /* u142 - GEM0 */
> +	si5332_1: si5332-1 { /* u142 - GEM0 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <125000000>;
> diff --git a/arch/arm/dts/zynqmp-mini-emmc0.dts b/arch/arm/dts/zynqmp-mini-emmc0.dts
> index 02e80bd85e1a..7823c58cb272 100644
> --- a/arch/arm/dts/zynqmp-mini-emmc0.dts
> +++ b/arch/arm/dts/zynqmp-mini-emmc0.dts
> @@ -35,7 +35,7 @@
>   		bootph-all;
>   	};
>   
> -	clk_xin: clk_xin {
> +	clk_xin: clk-xin {
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <200000000>;
> diff --git a/arch/arm/dts/zynqmp-mini-emmc1.dts b/arch/arm/dts/zynqmp-mini-emmc1.dts
> index ce1cdb207538..2f6ba95073ab 100644
> --- a/arch/arm/dts/zynqmp-mini-emmc1.dts
> +++ b/arch/arm/dts/zynqmp-mini-emmc1.dts
> @@ -35,7 +35,7 @@
>   		bootph-all;
>   	};
>   
> -	clk_xin: clk_xin {
> +	clk_xin: clk-xin {
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <200000000>;
> diff --git a/arch/arm/dts/zynqmp-mini-qspi.dts b/arch/arm/dts/zynqmp-mini-qspi.dts
> index ee8be5360004..e35317f3e2d4 100644
> --- a/arch/arm/dts/zynqmp-mini-qspi.dts
> +++ b/arch/arm/dts/zynqmp-mini-qspi.dts
> @@ -53,7 +53,7 @@
>   			#size-cells = <0>;
>   		};
>   
> -		misc_clk: misc_clk {
> +		misc_clk: misc-clk {
>   			compatible = "fixed-clock";
>   			#clock-cells = <0>;
>   			clock-frequency = <125000000>;
> diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> index 9acccad40e77..5a60b86a574e 100644
> --- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> @@ -43,13 +43,13 @@
>   		reg = <0x0 0x0 0x0 0x80000000>;
>   	};
>   
> -	si5332_1: si5332_1 { /* clk0_sgmii - u142 */
> +	si5332_1: si5332-1 { /* clk0_sgmii - u142 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <125000000>;
>   	};
>   
> -	si5332_2: si5332_2 { /* clk1_usb - u142 */
> +	si5332_2: si5332-2 { /* clk1_usb - u142 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
> diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
> index f7349fdc3b4c..8517bdad6f47 100644
> --- a/arch/arm/dts/zynqmp-sc-revB.dts
> +++ b/arch/arm/dts/zynqmp-sc-revB.dts
> @@ -71,7 +71,7 @@
>   		};
>   	};
>   
> -	si5332_2: si5332_2 { /* u42 */
> +	si5332_2: si5332-2 { /* u42 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <26000000>;
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 57cd9ba13e78..7717abf7bd8a 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -25,37 +25,37 @@
>   		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
>   	};
>   
> -	si5332_0: si5332_0 { /* u17 - GEM0/1 */
> +	si5332_0: si5332-0 { /* u17 - GEM0/1 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <125000000>;
>   	};
>   
> -	si5332_1: si5332_1 { /* u17 - DP */
> +	si5332_1: si5332-1 { /* u17 - DP */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
>   	};
>   
> -	si5332_2: si5332_2 { /* u17 - USB */
> +	si5332_2: si5332-2 { /* u17 - USB */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <26000000>;
>   	};
>   
> -	si5332_3: si5332_3 { /* u17 - SFP+ */
> +	si5332_3: si5332-3 { /* u17 - SFP+ */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <156250000>;
>   	};
>   
> -	si5332_4: si5332_4 { /* u17 - GEM2 */
> +	si5332_4: si5332-4 { /* u17 - GEM2 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <25000000>;
>   	};
>   
> -	si5332_5: si5332_5 { /* u17 - GEM3 */
> +	si5332_5: si5332-5 { /* u17 - GEM3 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <25000000>;
> diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> index 088545c87cee..2a3bbe170472 100644
> --- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> @@ -65,19 +65,19 @@
>   		};
>   	};
>   
> -	si5332_0: si5332_0 { /* ps_ref_clk - u142 */
> +	si5332_0: si5332-0 { /* ps_ref_clk - u142 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <33333333>;
>   	};
>   
> -	si5332_1: si5332_1 { /* clk0_sgmii - u142 */
> +	si5332_1: si5332-1 { /* clk0_sgmii - u142 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <33333333>; /* FIXME */
>   	};
>   
> -	si5332_2: si5332_2 { /* clk1_usb - u142 */
> +	si5332_2: si5332-2 { /* clk1_usb - u142 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
> diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
> index fa6046eb95c4..e0e4f1b13ada 100644
> --- a/arch/arm/dts/zynqmp-vpk120-revA.dts
> +++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
> @@ -65,19 +65,19 @@
>   		};
>   	};
>   
> -	si5332_0: si5332_0 { /* ps_ref_clk */
> +	si5332_0: si5332-0 { /* ps_ref_clk */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <33333333>;
>   	};
>   
> -	si5332_1: si5332_1 { /* clk0_sgmii */
> +	si5332_1: si5332-1 { /* clk0_sgmii */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <33333333>; /* FIXME */
>   	};
>   
> -	si5332_2: si5332_2 { /* clk1_usb */
> +	si5332_2: si5332-2 { /* clk1_usb */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
> diff --git a/arch/arm/dts/zynqmp-zcu670-revA.dts b/arch/arm/dts/zynqmp-zcu670-revA.dts
> index 76410de1edca..7f70904f44e7 100644
> --- a/arch/arm/dts/zynqmp-zcu670-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu670-revA.dts
> @@ -131,7 +131,7 @@
>   		clock-frequency = <48000000>;
>   	};
>   
> -	si5381_6: si5381_6 { /* refclk_usb3 - u43 */
> +	si5381_6: si5381-6 { /* refclk_usb3 - u43 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <26000000>;
> diff --git a/arch/arm/dts/zynqmp-zcu670-revB.dts b/arch/arm/dts/zynqmp-zcu670-revB.dts
> index c2dd9f696bf0..0adb2062aef1 100644
> --- a/arch/arm/dts/zynqmp-zcu670-revB.dts
> +++ b/arch/arm/dts/zynqmp-zcu670-revB.dts
> @@ -131,7 +131,7 @@
>   		clock-frequency = <48000000>;
>   	};
>   
> -	si5381_6: si5381_6 { /* refclk_usb3 - u43 */
> +	si5381_6: si5381-6 { /* refclk_usb3 - u43 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <26000000>;

Applied.
M
