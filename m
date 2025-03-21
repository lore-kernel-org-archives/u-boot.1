Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AF3C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD8881E5A;
	Fri, 21 Mar 2025 08:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S9vuRQm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4332E81E5A; Fri, 21 Mar 2025 08:17:15 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C1481D3B
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3KDZ/rRefmbXV3CCrQi2d/fzrG6m0fFNpXcwtLVgWFswvxp8SSto+tlVKgmDC9Foq7KL+Id+dFkZmOJ6Lao3HxLejeLFDVYpFgquXAqA86ncRxBNNCDYbXhuWRT8Z+MPKqVyRpMhurr7ACy63GjPiqOwz8zGtagCHqmVRpNLoopgoX8fSvt4DgimUj5yE4PM5YSj6MUpr5qBIjXnXj7rw4iO2oYaXSnwsUi0NHf+hMk8KDa/vL5ZHdt1snsGdfrVsX5tC8mkA58zfqOAeCEOy2s3Vr4DMnCtQaskDT4gRxDXAIydaE/bcN4iavF44NImXrobVQN8LNMv4ILu1gXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EcR+KFzb/yqdmZzwWQ6VkO3KAigncwovmB9OUR/A+g=;
 b=zNNaR0h+LrzAI+6IHR69mu17t8mK1nYFGA8b/5TJK06wPBD4ujMgcwXtouBa0HkPH9kkKsOffyFDUmkzf9Rcm4Ic8JlxKbpqgV6F9myk74iezyb81wY+g2gm1QnyueHnuEVMvctVSQGf/8924gX80xh/nd9AgEQkHJwutx8EknHAM3DpUlT2Xxz7NmvNqgl4sohggtEXoTpHklvdTz8q8Tj4qxIggCdmKasQXwEJJbaEDGVLKZ+QdeHytzOZlueC6qdE6ly0ZEeFba4DRB5kwVrqRX+jfc8VccNs+MEXxiQPzdyzlVi7afHcR/XT7MJ4cipBHse1zx9QWdxh29PwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EcR+KFzb/yqdmZzwWQ6VkO3KAigncwovmB9OUR/A+g=;
 b=S9vuRQm8sQF8UwXdQaI0Hx+OdvhUdmSaIItN86ouPsHJPRMHSwqK+dfjdd3PwnWOYy9CJWTPUyvEdU3uCUPJ0wGbGg9h64qF8F8lOLHleNY2t8VMXcKuNYkr3mLVq07uCPSjbodXSgxwbm3lhb0u+aw1LkfA4PBWdsG+sIg9zXr73rJf3akMtYNw4anM7qRbH+N6X8cO2UP5dALD5cr7dJKUsUeT9MznS93xMHyKA3HZkivdqN+eI//8Os+xif8kIl9E9yx5L5PEKv3wUcVyuDqPsqcz+f4VP6Qx1vouRo+pgLvZmF8gonAHv5MkA7F/IKWsnM9BY400hCNDEkXPaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 07:17:11 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:17:11 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:33 +0800
Subject: [PATCH v8 19/19] Makefile: add some files to CLEAN_FILES
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-19-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 3613a3ab-abc2-453d-2531-08dd684865f6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V04yZHgya0dWZFMwMDlYWEZnQTViZElsY1J6UzR0WmpCTmtEMXErT2E0Qk96?=
 =?utf-8?B?WjVBa0JZVVRQN1dpcFhyOG5lTjMzNEdCZ1l6ZlBvQ05ibnpSSkNLdGtPRUJ1?=
 =?utf-8?B?TjJCUGlMd0hBQjlONlNrSlJWRUN0bUJEWGM4R09qOVlnUUpSblpzMm11bUw0?=
 =?utf-8?B?Z1ZFVDdCMEorN0RTa2pzaUorcmZMS1JMcitJRGMyL1N6ck41ZjNwdzM4N0ZO?=
 =?utf-8?B?U24xeGRkQjNyZC9NRFRoSDliUXhaRWk1STBsS3dvZEVsNVFWWmxLMm5qc1Z2?=
 =?utf-8?B?UW5oTHhrSWtRWWF0VHora2VJZW5LVS93UnRtVHczY1JQSE5SUVJQTmxyT1ZK?=
 =?utf-8?B?VWtTZHJoeEdZelNBcVlVblhsYmNaS1RlRngvWjdRN0FoSXkvajZ5TXdPWHlz?=
 =?utf-8?B?RlhscmhLdHlSdG5BL0x0cXVDbm1FSjBSS2J2TktaSGpVbFJkTTNmOVN1T0Qv?=
 =?utf-8?B?MXhLYnErVmljTjJzeWM2bVFlR3NKOHR1RDY3OGUzWjNDRzc4c0RGQ2hVZjN1?=
 =?utf-8?B?UGZxVlVNWkNVTHl6cDhxclY5TXViblNJVWFKTWZ5VEFPb3R4MmVnV1VaWnFO?=
 =?utf-8?B?dWZDWVhGaEEyWlpxK0dGcTVDSTBmV3dkSUFFSmFXWnd0N3N2VzF0VjkyRHNa?=
 =?utf-8?B?b2FEUGtKUmxXN3dKY1hJSmcrK0d5dUJtMEJFQVJMU1Y2a2drWnNjZ2R5V1BX?=
 =?utf-8?B?K0hVU0w2YzVjTEZBcy9nNUQyQTNJbkpTYStLenBEUFlRRGJLR0U5eUt0V3Q4?=
 =?utf-8?B?eEZoRGx3SnI4bVpKaFNId0FpMDgrQ1NvaitBQUtXbCtBRVl4K3hyMkwvSHRk?=
 =?utf-8?B?S0ZCeWttZVhZV3VDN01TMVVPaGI5T0kxT3FaZTZBSHVhK1c1UU93aXNkdHQw?=
 =?utf-8?B?bFhOV1lDeGlQNm11YTVkaGUxWWk4NVJ3UjRLdzVoakp6ZnhKejhvVVo1VHVN?=
 =?utf-8?B?amJlbGJSSUdISkJIN1ZZVHhYdVlCQU5FdVpGam93cnFHczVBMUVzVTBjaWRj?=
 =?utf-8?B?NUpOR3BOUlRIN0doTUs4N1lXZWdxZ0Rka3hWTS90cEtPQnp6Q3kvZU1OQzlj?=
 =?utf-8?B?MTAxOHdQYlRjSXIwMkhsUnc3dHFKYjNmYTVPbzljbzVnM21CZXhUS28wUUFO?=
 =?utf-8?B?SmM5cFV3bDc0ZzVrNlpDdUtJVk9KanY5N3JuNk9HVjFVMnlBODUxUXBCU1pO?=
 =?utf-8?B?Vlo2UTEvL1hYdUxqL3FkV0haQXhmZ2hROFoyc01OTVZyVHN5UklFNzdCc3gr?=
 =?utf-8?B?bTAvWWJiUHhaMTI1K2ZuTktwM0lYampvWS9UUzYrdkF0R255UEFRZ3pHV1NK?=
 =?utf-8?B?TnB4RCtzUmxtUlIrRGNNQ3NHcWtKKzY5MHczYVRNOHg3am9jSWRFL3RuWGh3?=
 =?utf-8?B?L280ek1mMVhnVmJIUXN2VzlPcUkyMEdjbkVyMGpFS3pjOHM4UTE0STB0bTB0?=
 =?utf-8?B?Q3B1YnUyQWgwZWlCc1VScjNLMEExM3JlTVdMOGlWU0RhVmNTZFRFVGY0aTY0?=
 =?utf-8?B?SGw5T2FKZ2REOUIwRy9iUVpRa1ZGQnNoOG4zWFg1cW5DM1VadW1oNzVjYnMz?=
 =?utf-8?B?bFRDSjJwbXFtUlFCaTM4WWI1TWhrZUpuMks0M0J3R3BsbWFkK2lKQUNDdzBx?=
 =?utf-8?B?eXFlbXVJLzJaQWcxOXhmMFZyc0YrNGZqSmVyb01WeDhkZ0tDY2xjWXFmUmNS?=
 =?utf-8?B?QXA1NnRzNnpCaGRMMnd5dWo2RlltMk5idEJOODRIcU9OcVFwK09mR2lxSVpJ?=
 =?utf-8?B?T29MT2V6SnNORG1jTjBXcGEyVkhjZDArVjRLSXkxZGlGT2R5cGFzbWJLOUZa?=
 =?utf-8?B?NkVVQUlxaFlaS2ZJQldKQndTenN5TGNsbDY2b0k3cWlWRDliMmdTUlh5c1Zn?=
 =?utf-8?B?UHpZTVFWaHlsUUdEWjNYUFlwcUo3aWRwYWMwekVFUzZpRE9POHVQU2xZbUp3?=
 =?utf-8?B?UDZ0Q1Y0YkVQdTZvTy82UE8wb0J5Tk9XT3laUFh6cngvS09hcFhuSk1WUlpy?=
 =?utf-8?B?K204eXhKeG5BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1d2Qm0rc3BOU2hLZGFGV2tjQnBORWMyU01KYkZsemhLOWRpd1lqREVVckxQ?=
 =?utf-8?B?Rkg1NENzV0NyRnBSYk9lanRFZlowUWJITUNlYVhIb3psTjZZT2VEZmcvOWJF?=
 =?utf-8?B?NDlHRWc2RnpZN3NpdzlNUkpPTi9hSEFuekF6UVBrN0xOU1BoTk1QQW1PQzlu?=
 =?utf-8?B?ZFp2MTNUUC9SNXZhVHdzazNGaGJSd1QzWE01V05pMWZsRTc5eFJnc1FBbUdO?=
 =?utf-8?B?NHlVcGFDYTVkVzJLY3N5N2lHOGRYSHVZWUtLWWg4T3VYdmJQTzBMa1VwTlNj?=
 =?utf-8?B?WS9peWJEbTNFTkJ4ek50bFNCN2Z0YzFZRm1ZVlFYaUlMQ1VNWmxwaVYrZERL?=
 =?utf-8?B?R3BEai9rZVVWeWMrTFAwNGJDQVZnN29mZEYwQ1JRQ1B2TDMwS3RTd3Y3YnNp?=
 =?utf-8?B?SVVSNmdJaGYxWFQvQk9vNGNWSVNKVkZ5VWJuZU5henlndXpwY3JUMmNSRWVN?=
 =?utf-8?B?VkI4dkxTcEpYTkJlVmNsNGJJT0g2V1N1QmRWUkphMFE2VkRGVmM3ZFhzbFZp?=
 =?utf-8?B?Tzc3bVlHY29WRlpmWmc3b0NVSUlHQ29RRWhDeU8zS1pieUVXZDlGdHZpeFdO?=
 =?utf-8?B?WFg1aWdsSTlOd0ZTTzQ5Q2Fod3ZKUWw5UWRaeEIwUzdrYkQ3V3BkZWZZOXBN?=
 =?utf-8?B?ZkViU3pMMndFUmdlMWJ1VDhEenpHTE1ZV1lqQjVsai8zcUVubzllUWNKSUN5?=
 =?utf-8?B?NG9Dc1R6YjJveUN2bTFQR2Fva3BmYjgvVEd3NHVaWnl1azNqb2ZOOTNlQVJ4?=
 =?utf-8?B?M0o5VnVsMFFkdUNRVTIzZVI0c3phK2RHeWZ4bE9xTEVXb2ZQNjViMm5GUWJI?=
 =?utf-8?B?ZEJIOTM2eGh2WDlaUkJlWE9mMVhZekl3VWpNdVhZa3FhTGZCcVQxQytleTRm?=
 =?utf-8?B?LzJhQ1NabFE5UVZUdnZCWm9rSDgxTUd2UWpwNlo1Q2EzNFpLeFlUTTdydE1K?=
 =?utf-8?B?ZVMwc1BDOTd2Vnh3dGpLOVZ0STZjMXJ2SFFWYngrcHg3N0F5d1Z2RE8zSjJV?=
 =?utf-8?B?eHB2ZHQ3RFU4RWkyZUZKWFBZQW0yajg4TkdKcFhCaDU2WlV4cXhsOXM1S1FQ?=
 =?utf-8?B?QTB4dmVDV1lpT1JocEhna2s3d0o4bmxETVVTRHBkdFF2RzM3TVVPSXJobVQ1?=
 =?utf-8?B?a1l1TFdwdTFjeUFWd0JvekdHM0FVUXdVOU1vazJyOVNnVDV1MjBSV0ZGMVZ1?=
 =?utf-8?B?Q2o2eDJXZFhlNDlaUjkrTjJtTFhVWWZadWVjQkgzTXJFWVdYMFZQNmZjSStl?=
 =?utf-8?B?U3Q5dVkzc1RaSlpmOTlvMkpiOW5ia1IycFdwRUVIWlJPbmowVHVUMHA2T3Bq?=
 =?utf-8?B?VW9zVUNjcXkza2FKRlZRcTRORlZmOCtrUm9JZ2lmRDBPL2F2d3FoTmlMcVBv?=
 =?utf-8?B?MmlzTXh1Y25CU0MyVlBMdDdza0NtS3ZvTUZ3cFdaRnpCdmV1VTJwcURocFMy?=
 =?utf-8?B?VHJjT2hsT0U2NlljN0tLbFNMa05YM0FKQUpkc2lYMVNYRkdMQlNXai9NSTJ1?=
 =?utf-8?B?bG92QmVQS0FHb09FdHJ6NVJrWEdjVk53SmUwTHlDcnhRUDJiMGIxdlZ6NUJC?=
 =?utf-8?B?K3FrOFFsY0NyWkxicVZSTjUxSWFrRlJlSk5sbGo2VmtCN0xDODRITGJmVWdD?=
 =?utf-8?B?RzI2SW94ampySE1JeUFWRUFpNzE3UHk0ZkdUQXYydm5aZU1ZNThQOUpIeEc3?=
 =?utf-8?B?U3BoWXNPR0FmSW9QdEtjamY3YWhnREFsZW9EVFVxeWF4bml0clhsblV6OFh5?=
 =?utf-8?B?U3cvTDN4aFBmSGR0V3NieGc4dHQwUnl2YVh2RlVoRHNrTkxaemVZK0U1Qzcz?=
 =?utf-8?B?RFVicitWdE9jVGpLS1pDK2sxYklnTmNFN2Z1RU0zbHM4RnhPcFgweUxqWHVp?=
 =?utf-8?B?U1RzVjMydFJQVjJIWW5lbDZINmkwalJJVmpIc3NCZDRJdTZGUXREVGJUVlh5?=
 =?utf-8?B?WkZ0SmNlNXI5N0V3LzRuVHpiVGVrSU1hUjNMa1lKT0F5alpzOUVMK3MrRkZ0?=
 =?utf-8?B?UGR3UlAyWXhTbmtZdVBzOFRoaC9HRHRDM29obUhFaHZEYmZ2ZHN1UW9ZV3ZJ?=
 =?utf-8?B?NHAwS2xvMUhHTGZ6K1NkaHBmM1daUVRBZjk3VVdGN1cwS0V1QlZ5KzQ3Q1k0?=
 =?utf-8?Q?HH8NZII/c8X/L5Zooj0QxfkYu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3613a3ab-abc2-453d-2531-08dd684865f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:17:11.5112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjnMKUiZIpPzuvigzkSCIi23K9eA4cn6A3Qb0sx3wFce6qrto8QTDA5Jf78M1QzWsHfCt1yMMQ/77upJAjryPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524
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

From: Alice Guo <alice.guo@nxp.com>

When building the flash.bin of i.MX95 with binman,
mkimage.imx-boot.spl, mkimage.imx-boot.u-boot,
mkimage-out.imx-boot.spl and mkimage-out.imx-boot.u-boot are created.
Add these files to CLEAN_FILES so that they can be removed when running
"make clean".

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ea6ca427496..cc02c8dd59f 100644
--- a/Makefile
+++ b/Makefile
@@ -2229,7 +2229,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule*.*.efi-capsule capsule*.map
+	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
+	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \

-- 
2.43.0

