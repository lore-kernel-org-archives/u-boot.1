Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF807E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE1580542;
	Fri,  3 Jan 2025 07:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cKVIIq2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2711800D7; Fri,  3 Jan 2025 07:46:16 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B099080447
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLBSfFwFYodEln4x1pkg7yuMd6jhpjT73sAYxo/FVl5g9lB6OA4VvERfyawEpAjwWni9Vunc4JWPGW8S1XgADeioWTme4S0ZRG8p7lV1VVST8Ma7ywU9TNYy4wu/47930cUTquHDG+W3QwTONKOXSNQwlbZc9Agi2DqtcFkaM5buhystE8NvZ3GxhOXYTMGanEUhwCqz2KQN4SNLh0mT/kVZDuwK4cotf41SzctuBGKDYYHsSPwtoYGe0Hfu8hPS2UncaN1B8Z4pv8umk387I4nVJP0XnHD5lPtoOSjUDj4uFt7RBMlKix4C+muhbA/TRz4UlHh+RLWJ32yQHys6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKCB1yfDAmx03l0mhXjOjDppFlvblqH2PWIwM7ocSCM=;
 b=g7e7McOfms3L+lKKJkhWlr+N2h+OmR7G06WBM1qVAi/vMoZCV61Qmd5Pp9c4ByTBG5cFpgSS2w5q8v7isWGwo7G7gRIi5SlwRb8ili0D28Nx6waCNKX0yl7+1y+M+4aGYAbYKhitFfr7UZgajeNhKM4r0UtZm6PphOVcHx7Q6yFwvXxoal09hkRlMNkPXl5MkX4v4Gijreffm8ZbIaQbxn2SBVxGsIxg9D1JJVHaLjKdDTwDOJaxJIx+ICwhKNib5cn8z/HxZ8CtnbIgWMi8Hz0HxZa7/jSxWq2upJSzRmnk1goDIQhslZyh7OP1VxrXINJVDMC152mzdFs/hfsK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKCB1yfDAmx03l0mhXjOjDppFlvblqH2PWIwM7ocSCM=;
 b=cKVIIq2LR6nTPYQJBXhBvzxfZQMzNvvwlMu0upi26Fv1V4qlWUePITCyCxsW+Z59jcY/kppt5j6g4l8rxaKXUM4GyX9tm3Dfc+FyRLxfsL1COFErtyJJRKda4xqjImZcjBvK+dxVgnyStSBZxz6XgG81fsQ0l/qy8+OMp00ChmxhJOjY8zvXi83dtdCDcUWZfiFe26XZPuTYcrETZW0Jnk09v5MdDDmOE4qXWNWLW6Tu18MkloLIHimnhchiEvEu551EcMrbHO4jhZsmmwE3VbL2TZTIcw2V5ZIje/v8QKQC97ruFfSTHiUpWH/o6jyzzA6L/SAqZPQ6N6/t7kIeJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:09 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:40 +0800
Subject: [PATCH v3 05/17] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-5-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=1209;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=BJ/qxA9lxg2nGm+vMp5VJshGwywLmhm+kcwTDcL9kMY=;
 b=HedcUICb1hKGBmFyimq0qDpfD7KRKfzRjQwrw9sro0x5oACDUJNNZQlwRWnstFObF7dJVIPUz
 LIjLnZNwHEqAtafi/5GmloY0g6Ade7sT2TnaduzcL+gDnSx219IxhhP
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f0ba1f-befd-447e-cdc4-08dd2bc24e13
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1BHQVoveDZxZ3NvR0gyaWM5NEFCam0vRGtRNlpzZG5tdFd2ZjZxbGhVanVZ?=
 =?utf-8?B?SzVwRHJpNEhOUzQwZEdXUGVqY3c3UnVQVFlIWm1uWmE1UVFvTzJnM3lscStK?=
 =?utf-8?B?SmluS3dlTHRPK1R1VXFDYldabTl0VzhjQkxoRnlwWGY4cTd6WFNRV2M4Q29V?=
 =?utf-8?B?b3VWUEVjdDVDT3BpenRuWnRsZEd4WUdlRWRYMWpONTFuMmtyb1F1amEvdW9F?=
 =?utf-8?B?aG9GbjhtMTgycGVZaFM4M2tDSDM0Q0UrRlhWamJIWXQvbXlPcGpLWHVQNWhP?=
 =?utf-8?B?SlFwSExDcTZtbUp3SGNDUkVhcWxjZGZVN0lwSFdWaGhueEZuUmhnb2N5T29D?=
 =?utf-8?B?MTNPZ3NPVURhVG5CNWZRR3lnWWdvQWozL014Q1p3ZEZnSkJxR2VGZmwwRmQr?=
 =?utf-8?B?SitVdWhGdVJ6RTJNeFZmdzFLaUI4anR3Z1FnazFEUzdBT1JUU0VvelVZa05h?=
 =?utf-8?B?N0NIaWEvSUdnaXZrYjhPTDJZTXkyTUtzbmQ3OUNDdDhTaGNpcHJWb3hRUjMr?=
 =?utf-8?B?MlVNOGE5M3hRK1VGYVpscjNLSi90M1BPYm96UE5vcGVsV2diblZpbUx6S1NG?=
 =?utf-8?B?K24xWjZrVzBzb1Y4UGtEK3o3dExmMEFQUGxUeEFQZzRCS1VteTYwR2JnMENZ?=
 =?utf-8?B?MUUrVFI4bmZUckNDeE83N0tKV0VuYUFyMDRBdXF4OHhOazdlTlVJUWV3cnBZ?=
 =?utf-8?B?UUZzaFp2T2wyOVFDRG1obVIrNmllUFVyWXRoMDhZVDBlbjFHQlNRNUM0NGww?=
 =?utf-8?B?V0JNTU4xWnNxaERibCtJTEVtUGdXYzRQNGpLQko4dWpESWNqaFFSV2p2L1lI?=
 =?utf-8?B?SUgweC9BNVJoQjJWaUdwWVhDdkhEY0VEb1R0emVNcjRPdFdFNjdpdE41bkNC?=
 =?utf-8?B?ZVhIV3dlcGJYR1RuaW9ETThVNGZ2MXgrbzQ1SHhqODQ0bWlaS0pFa1QvZWFG?=
 =?utf-8?B?WEZRRk9Mdnh1SEZoTDI1M3lLTmQ0ZlhtM3JET2R4ekZpd01pakl3V3MvejNF?=
 =?utf-8?B?UGh0NjJxTWxLd0pOYkFkZ08wT08vbllmYlhzMzk0STFEWlBpbnJtUyt5Y0Uw?=
 =?utf-8?B?TFZXZ2tWdDFWenNBRVZJeTUrVkM4aVgrS2N6Z2o3c1IxNHZCK1VjcFd2b1FS?=
 =?utf-8?B?bkR1Z1hpVDhhUURiZW9UYTZmbnZsM0dXUEc1TlFidkFyV3NDVWZtRnNDamxt?=
 =?utf-8?B?RERKUTJwOXZLT1ZIYWlWNno4c21zR0UzZlp1Z3ZqOWZFN0E3VXlUaHRVQXRG?=
 =?utf-8?B?RCtyNXFEaS8zTVVRaXlWdEFaTXB1RmIxc0tvZ0EvVktrZEtFNm0yMXFLdzBx?=
 =?utf-8?B?c0ZhV2xpV1dSZFN6YkFQQUlTY3VKejhEdnJBWE9obzdHK0dyNUhpSnFIZGli?=
 =?utf-8?B?SXVtSDVmcDdOSWJuNGFUMCt2T3h1Y0JlcjcxKzNTT1lNVWV4RldiOG01VnRj?=
 =?utf-8?B?ZkxwUVFrSFZCZGZQMGJZZkdURDJJeUZaVUViQU1uQStFYnlZYmk0eitzTllD?=
 =?utf-8?B?SmRwTlRPODR4cVJXcGFvb3l2M2xFTGVFUFFmeFdNWUVCRmdzWXJKa3BMVC9l?=
 =?utf-8?B?UCtVNloyQ0hEczEwdml4cjF4Zjc1TFdlRXV5ZHNnSGh2dGxiSkxPY1lCL2V6?=
 =?utf-8?B?b2I5a3ZpWFQ2RDRoVzZzdFk1Qm1BNTIzdTB3M1I5SklZYjM4d0JGMHFVcEJa?=
 =?utf-8?B?ZXlMVU9rbk9GNzZIakJvNGlzbEhlMjUrVkhuWmxOSjZzbEZvWXJhUGNJdm8r?=
 =?utf-8?B?Rmxnbkg1V09DYlh3QTBTTDZwOThmYnNTRExxc2xjekVmelQ5eGdLaXlFaDc2?=
 =?utf-8?B?NnQ1SE4zS2hqSHlyMjdheWlML2RTRUtqc3didkdMdjVPU29qRVEzWGo5Rkl2?=
 =?utf-8?B?UlhBR1J4UUgyaDdIZ05UYmZWalB5VVdZSE9WSEVKREhVZWtYTUFIYURCZ2F6?=
 =?utf-8?Q?uylfqYdCNSSZc08+/roNw6HffygSRcZh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VFSXRobEwxWFNnWFZCRExPcDRNY1NWMjZGenZuSUlwVnpyK205MG0xTVB3?=
 =?utf-8?B?UGR3cGpUemxSVWU4RnpiMUkwV051Nm5oYWs0Z2NOSjRQU2FJS1ZjOThqL3A1?=
 =?utf-8?B?aUhOeEowWlBNZHI2bWIxMGZsem9HOUFqZWowdXJ2ak91Nk5CSG1vT0NRREN4?=
 =?utf-8?B?UVM0Si9ETXdJa29Wb0t0ekNEdEZJVzBiMzV3NU1ybTlqMVppZmI3ZWxhRnU0?=
 =?utf-8?B?V0t2cEp6ZmNzS2NUUDR1Z0pkRXMwNFc0RDZoYlByNmVaSmxKaWJIM2tTa2xP?=
 =?utf-8?B?K3BFYXhvVDRGNis2WVNEaENtUGJUVjNraHdka1ZaNWtkWHE0RmpMS3diSmxs?=
 =?utf-8?B?RWRnem93Z0dYM2lzQ2xoaEtHNUdwRitwU0ppVTR0cXVNNmtXSUlaT29oa3dw?=
 =?utf-8?B?RjVRVDR1SVYyMTRFSXlyWDVkOXliYzVDUWNsT3BWU1hGRUNyRGR2K01YWFJm?=
 =?utf-8?B?bFpaSlRyd0lsaVczYitHYnU1Nzl1aUszNDgvbnljVmFkVjQ4UnVjZnNkOWFF?=
 =?utf-8?B?TzM5RFZteEpQYWsxVHJSeUJGeE9Gb1FTMUNwQmZGVkNNUlYwbFk1NDlrMDFa?=
 =?utf-8?B?c2c0T3ViaTZKanhqL1ArT24yS1RJcDJvZ2NMOXdKY1JiMFd3RnJUYWZtOU9k?=
 =?utf-8?B?NTl5Y0VmbGdobXVHRE9RajdYUjgxbVpySzhYTnZXU2ZMakZwUTdhMWtRZWRH?=
 =?utf-8?B?Q3M5R2RyaE5QSGR5VkFicTBSSUtydE9abWhGaVlqbHBvcGVlbml6MER5emF5?=
 =?utf-8?B?aC9yZlZsNlVScmRPcHhzVkg3RWtWVUNHaGZCS01xTlkwMkR0R0MxNjNEcUVt?=
 =?utf-8?B?VlRnd2NZZUZ1Z3Q0b044dFljSzkyV21Wam4vMDE4cG1HWWpSQncwVEFRSE5U?=
 =?utf-8?B?OGxUSjVnL28xMnM0NVpWZzNUbCsyeURrRWUwQm5mOVl4QjRaRXV2K1BOelcw?=
 =?utf-8?B?azhBdGZubTVRdXNudVc5MXVVR09LVlVNc1ZuZDUyc3JzMUhza3F6bElMOWNj?=
 =?utf-8?B?bjJDVU04bkpRSkI0QXpSaWdQdGtwVHgyOUtUWlZ4ZWxtR2xMcHJpbWp3SENl?=
 =?utf-8?B?OUFQZEYvYmRReTRoRzY1a2xiRC9KVmJFbmhQMGdNY3pRRktXRUJrM1dlNXpB?=
 =?utf-8?B?MmJYVHkyY0NyVlBwWVVPMGk2aVVJRkFUU0x4ejNocmtDMXpDMDNMUFNoOXhV?=
 =?utf-8?B?UHFLVGZHYVFqdmVpaHdTdkJXekhYZVdwUGkySFN0SS83WG1SZ3U0WDdvR3J2?=
 =?utf-8?B?c2s5cXErc1VlTGQrbFZJYnFMV0FuLzdCREpYYkpXdEZqL3luUjUraVkxYUJH?=
 =?utf-8?B?a0JSdXZiTG00Q2JrTmI5K3N3Y0VBRkV2aUVYMEhRRkpEYVh2a01nZDdmUXEv?=
 =?utf-8?B?dmFCdmE3dVpDK1d1cmZ1RmJBN29kNTBPQVAwbWc3Qkp2MTFBSVdsdEU1Y21o?=
 =?utf-8?B?S2pJT0h6UHY3T1FtbmJvQUhmVzFPekNQcWIxa01OTlM1YmNlSFRTb3J1M2hm?=
 =?utf-8?B?V09WRGRUa1IyNGRaSzQ4Y3FPVEpIREVhOW8xZHF1bEN4NUhsWXYzbHBnS2JW?=
 =?utf-8?B?MzVrc0pSV1hNc1pGbHc1SGFoTklmY3o5czJZL05aZ0x6eDhqVDArOEJlY1J3?=
 =?utf-8?B?d1RWNUk2d0V2SXFnRVRqZER1Q0M1QjBreWExWlBUdWJUUEFvMlFjZDBSNEpD?=
 =?utf-8?B?UnZsZk0ybTZkUHIvS2Q2eTFENDYvMEZRS2NiMkhtM1M1MS9RWmpBOWVBV2Nz?=
 =?utf-8?B?eEJKVmFsTnZDOG9ub3lRT053M3NiNTZHZ0VuajVaTmJRL29tMUhlTk1xQ2dm?=
 =?utf-8?B?NmtVSjlabUROYzZHTXc1SkloQnU0Y05RSXlGVnV2UkxjRWt1WnVSM1c3K2x0?=
 =?utf-8?B?a1lBTHU3ZERVcDNJM1BDeUxCNTFZQnBIZnE5SjV0ckVJOGh3Wi9PYUdtZnM0?=
 =?utf-8?B?RmViTGpOeUkwR0xMNnV4Z1hYQ1hnRUh0RzlZOHRPaVZ4UlV5czMzS2FTUFB1?=
 =?utf-8?B?dURmMmJBV01zQlIrYy9PWXZNcEtReXB1eS9zL1k1OXI3OHR2S2NTSWNYWldX?=
 =?utf-8?B?bDY2RWROeGNrZ1Fwb3huOWdTZHpVV3FDcFNQVEVEd1lzbnJyY0hEZVlnS093?=
 =?utf-8?Q?cwiegMOvJHpCbpS76JKdTOIxf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f0ba1f-befd-447e-cdc4-08dd2bc24e13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:09.1273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +17JeAIP6H5YIdRL3ZiGMpzJLFdVNX48IZAsCdW8geangG0/6oD01u5ziXIBPekggOw/PablIVoQbDV3uYWzQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054
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

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 6cda1f00df1f6baf6db65a28b4cab114f8540a4b..08c86a642844570424dddbfcf9670d1e6757d8d1 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1044,4 +1044,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.34.1

