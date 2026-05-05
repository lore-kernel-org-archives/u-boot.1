Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8F0FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 01:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7DC9846CE;
	Tue,  5 May 2026 03:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="p1uGIsAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DE5846D1; Tue,  5 May 2026 03:57:23 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D342846C3
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 03:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvQufft4eQwBskWCxsPx8bPUJtFEk59KOEePrwfAknXo2Fdvxix1Pz1ksdzZAX8X8fG2WTGO6P3KD3xhHrmHXbpebaU9TGg33nO2JtGclh8V+rsVfAuuwd/uMIBi3nj0wBFfTmuClVPlvxz0+BDNB99ih2ni0/VsWvHUpB4wDQ4r2Rj3tu8qYI+85CEAKjLmr9auZt3rEVL7+9cYgVWHYfy/J/Owxa7PJ4mjpO4emmFWN12PjBklp31mPo5wH9YzJoVN+HYmIREqnGU5lLRk12iymT+gFkWVC29yJrt3PqGTARKaN58M/V/2j4Om2jSAX4WYjbZoFfUr66E4lRQ6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/SBonuDUwWeOax2b5KZumQeZOXddzVyLxK4E+qeXiE=;
 b=ouhxzak/WN3PNzhNlWCTFSJ/77rN2WBTVubrkqeY79tpAifiMsqx/0p22rlroEwC0Q2u0v+ULxY3QGPYpwDI43x2q+62dCpChSKMRabKfDrflUgxDA09qHs/yPAPRfDi/Gl/dn90xVnl4IMIwk9kc6Qb8USi4YRrAVoYnojx6kXUTM6Yuj/ceVjVO40EKSbzJuk05V/mvgM37kc7LY6O5na90yZPbeWjftU+nluvCoLY+wM9QBLSoP0a83hc9/5Fjf5bnvN2hKUXATR/HiSrbZwSCBqpx/tY8pfoS6pxEi0hjIWWK0YsVtoDU/N4DVEdwk3azfNNZlxEjawitIEfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/SBonuDUwWeOax2b5KZumQeZOXddzVyLxK4E+qeXiE=;
 b=p1uGIsAOheXN8Mnxf59WVgTiNLdvWzWALHaKRDMNLSgHNqRSvXJXqfHh43gSBJToueMLcWrWJ7DX8x2Z7RFFdqxNaPFjE65cS90jDAWsKuxN4PJcB8AEpXnZ1jYD5eeMpY5LxL7I4JAPXIE3c8HxcavX7dvBlHaIQY6uhlLVPD+lrDOl2uQqb2xcBW+2CydPbOVHhlOJn/Pe4QtAd8JDP3FYwE/EaWD7lyX77DHIuJSEdVfnCYy2WYq2qiaBfLiMs+mc1Jq210hdWtitYbR12eYVfa4HFmJxN2XgCuiCDKmiiUon8PUNs2o6Si5eE2aebpUlFOLgCUHnpIOUXrTTNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BL1PR03MB5973.namprd03.prod.outlook.com (2603:10b6:208:310::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 01:57:18 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 01:57:18 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: dts: agilex5_emmc: Remove kernel node from binman for
 non-VAB flow
Date: Mon,  4 May 2026 18:57:12 -0700
Message-ID: <20260505015712.4266-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BL1PR03MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6e219d-ada0-4ae4-5741-08deaa49a307
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: I+xmX3Koi3yd/FcirjuX5R1Al2DjaEUhv4TTf5H6XcjJdnlunEfKFvorFycNLjOKlYHGZQHztX1mQCR756QVVeG5NZgmQevRIx2MLBwNab+j0eV/rjUrWyprPpPJPPR45do7HN3mQiu/3C74zvEAfx7OykRMq1WWnbFz8wn0MGnbstSlaRdLFfx3FxV4/3+y4ESdotEZ35Eapff2q1xA3a6hU1+7JbPN3KNemyMMrac3sKBsJypHveZKQuGUgaIJ6iIvkIv43ykVd3gRAeUzH74h/eTLedhaUWcYMe1unvlAnua8qVAyKEoj5G8su8Xmb+CSK8ace9fIYzGnXx0hQqjcsWgeDn08fBz1El9Xv2M5qeVOnzrfkrC/f94/K38HicNBj3BewhJNNrU3F84xQxf5uaFeplYhTPXC7H2zJieBrLAJ9tYvLPlduHa5PBN4LES5QithwCsHO71TqhZu2Jx3CqDHOACLdlJinXox9fAcSKsKMHzkubDIwIH7+qSiFDy7k1Od3C4elDkny7hZ3eNLvt8ZNMD6dN5YCXlcBK8jkLOj1sEISckreSTrhJ0yZe1r659zQgTsZcWjWRP4b4kc7OtxT87e92VbQ5xLDAQbapcruH2RqGrQZ/ZbgYzOHmRjYRZGEDoQW8160uswYThFwWTgkjOPhArArE63HzyMUtn/Jbq1C9ANc8XqlhZh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fq8lWuzd1R3Cv33j3FgVzjEli5FFhK+29BrvD9oZCyQckboL1LCzuL2U0aaB?=
 =?us-ascii?Q?89/kPQEuFjbVWv7sQnid46XB7MQnxeDVel5bREseXD40qoz/JoqGv98Aghda?=
 =?us-ascii?Q?y2gXBjCv1smfh3LsfNMyR0XYTRqnBZSCgeKeHJ33Vujm89srHl+gGy6yWXkA?=
 =?us-ascii?Q?ldIRpZlJKukub9ht2gIRtkBodA3LY4QsHBF8pkVOgOauPqQuMX0lI7nWZ1FA?=
 =?us-ascii?Q?g6SZL4tnWDvT+5uuAPUqHrBnlRzVNuszV/VHvdnduKQdDnJSDmHa1LR9VBWm?=
 =?us-ascii?Q?JvOVphYa0LRBWdqg6SCQIIOlydE0X2ufcDVM9m8d0limy0LewAi5A0ryU/H4?=
 =?us-ascii?Q?OARlxCu6FkyEDPb20tKvtALeOpVW8aS3+5yplwQSAN78hERGZEYuCJGhqV8k?=
 =?us-ascii?Q?9A28/0UUdCfIjF+dhzGcY72lsKhcUJfKHmZV0c8Ddd7KKYlj0jy0FL/0lHle?=
 =?us-ascii?Q?qgefOLBjeOBrXvBw/59DtEqpzbPSTCXKowPep9ksn9UCyi1I9SzuSSr2q+71?=
 =?us-ascii?Q?YZv2s4cwNeEzXXX093ZrysfN4FWqtBElGFcIrGTAjhZynwSG4JpE17gPtEgt?=
 =?us-ascii?Q?lSf77G6vUQXLC2W3gPzXFaNX/TXlB6knxqShBhu66ZEI0CZHbiWJJ+tRnekg?=
 =?us-ascii?Q?YlG1mzRxqVvhoQxJOaXgYIYv3qbloLY2p+Ht1Ab+MhkXKIZwJtVYSl76KphN?=
 =?us-ascii?Q?zisGiKYJPEXcn+GpDccXBk5sACNuqCe3TO4+wZ4IkkZG9mCDqj+1mw8GIEqw?=
 =?us-ascii?Q?p+pqIaW2zLxgbJEW5BEycKA6IvRzwRy2Ir1vCnLRmvsxVMbl4KrJdV5SAHSg?=
 =?us-ascii?Q?0IiFInvioAJJzLhUuTkdeoC3oAwU1pFpb1kXiKVQgOzOC4QOYBlLX23nLCBx?=
 =?us-ascii?Q?OBPfh5dH+p1X/yBNxe5mH49g/fdUq/rNHUmIJVfOXS8xIPetqGCN/kSg2QX7?=
 =?us-ascii?Q?q2KsnGTkg4srqTU9QdfJCEyuluprCilMSxBknpyVuopCZpTmvKohika+4uY6?=
 =?us-ascii?Q?rJzjy2fr7I8ckofXD+9Ti7bLq3CWG1WPPTtAWgzl8n1XkQZnGByCtFzduHTW?=
 =?us-ascii?Q?CwJ3SyiPYqqfEkyWKs6FOicUubf7w1bfVCpLQPGXzZpMVMKMDqx2GyDSw6+j?=
 =?us-ascii?Q?EHTETqaWFT8BpAY6C6uSJW0x86WX4rzPHNdyJ0EFagaEIo55fv4PDVHe5YX9?=
 =?us-ascii?Q?kRebemxtnemOk8BFcrOupOfzbtLr1EdTDEFkOVGY2+1yFTElv4i1lu5mKf8X?=
 =?us-ascii?Q?AS/J8k2nPmBDy0VdSzzWMFawXMQK7GSKGDTxHL32WmonGo17G9I5skMf1o6O?=
 =?us-ascii?Q?M3/xLYDTCtlTyKKnoC8pUh0GgLUUjHIA/VWeXyvoU6MYjHIbT7nIQQ9Y+Crf?=
 =?us-ascii?Q?DAi6oQWw0ttmWk08nGSL3Jm9SuNpBQV/VS9vqmWwTgmUVLsz52QAF6mrvzmP?=
 =?us-ascii?Q?c797VJv+NdPC2XXlfKP4nEaUTF/t7fWeApsB9LSAofqGcCACR9masYTUfhOv?=
 =?us-ascii?Q?WGZRHlot1R3YQmvyuFUQ6FE/XhYB4XEQWP9j9+mfucG53XcCzkxj1vOjN3Wn?=
 =?us-ascii?Q?6R7aleICBPqPrhiuSFJrmVMzYRy04D1dE0GZxMac5gQuYpUuvAvK+PCuCio4?=
 =?us-ascii?Q?D0rOLbcz4Q67RlMQ0bCj5tLLaurwt3deURFduENMmCEHe6FRBNg07b86FBuj?=
 =?us-ascii?Q?jJUgvJBCo2h+/wvpQXleXtnendb0Y9GP9zNwwUFqk9ErPI9THBu1omFPLgPm?=
 =?us-ascii?Q?YtZg7d2T2Y3qJfVF1I4d+1jAbH3yhEA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6e219d-ada0-4ae4-5741-08deaa49a307
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 01:57:18.0098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6fnQ8dN9jQBIT2GbTSMQvHytRPJk0QNUz/uL21yf4h7QUHb5j9l8r2nixWfwQollonJmEJwN1f6qMFxr3V+T5o+hOSAA3qw7Vl7p1gJpe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Binman will attempt to package kernel.itb during U-Boot build, expecting
Image and linux.dtb files that are not available in standard U-Boot-only
builds. This would cause build warnings with missing blob errors.

Add conditional deletion of the kernel node from binman when FIT is enabled
CONFIG_SOCFPGA_SECURE_VAB_AUTH is not defined.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
index 3c03b00c0d9..c158566361f 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
@@ -170,3 +170,9 @@
 		};
 	};
 };
+
+#if defined(CONFIG_FIT) && !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&binman {
+	/delete-node/ kernel;
+};
+#endif
-- 
2.43.7

