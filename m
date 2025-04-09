Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14952C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A073E83544;
	Wed,  9 Apr 2025 14:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W5o2SHIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020CC836D2; Wed,  9 Apr 2025 14:27:57 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7444D815D1
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJBaEanSu+hvwnmkKTbAUxXPRsNzyvW6gbuTUyJHxPYgcZEEDAauRJrHve6PH4iTeqtk2UQUgJuGFYG0r2X3T8udS3d/mlkBn3aYZj4LJ9vMeLxvmPdmIl29TkIsdzQpT3IbMVkHZml3EHgQQBpDmfCEV9gouVU9Dl8YteXZGs2zZiFRrLw/+i1SwJdVwGnLi33G5z/QAGDkWlcydNzBcj3bJblxTXc7ReAiDaqAD2R5YH6r7bDKVWjm4etxEfeRUIait8aa6jO3nQT6OzvnoBuOKkPP4nZ4WtnpS2/jWR3qrOUrrYv/JDRn04V77mbj8Ob6BLFRirM0eZBFQHYcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y2XtFYLRYas9/fQm4j+mKJwobnhLAvn+hlVNEqEeOQ=;
 b=fmeGfmvtjMEECu3zyJE1Ue+pnNpbQAthuWpJSfUgGj4Ye6f1YCadZXg13NxCCXYhqlxkIbAMdpCWfwsUScut1fndHXWUZDL3MAnEAwp/GCFyaILg5kbtPw8ljJuG+68hu/ijTU9e7Qe0UgpdatCrds2VNl20S0+RPmBscBYGTdOQLOdjLdukvm4AMEvKyRMrEZeO3+0WRwbv+z7aVoEEhw8JS+rBvVm654AjqvIaN9turomhXSsCuhrga3kVzsFnSd00qedlDbxphzWEvAoWPeOqPyFhHCpHtyPllTfH/miG/jXYkC2fCNWEL43OVuPyghFWKiDfkN15TPlggr8Xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y2XtFYLRYas9/fQm4j+mKJwobnhLAvn+hlVNEqEeOQ=;
 b=W5o2SHIzQ1fS7iYimWYgR4XtJUyn65wbxt5hM5DITpSxZZa4jrck48gnGM69CYgaRprXbGSbyUBeBNN9OP009XJBWlFsISHrivbiDLIgv3QWu6ZjJiiMiv6cO6tsOxiI9ih31ouxZndCsv6f6pdL7spRyhUsUK5QwoxmSPMb0lY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10935.eurprd04.prod.outlook.com (2603:10a6:10:590::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 12:27:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 12:27:51 +0000
Message-ID: <8b395cb0-4523-4381-b172-ecc378735e3f@cherry.de>
Date: Wed, 9 Apr 2025 14:27:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] rockchip: binman: Factor out arch and compression
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-3-jonas@kwiboo.se>
 <cc9d923d-2635-41d8-bdf9-9eab0fa78249@cherry.de>
 <b833ffb7-9a28-4d74-bcd0-9de43a859690@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <b833ffb7-9a28-4d74-bcd0-9de43a859690@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10935:EE_
X-MS-Office365-Filtering-Correlation-Id: 24aa6cd2-0684-41bf-1409-08dd7761f250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3p1em80UnhwczhxTVhhdzIvZUtLTGpjT1dJT2NFeW9pdmhBU1hoL0tZanJ5?=
 =?utf-8?B?OWtNeVdSVitQV3FGdC9HV2I3bWFRRlVaOG1nZnBURGx0MFpiR1dlWldCd0J4?=
 =?utf-8?B?endpcGlZMkdQSFQ1MElNVWJmTUlKSUJtaFFKK0UrekpxV09KQ2tYOHpjSklN?=
 =?utf-8?B?VjBoS2d2L1QwY0JuaXMyQ2xTQWxSV0J6N1pRU2pwN1VzK1BZSmxVWGVyeDdm?=
 =?utf-8?B?ejI3NG4vUEFrNGFFWEEwNjVod1JaRmU2bFRJcmlnRm5Xd29OYkxGSHhWOUli?=
 =?utf-8?B?eXVWWDl6dnJsNkVlbkJtcE5WM3VHVkwxT2hRSldaSjdTZ0wyWHdMSi9NNFZK?=
 =?utf-8?B?UHBEZFE5dW5IYSt5ZzFnb0xONWtxUnQycjBpdWdMbTdrZnpUWm5SQ3I2Ui9K?=
 =?utf-8?B?SEszR3BMNjBVSjR2UHoyL2VBaHZxN1IwbU85VnNmZVhBYTBiTW5ETDUzYVAv?=
 =?utf-8?B?YnhBVGVnSFQvY3JVSUp4cHhXcHdXaHZCdTJ0RjdrU25DRHB3akVhKzJsZnF5?=
 =?utf-8?B?SHFibS9mNzBqUU9aRG5QSGI3OW1qRk4xZ2RjQVkvc2hMR05mbWRLanQzczRS?=
 =?utf-8?B?eGhFYzNkdkdmTSt0RFlTekYyM3RDbS9Nb052TWsvVnR6QTFPMnNjNUJHZlNz?=
 =?utf-8?B?am14WGE5OVVIU0JWK1Vrdy9UcnBaUC9OcEFBOHlMVmI2SlIzSUErcFlMay9p?=
 =?utf-8?B?SXdYZ3VOcEhCV24zQlRJalJDT0JoREdBMzUxNHFibkN1R2hETjAzbWJsemRj?=
 =?utf-8?B?YmpBS1orVS9DTExCamFiYW8rMXJHR0c3WnJzNUp6TjdmcTUyWW9PNWFkcXRy?=
 =?utf-8?B?N240SU14VzFOb0lqSG9oU3hRcTJRNlljRWxheDRxelY5SGVBMzdqNzg2d2s5?=
 =?utf-8?B?Tk55K0FUNCtwZElpcUsvR0hSR3JxOTdoM3NyenIrOHV4dWdUN3lDZnFSdkl4?=
 =?utf-8?B?Nlp0R21HdTdkdTRBK2FyaEJSSnpsZFlzYmZQbktwNnRLSU0zS2g3NnBtdE83?=
 =?utf-8?B?bjZYWVFJY2oxenp1RkhKU21kUUt5S2RJemJibUIxbExUS21SV2ZDL2xhQm93?=
 =?utf-8?B?V2NPSjJ1QU1NcHp1WjVBNTNBNEZ4aG5FZlFOSTdCUGgzaWJwWUVBZTdwOFZN?=
 =?utf-8?B?dnE5Qk8yYkRwcmFIbnFyVmhQWDZDSXhBb2tReTZlYThjNzdpSHpiam8wclVx?=
 =?utf-8?B?UTdBQ3RPVlZLSGdhOGhSWVR4K3lBb0FvS2NTeTVhVDRDaFQzMXNNSVo4RFR2?=
 =?utf-8?B?R2ZWSEJuMHdoT1dZdGpZL2pxL2JWT3h3a0lKMnkwRWo2ckdKTm1VZ00yWUI0?=
 =?utf-8?B?ZzBkTmIxeVhhanlHSFQ3VHYxQ3BsdDZ5dGgwNm02MGMvanp6dERyV2g4Qkkv?=
 =?utf-8?B?eFNCQXhGUUljcFFEamVseEFiWHBBdzFDTHIyM0dUWUc0VmkvRlA2ZU9VUzhL?=
 =?utf-8?B?c2hHdm5jdHUrNDVqWTRhclVtZ0lKR0JiRCtiSWZYcmNVQzlyNXZGYSt5NUFl?=
 =?utf-8?B?d3Axb2pCb2JXOUdCcWtFNEFnMkt5N2w4angrYnFpaktZZWQ1OVBTZGhnTTJW?=
 =?utf-8?B?Mm5RM2tzMFhJVG53c01QazJGOVlUZ0FvVy9oVUdCcnhyclZyYmpqSzBLUTA1?=
 =?utf-8?B?d2QrZEVCaUNZRUtLQ0x4SVNiTTRZcVhxT0NhbGVpc3ZBS0hDS0hzd1RNSEV2?=
 =?utf-8?B?SHd3SFdySEhFQzFmNnJLMFJ1eldZb0lWSkZHQktJcER1VncrMEpnMS9qTnFB?=
 =?utf-8?B?RUZFNFB1aVpUTkZPQzFucEpIL0EwUld2U1dvMFM2eEI3bzA0VjNkWXJ3QWR2?=
 =?utf-8?B?VStGV21TYUltSTQzd0o4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2VVdlplaHJjbnp6MHRSYlVNM05QNHU0MjN0T25qSFlyM3M1NHBzMlhiL3N6?=
 =?utf-8?B?Z1d2WjNpMzZCVUZ4SUYwMFRIMTlCZWF2a2ppVHo4ZVI1eUs5Rmp4ZXFJL1lo?=
 =?utf-8?B?bXJoeXUwNm84Q2I5SkJZekFnUzlaeXJSRjEvcDJoQno5RG1TbTY0MUlWOE1M?=
 =?utf-8?B?YVBFaUMvQTY3VlBPaTIwQUhJbFhPMWwzd3JIOElocGk2b1N3QTFZZDJWc09L?=
 =?utf-8?B?Y3N2aUpsN0ZzMkd2cTMrMkFyR1NNV2pOL0FjcjF3cU5vbXRpRzFNcUVRenZC?=
 =?utf-8?B?V0MzMFRORFFPc0cwamlYOUZaZGpHQmtaZzQwbDNMblRNOVJDenNaOVNlR0c5?=
 =?utf-8?B?cE5VdWFOSmw2eTFUc2NFSDFqWnpBSWRUQk9HSkVRM3NwTXZyZ2lkVW5DL1d6?=
 =?utf-8?B?Wm1JZmltK0IvSW9zRmErWWxvSkJKQXB5M29mbEgxSmV0RTk5dWRkNS9XNUFX?=
 =?utf-8?B?M0s2SUpEeWd2eldoeGtyY1I3TGt1NlRwdll2SEVTU1hTc3JxTjNUNXpTdkZG?=
 =?utf-8?B?U0pFVmhkREVvQnhzM1VTemY3MDhhczZtenFEOTN0RFowL2Q0Y0xVYWkrU1Fh?=
 =?utf-8?B?aDc1aStRNXVoQkdTUW83Mkk3SjU1WWljdWlUdzhwSlFSaEVpUDZzVWg3VzJi?=
 =?utf-8?B?dDk3eEV2aEQ5QXVqdXFqRmQ0N1dmSXJCT2hyMnlFdWU3cGxuVjNLOUhMTStZ?=
 =?utf-8?B?NDNuNUdUa3cxZWlMbkNsc2VpYXQxTUNFUTRvUUpDRXJ2UjB0S2VOVTdsS3JN?=
 =?utf-8?B?NG5wVlpKSktEdHcrTjVtTTRKbTNoNXp2TVdEeFJIK1ExaGxHeFVudUpjMFA3?=
 =?utf-8?B?VG5ybEZWNnk1SEJ2bktEcnFUNEFPMEVsSW9VMGgxRzBmanVXTjg4dmZLcnNJ?=
 =?utf-8?B?ZXdPYVR0QTZkUzErUVhmN002U1c0OEttSTV1eklaMGs4NFY0Y0dTYlUxam8z?=
 =?utf-8?B?Lyt1bFBPODJPUXcvdVF4M1d0OXFNS1JBYWV0MGxRbFBjaCtpY0trMnNjR3gy?=
 =?utf-8?B?dTZGdldJa0g2ZnZKbDB2YjQwbDZVbFdkOFlUMW4vaThpejM1eTBEcHpwUlVE?=
 =?utf-8?B?Y29vcDd4YUU5RElnVnkwV1QyeTlKWEE0UFFUMkZwNVB4QlBjZ0RXRTlORW5v?=
 =?utf-8?B?SWdlWmtBSjRDL2lLTW1GS2FtY2RIOXBVYVA4S01UWTJPNVI0N29QQktNTm5H?=
 =?utf-8?B?Rlgvb0RvTEQrWE1TanZ6VTZuRkNLaksrWElCRkpsbnlTVkMwa1FDOUxCK1Js?=
 =?utf-8?B?NDlFTTRsZ29rUlV4b250dk9kL2lZTU5rMFJaRUVWb3ViNHZtbzRIdjZId0FQ?=
 =?utf-8?B?dld1NTZHdmt1YzFqTWVtcThCQThnYzI1bW5MNzc1N1RwOERMMFdINU05dXZX?=
 =?utf-8?B?WVBCZUNNWGY5TTZRYjBRM3BTSXNMT3JIQWlYeUVrUlNNbklyWjJxMkhVUEVo?=
 =?utf-8?B?UlVSeERRZTVMaWVIOFdwc3VDcHJkRlJPNFFlVHNpLzNvV3MxUTVzdmhLeWpR?=
 =?utf-8?B?OGtFVkFSelptNmdBWHBTek9oelFBUE0rTlAwejF2SHdiRG5WajVwNTBYTXdG?=
 =?utf-8?B?QnJKSTUrL0pISjBhUGVVL1BBNS92ZCtGS2d3VHM3bHN2dzBZUUpWbjhDTkV2?=
 =?utf-8?B?MmhxT2ZPS1NVNURQZUNpYzBqRU5acVp2ZExnbGVLNm9vYi9tdy9xMWx2TEdz?=
 =?utf-8?B?QVBQdmF3L2VRck5mbFFjRXBGNXhhSXFUcHEycFlFclhRRnp4c01XSjNvUzhC?=
 =?utf-8?B?dlFVdjdHV0Q3WEV0eVcxNE9oOFR1RldOTmwwK2lvQ2RlZ0gySUJubWtmR1Nw?=
 =?utf-8?B?UlVYdnQ4Y0lsVWNTN2lVR1FDZEJ0em9iNU1vQ25jeFR6OFNrZ0hKMlpyZ1hu?=
 =?utf-8?B?QUpUT0hrdFJlek1iV0VRUlp6TEk1NUlaMFRTTCt1WW1lSlJMbzhUNGhwSjlK?=
 =?utf-8?B?dW1qV0Z6WTQ2Z0xvWU9WWjlySDZ1ZVEzTFVXeUZ2QmpBTzA3MWNzdjZzcUVS?=
 =?utf-8?B?bEV0VmdqdXdITlRNdE92a2Y5N1R4Yk5SRGY1Z2VvdE05aVc1bm9tbW1hLytz?=
 =?utf-8?B?YnFCeC9HMWF0cGlUZTA1bExuSWhhbVlpU2cvbVF5WnpRNWdsNmVmYlE5Z09N?=
 =?utf-8?B?ZytCY3NhQ2JoVUY5MnVnWktWMXR3R2dXM0c4WkNoa0VpN3FDTE9tVlBIaURN?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 24aa6cd2-0684-41bf-1409-08dd7761f250
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 12:27:51.8706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+4PJtkICyp7kZAoeDc0mnPW8bmdKHlRLOfRDxg3JchGMpHJYhFfXtaEeQ9g5Bz2UP0PfhrHMK8M1po5+O1eWmPZO3AO8DYjCZtW+DCuGoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10935
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

Hi Jonas,

On 4/9/25 1:56 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-04-09 11:28, Quentin Schulz wrote:
>> Hi Jonas, Simon,
>>
>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>> From: Simon Glass <sjg@chromium.org>
>>>
>>> Declare arch and compression at the top of the file to avoid needing
>>> ifdefs in every usage.
>>>
>>> Add a few comments to help with the remaining #ifdefs.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> Changes in v4:
>>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>>> ---
>>>    arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
>>>    1 file changed, 22 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>> index e9ed1d4b5738..2b01dc660562 100644
>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>> @@ -5,6 +5,20 @@
>>>    
>>>    #include <config.h>
>>>    
>>> +#ifdef CONFIG_ARM64
>>> +#define ARCH	"arm64"
>>> +#else
>>> +#define ARCH	"arm"
>>> +#endif
>>> +
>>
>> I would refrain from using ARCH here as it's something we already use to
>> specify the architecture to build (e.g. make ARCH=arm64 CROSS_COMPILE=...).
>>

Actually you don't need (or even shouldn't?) provide ARCH to the make 
command, got confused because I'm compiling the kernel right now :)

>> Maybe FIT_ARCH?
> 
> sunxi-u-boot.dtsi is also using ARCH so I figured it was also safe here,
> we can change to FIT_ARCH for a v5.
> 

Indeed. I would prefer something not clashing with other 
environment/make variables :)

[...]

>>> @@ -84,7 +84,7 @@
>>>    					fit,operation = "split-elf";
>>>    					description = "ARM Trusted Firmware";
>>>    					type = "firmware";
>>> -					arch = "arm64";
>>> +					arch = ARCH;
>>>    					os = "arm-trusted-firmware";
>>>    					compression = "none";
>>>    					fit,load;
>>> @@ -103,7 +103,7 @@
>>>    					fit,operation = "split-elf";
>>>    					description = "TEE";
>>>    					type = "tee";
>>> -					arch = "arm64";
>>> +					arch = ARCH;
>>>    					os = "tee";
>>>    					compression = "none";
>>>    					fit,load;
>>> @@ -119,11 +119,11 @@
>>>    					};
>>>    #endif
>>>    				};
>>> -#else
>>> +#else /* !CONFIG_ARM64 */
>>>    				op-tee {
>>>    					description = "OP-TEE";
>>>    					type = "tee";
>>> -					arch = "arm";
>>> +					arch = ARCH;
>>>    					os = "tee";
>>>    					compression = "none";
>>>    					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
>>
>> Wondering if we couldn't put some of the Aarch32 and Aarch64 OP-TEE OS
>> node(s) in common?
> 
> Sounds like a good idea to maybe put op-tee in a template, personally I
> never use op-tee so typically try to minimize any change/impact related
> to op-tee.
> 
> The RK3506 does use op-tee so I may need to dig more into the op-tee
> parts in a future RK3506 enablement series, initially [1] was enough.
> Could look more into using a op-tee template in such future series.
> 
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/3d683f3b717de010fffeece8712373892a599905
> 

Interesting, is it required for RK3506? Do they do things in secure 
world and since it's Aarch32, no TF-A loaded by U-Boot?

You can play with OP-TEE on RK3588 from master, c.f. 
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-rockchip/platform_rk3588.c

I haven't even built it but there's been some work on it since it was 
merged early December last year, so possibly people are using it.

Cheers,
Quentin
