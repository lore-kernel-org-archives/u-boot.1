Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D807DCD583B
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 11:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E7483A57;
	Wed,  7 Jan 2026 12:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="gaag/4Tm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61C883B03; Wed,  7 Jan 2026 12:15:54 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7411F803F5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 12:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomas.melin@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWjDABPRFpVvs1aaItSWrTGs7eyBys0zjT92jGusQNOi+A0Osx1No3c3Py4j7+g9BbWDQSivpLurqw+fPnuub0x42ICj9mcGmJ40KKDp7UoR/Lc+8QJceIbSh2PtINIm9EsvhITAfanjQfvrlalbhlZcHNfDC2ESHvnjQjX5bI64deq4IjLh28vCTkBnqEZMnw1Pz2kV+rA/B6lnLpxas5ppYrB3iKhzzw43pSV79ct9V8pUO7+1CDvR/bod8uwn3yvenbeWlz9e80kALaofQV/QUn4e/moQ7FrQLd6baz21TUY9GyzvUtGDZdl5eRqzRl36mWuy9KSHfMsMwCI6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm3mXQYTs4IsHG7U+C58UTCIFl6/tyxv+rJzOVwBmDM=;
 b=x0XbVcmNAGU1gHmJoJtnIWYduyjwVQiOR2k8SJyhwJKHkX8oKVDPnK84AFmz7dctYHpUjeSIrrKuZKLexLFv2/rYIAdL7s0XkiZa0+M/li4V1MFVCGkYaFAbOPPwdUCH1acAMo93unl+//6zt7YRagrZ6md84E2yhLjvpYLBFkfJvFwdJp3hnn9924OAQkldDlFUPDQD2qdQesgB9ObJX4lRhyJKN26S8L62IxPZCpPC2uuBzoAMninnP9dSu77kchKTJuHdIi0diUetXRE65+toaT0BMDyaApbnRZma1gxRFq4mwXBTFAdSHga9v5pJaZHXNTdczRfXuhXbT1b4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm3mXQYTs4IsHG7U+C58UTCIFl6/tyxv+rJzOVwBmDM=;
 b=gaag/4TmTBHi1wPLQL9SI+ezLbcHIMr6ttxdjCfT439j25bE3w/wtZ1HfboSgAMWf6qjIzeGK5/WeehriDVi9GFBh583LhSdcAvAfd9m1av7skQAUEgMlyHlEvjrlOeOeVeC7nlw8rfK/dBxeqEJEI1M27q0gLyYdJrD0VyXdJHqJpPPeU77xSv9/qtXtJQe3qYNQeO19+4neqVlBOYFbNYEpyuIkn5DCjEry96ktQ8YqThbm2NWv2eIWernXrbSiO/xW9M1K53xbIX2MFD2d1zvHeRcfYNbxfKvyNxZJZ7afw6JkIW5bK8EXGaiLnvAiZ8dC8Q9V8iIJp0/Mwu0zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS8PR06MB8226.eurprd06.prod.outlook.com (2603:10a6:20b:345::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 11:15:50 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9478.005; Wed, 7 Jan 2026
 11:15:49 +0000
Message-ID: <e8016430-2ffb-477d-b29b-378aeb0ac75e@vaisala.com>
Date: Wed, 7 Jan 2026 13:14:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] board: zynqmp: add cmd for getting boot auth state
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, igor.opaniuk@foundries.io
References: <20260106161545.2416551-1-neal.frager@amd.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20260106161545.2416551-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::30) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS8PR06MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a942efd-c8d3-4a1f-b5de-08de4dde1cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sy9lN01ZZFpTb1g3NEtpZWh3TkV6TGJYU0lDR3VLV3FlWlJDdzJoQTE4Zk1k?=
 =?utf-8?B?dWZnTisyRk56VmZYU3IrcWlHdnFyOWJrd1ZPM0dWQW10Rko5QUIzS3ROb3NW?=
 =?utf-8?B?STlGQk52N1pGMTdtODh1L2VEUnVUeG9NUzVaTnBYMHFjQVI4ZUlQUFRhK3lu?=
 =?utf-8?B?TEEva0lSTm5pSWJ5NU9oUlk5NVptL25UOUNQb3FyRjMyNWN6MHV2TFZMcTJP?=
 =?utf-8?B?cUY1Q0lLbFlBNVduVDlhVFd1Q1BEMWlhd0ttazZRb2NJdkdtOXFDVkE5enBW?=
 =?utf-8?B?RWc5b0dZVnZqUHZVd2tmdHpSWkNVNm9HbHErV09zOGRIS3hGWk1wT1J3alJi?=
 =?utf-8?B?Q1U5Q2lyQXdSc2FsdFJQeGdBS21xQ294ZFBHSmYxZlVEVG85UnphUkNRaktH?=
 =?utf-8?B?NmFtaHQ4enJBR1RUNitxUUd4d3ArcUUrdXJDVUw1WmJ1bk8rdThPa2l1OGtE?=
 =?utf-8?B?U2F5ZVYvQmRVMEdCNXVIZ1E4RHE2azVNNTIwK1ZuNUcyYWNNdElXU05kNDJ6?=
 =?utf-8?B?WVR1a3JoWTdEb2d0dnFYS1UrNzErSXZSemxLdVQ4ckFNdDc1NWQxUzhwa2VQ?=
 =?utf-8?B?bVZmVjhDTkNTenhxTnFHbFN4MEhqVEQxbVRUZmFXYXkvUy9oZWF6K1UwNG1m?=
 =?utf-8?B?YnVSaHY4ZmJUelRrWVFjVENKUjNIUW1ERm5tN25FUmEvQjZPUzB5L09wSzcv?=
 =?utf-8?B?V1U2UmhINElEWHJ5ZHNiait2Vm1aSEJDQVF4cTRJTERrbndmUm95eCt4Vkdn?=
 =?utf-8?B?d2hBQVBaTFpTOUJTZWJDc081UDFJdkFleE13UXdJK0tqVlk2dEs0RjVrWWc5?=
 =?utf-8?B?VTA1dkkxb1RCUVlGRnI5U01jSTMvR1o1eS9Ra1VVUEpLRHpBVWpVa2ZiWEIv?=
 =?utf-8?B?dUdSSmlVTU9aQ3VIMDVGa3VKUjRoUXJpdXBlZlVNVkdPaVY5SDZKYVRmUU1C?=
 =?utf-8?B?Z0FMMTAyNDB2bHB2bFpJYVZxTEtEb0hEbmkxUXBKMlI0aWVJRVdPWFVON0d4?=
 =?utf-8?B?UnA0R2ZWVXdFWVBHY3h0K3Jic0JrV2dEcHk0VDRJMlBKMm9pREFHK254S0F6?=
 =?utf-8?B?d1ZselBRK0lTTTBKR1g2d0VrZ2NWS215ZWpIMVNMY2sydHNFdzVQMUtFeE5v?=
 =?utf-8?B?NENzOGpJK0dyVjdPSVNMYy81ZUJET0s1d1NMM28xSVpsTnhBRCtNTFRUVjM1?=
 =?utf-8?B?ZUlWTG1UTzc4NXNoRkVWL1ZrVXFkRXlxWERoVDlPZlVRcTBUbzFwWlBnbElw?=
 =?utf-8?B?Q2FJYlhPOUltd2NIbWFFZGh0bnoxNS9UTHdaY0Vyd0t4NWpiTTVQd0RhT0R3?=
 =?utf-8?B?aHEwbUF5VFg4dmVaRERUNDBaM2dpanljWVFqT3h0TXZaSTNzQThOYUc2Y3Ni?=
 =?utf-8?B?QU1Bd014c3hNL2V5cWlLNDRsbHNFbDFMeXlEckkzZW9hVTRpRGl4Q09wNktM?=
 =?utf-8?B?N1BCZlY5am5ZQVh2SXIzd2NjK3l4UjlCeUR3WURHWDA5eWpTVFgxVEpZSXNK?=
 =?utf-8?B?Ry9FaytqZGxsUzVDUmkvODFmRkkvbmRIekNvYUR3bkVybnZ5RU9ORjRHR09p?=
 =?utf-8?B?c083NDV0SUlGbGh0MDRMQ1l6K1lmWGwrSmRlaFJ1aGtyZGVFSENTTHNaZ0hY?=
 =?utf-8?B?dmtPVVIyeEdVeCtvekt3RmljUW80eVhpc0JDRnI4QXlBMS9ZT29rZmEyOC9I?=
 =?utf-8?B?VFlmdkVyZUZGVU9RbE1hVm5SWUlScU9NQ3dKMmwwNFEvZk14amVMTDNhdVNG?=
 =?utf-8?B?UDFtb3J3RkRYQTJSZVJTUkVhN2E1Qk5lK28ra3ZQNVkrNFhsNXV4OWNVRFE3?=
 =?utf-8?B?Ymc2UGRIVEpiY0FEUCtZeHpXQ0RpZm1mRktmM3RnQmQ0T0xoMVFhQ2s2Nlhk?=
 =?utf-8?B?MHRKaXVTVFFkdEc3LytCQ0pLRnQ2eWlrUEFSNVlYOFJPRDZFUVlDZHNqMHJz?=
 =?utf-8?Q?G1Thr7x7THU18xMpV3umQHGEX5NpdLaP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR06MB10365.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(7142099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3luL21pVmdYSThUUHdhM3VmUnhMN21GVGRoa3JXdVZKV1lhL0hTRWtDT1FF?=
 =?utf-8?B?TkpqWFkrRWJjRFFJbFc0VSt6cjhQNGxCNTRRZWd6Wkh4WVBRVmMxWW5tZGw3?=
 =?utf-8?B?Q1ZoNm0rSjZGQUREeG4yR1Z5eEgveGt1aU1KQ1dJYTNGN2F6WlJYWTVPaHhl?=
 =?utf-8?B?bnExSXRJblNBNG13UWx3clFkdkVGVmJIbjlwTi9tb2lWUlpGbGtuajBERjZB?=
 =?utf-8?B?YXFLTytHVU5ZT1J6SFQ4ZEFWb0Fnd2d2OHFIaFJSZ1Bha2E4bS9qeHpCRUZn?=
 =?utf-8?B?Z2VudG52SW9wYU9mM29xaTUwenZkL0JZNEh6OGJTMUdJM1p3Mk9ZRkxjS2FZ?=
 =?utf-8?B?YWtBZXBFM0pZUmR3SkIwakdKVldQVTNidWV5NjlGQldNMEFYVlhGU09SQytW?=
 =?utf-8?B?em85M2M4ZGxFY01NQWxZSXJFcWV4SHN6OHNSQkZjaXlCNGVlUklDTGpaeHpx?=
 =?utf-8?B?R0Z2QzNPb29iRVQwU0FBTmhIcUVpZkhyejZtUElINmF6K1hoZWZuejlyZ0ds?=
 =?utf-8?B?Q0JaeEs0S0RSWG45RVMwZjdObzRTclpkd1lKU05jbmNPZ25OUmhCc3ZvOGxP?=
 =?utf-8?B?QmVPVmlsY2VndW10ZzVQRk95aHRXUnpIWFkrNi9UeVhRN3B1NERGSUl1MnRh?=
 =?utf-8?B?cDRONmhsN1ZDZTdzN1duaTUxa3FTbWlkL2w3SXBaa1NZdDZtUEl0TytpVlFj?=
 =?utf-8?B?TmxXZFlxcW9yZFRZa21tRGo2NVQyQzgyM21tdDJ0WFduVFZiT2N6QWVLeFFm?=
 =?utf-8?B?c3I4Q0RPdlhsS1NXWGlNdGIzR2dnamR6Q2hudVJOZmhVT1lNZmU3OTVNYWp4?=
 =?utf-8?B?N1ZOM2pEWjQvSVBTbldJM0VHSmJuT1lRdzZtNGh3b1F3VUd4Sk92ODRXUlZs?=
 =?utf-8?B?WXFwZ0JYQXU0WE5wVzNIZ21DMDQxOEY2ZzBSSzlveGxNSmxxZG1FR2g4N2ZN?=
 =?utf-8?B?K1JvR0k3VWlHSk42d3N5d3RkNW1CeENyckMrMmwraWlZa0VmL3dHMGhoMVZm?=
 =?utf-8?B?cXJvYy8ydmVzZEthMTlwTDdxOSsreDhUeW5TcnR5aURkbzhIazZ3Z00vMEk0?=
 =?utf-8?B?WWVmdXZuSnFNY29PSW4zTkhBc2h4cFFoUFN3QkVoL3lhYWFIVzFUdWdIcEJn?=
 =?utf-8?B?SmxJcXJkUzFLZlNJMC9RQ3B1ZzNaazYzQWs0QlkvOU96Z2VZamtsei83WVlH?=
 =?utf-8?B?L0tyU3VEUkV2b0pEU2tNM042dFRDVnQ0THl6S1M1ZkQ2R0hyaEZJRisvYXRO?=
 =?utf-8?B?QXBTU3Y0TWtlRldKMnl2VTI5WkE1bTgwVjFBK3pIT05JU0p6cjh6V2RiYkxh?=
 =?utf-8?B?bWVhMFlsVU9EMFFlMExxSm16c01QNWVySENKY3M3VVl3YlllTzBRb3hIZHh0?=
 =?utf-8?B?aUl2eXVTa0FxVm5zUEU2Q3UzRHNSaDZja3ZNblBBQmJ6YlNCc1JCUU1Gb1dx?=
 =?utf-8?B?dVZqTFlLNi8yU1YycnJHaU1JNGFRNkdnTThUMmFjaThRL0xXTVAwZE9zdlpj?=
 =?utf-8?B?V1JBSjdwM3BQVHJQQ3R3cVNBZURYbHg4UHl3UGRjOFVTZ0x0a3I1KzdmMkJH?=
 =?utf-8?B?dW9xWlJMQ0hIcjRwQi8rUmJORERWKzZtVHpaU2RKUU91YW8yb2RGVmhCY1BG?=
 =?utf-8?B?Wk9mdGltdGV2SGxWN1hPb3NSSHRGdVR3UnpUUnREL3l3SUUwZExtTTJzMW1L?=
 =?utf-8?B?ZWFNWll0WklKZ29PY0JEa25xQ0wwNmZJUk5aaW16TWZYN3o0Vzc4ZkpnajRX?=
 =?utf-8?B?T0hzYk12MWtvL29KY0M4WmNVdTRpTkNhYmZZQnNvalJPdE9mSVdDcS90RVls?=
 =?utf-8?B?SUxWeURublJtMUJaV04rcXZiZksvUVNyUStyeW54L1J6MjcreWZzUWJadEUx?=
 =?utf-8?B?KzNGNnFBZlp6bTlUY3pKZ2kyb2JPVVVxa3JSek4zSmRTQkhWY1RaV0VrbnZo?=
 =?utf-8?B?a21kRTl3SVd0SmxzK0FTTUtMOEhDb09zU3grSWpTYUs5c1k0UjlEYTZvTTcw?=
 =?utf-8?B?WWdLVmRoS3hSRHI0dVpwMDNQUzZ6OFRIRlVZYTNxUjlEbkdaYjI5MmtGbVdR?=
 =?utf-8?B?WjY3NFRWU21xakxtdVU4SjZRWGVkVW5qTWRIYlRzZndheFp4Ukl0V0tuZkUv?=
 =?utf-8?B?WnlCWkJvK2M0T0lBdjBEb2M5V0wyVjVESktGeHYzTklJR2NXdlc2aTJObit0?=
 =?utf-8?B?VXJ6d0FYYStvbDlVV090MTR5MThhZ2JkcGtzME5oN2QvWG93RjEzeGZFZnoy?=
 =?utf-8?B?RjJ0MmhuVUp6ZERvT0dxaW1DYjlDWVVpUWJuaDBLMWp2c1Bldmw0UklybnFD?=
 =?utf-8?B?VC9ZeXBZVVJ4K01QWm9QNzFJUngwd3N0SWVxcFRKVklmSE9aRGZoSDdRWGNy?=
 =?utf-8?Q?MXgFhDuI3+FcwyPs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a942efd-c8d3-4a1f-b5de-08de4dde1cfe
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 11:15:49.8664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uusfL63Btn7nu8p6LpXqfgRH6J7HdLuUXwIuNbYPVM89BzwZoxlhpWNTS+TE4RO9KS40sJMatfjtOCYLDY1lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8226
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

Hi,

On 06/01/2026 18:15, Neal Frager wrote:
> Add command for checking if boot was authenticated.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
> V1->V2:
> - extended zynqmp command with verify_auth sub-command
> - changed return value, so it can be used with scripts
> ---
>  arch/arm/mach-zynqmp/zynqmp.c | 44 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
> index c0398a466ff..b15c31919c6 100644
> --- a/arch/arm/mach-zynqmp/zynqmp.c
> +++ b/arch/arm/mach-zynqmp/zynqmp.c
> @@ -362,6 +362,45 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
>  	return CMD_RET_SUCCESS;
>  }
>  
> +static bool zynqmp_verify_auth(void)
> +{
> +	u32 status = 0;
> +	int ret;
> +
> +	ret = zynqmp_mmio_read((ulong)&csu_base->status, &status);
> +	if (ret) {
> +		printf("Can't obtain boot auth state");
> +		return false;
Using boolean as return value here is not practical as this condition
should rather signal error than return false.

> +	}
> +
> +	return (status & BIT(0));
It would be better to have a named bit here instead.

> +}
> +
> +static int do_zynqmp_verify_auth(struct cmd_tbl *cmdtp, int flag,
> +				 int argc, char * const argv[])
> +{
> +	u32 status = 0;
No need to init status value here.

> +	int ret;
> +
> +	status = zynqmp_verify_auth();
> +	if (status) {
> +		printf("Boot is authenticated\n");
> +
> +		ret = env_set("zynqmp_auth", "1");
> +		if (ret)
> +			return CMD_RET_FAILURE;
> +	} else {
Here it might be that reading reg actually failed, which should return
CMD_RET_FAILURE instead.

> +		printf("Boot is not authenticated\n");
> +
> +		ret = env_set("zynqmp_auth", "0");
Could use a more descriptive name, like fsbl_auth?

> +		if (ret)
> +			return CMD_RET_FAILURE;
> +		
> +	}
> +
> +	return status;
Should it be CMD_RET_SUCCESS?

Thanks,
Tomas


> +}
> +
>  static struct cmd_tbl cmd_zynqmp_sub[] = {
>  	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
>  	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
> @@ -371,6 +410,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
>  	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
>  	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
>  	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
> +	U_BOOT_CMD_MKENT(verify_auth, 2, 0, do_zynqmp_verify_auth, "", ""),
>  #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
>  	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
>  #endif
> @@ -446,10 +486,12 @@ U_BOOT_LONGHELP(zynqmp,
>  	"	48 bytes hash value into srcaddr\n"
>  	"	Optional key_addr can be specified for saving sha3 hash value\n"
>  	"	Note: srcaddr/srclen should not be 0\n"
> +	"zynqmp verify_auth - verifies if boot.bin was authenticated\n"
> +	"	Returns: 0 not authenticated, 1 authenticated\n"
>  	);
>  
>  U_BOOT_CMD(
> -	zynqmp, 9, 1, do_zynqmp,
> +	zynqmp, 10, 1, do_zynqmp,
>  	"ZynqMP sub-system",
>  	zynqmp_help_text
>  );

