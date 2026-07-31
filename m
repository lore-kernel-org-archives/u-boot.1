Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A56C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 07:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72DAA40F2E;
	Fri, 31 Jul 2026 07:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id npynLPN_QiEa; Fri, 31 Jul 2026 07:53:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87E0B40F31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785484413;
	bh=OH9dZc+l9gJu4+3VjRMKxNudo8aJtGOIKI85+kCNUd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yS3AGpBayJDj+534fRfbw/6v0xBeJEG1VNCYaiD0porjZsBNPnVoshGBqcAhXe7OP
	 ffcsKV5WiEBwePhhWQ/XIGHNDnELrttvO4khm8Nv8BNePMjQpS0qBXPL91j/EUVyhS
	 pnRIa0JambLskGmaPWG0BNNePxoQd36qoIESolp6dTEVx1+ui6Yt4pLqGqw3gKfeIr
	 mfu3DdADJ43c0UciA4ipVeh2aszrLtYL6p1XfqxbGr3ZN7APltmPkKjg8tn8gdol8K
	 i7vBPEV0sQufzICNIQ58Nbzf1YV3EZqqs9ilVB7GBTdg/wRtk9I6fyvYo80UlJWauf
	 JFIWx3keKzFtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87E0B40F31;
	Fri, 31 Jul 2026 07:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF3782CE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C435A80B80
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LX1SjY_r1vE3 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 07:53:31 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 04C8F80F88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04C8F80F88
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04C8F80F88
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN6M9wm4yEuTe4OzsBcRCuou1QJQExGgKSE56GWkDhnP0kBv4ts19ITWU3xO/tbAu2X+xmFO4PWTJOTGQ+gf1c+zaIJCF8dh9WocVdDcmS6oRp6wG+WdLUaTy7QcvCA1QnUNgvrO/tDcKkdTDc6QeBnhXYdMID9m2fbGq9js9BQD0bNsW9qf3hV2uurJfEhP3ntNRIIAIzXr0St2dHKkQNZnMHNuf7+mz0AeQ4Jl1+frOYj1aA+8tAqOLzIqee78OODMNs/yaWzqS6ly0PIKsYDqhHHmi+cdkwmj/BzWaJEQK1fNeAK7qU07MuH/qoSlhBTbT5vVzhshDrBB/ihY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH9dZc+l9gJu4+3VjRMKxNudo8aJtGOIKI85+kCNUd8=;
 b=KO4vXy8XtMCj6tBo8cVmsSWx3VK1HDhYRAak6fbNMhpvCOJSI4GJehhtRAkYrWs1/GCE7UxczJLBrDA9v0BStV7hdCi8bro1m7hEuCPZVTwD3xx5fjUf4PJq1wY7oHjl040zkKdzEGYX0E/yrAh8LpocbLjKg/WTa/icMLEdtEJnKK+uzfbMb4KpRncVqbEryH/yYfcU3BX0VwRfjMPnxKQNhyNwWWx89HfDE8h/NF4tuAIJwFGzj/NG1R7PDSqfPGjrvZRmR/V2VUuqEPKBqR3LgqzFYGq4+WZg21IHAoEcmQ94PFkRStotEKeUhKhz0vz8QDfcgAMrpXADVW725g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB11954.eurprd04.prod.outlook.com (2603:10a6:800:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:53:25 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 07:53:22 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 31 Jul 2026 15:56:49 +0800
Subject: [PATCH v1 1/4] imx93: clock: add 900MHz entry to fractional PLL
 rate table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-93w1-v1-1-62d8459143e1@nxp.com>
References: <20260731-93w1-v1-0-62d8459143e1@nxp.com>
In-Reply-To: <20260731-93w1-v1-0-62d8459143e1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB11954:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb9bc0b-ec0e-4c5c-160f-08deeed8cb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wdUtC/OZGSyu+rwQq3plX6KRLQ7Yb28TneDsaSOj57wFnk73r6D1jIs78pi0E8cYLb+zJ3ANnyY6k+tmKtrI2ZsfCEO9e8yINouGg2Zm51QGXTDXMEkZrYigW9xVeSG2jrRyflPSLlCj6925DcVoO8geibD7rF7P9ujrrFtx9FUNWihtiPc0Sp64MGKgzcWl9+e/jSkp94fdxgtc+J/Ot2OegXe6Vl4MJnMQ/7KKCnRVBSXbBt0VTodBs37DDPL8oRbVEKJhdxSNzKY7p/9SKcWpMO/rrPn5OkDXSu4mRH1LHz4lXxm+Ld8DcvnHl3504eld07Uh4jZnTGMw7EPJ+qAEpPh/sOa6wyPb5UdTASIp7vRRUtk3KgtPTCc3CdUNPQ0dAiEulPJdQJ0O4HlU1ERv/SyXEuizw+Ze7YfIBvY69lE6k0GPM5bvx/G2rr1xfE4L7rfytkSK4oquaFlaXyYpjpK0JOnI0hF24C4O8a7yR0XCj6Zv/W6vRNbrMkD/KmHAoebMOS6kKN5EIbVJOKvSrCFwQ90BH+cXH+NiBac71yGHcBZgXpsrMRC8DRda/0KT771z+nU5OfBasmsGbx+W9HMjSbTLCSh+I0kzhMzbNB6dBRbHTTRxAMzwROFnwb+o9vkiBT4Xbgsac+O3jDFVhxMrYKkfFv915V/SP2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW1LcHNMMHNaRGpsTWtwT1FjaDhFTnJ3T25VbXJ6OFRUZE1HV29EczE4SzZx?=
 =?utf-8?B?YVM1ektxTmh1VjdLQlQ2bjB5cFdxQWFSMUxkVm9RQVV6NlNjeFRLZHB4eCti?=
 =?utf-8?B?SGFmL3NycVJOaXdpYjhwZ1FidFhVR0tWUWtQYk0zc3EzdW9VY2lSV2pzMHRV?=
 =?utf-8?B?a0N5VlJtK1FvOG12Q2xjVExEUk1SbUQxUXlka2MxTk5zTHhpZmlsVDZqd0JH?=
 =?utf-8?B?RWp5dzlkWHBvYU5VdEl4RlMrMTBPOHlTQjJERmw2SUE5SHBPck1pL1lEM1JT?=
 =?utf-8?B?MXpjUlJxRGFCeDE3SWdTRUZaSG1HSFgrWnFNMFl2UTNwdzg2MnBKOXczOTdL?=
 =?utf-8?B?WjVLc09GajZJNjJURXU0L2c5d3A2L2pRLzd4c0dMa0pxZGI5MDRZQ1NrWHNu?=
 =?utf-8?B?bVVQV1lCU0FqMjlrZkZ3SlFZcklzbUlMTHNxN0ZCS1lLcmEzUzh1VFBCUkEw?=
 =?utf-8?B?VjNDRWNvMUhjQXhvQS9iMmNBUk1YeWZPNzIzVEU2bEVPMHJ6bWQwNmRBQmNL?=
 =?utf-8?B?YW5wb00vamVyQTRyMzdLb05paUFvOHFLc3o0b2FFWldEaUdIenZ6czNFWHJj?=
 =?utf-8?B?N0pxZlJvQkF6ZFZjTXBsc3YycWUrTm9MODV2bkNkZWJwZW02ZWpLbjN4RUUx?=
 =?utf-8?B?VFJnTGlURlRSdHI2NGVjMEdsbVdBMU04a2ptd0hDSnF6a1hkb3JzRWNBZDVR?=
 =?utf-8?B?VjFCMTdYSFd5WjlzbzBEaVA1MDhZcEpReUgzanNPbnI2WDYrcFdvRzZGNFFq?=
 =?utf-8?B?eEdONXE5S0hvcStDU0JzRWZjMXBCRFVVeVFLdUo3S2tGV3FFVDFkaWNkMUZT?=
 =?utf-8?B?eDY4bFM3ZTh6QmRzSVZTYVJWWm9ESWVvZzFXZnhIdW16NkUyZTdGVVJMSUpZ?=
 =?utf-8?B?WXlraDliZmMrUFRiWU9pWkpseWRvTWlheGowS3o4UUlZWFFNRjNNTlRZK3VJ?=
 =?utf-8?B?UnVEYS9SZU9LdXBOUXNtRHNFVzF5U29nQ2dwQS80aUc2VVBMVVRSR0NhQk9x?=
 =?utf-8?B?SnNrMnlvNnd6clhmampEUVRNM3EzNHpqQ3hjMXlQTGtPVDJ5WHB1bWNWUmtI?=
 =?utf-8?B?RFk4bGlGdkFBYWhVN2ZBWGE5eU1kSWo4U3VDeGxqcWhFb1ZieEpnTk4yRTRX?=
 =?utf-8?B?SXY2WU0xTWo0Ri8yaEhzUHp4MUFJanM4cTRVV0w5dDJFd2szQWMwQnkrY0pm?=
 =?utf-8?B?akxNSytLMTljVlBQY29oQmhOemlKajh3L01FQmZsQ3VQUi9TakNDRFluaXJt?=
 =?utf-8?B?V25nNTBHMS96VzBEd29aM0xOS0RnWHdHTk5wSmkwU1NieHErOFZJdGZOQUlk?=
 =?utf-8?B?NVdaNllrOGh1VmZtbXEwazcwZEl5dytGT2plWWRhNnlZV01XTW5zckhEZWc3?=
 =?utf-8?B?aEFKQVo0am1KbUFQVG93VDU3dWw3QjhHS2ZlbThmbm5rSkcxYnBuNHprbkpS?=
 =?utf-8?B?cmt6b2NGeWNoNnFxRWNCSXRCTTFSM3p1NzBoNm5vdnlZTktoMVZxM3Z0cEJo?=
 =?utf-8?B?M0VQTDVBMjdRUE5SSEgxYmxGbDZuOUVBK0QyelJwaWtTT0M0Sy9CdlcwWDBs?=
 =?utf-8?B?Ri9zUFNLVkdibDJtT2ZYVEVGRmRoUUd2R2R3cUtZQjZTU2x3ODBPd2k0cWRx?=
 =?utf-8?B?bmV3amZ0cUxIS3dmejI1RWZRRVI3RlE3VFM2dXlHMlg1U1dXUFRDMkphcTJ0?=
 =?utf-8?B?dGxBdm84Z1M4aS9kZDF1RGNkN0FjVldoQk9hb3J6c3l2dUEzOEQxd01kZmRv?=
 =?utf-8?B?cWNiWHl4WSs4azg0TVR3MTdvcUJ1eXA4UFRYYWVTUi9TSnBsWUg3TXYycEN6?=
 =?utf-8?B?elI3MTIvb3Vmdm83QmN2ZzhqWU1HcmxNRG4rbXRic0htd2diZDBBeEhDYzJy?=
 =?utf-8?B?bUlSVVMydU9tQXM2VUlRTmErZzBvUW1sUVFFUVpsVWtrU2lNSm5OR2txSlBB?=
 =?utf-8?B?VmJOQTdTREVJeHFtM3FTdHRtWGVFcytnQXVmNFplZjJ1YnJqNEJkbWtJY1l5?=
 =?utf-8?B?b1BJVk5hTWpYdVNlVzhJSkpGY1M1RWpzbVU5VGZXanpNVnU0ckZFeXU0VmZK?=
 =?utf-8?B?ZFNIVUZtOEkwdHhSR1ZjNEd6b2VrQzRtV1F2QTU5RlpnSFl1ZTBjOHBnVW9s?=
 =?utf-8?B?MG5XTFFkVlhld0RZZE05NElIUWRxMWEydUNUY0t2MzVoV2RWeUh5UVZKSEMz?=
 =?utf-8?B?bzJrenJNVFoxOUtMV09Ick5LRVhJYk45Nm9LSTA3RHRlakhTUk1iTGNSb2JG?=
 =?utf-8?B?b1loME9NTllreThKbER0M3ZJOTV3WHhSV1dqTitEWWIvci9uVFZ3bVRXVkg2?=
 =?utf-8?B?c1ZDeWlOSFdFZnBKUlg5cTBtc2VKT0d3VDNud1dLM3lqUGpOd0RrTmczS0pC?=
 =?utf-8?Q?uN7OPrkdRJNci3QZAR25ah4f4z6y4vppt+QWN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb9bc0b-ec0e-4c5c-160f-08deeed8cb4a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:53:22.7246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OLnd2gfi5WS/hrexExP/VHzveUp+bNjbUYXPbiWwpG6hFoDBHDFdxaMHlw55uLyeTt16KofUix5ZmkaDDaITiacIPPekh7crAq6/kdDjrFyoPvr7pLX4FZwvWsJKCxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11954
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH9dZc+l9gJu4+3VjRMKxNudo8aJtGOIKI85+kCNUd8=;
 b=XDp/om2z6zfzBleLKbbbiC5VooXV7x4YnBvUb5oFnR4UDmLq3ITH3utw8VI4jju+krhKw4brCJ2Fh1mr4SmPGK3ZCUoslc+QsA71UpspbbPsirBz3ArI+jS3mghlwfGvxsJKBmxgKoK7jzZjxbsbHrZv9rCQ148OnbKwAApGV12jyPn+cXBMTUCPNg6UwUcm6M4k0bhXlyqV6fvTCRJMsAYIjYAJNWYu6qG3syOrFqxXjf+etKRw3E91A5q8ZnixsfH39J6vtecSoLP98wpyzoowr+LbsOiduKUqW3pkMzLc5hjBg1bcW1XJC8dYENVCiWNIMSLvnvoFcUpnUWt11w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=XDp/om2z
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
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

From: Alice Guo <alice.guo@nxp.com>

Add a 900MHz rate entry to the fractional PLL table so that the required
clock frequency can be configured to support DDR at 3600MTS.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 4ccff67b7ab..4b89ee3b2b4 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -33,6 +33,7 @@ static struct imx_intpll_rate_table imx9_intpll_tbl[] = {
 static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(1000000000U, 1, 166, 4, 2, 3), /* 1000Mhz */
 	FRAC_PLL_RATE(933000000U, 1, 155, 4, 1, 2), /* 933Mhz */
+	FRAC_PLL_RATE(900000000U, 1, 150, 4, 0, 1), /* 900Mhz */
 	FRAC_PLL_RATE(800000000U, 1, 200, 6, 0, 1), /* 800Mhz */
 	FRAC_PLL_RATE(700000000U, 1, 145, 5, 5, 6), /* 700Mhz */
 	FRAC_PLL_RATE(600000000U, 1, 200, 8, 0, 1), /* 600Mhz */

-- 
2.34.1

