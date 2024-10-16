Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F8DD206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C7B188DDC;
	Wed, 16 Oct 2024 09:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fxa8xGvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A75B88E9F; Wed, 16 Oct 2024 09:19:56 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06FBC88E6E
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWqIB/OSb4uQ0cQqEwUtYDFPUpUP7A+pX9b1hO4xqUPLZrXUTEfd0UPoDFMGw3xbxXJXwSrTbXajxduhUX5jaiSOeCj0TsFiKKQzR9/NMjjRPsT/tq32fVn8yiWBZ6yHopQFbxHlzbamqVJI4VOrSGEPDAXrzypfqu7ESXk1nhGio3R9B8WVA7HqCnq53R0/LyRLcAqyEhPybQQqbKi0Ybk+VCvi8SvnRS2rXTY1PXVfo6ti1XGTy5O/drUr5qDdRDjg1MxBB3OshNwvMLR3c4rqn4FK1jiQFsVuO23AaYUeJifrrVOFC8w6hb1+KUTOn7kgv8ylp3fGYUJPxIta9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpOVbuCSyvQxaJlOU3F/GX/F5hmNXT2F5OXXwGuCyns=;
 b=l0WBiuX93Hm5lBFQs+vn06LVCqYvc5U1XfbjvxmtmKedygiifbHMGs9HtX30g9TxsTSD2jd82fg0ChmCX4KKyL9PIISUSArZczR0nULDpYLxuJKVhYLULn1f1yaC1yWaPY9SKaVkz+m0hR8sjhutdsEoNw4uL2dbxhRgp0E5iOUkxHAvPU1cQsVApdmF2kHg4VQEqV3oBGMHzkpIhUb75XupadgyzkF+4eluU23BDIGoOfCB/BK4+7rVRgigZk7TanfPwghmWt4Id0LZZCTsxaOrui1YP1tgfr90q3iMo18c3vuqpiG2j0G9mKLOflIQMBVYb7IY2UnqDUHihbAwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpOVbuCSyvQxaJlOU3F/GX/F5hmNXT2F5OXXwGuCyns=;
 b=fxa8xGvn7SnYE6UcoXqEvA1U+gUN0Wj3urwqRa802XCUDijgSHmLY+ePrY8ZrzaSC0opT5GYDBufSnqKLrEWOxzkhrKTHNWW5tyYuim8eK6RcG/R74lraHWj3i1uGNCdoddqLdhkQFxpitrn6J86cacegLisChf6wgK7RNN3RaiqPgCLl7ajO3831pAcQPHw2+lAa7ESv/1jAdXnmgmtw4n3lrwyLrfvjDI236Cp60YW7NAOemt1UILNu43yrCi1PeIyLO7AYzpgF4eYBkgWYi+8LA9G4I7VkM+LLawRDFySrjsLnP6lbj6Gks6KkJ4NEr7EqIDDJC+TQ1zWL4O4YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:19:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:52 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:07 +0800
Subject: [PATCH 14/17] imx95_evk: add i.MX95 19x19 EVK board basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-14-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: c90ce312-6662-4240-a728-08dcedb2ed3d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REJuNWJVbHIwdldwZWdiNVBFT1llR0JHa0xaTzFOWUgxTXROcDBUb2tTUUVn?=
 =?utf-8?B?MjVRY2liZElENS9QTktpWjhPenV4dWJ6VE80UWZmeWdubE1oMUc4S1VkVExX?=
 =?utf-8?B?RzlNcXBJOGlHT2NmdFhZRmVqVDBVMVh1V1NNUTA1dWIrU3lDWFB0YXcyUnhm?=
 =?utf-8?B?UlNieXJkZWc0SkxzWkdQTWl3OEdnOCtpNHZoTDZwbUtKV0N3bElSMFdueWVq?=
 =?utf-8?B?cWNVQTk3UGhZOHcrZGxNdFNOUFF6RTNXNHJNREVzZU5LWG9XTVo1TE9tRGxa?=
 =?utf-8?B?anJXU1RFcDc5dGpnZUlGYW45NEE5ckFzL2Q1dmdyYXRKd2JDWlVhNUljRWVl?=
 =?utf-8?B?cmkyQ1BJRStoL25xZWFVb29KbWpSTjRnb1hXUjlxMUUrMUVhcjdGUmxDUFZY?=
 =?utf-8?B?RmV0M0VUNUhleG1laTRxZWtxNGN1ZVlQd3FpSURWU1JtTllIeGVUKzVIenF0?=
 =?utf-8?B?dHRUTWpHMmhEU2RENHE5a1JJcldtRTQxNUIvNjN6ZURHMXAwZGFFcGVBS1Bm?=
 =?utf-8?B?UWdVMVdCcjBIcXV0dkhOKzI0KzRncWR4TWFBVUhORUJtWjE3RUZsT25iWkh4?=
 =?utf-8?B?V2lUcTNGM2Z2M2M5bzdTM1RpeVNGaWdnTFdrV0lNQm1VSThOcmh5YlVEUUYw?=
 =?utf-8?B?enZnRWd6Ly9qdXJZNG9HNml4dmE5cm1URzR6N3U3VmlJZHJ3Q1MxRUNEekNF?=
 =?utf-8?B?VFkwZWFMcjhwZzhZaHIvWjBiRW1uYTN6WjB0TlVINjBSY25ZdjJGQ0VPSmJT?=
 =?utf-8?B?dFBZNVBKRUJTNnlXb01ZdnhXYVBEaUhiUDM1eG1COVIwSU1zUUxVZTArcHM0?=
 =?utf-8?B?OXpwNmM0QktEbWRiVEd1ektEckJMd040VnZFM3VZYUxpNjJDVTBmSmEvRnZy?=
 =?utf-8?B?MGZ4N2tYVzBjMnBpWE92Z2wyNDAvbEwydlJZdE9WV0NtemtIaFdwY1NpMk5U?=
 =?utf-8?B?cFhPbC9LRnNNbHBrQVZuVjNvcytEVTh1SlkxUlc2Tk1BeERVZHExL2RVc01s?=
 =?utf-8?B?VENqUStRVlY0WjdSNWd3WTBqUTV6UHpEUUFIajRPMkZpVVV5bldRU2N2SXNZ?=
 =?utf-8?B?ZFk3RzdEVGFSWU11TitvR01aTDJDZUJLMnZZZEExOW1xZ3hYRGY0a0JTL0dO?=
 =?utf-8?B?RmdHMkcrUlhwSGRDb1lHVzJFLy9MR0swd3BSL2FiYzRuTDFzRy9oaUJ6R1Rw?=
 =?utf-8?B?YnBmUDhLS2NGMjJwWm14R1BkMWtRSUxUMVdsSjRFa09Ed3laeFFHRUM2c2VE?=
 =?utf-8?B?TXYwaGRIRGdremxXbXY3WW44V2tTQnJ5MjYrYjRVdXJTVU1Za3NPVHo3dkNp?=
 =?utf-8?B?YWQ3WFh5VHhsa3JZM1prdjNLM2s1Q2RjK3BCOXk0clhUaFJ4WFR0eStTUWdE?=
 =?utf-8?B?TDFEQUovVlpNdGZhREg2bjkxY0pRZFVETjdFS3RvcCs0d3h4d3hDR0VDekd3?=
 =?utf-8?B?RHJpZmFZUlAvN0VNN2E0LzNTSU5nVzhCeTFZV25Ycjc5TkM3RGhkNTNzWFlx?=
 =?utf-8?B?V293Z01WSHZUbTZnRTJ6R2hpdTVEZGdZUU5HemdWaHltN3FpMTZ3QXpUZkxq?=
 =?utf-8?B?VkRKbTBJMEVKQXlMVC8vdDdhRmgzaEtubHh6QStUOTBLbC9Vd3JGcXgwc3B1?=
 =?utf-8?B?K21HVGFub0hoWG4vYnIyb3FFMU5nTE8vQjJGYzdUL3lTUitMT1NGK2RsYjUv?=
 =?utf-8?B?L0dPTldCZGRsTHBKZEVEU0VKcFlPeFhMa3pnTW9ySGVXMm0wQUt0Rm9hUzVq?=
 =?utf-8?B?MTdkOEhBNkZnYUR2KzZzaFFKSEk5bGJLSFdBM1dRYmFFUllmaEwvZ2g1L3M1?=
 =?utf-8?B?dUw4NlpoZ004ZXR3QnA2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JZbkEwSGZncldhSUNlS2xaV0t5MU1LUytmVlB3UHJ4b3hObjRydmVNMUJL?=
 =?utf-8?B?WGU5YWsrTlpaWWVvaHZLdlVQZ2VLaXRXUUlJeXZ4N0lhZlE3OEt4RXFOSGdX?=
 =?utf-8?B?QkhNZ3N5M0tnVHJpUitzODdRN2k4ckdZTGRzd1JLakJUZjVmbEMzMUpoS0lr?=
 =?utf-8?B?WUszZlBzZWNjT21qWFBEMWUzREJCSFhRNkFRVCtBY1psZWlreUh0MWd6c0NS?=
 =?utf-8?B?NUVhY2tZRWNHWnJLb3VqN0lkbXM5Zm1CbjVubldzN29DUWNmVVdVMGkrMXJt?=
 =?utf-8?B?MjlOZWJTRWF0QzNGUmNlVDg3RVJoMWM2eXJWeWtTZ3VvUGRyS2JNR2VqZExL?=
 =?utf-8?B?MGd0M2plUHFxWFIzdkdja2VtMm9CQlEzWW9CT3dzNzhBYWZidDdwcll0NExq?=
 =?utf-8?B?U05RRVBaLzNXaWQ5eUxUK05IcHhEN1NDOFVMUnJKKzFNZFVBaStOMnF6YTBW?=
 =?utf-8?B?NjlTVEUvSHNGWUE0WWtYeGJzeEJLbXU5MFFqOFlNUXUyN21ZbklQNTZpYnVK?=
 =?utf-8?B?eHlSaUFJNWNlZmI0cStRendQNE4vdmNETFE2MmlUZVV0eDZHWGtQSkwyeFRS?=
 =?utf-8?B?MGk2c1dHa0lqbUZGb0xmOEx0MGpaRDZzR3ZFT3VkSmJFZ2pGNVdtc1dvaFgz?=
 =?utf-8?B?TWlqSWlvb0sybStvTDFMeTlqNjhuQlNMQXhDSXROdkN5VC9xTkdjYWxMSWcv?=
 =?utf-8?B?L1NENlFPa0VjOFE5RklEYVdtWnlONFZvWGV4YnlBVXA3Mkg2R3JieW1mU0lZ?=
 =?utf-8?B?VG4xY1Mzdk1tVXYxc2dKai82NmJ2YkhEZFQ1Z2doay9lWjg0Y2pnak9Ebnoz?=
 =?utf-8?B?QzhycjA5WHNiUFRjVXpaTXRNWkg5V3NsdkNyVkp5VnNRWWMxUHd6UTBSQStY?=
 =?utf-8?B?MVZic1B2QlpIYmFmU0o3bURFVnhzTWw4b2c2NkhUTWd3OGhjbDJFTzZyNEt6?=
 =?utf-8?B?bS9TMkVEcVhtU3g1M3ljUTU2cjB0Z0pWdWpTdkhuSDBrUHQ2RXFoVStLR3J2?=
 =?utf-8?B?RThnQm9FMzRIRlQwZUMzS2RnekYyRFZmMHZRSEIzaWx1SVNQbFp5NUtxTjE2?=
 =?utf-8?B?TnUyL3NHMUJuT25pcjRBSUNJcnMvWU1aSGU3UEw1eUFKcjkxYVVSN09yS1J6?=
 =?utf-8?B?RXVDMm8vWTl2RFFiSDErNUwrUTNYZExlNWpNT0JYUFN6bzdubHBJNjdTMzlk?=
 =?utf-8?B?cTV1UnU2OXVzeHdFbEZHRVp4T3FJWWFxTTdNRmpBS3JOQ0ZxZkJrMnd2VXk5?=
 =?utf-8?B?UWpSTTRncWpkMU1ybk5ZWmZ5dk5welppNWNKbWd3anUwbVljdFlUdTJwVGpH?=
 =?utf-8?B?TEVRdWdwYzBWdmN2bjl4L3hTMlRqeXppQld3cE94ekNUeS9nZEZlQUs2MXdv?=
 =?utf-8?B?VkF0YkhGTmNTWG9Ed1NsQ0lTN3U5YkhneGF5NFJzaS90YTJvNXFneTJXL0Fi?=
 =?utf-8?B?SFhoWTg4eWtkbmJSWXRNNld3L0NSMXBvV0tBRkVybkRVRVlFdnowNVB5cnMw?=
 =?utf-8?B?ZGVrWnJwNkpucnovY2lyY1ZEbXBQZGJIWllxQ1NUMERjTGtqWno2UU9hTVhn?=
 =?utf-8?B?a3ZvRlBQUmMvZU1Vd2p0YWJhc3J5WEFCRjhxa0pxOCtBcUpuQkRmMmhKUTdN?=
 =?utf-8?B?NWdpRzdIWnd6TkN5VE5aRzN2MStYTFh4Z0dMWktTbXN4U3RZVjBiWWhCZDh5?=
 =?utf-8?B?dVRIWVBibFJhRXdwakQvR2Uwc1FrZ1dQY2tSQTd0bi84SE5TMm9aZ3diUE03?=
 =?utf-8?B?ZkxadzdHTkZHWDJrMUhCVkNoRnBtT0tMYXhOUi9QUHhjUzJLQnZBMWoyOGNo?=
 =?utf-8?B?cVhyN0RGUmpRcXRxUWVXMUlGdVJpVjczM3p4QXNjckRqTXI2WktlUEFHdnNS?=
 =?utf-8?B?WVZ3cEk2VU5ERUxxZnRVU01IdlRUUTUvcmVWUTdaTUJET3V4MVJTeFdjdHp2?=
 =?utf-8?B?YlFRSHQ2QW9SRG9WMEpRdm9JVmdPYUFrbEhBa1dJUS84QmJXNXlJakdpYU90?=
 =?utf-8?B?YW41NWI1RFN2eWI1S0E5N2lGRnF1bUlUZ3FpUE5OOXZZUjZUVjN2c1BSSzFI?=
 =?utf-8?B?cG8vRWlWTyt3aktCSGpFcmt1UUU2WVBYRWhrS2hnTithb3hVbkpOT2hNRW5W?=
 =?utf-8?Q?LwFpwpBzYO55x8nZdvcnCM/5O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90ce312-6662-4240-a728-08dcedb2ed3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:52.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGW6tlvgraDFB9ClOEeBcVfmB2sXdh5p1FpYWCbmmrkqIYrEq+3/RFQXAOkAEeLXZjvRIaSdr7qlwojozLTTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 19x19 EVK board basic support.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi | 172 ++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig           |   6 +
 board/freescale/imx95_evk/Kconfig        |  12 ++
 board/freescale/imx95_evk/Makefile       |  11 ++
 board/freescale/imx95_evk/imx95_evk.c    |  75 ++++++++++++
 board/freescale/imx95_evk/spl.c          | 119 +++++++++++++++++++
 configs/imx95_19x19_evk_defconfig        | 189 +++++++++++++++++++++++++++++++
 include/configs/imx95_evk.h              | 148 ++++++++++++++++++++++++
 8 files changed, 732 insertions(+)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..205f8ce5f9dd73421a6ded86c78d7c5f03adc5a6
--- /dev/null
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP
+ */
+
+&{/soc} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips2 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+};
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
+};
+
+&gpio2 {
+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&lpuart1 {
+	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
+	clock-names = "ipg", "per";
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&osc_24m {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&clk_ext1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&sram0 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&scmi_buf0 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&scmi_buf1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware} {
+	bootph-all;
+    bootph-pre-ram;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+    bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+        bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+    bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+    bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+    bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&elemu3 {
+	compatible = "fsl,imx93-mu-s4";
+	status = "okay";
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f594f998895b9578ea43e83ecb6579e1bce9c88e..934a802698f9552977ab84783e72b917553decb4 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -46,11 +46,17 @@ config TARGET_PHYCORE_IMX93
 	select IMX93
 	select IMX9_LPDDR4X
 
+config TARGET_IMX95_19X19_EVK
+	bool "imx95_19x19_evk"
+	select IMX95
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/freescale/imx93_evk/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
+source "board/freescale/imx95_evk/Kconfig"
 
 endif
 
diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_evk/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..f9a67353e5db6d3ec94784cf091e45d8817d541c
--- /dev/null
+++ b/board/freescale/imx95_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX95_19X19_EVK
+
+config SYS_BOARD
+	default "imx95_evk"
+
+config SYS_VENDOR
+	default "freescale"
+
+config SYS_CONFIG_NAME
+	default "imx95_evk"
+
+endif
diff --git a/board/freescale/imx95_evk/Makefile b/board/freescale/imx95_evk/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..d5cff91c961e0045514b44f508fa40650bc24116
--- /dev/null
+++ b/board/freescale/imx95_evk/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2023 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx95_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
new file mode 100644
index 0000000000000000000000000000000000000000..7a0617e3cb337ff1d2b6916b5f4889614a7e18c5
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_evk.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <env.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/arch-imx9/ccm_regs.h>
+#include <asm/arch/clock.h>
+#include <fdt_support.h>
+#include <usb.h>
+#include <dwc3-uboot.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <miiphy.h>
+#include <netdev.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+
+#ifdef CONFIG_SCMI_FIRMWARE
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_early_init_f(void)
+{
+	/* UART1: A55, UART2: M33, UART3: M7 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(NET)
+int board_phy_config(struct phy_device *phydev)
+{
+	if (phydev->drv->config)
+		phydev->drv->config(phydev);
+	return 0;
+}
+#endif
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+#ifdef CONFIG_ENV_IS_IN_MMC
+	board_late_mmc_env_init();
+#endif
+
+	return 0;
+}
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
+#endif
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
new file mode 100644
index 0000000000000000000000000000000000000000..1c8782b64641ce295ec2c1a4390f45b3b7fe0bc2
--- /dev/null
+++ b/board/freescale/imx95_evk/spl.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <command.h>
+#include <cpu_func.h>
+#include <clk.h>
+#include <hang.h>
+#include <image.h>
+#include <init.h>
+#include <log.h>
+#include <spl.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/syscounter.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/ccm_regs.h>
+#ifdef CONFIG_SCMI_FIRMWARE
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
+#endif
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	puts("Normal Boot\n");
+}
+
+extern int imx9_probe_mu(void);
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+	bool ddrmix_power = false;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		spl_save_restore_data();
+	}
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	printf("SOC: 0x%x\n", gd->arch.soc_rev);
+	printf("LC: 0x%x\n", gd->arch.lifecycle);
+
+	/* Will set ARM freq to max rate */
+	clock_init_late();
+
+	/* Check is DDR MIX is already powered up. */
+	u32 state = 0;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		printf("%s: %d\n", __func__, ret);
+
+	ret = scmi_pwd_state_get(dev, IMX95_PD_DDR, &state);
+	if (ret) {
+		printf("scmi_pwd_state_get Failed %d for DDRMIX\n", ret);
+	} else {
+		if (state == BIT(30)) {
+			panic("DDRMIX is powered OFF, Please initialize DDR with OEI \n");
+		} else {
+			printf("DDRMIX is powered UP \n");
+			ddrmix_power = true;
+		}
+	}
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..24ac94fb3a23ca7b367e44d0698dfd28ac327dc4
--- /dev/null
+++ b/configs/imx95_19x19_evk_defconfig
@@ -0,0 +1,189 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
+CONFIG_SPL=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run distro_bootcmd;run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_ARCH_MISC_INIT=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_GPIO=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_POWER=y
+CONFIG_SDP_LOADADDR=0x90400000
+
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_CRC32=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_IMX_RGPIO2P=y
+
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SPI=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SF_DEFAULT_BUS=0
+CONFIG_SF_DEFAULT_SPEED=40000000
+
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHY=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
+CONFIG_HUSH_PARSER=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_ADP5585_GPIO=y
+
+CONFIG_POWER_DOMAIN=y
+
+# SCMI options
+CONFIG_DM_MAILBOX=y
+CONFIG_SCMI_FIRMWARE=y
+CONFIG_SCMI_AGENT_SMCCC=n
+CONFIG_CLK_SCMI=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_SPL_CLK=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_SCMI_POWER_DOMAIN=y
+#
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_FIRMWARE=y
+#CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_IMX_MU_MBOX=y
+CONFIG_IMX_MU_MBOX=y
+
+#CONFIG_REMOTEPROC_SCMI_LMM=y
+#CONFIG_CMD_REMOTEPROC=y
+
+# CONFIG_RESET_SCMI=y
+# CONFIG_DM_REGULATOR_SCMI=y
+CONFIG_SPL_OF_TRANSLATE=y
+
+CONFIG_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCI_SCAN_SHOW=y
+CONFIG_CMD_PCI=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_PHYLIB=y
+CONFIG_PHYLIB_10G=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_FSL_ENETC=y
+
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_IMX8_ROMAPI=n
+CONFIG_CLK_CCF=y
+CONFIG_SPL_CLK_CCF=y
+
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+# CONFIG_BINMAN_FDT is not set
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
new file mode 100644
index 0000000000000000000000000000000000000000..caac8bffe08648c7eb044dbc2fbdbd8c50474ac1
--- /dev/null
+++ b/include/configs/imx95_evk.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __IMX95_EVK_H
+#define __IMX95_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_UBOOT_BASE	\
+	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+
+#ifdef CONFIG_AHAB_BOOT
+#define AHAB_ENV "sec_boot=yes\0"
+#else
+#define AHAB_ENV "sec_boot=no\0"
+#endif
+
+#define BOOTENV
+
+/* Initial environment variables */
+#define CFG_EXTRA_ENV_SETTINGS		\
+	BOOTENV \
+	AHAB_ENV \
+	"initrd_addr=0x93800000\0" \
+	"initrd_high=0xffffffffffffffff\0" \
+	"emmc_dev=0\0"\
+	"sd_dev=1\0" \
+	"prepare_mcore=setenv mcore_clk clk-imx95.mcore_booted;\0" \
+	"scriptaddr=0x93500000\0" \
+	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
+	"image=Image\0" \
+	"splashimage=0xA0000000\0" \
+	"console=ttyLP0,115200 earlycon\0" \
+	"fdt_addr_r=0x93000000\0"			\
+	"fdt_addr=0x93000000\0"			\
+	"fdt_high=0xffffffffffffffff\0"		\
+	"cntr_addr=0xA8000000\0"			\
+	"cntr_file=os_cntr_signed.bin\0" \
+	"boot_fit=no\0" \
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
+	"bootm_size=0x10000000\0" \
+	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcpart=1\0" \
+	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
+	"mmcautodetect=yes\0" \
+	"mmcargs=setenv bootargs ${mcore_clk} console=${console} root=${mmcroot}\0 " \
+	"loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
+	"bootscript=echo Running bootscript from mmc ...; " \
+		"source\0" \
+	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
+	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}\0" \
+	"loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}\0" \
+	"auth_os=auth_cntr ${cntr_addr}\0" \
+	"boot_os=booti ${loadaddr} - ${fdt_addr_r};\0" \
+	"mmcboot=echo Booting from mmc ...; " \
+		"run mmcargs; " \
+		"if test ${sec_boot} = yes; then " \
+			"if run auth_os; then " \
+				"run boot_os; " \
+			"else " \
+				"echo ERR: failed to authenticate; " \
+			"fi; " \
+		"else " \
+			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
+				"bootm ${loadaddr}; " \
+			"else " \
+				"if run loadfdt; then " \
+					"run boot_os; " \
+				"else " \
+					"echo WARN: Cannot load the DT; " \
+				"fi; " \
+			"fi;" \
+		"fi;\0" \
+	"netargs=setenv bootargs ${mcore_clk} console=${console} " \
+		"root=/dev/nfs " \
+		"ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
+	"netboot=echo Booting from net ...; " \
+		"run netargs;  " \
+		"if test ${ip_dyn} = yes; then " \
+			"setenv get_cmd dhcp; " \
+		"else " \
+			"setenv get_cmd tftp; " \
+		"fi; " \
+		"if test ${sec_boot} = yes; then " \
+			"${get_cmd} ${cntr_addr} ${cntr_file}; " \
+			"if run auth_os; then " \
+				"run boot_os; " \
+			"else " \
+				"echo ERR: failed to authenticate; " \
+			"fi; " \
+		"else " \
+			"${get_cmd} ${loadaddr} ${image}; " \
+			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
+				"bootm ${loadaddr}; " \
+			"else " \
+				"if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then " \
+					"run boot_os; " \
+				"else " \
+					"echo WARN: Cannot load the DT; " \
+				"fi; " \
+			"fi;" \
+		"fi;\0" \
+	"bsp_bootcmd=echo Running BSP bootcmd ...; " \
+		"mmc dev ${mmcdev}; if mmc rescan; then " \
+		   "if run loadbootscript; then " \
+			   "run bootscript; " \
+		   "else " \
+			   "if test ${sec_boot} = yes; then " \
+				   "if run loadcntr; then " \
+					   "run mmcboot; " \
+				   "else run netboot; " \
+				   "fi; " \
+			    "else " \
+				   "if run loadimage; then " \
+					   "run mmcboot; " \
+				   "else run netboot; " \
+				   "fi; " \
+				"fi; " \
+		   "fi; " \
+	   "fi;"
+
+/* Link Definitions */
+
+#define CFG_SYS_INIT_RAM_ADDR        0x90000000
+#define CFG_SYS_INIT_RAM_SIZE        0x200000
+
+#define CFG_SYS_SDRAM_BASE           0x90000000
+#define PHYS_SDRAM                      0x90000000
+/* Totally 16GB */
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB  - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE 		0x380000000 /* 14GB */
+
+#define CFG_SYS_FSL_USDHC_NUM	2
+
+/* Using ULP WDOG for reset */
+#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
+
+/* USB configs */
+#if defined(CONFIG_CMD_NET)
+#define PHY_ANEG_TIMEOUT 20000
+/* Number of Rx BD rings: 8 per ENETC instance */
+#endif
+
+#endif

-- 
2.34.1

