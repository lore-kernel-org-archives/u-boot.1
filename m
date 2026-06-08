Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167E1CD8C90
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 01:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28004838BB;
	Mon,  8 Jun 2026 03:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QiGv4emo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336A983EEF; Mon,  8 Jun 2026 03:43:22 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3605083314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NacIcgxA9O5NYhsmmcg1+abZqg9fKMkJtJERNvSCuz2kb9uFnWmP9lDsRSAnq/1IjFveHP23Q5rhGS+GkoRDGBVjOphoSF4P6uUi2KWECxDv9isoDaCwFdkuERiOqLUrZ90DLLL4dbXsEdDJQo3wyzSq7YrWkEa+oWWKGIG4L7y2yA1E5eIbaAvrK3WaeD3T0ofc7CymlWqpUr8dd4RLmyJ/aC2HkWGsAz2oJ2Lqj+fkVW5fyc6N0lPVEtZeq7d70ycaY9kVJk+yqwZ8MECkJMgyvCeaC36bSr3nFCEyYuSy32Y8QujszAd99UuSveGFslGniTKLNN87XuwH+TJpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0t0RFCRYci43zqIPqjw8KsxTRP8GTFll+lYypR+4I8=;
 b=IKM/aBiRA/Wf9v9RSo7mpoHvfFFv2S8taGGYgbR9I+RBxp2abHFiceJz5Bi4livowYyne1uw6ltakUwxG9XCf0dwhGj9vY4Bl52BMg0PPu6wTeLN2FDWgm1AnfH25vmLfDJ1iB/ihgscrxD4GWkbIAmWgtY0x4G1P/q/1hLtHNntpN+8UMj2q0WqGpeQQIaVFTZ3w4oXq5ousmAj2DQRBZgokuJmi+xROCxbN/4YrzQiLJ0zZkFRYkEemWvXa5mM5i63CZN6nH2OJo5P9EydFR6F+GBlqhBeAd//dCwRBtyH9AWcFI4zB/PvPJE3CFL0MKxsiL1lNKrkXdrJAp8x6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0t0RFCRYci43zqIPqjw8KsxTRP8GTFll+lYypR+4I8=;
 b=QiGv4emo4tQxMtgvI4movGgF5uGyr/dEqhEKJCXwm46pOx81LQB/DT/0rOvSlvoPMqEngphjaSOTG/h1qcyNyhJl9I4yA8pVoppB729jvyADBMCuG4XrdrMOfhcUCUDEzUD5+kIxfBpHmgtAiPwZbmtOyKBLyogvs04mTTOKzepoE5NjcqQqVXO7MHrLDCG8fuKd1M8WURJSbU5+BZpeW6u9bjwkQ8qnPT/61SKNotXtOAud/VAiB+xVTGlDrX1Hsw8Gk0jaqFHcbTV0JiT20iijUg9W8hb4wEf63NdK+lGmLSDnG/WmQjUx/ulY9FlUJV+xeII0vPidrLXTogxQ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by GV1PR04MB10351.eurprd04.prod.outlook.com (2603:10a6:150:1c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:43:13 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:43:13 +0000
Message-ID: <a22e9862-8718-48eb-9eb2-ecb51209f672@oss.nxp.com>
Date: Mon, 8 Jun 2026 09:42:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: TZASC misconfiguration on i.mx8m
To: Richard Weinberger <richard@sigma-star.at>, u-boot@lists.denx.de
Cc: alice.guo@nxp.com, peng.fan@nxp.com, upstream+uboot@sigma-star.at,
 ye.li@nxp.com
References: <3208216.Ym5mLc6kNg@nailgun> <5857153.7ts2hSHzFV@nailgun>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <5857153.7ts2hSHzFV@nailgun>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|GV1PR04MB10351:EE_
X-MS-Office365-Filtering-Correlation-Id: a915838d-8209-41ea-ac52-08dec4ff4dad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|366016|376014|1800799024|11063799006|56012099006|4143699003|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: hrdKi1lNH/rWAmTlPzKYDBkTTxMtlV3Ichl8NtsorVxJ6bM0w4dvclBTZkFHtIk2uVtEjhOgH7YbUmB96UA5ttldkk3NB0/yMRQfKuu6HLqaPyD4gDYqzKUpYG9KD9VMnD1P3gIrPqfwKx2r/ZAXbX/UMxaYcYnmlUsbRHu7gzynZyJyJNQVPAxtDwb/BPYc0hC9Du6H+jgQMkT9KtRrNnmn4M+aPzL2grdFMJJLqd/Fi9Pj1dwASHIOMM8G3gWbuztCCZwYzQfz0HHhJwPhZi5ojsABSHIHFLSX7HPYbiz+Pmg+pttf5iiYKsdJCDUpdh4xiFcH5OG7aE3ei4gm0Kq8h3wxQsBpZ1/1RnT9zBIJvvHssChfP2xV9eh9HpiTpHtoAC745ODHwOiAefnykleViRbDTYCLYYy+d1hmk3vH55rvi8VJxghcheoBwfpNOWeEjwwSfGpJ7E7diPUWF1hQ7cChSJxWACxYxyCd58isCQy6TqaAxGRs2E77s2F/nUojtQN+WcPfhhNpneaeA3b5STjCOcXpnBvqcb63kvy0jmsClTpqMcgn07Uo430hAQH0aUw79GLCW5VQ7trjGVOSmKM47+yzdUOF2iK/oDbiDng77GUfYCG9sHVX8DW86Ds2FhBmpzDTc3PF62XbRb+l3Kl2upMvHYAcZN1RXN7BU16tp0ZUVNVvp5gu4gsT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(366016)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNFeExEdGRuOXkyT1dpT3hxK3JXcWFwMmcvRkZ3N2ZJQW9haTcya3ExNjMv?=
 =?utf-8?B?V1pQSDZ4RFVPdk9Wc3I3Nnp1RkpqQ2trRmdSWmpoeWt3YnZFRkFTWG0wUUFG?=
 =?utf-8?B?QVYxcGhRc2E0K1ZGejUzVS96bldEUnR0ek05QWcwWWxtWjZSR05FTndOT3Y2?=
 =?utf-8?B?NWFMRmFJTWVJL1puMkkyQzdiNmIzSEs3OWF1RWtocTBFdlN2NGhIUlQzdm9t?=
 =?utf-8?B?OUNmMGlYQ3IyU01KdVBndnM0d2VFRlF3dktRZDVSVW5RbTl4TzhsSS81ajZh?=
 =?utf-8?B?bXZuRDAwTlBpVXdXYVZMbTNzR3JDL0M1dmxDUnhoaC9LTkdTeGNRbUNISnNB?=
 =?utf-8?B?Q1F1MWYvbk1aZXFjS0p4TFoyVUFCTlRaRWNDOXVTWENCaDNZTFdxcmZLODFz?=
 =?utf-8?B?VWRDNENMNWhuWWNKMWlaSHowaUthNkd2czYwTHI1MWJobWIxM3RLRFJyYW1n?=
 =?utf-8?B?OStxOXR1ZW92d0tScTJUb1UyYUdLUTJvVUU4U292bWdVYUxwN25CbFV1Zkxj?=
 =?utf-8?B?QWorZTVRTGk1WDVuYjhLN05GeElmempyU0hnMnNZTDNPRnBkR040T1VCdGRD?=
 =?utf-8?B?K3BvZGFod2ZCYkpNTjZOeVAycVF2aHhLQnJXcTg4SWRWU1crcXpidDkxOENU?=
 =?utf-8?B?cEZabzV4cGNNWXNhVWZKenk5WmVNbTZKMUU5VzNpN2xVajArTmVLQXFQZWUv?=
 =?utf-8?B?N2wyOXFSVWs3c3NnSVcybFdERFlKay9GY0lwcktCVlAwaExQRHB2Nmk5akVr?=
 =?utf-8?B?RGd3RnNIeHl0UDZoV0M4bHVibVl5Qlc5Q0RDSnI3R0psSlBmMWZNaHBhaE1a?=
 =?utf-8?B?cnArTU9ocG5nd1BYVlVPV2Y2TUNZdXdBcVprQkRRRHZYRHBrT2t2SmJVSHhk?=
 =?utf-8?B?T2FuYjFmWmdrNi9hcUJJSjRTenRqS1VrSjdDWXNQRVZHLzhHRzR5ZS9EYXlE?=
 =?utf-8?B?SEoyb1Qrc0U5MldYY2tDakE0QWVVM1ZCNUtFME5zRDlWSW0vUG5lMjUxOEZP?=
 =?utf-8?B?TjlSN1psaWNwL1V4UXdFUjQ2UEJJaDFaQUdodnp6aFpJUENiY1VlTHpIOFkz?=
 =?utf-8?B?V3QxcG9adk9DOTRFeE8rK2sxNERPdlBCb0czYnpEcytJV1dZMElTNFhKK1VP?=
 =?utf-8?B?bExMOE92UFdnKzhkZXhldWNTK2FxY3plRFd4N1g5NHp6UXZFNFMrSWU2b0lD?=
 =?utf-8?B?MWd0bW9raE13NStYTXBGMTNIT2RFaWpENHMyZHdid3Nkbzc5SitmM0NyZnhI?=
 =?utf-8?B?TE9VN3NDWFNkeDJreUN3M3ljam9HMTJrQzh5L0syYjh0SU9LcXh6TW9jYjdF?=
 =?utf-8?B?RGtCaXZrQVhWUkl5cm45eUZNN2djTDFoMmowUFp3YWZ5cEs2cTBjT1dIQlhk?=
 =?utf-8?B?WDBwVGFtVHRHbVF3U1ZMaWN0MlF3NE9OMVd2Z1FmN2orNklPUTdQUW1RZzRi?=
 =?utf-8?B?RlNLQlBRTnEyRUs3YVgrNyt3aCtTa3MrSHFPa0VZL29VTm0xVUNDZExHOGUz?=
 =?utf-8?B?dU9FUnJvcGlmVGtLa3lHaTVaNHJKYXB4KzZaaURmRzBuT25WbVNFWER6OVVp?=
 =?utf-8?B?TEdNc3BPSXArQTd6NVg0NjJRTmYrbVQyUUU2QzdJTGY1bjNMMFc4dlBzb2Jv?=
 =?utf-8?B?KzR0Y1ZWRkRaNDc0czJYZnhVUjJFSDZuM1JHYWVHMy84N1JkTzVBODJ0Q01j?=
 =?utf-8?B?RE12N3JMT2pGcTg1WXY0QVVHUW1xUG9McVUwL0ZzT0QzSFFlN1ZLMDdqQ083?=
 =?utf-8?B?UGFyclQ2eDhVbEtHZFd1OElBd2t0eXp0aGpYcmRieEFYY2NWelAzOTNZYXk2?=
 =?utf-8?B?OWFqVVNrT08xQWVFcDhyOWhxWUQvUzZQVmx1THR5MW1qTnIrSmNaWGNkNE1L?=
 =?utf-8?B?QzczTEplNmcwalVocTNpS2t2V1JLaEt0RXFLZW1aT0dvM2Z3K1NYeHNlaFQ4?=
 =?utf-8?B?VVJwRVlFQ2xwRHpucndUbjJqa1MrOTVmWkd4MWFIdVJiUzRNRTVtRE0rN3la?=
 =?utf-8?B?d0lPRnRQS3orQ1JqYko0UUtKSnRxaUlkdmE1Vnh0UDB4a3IzbSt1eEtPbFpR?=
 =?utf-8?B?dlMyN1dOS1BwV2lyODFBZWxyQXJUd0hJSldFbzc5RmxweGFqQ2tJV3ZhVHM4?=
 =?utf-8?B?MDdwcnUwNFJWNmZIZjg5c1VyZXpZdkxMOFJWREI4VjllakZGWEhGQVJpZFZj?=
 =?utf-8?B?WHhVeHk5dEIwVmd5OXozd3E1a3AwYXBwT0UvOVBwV0NMOW5MVjVESm8xVVpw?=
 =?utf-8?B?dHpNNWh0ZnZGWGgvZ0lKcVdSQjN2ZW9jWm4xV01mU005RlVHbkJxOXhrMDVX?=
 =?utf-8?Q?WS1Yq+wpqagTxJi6Wz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a915838d-8209-41ea-ac52-08dec4ff4dad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:43:13.6036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/gVu/r69ZgS+SR//+BDNQws1BfRut+AGZmMjOBH6MnUm1+GXOiiV1aSIT3UV8Nx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10351
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

Hi Richard,

On 6/5/2026 10:52 PM, Richard Weinberger wrote:
> CC'ing Ye Li.
> 
> On Donnerstag, 4. Juni 2026 19:24 Richard Weinberger wrote:
>> Hello!
>>
>> FYI, in arch/arm/mach-imx/imx8m/soc.c enable_tzc380() U-Boot configures
>> region0 to allow secure and non-secure world access.
>> This is known to be problematic and allows circumventing the TrustZone due to
>> memory aliasing[0][1].
>>
>> It causes also recent OP-TEE to panic at startup:
>> E/TC:0 0 Panic 'region0 is not secure configured, non-secure memory alias access possible!' at core/arch/arm/plat-imx/tzc380.c:217 <imx_configure_tzasc>
>>
>> This is not a theoretical issue.
>> On my i.mx8mm evk Board I was able to exploit this and dump all OP-TEE memory from Linux.
> 
> I suggest reverting commit b3cf0a8f03d162e030cde1131751d060853e16fc
> Author: Ye Li <ye.li@nxp.com>
> Date:   Tue Aug 27 06:25:34 2019 +0000
> 
>      imx8m: Configure trustzone region 0 for non-secure access
>      
>      Set trustzone region 0 to allow both non-secure and secure access
>      when trust zone is enabled. We found USB controller fails to access
>      DDR if the default region 0 is secure access only.
>      
>      Signed-off-by: Ye Li <ye.li@nxp.com>
>      Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Thanks,
> //richard
We have discussed this with iMX optee owner. The fix should be done in 
OPTEE not u-boot.
1. OPTEE uses secure memory, so it needs to re-confiure trustzone to 
meet secure requirement not depending on SPL setting.
2. SPL also supports Non-optee case.

Best regards,
Ye Li
> 

