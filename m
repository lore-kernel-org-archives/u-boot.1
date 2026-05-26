Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A28CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 05:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02AFB846A7;
	Tue, 26 May 2026 07:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TkKf7UQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A450B846A7; Tue, 26 May 2026 07:22:40 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A982C8469F
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbI7oF9PA7l1dqTUQ4bmcsjCM2ZeF8DkEtbEWYtevOj9qOYmjCGqNaNxGt/E24Z7m3KubXSOMLjKGSihSl04YVz8EbyS3cDq9FzsXMqiEs6QgKHHZLBrhj/QRCMQLHnB1jKMtNeSCFzK6mAmNZ6iRr1IlKSpXjKn7Oe/TdTjPKwQdskVUdnWT5AtyitRTOJXE6R2GmIubNfK+yJWlazw2HH3krGx24sxFeZLKcdE2UVnG8A5S1y1MHeJ+POB6uzqZGsmsUmi0btSgTQ85yAwEnSpuaBljuDTOsrFf8uW5mu3rymAv+KPEHj/OT5CrzgSGFmThRB735f8QDDDGBqsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F63d+nrzRuTht3a6h0grgyV79b36O2HVzeeH410aK2Y=;
 b=FU5lHHzvsWaWXVZy4Sb2LUzC+gzQIeQRmquV2CsZDClDOx/L+tO+HG6jSmXHjKmxPEGPtuVmycCVu8CnpoPF6qXqTk3H09bGV3A7L+th9nNXQJaGROoEGfQbxn+lBGPBsk5uUKcYed18F3CmY0Cw0DxwlRP5CWifbMqZhWVrFvH8NCUYLNVvqAAsUEXaPYvLTRBtV4X4g0xFUftYSevmQHKYkyFNFdA+5HUJmMDIH3Ulj1IdDId+q5K2kFnYxBDntEbtt2YagslUmrZ9pSeW+5U8KTz6mEBixvwoPGreR46EPkvOav2GjPWo9rLX3eUIOxi7jEIfWKye27FmdJhwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F63d+nrzRuTht3a6h0grgyV79b36O2HVzeeH410aK2Y=;
 b=TkKf7UQeEU2UINPVbBqvjvKz2J65R937+WCnC8ttC3IbLDnti7z8dpkw+A4IDVv30RM1UTg5wOfxWX2TD7CmRXewDLPNjEE0SnvPGsCK1EhBgsMXNvrurEleuNjCqtr0ZsVjdipfQTG9DayP6civCuI+Vb6OeleW6qdVRnnSGgd5o1bBadFXR5vr5JU+Esx7MvCmPUsA7IxeijSgPjIGvQ3M1Gv5zaPgTVnFRcWjNJw1CgpqjbKBspYCFPcZZZv3sU/bBnbvFxDUgnMc40yBJPn//xUFdVxhbysFzSlvDKOqm3kDUuPfHE/vhPNY1jpQFh7BE3vQ6ELd/TBmxZs3bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 05:22:35 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:22:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 14:39:15 +0800
Subject: [PATCH 2/3] phy: marvell: comphy: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-phy-v1-2-908ff621dea4@nxp.com>
References: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
In-Reply-To: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 George McCollister <george.mccollister@konsulko.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e97370-1ff8-4ac1-4063-08debae6cbab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|52116014|38350700014|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7Jz2V61bFaLNHFGlVTQlQ5f9XdM0dbYRBts8WYuRJ2Il62nHakezjbOVEmU0N5QCOFfSakjnbdt5oui2AlPOdN3UPcdvJZWkbRpVSoNgDKQPLyGh01wAapWoNx2gJqVxjhF2G91lNJYFUXtzggubMh6o1meq3clIwrnYL5sFf+ulZqHHYONEM7zQj70pEJ3afGc8GZlwdDzU03CJXOdCnyBUJRNWflX1CMvASde/vUxcFRsbtPXmxP/fw7PNkqGm8tLMQQWAahwWfQCyzGGsatWEu1xMva6JF3yNiAZWB56Kj4wNAz0sOI5CdS0bmSt6VI5vexHBGbZmLXt9sv6+WUXXG9fDFjo1pOjjcPXQb2kIAQn72rtv0NszYDRnv1bnJGTWAFQpgTHBxwL4m9jwGVOaxIvIBcCiI+AK1Ba9d4TRFJsBmuaXfnTTRLre/I7b2nOE7oieBjJyi5/S92APHxG3q88oAUXknPEnZfCN/mbHvLdlZjkRZKMeJD869qubI5IbVGbXSneMz99hVfBmpVz/qXT/0yWQOkuBs7JMZYMuB/ulyHY03tRqlxSeBMpqbYISA2UR+OaMSICMPd5+K28tyaP2vxlM9XSb5PvLYxVIItZMtiubjZZNOSCnCQ1GlNDLupMBGpVCShwv8hbHp6s8sd+lUXt87uO+7mGoHI+GagBxRzgfiE7CupwoHsIDhCxUaqtnropo5oS1H3ViecSbOPjLYxuvk4WDNmqCkKc3JsBrcK4bWgRXBIiAQ0F3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(52116014)(38350700014)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEtFK1VPUWdYWkdabW1hRStDeHZXOWNnQVVhQlFHdzBHRzc0bU5IM0FmV25j?=
 =?utf-8?B?RUhyb2VRV2J6UjMrR1NJQS91eForaFhESkVWM2hKd0VSZFhtTnl3YTFnRmpQ?=
 =?utf-8?B?SGdDSXkxRWhNNEZEMkc1OFNqM0xhdzJsMU9uNW9YTDVERlhoZWVaQWN3WUhW?=
 =?utf-8?B?ZEVvaFNvSVVMRmEwbkZqN1ZLRXdVK011U3I0NEIxVkx5aCtEQ2VqQi9lMm5N?=
 =?utf-8?B?SXNwZTRzVjNQNklya1kvSkZwZ1hVZE80bUZTN0VCNW1sbWJ4eHJxOVJOZnEv?=
 =?utf-8?B?aXdXMitvS3EvV2YvdFNNZjJLWHZ3bGNwMFBqeVZhNjdSSUR1WjVHVWpkUEZt?=
 =?utf-8?B?aHBvZlorN3U3VG5YMXhIUGZGbG5nUDV6Vlh3M1FabytwNkJ5bW0zblBIQ3FS?=
 =?utf-8?B?ejd5elZZUkwzVmxIc0w3VW8vRUdjbU5GNjhuNm1FczBYN0lVS05yWmdCempp?=
 =?utf-8?B?OEMrZ09ZZWRyTDJCZVovVFZHM2Z2K05pVkliaitramdIZWU3cjhuYTRzb0lP?=
 =?utf-8?B?Um5JcG40Rk9qTVQ0Vm9QcmJPL3YvYzBoUy9Ia3dEUjhsbUVsOFp5QnBtV2JX?=
 =?utf-8?B?VklKVldiOTNtaG9UaDVUdHNVK0NXcjcraWhJR3QrV1N0Sjk1aVVGcXVrWDJt?=
 =?utf-8?B?TUI1a241V0tEZWN2ZCsxclNoL1hRd1VidTBHN0haWFp3N09mWDRhOGxaOUlP?=
 =?utf-8?B?TTVVdzl2K05YTUVVQ3ZFSXpFVHg2Znd4T0NkK1FWYW9iUGFlZ29LWFVxemNR?=
 =?utf-8?B?QTc4dUpidDlxdDJxeS8yTFdzUDB2bjk5WFNWOEV3Ukg5MHI4MmRhNzU4NFRj?=
 =?utf-8?B?TThMOW9pcENQeTFwRTF5OFVuQnFNZmExbHM4UFg4MEV0K055RVZOMUVtKytR?=
 =?utf-8?B?NWNURHFKSGJRUCt0SlgxcTRSamFUL1BCa09hMG12TDJxVnRxbWZQNmdvWTlH?=
 =?utf-8?B?M1RabWhhQkltSElnNC9CbkxoWHVaOHNrUnFQaXdzVnorTHhLbVh1VStTUit6?=
 =?utf-8?B?MFY2UER2Q1d4ZjRhRUc2amNlVjY1YmhnRWp0T2lqYm8vYXM2MlFXaXlSZEZS?=
 =?utf-8?B?U0pQbGtIS29XY015ZGJwbmRqZ3RWbm9tcmw3cFlSRkU2bTR0NEgwUlpJa2Mv?=
 =?utf-8?B?T3FIZ1Rybm5MT3RqQzVqNGhLUVlRUVBCYlY5UmVJWFNLNE4zZXliQmlVZmxE?=
 =?utf-8?B?bUgxTUVHWXdqTFMvbWZmTGxpSE9WNTFDUFlwa2hYQ2Q1MHdsS3I2QXN4K01R?=
 =?utf-8?B?c09xRGFXcTBMWTZnLzJ2V3RjUU45MEcySnVSZE53UlFoQVcvUklMNFRYQ2ta?=
 =?utf-8?B?TStvYXdvaGJVMElvWFRZS2lQOGo2Q2lqSDVpTDJEa2tPOTZPS1NmbS92Znp2?=
 =?utf-8?B?c1RUdjMzaUNyWmNKNEhyMHJJVFRUbitaTkJ3ZjlHSnBFU1hFbWdxcTc2RVJs?=
 =?utf-8?B?TnY3clQwUEZ2cElnV2pwN1BNMUdHRDJEQ1htWTdCMnpQVEZJdHhXYk1GSzFN?=
 =?utf-8?B?SlZucmtJKzh5Q1Z4ZkxWc1JSQURxU09GdmdsT2J0dWhSVlhwU3g3NTJtU003?=
 =?utf-8?B?ZUlzQU5UZHVreGdxT0d1akViL3dvR2pTcDFacFJwdGJwbUxzMm0vYTZqNWN6?=
 =?utf-8?B?bEhJcGVtcEYxSmgwS1I1V1RKMHR4cEVkNkNuN2ljMGZpYmxNb2l0RTdjM0Z6?=
 =?utf-8?B?VlVaVzBtOHhQVDFWSjNMYVJYSUZuYU81bXQ1VHdjK0k2V1I3SXF5WmlVUDcy?=
 =?utf-8?B?eko5Y0RmdGpta2JnYXFIUU0wSWJTeTA2SjBxaUIwSU9XK0YvdmNyNno3STRE?=
 =?utf-8?B?YkNIMGhmMEtIamhDNEpYNzVCZHFkeW1MdGVFeCs3cXZwNlBmRDNFSHMrd2lt?=
 =?utf-8?B?L241My9sbElPSlMyUVo0WnRlTTFEVWk4eE9RQit6ZGNaVHlpaWJ5RWVqZzJ4?=
 =?utf-8?B?RGlNa0UzTlNrbEJyaTlza0EyZ1FRSXFHYnRzRHo5N1JGMXRKU0xncW9EMndw?=
 =?utf-8?B?UllucDRRL3M2Zm5ScFg2MzlkZTNiSXZEN0NGdXRkd2hBdkF5cmVqTFJvcE9X?=
 =?utf-8?B?cDFURDhKejlQMWx6djI1d2hBS0JSWmJ0K3lKUS9SWFU3U1dtdEExQW0yejB0?=
 =?utf-8?B?UlVHdUVTalJoVUZhV2xlN3o2VU5hMmVobS9SNWNta3BFUUgvbHhPbnI5VkFa?=
 =?utf-8?B?dFV2eHBHZWQ0WWJocmgyYXdJQXJ1eU5tcDVISENGOXFUV0FCTVVwdWFtTm9w?=
 =?utf-8?B?cFYzOURSWmxtY0ZZTkVDdSt5Y05mbGpBdlpjZ0VzNm9INDIvQktjUjl0b3ZZ?=
 =?utf-8?B?azBKaUVlSjFZTkdmM1RGMitTWElhRmZmRG8zdHVkeXVxWDY4ejd3UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e97370-1ff8-4ac1-4063-08debae6cbab
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:22:35.6326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZZJVC5LYogQwRb+X1MGIQSR8/DKCo9W4h1qwcey2ugk/tuuWNN5P58SK5tdV35rxVXD9/aOlsJLcYsuTV53vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048
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

Use dev_read_addr_index_ptr() which supports both live device tree and flat
DT backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/marvell/comphy_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/comphy_core.c b/drivers/phy/marvell/comphy_core.c
index b074d58f9f6..0ab5f9a3f0a 100644
--- a/drivers/phy/marvell/comphy_core.c
+++ b/drivers/phy/marvell/comphy_core.c
@@ -84,11 +84,11 @@ static int comphy_probe(struct udevice *dev)
 	int res;
 
 	/* Save base addresses for later use */
-	chip_cfg->comphy_base_addr = devfdt_get_addr_index_ptr(dev, 0);
+	chip_cfg->comphy_base_addr = dev_read_addr_index_ptr(dev, 0);
 	if (!chip_cfg->comphy_base_addr)
 		return -EINVAL;
 
-	chip_cfg->hpipe3_base_addr = devfdt_get_addr_index_ptr(dev, 1);
+	chip_cfg->hpipe3_base_addr = dev_read_addr_index_ptr(dev, 1);
 	if (!chip_cfg->hpipe3_base_addr)
 		return -EINVAL;
 

-- 
2.51.0

