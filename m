Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52106C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 14:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00EC26064C;
	Mon, 10 Aug 2026 14:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNrXrrNiYmct; Mon, 10 Aug 2026 14:03:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0666E60707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786370623;
	bh=8gyirOWSJx1/M0b/5Wwkoov/vHSz7A+eaZwB4dU0okE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0WPyg02m2nuA44ama9ZK2zNklg6n6ATaEiLU31je6WvzY1qWupbwhyJH6ggP33pZ
	 asV7aq7GL8s3BRdQceCB2e+60hc+ycjFTTAaxiAIuXJbG2XkOixTWIuIsiYGKsGT4S
	 fg9IPO5Wauzfp3Qsj0dptBJecYV0y2A5HeJ6DT2m4eadOw3K+pBJKCJ0P0Vo5Ttpn9
	 eqH49zmun4FdHJ33jmZukABI/zD6m712941P62ppUe8u1G8cI2wW8CHZBJHBunxQv5
	 lPVX3Jugn8mcJIQmjn04gKbTbZek1Q9QrR0rtgh4TXHJEULSbckvKSaf7627ztMXa6
	 U1n1J3CksAKwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0666E60707;
	Mon, 10 Aug 2026 14:03:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1F8024E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B31E6064C
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:03:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kbIfWmepDMUu for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 14:03:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 925B460707
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 925B460707
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 925B460707
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1MxfOh/CPUHwalT9eWbZ4UAo9f2f8h2lZnGS8wImhoBGXOdb7/sOO3hrrGib0nTxVvw+pbaqM7485wN5LK1chLwBlEZlXysCxa/WIW+m74uge5AHl1+WzIxv80Cp59mgUCqKFfYKzR5UGopHsJ5rOnYLY+kQyr1hFiLdgT8aEFJBX+mQ9Sc43pvxF6MNE5np3YB2BgXcQWVbABfroQIwHIJ8oCOXEnBmhxad5kaTSoQxYjPuE6/3dYgNbgdS+Wc8cRpCH6vuSaoWWDsldqP6OwXuFa2E5fW4OESrff70xjrjtNXuDeLfd3NXzVOYr7i/3UklPYNjaS4jK3Bwl9xIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gyirOWSJx1/M0b/5Wwkoov/vHSz7A+eaZwB4dU0okE=;
 b=Sea11CEoqizjQBXKFcjNz/M6EbiazUM76iD5N6yIkZzzRs0aGg6q4SeH37QB/MqnPeNYHa2W1sdTDFPBV2uo5z4vqbE9Z0V0WyvrmUT2k8hRptV1mJsrvbvNeAtA7yXf2qYr7U3E25FFkN6rs2lgn4IyInhXUoMvON/sZJIhYSuf807M01VyCxXEiGVvggMGfeC9YygNQa3n6Z1Geek0QCaiDBHiAOTHw1Q1yh3U+DyTeFtYvz7LuN4mc0s3bSMuxmJyUG85xGS18Dt8r3I1ixU+Erp5rAp25z0XHd0YuJ9attDjJFkfUT8ZXwSjrhWw90xg3me2aJKxCGpkZxyymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBSPR01MB0009.eurprd04.prod.outlook.com (2603:10a6:10:200::5)
 by DU2PR04MB9522.eurprd04.prod.outlook.com (2603:10a6:10:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 14:03:32 +0000
Received: from DBBSPR01MB0009.eurprd04.prod.outlook.com
 ([fe80::882e:c2d6:872e:9974]) by DBBSPR01MB0009.eurprd04.prod.outlook.com
 ([fe80::882e:c2d6:872e:9974%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 14:03:32 +0000
Message-ID: <24092fe1-9f23-4f85-99f7-46cb322f2e88@cherry.de>
Date: Mon, 10 Aug 2026 16:03:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V2] CI: add Qualcomm requirements.txt for world
 build
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
References: <20260810124802.2037363-2-casey.connolly@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260810124802.2037363-2-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::25) To DBBSPR01MB0009.eurprd04.prod.outlook.com
 (2603:10a6:10:200::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBSPR01MB0009:EE_|DU2PR04MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eee8e40-a225-4a47-a6fb-08def6e829c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10070799003|18002099003|22082099003|10067099003|56012099006|5023799004|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ccnN1YcEhyICHjjAB1Vy27ysaULPE7a9X/Qpef+Qj7xQzPIwO44lialmReAuV96L5m7vnr7N7FqsVhskDiaT9aQRRk+qSDScvaDEOV4AYPSeNClXk90ApuO7scBLg8xU4776dwY0koyuICgZ3Fjyx4hE5SP4VkfaCjWk4FqAtI3Lj15Xjmwq2VMtlb65jLFlYTO56FhWgBy8giwof98qnMx/Gjy0dKakavnCPaFCbaksOfIgS5IK8Z3pdJk30uiA2Pv5KPywS96+sKAOD80/aPR8B7kPwnCiyRWuhaLoHlstBUWgcRo1z+gZimnZ1epN7LyxycifdGt1Irw+xd7Z8CTxIwdHS7Wu8xfRzOvsF8jpkJS3mvoA2PvqRs8Cbg6NYGu3kXZb1JkShsg4ZP3ZTB9wrlQSTAeXau8OBQ/UwPVZsOccIoWHDJ61nD7D0xaSSWYwLwhYdE56nqL5pEd2S58YFJVcSXXMAYbGb8Xr9bwMI6r1YB0MbcVTJ8TCYUcnyBi2OEdxSvYuk451QeZzibTo7KAM4Q/1wOAsV39O3nxc+gp7/uVe+NSiYinWlbYXhIm0mQpmV3YTkcj8x0FYnZPrBG4WZfm+0Hxpmpo+bWSJs/NOmoXBh/YzffI1wJxnJTfDuolfq1BfF7brMD4DYNqxuJBMxK7J87yWHd0c8n8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBSPR01MB0009.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3Z3WnVQeE1WY0l2M3VxclpXejdVTVl2WDVXTTI4RzRNTU8zOThBdC80N2xX?=
 =?utf-8?B?S1ErNzNPWllmSzM2UDRhaGxaVTYvVUpjUFNoVktWT01aK1BMT3paMUxLcWgy?=
 =?utf-8?B?NUpEYk5nTUV4ZndCRnZndUVzTDhWTlpDUVcvLzdiU3o2eFlDM0YyaVVETWxi?=
 =?utf-8?B?NVZJMkUrbnVkMXZyNUZkWmhESWE2aWdhRzdPRCtCQlNMeSthTEJLRWJYZ2ZM?=
 =?utf-8?B?bXNaN1JiaE9PN09pdVE3OWEvTW1mQktUYkNYakNjYmpLd3ppcDBka1V6QkU4?=
 =?utf-8?B?czN4VmNIRzRuN3BROWwwNW5TdUZPOVdWdy9mZWhNLzFPbFExbDlWYkg1QVJT?=
 =?utf-8?B?dG1LelF5dC8zWWt5QzVNNzFvWWIyWEJlV29XbDZYZGp3WHg4NlJMc2taZlFN?=
 =?utf-8?B?SndUTG1WMGV4MXFtSkNQRnB5Tlk0ZWgvZkNPa1F3UnovZDNhNEJMNTE1SEd4?=
 =?utf-8?B?MVdZRCs5MEJDU3VuQ2ZOQlhBSFJzeFJjNTU2MTBOSzJyTG1hRk5xbk1kd3hm?=
 =?utf-8?B?dlBxUVhWL1FvWkY3VSsyRlREaStXZVVOa20rMnY1eW5GNWR3TTc4Z284alQ3?=
 =?utf-8?B?L0d1YklsR2ZQTUdhU0p5elAzMEw1RFRiTEZaeW1nVzc1aHBteFk4WU14VFR6?=
 =?utf-8?B?eEZ1YjVHR0wzMGNXckh1MXdBZXRGQ0pMR3plMzNvOVFNdTFvM3RnTGV5ckhj?=
 =?utf-8?B?TWJXRFlWYmtTOVhBekFwV21ZamRLTVpZa3RveDlyQSs2RWR3ZjMveXJkUzIr?=
 =?utf-8?B?VWtZWHhpOCtNUFlpRjFCYnZGVmRmYUtJWm5ocjFIcThKZ0JVczB1RCtHaWN1?=
 =?utf-8?B?NHRMaWJuYzQrY2YyT2R2dkJwSDYwS1NSQ1pVdUczb0xONm9KRmhiYVd3MXRi?=
 =?utf-8?B?WlkvV3AyMElYbWhFdG40WWFHZ0ZlckNwY3hIN2FsTkhJN0NQanFuMHh3NEl0?=
 =?utf-8?B?cjA2anBhc3h6R1pkbnRJSERkR2ZRQWRiU3ZDb2VjOUNhcVVuMFhtSTM2VDdZ?=
 =?utf-8?B?SHdPOVVsZUk1RFVFa1pyd0Z4ck8wM2UxNEd6QTV0V2RlVXhObGtWWmIveFg4?=
 =?utf-8?B?UWNWN1d5elF5SzFlRk5ZbHRyYTV1cm9xNGZlbjFsem9Cc1pHUkdRQ085MEl1?=
 =?utf-8?B?NFQ5eHQ2NzUwTUtyMWN2bHI5WkdURm1FOTFnQmV2YkVtS0JBY2RUUHc1TWtl?=
 =?utf-8?B?eW9RUktrOGdjeGZISlJ1MEE0VUpNaEhNaVgzcVA3Smc3MFFQSG9NSXpzRVJS?=
 =?utf-8?B?d0h0SldXRHkzNldqTUFVNHJXUEZVNkxMUStZMUpRM21Lbk1ONjlWY2JTelFv?=
 =?utf-8?B?TnhJVDJtc29yWHZ5Vmk5aTFYK3N0eVI5TFE5UXNpTVJ3eWhXVysrUWhXN1BE?=
 =?utf-8?B?bUtYbVRLYnBCT2lLSnpCUGZGcEQyRlVjVWVJSTMyeEJnNVJmbHI1NTNFTXlk?=
 =?utf-8?B?RVlVc3dQek1KYVh5U204ajJVcm5haDZBR1RXbzZoYUN6b3ZuZ0E1RWF0aTIv?=
 =?utf-8?B?bi9LY21NandpQUh4U3FpMU1iZGtrSjJmS1BSOTJSRVNYN25TZGd3b2FuTWN4?=
 =?utf-8?B?bzh1NUdlL0RFeUZ6U092N3ZrV21RSURFTlJqbi96bEFvczY5T1BJVHdJR29q?=
 =?utf-8?B?SWRpRTJVR1VRYzhLZHhwSnFLaWlJTFNmcDhuckpPQW9uaGhBUXZPV1A1Mmda?=
 =?utf-8?B?Y1VJUG9DTzV4bW5aanpnT1ZkbDZYenJ1cXBkUnFyWldWdVU3RUdtbjhDa2I0?=
 =?utf-8?B?MWRKQU14aDRVS25aY2dBT1pzb3l6VnJIc3FuaTd6SG5LMERrS2ViTUNjMm0r?=
 =?utf-8?B?K2trblZIQmNnOXNhNlBJc2RPRm5XWHFhRjBHWEROYTROYmZCTXFKcHczeUFq?=
 =?utf-8?B?SW10bWVObGpKZHBjY2c1dENFWmc4MHJWaHpXd3V6OTlEWTYvK3NkQm82OUNn?=
 =?utf-8?B?UUdOei9iN0Nva0JtWmJuV2ZNZHpuTG43YTR2REt5d0RrbGlmZjQvdGFZVE1C?=
 =?utf-8?B?MVZxeU9NTUNIbXNqVUd1djY0aEFHQXlqSVN0VHp6anhqZ2lmUU5HSTFqQzls?=
 =?utf-8?B?aHhpMjRtb25Yck52RVBPTGRGMXRDczQ0d0FpbnJqa0czbkVxVW9TSTRXcmFW?=
 =?utf-8?B?cFNNRHhFSlFXWWdRNHYwTGsxVjllNmdaU2xReW9WVHFrdFZXdW1pam5HTmxI?=
 =?utf-8?B?NU4vUW5JMWkvUFVyM2VNTllLUXBpbnF2SFZuYnEybEZRNlRsaHpiWVNJWFV5?=
 =?utf-8?B?Y2Mrb3hyK0hqOU1VTkZnR0tMRDVWeGNoT0IyUkZFanUyYlZSSEdzaWIvVVlR?=
 =?utf-8?B?YjFHdnRpUUVIYkQxRTk5M0xSVGV1RmFHY08vaGc2WGIrZ0RiMk9ITUpkVkpl?=
 =?utf-8?Q?xARSb6B3iU5JXYpY4P/3oH+/pI6R2gQasRb10yA19IIyr?=
X-MS-Exchange-AntiSpam-MessageData-1: aG9gIvNztLUy2w==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eee8e40-a225-4a47-a6fb-08def6e829c7
X-MS-Exchange-CrossTenant-AuthSource: DBBSPR01MB0009.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:03:32.7857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wAyypufQHzgDS/RlRQsUGl8CznYpcnhTHEJvR3w35cFRfJmT33U+8owVZd4WkWEuGWyXrCfAgUD7mGqawbXRq1hb5TZ6S/7Z6haDmyAaYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9522
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gyirOWSJx1/M0b/5Wwkoov/vHSz7A+eaZwB4dU0okE=;
 b=d7x84jMwUSIEGDWKOSZCxF3zxBXWLTbZK/TFqL64jbWch8KUleifSmy8MlbILo6TLJxF+bK8WjlnRc9QK61kPqhxkiDC2qpquDuU6qqY4a7qFKORIplDQOxJM5F4+tzEksXNPEeKtbwpG88y9p7Fw0LAnCuzBH6Q1h2HW6dkHwk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=d7x84jMw
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Casey,

On 8/10/26 2:47 PM, Casey Connolly wrote:
> The mkmbn Python tool used for some Qualcomm platforms needs the
> cryptography module, make sure it's installed so the world build can
> succeed by adding a new requirements.txt.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Resend to correct list
> 
> Changes since v1:
>   - Use a new requirements.txt instead of adding the dependency directly
>   - Document requirement in doc/board/qualcomm/signing.rst
>   - v1: https://lore.kernel.org/u-boot/20260720131325.37436-1-casey.connolly@linaro.org/
> ---
>   .azure-pipelines.yml            | 1 +
>   .gitlab-ci.yml                  | 1 +
>   board/qualcomm/requirements.txt | 1 +
>   doc/board/qualcomm/signing.rst  | 3 +++
>   4 files changed, 6 insertions(+)
>   create mode 100644 board/qualcomm/requirements.txt
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 352269b08354..31962db1a40b 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -704,8 +704,9 @@ stages:
>             python3 -m venv /tmp/venv
>             . /tmp/venv/bin/activate
>             pip install -r tools/binman/requirements.txt \
>               -r tools/buildman/requirements.txt \
> +            -r board/qualcomm/requirements.txt
>               setuptools
>             if [[ "${BUILDMAN}" != "" ]]; then
>                 ret=0;
>                 tools/buildman/buildman -o /tmp -PEWM ${BUILDMAN} ${OVERRIDE} || ret=$?;
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index f53c9286c0c5..9831dd61bc18 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -153,8 +153,9 @@ build all platforms in a single job:
>       - python3 -m venv /tmp/venv;
>         . /tmp/venv/bin/activate;
>         pip install -r tools/binman/requirements.txt
>           -r tools/buildman/requirements.txt
> +        -r board/qualcomm/requirements.txt
>           setuptools
>       - ret=0;
>         git config --global --add safe.directory "${CI_PROJECT_DIR}";
>         ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
> diff --git a/board/qualcomm/requirements.txt b/board/qualcomm/requirements.txt
> new file mode 100644
> index 000000000000..2033083a01a7
> --- /dev/null
> +++ b/board/qualcomm/requirements.txt
> @@ -0,0 +1 @@
> +cryptography==50.0.0

Maybe we could add a

# mkmbn

comment in that file or after the cryptography==50.0.0 line:

cryptography==50.0.0 # mkmbn

c.f. 
https://pip.pypa.io/en/latest/reference/requirements-file-format/#comments

As it isn't clear from the path of this requirements.txt what this 
applies to except it's for Qualcomm :)

You could also decide to rename this file to mkmbn_requirements.txt and 
that would provide the same info implicitly.

> diff --git a/doc/board/qualcomm/signing.rst b/doc/board/qualcomm/signing.rst
> index 317cd57cefee..ad1d0faa58e9 100644
> --- a/doc/board/qualcomm/signing.rst
> +++ b/doc/board/qualcomm/signing.rst
> @@ -26,4 +26,7 @@ For example:
>   
>   When you run make to build the ``u-boot.mbn`` target, ``mkmbn`` will inspect the DTB in your
>   U-Boot image and try to match the compatible to the table, then it will build an ELF image and
>   hash/sign it per the MBN spec.
> +
> +The mkmbn tool requires the python ``cryptography`` module, this can be installed in a virtualenv

``mkmbn``
to be consistent with the highlight we have in the paragraph above.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
