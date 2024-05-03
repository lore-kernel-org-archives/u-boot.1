Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37B3C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 14:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C28882A7;
	Fri,  3 May 2024 16:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d/wMeT8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C29888313; Fri,  3 May 2024 15:53:43 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3725B88BEE
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 15:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX6hgFfNPfDj6tdzVD97vKWW4ddvQ9ImPejVpHtAvvCB5UBnAjvAhDa2pVz6elqXlqaXT7AqBjc49EAruUy8Ej2YoK63QKxqpa3k59Y6/nZxw/UWggzVCHZuRuydxwz33isWPrNJ5RYvATQbV6+vLN7rrnaRtAErHIEEkML5m8/MIBzmcQa5KalqR498F+nFYMWFOcPPuXtnvcfXW3ddNNDjrXkKM+Q4sQ0kUlRVTeLOa6GyvxvBs962BSZp36pi+X+ciAmjFQC2bg/u2NAvdN8papoLYRiq4AozR4MHOPkdMFdCuGc3iv78XmGd7EpWz8Q0ZDbJSCPd8Bg55kDAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZCIBaSlbVqj6C/qCxGryS63CHneQNFejU93qCT8QrI=;
 b=ERWXDIqTHpWqlddztBlyiM4QXoyNTo/bPlqwYA6E4ETsPxeqIHMPHuqxesCOWEW+j8o94SAp/DiWMumcEjZnCX37CYDy9xGh1co2z6oCy4ASSVAhvgoQFUHIjdGPbUIFH6htV8XLJeD3O02Lz2D6CZrCV0QPWQ2zmgqgIhS8Q6zSi7SwfYMBd0VJvHse6nbzRbxbp5QDN0EXoJwkqi/Hfy8BE9CAL3rxvNK1+HYinRZ+RlxltZY82UYPvdbI80pMApEy7ozakNesjEpsLtAmtqLxnAHpybt6VB6lfLYAMOjwSuUsPdykuQieZF9fGmfUb1OnnhOA5jhRUt24xiXbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZCIBaSlbVqj6C/qCxGryS63CHneQNFejU93qCT8QrI=;
 b=d/wMeT8r6J0fn+XjE7NU4YBIAfntKNLhl4S0fP4wIDqi/1VYaB4LRpFg8kWuy0AZQTWzjRMTaXAwdJ5k/fBGreQkVcYjvdJp5rxfrF7KPdzpEY3vVlBgbx+Nqv7YSVBMAEotxcCihziJhWzUsbTPHYgICj77Y8kXa/eR69bVVBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 13:53:39 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 13:53:39 +0000
Message-ID: <beac250b-2f37-4d30-8bc9-b22e5ba3ddcc@cherry.de>
Date: Fri, 3 May 2024 15:53:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Correct UUID for root partitions
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, Chris Morgan <macromorgan@hotmail.com>
References: <20240426153338.210102-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240426153338.210102-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|DB9PR04MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: f73e792b-42e5-4289-b583-08dc6b786f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVJOemJ1a0M4VzJDNWJBU0laKzVoN2p1d0c3ai9TVVZVN2lPaDdybFRyalpM?=
 =?utf-8?B?SEF2bnVuRVZJMjE0Zk1NQjY2Qjhtd0czS213ZVlPN29pUWg0d1RzYitPdENT?=
 =?utf-8?B?ZWVkWDVZSWJDMnVPRmdqYVUyNElZNlZEUi9mazhiWHhXU01XZmtJWVN1Z0U1?=
 =?utf-8?B?ckZDR1JoSi9JbUFIOWxLVG1Wc2RFTEZwMFRXUDc2NVF2STlkY3NIbUNUbDFo?=
 =?utf-8?B?L1QyNlF4L1N1dEd3d3BrdmpiVWdneStSR0VYazdKWTZjeW56Tll3WDdTV1dn?=
 =?utf-8?B?cDFCOG1WVkx6VHg4TnUyNHpFNDBUd2hCeGdFMkNDaWtHd3ROaVVFZ2ZTbWhw?=
 =?utf-8?B?VXRqM200UzBsSlZ5VjNqY2J4SmhlN2hybTN0c2EyUFpNaVVDc3JOcDBrRlh1?=
 =?utf-8?B?VWk3RC8rZ3JBQjZha1dUaG9vWDE0c1RPaUh1c3RZOWc0K0lIMmtleXBKbitB?=
 =?utf-8?B?M09GTWpoSUtOWG5kL05tdWgva2hQZVFtS3AydDVqK2hTaTNvNnZXSHJHTTJR?=
 =?utf-8?B?V3hTOHdPaDVxUm9tR1JSUHU0b1RlMjh0ZllnaUpYdEMzN1ZORXpJSi9oNWNH?=
 =?utf-8?B?ejhXU2lqSE0rVXRiUVdnVVZJZnM3QitNWHVvcWQrcHg4SVNZRi9ZT2Q3RHJq?=
 =?utf-8?B?cTVpRkpLdCtIWlZiMWNYRERXcEdEYWJJWGU3SkJ1dnZ2WUFQOVp2emd4NlFi?=
 =?utf-8?B?cEFTcUwyM2FIaW0zMFZGTHF6MzQxbnhmS3pSV1AvRkt1emJzRHpVSVpaOFpy?=
 =?utf-8?B?M2hZbjNmV3V1R2RLMEFsUkZ0U3lsN1hpR1U3d29POVNKdW14dkVTWVJrMTIv?=
 =?utf-8?B?Zzk4NlZMMzV0bkc3d3FZU2hOZ0R1Nk9lL2xWSGFhTnpLQzFoMlR1MmhtNzFE?=
 =?utf-8?B?Y0ZEVXA3YzV3eFpkUXlMSjE0ZVpwdUY3ZlpCTlUzQUl6VzFENytGR29JZlRO?=
 =?utf-8?B?YlJvbjgxSFJpNE1ra3llK295N2Z5NUg0UjFKNGV4MFJpY09xYUVKR202MTBO?=
 =?utf-8?B?VmtYaXNCd0RacVQvcWRnWGpHVGdJYjhuM2JzaE04Um9BWUt0Szh4TUJXUUdy?=
 =?utf-8?B?clAzbi9rQzN5Qk9LTTI0MHQ0U094dW9qdE9MZmFDSmg3NWhKTmQzbHlDTWFq?=
 =?utf-8?B?ZUpWSVlyUlpLb1djZHRDQlNxemFaTlRKU0J3VnZIWXdORG04TndqYit3K0dH?=
 =?utf-8?B?d1FqbG5vYUJ0cmJrWExXWCtVREt0bUFFbkNxRzM0ZThtYVlKWGJteHA4TitI?=
 =?utf-8?B?NVRnZ0E2YS9za1BKUHlIUENJNlp4MjZNTkdJT1I1YXFrN01SMDl6UVBGYXBE?=
 =?utf-8?B?TDRGMVJSZlJoYjUyWW05N0IvdHBwMFE4Sm4xb1BrWTRsSTZFWDNMOW9raVdp?=
 =?utf-8?B?eDkvYTB0MDE0djZsanFkVXFtdXA1WUs2OG14SHBLTmtzczNZWVRKODB4VkZU?=
 =?utf-8?B?ODBaM3huK2psTm9IZXlLNC9FN2J4SjY1ZFAvdmgvWmVwRFpTSExIMlUzTnA5?=
 =?utf-8?B?aXViTE5iZkZrbWU2dmN5cmU3M3J6UkU0N05GSTJlRFBOcmUxamdvSHFCaUlP?=
 =?utf-8?B?TjVvbFN3aGVJVDczcWFybXRia0FWUERGcDdMaTN3bDl3a1JQbVp3NkwxWFhN?=
 =?utf-8?B?bjBSbVk5NXdsSmRMemVKeTRhTGJJZFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEt3bjBtRXpSRW1pZWZjd0p1TlNybkpmTzFrMkNvc25WM2RPOFQxWVFLWnlz?=
 =?utf-8?B?enp2YnZGSzFTalViUlIrWklHQVg2VjMwQ0VzVGFmKzRlVnc2K1lpSDVyRnlq?=
 =?utf-8?B?N1NqcytvM0FoNVNQTEd3dlpPWC9vbjBINEhOTFl5V3czOEFaQ2JGTDNKMC8x?=
 =?utf-8?B?aFBISHdTa2hZeEtyTnFkWE43T0xWOUJSZS9HNldGanBmbGUwRFRFY08yY2JX?=
 =?utf-8?B?L0lBcHlLUFV2NFdoUm5HSWdlREhCbDBmOFZjVFhzR1hRZ21JQk9aV2hZUE93?=
 =?utf-8?B?R1IrdSthRnFMTHV1ai9Vb1JkUnhlSDdVUUloU3ZCVEdvNlB1amQ3eUVHbS9P?=
 =?utf-8?B?RWFmaHFSa2lFR1dvREx2UG5saEJGQk1hU04xNEtKOVlCWU5VUnF4TDhlc3JJ?=
 =?utf-8?B?d1N4UlNudkpQQkFPZG1aTHIrSWl6TEQ3OGgxWHR4RnpzSmx3Tyt0VGY3a2RE?=
 =?utf-8?B?VEVtcXkxQ2w4TDZSNFZ1c0sxWjRyVUFoRjJrdkQwRk0xbTBnVDhFWklwbGFQ?=
 =?utf-8?B?VUFTUXRFb3lNVU1tOHdxWnFPam9hYkdPbDFrMElXQ1plZlQzaEtmUzAvNWdJ?=
 =?utf-8?B?dG42UzlBUVNhTmw5TFpHOGllbHh1SE92RUMrTFJoTmlreUtCdTN6a0d2aXIv?=
 =?utf-8?B?a0dsU1Z1RU1kZDdrU0dIeVBlVmE5YnlhcVNwM0xvb2xwL2VpeS85UjFDbTdF?=
 =?utf-8?B?Lzg3RFUvWjhnNlRIRzRjckdmQ1UxUTFQTGdzelRSdDdabUF6QmsvdnppNTBV?=
 =?utf-8?B?dWdmNjVudUcvL1kwWW1mS1RHNnVBaUFoY2Uza1NUaTlGTHI5ZGg0cWFsZnZa?=
 =?utf-8?B?clk0dnVoMy9DanZ6cnpYV1hHbGh4dTdDMjdvYXVpd2d3MVIxRVBralo4Qlhw?=
 =?utf-8?B?cFVsalBFZCtvQ1l4aGk2VEN2dzd4cE1URXBEZmgvankrY2F4cml1UGpRUTc1?=
 =?utf-8?B?N29raFRXK2hrMGk4TVVIaWxsU1pCc3BWVzVUYnNQUUV1MWFYU0FRMnlBcHQr?=
 =?utf-8?B?R3RIOHdnRUZ6bHl3Z09WSmE0NEVtK2VvcnhrTXo4dWpQT2QwN3VyN3lZR3Fw?=
 =?utf-8?B?WHQrSWIwZTVUbFVkQ2J0U0NhRW9nQ3FTUHlnWU5ocHJaSERSNHNOeHZRTHNl?=
 =?utf-8?B?Q1BFQ2U4OC9UT3RlalpjNy9oUkNwZ1dLdnpDTXpodU9UT2c2MWZUVmtTNDVj?=
 =?utf-8?B?MTNSdU5zclpFbTdSMFNJNWE0R0dseU1KWHd0dlBMbW83VE5PTGdVY3lTc1hV?=
 =?utf-8?B?T3JOUTd0S0pvU0g3azY0UFRlSHpDdzA1N3ZkREdxZmphQmxWZlRvbERsVDB4?=
 =?utf-8?B?NkU5MnNtcEl5cWIxS1MySXM3d2RwYlBjNEVVTEFsdVNVNENPYnRFWUdUaUs3?=
 =?utf-8?B?eXB4Z2lTME1QSDB6MEtjNEdIV2RxemxDRVN3cTVUd2xYd3dBVktTOTUyV29O?=
 =?utf-8?B?RExGQzhMZW9RVWhOUUx6d3VTTUsxenQvUTJnMWZLMHNlV2l0VXRBSUh6bTBQ?=
 =?utf-8?B?M0NnRHRDR2FuK0R1Y3VlWlgrOHA3T0N3bHJmT0F6VEs5UFRhRG9wY0tKclFh?=
 =?utf-8?B?Q01lekdYZ2QzMjdxMUdVNW5Xc3g2UkVwRFB5aWZIVFkybDJkQ1FKbkx2Q3Iz?=
 =?utf-8?B?cG1OZWdEUVlXV05uU1BYMnB2bFNuMUxPM0tpbS93NVdxbHViN2IzZlllRDFy?=
 =?utf-8?B?Z2dOQVVWdm0yMWszNFZvWGJ1S1R0TFluVFBQMExHaDFhSkdNempRSkcyaloz?=
 =?utf-8?B?SXM2RFB6M0FJK1NMVjhYK25kOUZiUDAzbmJrME00Z2FjM3Jybm5hKzhTQUZq?=
 =?utf-8?B?c21pVFUwbURUVW04M28rUGFsSDNUWHAxVVRWblpreGdEcHZOclpucUFGcjdP?=
 =?utf-8?B?WS9DMStsWGcyUGs1K25JK3J0Sll6ekJneVpFZGxRNXlwVm5OOU81OCt4MjMr?=
 =?utf-8?B?UEk4OURyVDl6cjAvZ0RSKzl6bVpHNnNEcWlJWk02M0dTcUNxemZSdXNRanNi?=
 =?utf-8?B?djRmakNnZHZNWmFiZml4elVTUWdKekFPSTdYQzhFVEtib0xnVW50L25Ibys0?=
 =?utf-8?B?TklhZXpocS9RTGF4YTBRbVIyeHBLTzVzODFLRXl3V3lab0FuQ1hIYXJkTFA2?=
 =?utf-8?B?VE82YVFpQmRXVkxiaStLd0pUY05tVW84cWYxYW5mUXBmaFJuQTlkVi9uZmtB?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e792b-42e5-4289-b583-08dc6b786f7e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 13:53:39.2089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+5RNdeVAefFwXfBWCJXNJPPie12vfRCvAgsVJv0mTHa05q9gowcR63W8ekwOqLtKFdY8RUXZRtcNpUvwGpL1jXV9RubXmYXeHDG30CqfnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
X-Mailman-Approved-At: Fri, 03 May 2024 16:00:45 +0200
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

Hi Chris,

On 4/26/24 5:33 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> For root partitions, the UUID should still be random but the partition
> type uuid should either be b921b045-1df0-41c3-af44-4c6f280d3fae for
> aarch64 or 69dad710-2ce4-4e3c-b16c-21a1d49abed3 for aarch32. Correct
> the attribute so it is the partition type that is hard coded and not
> the partition unique identifier.
> 
> Note that in order for "type" to be used the config option
> CONFIG_PARTITION_TYPE_GUID must be enabled. If this option is not
> enabled then the type is ignored and instead the partition type
> remains the generic ebd0a0a2-b9e5-4433-87c0-68b6b72699c7 for a
> Linux data partition.
> 
> Fixes: 42ec247e6988 ("rockchip: use UUID for root partitions")
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   include/configs/rockchip-common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/configs/rockchip-common.h b/include/configs/rockchip-common.h
> index 9121bba373..f620579248 100644
> --- a/include/configs/rockchip-common.h
> +++ b/include/configs/rockchip-common.h
> @@ -26,7 +26,7 @@
>   	"name=loader2,start=8MB,size=4MB,uuid=${uuid_gpt_loader2};" \
>   	"name=trust,size=4M,uuid=${uuid_gpt_atf};" \
>   	"name=boot,size=112M,bootable,uuid=${uuid_gpt_boot};" \
> -	"name=rootfs,size=-,uuid="ROOT_UUID
> +	"name=rootfs,size=-,uuid=${uuid_gpt_rootfs},type="ROOT_UUID

I would recommend to rename ROOT_UUID to ROOT_GUID also, since it's what 
it is, c.f. 
https://en.wikipedia.org/wiki/GUID_Partition_Table#Partition_type_GUIDs

BTW, it seems that type is optional, so maybe we could afford to just 
remove the whole thing? I don't see anything else defining that type 
parameter?

c.f. https://elixir.bootlin.com/u-boot/latest/source/cmd/gpt.c#L536

Also, this code is guarded by CONFIG_PARTITION_TYPE_GUID which seems to 
only be enabled for RK3399 and no other SoC or Rockchip board... so not 
sure it's *THAT* useful (or if it is, are we missing out on enabling on 
other boards/SoCs).

Additionally, I cannot find anything setting uuid_gpt_rootfs environment 
variable anywhere. I'm a bit lost to be honest. Are we maybe randomly 
generating this uuid at runtime? (RANDOM_UUID is implied by CMD_GPT 
after all so it isn't too much of a stretch).

Cheers,
Quentin
