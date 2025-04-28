Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD7CC369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05AD82948;
	Mon, 28 Apr 2025 12:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F2avpg4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED39282948; Mon, 28 Apr 2025 12:39:28 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD5082145
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaxRTlFKtTcZQRS6NYRF0xk6SBmxh/ZtnHvTstD3GBxOU+PU0Bs/uv5Jr/Pq1VVMww963bchz/SydMBGh5nHUhr3bmtuLM/pxG+gLAGeYItat1/sg9c/ZmvOnAYd7bKGgWsuxu5tnSUcjaGcwe/A99qGkLAaQMSRyXkUpB+wqIcnrufsmBRXKgdVOD1t9EGTz59Z7iVLuHvRMvgYu9jCfbbb4ZL6JgYlF3kINtTUuzywf8EM8fUmewX31tlMTiT1K4UombJ7KBa6R20pie18kAuiiqL/uVexeP2JNv9+KtwjR6uL2S7qvjf7j1t/ZHUS4uOaVEsjT5equ+2vGu5Nvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2NyOrvLbnpwFnzHtLZ4sPgKYhoRwuDSJgTblMTkcFY=;
 b=ZzJoTx0OTDUQCfIfxuu2uUl8CONHFFomz5nHeAWsNKFoMhG8WeoHl0dNDKBVp0jFRY1U9eKgShE32j1mHq5qG+jev2atwvQPEGr4xrKSAwTUyEUMCIn7/udwJspzvitDKTyzblA5m9G0EWxSupD1AJof7sO5kFCt8+5ut+Dg855P/0WCRKBSRCahzutW59d4UeM+qRg2hItDM5aetl6hrS99SR0ip3KbOrUQMnmONCRIZIVNXaJ8zWexyrvfavjOjy4xeQGsK/+R1vy9HYgFqGZCjRBDgnJqEixgF9JabEv6pgpJyYmQ6xwvqFi9ozno5In8IBM7w6BloeGRDCiRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2NyOrvLbnpwFnzHtLZ4sPgKYhoRwuDSJgTblMTkcFY=;
 b=F2avpg4haGLJLvA2PmVv+Ilt0w/WJaSbx+MIhgV1lY7GhqOBfEyaavtyYdQQfPl5J1KBN1gT2OWewI0GB0U8ljeoAfJGQfKB555tkkDZlUWq2/5nh+77Cahn9s7eH0PGXEOdHZ8sHrZIaFFNgLOUqzoo0G6zarxKYR0VouLRIJ2VhOrI2gVA8jtBhfo9VA+nmylPAQHDAHduP3XO2abGD3Peu2RLKJFaZNOqadJm2zbigWWBDmUTar1Gwd15Ujp/Zg6sCbFMDcX8ucjhZtq0KMKJkiX3ADi/9QMm3PAB+GrFiJLGIzP/IzOfgPWrYIBwS5jyQkJXslXmXC9Yy/lL/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:39:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:37 +0800
Subject: [PATCH v11 14/21] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-14-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7976a254-61e5-4051-71af-08dd8640f113
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXJSdVdzK25mYXBEYnpmbFAvR094T2JZL1QxTkdkb0dMRmhJZXo0VEhrVkY3?=
 =?utf-8?B?ZEhsZFNucFhHbVBKelRuM2h5bVl1TEdwWjVQNitkMUFDSTU2LyszUEVXL0E4?=
 =?utf-8?B?bSt2ckRNQ0pvd0NHTEZWc1p4THAxdTg3c0VMQ1hXYTVMb1M1allLSE5INDlj?=
 =?utf-8?B?T25SdVVvOXJRQWlvTU9wU1AxSWdBYnQ1dUxDRTJlWkJGOG1HYVNMMExlYVV6?=
 =?utf-8?B?cGo0N0hwVEVhVDFRTFE0TDRLWjk3MGlVQms3aUlWdjBPZU8wQThGTzhRUndO?=
 =?utf-8?B?Y2xoK1BvaVZzYS9LOHEvTEQxK0NkYitrOXpxV1BTSGN6OVd2Q2NKYStXY3cr?=
 =?utf-8?B?UjRrSWtFOWtHUmx4bVlsWnkrRTBMRlFmS0pwOEtrdk5IKzZHOTBkbEw2Qk5j?=
 =?utf-8?B?MTB3UTNoWVpZVVlIdnhBRmt2VUFZWWQwRXVpbzhqcmhTRWkvR3VPNDBiY3R4?=
 =?utf-8?B?VzJOZVc4ZXI4VHV1MXJNbENGMXduSEhJYUx1M2swNmR2LzF5WUhjYW85NlFw?=
 =?utf-8?B?SUJHOGRZN1czOVJPY3lRaENyNUNyLzBJZG9BelZjTzZTeFVKOFZ0NDBpaGlm?=
 =?utf-8?B?UHFoYlZqQzlIall1cjZIZHRwU1gxdWo4NVJHVDhxZXRLbVg3WXBGOFdjMS9T?=
 =?utf-8?B?NjZSSzJXM3ZnNEhYeEJzT3dHK0E2eVJKcVYrQXF0eldFM3hFSzAvakhrMGRt?=
 =?utf-8?B?dXB4ZDE0OFBiOE5mT09OM1VNUmhsZDdVT1U2TUVSTXZGU3NyVTAyWWFGNHhQ?=
 =?utf-8?B?MUtBR0pJbDdLanJnVlMyRGQySmxvZkQyZ1BOS1VESVNIaU1NOHVDUk5XaTlu?=
 =?utf-8?B?SDZWZUl4cERVL2xaVTVOWS85djJwNGxneW5peTF4YXByZ2p4TzFsb0J3NTRK?=
 =?utf-8?B?ckJUYno5cWhkYkxpK0lCS3BST0NzRUtqL1VOK2pleVhuZEFLc3NndEUrVmpr?=
 =?utf-8?B?OWk0dmlsQ2R6QmhtTSszd1RmZW8vRndwajFtMXBFQnpTcXpuMFdHV21QZEpT?=
 =?utf-8?B?V2xxekFOZVRsL0xoVGwxM1hETEREWi91VERReDQ5RnhyeEYyZG1rWlhMeEhR?=
 =?utf-8?B?dG05QWFqclBsSmMrYUZBSUcySmRvY2xhRlJzNFdtMS9DYjZlQmpZSEZaOVEz?=
 =?utf-8?B?L1A1M2MxMGY3cXVyK2l5TzhHTVRtbmpHanZMQklTdndGekxJb0JmOHhGUm9j?=
 =?utf-8?B?UWVhK0lVQVFrL2FtcmxNRy9ueERIUHBXemV4TjVCU3Rkalp1WXZxQWw2YS83?=
 =?utf-8?B?eGh6VEllc1FjUXJ0dEV4MlRNaElpT2Nhak0waUFqZ3R5RzZiMTJzM1JwZEJx?=
 =?utf-8?B?VXVyRncydVJlVWpsMTZnRzVhaU12UGVJYzFSK29uMzBnYStnZlIxRDFKTTdx?=
 =?utf-8?B?a1JTdzVXUm9BLyt5V3JncTM3MG9yM0I1MUdmeXZNUUdxa08weGl2UktCSFdW?=
 =?utf-8?B?ZkVIVTBxUzM5NGZ0d3AzRVBSd00wcFRLUnVZNE16eXhmRFFZaVAyb2NaaXcz?=
 =?utf-8?B?MVdsU0tBMWxjNk9RUTc2OFVQbkFGYjJoVjdrN0VCTEREMHEveWhQQldTV1N4?=
 =?utf-8?B?L2lTcFZIeUZ1M0VQVWVLZmorSEsrYUk3ZW1XNFBDelVSbnJsYnNKU045SVVn?=
 =?utf-8?B?U2xob09JZ2FXbGV4WTd0SHpEVE1nVHpkZmpkWkVqdDlrSU8raFNHYmVaSFUr?=
 =?utf-8?B?SDdJeE94NmJCOEwzT0Y4QXFUVlppOGJvVWNNNjRFWUNkNHJaQzZyb0twdmlS?=
 =?utf-8?B?VnZIeS9lWkZ4bTQzMFNYQzcxekJKbHRzYW5IMzRFR1JBcE5rQ3VBeEtXeGUr?=
 =?utf-8?B?M0E1SjRheTR5RkZRcFdyMnlOT1NQaThpL2RMMWJ2NkQ0L2NpajcyT2tMRkEw?=
 =?utf-8?B?SThneDBLTFJEUmVBR2h1c1M4aXNBWHh4OGE2TVVIdXJ2K1pWRlZaSTczaXA2?=
 =?utf-8?B?c3FrSEV3QkVBamFuV2lwWWdCT2FqN01OZ1RjOC8ydmZNR1Y2Zy9PM01LNnVK?=
 =?utf-8?B?QjdORlVaZXZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhQcjlURVY0NngzVEhPYTBLK3Nha0ZXczUxbk9tUVJ2SkI1czQvU21Xb2dP?=
 =?utf-8?B?Mm9xRVlyOW5neWRlZzVMNkcvSFRtR0xnQTlTUmNJZjM5MWpZTTdkeFpLMWNa?=
 =?utf-8?B?NkJWSlk1VlVOUlRVVUo4eFFpTENvUGx6WlFZYnlDM0FNZm5kM1Y4N3pDTXAv?=
 =?utf-8?B?NStNWjR2RkZiWHVSMEpRNzVVTGlPenVERDQxNVJSc2ZhbkJHZEJKUFVEY0lH?=
 =?utf-8?B?QWlDcGlVZng3NDBUYnZBa3QreHY0d1NPYmRXK05PWFRxb0RPbGNwenpESVV0?=
 =?utf-8?B?cVZyYUtWVVBnOUh1SkJGN0Z1Ukp0QXFidHZkZlhSZi9jTWJ4WjV1T2lBS0Rp?=
 =?utf-8?B?NVFjaFpoRFMvaTlqbUV0Y0hPTjFvb293S1FxTGZ3RGJQYllaYWV3Q2xnVHZZ?=
 =?utf-8?B?cW1BbW82SldBUkgxUThqSmlxY0prV25Ram5rcktwV0krc3hiT1ZwRndHQVh0?=
 =?utf-8?B?Zks1eWVVdXpnZUR2MXN6ckRtaERxNC9xZU1tVEpWbU5WU2lOUG93bVZZcHh0?=
 =?utf-8?B?Z2pRVDd6bWdka0xaWUFGUDh4U3NTS0xkbEs3akxHZmtlVi9hVTNyem0xS3pi?=
 =?utf-8?B?eW1MdlZtQUVPeDVmUUFIdkVvQTVXR21lSno4YmMrdWIzKytFc3RLdGhFUGlE?=
 =?utf-8?B?Nm1QMDh6a3RXUDg3TWhkaVZRbWgrUklqOUZRRUduVTRSYjZLR2RJcTcyK3h1?=
 =?utf-8?B?elovYUF5OTNLNk5INzREOUVHeW01TUZlZ09BVUpIb29rd2JxRGw1RFdjaWFS?=
 =?utf-8?B?ekFjVlFmWS8zN1ljUm9KVXBwR1VwVHMyQlZpa29iZ3c0a0Q2YWdtaXhyenQx?=
 =?utf-8?B?TlhNSjd1T1puUitUV1dBMTZnL1BYTTU2OXlOTkx5VHVWRkpsZldybmRDY1ZE?=
 =?utf-8?B?eEVWMXBNUHR5ZGxNWTg5d2t5UzY4a3YwUlZQajdPZ2pLazhHeEl1UUMxL0hj?=
 =?utf-8?B?QVBzN1JsZCtJZmF1Z3luMzEwOXp2dGtqcG45L0UrbE1FTkpqY2paVnNEKzk4?=
 =?utf-8?B?SnpDb2ZsQStkbzB2a2IwbU1la3JrYllPQjQrUGMyRUROTnFhVnpHYzF3Y2FF?=
 =?utf-8?B?eDd3RFZPOWtoM1lqRmtweTJqaHIzc2hyMi9IcWZoRkxZSXYwWnliOU1FaGFq?=
 =?utf-8?B?UkxSbFRKbzNZTm5KMmJYakVaejZYbkI1QjZSVHJBQUJ6dCtCQjBpVnBPb0dM?=
 =?utf-8?B?WUo2dGhSMndLRkcycFhtMHl2dExBUzFFbXlkTjZsK0EvMzZtTlVXRnlnNHJK?=
 =?utf-8?B?b2dsVkloaHl4QjgyWXM2OWxqWHAvdkdhenVEWnJjSklmVUVVMXhPWkp6VEV2?=
 =?utf-8?B?WE5Ba0VVSm1BSXhwcDdHSlA4bzcvNVVkM1QwS25ScEJhenk0TnI1TTl1Y2Uv?=
 =?utf-8?B?U05ONm8yVk5PNTcxOFpPdmxRV1ZJbWltaXczZlhsanRLZTduTHdBNnJROHZF?=
 =?utf-8?B?enN3Z1ZZakZDM3NYd2dVbTRCQUdvR0t2SXoyd1E0dzdYK3p2VUJPTnpPZGg5?=
 =?utf-8?B?S2UvNjRwQWNQL0RwaWd0NE51T2J3WHFQSWRuQURLOW1pQ1E2TEZqeGt0Nzc3?=
 =?utf-8?B?RXJvYkx0ZVp4SFFoSkN6OHhRMjB0dDFHUXhUZGNUVjM0RFZCV1kyV2FSTFFk?=
 =?utf-8?B?UlpTV1M2WUNYNVlsNkpmeDhNcDIvZFVHaHl4RDR4YzVSUFVQSjkwMVNjUlZG?=
 =?utf-8?B?U2JQdVlXeTdKSnVEbmVFaEVBYnZHVDg2U2MrN2laemtERjVFY3kxaEhBY3Z5?=
 =?utf-8?B?UFdCN0p2d0lmek9lRlFVZndySjhsQ2EwZjcwNE5PdFNiSVFhczFFaGU4OUZH?=
 =?utf-8?B?eU16L25pRGVUY2lsWnY2aVlWWWZ6ekZmL1pyZFo4UGV6Nm5sQ2RDaVRCYlgv?=
 =?utf-8?B?SkRiUC9sZVJFZTVwaHlldGpPY2ZkNyt2S0dNdFBqdUdKV3JzSzRSZk5ITmhq?=
 =?utf-8?B?eElFS0paWTl2WGRWNzRnaElMSzNaRGFzdThnaXltNDdNa2dIYjNLd1h4QWlP?=
 =?utf-8?B?UVZyYlpCTi9ZMTNXMWhOZnBqZXdjaUN5aEVheHdSa24rY3NEVktHa0pVeTBh?=
 =?utf-8?B?WUMvYTAzTGxzS1hmNll4ZjBWcWJCWHRXcEpVU1VpTlNsQVFnT1ROMExHZEwz?=
 =?utf-8?Q?8ILaL5njzcY1tYVpw0q9IfH7X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7976a254-61e5-4051-71af-08dd8640f113
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:23.9144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+J7RLLZGdod53TbaGrYA66kS9NaXS2YwDM5PiLVyIzpNLPyNzbzOCOwtWa40B2uPk6azLhKtSYVZLi8Y0a5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  | 7 +++++++
 arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 1ccdb1cf64f..f6a9a13e4c9 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -24,6 +24,13 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select IMX9
+	select DM_MAILBOX
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75a..53cc97c6b47 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -3,8 +3,13 @@
 # Copyright 2022 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.43.0

