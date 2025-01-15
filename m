Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C31C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B6280214;
	Wed, 15 Jan 2025 14:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n+a6GTHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBE680040; Wed, 15 Jan 2025 14:29:32 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76219806FB
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1YjIUS7uPl8XYtganCQPlt6SLkvXceA8+R2yrEn+DQ3VpQ3zM6iLMijGQGo55SPw6PkavH2n4m5NSNwE6QgEe1h/9qh1jPZnx9A7r75Y6v34X/aLNvcyAS9PcPHXSBFXiVqqw+H7+hSGsol6LI9nXO6GPNfVvF8oIJ85zMo9GDP7Qks4ffW2Zo1Z3Tv9v9EkNP4/vXsIIufFYu+RyI4TQLbVQwRreumXCPh8V72roOgZuirrZoBopAcvDSgKU0iP2ahq8KmW8VFeKErusYf/dMuldzqIMohyCFK35y+NBEjavvESvPTaNRsgUVC1Vt2VyiS6E6SnLWNVdqj5ei1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ27QUNb4XMZA14luYXRGGDYS+j7R3pB5YLFWAgcKe8=;
 b=oPYvSLlq+h5RgggXORJVzR1kMqCYICmhJ38Twm4EPH9PeG8YasVicIIyf68N/HvgXvEYD+XDqN3ZeVsGHQRKWAZdy+zAFUP14afbl3/jdED1I/PDO8kn/u6wviuWuNPA7etzE+b3+LLWuwxmy7EYQuKfnIRG/yb6gG5pMrBZvYgBL7nBV5cwh/icmAB+Ith2KwwSpRrk6gtHSsAbFBPOCFtIi1VAAO4N9PbsDw0Se7nOr2WGMmZL5ArGAgFucEYwTxw7cQftC51h+rUYv1G/TSpzQ883eWLtf3F7UNtUzcpK7SFOpRktdHomUdlXnyRjJYTuY8nFrdpXsz4BqsRuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ27QUNb4XMZA14luYXRGGDYS+j7R3pB5YLFWAgcKe8=;
 b=n+a6GTHJJn0gsVWDviC3RorcyF95lXd9M0qZ1P5phZCg/yWxPGYBbZe1+pJpCIjUZMT6GAM4se9J0VGIoFOPYzvW/LzRi/Y0gJziQ7l5SOgeKlEfCMjv7DMCTnQSrAVo2AzEsIW2weWq0OKAlqoSYmdc/Sjb8J2v29FM/wwUT4YnbvQTveOzmE1/YQVfC2A9zcXW0WdGleNWC5+a8ZllJMhKBu3LbKjRr4h6xI2Riuda3MmDoU6RBARPZNmzLu37xG3vKJ0lfsLf++dFkwusnm+WJJaYd6V4LzI1/3yB84kULAd1Iz0DcyOPc83WrmJVOp6AifkDQZKz6Ne4hmzW3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:28 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:52 +0800
Subject: [PATCH v4 05/20] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-5-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=1124;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=EB3jfllXXxvcutkNsraldgKBWYZpnS1lCbBAdD2GLIY=;
 b=ATelcu6hdrWJgUNWCoLETRWsJOASrSUpoy8fsfZP39Kpp+Zx60th4wBY0WBHAvobmQA34bHIy
 ciC7MHOoFNGAnNvZgJFekAsMIZRj24z9y57WLv2IYogUuaSCSBMkCWa
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca31f04-f55d-4896-aab2-08dd3568a327
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEk3dGptWC9wWUZRMTg5VDhoYi9VdnJhb3hMNVdVN1liQ0FIUTZVVEw5UnFt?=
 =?utf-8?B?cC95K0M5VVpRd2hsRVJ4VTgyc0pCS0U2VG9yRFB0U1ptb0RFdTEwanlPRmhY?=
 =?utf-8?B?dE8zN1kvUnh0VlRyWFpmcXBKVGdRYjRaVkQ0TEtxbXB2Z2RYZWxsOS9TZklx?=
 =?utf-8?B?ei9qM0VBNjRDdGVTNUpXNDRCeFowMmNUZVcvaUFMckR3b3lRTkV2ZU1LTlpy?=
 =?utf-8?B?UzN6YVFndjJOOFFjaTB1eElVVmgyMWFqaEFBZmtNRnNJK09Qdy9VS3hMZUN4?=
 =?utf-8?B?WG5PRTg0Zm1GOWRtUUJzaWNKWUg5Zjk3bVFYYzk1VUh1ZThiWjMxTE5UekZT?=
 =?utf-8?B?VGx6cmpYOEdkOU1EYmlpTkt6L2QzVkhGYXY4UE51QUtsL1R1Q2E4VURNdFBj?=
 =?utf-8?B?VmVBN25pejUvZTUvMWg3QnZNRTVxWTJHWVhUT0ZDeDRINTQzQ1VKaGVZTDd5?=
 =?utf-8?B?S28rdmxNcFVDWmFZQU5oei92T3JteTdncVpnSkZlUmNKT0wrSFZReEdFbGt4?=
 =?utf-8?B?SW1rVWRuRng0L29QNUpkeDUxUHQ3NXJyOTVsSFBVMHp5WTMyRExDL0VpMTd1?=
 =?utf-8?B?QWJLTXpHbGpDTGZPVCtkNjRRWUJyTy9mc1dBWUxmUkJqR2FEa1VlSzA1ZXRz?=
 =?utf-8?B?NnFEZDNiMDVnc1NjUWhiTWo2d3NyRzR0OXRkbE9jNnA0VUFsYXpYVlgwVXVP?=
 =?utf-8?B?K0cxMUNDVUNQRHBuWE41THJlSFB6Nnh6SDhSMitpbzZhbHlFWXlVSW1CU0xJ?=
 =?utf-8?B?aUVLTW5SQllJNStidUdjeTd5NjNQYlNpWWFBcEY3ODBxSXd5aHBaN3U1eE81?=
 =?utf-8?B?bldrTWxRdWZhVkpLMndXS3lsR3Y2NHhTTDRyWmFCRWMvY1Z2YTZFMEltYUxy?=
 =?utf-8?B?SXZ2RWFtQzRac01Yb2l1blRKd0ZlMHVXR0ZaRmdNM0RZZ2FVNzI0MEdobFU2?=
 =?utf-8?B?alpXamU4VTR3Rnh6VytweXpIR0ZoMUFiVzRlV3Q3MHFtTVZQc2tKQUtrT005?=
 =?utf-8?B?S2NEYnFSa252S2FWNDdCWldDN2h0cytYUk1zMmR0VjFnQVZLdk5UWjZlNURu?=
 =?utf-8?B?K0pjOTdvWHhNZG9aSnEranZoRE1yTExKRFpteFkyT1JyNTZMWFJFY0kyK1cy?=
 =?utf-8?B?anJvcW0vY09ZYnU0ay9WdFB2emdGQVJCK25JQzBMbDR5MjNXbUtvYWFJRkto?=
 =?utf-8?B?a0ViVHNXUEhPdFRRU1ZRTm9VbUVINUpPb3pzNWRIU1RDaDN1Nlp3VGdPTFlp?=
 =?utf-8?B?ZG4yVVNwOWpOaU9GbkJsMHNlNE1vYTdBU3ZEbVNBeTNlS3l6VmtEQkt5SjY1?=
 =?utf-8?B?NFIzSnYxSTZmYTE3SU5zejI1YXJZMUhraU9zY21yYzBZKytTb3VNYVNKY3lh?=
 =?utf-8?B?ZFBFWUVEWmRFQ25iVG4rMTBLV2h3YTBHTjQ0bzFFMHhqcHg5TVYydUdKUlZh?=
 =?utf-8?B?SU5Zc2FqZ2lsWTUzQnNXUnYwdytxcnVIc3ZGTHV0Y1ErZCtGTXVJT25nRWtm?=
 =?utf-8?B?QUJ5YTl2M1ROVEh1dklmZm9CVUdLekFIdXMxcEZ5bm90ZTVjQWx3WG5yVlRx?=
 =?utf-8?B?aTIwcjUyazgxelNySk9aVnVjN2hFU0txOWFkY20yeVRPY0RtWTAxUHVzT2dn?=
 =?utf-8?B?UW5VQjM0OWxHeS9VKzhzaXpRYmg2RURkeWNiM29Xd2s1SHgvdUxTSGM0MGxQ?=
 =?utf-8?B?V1M4VkdBbFg1K0JHTmRLZFJBVEo2bThvaGszNWV6OEhXSEdjZjdWaTVvWEJV?=
 =?utf-8?B?TEFkYTFiQThRM3VTMWkwRHMyeUNkYU93aTVRdFNjQmtldEpMU2kxYm1YbXpO?=
 =?utf-8?B?YUVCazFscWFveEFRam1IWDZRWE5wS0VOcGhQczVKVVNVSG5aRFdFOHkzaTZR?=
 =?utf-8?B?Mmt2dVJ4ekxIL3cvT3hHQ0hNbHp0bE1BQnhpMjZublBhNitDQWErUUd1aWRk?=
 =?utf-8?Q?1Ary/JLT0sXIRKr9Xr3oXiJ0WhYC78vN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEx3MFp1YWN1NTBZZkZwOTlNTHJ4YW9jbVZWN3FXNnlHWExTU1lnWHhEc2gx?=
 =?utf-8?B?dTRrNW5JZE42OUNNdHdzaS9lVzV6TkEvVGlyUysyTFR3NEQvb213clc5SGdw?=
 =?utf-8?B?SlUxRkhXazA5MTdQSFM5Ymg3elNRMXNzYm15VkNEczFObnB2Y0F3ZmM3WG1P?=
 =?utf-8?B?RlRGcUFSaVJBWVhSNTBWOE1LemxRSFRzZFZRbytGUURLVUNsUVhXTHByOXpC?=
 =?utf-8?B?M2ZtQStUU2g0Q0F5QXFVUnVwa0RkQklIdlVkQzNja2E1cmtFNmFHNVNnYWdP?=
 =?utf-8?B?U1pPQ0JYbzRaOXFBVkVENGJPaGlBYVFoc281Y1BnTFJQSC9xT05zUGMzMkZ1?=
 =?utf-8?B?am9jZWlsRnZjajUyaStXQ0ZRS1VpQjltYSt1VTkwOWMzdHNFRzVMSFROVXcw?=
 =?utf-8?B?RkI2cWRLQmFYSmxMckttTkxyTFpSdGljZHliNlBzV1lNK054YllRSEphUWZH?=
 =?utf-8?B?MlRjd1N4MXJWSTJuNkxYaXY5bTFJdUZWRnR3S2gzYit5Wm8vdjFJWXV1dHdO?=
 =?utf-8?B?N0tZQjRkYUdyQi9wVVdIRkh0TGtpZzlxRFFSM0pmV0VZOU0rMkN1SHJGc2cy?=
 =?utf-8?B?VzlqTk9JdXI1c1RzSnczYjcwVmhoWG1SMmxnMi9iZFBsamRYTTl3U21FN1lD?=
 =?utf-8?B?RXpGTUx5Yk4vOGpocURBM0NXaHZFRjJMMWovSzViUWJ6UHM3S1RDMVRwbG5m?=
 =?utf-8?B?VXhHazFTRVlBbjNqWmFQVE54aFNzOFRmcmM0QTYyYnhjMytnSlA0NkljUU5T?=
 =?utf-8?B?bDViTXMwdjhFOHkrT3loNFhtL2x2OFRHMHRCcVN2UkY3U0xZNFZHek84WVNv?=
 =?utf-8?B?clMrZm9jK3FaS0pnZS9mbG5WYWRCLzRRZHBEVGtyaTJFb1FWSU9iaWVrWEZN?=
 =?utf-8?B?bHRQZ2M4aVhMajVsRnBLSVpCcXhpMTBiNkZkTGpWdWZxUzFJRUdDYkR0ckc3?=
 =?utf-8?B?T2NSdmxDeGJlVmtWV2R3SzZya2gyMERNVTY5QjhHYWREVHVQaUlUTFdpRlJ2?=
 =?utf-8?B?ZHlBMldlbXRpZUYvOExPRU5UZW9iRVVZUEZyb2ZFcFc3Y3R6dG91S1MrNzJ3?=
 =?utf-8?B?d2ZaTTlWd3NVMk5TU08yaXFUMWkvMmhDOW01aWVYMDlzeDVteHI4alYxMGRy?=
 =?utf-8?B?cUNkTDcwbExET0xjb2Z6YXlMZCtZNDFFWm1SMFdnZ3dybmdiU1ZRMG81MjdO?=
 =?utf-8?B?NTRVUnp1R0RvMU83RFdXVFZ1MGJYcStXSm1EcVowWWliSjRyYmFSdlIvOTdG?=
 =?utf-8?B?aVRzRlQ4OS92bklXMi9oWWZIbzhEem4zUzhHNngvNVhtWjVkQTAvcjV1Q3NR?=
 =?utf-8?B?U1hNdXc2M0FkbDlSTWNGcTRlNUNVN3dDVUNlOWw4TzQwTFBEZjJuUEFBVTds?=
 =?utf-8?B?SlB5aVRtdHliM1o1Vm5GNkZJZ2MwK3ZTS09KUGFsY2UrbXF2K1ZzU0U1emJL?=
 =?utf-8?B?a0tjNHpNSVd6emZuUmVMSG9XVllUSmpHN2w1YXlmM1FvZllreWdNTW9FMmFS?=
 =?utf-8?B?VWErT2lQRHZpOVp0cVJJS1JIYWZLa3kwSlM1L3IzZG1nM291WGt2OWtBSlpt?=
 =?utf-8?B?OFZPb0RqbHBEY1FsSkwwRkQ3ZVQvQ2xHOXM2UlFFanVUU2k0V3JGaU9jUkNh?=
 =?utf-8?B?Uy9HT0ZZU2RaMFdwR1dUaFRuSGovRXAzNi9nR29nR2xBcEpJMEhxQTFGTzRG?=
 =?utf-8?B?a3pYUnBPYmlmbnFPOERSazBzY1p4cHQyUEIxc3ZOSFEySkVFU1dPQ3p6M1h0?=
 =?utf-8?B?bUFpeU5mWkV3OWlZK3JVYy8rZm9tKzkyaHdHQ1VNN1B4b0R3VlNWa1RPOHpm?=
 =?utf-8?B?aWpJcHI0aXEyZUtXVkJGUzNCYUZqUmRVL0MxYk56QXgzbzQwUHdzM3RTS0Nn?=
 =?utf-8?B?WHNjeDAwZGk2aWFFVTEvL2pjTDNPZ2hJeStLMjlOVWF6emdCSFhMZWZuU3pM?=
 =?utf-8?B?VzRLMlNVNXBwTjRyalpVcHVtUzZCakZQcmF4WW5aRVUySzM3YTdLR055ZDFV?=
 =?utf-8?B?elZSMFBFMEZJUUo3Yzh5MkRRWm84dkQvU043Lys3b2lWc0JGS1RnL3BqYUNw?=
 =?utf-8?B?aVlDRTJYd0xXOEVwWmd2MnkzamMzUnkwV2NHcUpiQWFTWHZ6UExCeHZDNFNL?=
 =?utf-8?Q?f5bGwfF9VUcxjUihs6dPfu6CJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca31f04-f55d-4896-aab2-08dd3568a327
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:28.7867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHjpe+0X6a9Llt/BReHYLEOBJEjK19ddXuGVMs6QQcxgYWhtOfLFgNMPeqbC0XUcdX/rsqt1CiwV0Z7lsBpdPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. This patch
adds SCMI misc protocol protocol_id and message_id for getting the ROM
passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 2367467512a6b65253317e51bea71de396aa96f9..6cda1f00df1f6baf6db65a28b4cab114f8540a4b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.34.1

