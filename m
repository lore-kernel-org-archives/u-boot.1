Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4725DC44503
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 10:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D0483946;
	Wed, 21 Jan 2026 11:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FbHkrnkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45EED839DF; Wed, 21 Jan 2026 11:55:54 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59FC58341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1CI0JM6G37HHClnqpQ7szbPXIT8pU0NX9guS/2myK4EbdB4pzm1N0CEWppPWqyIsv+mknau76IoIFyBi7uchREaVpwM+PkF/orCTvcxyI+4Sv2pbEiQwB3s/d9V4PyOuskR9eHG1CCAwwD7KN+D5BLJ1Du4uUZVEvDiDt4WXmxKo62AHd9p+w41aDRI73QUylmvA8K8ma3NSDZEujk4KHFO2KaBwOdAYFegTHi4YqB5i+M/Rm6nuXax7WvAErdr51vtXQDTwQBPahQAbef6LFylLYOIIvs5xX75eOpTveFbynt5OB1VEqb91GNn9BMmq4Fbzp5ZdqAOGF+LGun3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Il5DJttFNpAEVV2L2aUWJN/Scg5JyB5iYibCJwI4uk=;
 b=sGi56tQVMvCXYZ6Y7q5Ive/rPL2s2mrAo34Oo9TvF0PfStpo2twQX0AoUzOW/a3p3xoyz1Iz8PAzI2/wfG49KsSH4F+OF7zvtVkoh7BEmIT9i2lVHF/yvSlLzPqugfqk9uiSkl5Bg5ciVAGsNwuXb44PLwti0vDkkrGWmwQ132l3fWVu/Q/D/XY8eE3vwDbYyrPytjsX6O1m0vZbuCyOm/3gZD+r3Q5RN2KY+1N7eBZLBDxNSqjVDJcGfr4sBIzjL5Sf8VXiE+OCnvfeYgG4Rj+gyNJTJZqOXDy0N3uFIKHjHWKXC6w1PpLyDDtnaIz9aZIg39Yh6heP1gMaRnJUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Il5DJttFNpAEVV2L2aUWJN/Scg5JyB5iYibCJwI4uk=;
 b=FbHkrnkPR3bLo9t+ahJQQELJ+UlIXpsi0PxbfHp485RhjGl1S9eQ6mo83wkS2YgQA7SJOpTemwyMRT5d6xq83F3RTcjiw4BRiOgppoZxJ69c9VykRiIoGJ3vLeUQw31KLx8PGUZ5RG/t+scLQ9KHPaMxYgeLHb8WwV/fvAgt15w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:55:48 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 10:55:48 +0000
Message-ID: <cd902159-94b1-4ba0-bf66-b69a60186c5e@cherry.de>
Date: Wed, 21 Jan 2026 11:55:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] doc: develop: process: Move Custodians section
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120223405.469050-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbc8724-d465-4063-5e29-08de58dba2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVZuYVVPaXQ4VHFTaEJ5NzkzR0F4Z2svOUNENUZiSG1QWGZyT2tSeFB5dDI4?=
 =?utf-8?B?U3BpbkZCa05TR2hqelBJVUlyaGtMQUhFQ1IySmpETCtsQXJpcnBySzgrWWJG?=
 =?utf-8?B?MFRDUGU2YzI5ZmR2dWhuSlFvS3RFWDFzL0JrK09GN3o1NktPdFljZlJqOHM1?=
 =?utf-8?B?d082RU9mcjloT3N4NnI5ZUZjcTBYWTdXeGtDMWpVZit6WitDWEpNMy9uYkRE?=
 =?utf-8?B?RFQwdnljQURDQUhFRmpvTUgxUkY4NEFvUVo0RnNCaXlUYTV4ZDVQeHVJS0NU?=
 =?utf-8?B?SFoyY1JIa1RLZ3NGdTNCcitJZlRBeCtDMGxyMFlydm1uanRxTzZuekpiU2xI?=
 =?utf-8?B?QnR4NTV3Z0cwYmFCT0NkVGFRS0FkWldvYnYvSFk0VEFMTGxQRXFSYTRNNmFQ?=
 =?utf-8?B?RzZkMlFLSVExeFV0d2QzMXJNUFlkTnBXN2hzYkY2TUNmQmNZUTBmNEZtKzlM?=
 =?utf-8?B?VHVnL1piWG0velZEd2VRYy9KSmV3Yk5pZlMvK1FybG56S3RoZjZ5YXh1Qk5m?=
 =?utf-8?B?WFp0dklZNWk1OEJmb1FXZGsrMFJnMGU2M285djBtRlVvcjRhTDFJRURobVdy?=
 =?utf-8?B?NW4zbkl1L2FDRWdGbEN4dXUxSlZHRmJJZlM0OVh2c1VVWlFPRjJVcCtodndV?=
 =?utf-8?B?WjVTVW5DRFRFeW93K0NCQVl0SHlEbDVKWkdCMzVpVHRKazB0clB5a210QTJr?=
 =?utf-8?B?R1pmTkxnYThETkg2bTRwZkhPcittR3YzNTYxNnBuemU5bDBnMTJkQWhBYlI2?=
 =?utf-8?B?SWVkK01oR0QzUjlMQzBFMHUwVVhPN1pMWmt6d2Nuc1NKdzBJY3dqZWJwVHI4?=
 =?utf-8?B?VzV6b0w2TUpyenZXY2tabXpEYjJON3JHVVB6Qll0Ni92RS9LZjRRNnFHN3ZN?=
 =?utf-8?B?V3BBN0NFOVV4Q1dseGQvQ1dwRnpldG04L2lKbVp2bWtCM1Zhd3BmMk8vZm5H?=
 =?utf-8?B?NEc1WnZWVXRWbEdkUVBidXB5NGFiQ1dJQ28zQW9oMis4M3hkbU5FMkNCM0dH?=
 =?utf-8?B?cER3cTc2ak4vUVNoRnpBY1dJeDRYYUFmWldraWhhekt3cUNtN3VYbG0vRldj?=
 =?utf-8?B?QkNITC9hYnBxSWNxVFNKQXBZZUFRV2tsa0tIT3RVd2lyYkNxNzg3WDl0Y0NI?=
 =?utf-8?B?RVR1c0tMQjBwRHRidGNwckR1MGQzcGNtNHZmczBOcWFONVRTVk5Ka0FWdSti?=
 =?utf-8?B?N01hUmNVUCsxNzB1R2tEZVZtbjBaT2p6UVBaWUQ1NHFRZGhOVXNaT3RjYkgx?=
 =?utf-8?B?dk1ZZ0gwOHdVYXV0ZXN3RGtmbFFURWdmTklJaklxMjdMNFNJemducDhETkV4?=
 =?utf-8?B?OFREamt0SW1NNElkQUxtcFhqVzJNcUJjV1VaazhjVEg4YWxFMVR5c2oxSmRq?=
 =?utf-8?B?SFJNVkY1RHhjc0FrODllSmt2VWJsdzhSVWN4MEZTQXlnaUJwcWxDU0RZaWhw?=
 =?utf-8?B?cFQ1ZmJRY3R2NEdWZWZOMy8zNmdCc1UvNzdVY0IvdWErdnR2bjRoZVV6TG9U?=
 =?utf-8?B?R0VITXg1TnhCWkkyQVRXRUFMZjNYMUNpRUNPNG9nLzVWV04rR25GN3QyeDF4?=
 =?utf-8?B?V3QvWm1oRXRGbG1CRGhhRWttTjM1NFVmcVd2RzlxTG9aWnQzWkg3dFNldzBn?=
 =?utf-8?B?K0JRbitiaW05bTdBRTVrc3N3ZityTHBkc2tTd01mWTdZMGlyKyt2TFZRT0Ur?=
 =?utf-8?B?RnlHaUZFcm5xTkhoU2owTy9UbklRb3dJcmgxTEkxVzljNlhKam1zU3FBY1A2?=
 =?utf-8?B?Y3dvWU5CMkdndkE5RGR5TUdsMTBZRlJuYjRrSkMrRTNkTG5CWjJvdG5HVHBm?=
 =?utf-8?B?L3JJQStpSDdNeWJ5alh4N0kreElBNFJ5VEhZQW81R1k5THM1NHpiQzVXUE05?=
 =?utf-8?B?MXJ4WnBpUmczWEUzaDQ0VXVscVY1RFpja2lZOUs1SkJ1UU5FemFHWGwxN0ds?=
 =?utf-8?B?VHpWWEFiZmszWVU4Q2FreUQ5bEYxMGNsMFhTRGNxTWlCWGZnNE4yNEx0SWMx?=
 =?utf-8?B?NGdzMVhrdFI4TnJUYlpCdTA3TUNqVVp1eGlNQ2lmR1VqYkJaQjIxVkJpSlVK?=
 =?utf-8?B?WlFNRmN5dWZyYk5WTHE2eTRUL0ZWdUlJc0FmUHBVM1N5Z3kzNnVJdG1UVTAr?=
 =?utf-8?Q?UAnc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWZUYUYvMmRqM3lhT2dLZFdPYmd6WFFoZjI2UldTUEhwZUJjYjlFQXl5UlRV?=
 =?utf-8?B?YkI3TlA1M25yZ0FaZ2V5RG00eFpCRUp4TVFQSU5peDlUUWt6Nk52QnJ0aEo0?=
 =?utf-8?B?WVNUN284SGRCcGZmUlRNNzNPRFhaR25IMTZjSy9NQXdJYTdBVUxjdURoQmVa?=
 =?utf-8?B?MjNSc3FTZWk3QXRuRDE2SUFqV1JLMDhXMEdZM29vMDNGSWFFbVdZc2pBUThw?=
 =?utf-8?B?Snd2MmJ3TTlSRlh5WkpCNWhabzMrWDd2dGZHOGxnc3VJY1JOeVQzSmdaOEND?=
 =?utf-8?B?Sm1ZbC9wblFqMkZzOCtCZnBESnRHSUhiQUt0a1NrN0J4RjhaMmRJd0tkWTdt?=
 =?utf-8?B?bWxzOXpyOG9pdHdza2pqWklxbThrU2RGNWp1QTZIRm1Ic0grM0JzZUthMFk5?=
 =?utf-8?B?aDN4b01DK0xGamhlYWQxaHA4blZiQi9JVU1tSk5BY1JBWGJQMjBldXo5UDhU?=
 =?utf-8?B?L1RhWG0rdmZHSTRIV21wb0RPQm93OXFsWGdyTXYrRHpVNmxkZVBHMTh1UkRW?=
 =?utf-8?B?TDFMUEdiWEw1a3pGNnNSSysrOG00aWdEUWR3MkRJMjZyUDhpTXhCNVNFRjN0?=
 =?utf-8?B?TXpSd3JNS0p1YzhCOWpGci9JTStOczlVRldkOHVXQ0g1QysrMVljbW81YnRW?=
 =?utf-8?B?OEk3NFNpc1V0RW53SlZadWRzZTdmcFdTSjRXN3J0SkdFNG1qS0xadGRmMUVq?=
 =?utf-8?B?TW5sRzZYMVdqMUZwS3h2bFAyTno0K05OclZuMWxzZWFkeXd5VnpuZUtOZXVF?=
 =?utf-8?B?R2N2ZHNTOW1VRXNzcTNucThBUlE1U2cyNlprUlEzaHFpMW1nT0VxNTF3Sytz?=
 =?utf-8?B?YjBKWkwzT3dDeUJmS1U1VXNldW1LejFxQW9CWkd4ZUZXbWZlRFpvTEpLbGNK?=
 =?utf-8?B?dGJLV1c5dTFmVUk1aUY3ZW1GZEU3Nk1COVMwTGF2NGF0TlVHM0NtL05Cd2R0?=
 =?utf-8?B?UmJtemJQQU5IWlQ3Ympva2lwd283RndGVWZMay9yVVhHOWhFMnBjVWpSMitX?=
 =?utf-8?B?RytrbWVTMDRRVFk1b25ERVlYNjBGbXVTc2tWNkRYYzlhOWx5VXQzdjVBMEFR?=
 =?utf-8?B?R2pRb3FLZjZyenVMcHY1d1lYWkFBTlRCM2tlUHQwLzMxYmVnbTQ0WGY4NU13?=
 =?utf-8?B?TnE2eWx6Z2dvdkE1NjZPeXRuSE1PM2V2cUtRMU9PSnQxaTdJS0J6c0ttbVFW?=
 =?utf-8?B?b1lUTFR3d3d4M0FyS010YW1aSEs5dTF1YzlFcjU2WVBFTWFxRkYxN2pPd28y?=
 =?utf-8?B?Y1g3ekZNSTZHOTRCTjFlWFRjTXlKeFVJQ0dReDcxZ2RzcVlwQ3VKTXR3K1gz?=
 =?utf-8?B?aVRqazFlaVNCak4xcnVjL3ppUlBZdlhKb0V0Q1dTcGo1QTg0a2dPN29sVG9R?=
 =?utf-8?B?OFFoL0ZadmRYaFBDTVpXVDJnYm1TV2Ixa1RvMWlWZ2pLeW85NUVmeVE4K0ll?=
 =?utf-8?B?eXhHaTNWY1d2UGdNelJNS3E1YnpWWGFkOGdwWVQ0a0dPWWtQdXNXelJ6Z1F5?=
 =?utf-8?B?VWE3NzM1US9lSDNoQ3BSb2txdDhHWHVCU0NIakhKRExXcW40ZWwwYWdIL1Jo?=
 =?utf-8?B?TVF3c2p6dHJjaXdRMHJJR2t2NWFxZjRPTlZmWlVTWGRXeGtnbXY1bzlGTW5h?=
 =?utf-8?B?cXlxQWRJajZyTko1Y241dXBVaC9mTXlMVi8yMjRkVGFRNGE1QUxxcU5DK0Uv?=
 =?utf-8?B?NHRhUTQrWk5iVFAwdGhHWTQ2d0p5WVVldTRiTFFjUk5oVHB5S29iazZkanVQ?=
 =?utf-8?B?aFQ4QTY0Q1dENHdKSzJSOTlYdXE2MHFWRm1mQS9LZjFkcmxvdkZvbDZWQmo2?=
 =?utf-8?B?TGhXcjlGbVNmaHpNeWo4Nm9EY01vZUFqRkZKalU0NGVzUVFtQlplcG1tQXpO?=
 =?utf-8?B?VlpNdHdRdmNmeExEQzhSdmFXajNmeXZPRnQzTTZaTUp3VjVuR2xuTlU4Rmtm?=
 =?utf-8?B?Z2RQa3cyaGhIdlRJOVFrdEptNWttbDVyL0hjS0ZWZHY2OGdSN05vQkZMUFV3?=
 =?utf-8?B?K054VUp5TSt5Y1d6cDlQUEJtWlp1bkFIeUw1cDVMN3RnaTJYc0R2V1BJcVI2?=
 =?utf-8?B?UVVkZFpYc3l3TnpoVU1icUNJZVRJTHNyMFVWOGN2dko1RWNSbkR4K1NIeHpR?=
 =?utf-8?B?Q2VUSTVMRkYwZ1UrSVF0cVRGTzdwM1JwMFNoUmxsc2Z4djhmT21vUmFuelp1?=
 =?utf-8?B?WGp4N0xBZG5hSFdBYXNYQTVycDJDcXBmSGNDMDRzaEZzYzhxV0JTSUVxRTUv?=
 =?utf-8?B?dWNKNnNES0ZQMGlva2hOWnZUTWFsbjNJVTVJUEE1Q1NTRFdBZDN5LzZPY3pE?=
 =?utf-8?B?cVMxQVUva0JGN240WExuMmQza1FrOVBBem1mWGplMTdIWmZkdzVjSWF2R2tz?=
 =?utf-8?Q?b32/3wvZTKKCFqOI/e1YGOXD59+h03L1Ht68R?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbc8724-d465-4063-5e29-08de58dba2de
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 10:55:48.8097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKKS32j9bD5LRfPb/btZmbod2qvgXttbxhk2TebNFc2CZlzIqxFkSTf/f+CIjsLC72Mj9zrD4SAcEy6AcYZjjXLPfQd86yWtbCJMJNYbIEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
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

Hi Tom,

On 1/20/26 11:31 PM, Tom Rini wrote:
> Move the "Custodians" section to be after the "Review Process, Git Tags"
> section, in preparation for more re-organization.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
