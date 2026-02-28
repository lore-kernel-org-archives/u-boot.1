Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25581048925
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6016783E81;
	Sat, 28 Feb 2026 02:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="la5mmeNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A1783E81; Sat, 28 Feb 2026 02:44:20 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BABE83F69
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfcuGs5inCiVEn9YMCS1vPhyV/fd/wOL5R3fz5CWQvcN/kIcw9XU+6w2b0QSHt/wNwQHCEyQXAhTnHREWJmudL7gshaHKgQDGqD8k3zAEDupVQ5sw56GM9pykMr3rDsyKKGFm3k0zyjHWTI7VdhR0/nfq+5Wsi8w2fd98iaLNNwkMlYwHAOKBZC5eLy055uZ4fzlIDnxdh8h2tHTn0oFU7wWQ7z7f+VAs6aZdRCpsSw3nPp0dMbsTUzmrVmkaK+Yzr73iOuX0JlBPrGas4BpsxCZcRcFCATgSf/yzyLrpTO+KbX3j1dbU5rHLVBJAjnxj0672Rb6KgZeHf1s7vi+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwFhhIKlwJRR1FW/B8Tfidgos4dvgSRiy//Aw+KsEsE=;
 b=VL/AyfPoeRfNHGYa2DDcS0nkY6gPhifocX6Jt+UWauAREX240XUNz+HGQtOri3s/HznY5MBzaN9bh0pAmq9uY5GkxPYZWw6Q/oFMmr9n7x0WCTaoeoTmmRrPp3Wfn+HDa4b/NXKDUobuZUW33UML7X1ZgW4hyi9rxNx7FTqub/HF6opGyairI793ZcydyPQeVnvy47rmO0qzk+orJTY+u4e5gXDT76+xiJ32oS/53NsifWPPDu5LwD6tV5DCJYTPflB4Fp4xhOak4WdKt2rTqnjnCUrHx+0pRvnqA1jIt6Ar7Cvb5jTTpZFV9eVetQsc4zwmQ9jgcBMb7XPmXVlToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwFhhIKlwJRR1FW/B8Tfidgos4dvgSRiy//Aw+KsEsE=;
 b=la5mmeNAfYRpw8VO7bXMvKV7MKmxVdMeN6zwV8W8s63uiBybYkHI02pB6epxFduownDU/BD1ZsXbPlqoCZqAicZhb9Y6lYimNXBIEmkrny6m1ZN84E3AdCTwnElP0+Ad7bTZGIn4V15ovALOipLuCWND//NLbikl91YjKV3oukxM5kGViD56MCwuP6zLigSyxMCcErUmEpZE8/5a0FgNUN6uYbqbwxnNZa/v36rBw/DVFY4kut/OjkEGeiIVO+Es7TF6ssgyu9kuPHoDKkofD2YzV+QZIYFy51EBgZbo0VuVcpTdMF6vxGT1RA8OGerFgFyCbv2uZgVqmJnBR/NiNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:44:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:44:16 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:30 +0800
Subject: [PATCH v2 12/13] arm: dts: Add U-Boot device tree for i.MX952 EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-12-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab05fde-6ece-4cf6-5215-08de766ae1a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: lG6fSS1AGlKQblNUS1A67RlsthuSN3Qj5HiravQhJgpKXe8vYoZw75qoSnTBDsW+o7WTvKMV4v6zCaZe7Y1DxjGOx0v+eiDVA4TTPwCsXsjtIGJcHNqAjobdW2oE6FLMnQlsudn5AhMk9HJsrNlIscV8F8zyWoGvDU2IZ9LAdYbYfvbgS6YroPV5cVsOqKrUv/lxqKh99Quhh1qPX54aJ1GyRFg4LXduW5rA8mC8mBiDBVzQIBsa2iRPLKwvVsHTWViyvmCK0IU7nGszsas7BXrvz8bw6Rgl1+C6pm8SxTkRhbBa7BikYhBvpCC7SOKB1Nj/zDWY7ugCypz6C3UVaKGwvHbz2VF9G8jC+3+18pZs7cK6nFWPlQPEJNv//wOvgknzp7SMxJXdgrF33pIGOre2JE4AvmZQRWUfYCMlgo++/KE+7D1BbmjC9cyDHZf2d6pUviCnWfk0bjS3jTaqfOccJM32v/6hVtQaL82DDwbd68St+Z7V/iqkdGneIa8bFvqi2+DAL+zwb/hSRMTRiY7ej6alV+na76p/rGfdNsV7qgHxy+t0dJghrSI/e5RldA8YS9Q/cRPfSAKcdO/8dMtjJgzqveMiCOWgoVa6NROl3nWgjwUPgG7AyMuLxM1JF0WPZ76pnTDfCdb0sn44B6ewnP+ATD6Ox/oTJmD5C4ANmu3JgBqokK3N+VVFJjZ3jRLAAUhH93aGK1Y8K+OVxzAVLQQhAY32u0ugFLOzXTtCN5Tbeja6SMgWGaB5XDVhuE4cIXriFLUMPopRC9FMM6y13HzkMESfQ2AOthJiuuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBTeUZlSHlOMWJLZkFBSTBJbEwydFltYjR5cXYwOHM5dHRPc1pGK0pqelFo?=
 =?utf-8?B?ajZOL3VhOUNISGIxQXNZYXprM0V3V0gvdXd1ZHMzS2VsUDM0d21MamJZVndV?=
 =?utf-8?B?OUZteDVibWVEUXU4YjlVd3pTYnRxWC9nWSszVmlIc1Jtb0U2V28rektHVisr?=
 =?utf-8?B?NDBrVWw1ZmFGbDVzb080NXdqNVJqeXpHNkt2c3ZXYWxsTEg5b1o3T0VrVHhx?=
 =?utf-8?B?bUFMN0orbzFpbE1ycVNiL0NiYXhMNTFZUDJRbytZdGFTbk1UOUh2UUNJMFNU?=
 =?utf-8?B?WkpLY1hhSHpHRVI3aDQyVDdRNmJjQjFiU1l4NmZqL2VtcTFZY25yWVRPcEV0?=
 =?utf-8?B?T1dMNmhpQUZPYTRMYXNqZ3ZCNmxKT0w0dFBNSkF2Ky9vajJ4Sjl0ZVFjeHNU?=
 =?utf-8?B?VDQ2OEFqUCtTRlYyKzFCUVAvYVpXUUk2UDd1S1pZalM0OEJvUmNQelJ2QWx4?=
 =?utf-8?B?eWJ3OHlLUURQOG5qKy9uKzVUY2tXZmRvdUlMS09aRGYwN012cTJhVHBIQnNl?=
 =?utf-8?B?aHoxVE1GWWN2OW9XKzNTRnFQVVkrVy9Fak9QRjJnaG05aytUVDJZT3BJUnYy?=
 =?utf-8?B?UHpxVW9BS1JzZjhUNVhCSzdhcFhwWmhPVTJtZjJBMzJ3aVlQQmd6NHY1SFMr?=
 =?utf-8?B?ajF3cXVyRGczNXA5VVZQSU1ra3pDU0ZWMEZkdlBaOUttdGUrOGdqbWNMK0p1?=
 =?utf-8?B?TmF3QXYxK001d1lUaml0bDJMSTk1MmgyenZLejh6V2N0K2VnTTYxVVJVUDlN?=
 =?utf-8?B?ZE0vbWV1dFVUNlIxcGpqaFFSd3NGR1l3dU5aUzFpRlhQNks2b29TOWZycXRW?=
 =?utf-8?B?aWJ3Unl2M3F6Zkp5UW12S1pFdDU3RHJPTEhvNmEwMkFQT2dHWEEyb0hqNHk0?=
 =?utf-8?B?Ry9Dd0Q0Y1RkMENhU1ZMV3I4VXh6T0lQVmVOODBzWmRnS0l0UlRFUi8xbS84?=
 =?utf-8?B?UlRlNERpZlFQWEVFdnZVczl0RjkvY3ZwMWdsODM3akxsMXRCUlE4WUhjMjlR?=
 =?utf-8?B?ODdheGJOUjJIbTlpb2YxK0Y3V0dERmpGRStZUUxCMlJYN2FoSUxwVUs2cEdP?=
 =?utf-8?B?bEJFWHJrK0lFOHptNTF3dFlhOHliNisyV3ZkN0VGcVpCY3lxSVpOV3l6YnZl?=
 =?utf-8?B?YXl2MlJTSngrODh0S1V1WHVlb0Foek9naHFLRXUwYzB4K3VYRlRKNnNPVmlG?=
 =?utf-8?B?WDIwYlRzTXpxNUtuV0d0bFBGZHZFYkZ6cVVRMjVNSDh3YnlucUNYdjRadld6?=
 =?utf-8?B?bVMvYzkxRVBGOFpHT3VWcE5DWVJoSzRTMGdabzlxZXJidjNXYjJkOFk3Nnhq?=
 =?utf-8?B?THk5TnpKbVFDc2o2ZDRubktKRWFqbXZJZmtYenM1WGNsbmpKbndjVDFJZnRq?=
 =?utf-8?B?bnlqL1BZSDB6ckpvTHk5aDZxYUcxOER4TmUxNmxUY2VrK214enU5RzNTK2hT?=
 =?utf-8?B?TFJvTUZIc3ZMS0o2OTZIelh2TFBKTy9aSHlheFY0eU8vNysyK1NxY3hzRGlW?=
 =?utf-8?B?b3lnV1o1TjkrMS9mR1QzUXdnamhNalgxaUxDWnI5UjAyRkI5cDMvV0ZuODhZ?=
 =?utf-8?B?YkhIbFBUZmp0SWdZVnkxd0NuQkxURktQUFNERGtIZTRDYzlvWUU2WE0xcFkr?=
 =?utf-8?B?ZTlnUkZHdnRxcjhqeVB0cDE0SDl5V1BiQXdudVlrZXA0L3FFVzZ5dW1sSGhW?=
 =?utf-8?B?Y1JQbFV1bGNyS1pIdUhuNWRjY1FlUFNIVDZhY3EzbFZ5N2lrUUxSVmZBK1dT?=
 =?utf-8?B?ODltMDlXN1hGaHhpaGU0d2REQ25qMVFNTWJuNURDWlVLNG01THZSbXFmTit0?=
 =?utf-8?B?NVJsTlJFQjVpMUgrbHZ6eWk1L3JUdHJyYUMxd0ZOMDVhZ2cxWlpxNmY2Ty9P?=
 =?utf-8?B?cjBjeTNEQThYTWo1NFlKQ2RROVk0N1k4c0JTSzAvQzFUbWZ1eXpxSmo0R29p?=
 =?utf-8?B?Ui9BSGNBVGFuNzlGd1pnb3pJa1F6N3JSbHQxSW9ySEVZMElraS9pVDhsVVNh?=
 =?utf-8?B?aHVqczJveUd1a3RZeEY5b0hWVFB0NnYxcFllQ0MzcFpJYlUzMFl4V1YvSlJh?=
 =?utf-8?B?VmZuOWNJU0VKbGtIbHFRS0kwZGUvSVZHV3NDVTRWQ1BoOVBXMWc2YU91Y0E0?=
 =?utf-8?B?ZnVyQ1NUcVFzL05DbWIybHQzMU8wdDFSNnUvWlQ5TTQ0OS83cE1FdmROMVBF?=
 =?utf-8?B?amdjdUFlSDQ0aDdUaitSTUQ4Vmx4Y09JNnFUR21SRmhNbVdZYUZPcVd3Mk96?=
 =?utf-8?B?RWMwVjVTTWhtTUh6N1ozNFlHN1ZwTTZha3BHcWkvai8wU1dlUkJxYUVHejZX?=
 =?utf-8?B?eW52WVBuR2UvNE4rZndmVy9GckEwdFNMUDkxQ09PNVp5T1dxb255QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab05fde-6ece-4cf6-5215-08de766ae1a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:44:15.9359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnOyq5NeHkt32aLjj0kRyCBN7Q2TauPFn2wMleAJHf1fipl5h3ZndiBXpP5LL+g5DxZZblWk2VgN5KS2jsSqzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

Add U-Boot specific device tree configuration for i.MX952 EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx952-evk-u-boot.dtsi |  10 ++
 arch/arm/dts/imx952-u-boot.dtsi     | 290 ++++++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+)

diff --git a/arch/arm/dts/imx952-evk-u-boot.dtsi b/arch/arm/dts/imx952-evk-u-boot.dtsi
new file mode 100644
index 00000000000..b872c3a7273
--- /dev/null
+++ b/arch/arm/dts/imx952-evk-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx952-u-boot.dtsi"
+
+&wdog3 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
new file mode 100644
index 00000000000..e977014992e
--- /dev/null
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			pad-byte = <0x00>;
+			align-size = <0x8>;
+			filename = "m33-oei-ddrfw.bin";
+
+			oei-m33-ddr {
+				align-size = <0x4>;
+				filename = "oei-m33-ddr.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem {
+					filename = "lpddr4x_imem_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem {
+					filename = "lpddr4x_dmem_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+
+			imx-lpddr-qb {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem-qb {
+					filename = "lpddr4x_imem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem-qb {
+					filename = "lpddr4x_dmem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				append = "mx952a0-ahab-container.img";
+				container;
+				dummy-ddr;
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+				image1 = "m33", "m33_image.bin", "0x1ffc0000";
+				image2 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
+			};
+
+			u-boot {
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
+			};
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyLP0,115200 earlycon";
+	};
+};
+
+&A55_0 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_1 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_2 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_3 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-all;
+};
+
+&aips3 {
+	bootph-all;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&clk_dummy {
+	bootph-all;
+};
+
+&clk_osc_24m {
+	bootph-all;
+};
+
+&elemu1 {
+	status = "okay";
+	bootph-all;
+};
+
+&elemu3 {
+	status = "okay";
+	bootph-all;
+};
+
+&{/firmware} {
+	bootph-all;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@15} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+};
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
+};
+
+&gpio2 {
+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
+	bootph-pre-ram;
+	/*
+	 * Use one SPL/U-Boot for mx952evk and mx952evkrpmsg, since GPIO2
+	 * is assigned to M7, disable gpio2 here
+	 */
+	status = "disabled";
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
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&scmi_buf0 {
+	reg = <0x0 0x400>;
+	bootph-all;
+};
+
+&scmi_buf1 {
+	bootph-all;
+};
+
+&{/soc} {
+	bootph-all;
+};
+
+&sram0 {
+	bootph-all;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&scmi_iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		bootph-pre-ram;
+
+		fsl,pins = <
+			IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_GPIO5_IO_11	0x3fe
+			IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_TPM3_CH2		0x51e
+			IMX952_PAD_CCM_CLKO1__WAKEUPMIX_TOP_GPIO3_IO_26		0x3fe
+			IMX952_PAD_CCM_CLKO2__WAKEUPMIX_TOP_GPIO3_IO_27		0x3fe
+		>;
+	};
+};
+
+&pinctrl_uart1 {
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
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};

-- 
2.43.0

