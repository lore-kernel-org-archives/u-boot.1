Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A433F588F7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 16:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9E4842C7;
	Mon, 20 Apr 2026 18:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="h9xjOieo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57543842CD; Mon, 20 Apr 2026 18:35:41 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B2E84258
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sO1hzflnutJXv/CIU2o1CsbMfu38GsRhaiPDz36gOsZoqclinB9m7c77HlavISfa1NNZ4ODYKLhA5N+19/o3zU3zLNCDdmisbLkmPNBBIR5km+hdFwrsaLNotcxZNJRuGCbpZZ9B4AvtdeOMR47Yg6qGbbpFte78gRXgc2sm1sreNq6BkyoyJ8vY2u+GR4Tc0fE1koFG6Fnyq4mpKEesSvt9TdnPvuLlQirds+fXH7vFvVCpKEBW0+6/2s05Xd9YDnWrM68+Irx79Rwa3RN2oZZoyugnOh+ShSkWM3L12Gr3rx7FcvKgUk3kheOgT309cE7n7uexZ1frkYq4YT+p1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgUVyPyrvkn+802mBBVr1WCwmsVlfLA9HLLmv2xPvFo=;
 b=UJheSF1STXOPYQ3wb4huX7Z1nFWm+PqaP2dAS901pmT13YEk+cF7mVloJtptIJc4DnfegMnDGtekDXVd09t6/hBOWHFDA0j7hMsvbI2DQ7NlGy7RmqEZ9FZiknbQYKzRGc9fQUm9RJvduHcMpCUotl45kyC84rq8JG4JZAHEPPuvYy2zbonWwG9uIGeD+X4T5tFL3zKnx3paoGpZpz/dFWGfOwQ+zGEPxbBsSAFpv1lwjUMIynZSoaQ2vddLbzKhDaRoxwF6hvR4JWh2Ijzp6XmlPeBsjoqdP0qgq1F94h87TaDKI5obJ8bCf4AS8GxGqHIs+OubAZzgbywrXuQEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgUVyPyrvkn+802mBBVr1WCwmsVlfLA9HLLmv2xPvFo=;
 b=h9xjOieoZnMr70CkqFisIj8z5BxU8CUfjyeFeFZl8MUNLJPhHPMpQrgLe20O6weJm74prLG4HalzRnqDsR1U94/59i9gLwKlmc3ikL9pMUr62GLrWvgLpO9TDrr7BOk9SsrS+J/zyzArKAzM03GDfLgYzAZfhSCEVVhyWerBsYb7RtGghHD4iTX64kHYgOEbjX6Y5jrKGakRIQfNDF70ntxv1+lWQlA8JVwwW+glIdlIL0d5AGJbq1u2EFUpwiFf8DO8DCsygo9tBQVeqMa+YP3HhCdHiBdi7r9uqOLsn2rG5XyYDgTbmdH4rdswSO8YYRb8nksnol4NSb4+zcNNqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB2613.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 16:35:34 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 16:35:34 +0000
Message-ID: <90a9f428-5303-4afe-a0cb-3cadc641c70f@phytec.de>
Date: Mon, 20 Apr 2026 19:35:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] configs: phycore_am62ax_r5_ethboot: Drop duplicate
 CONFIG_SPL_MMC
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: ggiordano@phytec.com, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
 <20260420145353.3923395-2-aristo.chen@canonical.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260420145353.3923395-2-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0015.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::10) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB2613:EE_
X-MS-Office365-Filtering-Correlation-Id: f62e9057-de83-40e0-4b82-08de9efad832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EQQTjQTqckmmjRY8aoKikod8oSJu5zTVPNxpJ49dF3pL9T8zRhE9/D9xiTEfwPl+O+fd/NyPqTT+FK5qDYnlgmVpBJ2QeTQIV3t5Qdseu+ov3HUGMvrighxm36Jy8mTCfehKv5cxPLhtO/G1KJcyH80fA7NtvGLv7OUjndFDtXK6ounOlzFnsN5qb8Ac36quLTGKiyJ6vPsXRElONRJPMXn1M7rkxTc84uGzBDPLIlOioDs+5ARRELCLGN19E3b5FlMlpqFLafxD6vy9s6hNj/CAaW2XnGuTPJJ188Qd/sxALYBDJAu+3ccNERQQISJjtRTjNRZslq7d2nnMNvPDaVYSkKvKJu+5Fo9JmKEFQfXueNXgK5jIBVaKjBzAuRvtRIBR5J6h+zTXd8vp9nuV2BYcypn4avoI6FKu3F48y1rpMDMCho5ep0JyDEl8W7erg4zZFlk2A5usnBK4q0gVLXjynSuijop5KNBPvpQhymZiZoIOpx4V3uxT9kL9GNDF2Dldo00KNZyKJGysDU6or1MZEh0bDvIiXke1s85PhtnzCdmVH+8dqdwBkfU36WpzXLnDCn/y4H8uJhsIIa6ZIlijdUHGn048YSy9/vlpEavk3fvtEjCg1AFSFUycWPEeoZvxFgQTGYCIsfvgWcQ0WKP36skcZXkdwrLv5iSjydPakHv+cLcKM9kGFkkEyQWY4/iGsctmn/uRICOde3qvv4GgtfkvRyoC6YltGJdC/18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NkOVJ1azZXd2RIVlJMTGsra3N2N1lVaU53WTRzSC9tcFZEWUw5SnEzT0k2?=
 =?utf-8?B?dklIallFUlBqdHpLTnY0UEs2VjdDL3FGc3Q1UG9UWjhMN3k3R1IwbzkwQnNN?=
 =?utf-8?B?cXBnSDlnblNXSWJNbHJ2T1NGM09LWUdwT3M4U0FYenh0ZWRxNEFSWXdhQXBi?=
 =?utf-8?B?cVZva0tkcGllR3Rqa0RtcW95U3hIUVpNYlhNbHQzbzd3a1ZyVENCZzBLRDNq?=
 =?utf-8?B?dUZNaTVKMHg5dHNDN0hiTWdJdnFGWUY5MUhETmZYK0ltb21pWWtWa0lvaXBK?=
 =?utf-8?B?cFNwT1VVRG91aVhZYTBZZ3hXeW5YODdVL094VVNscEFBdVNVc2JNYnJxL0pC?=
 =?utf-8?B?RnlJMU43aXoxVkY2cTRqQWJKU2JNZVJ2MzFQOG9HT1AwemN1Z0ZNNEtQczN5?=
 =?utf-8?B?M0ozZGhNNGxUSGpaY0tSUjZvRlR6UUtxTGJVQklhYjFpSlBVK0NQY0VXVzVP?=
 =?utf-8?B?c2Zxa29sSjd2U0l4MDFVMVl6V09od0VZZ2orS1h2YSt2THpRT3VjZDRtYW9Z?=
 =?utf-8?B?N1g0Vmt2clRJdDVlNWorMjhLMXY1T1ZmME1UMGhORFpSa3VNMi96UFRVVWpQ?=
 =?utf-8?B?U2lxS2tLTW4vVGMxbFU5VHBYdVYzVEE1K2tUN2tTMHRuM3dyeG1xbDJuN1BI?=
 =?utf-8?B?YnpuZHc3TmtzRWRPeFMyL0Y1ZFAycnNXYXZpVkpyU24yWnU1STZ3Y0Q2SEdI?=
 =?utf-8?B?blgyVWR3OWhxSllzcldSWko1V3RoNjBLK09FZDdiOGhsYk9naVBZZkxvbzJT?=
 =?utf-8?B?VzVrWW1GNXlvdUtCZE9MY0VQWHN0dUltNisvVGY0eDJzV2tXQW9tQUJTYmZJ?=
 =?utf-8?B?N09Xb3FtUGFoUUhHMm12NDlVVmhaVzQrQWpmU2FBM21rOFhIWUNYL2hQaVBV?=
 =?utf-8?B?VGlXNzB0bnNRaW5UMkd2NDZYQktoUmZmQjVHaGdiUXZJc01kRDJ3TnIwVFNI?=
 =?utf-8?B?a21IK1ZBbWtvK2N5T2ZkelNublF5MzRmOGJXVjBYTCtVRTFNL0tBZ0taRFBF?=
 =?utf-8?B?UGFkWmZUVTQrS0QvVHNPeUpjaUJSYjloMm94cUtsYUQ1eXE4YzdLd2FScWhn?=
 =?utf-8?B?M0djRFJVM2svZ2RHdkl5OXZyaTluejczQlJ3UFhrTk1SVVBxcExpZmkrS1Rs?=
 =?utf-8?B?MDE5QkhhQS92elJTM3I0czlDckVadE5RRmJ1TktDb20rdmpBYnBVeVBkRTdC?=
 =?utf-8?B?bElxOUVhOXYzNC9zZWFmZ0RQNDdDSGgwYVVtNWlrcm5XejZLVzQyZkxKbHBr?=
 =?utf-8?B?NmppVXRhSDdjb1pESklNaE4xSnY1R1pOcXBaOEpOVGIxZEd5V1UvZkRZUjdq?=
 =?utf-8?B?d01HVjJjWlNLRmxPd3U4ZHZYNThWL05wU0JWR0VBbXBBcTFSOElYVzg3LzZv?=
 =?utf-8?B?bkhvMFFRa0YzdU9GN1F1Z2I1OVNCcHo0bUlXK0V0bTRmdnlkTm4vdHNab0R4?=
 =?utf-8?B?eVhKeUxrTGdLN2tlNlRlWmJVeVB1aXRuQUtjSVVnekcwSldxbWs5QUNtVXVG?=
 =?utf-8?B?bGRtWHIrcS9xbUtwWkNzdzVmY0tJenVtOTExMHBPU3Ewd1VtY05UMDZZdHJF?=
 =?utf-8?B?emF2NVY5cGk3OS9WUkhHU3c3bUxRNlVYTVFucER3VTcvMm9iSEhORU90Z3g1?=
 =?utf-8?B?RUxBWmFLeVE0d2tEY09nT09Pc1U2SFNMbjZhc0J4UTdESC9TRCsyaTFIWXpL?=
 =?utf-8?B?OHNDMEFhM1FFdG16cGhROHZzd1hDWVg3UUNNTHluZzdHdXhDTUlsNm1jY0FG?=
 =?utf-8?B?RmpiSmJ2emdxNTNCemhsTDZMRWh4czhLdjArMTkwcmlaMFlBaWVQU3FKeTY4?=
 =?utf-8?B?SDBOb0FTVGtQajNPNW4rMkg2aERUUkg3Ni9XQUNJMUYzWUl0RWhQRUEyNW05?=
 =?utf-8?B?OVF5RFdVWlVxMldEZkp6WG12cmIxcTRZRXRMUTkvRjRGMVhmMEZDZW0rRUIv?=
 =?utf-8?B?TWx6ZmM2bEV5ODd3VklwK1Q4Z2hvMjU4TldDeEVvTzQ2bnYzaFdHQnZJeW9v?=
 =?utf-8?B?eUtvMXc5VVVLL1RHQTNNQzBqRGVhYWw0K1pXQXJ3NmJoVEZiWEdVRlg5Lzc2?=
 =?utf-8?B?ZURqOVd6N1dtdUVwcnZWNXArZlV1d3ROSVJpRG0yeDhTRi9kR0dKN0JJVUNU?=
 =?utf-8?B?K0RnaXhpaFlMQ2lCaHRTS3JBbHh3TlBBSFgzcjR3TUtlaEtIWUsvMzdHVUgz?=
 =?utf-8?B?NGpsTm8vUWFqOW9ZOWdheUJFKzVOby81RzRBVkl0U0V5cFE4TG44eGZnWGFr?=
 =?utf-8?B?NjJPVDA5dzNLdTM5WWRXeXRrY1B6Z3czUE5jYzRyTG5rUEhyNktoS2FybGxn?=
 =?utf-8?B?VWRQT3RBT3llbUtnTTF4Y0VJaWxJUmtPMnBsb2l5TmlpWW1QSm02dz09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f62e9057-de83-40e0-4b82-08de9efad832
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 16:35:34.0527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8nUOBGq9k5ER1rsnulCfQvEgyQT74aX3sw2A1RILI7rgJ9yK/XH0+nJDNE3BwCD6ZpBTKevzomsarpw5Ca2cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2613
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



On 4/20/26 5:53 PM, Aristo Chen wrote:
> CONFIG_SPL_MMC=n is listed twice in the defconfig. Remove the redundant
> occurrence so each option appears only once.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>  configs/phycore_am62ax_r5_ethboot_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configs/phycore_am62ax_r5_ethboot_defconfig b/configs/phycore_am62ax_r5_ethboot_defconfig
> index d597e9d92d9..db04706c739 100644
> --- a/configs/phycore_am62ax_r5_ethboot_defconfig
> +++ b/configs/phycore_am62ax_r5_ethboot_defconfig
> @@ -24,7 +24,6 @@ CONFIG_PHY_TI_DP83867=y
>  CONFIG_TI_AM65_CPSW_NUSS=y
>  CONFIG_SPL_MMC=n
>  CONFIG_SPL_DM_SPI=n
> -CONFIG_SPL_MMC=n
>  CONFIG_SPL_SPI_FLASH_SUPPORT=n
>  CONFIG_SPL_SPI=n
>  CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n

