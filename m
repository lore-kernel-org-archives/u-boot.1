Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAA4CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9178B848E2;
	Tue,  9 Jun 2026 09:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aW/tMUO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BCB848C5; Tue,  9 Jun 2026 09:19:43 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB39848D7
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deEdkF6qPWQOiFbENFas3qafYtWxySjy7XZcpBLFGt8Qv442bCIxTJKl3Sxqn4ubPkh4kU1bkCix8jn/PosIg4o6LjZ/L/cD970aZkdPvofPG2gvnERfch8JllUADgGj/TAELJ9yp6v9f7N/1EFG76yyMMy36R/IZ7i+DAGhn9mUC8cw7tFcq6Ow4jZvGVTfYFfE+dBFantlSnGP4SRhSDx4vZPQjiVQ2/Jer9IaTrXBef6uo+iRGmLf4n+477iEHBbucVSFF1tu7KkNdrU8l0CjkhogHvw6/VU8mhYqZiApZHWzFTJYGUspQuzgOt/lgCWVPk2EZX6o2HzReAMpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iq7c5JUJVwNbvF70qPjk7UatHCyE1agF/mgoMr/xqU=;
 b=aT5FwdP8pzSuAhzbD17OnGfx+Eg8viQnn2GsaKyt+nawap2yOjEouV14Ux3OUPt10LlZp6Rx2vbTzxAlXLnFRPgAwKB7snddx4ORToLSu4jxrRUs6j5yZwv4n2nPgZtDqy1/Sy/XYCS3GTmbvRMNo2TDHTiLgDg/8VhFAHtyK9ec5qs9dWnBEYYpTOxA8sFK7N23DPxBPpmRb+vAzmxFifqnr1vJwBZOKY3P6Htvw3e1YuOl/KBcukRTmDyG3MA/Exx+TbBj0Qf0sHwoLp8GlMA8sLHe8xaS24BgNPOHALPRRO706rCzcRNcqk+cWoDDoPnP+pIoZYokYKqPipqjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iq7c5JUJVwNbvF70qPjk7UatHCyE1agF/mgoMr/xqU=;
 b=aW/tMUO6DCubirET9usuM0kEzQ+HRzNpVMwHQCaTRiaFdHQWdnYYVNLtxNHGoRNxmZqqsXV4mrR2t5uVZb5gxfw2kiVFYxOD/AhZ1Eo/QIw2UmmsmjzCvw2saEHz5hchikV7vQHr5LH5nUpwwzUJbDg4a+YSvMhXZ5s2A8pgyjFo4n61fqaPpRs/sasBij/ztJ1Or0CricT35Mce8czwoIUyWDtkSOYX7HPG1hnG3gJ2vRoRl7VEq+3YPt0fev2vMa7laZRu0ateSpTxTHiIxSkvi5KsvOg8w88Yc5po6Chui6MYwSTjUO7MHmvtRtIjnpyk9Vk/Prv7pwule+aFdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB11546.eurprd04.prod.outlook.com (2603:10a6:800:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:39 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:30 +0800
Subject: [PATCH v2 13/13] imx9: Select OF_LIVE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-13-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB11546:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2ff014-6f5d-49bc-97b0-08dec5f77826
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 7mykLkZedPbSINsmmAHQc4phR9yVkRp0JLVk7aSnzYiFeC848REGUH6V2pbY7DXk0VN4acdA+7l9df7Lw+XXyEdS5+0DogCyyH6iyEHEF6M1TcUDHxNSNtxnASkKxaNp8f6hOPe84wM9TxvenKJ5iRVzpqeFMLkskGZn+mrZMEv36G7q0Iy9NjkBCbiwd8ca5K+fRD60OP+gPeryYHWJBxA44ZgpdSOTRXR6pqtlhb2B8E1stNgv1Mi8sPJFYK0XqA0gRKHJMoQyAOK9hS2ONLD5qkf1PGQnC+hxs8e35JBTfx44qosk2Mtqf0qdN+cZ384bEtvq+LePBbqUpk+zxFh1M8JwCqJPX4eQ6L8Stkbf+OiWEC6n332eQwj/2NqT4VrQ30hQH8hGcg6txkSa5Ub6uuc4bVo2/VOn6E3dB3TqZGxVqJ7YKCqc7H9ci5NF8/FhIPYfSZdn7V3+CnjsoYag1l4cw6kVFERqJrmQvhic2JIcWInQjkKRvZLVup/8Ei8L6l8qwbr2GxU463u4ElKVHgSYCdqad/+4h8mULjpXFrSlVXMyUSS7e4vcaetwbeoRsKHllY52tPwypndbJ3v/RGUwRKnqLAVNmwb245E0lM/QWHMsaUzZssQ/6NhEvLB4LZVpzVN1jstzF/6THJjdyogXakTbngWjQMwcPzBFsNOcAQdXZZ9yxt2ui2d9lwosDUR3cdxtRe1uUD+knUVLaqxlwxA/5H1gKD7GsqVR64sIxj2c/j7kU9X5qj8v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29ORTYrMGZYVGdvbHFZQk1kNHdxRkFxVTVqYlpnZUVHUHlENGJ0V3VmMkY5?=
 =?utf-8?B?Z0w0eW9JeFJsY3RYNGIzL21ob1Q2V2x0S3FZQlg2NDRKcnhJc3ExdDZ4K1Jh?=
 =?utf-8?B?WUhMcVRIQmhYeTc0ejljSFQzYlh5c1VWUmRJdnRWWFJhVTNvNUU3cktBbHJq?=
 =?utf-8?B?TFdZSCtQMGVYcXY1dVUyRjVTQWs4ZCtFU0ZGY043L1RLbWZMa2ZQM3BjbFdN?=
 =?utf-8?B?WmI4V0RGU2dLWGhHRTFVWjg0QStac2NpWjdTYWMxM1YvVllZSDlESjhrVENH?=
 =?utf-8?B?bG51NmtyM2V0eWdaYmR3NUdtRm51UGppS1N0T0xHaEV5TlhDWE9SNWFpRCsw?=
 =?utf-8?B?SEtoK1ZpRUUwSmh3OU1peTNBWDZkMy9NU3EyNU1sTE9uVURGRi9QOWJuVFBK?=
 =?utf-8?B?QVNtdEV3eHcwRU9UaytSM1k4MzFQTHlQbHlzQWF4YTRodXBnRzdrOEc2L212?=
 =?utf-8?B?OTdwaWlySkZnZHBpN0pqZVhJQ0QycFp4OVl1UnhjS2JKMXdyMlQ3dmpFWVdh?=
 =?utf-8?B?eEhhVXpuOVlsYU9KT0tBRDM2SVp5WmcxV3VqWWhmcFFxTXhQdGs2U1N2cFRu?=
 =?utf-8?B?TmNOT3NKWnY5cWtYMGFaY01uV0VJNWlnYTFaQ29pR0ZUY29kWEFpbXhKR2FG?=
 =?utf-8?B?U0JaUHBGbEVHMHNGTHlkRVc2RnEvaG1WSzRMcGwydGNHNDlnS2ZZaWRaOXdU?=
 =?utf-8?B?R0tiOUhQZzAwcnh3VmRKSGYwTWJKRUFUbHk3SzlmckJBdUw0dVM1L0hrM3pG?=
 =?utf-8?B?cXFZZE80M3pIM1ArYVdlai9sQVI2MndBL2RWbk4vckYzQktDcGUvZzlaYURl?=
 =?utf-8?B?bHMxMW5yWktkeG5SdkNQTVRyM2dHNytrVU9vZGJGYXZvUU5hSWpqVXFLU3Jy?=
 =?utf-8?B?UVd2N0tFWnc0QkptdXFJNmh3dVVwT1lvZi94bjNQTzFxMVNsWHoydDhKRWs3?=
 =?utf-8?B?V3p3YUZNRC9UNEdBZHpVdlhrakc3ejNjam9RZUpsaHJRTUgrSWZmV0pGd0M4?=
 =?utf-8?B?TjZGTEQxOUJ3b2VKclMxTEV4WWZHa1BGODU1U2tZaGdWYTArZ29aMGFoVVVU?=
 =?utf-8?B?VlZ2T2gybEMwK1JFMGwxSWlmSUJ1RnloTVJ2ckZPNFNkUW03K1ZpNmlTSFVt?=
 =?utf-8?B?eGdRUWFOSmo2L09xd2dwN1JiUW5KOEN6Yy9XQ0VuTDRHOUo2ME1mTktGamFR?=
 =?utf-8?B?Ym9BMStzSHVXdy9nandwUFJKOGhaOXF6ZjZ2VzhSN2dneW0wbG9JOXlWVm1X?=
 =?utf-8?B?TXF4aDhNbVNhWjB4ZzNYWjkxNUJvd1pUZU9Cb21qc2FPNEZaZktmMEtGVkNl?=
 =?utf-8?B?MzZNczBIUGVVUzcrUXZlYm5Fb3dXbm9BSU00VGVTUjRlbXNuRVdBQ1hWNWNi?=
 =?utf-8?B?K3RiQU5kNjllVlNLQ1hHRmZZZkpYZk1NcFVZc3ZLVjhMUGtnMkdjemF0Q3V0?=
 =?utf-8?B?N05MQ3RkdFpKTXZpekcwV1BwMFJheGtJLzJocndHS3dJRm9KT1BKSFAvNTdY?=
 =?utf-8?B?Q1NJa2hBdWU3bEtlYzUzMElCRDBId1ZWNXFkQkNISUl0bGdydkg3OEVNQWpB?=
 =?utf-8?B?MG1NTytUUFZtRGZBUWNqZWlCOG8yV2c0bmVTTHd5VjNhOUo5ZWFNalJZZ3NW?=
 =?utf-8?B?N3F0VWk5dk1wczdqT3FjZmVraC9ONWNKUHJOOXZpZ0xPM3lvYnNralN2ZnB0?=
 =?utf-8?B?TU1LTy9zVlJWTTgxMGUzM1h6NUJ2eHhSMjM0cWFMcTRRVVpJUW1CQkZQUXRw?=
 =?utf-8?B?eVZPM3F3bTExSW5zbktkMXJ2SXVKMGpPazkxNVdwOWxiaU44bUVsT3RWaFRi?=
 =?utf-8?B?NFI3MW55RW1DMUpyUC9HSTM3NUR0cm5IQXZmbk9MR0hvWVcrMkpxeGZsazBE?=
 =?utf-8?B?SFRqaGRqZkhjVW9PcERVSFVRbUtrZ2UwV3R5WUg3UUpOU3hoclNrNEsxeGg1?=
 =?utf-8?B?ai9ZamxDN2FsUDMwaldRWWhDK2RPVUdBWngvYm1mbVRUaVBRQnNWMXhSdlg2?=
 =?utf-8?B?RFRoUFhzeVJFN1k0OXZtdWI0QTdMMzIrbFRhSnpOUjRza0g3dzlscnZGVXhz?=
 =?utf-8?B?L3dhNXBvdEZLaWVoNDhiUmZvUTU3VWFuWVZyZTVPZ3BuWjI2eWpHUzNNQUxp?=
 =?utf-8?B?UHYxOHhYNXpUY2xqa28zYzZkVWJRTjRQcTd4L3Rqbmszd2p6aERpcXd1cksz?=
 =?utf-8?B?WGtZdU9DQkZLOTU3Z3hZMHp2bVhFOHdvdmN4cEI5UnFHTUdIcTY5UnBPVnQr?=
 =?utf-8?B?NWJiM0V3Y3p4elMrOUJVVVhPV29HV2hwQ1lFRUJZVVRadmxSMFpWd3BaSWZS?=
 =?utf-8?B?TjJydFZFZGprN0FqdnVVYVp3ZEVYaWVzWFJncWwxRGUxRmI1dFlLdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ff014-6f5d-49bc-97b0-08dec5f77826
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:39.7409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3ClAyGx8ASd02gNDAvvbgZmOm15bjTLZ9qCUTOh49a3ujVro6IA2GndY+qa/tdjkg7DBv1WCunD0NohMDLqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11546
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

Enable the live DT to reduce the DT parsing time.
Test data on i.MX95-EVK:

Before:
Accumulated time:
                26,205  dm_spl
               483,991  dm_f
                22,977  dm_r
After:
Accumulated time:
                26,229  dm_spl
               484,772  dm_f
                 2,667  of_live
                 1,003  dm_r

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 7fa6d6369e8..3ec222c2a4b 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -14,6 +14,7 @@ config IMX9
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
 	imply IMX_TMU
+	imply OF_LIVE
 
 config IMX93
 	bool

-- 
2.51.0

