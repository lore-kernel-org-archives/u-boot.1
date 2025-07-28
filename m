Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CCCC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 02:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DE983106;
	Mon, 28 Jul 2025 04:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L86POk1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD9D82F14; Mon, 28 Jul 2025 04:14:39 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7DA83123
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL18zSEW9C0ba3aamS9wIW/7RcyHW8eZa2h1+0n64m1+m/8ns4heWbpgC+jwR0mHgFJWfEMiG6hUzpjCcwIVmbiaU6eeE85Gba2xfo9aaZ6ZUfSa20WwYkUdYBZMv30s2EHayGmltJAqwlYDqVAVDqJuNVQcJBncOHgB/WXUaQPXs4VAojXgP+F6dJSCl3rUuoKhWsI0jUVF/XyUogMHl3i6jRZr76xNR2irT/gVOpjIjb7rHIzA0rh5CS697zfs1U7jv4YmqLcFoO2JdFC3Hk/gFthhm8s4WSYOA5mc/3eSXb5e1Xn55riS5pX/lYyvcJsAmaKKkB1tiKe5fw2Tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woUG0e0TfjNvogMBZTxmq/cBcy+W7AiWvH1FyWBt9+w=;
 b=LKbtzUy6aAXwyeiLRBU8LCa4oJ+iYSP0pNuXnmvleOkBiMrCNuCjGH1ldAPkSwwsqMIR+FDypaOp224BUhDtoZuNbfp4A9juu6jpLI5BbzAnegvvcHzlW/cW8npld7R/oEpqBCiyRzsFBjOc7qZrRWYLiYWQ9lg21P8K/aS0EHzEmxZ4nLT3Pn38dIrIKWaH4eiUiGOLWbFiXRwV3gk0BevjNPJYjKA5dmgq8huH/ElRXr42pEGfx4vzxmmLh8wh6bNn5OFnByVH7XKdaBrJ70vhGn2AZRj2aAbWMdhtxePzypCjZzJsYgJsyj8IpNXjz2WDsU5qE8v9847YVOcaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woUG0e0TfjNvogMBZTxmq/cBcy+W7AiWvH1FyWBt9+w=;
 b=L86POk1s8FjSBVvw5pInr+pmuC3Ctfp1cwgmRZWrRvXIxhtlSawyodRCG6hjbpwPROM8IlbXhaaO3kFmTAZyPmBVXJp1IMI1geHk3MK0sCpsfazY7w4EDM+DAg3rrCeQQoxvBHnvDc2EtSV6oCPyHiQQHSfi/DEM82K9MUqiX9H/La4Y5rYe64u1lBgu8MhaLdAeHlO0mlakqyOeIKy1rBxiwMmQ7P4G4RRHX5RZog7TeGvCSObRH6nucFLcYVOHNsXlMKEX0VGAGsp8U4UClFeBxkNSzhbqS4KIsLutb5C02YtIlO20fzOwbr1tilTHbOIhLW6LavWqHwnAZHIINw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:14:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:14:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Jul 2025 11:24:51 +0800
Subject: [PATCH 5/9] ddr: imx8m: Drop the dependency to IMX8M_LPDDR4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ddr-imx-v1-5-73da75bb33d3@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cf6031-1cb2-46cc-31ec-08ddcd7c7fab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZSsvSDlOcWcxVjdVSVNDZjl3a1AzZENZY2c1clMzZ0ZraDdlZ2FXWFNHRFp2?=
 =?utf-8?B?YVBGMkMyM1lwNXQxeTFuanlhT0dpWE9PaTl6TDF1d2tuc0hUbHpiOWpMbmM1?=
 =?utf-8?B?aGFObW4wLzlVV1JvZVowSlc2L1FLWHVEd0owQjNNMTJ4Q3dRSVMzTXMyV1BB?=
 =?utf-8?B?OUY5MnRxSnZFOVNtVjMvb1F4TlRMQW9KUWg2ODBLUUFIK2JjK2Qxa3d3UXJT?=
 =?utf-8?B?MXFvYVltczFSZW5oUkVvUXdLM1VCaTA2b3lOUG9mVHVUYUc0NmduSm1ldXlq?=
 =?utf-8?B?eDIxS1NjRE51OEFxdDN4aitpVHFxZTFDRVdIbTUwaGtmS0FKajdjMndzQXNj?=
 =?utf-8?B?WVpnVDFwcUc5SDRsNkpRWmhJbExDR0MvclZLWC8zRG5ocVpSNStMNTZPbTFi?=
 =?utf-8?B?WHlja29Rbmloa1pzVjljZW8zT1dnbWxucFptTzk1NDB2MkcyOHdiZ0Z1cWpX?=
 =?utf-8?B?bktzT0h2aTJFZ1hIRHhpT0hvTG4zYnJUR3lEYWxvUjcyLzFOMlc1T1Jkd2lX?=
 =?utf-8?B?TnppWTRaMFk1SE55WXRjczRnTHZVbDFWMTNObUkxM2ZFK1g1WUZic0kxYm5T?=
 =?utf-8?B?K2lLdTNWRnF6anh3TkoxQ1F1YnVsWExRTlBySmJ3VW51Z0VpRzRSLzE2VlRP?=
 =?utf-8?B?K25WYnZsb2Y5bkp0UG5hV1VGcWdwUG5TN0E3bEJlY0ZkWlNkMks0N2VKaEp0?=
 =?utf-8?B?LzltQmtDMFRKQVdBdlNWdHdGdS9yVCtyaGtxdFdIamNrd2VpQXJkb04yck95?=
 =?utf-8?B?QlpoTEdOZFZnT2xNUGx3VzVkamtwT1UvRytpMTdINE83VDZWR3dtZXU0VWNv?=
 =?utf-8?B?UGNQdi9PV3hDdnJqc1RLVnQ1WUtUanZKeExYTVZ0SU13RnhuUW1LeFdEeGh1?=
 =?utf-8?B?QWpHOGFSU3dDYW5RYnRweEx1MDFPdWc4TTNHd2ZRcGhTYWNFd2FwV0RtRU9L?=
 =?utf-8?B?VjlxeVFPWGcxMERKQzN2andNc2xtcEhGTzdIeDQ3Uno2U3JVWEZzMVo2UVVz?=
 =?utf-8?B?T0JVL3JGZFVVQVdMN2tJMFJzbDF2WWxZMEtCbnFmdnA0dkdJWERIaVFib3pw?=
 =?utf-8?B?QUhKNytBNVlTYXh0STlYUXA4WVhYUU5pSk1WOFF2WFA1bUJ4NG8ycFV4cm0v?=
 =?utf-8?B?dXcxdVo4V2FGLzNIblpReWVqUWgxNS9PU0xXQ1owYmtKTnpzVUhqWmVPZVNh?=
 =?utf-8?B?K0sxSjN4VUNVeDgwQTU0SGphY0V0VVY3aitNTDFpT1RkYUJOalFxYW9rVlV3?=
 =?utf-8?B?d2hzeEkzR2puK1ZPZnpZKytHSytDK0VJbzh1cE9pNHZIb0N6NFk5b3RaUlA2?=
 =?utf-8?B?enduc2pNVFdTSktURUdqZWY5engyUHRxYkV3aVg4MGRaU05RRmhjeFlwY1c5?=
 =?utf-8?B?b3lhNHFUTXpoVUlnRGFtQlZ1KzFYNGtIVXBzL1RGK1dFa01YYU9XYnc3ZjhI?=
 =?utf-8?B?a1lhc2ZNY29HQUs0TUcwSjRXYW5MbVRVQk8yZ0Njam1jWmlNV0loVkdZUWZ2?=
 =?utf-8?B?N3hFQk9vTUxsVEoxVkRSQTRtQkFMKzR1VHJReWRxalF3QkF5eVFReWw2bTNI?=
 =?utf-8?B?bmFta3ByamdreE1MZytYb2JnYWw3U1dGVW5yQUxHd3VKQ212WDhldmRJYXBU?=
 =?utf-8?B?VGdudHpBNlBFMzhrdEdvLzNOcHFHRFU3eVhoeHlJcDVGYXBZMi9vOFVCbElL?=
 =?utf-8?B?eUV0ZHBLTVMyV1VBQWhZOVVrT0pZTlRCQ2JLNHgvSGRnakY2RThXdkhudVNq?=
 =?utf-8?B?RmQ0bm5YOUc5VHZ5ZDRjaG5ENGx2NTlGcUYvczhRRWtGUlZBREFzbTJRM1FI?=
 =?utf-8?B?MEw3SFVmaFkzQ1NWcDZ2ZHB6MFQzSzRBRERldkhNUGVSVHhoR1FkWXhOTno3?=
 =?utf-8?B?aG9vRVpRSEdJalN6SnE1YXdEY2JXajg2VUJCUE5VQzBkQXlVbHJadTFOdTBC?=
 =?utf-8?B?Q0RGS01zTjBPNTZUb1lEVlN3Mk00OVRtOUppdTRZb2taVmZnUFdIcXg5QXBj?=
 =?utf-8?B?cG40Q09aQnFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGtITGhneXRiNGlPYUlwL1JZTE5meUlvS3NLY3ZTblpEeFZaTlNWZnRxSHl0?=
 =?utf-8?B?S1B6Q1pKQlBsM3gycnVyaTJqZXdYQm90c0hlKzBCTzFGd2toY1FZdVArdXVL?=
 =?utf-8?B?a0NMY2N0aFJmTTE5dzNpZVZOTU43ck9JbTFHNHZkVmFYREJTTG1iTTNUKyt2?=
 =?utf-8?B?MWxjanN6NUEzNWtZY09pOStFRG9GVWZqWnRoUUNzd09ERzlMcWVSemw4V0sy?=
 =?utf-8?B?ZTVyYTBnWmdkaXJlRW42eUVndlIrWFRwcForSUNZTDVoczBxcDl4eFZtUEw5?=
 =?utf-8?B?b0ExQVB4OXEvbHJQZkxCeTRuY2FlOUhSTDZ1a05pZzBJTERjNWNvRnE1Q1Vi?=
 =?utf-8?B?a01idURHVGZWNDRTc3ZqRC85cERhTTJvMENvN0Nob1NWdTJKRlkwdkIwVkNm?=
 =?utf-8?B?UkEvcHJWbWVqOUYramNvVzZWcmErMkcxZnJLdURxQ09uRnlLVGE2YzVSZ1hN?=
 =?utf-8?B?eUxMU0s5b0xST3h6bmR0S0VOcXRkNGZWbTEyTXZIMzhvOHcwTzB1ak5lL0NO?=
 =?utf-8?B?Vzg0anVHZTFONHpBSE44MmEwUFhNS0gvejBkcG9tYTVKSmNtWDBrOGJQcDlP?=
 =?utf-8?B?KzhxQjVCTVB0b3hlRUY5VFpIdXJURW5TOHYwM0I1MVpDakczTng0VXFPc3Ax?=
 =?utf-8?B?ZTArNXJqOFNjYkVoUmxBTnIwWkxTUXExbW9COXRVVTdWK0JRU3pndW50cDhh?=
 =?utf-8?B?RjZmSDlhYUVKMmV2MXhoVmJRWTdFSFhkaVE0Z052MU52VzVJRDUyeEpkTG1a?=
 =?utf-8?B?ajJqYkVlK1BtRFF5OHlQbXdDcWNEdHFjZXBwY2lJRXB2YzFwcTNHYldoNkQx?=
 =?utf-8?B?S0xJcEdaUHMzTTJBNzh3QWtpam1tUjNiQ0FsY0x1UUtxK3RUYzhHc2VZK2FD?=
 =?utf-8?B?ZVF4ZmFZTiswcHQwZmQ1SllyNWo0cGthZkdLRHJXQXFVTnVjTnFIRS9EdjVh?=
 =?utf-8?B?ak0xWmROZ0JBQ1U3Nk16RDc5T3ZjS3Jnd1NsUStDWEUxcEtWZnFKMGIwZ01j?=
 =?utf-8?B?RVRLOTRKSk04N1JXYXhMNGRHSW9qWTExNmhreHYyRmVTMzFHQVlwV3pSMmFZ?=
 =?utf-8?B?d3JxUVY0V1Y4MXMyY24xdzlmblkya0tydUJUVFpucFB2Zkd0N21DZGQxTzVG?=
 =?utf-8?B?cTVVSUZrU1pWYnhmek52VFMzRlplcnJzY0xIQm5EVnZIWEw2SXNqRmFaQVRB?=
 =?utf-8?B?UGdTQVVjd3UxRXpvMXBUZUhEMlRsY2w0TFdZeFNFdCtoUnFydllobHV2ZkxT?=
 =?utf-8?B?S1FHdmJGR3N6ZzFweGJhTWVYbmlqNEJYcWx0dTlVdlI2eGtkYW5IeFRyNkpG?=
 =?utf-8?B?eHJuVy9uSDNaMGx2OXR3bWdZZm1VdVhLQkdsbzhYdDc2VS9JSUpKSzhkQ1Vk?=
 =?utf-8?B?M0xzcHJHMVZPajVTeHVMTVp4bFVFU2FCb2xNNC9UMFZocmovQzdKZ3RHbWpZ?=
 =?utf-8?B?VFlYMjlKdHd2WVAzYU5URHlwdDlJcEVGK0dNN2ZWcFc3cEl6N3BaaDJpUU5q?=
 =?utf-8?B?R2F5UC8wcFdsenErZEZDL0JBc2QyMkU2eitLOFNlSS9LdTdwYS9qcmdXcmpq?=
 =?utf-8?B?Wm9xV0Jmdk5EZ1M2V1NhYkRNeHRwTDJVV0ptNDNWY1JCS05yNEhWMEhuOFIy?=
 =?utf-8?B?VnNnYzhZRGl1aUY5NVMvL1dsTmxySE5VNjYySkZXdC8xYkNxUEp3elFJZkh2?=
 =?utf-8?B?eVZPejVjcE9pRHhVb1JmZUQvS1VZcFlLaFJueGtiTVdWQWF1cm1USEYyMU1q?=
 =?utf-8?B?M05VZWR6ZU1CRG1UYnJzQzlLazZyMjVIZ2w1VHB4R2k1SGdqV0l1WDJta1Mw?=
 =?utf-8?B?RVN2S3U4aEtFVmhZQTFuTmp2OExpenJrclpUaldBNUNRWjFLb0VldklQV3JR?=
 =?utf-8?B?cFpBc3RLRTA2eHE0ZE1ZUUJvb1NkeTBibWd1Vmx1RmtVS2FJeEo3cGRiYVhW?=
 =?utf-8?B?R2w5U2lBWG9mdnptWjhxWlIyRERucDlNdEh4aVdhbEJvU0czS0tnQ01ESTJO?=
 =?utf-8?B?V2plZ1d6dUpscEszNW43bkhNdUZhUks2Y3RsT01zRDAxWmRMeFFUOE13Y2pt?=
 =?utf-8?B?S0x4a2dWakxLdlJGR1JvNFRIZmdtak10c2tLUnVPcXJDSklJeFg2TWx3R2sw?=
 =?utf-8?Q?60CSLene+1idQm1FiKbRXNc8m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cf6031-1cb2-46cc-31ec-08ddcd7c7fab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:14:35.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71tR/y1zE5smsSa45ygsvf0tvDntgilxZ7reesSNcB0eeoajySCsleX4G5lyQurBqaHbMVtVJ0xAbGL/qo/2Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
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

The ddr driver support DDR and LPDDR4 both, so drop the dependency
to IMX8M_LPDDR4.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ddr/imx/imx8m/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/imx/imx8m/Kconfig b/drivers/ddr/imx/imx8m/Kconfig
index 08b6787a54311d27265c0bbcc6d347ae1d9998f3..7c050055be3c39a0188445b6fe5630c590d01506 100644
--- a/drivers/ddr/imx/imx8m/Kconfig
+++ b/drivers/ddr/imx/imx8m/Kconfig
@@ -33,7 +33,7 @@ config SAVED_DRAM_TIMING_BASE
 
 config IMX8M_DRAM_INLINE_ECC
 	bool "imx8mp inline ECC"
-	depends on IMX8MP && IMX8M_LPDDR4
+	depends on IMX8MP
 	help
 	  Select this config if you want to use inline ecc feature for
 	  imx8mp-evk board.

-- 
2.35.3

