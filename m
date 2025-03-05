Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87860C282EC
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C52981273;
	Wed,  5 Mar 2025 14:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SI/cMdB6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F66812D9; Wed,  5 Mar 2025 14:29:45 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B851807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKtTkTUKlQw4iJQ8jUbMCi/5XhzI1HmxXDbmG183+XK3Vghh0m8XEdcCLV0+/zazJUPnMAjZ/9bDVBDxsYzomnuCIy1o6ErUWpzG9ChgzWeQvUmDLidy06NZ7LRthKFRN/RdXEG5Jzlj6TSJoroINtcLxMfS02CceJIjm6rjAT/sK33GOqxGE98pnOMJSDLttb7I2QEobQPKoqZil62LJgbeQ5ZfHSU0tGBFRDZVEr8Y7uqWO91thcx6i8ovE15En1ybXPp2Fz3wnKqHLUcc3kZCUcjtttG7++ygxth/oB71N15qQ3baUpdbEwl3Vb/LOK4QBvHHVflEtZEL7ajeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnXDWRLGcOmOopdsFkKHPfX9D/0atVWca6wd6Yzcels=;
 b=MNR14yzwYr7bczv5JhiF2NraoqyUCGetaUPSzc1fwdbZ0heRWn4Vg6fxKkDtlEpOw882x9LrcDUCbJZ3n5Tj9ipUCahbhH/f+kefxYqVlD37t0bTheugbJHkY+OXN2hR9VmAaxURI+7bZywgVFczThcxzM6tcGJbCKtYhH9pit0MGZYn4ldKwfVhoIUEl1RifsfzeqAUZD5g3Lkpc9UCRzPgEIK2jVFGSbcXH+PtJrPtSH02WUFI7exy9HZvYkJOOCUNbfh1qPSI72K5/YelEXFw417i8PKN1x4YFM54vACIevuwHGBSftqeVc4l3fNxxMxD+5z3+NS1K84L2x888Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnXDWRLGcOmOopdsFkKHPfX9D/0atVWca6wd6Yzcels=;
 b=SI/cMdB64vi0lN7sB8VbtAVNXmDC76tvs3jJjM2/RZNdSvGVbQav3amiHywiR9YUDVx1VB+i4h+A5VawzTL+q7Ur64Mg714A9TrVYIt9PLyNMZ+IHdTUnHZDxc+XHjfz0xnUaPCiJiQKYx1H/b86V1ZQFsMKrSBP4p4m8s7GhoswjdVT/k2V8caqMg8lpZKDGUiSF4us3O3pSpfzLSB/UIuiDqT93p0itBq271ZdADaAsHkx74TprzytdWelAv0ug1v4owHIH0abyQmJ7Zp0+tYPTIfSGwE6WiUFDbalg8WUQjxLDX6YO2rSKEqQUlWPo3CLV22S5P0gBHUo3VFkkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:29:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:41 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:23 +0800
Subject: [PATCH v7 11/19] spl: imx: use trampoline buffer to load images to
 secure region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-11-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 267c41ae-e6bb-4efc-2606-08dd5be9c918
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmtPSzRZUU5CS042KzNJTlA4YS9pK0IwVnJkbmtTMlVYS1JTOTNqVk4xdUc5?=
 =?utf-8?B?N3UzZ0FmSVZpRWFTV0RQMkVuUkVZNHl1RTZNc1I1K3NnWFBSQXQ4eGFTSjd2?=
 =?utf-8?B?SlZMM3luTUlZelVjK25QcmVmWU9kTTEzUXY2dDFvWnpwT3ZQaDQ3MEVWQzNI?=
 =?utf-8?B?ZUNidTltSm1MMjJaRzZTckx6blZlYXE3c0kwazZLbmtWSmpPbnZHeFEzTWdI?=
 =?utf-8?B?UkZPMmMycm43SHhEQVhaRlB2QndKcjFXTU1yT28yejVjSWR4dktLZDE3YVd6?=
 =?utf-8?B?ZlJ1bVB3TnNJaE9xN3YyUk9HbFpDZElKWlBpdlVGRExuc1YrR25CbU1YSmJG?=
 =?utf-8?B?ZVpQUEYrOXlMcEpudFFrekQybTlFSWZSQzA3UDhjdWg5dlZTTjRoVmpiKzZa?=
 =?utf-8?B?S3JOZUV4N2NYZjQ1MjRER0ovblo1a3oxUDNhQW4xNnVWbitGcXhkMHhMdWJY?=
 =?utf-8?B?R1p6VGYxb0N3NkZZQnhMY01INU04V2U4dHQyemtacnU4NXE5SGpaakt0Wmk5?=
 =?utf-8?B?Yy92NkhvNG9WeDR1Z1YwTUw1ZkJnbytJWnBpY3lsa1ZtK3dwYmlJaWhrVTZs?=
 =?utf-8?B?M1BmM1dWUXRjSXpKR0ZCeWZzNW5meWRQa3NYWC9LN1FsNjhpb2tPWW9TZXkz?=
 =?utf-8?B?emVnbVVVUGpieU94MmtVOFRiWEQyV3VMRzhsVEhHN2RzYURTNzhFRmZYWHll?=
 =?utf-8?B?MEJ4dnRobmZQUlRWVkJjQTNXSDFsODZNQTd4eTl1VGllc0JlUVExbXk4ZnVZ?=
 =?utf-8?B?UFJ0TXlpUDJhOUE0cDNRL2duVFZReHhBZlBud2UxcHBnTmNCVkxIZHFZclRM?=
 =?utf-8?B?bVl0YjZPekpzeWlJaDArTW1YcmtITE0vQytYd2hMVWltblJJa3FxemJoZ3hh?=
 =?utf-8?B?VHpSZkdDNW55ZDVGVDlsd3FtRXZjMkppeVRNVnRpVE5sTlJscVQwYVkremxC?=
 =?utf-8?B?MmROS1FDOFNpS1pRbUZkTVZOR1E3SFJsR3VwRGdHM0t5a3BtcW9CWWwxdUdp?=
 =?utf-8?B?c2xmSDdyVU9HeTN0K1hTRnA4UHkzbnlaaGxuQjIrSWEwbXNraWNuOXhVWTZS?=
 =?utf-8?B?dnhXdDJKdjZ6cHNRd0d0aE5VQ2NGMFVHc3lNWkFnMjN1RkFCa29lci9IWDFo?=
 =?utf-8?B?M1h4ZllEaHNCeEZGdVhhZ1lGVkgzNkhCVFpnc1RjZEg4bmQxM1EzT3pOVWNU?=
 =?utf-8?B?U1g0WnpBay84YjBIVmNKTDAyN0xzYlpUZmtsUXZ6VCt3S0ZyQ09DUTVsY2Mx?=
 =?utf-8?B?RnljQ0dwNml1RFVHT1FJSUY0WjVNcTdQc1FXRXZ1MFZmSk9HL1dMc3ZXSy9P?=
 =?utf-8?B?SHB5K05jM0NNenFNMXJyeGFZVW43akQ4WGhpN2RGcEhVODU4YmpWV2NObkNY?=
 =?utf-8?B?aXZvcGdQc2I0VUNIczZtdEZob2t4S3VlT3ZSQmtvZ1gzdGdHVmFrZ24vb3RT?=
 =?utf-8?B?OE8vT2toRWFDdWFuRDlkZU16VnBTdDlTTWZGMnJYdjRsRW0welIvNjRCbEhB?=
 =?utf-8?B?Wlc2RzZuUktXRnFnVDNKQkRTY3Q4RW9kNnZpOW8xN1RxVzJFYmhQR3Q4VEVW?=
 =?utf-8?B?VlJObTZYR0FSUzBOOWc1MXpuUWcydWp5eTJpZWZ1WnNOMnorTFM1VFU2ay93?=
 =?utf-8?B?MWZGQldxK28vcVViQVNnQ05JbThFclVsZUhqL1ZUY2NUUngvMkFGZ09saThC?=
 =?utf-8?B?d25MZktidC9hTit1dVI1RGJYZGd5eDMxUDhEYU1WUDlTSFB2Um14ajhZbjlC?=
 =?utf-8?B?d3pJaWcwZnpDdVk4L3JBNlgrdDRLYUZMWE1jemFPMlg3ZEVxbVJxbE0xTHJV?=
 =?utf-8?B?Z0g0RGUvUzNmYWhvRmN2WXZJTCtGY0g1VEdXNVo2SkI5enB2bHgxam1LNUdX?=
 =?utf-8?B?ZnBFZ0xrN2N4WmVXUXBBYWpVdkppVFIwYlp5dUNnL1dqeERjOVVQWTJrQ1Zl?=
 =?utf-8?B?a3dXN29xa0FMNEZnKzB0dXA5a0ZKYkZ0ckI2dldueGJ5RVlJcVFOeWIzREY2?=
 =?utf-8?B?RlByUDBYbm9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk9ubWNScTEyOW9VSjVoajFTWk9ZZkthRkpaTjd1dEV1TytPNGNGVkhJZUpL?=
 =?utf-8?B?dFVQTDd0OGxGaFZzRUNOa0gySXdFaDcwOUlzMHpySDBLa0hsMUdKSFBhSGJ1?=
 =?utf-8?B?UDFpM2Q4OEFyV1FxZVNSdE5rN2wxMHM3NldBOE5wazJYb2U0L3JjUkR5cE1Q?=
 =?utf-8?B?VUtwblBQOU5Sc1lleDlCczZqM3VwZGRiNTRnaUJ2QnNRcmhSbkw5T1ZidnNP?=
 =?utf-8?B?MzdGZTVpYW5XYm8rWExaWFpWSjFSK3l0Y0NyVmtyU2d5ZEZwYWhLRVBYUWFh?=
 =?utf-8?B?UWc0dlBpYlZzckd3cUg5MzdOS2w1MEtVckQwS1o5OFdTSFhYWFZwSjU0RDBx?=
 =?utf-8?B?UUQrRnlHQUFvUklLV0VKbndWOUptTHBKVDBsVUJYVjFPNHVleUVpQmpRY2Ez?=
 =?utf-8?B?RDI1RjQxaVlBMkg5TWc4azQ5UEQ3YXRzMkpEQis1WnoxdHpoMTBFTDI1dGZ1?=
 =?utf-8?B?Vm1FRUxIU0FMVTdyY0RIcit4TGg2aXY4MEJrSVV4aXo2NU92K1hrVU1MYzA4?=
 =?utf-8?B?ajNLTEl0NWVlSmlwbkJaNEtxNDBLVmthcUxFSWtJRWNlYmRIUVRpODB4R0Ny?=
 =?utf-8?B?R3pCRHg1NVlDdVFkcmgrZzhReldOWDBkLzloclMxUU9NUEdUUkF4ei9VSGwy?=
 =?utf-8?B?WitsTFlOVy9KOS9Hdm1KYlBUSnBOQWtPVDYxZjc5NC9TKzlqYUc0Zk9yYUpu?=
 =?utf-8?B?ZzdaK0JyY2ZGMit4TTdCeUZUVU1ScklxbUVTaGlkTlVLelpITXpGM21tVUF6?=
 =?utf-8?B?dGN3VjVRUGUwRURtTmJicFY4SW00YnZPY1oyVkJZc01jZHQxbU1mOFp3dzhl?=
 =?utf-8?B?Z2VOSW5FckhidXdSajhZZGd5STY4MGRsY3Mwb2R3NFBUMWtVT09RNDZoeHYz?=
 =?utf-8?B?d0pFVEFFWEdybFd1eFY2WTh2Ym8yN0liY0pQcHc1U2RVSTlpYkhKU1BCM2Mx?=
 =?utf-8?B?ZXI2WXN1M0tyWXZEVCtjb1pOUm9yeVJDdXJuUXhLY0RrcUJGcWJrcFJtM0wy?=
 =?utf-8?B?WVpGcGk3Y1REWjVYMGN3UkJkcEVWV2l5d0txOU5FcUN1MmdDeFcxMVYwOHNi?=
 =?utf-8?B?Z21BVm51TU9DRUg2Sk5QZ09mN1BGTkEzclNKWnhFVDFWNmxpSDRrNkpkYXpj?=
 =?utf-8?B?Q1N1c09BL0pCSGQvUVpUSGdBOGt3bVd2dTREUS9SL2pHK1BRY3M0SUU1VGwx?=
 =?utf-8?B?TGlZZHEvWkVYcm5GS2YvaXArZmh6THU5T0tqMHYxZFo2NjIwNm9peENxUUZm?=
 =?utf-8?B?RDJVdWxuMldkY280RTcwMHNCN1VtMVViRFFFSGozQVk0SjBldTdGUFpZdFhw?=
 =?utf-8?B?SEtDeWFja2xhaThManovMUZyUmFOYVF2UU9yZmZOc3FaL3B6Z3JneEF4Z0R6?=
 =?utf-8?B?bjlkWjNJUko2OTgxYWs4QWdYei9PODdESXl4cDVZd1htQzJITGIyQno1SEQz?=
 =?utf-8?B?TnFsMlJGU1Mza1dMN0hMK2VaWWdQbGJjVU8xWmxxTXQrSUwyWkpsRW0xcWo3?=
 =?utf-8?B?VnBHTnVYalk4c1pXU2FBM0Y2ZkdxQVJNTTVSL3U1VGFHa1ZkcU9ISXZzRTdy?=
 =?utf-8?B?alh2ek50K2dYWkZYYXc0a2J5KzdacWgvWXl0NzRFTi9QbVkzVThxZW9wMS93?=
 =?utf-8?B?dzNmdEYrWjNjYmNxZ2piaTlIVkZPQk1LNmptUjVlVU05R2RPd2FyZS90cHdn?=
 =?utf-8?B?RGRPT250STVwcjBHMFNrUnEwbHJnZTZpTG9YQmZPRzRwTm9tRGs0VUdQTXJY?=
 =?utf-8?B?T0VCcFVQT1ZwalkzeURqY2ZOSEVnYVc1NUpMcEFRMDdSNncrWndwa1BUazVp?=
 =?utf-8?B?WG9CZzJ5TG8vTEVGemZ6SXVxTy8rRFRjQWdRazRET1MycElUOWxuQTBKNXdT?=
 =?utf-8?B?RzZieWlqczc4aE1NaVhWVFZrWnJtT0ZMWjNVS3JFZ3hWclE5TGZmeng3VXVR?=
 =?utf-8?B?T3cvbGZ5TDVoNU9teW1CNWFLVCtyTGlvMUlQOVhxWlA4Y2VycXRpMVVvTUFW?=
 =?utf-8?B?S3Y2Q2RzMms3UDc3cUFIYUlyVms1Q1VCaW8remY0dHRMSkthcUlWZzl2ZGYz?=
 =?utf-8?B?ZnZNL2o1TjJySmNsZDRhY0dDS2s2V0lYbVdkQURoQ1hpelBBbnVwUzhuTDd5?=
 =?utf-8?Q?zmrGKy8WoDmFhpC6l8m466r+U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267c41ae-e6bb-4efc-2606-08dd5be9c918
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:41.8679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQC4zIY8xpY9ZD6G2iLbYUJ4z/P2olwJigd7NI1R/6piXbXdSMJ/NM6dGYNSUJKcecHj5lLZIwuNJ2+m8IbTAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037
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

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So use a trampoline buffer in non-secure region, then use CPU to copy the
image from trampoline buffer to destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 18 +++++++++++++++++
 common/spl/Kconfig                |  6 ++++++
 common/spl/spl_imx_container.c    | 41 +++++++++++++++++++++++++++++++++------
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 217e7ed41a..1bacf52657 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -786,3 +786,21 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
+		return true;
+
+	return false;
+}
+
+void *arch_get_container_trampoline(void)
+{
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 7d6780936d..29bc119bb2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -362,6 +362,12 @@ config SPL_LOAD_IMX_CONTAINER
 	  Support booting U-Boot from an i.MX8 container image. If you are not
 	  using i.MX8, say 'n'.
 
+config SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	bool
+	depends on SPL
+	help
+	  Enable SPL load reader to load data to a trampoline buffer.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 2c31777fcd..47fb2e65e3 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -14,6 +14,16 @@
 #include <asm/mach-imx/ahab.h>
 #endif
 
+__weak bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	return false;
+}
+
+__weak void *arch_get_container_trampoline(void)
+{
+	return NULL;
+}
+
 static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
@@ -22,6 +32,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 {
 	struct boot_img_t *images;
 	ulong offset, overhead, size;
+	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size,
-		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) <
-	    images[image_index].size) {
-		printf("%s wrong\n", __func__);
-		return NULL;
+
+	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
+	    arch_check_dst_in_secure(buf, size)) {
+		trampoline = arch_get_container_trampoline();
+		if (!trampoline) {
+			printf("%s: trampoline size is zero\n", __func__);
+			return NULL;
+		}
+
+		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
+
+		memcpy(buf, trampoline, images[image_index].size);
+	} else {
+		if (info->read(info, offset, size,
+			       map_sysmem(images[image_index].dst - overhead,
+					  images[image_index].size)) <
+		    images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
 	}
 
 #ifdef CONFIG_AHAB_BOOT

-- 
2.43.0

