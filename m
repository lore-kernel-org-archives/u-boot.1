Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C654C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF3E7810F4;
	Fri, 28 Feb 2025 11:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yDHgWvwi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE660807D7; Fri, 28 Feb 2025 11:55:04 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED76081110
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3AQTj/85KSMpcpIJQhNgFlZ5YAytMaa7zW27o0w3U0uZ7Z41O+WLBeOks7nKq1fQboRUfPE7zIkTp8sz8dyljbnu+/fp05mRfagRAndD1ky5PNoQ+Y/8F4IVCo0ZsCsZCdr3PsSC12FjVUZD+/UpyIGpyw/PG1+1IP1XBI8yI+T9ad+gyWsCc2ntnL1cPn3/yxR7mh99BUGBnSeED3G8KnLkUcVpJ828O3+FMLi5SA60ukxC37ncnP7CX7eesVQGmAQrpP+J8i7s1+3kumspR8Z+mpSd+Pn1bcKY/df0WQv5lY9fp9JV22itSpTbuiSH7utflekBlFoH5pxHnZKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYOuXCA2y0VohT56bSbQOwfWldkYoZYopXV2k9/B+dw=;
 b=HFDWe7uHlOwEajeCNCkfK+tGUiFgR6B+33m2cHTXSp95oeNp2JUUQBU3jlYOD1CA0MOXw4EJb1ZIk6JI7sMU0B7iQGHeZP1HVFJIJDftkNC7BqVuw9fLuKeqs8iyX30bF3XpScC1k95Dw1MkNIzt8lElGprXKJlmSkYbtOvKz1sM8/0e4mEuJAOTD5UxnQUzRG4Ah+X6KBz/wqORovIfKgzr7A04zwDgs8NIjEIlavPjNsj/QvcTIJtuqnN5q6L2Bp378gI1Xmfy63AFE4FY3ETrKwG0Ju6JNPbzpAJ7PSG7wZ424RdKmYcVyfFEIg4AWsl9uVNXuEBcgrq8141l1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYOuXCA2y0VohT56bSbQOwfWldkYoZYopXV2k9/B+dw=;
 b=yDHgWvwirI+/Y4SwQutEz76rPY4am4psPqlvm+LWqAoMR4hNvCRRU7I8W3OuygAr42aVoYDxR0aD8urO289J2v/+Sb6r+93mD265cmCmtI70xrDpfC6nnixrVk9T3JYyxhZKujHF8ikfAeb2l20/naooe+PttUFiwSyUVKhYt6LN5ef655vaCN/HZJPL0Zc3EIClNaaQU3Wb+0gSfxa27erc8uvCP4hHVQN0jSXCYsuOMH9V2PsMeKsUegOP8aSpfiVnlC2iTZDiOfAzbzFeQQPJVgFG3zt6rP7VoKHRSyz6jZS3dz1MZ+qMhJ7CbFYbP5mEV2+VWXTzrqvjD+dXQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:55:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:01 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:53:58 +0800
Subject: [PATCH v6 07/20] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-7-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f46e12b-86d1-4d51-64c7-08dd57e65985
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzFaU2ltVU1tdGNIRmh4enoyOVhYZFhiVkkzdTE3K3lLMk5IQ1JWejNuVXpV?=
 =?utf-8?B?UnRycHNZbWZPN0hGOFdTeGhHSGIrZGx1bkcrYlNnL0taL2llZFRUQ1NEMmw0?=
 =?utf-8?B?dUlRUGRLVGVoT1llYWIwY0k3d1grZTJEcnRZSXhYM25weXBzQVBmdHdMNmdD?=
 =?utf-8?B?MEVTZ1BwbGlEVnpkQ0R4dTNmMWR4TDJBSEYrbDVQZThiMFJ2eUVZeE0wdFZn?=
 =?utf-8?B?SnhLUTQvUG1zaWVyWXRDRHVIMTFYU1dQTTJIMHZLRmozellHWDByNmY4cmhJ?=
 =?utf-8?B?SENpVWV5TmdzaFVVOG1TbDN4YnRrcE9PUUVpcnMrV0FXaUVHZG5PbnRRc25S?=
 =?utf-8?B?dy9vMlVpTG5mbElreXhWMXNGdVZVSVRGdTJ4RlVKRkEvbWxRbGVQSXNkdHYr?=
 =?utf-8?B?Ymo0Z1htelhraU5xMWdkbWthYlZMZU1Kd3hsa1g0aDhEcUI3Ukt3REVjQTF0?=
 =?utf-8?B?M0ZseFl1UUdBcVo3SUhJRDhZTWkxQ045SWhTaXZsTTVya0xvQ1BCR0hpdVVR?=
 =?utf-8?B?bCtxbVBLWUhuclIxSXY0dzVySkVwWk4wbHBTNXVZUE1hT1lwNzVFYjNwbnAw?=
 =?utf-8?B?WjNDaFRORS9JNUxEc1Z2NUtiaWhuUUtJUCs3Tk04cE5veXhhOUdjZnZzRmh3?=
 =?utf-8?B?N2Zxd2VHYUp2UEZ4cis1cURtT1cvT3RlM0pHUGpmTE56WW5RcENwYUwxWmpq?=
 =?utf-8?B?MzVncSsxOTFXSHFPcmRveTdjVm12ajBtZ2lhaHJrdXJjWUVkK2hDYk0xVzZY?=
 =?utf-8?B?UVNSSktKcXM5MHZ5eUc5cDZtVm9ySkNET2NUUnB6Ynk3azhDa2J5R3ducE5M?=
 =?utf-8?B?VVZiZXlWNTh5UmNvWjRsaUxWSXpBdGxzcE5jTER1dGlWWFRLVGdMVnROc1Bi?=
 =?utf-8?B?VVdiaVlWaXFDejNuOWJxTi95VE9VNVRTekxIY0llUTlSOVYxdHozbUJIU0Nt?=
 =?utf-8?B?bmVlbHBZd2U3WmNYNGszbndWMzVvVHBnTmdrdWxNckZQM283ZlhEcU1YaTFK?=
 =?utf-8?B?R1JIUjlqZW9MckVwNlJwZmo1MHVCcit2eHRXc2U0M1lHL2R5bFgwSzBpTlZ2?=
 =?utf-8?B?SVUxZjZYeDVtcWNkVVRLeFNteGJiN3hhQ0ZSd0NPQUV6OVlDYW9PWndkWExj?=
 =?utf-8?B?VWlkaCtNOEQrTVIwSmtUa0JZZ0FKZXVhLzlRd2hpbXRVSS9pVFc3SmpGS3Bh?=
 =?utf-8?B?WU80MUQ1a2JkTVdGbTVCVnZQRDZrdFJHVUpjQ1lNRlhLdGRNNHhjbFNjeU1W?=
 =?utf-8?B?bHl2M2VhaExLL2p0ZGdMTkpVcUZBd2psVklIZExQOXZnb0tnYzV5bmR1M0VH?=
 =?utf-8?B?czcwMDBTUjVJbjlZbWE3QmtmWjl3clFodXB1TVd4alZtM3VucFAyTlhLalZ6?=
 =?utf-8?B?RnBPZUF4V1JZcnFCM3ZkUjlBT0dzWjdwMDBiSUtFZm54TWd5TkVDNFlmU3pp?=
 =?utf-8?B?aWVPNk1EclBVWEFmS0c2aUF2ZWpyUmc1QUFadVdzY1lYc3VUMGdMZ3Z2VTd0?=
 =?utf-8?B?ZHBsbDNkWnVEOW8wcUJkeVNtdEhhNzRpSlQyVlVwemR2bGcvbTlTWjNpeVRS?=
 =?utf-8?B?ZzEyTGJSOFhKeTJWTmpDWk44aW9TMXRVQ25aVFJpWFZTM0hUYXg1YXZoRmIw?=
 =?utf-8?B?eDhSbmhmQ0l4SmkvQVJwWjFyOFd3bENhbUNYUEF2ZnhkaUVRRWNyWFB2cnhq?=
 =?utf-8?B?RXNlT2dETUxqenBkTXdzTmRSdHRvSGkyeCtmOXZiS2trOWdJWFVNNFZUWm9G?=
 =?utf-8?B?RjRmY0U2TzVueUpub0lISzVUMUNtVjFaWnlPYjdkRW1BZlZlWm5KZjdaQ1o5?=
 =?utf-8?B?ZDlGVGt5cXU3eHVUc1dxbDRNamQ3SE0vVTFSYmRDZmtRcG5iRHVSNzBBNWFn?=
 =?utf-8?B?NjY5eFFoMmJReG5sanJuNGtjUHdDV0dsOWlwUWFlNURVVlAyUDJhRWhpQ000?=
 =?utf-8?Q?IO/Gsg9RcTWl0uGbgBN1XlcFM05fSLck?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09vbE1jS1ZvTHpCalJhL25QUHNnVXlYY0lyYm0xQSt4Nm9TQXE3d1dNb2Y3?=
 =?utf-8?B?cnFaVm9rRHZocW0xdzFwSkI3bVhwS29XV2h5RmNCYnp5cHhKNURMU3E4ZjBH?=
 =?utf-8?B?TG5GTHlwN2lXUUpIMXdqbndOUTlxTmFhVEFCeEcxWm5udENNck94TGVRd0FZ?=
 =?utf-8?B?LzAwalNMbGNqSW5CUDBBNElqTGNyamxPdkc1U3pNd05zdzBrY0t5ejA4aTNt?=
 =?utf-8?B?a3p5eXJ5MmdEWEI1RHJhMEpGUVFqM0hXcnQyL3A5UG1lcVplZnRQLzNuZGho?=
 =?utf-8?B?VHhlSU1NYjNNeE5yN2ovdTk5WGgxV1hYaXlZVHVCUkhKb2lpSmFITWVpTGpN?=
 =?utf-8?B?bXRpaDFic1JaUDVERXV4K0I0R3NsU2hmellXb2xVQUZYSXdVL0ZWL1QxOXlY?=
 =?utf-8?B?V29LVENCS3BrTW0vWkhFUUVtV1pvVEdqT0ppeTNCMHFrb0N1RFBKU2JDbDAr?=
 =?utf-8?B?NjkrV1ljNWpxNEZxWU1KcUZ5RjFldmRiZGxJTk9udXRkMTlGL0NMUFlORFNj?=
 =?utf-8?B?bG9NVHd1dXNDQnRiMXJYMWlrc24zTTBsZ3lZelQ4YTFIQmt4Nm9QSDJoNUZa?=
 =?utf-8?B?dUdoMWhBTlN6eEVwcEtEVEYzVVovdnZsb0dRZDE5N1lxdi9yQitoaU1FSUNH?=
 =?utf-8?B?d0g3aVMxVExPTktPTVU0Qis0OFpLekFrV0pSZUdGRnhITW5IUnpIM01vYWUx?=
 =?utf-8?B?dGNnM01QZWE2dGlSaVZVMXZwQWcvTlFmTmlXRE0yYVZRYUtmdzFoVVJ4ZzV6?=
 =?utf-8?B?OU5jOXIwV3B2VUtNMklMSkgxZ3Q2OGZaaEVUN2dPK3pPZ1NjZmJ6NXEwQkF6?=
 =?utf-8?B?SHArb05Td3hsaTFEOWVPQjlpamRnV3VYa1gzUFVaR2ZZbElTdlNkMDgzczdJ?=
 =?utf-8?B?aTlScUxZd3RERzFmWk13NGg0U01oaENEbG53SUhUT2NJdmx2OHN3V3pxSW5p?=
 =?utf-8?B?KzRualQ5RWVsL0VURkhMU2dPRFRSbEZORklGTTFtakhoKzZEUEJaN3c5QWVh?=
 =?utf-8?B?Q29JQTZsWWFUNHJQT1N6SHZOMVBWSWJ0Tno1ZFNZdkQ2aGpZWjNVc3ZWalBZ?=
 =?utf-8?B?VWNYL1JtN1lhZ3FZV0tKQUVnNzV2bm1SWDl2MnhkMEhtVWVRZGFERkdqa2ox?=
 =?utf-8?B?QmpTNEVwZlEvK3U5UUxGSkV1dzg2ME9qME5jV2llaWFlS2lCdFBaSnJiTVVm?=
 =?utf-8?B?cWUxYmdqSlZoODB4aEpIbWZTbVZhTkRldGE1ZFYrNnNDUldyQVZiNCtRMXJy?=
 =?utf-8?B?YVBVcnc2YjVCMm80cmxqUWhRalRLMVFVNk4yZWh4aXU5L1FEekNyUjdRTnZH?=
 =?utf-8?B?Q2hFdFMyTGJwWHBmMldlYURMTUNDUDFsOS9OSDZHK1Fxc2pkRStaTFhocWJr?=
 =?utf-8?B?akNCM1RWK1pYRUZIdFVRL1YwUEgrMnR3ek9Hd0t2eUF1TUpoSVo3VXpPb2xM?=
 =?utf-8?B?amwxQjMwcjluaWFsNzIvanVGQVNOMVA2dm5BME9ud0lEY01aQVhsSHloQ0l2?=
 =?utf-8?B?ajg5UzhGTk1WUDBqYk5lZFQrSFEvYmRNajVvR053OE52YkwrZXA5UTBCQXV4?=
 =?utf-8?B?a0ZpVmwzQXZGUk0weC9XZHNnUmRmRElhVXFHWWFmSlRDYituZFJEcHk1dGZh?=
 =?utf-8?B?djNPQVBNS2E2bkl2TTU3SVFPNjlBVzFOVmd5YTR0ZXA0K2s5R09aL3BBR0lZ?=
 =?utf-8?B?L0hrb2gvNG1RbUJmSDdldW9Lem1aQUVFb2JGUWRvZm5kMkpucHJjTUhiQmI3?=
 =?utf-8?B?MG5KVlZrUHkyM3NwdDhDMXNRTTJzZDU0YnpuamVpajM5aWlxc3ZnOVNjU3B0?=
 =?utf-8?B?L2N0dmVTY2thc05NR0xOdFlIQkNqVUIreGJtWTRkd0pXeElJVDlqMXByLzZG?=
 =?utf-8?B?NHAwRjFCUzdVWFl6b2REY2hMN3dSNFNwTmNDaVlVQ1VOaitmWW5ENGNhYXIw?=
 =?utf-8?B?WnluYkM4K1c1Y1ZjZHovNDJDRTZjSFpuTW85MUVrTzFjV3hvd2t2M2xncEVX?=
 =?utf-8?B?MEFPRkJ5MmJNZFBaZkFXRk9iUmt5MW40WnJ3YlJWWXNmNjFNRnZLemwwUnRY?=
 =?utf-8?B?aFl4Q1BmY1JjcGhnWldCU2tienRvUzJMMnZPVmJIZy9tODRNVlVvaUxITTE0?=
 =?utf-8?Q?dYeVdL4VcV7ujRhetbpeQi2NA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f46e12b-86d1-4d51-64c7-08dd57e65985
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:01.3819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duB5qvxtjtSVXjvHSRrgRmzlCQ+bdWPx+dgVOi4Odifqbrjw399mbL4O/L+Kj3JUPM09JaeuH4LhDZzY5hiH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
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

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d4..84333cdd0c 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -178,11 +178,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 34f272c448..0d8c177025 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

