Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878A3CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 10:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A4D84A85;
	Thu,  7 May 2026 12:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SIfB8DHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5F784A8E; Thu,  7 May 2026 12:42:29 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEB184A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjGl21TmD/B6+49DsWmqKXgZzrahIE8yQ0x0WKAhBwclurUGFBGxVZnv+RRmtaCBWcp9OQjhghaTzZm93bDzUGLW4Zdr/xFV3yS++zcaTK1WpBmO+2OvCY+zbJKfIkMetmntBjt034mnZBNOHkbdkKizyz3v2vS4/4od/LpgaEBOG3lO+E8ANFiufUV85uq4JBzMPNmGWxdiA3cQ3K+pPEx7I9AjWMfmDBIK7hLNHdaXa+Vlj4PA9/g2NDMogIH7NOmxJcmaTSh51IXzIPqyacfDIOYBlqRPuulVGXl5j+m7QRcEAPknMqFtFfliKy/JD4/4gY28orpI2ugvgOQspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8ndvyEg2QflFFJS01rY57i5hqnHc6rC3fme04Dkql0=;
 b=wJ/Gy5nXeXY5z+f5pefRCrL86x8wRYFaXoF9KxGzmInFJXI3iBCsO3jEiTsJgAmtfO2scwJSI1iI9TdyEptnzxOAxibDMwkOWNXJrHszXA3flnZseXfL2P8Pm0FZVDgiph9UgJvv+G+QXQEljsCSw3TcQT+1W82Uh/IjWfZCIcvWKnQqrrnUEvhKZmg1NOlLdmrhFEVj0zqd6wtbx7H/89n+xOGIOl6N3XSlKXJjsXfGYNkBvdORKuAUcEcbMqPekJH6qkgTHub6HsvrCDVP1SLYewi8r15y0fJgmyUKCrxLH1dzgla/skf9a1srltqvm8uknsWt5FcorHd0ZY7lbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8ndvyEg2QflFFJS01rY57i5hqnHc6rC3fme04Dkql0=;
 b=SIfB8DHS1ivZdthd23KR+jY6nlMKITZR+EEnPRvTMCnNqIjPmStPkl45PMn/ydTFK2ORvHkphhocP5xQ9bI8PSjuPWgdDCEP/GdUtXuwH9lE0QH8i9ipaOA7+0hZ/YMRuZA9aQJ5usVfzYufnzMHe3dbwEnY1cl6GqlY5Gbc1zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU2PR04MB9195.eurprd04.prod.outlook.com (2603:10a6:10:2fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 10:42:23 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 10:42:23 +0000
Message-ID: <f99cdfe2-4490-4e7a-bf76-edfdfdf2080b@cherry.de>
Date: Thu, 7 May 2026 12:42:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/mach-stm32: Remove remaining non-existent STM32_RESET
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simeon Marijon <simeon.marijon@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>
References: <20260430-remove_non-existent_stm32_reset-v1-1-8ec87c655379@foss.st.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260430-remove_non-existent_stm32_reset-v1-1-8ec87c655379@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0168.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::25) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU2PR04MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: ce842023-b579-41ad-8a04-08deac2552a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: W3wG/wJ41GewDyC1B+EDGSG7FNokYgZni5itRLMuanHd6SfJMxRhLmaxl+OwArlVE7VlLK27mYhhzbIKBUZL1WAYv5guGblGph5gxnNZPA8Zocd5eIJYXJa5KjoW65WmX0v4AcR1ui3qJyEwcl6SLedqI2BZVOvHlMnbmlXZ3PyhCTHYMZJaxQPbNMjfJ4KNoNkqs8nKjJILkwhMtwIfIVnnLDKZAbBoy1Jt5wm/TmMe+QeBqCs75eCnCFj4m65uOQbZzLkRJd6QuvXpp0XzDSMIv9LqS7lh8W8z1i8XNy5T2dOu/9eDpo5C2ddZ0HDuhhiecZ1ZmU7KuhQSMylQJcMZm8+D0nlEm4J99B14yL9oEHMcKWt0bBNviKJ7CZQPmCx6vPj+VlIboklZAN2KaIzDf9zPBpaRhng3oGhfan1dOGB1HelBBkpcgCd/iOQlVz93ATu716TgtDrhz7Gp9x8zpfBtdWUPgR4tx2K5tSp/Cc8+afiU3uZaK1ts5XuC9duTf8rd+mHBpql/kmEYC8yw82DPBqSkexIN2MkJMSSlzoufZ4cnAIz7btnQaya7AznQr95mr5bQsL8tyD8TFTatwacuGjrNAFtsYVjrqon1FoY8SeD/fMqNG/k9eYgcLs1r/selmDLlJKO04+lGCOhsAeqjEQKoOVX3Qii8mT1eHIgKuXTDsjpbAAFi5rTv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVZdEo2b3R5dWw5WklFUXp3aGhnVGFvY0NFM2dMek5RdTNVY3ZzVzg5UVM3?=
 =?utf-8?B?RjNqV0ExcjQ5a24xc3psdkhDbTEvc2ZCUXp0UnhBWlRjVlJ0SGx2VEs1Sk9C?=
 =?utf-8?B?cjg3QlYzaXoyMkNtMlBmbnVqTm8xRHJSZG9keU1GUjM1RW41MVYrdzJYVjJq?=
 =?utf-8?B?ZDRxSFVNUGoxS3p1dTFSUDNleWhzSVJrcUpDU2NVUDVEaXdsOGFJMFJ4NEhB?=
 =?utf-8?B?RHJzRWdNRkx3T0xXMnNIQi9MZzN5WEdpc3hrMnNJTk9pd1VqVDdtN3FBOFJF?=
 =?utf-8?B?VG4zWHZpaVNZQkZwdzlWaWdGM2xGUXhWV2Q0d2VCaUovNzVQR2QwOWlhZkJ3?=
 =?utf-8?B?M1Ayb3RqVjMvTUhSalZxZ0V6YjFHeUtNNFlmanIyRVgxLzkrcDRsOU10cS80?=
 =?utf-8?B?NzFRd3BtOGRGcS9CT0dxYWs2OWgwWXNQdzI2SGJGRjBxak9kblZSNnVUZHB3?=
 =?utf-8?B?S1FkdGNNU2UyYkFWZmJkZXBSVzEzYjkzay9iT1lkeW9hdzhYd3ZTYmpnNGlo?=
 =?utf-8?B?YmVsOG4wR04vTVRzZHZ5N0ZGUTQwUmwrcjY3clY5QjhLOWVYcWNnVmEyajND?=
 =?utf-8?B?cGhjeVprTzNqdlFlVUFlK1BORS8vaCtwamJpVjd1eXZzWjcvU1oySW8rNldD?=
 =?utf-8?B?K3VJSkM1Nm5BRWFDRG5lV3JBOXJJM2hZaHQ4ZXlEMlFSMG5SdVp0RGlkUHhs?=
 =?utf-8?B?TVdFTVdaZzl0eDgvWCs4MjE3S011aWZKeXc3dk1oS0NoSTlpbXdsc2s5eFhx?=
 =?utf-8?B?czExQXpYaFVqNEdxaEpsUnVuMTNwa3d6bUI3WHdtTmdEdnVhcFJOV0VuZ3BQ?=
 =?utf-8?B?UUsrek5Sbko3LzhwNVE3UGs2MzdZNEdISi85TDBhcVFLUGdMT2NjMGQwc2Vx?=
 =?utf-8?B?aXNWL0drN0tONWtwWDllY0x1VDVuVFFWQmplUE5Gb3FyemdDMlY0VUlTYTIw?=
 =?utf-8?B?N21lV1dqcCtra2RiT0R4aFRveWxoMFo5SjVVRkEzenhQWldRQ0s5QjhORXRh?=
 =?utf-8?B?dFNGL3NmVTFjL3FDRUwvVVFNTExOMDFhWlhRbDN4UExuUGxWRnlUblFuVC9V?=
 =?utf-8?B?ZGRPOWgxSnlBNjJyWUVhdlBJMk5nNjBiSThVQXdZOGora0FOY2x4Sjc3d2NQ?=
 =?utf-8?B?d3ZGVWR6aytvdUJPd2Y2dC9wRXBIQXF1Ykxlb0R0czJEdlNjbCtBbTdMWEls?=
 =?utf-8?B?VGQ2YWo0QjJvSlUwRzliVWRLVmw3bmFNZzJxanQ3VmNzd3dxVW1jRU9SQzg2?=
 =?utf-8?B?azY4YWg1UnNuN0FuQ0hwYS93cEZTSjlKZ21WSlVVM1hFODdJcG0vKzhMN0JX?=
 =?utf-8?B?aVUzTEVraENJeTVCTi85MkRUKzBmdHIxa1l6U2ZIWmNxWGl6c3FXdXdRelpH?=
 =?utf-8?B?VnRZcXNCVm43RktKcyttWEVRdm5FMHhOYmlKRmVEazJ4d1Y0YnpYRWJXelZk?=
 =?utf-8?B?ZHZoMjBxQmNZWitqVGpVTkFqQmJqbGtkL04vdW56T1U0OFVTcGU4bXBuY29a?=
 =?utf-8?B?eFd3Y1kyRGphZGVubVBhZU1BUnZITTBQK2JwUnVTNGlRN2VQbHFJeSt0MTJ6?=
 =?utf-8?B?ajloNGUxOGYxQzFZdE5qNy9PMFZJamhaSUMzTFFzS2dUVkhSbnVWRFFHSzY0?=
 =?utf-8?B?d1dFNU9DN1paNk4wcWQzRjZBRFVQRk8ySXRGRHBvSWh1OTgrVWhwMTJZdDZT?=
 =?utf-8?B?bFE3dXJKeWJ5cWYyUmJZcTNEL3hRMkJFaFVpeklXZm52VkJDZ211VllPR250?=
 =?utf-8?B?ckRvRGwxQklKN2trUURxMm5pUEgvK2ZGWk0yaEI0eUk1RDIxeFgvYzcwUkdV?=
 =?utf-8?B?Q2dScGI0KzRUdzZMMzRTVzZMc3RiL3lRMmNvcUhPL0pGV0xUaEVwbkJkSCtU?=
 =?utf-8?B?N3hyUTNJWWpQcGgwMUZDeFRLMkFUQVN2ZC96S3dYWk9Fc1pibzhjVkNscTFq?=
 =?utf-8?B?TjU0Y3ZkTFd5bjFqOUEyeWhkbkw0N3hEbHZvWVNRcWp6UGZQZG1WTzNRSDUy?=
 =?utf-8?B?d0NRVVdMeUVJYU1Dbmc2aldNU3hSemRXS2xQWk83bklUMmJHTkFaamRXREdD?=
 =?utf-8?B?S2dUb2lNb0dGazlCUjMzTUFsUWM5enlGWktCVGhPU3l2WlhUVXJxZ1ZYQ2sr?=
 =?utf-8?B?QTVFREtJSzdWR2pqYmg3TmxEOTYrU2ZNVE81cWFWQlQrWFBmL3k5QklvOW5T?=
 =?utf-8?B?QXJhSG05SEZERlJsWjZJWmFqNk91UndXZHBVcDg0M2pJeUVnL24rTlBZQU11?=
 =?utf-8?B?MkUrTmFTRDByK1luUmtPdWh1YmRoN1JDcm1ZTThqY2dlL1gzWHJqMFF0ZVRU?=
 =?utf-8?B?NEVHNVNhQkF2azlGUEhvelM5ZmxpVHU4TEl2Zi9MWnpDNWV5Rmdmdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ce842023-b579-41ad-8a04-08deac2552a6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:42:23.4608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iBMZiaPC8NyJ5OKgR+WH93SH3ctMwF3oXU+a7zlLepg+/uRxj5sBwqrouDs11r3jIyYg9uaa69ZEpTcLDEWGryYK+ZbM+TXf2iiEGx2nJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9195
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

Hi Patrice,

On 4/30/26 9:14 AM, Patrice Chotard wrote:
> Symbol CONFIG_STM32_RESET does not exist.
> Don't select it.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Fixes: fdd30ee308a2 ("ARM: stm32mp: Add STM32MP23 support")

Thanks!
Quentin
