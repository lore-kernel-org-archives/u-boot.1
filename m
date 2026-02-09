Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2431AEF06EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEB483CDC;
	Mon,  9 Feb 2026 02:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SdCIUu1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F084A805D7; Mon,  9 Feb 2026 02:29:06 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF6683C5E
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgnNcvj0JW+2uX5noVDPDsuTpUKVW80lUkOkFhGvq9Y2Mo9w6OOnMkesOpG6h8lRh/4beLtWCJxAkfLbJqLlrMhMAQ49ds/iRbR9sL9PIqSzGn1k2JqevB6OPwVU80ySsZCPRrYBz8kGm6vuX0pdJVvZk0nxVYPQ00wbFjNDk1Q/LprP4Mo2Vk3zMiQZWk+qkQPmPWqy5veRvyRDhb9HjdunkClkI7x3/dlP0Z4lxgruG3Cpe5gd7Y8+3D/BB+Wqjm3prg0Rnnem/58PiGQj8ox83LkMLzvQIViLfL5lMUSgimxJ2iKIj/oJaoiKStSyhbO38auX2rUCUb4sGfRuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VssyrbsKhy/hzCHFhqpCm15ufXmqdTZQ6a9TAby6Zcs=;
 b=uD0RStKaSfkw0tzCe7bEqzKKmKVrNBuO8e6hwFWcr8uvnIiJVymuujnYRGDyiLypREYneLsjdahiKZgy/QwEE8XsVOb4dcWzFMSllzGf8Fo8JUEUVIT7FvE1v08O5fgh5fMN0ldaCxN5Jp0FoAjO1fOtM1Xq6Z+x1ExX4OQr4LfK/MoeJz8hR5fIxrgD9NuXDGKXIylmiWv3NdpUGvF9jCYQEuwg/UBq17mGpQy+u7n/N2fbZ0Ee62Cn2Y2KsTFai92cXw8Hsi3qeRymqcHGQm96e/CA/WysauXQBgQhN9DtH/b3l9ANjUuDGdYVmComhb8hsHqd1NW57prKEs66jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VssyrbsKhy/hzCHFhqpCm15ufXmqdTZQ6a9TAby6Zcs=;
 b=SdCIUu1R8kVU2lbLLL5FeMNK94eHwPHTtqACNRoVLKTZ+u2pJ/I+EHDTdTKmCM0KzEdRdq/Ne+xhya0WEVVyY+EoXHkhqbU6A5Se2PYAH2t7Kh7DFVYdnoDnXPAppk1eWmXdrfBVajyRitBRpqbaYC8Fhypdhn/aN+vc7afrl5svbEAycfSmy4/1AQS8KvjzSrllCXHmGQVk/sN3fWAfDHmTWf07659ycMPusv+fHUBJdv8u+UkfGffENmYGVuFp8mMxqt7LTEQKWnFjSnMl1ZylQbOLstiaUUSeCmqGRn+jqQxRmz2jO9J0O7TH16cYEAzbj4ymyfnpyzEtYiZS0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:29:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:10 +0800
Subject: [PATCH v2 06/14] xtensa: relocate: Add missing headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-6-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: af43928a-d520-4f65-d14c-08de677a9bcc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFdNNEhDVXZIM2NPTEE1ZFN6V1U4ZWFJWGhSOVlqcGpjN3Nzd2FYTW9JaXRG?=
 =?utf-8?B?bjVKZExUdzFVcTRZUm5Fc0JqcjkvdTRLREU5bjhEb1dENGNhT1RoL29XZzA0?=
 =?utf-8?B?Vm1vTUtKVnh2QldJcWpyMXp2di8vcjgzRVFYYzFkc2NMK0tqZlpJOTZJZjBx?=
 =?utf-8?B?RFN4Ullxd0hTdzBseGZVMWF0ZmdjMDFxVXFUVkszM1gwSnpIN1dEbjdsRnZs?=
 =?utf-8?B?N2VCQkNyblp3ZHBwRXZGOVVwWnM0M3VFejlLeGZ0bDBJM2YvblRUb0tEM1hz?=
 =?utf-8?B?ZjM0c25TckxVNWRrckd4cDJodWhGdU5WU2k0eVBSbDJaYUU3VU1LeEJ6R2dt?=
 =?utf-8?B?bGxUQjA3aDdqY3lXbzlMZDN1U1ZISkhxcTNwTHJzVG5lY05xTG1vNzVJWnQv?=
 =?utf-8?B?QlM1QVZxc2lZQldMcnk3a3lsNGF4N0phemJEK1pwK0l3S0FEcm9ZMkRJRFFx?=
 =?utf-8?B?bW9EMnRKeTl0RHBmN0RydmJZQ1dUR3BQS1V6K3VmL2kxanRRQnpzbmxNRXNs?=
 =?utf-8?B?QTk4MER0aTh4RnBmK2hOQkR5bGtDL1FjTVFMV0pwaGxnUEYvNW9wNExyTmRp?=
 =?utf-8?B?M2pDQTJFeXhzRHMxM2t6dzFISFU2VHhBcEZhWVljeW5xNmdYelhubVpTRW84?=
 =?utf-8?B?WnZNcWNIV2U3RFJVb01CQi8ybDc2M0I2NVl1dDI5dnUyS1Q1dGN3RURRaFhB?=
 =?utf-8?B?Q3JzOHdTc3RMRjUxbkgzZ1kyNVhNSkVuRjl0ZUVCdE15NEc3Z2lRZzZkMGht?=
 =?utf-8?B?TEZhZ3FTcmNNcmNjYmcxMjBNQjBMYyt4RmpzVXQ5eFI0Z002ZXloQUU0d0I5?=
 =?utf-8?B?TkwzUkt1UVdVVmRVZ0lGUTZNUHNrN0lrR0FEaU13bVNlRW9lREhCQy9menpN?=
 =?utf-8?B?MmUybzh2SHkwb0EwWnlaYTU2Y0ttYmJYcEpicEY5ck9yZ2oreFJ3eEE2UXhC?=
 =?utf-8?B?cnB6OFBTUXJ2SllpNDZWMElQUVlTRHlSS2w0ZTlmY1UvemRzTStXcitJTkxP?=
 =?utf-8?B?bjgwcFBaNEFjSFcvSTNUMWNReDR0eFI1ZHp2aCtNSjRIVlRzZ05OMVNEbzRh?=
 =?utf-8?B?Y29EaDZBQXRGZ2poRS94UHJUV0tPeEorWGE0d3NYQXdnQWZKRGdPcE9hS05B?=
 =?utf-8?B?SWxrT0k0WmVzcjBodElESXNSTkJ2V1RYcmthcjRpa3NGZGw0dHBDNlJVUUpu?=
 =?utf-8?B?bklGTlZZRVpPUmZKQ01VNG83aG12akgyRU43UmUrZXpoZDJyUlBzYXcvc2Rx?=
 =?utf-8?B?cWtXQkNyemtPTmFNUkhXNlRPTU1IOHBkUTRRdVVlRVVsMlVNVjcvZFdHT0tZ?=
 =?utf-8?B?bmFIZE1TQisySnlIbUQzaHMvaGFEWEJsNWs3L0s3ZWhEa1ZrUjJQMnd3L0Vt?=
 =?utf-8?B?d0NzNEQ0aHNRVk4yRHBCSFZqTHh6N1BwYThXaWNjMU4yM2dQdGNGOWlobDY0?=
 =?utf-8?B?dTlEOStoclVid3FJQlBPd0lnaHlhcW5SaDQ4L0JOcjUxaWMrS2hvUjhUVjJU?=
 =?utf-8?B?UzNtUEVmcnRWZjI5UU1zeU5sN0dHVzBUUmNocVlmdzVIdmZTZkNXb2RXaTQv?=
 =?utf-8?B?Z1RNS0dsNXpaS044QTBzQ2YveTRwL2NRUy85VW8xaEFTQkNHTktwZUZCUHov?=
 =?utf-8?B?UXFjd1BjaTI0RTAzbG9BQ0I1aWVkTXJzZy9DRE8vN1B6MTE4WGVsU3EvSEw5?=
 =?utf-8?B?VkJDZUp4QVE0ZnFLUlhxQmJyK3U5UEpyWHQ5Y3NGNlJ5aTdacGdlODlXMG95?=
 =?utf-8?B?QkY0SnRqdldla00vRktGazBWeDlGMlp3MnovbU5QcElaYytJTGVoSUJveS85?=
 =?utf-8?B?bG5QZkRzMVVkaVBsdnRDU0Q0bDk3VFVZdW9NY0h1bmE5VTV5WERqNGRhSnhL?=
 =?utf-8?B?MTY0UW05bWRYWGtOWmtMOFVWRjVEU0Y1dmN5cUZNR2dCZU1Jb3hxQ1E2WDgr?=
 =?utf-8?B?MWloZGVkQU82UEM2ci9xeXN1ZHRCTnl5c2ViS3pGZm5QRWxlL3JBbXBQUmxl?=
 =?utf-8?B?TkxTUFdjUDFoQjhaOHd5ckZnOGcyR0IxR2tSUU1TVzEyekhySFBpYzdycVE5?=
 =?utf-8?B?UUtvT0VyQzA5cUxZY2FUaDA3Z0lHY28vRVJVNmZYNitqeTdYMDJMSUIxM25M?=
 =?utf-8?B?SkVDVjNzM1pKQWFPQVR3eVdiS2FUOFdKMXNLKzFHbWI0ekluRUFyWU9oamF3?=
 =?utf-8?Q?NQkregy3E/ZI7Xyqy8YlSEM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFF0VWRiQ2xWQlhqYjAwZW02SFcwemUwajZPSTdlQ0RKSVlkQVRKVmhGTHdk?=
 =?utf-8?B?SmQzQ3lLRVRNakJJZE9RaVNCSWNUWEplZkUxeHhzVnU0RSs2dHBXUXhtNm5F?=
 =?utf-8?B?eHNad1F5dWFQQmsxZzByTXM0YkVWZlpFY2xLUzhBVnJxV01ILzJrazNCZVpY?=
 =?utf-8?B?S25RUXRaMzFhVS9IV0VISXBQUXlUQUxDZWtGVUVlZWx0Vm1kd29DbXdYaUxQ?=
 =?utf-8?B?SmE5ZGE5dUtNZUFRTytOWUZDWHoyT2VXS3hPVVN6QWVwN2ZiUTY0dnVKczMx?=
 =?utf-8?B?N0t3anVqTUVkTjc4WFJLdVZMQ21GWmh0YkFRN25vYktzR1hpbmJ6Z2JKMW16?=
 =?utf-8?B?UGxwRldZZllOdm4yM2pyaDA1M3ZLSi9mMnB3aWxURkVLa1FVWmFlOTB0RzE2?=
 =?utf-8?B?MDNRTUF4VmczSVNoVWYwamxPek5BQ1U2Rk1zaG1UR0VPUjlrWTVWd1NBYU12?=
 =?utf-8?B?ejd5UUR5Wlp2V1VkT04zM1pqdW1YSFA1ay8yaFk1cDNHUmNjNDFmUEpxVTdK?=
 =?utf-8?B?MWZ5RHlUaVpCNDA4OEcrMTJCUUVERFRZbHlIRTFGazJGV2lNZFp0V2ZiRFRP?=
 =?utf-8?B?Qll5RkQzd0lzY0ZXZ2VMdGs3eFFpbEQ1eGo1cE5VcERGdWxxd2QrNzg5TjRZ?=
 =?utf-8?B?YjBWQTlDQ1hDclg4QkRnQS9OckovbndqSzFsaG12YUFQT1NCaHllZzhUUnlF?=
 =?utf-8?B?WW5sQkU5MlUzSjBxQW5DYW9Wck9KdmRCTlNaTDY1M0tuYStjMmdDR3R4QUtj?=
 =?utf-8?B?eWV3RnVrNVBlSXJMczlBaFZMWWJ6U3VsTUtORmZ5ZXZ6OTRUOUwvdFRETkRG?=
 =?utf-8?B?aUhvMmpOV0J1M2NYY0lUOGNVOG9rMUN6MERCbFQxWmhqWlNBdUNGWUs2SnlO?=
 =?utf-8?B?MFJtR3FvSWVJdWpMV0ViL2ptS29JYy9kZzd6VFp5WjNVbU9RTVYyaXNPbnlG?=
 =?utf-8?B?S0FPRU54aUdnajhNamJYZUJmekRDNUk4SklGcWdSRjVna28xQkgvNnZHY0hQ?=
 =?utf-8?B?ZkxuLzM3Qk1iVk40NjFIR0Q5OEdXWlJRS1lveEtYZnF4eWZqK2haOWlGTU9Q?=
 =?utf-8?B?eWx3d3ZOa1N1UTZUNklRcmFSQmFhbFVXQ2JiTzljQ003c3A5LzBwR3Vpa1Fw?=
 =?utf-8?B?RlhLRUkybHRQOU83YW5yZzBPZFFFK0c3SXlBTG1oQzV4ZnFyTVZYdW1YdnpW?=
 =?utf-8?B?S2hBWnpCd2ZNZUQramJQbkVpOXlxbnZrS1lIb05rTGhhb3NCMEs2TUZQSlpR?=
 =?utf-8?B?dlhVOGJZaTdkK1BqaDFidHk1ZGZBSVhtV2RoT05RajFyRTlYaTdpU2g4Y1dI?=
 =?utf-8?B?bTQ2L1F6dWhvZlN6SW8xMSs1YXpzdmpkZDUwZFViU2hJZ29FaUFkTTRJT3FM?=
 =?utf-8?B?WVJLR0FhSE51eHFxaVVXQ1ZyZWNSS0NCNGZLeFNhMFY1YW91NzVTKzBUR08r?=
 =?utf-8?B?L09SUlozb0luellrT3d1Rm1nNldLa0VUZW1RM1N4bDhKeWpZcno3WFNmdlFP?=
 =?utf-8?B?N2hKdWZRNit4Vk5rOVNQMHpJZ3pnVUZTN1MyVmc3ODV1S1dVbDJSb0NSZDd0?=
 =?utf-8?B?S2FEWng2VGYrTzFuQnpqdlQwRzNTbk93cG0xMml3aTZDc095Q2xMclJ2V2Vq?=
 =?utf-8?B?WTVXaWc2T2htUHhxeVJLU0ZsUUpvc3o1cW5aYmRnMCtuL0dMdmFIOE85MXIw?=
 =?utf-8?B?UzRNcjJoWWRVRkpyMFUvNVh1L1EvTHFJcERUR0tZRUtZSUk4eEtxRG5CVnpw?=
 =?utf-8?B?WTNRWG9vVk5ZS3NTUWlEYUlxaU4vQUVPa0JMTVZSMFlKbHFWaUIzSVE2MkxJ?=
 =?utf-8?B?Mk1yN05vTUtxMFBnT3pJUEczdHYvb3lScHl4OWNiSXduZ0l2N2srNm9vR0JD?=
 =?utf-8?B?ZlE0WGtTUCtwcDlrNWhuU3BqS2ViLzRycTFpRENET3k2dlFLNndVR2tnNDBS?=
 =?utf-8?B?Q1dDc1dsNzZ0b2NHM1hCQjl1MzdqQTBjUk83aVVEMXJlU0I5SDl4UCtsdzFa?=
 =?utf-8?B?b1hnclN3d2xLd1V1L3FPdTZWUkJKbmk3eFBDVHJpeTAvWndTdkczd29PVDZo?=
 =?utf-8?B?dHVSOHlCbG91ZVAwZkxjZWZaWjE4RzZUbDMwOHdMTDZ5dFNscGZxakVqOURq?=
 =?utf-8?B?UVpDOE1PUWhLcldWOHhSaGxMSEkyem41MEtsWi9JN3lsUUxkekpPcExxanhV?=
 =?utf-8?B?VkprN2FwQnFKYnBXMjk4ZWlBc2REZHRic2E4RGI5QTBmWnJwREFrTW1BekJy?=
 =?utf-8?B?Q01Ua3lIL2M1YXBnRGRzY1Z2SVo4SFJncW43SEZqSTRndkZqblRiNVlDUkwy?=
 =?utf-8?B?TzJCU0tsYnJlcGxCSFF1aUU3OXMrTHF5U2g2WVR6K2JMVDdtQmh6dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af43928a-d520-4f65-d14c-08de677a9bcc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:03.3571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqteJqbwSt76gsAMgiu0LoBIHxXmyL2ab4CchRcXl5FFJ1MIRNLiyCCiTOX0zyVMO26s40M7CCmpPLAts63SVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

From: Peng Fan <peng.fan@nxp.com>

memset and size_t are used in this file, so add missing headers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/xtensa/lib/relocate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/lib/relocate.c b/arch/xtensa/lib/relocate.c
index a499590c75bc5f143ef9dd008b36262b63e027de..d3d317edf88fe433908ffb2300f8f8733415d1fc 100644
--- a/arch/xtensa/lib/relocate.c
+++ b/arch/xtensa/lib/relocate.c
@@ -4,6 +4,8 @@
  */
 
 #include <relocate.h>
+#include <linux/string.h>
+#include <linux/types.h>
 #include <asm/sections.h>
 #include <asm/string.h>
 

-- 
2.37.1

