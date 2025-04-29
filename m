Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC32BC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7F28215F;
	Tue, 29 Apr 2025 14:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QDgo96Ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4C8809A5; Tue, 29 Apr 2025 11:56:03 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6747480BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 11:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVJc+Z6vj5WUiN2CdX9EeWubXDuzBFnhW0fepNawK7BpHOfK+ns/HcnS1Vq4nFx5VlhgY8tWM6xWyjmWNX9AWnM9uVI7DG0QOqOXZ+vasHqDXxsgBI3Vn+3RFfhlJWkPhbFatDCwaBppU31SzeZX8S+6iUaganCsVAZXUnMOkCOOuZ8cm8JWNGcqg+MRQPKvOGy2uY0BrqtwAkSGZ9WsZ7NaOqRK3kdzdt9g/l0D1ka/xglUp4mB7qaU/C9uC872S9rjYdx3E5czjGqehRyi6HWAYun1DAr91//AkJ/+1p1QItfVbT46/74KDUeJFqB1bDdJUtR3f+XqgjbEfp3dFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWDekHXvB345Iul5pN5RuWgCYHLgONu9gW7tk35mHU4=;
 b=BSoLoCA1jY4jkclEI+dchQFxMHYoCC0oiSblqAG0UXM6Aq+O8ndNBv+hMKaqyYVirYWpmmoakdpJYyiw01XhP/mOIsdU+A4dWS0rAQsk/vIMKxOtrlURTBlfgaXWv2tP2RhcLDiK2Y0vFA77yEg48Wq6DmxQ4o4wo76Oy35jpcAw7/wOKON+hf5G1CfzjcXyLWu2tP/m3ipAP3Yk+aCvhYPfjFvDyDLG4K9AY2w0zzOcGRksYN0zdmLY9LB1sKqQCv8+Y9W2AfiERdQVojJUMxWS39N09QZmvCtqOv1i8syluiNsT5ucDp4A6UGbno79OJb4FqVQ3gEvopIXAiuiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWDekHXvB345Iul5pN5RuWgCYHLgONu9gW7tk35mHU4=;
 b=QDgo96FtvKzSq0KVV2S/MUl/BLPqIwjz3uIAbcsoVw8AmwOAYtjRdSieIBHzF/r9IJcCtrE8YLSG2b6a1FeXFZuUkEXo+j19Zd8XIOE5OlpM0tY/JPQitErPLXh3WPs4uNEi/QgMbcJWEzZZA7WBc/+8xu2r3hlyyxWs3K+VYreZZeNICeERrYJo7zlkukt2KKqyFY3CeGZM6o76JMTQis9dDb+i8Q4a74qAg1Vq77dkcs7HPWEGrW4wOPv7KMoNmEd7odcBEIcl0otXOxCHmG77OwpzGgaTLUqn7FIeei3sN+6BVkqtPmHvel1oosA90vkpDHkTsBrD1vzxhBVPJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5621.namprd03.prod.outlook.com (2603:10b6:5:2c8::21)
 by BN9PR03MB6041.namprd03.prod.outlook.com (2603:10b6:408:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 09:55:53 +0000
Received: from DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b]) by DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b%5]) with mapi id 15.20.8655.033; Tue, 29 Apr 2025
 09:55:53 +0000
From: tingting.meng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Danish <danish.ahmad.rosdi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v1 1/1] arm: socfpga: agilex5: Coverity issue cleanup in
 jtag_usercode check
Date: Tue, 29 Apr 2025 02:55:42 -0700
Message-Id: <20250429095542.10925-1-tingting.meng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To DS7PR03MB5621.namprd03.prod.outlook.com
 (2603:10b6:5:2c8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5621:EE_|BN9PR03MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 96fcb1e3-1de8-4afd-2a0c-08dd8704078e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8YnILZgMiQjWs04rI+791NBLBf4IYnn61WWLE/ZSWY6goeS+VFIMLlhf201e?=
 =?us-ascii?Q?8ZfzK+BT5WOJy326aIxaqpdsG+VdBWH8DOfMDVRyOcfuQmqzrXPgks0CsA91?=
 =?us-ascii?Q?87EPuACsaJ6xQQXyjXI3v0fSACi7UZBX5lyCn4NuOoPp548+OSn8YbUwEtMo?=
 =?us-ascii?Q?eMwcmT4Cu7tXW3zsQ+7xaqmydQpNHrjV4bfVr7ZJsYXAadaekZ2RFITANLLO?=
 =?us-ascii?Q?qKRkIIElxyrJjWLAQCHxlauujWaLiIS+J/ex4hlOwb4ACF0lgNrTXXjfFzb+?=
 =?us-ascii?Q?daKaQLDSpbR1yMmvIVXrYQ7GPjgf3TPdmLr3tYdH8rltig8HLwGEBLx5An4c?=
 =?us-ascii?Q?zJNw3+Asash4L6Jc8IAjM/BjY2IvUK9Z6Cu7TOtbVtF2K21Ntd1JT/Rqhsxk?=
 =?us-ascii?Q?1SXn8oZkmn2evr6myGntkTwnVfO2OlY3fvBKGVkN969m10lhKxn9rynYHfW1?=
 =?us-ascii?Q?OrjhPpXTUrsfKAj+EEEX1CfkWvs3y0+eZV5Ln1mKQfPEwz2R6IusWj64amXZ?=
 =?us-ascii?Q?AUNNZd5YGXde4dd9Wg0evgSRl7Eg/QxsK/erFLUlhddyvlS2wThWbPwrcb3S?=
 =?us-ascii?Q?kJ1mwFzPqhBGcnzTMQsn+vCbcCv4m1jDrizbnUUYcbJSa5IJ1BEJ7liDLKAH?=
 =?us-ascii?Q?Tmes5KUbuA1ThDeypAwZk3yFQs/dIRUxIKg663yuGXT1UDenI/P/Mnvk2DTO?=
 =?us-ascii?Q?ohc1tZYrotYH0FXEqLAEnKv0tpVKKpfQ1CfJL4xF4TgUbuz/aHWybkDDgC+O?=
 =?us-ascii?Q?4I8jlssf80ujIgwqGGgI5hkcupt5Q4xsIWYOg3H/uEs1IP+XVVqI9CDtBZ1f?=
 =?us-ascii?Q?HF1iuk2G9SJ6FlDkkaZUPuMZ7+GQpbyUB6GvTxXc6Id6HeT49X9CckwPWL8d?=
 =?us-ascii?Q?ZuWiCP2pkCchdCOZS+FP/2dX8DJIr6+bqlQrfCY91K9OcaopjWH3CnXlPmEU?=
 =?us-ascii?Q?CW9gPI9SMBrhzDblAIpS+7quL5M+R8rNHsj3qh8/YFmOimPec2vdA3SvBHoA?=
 =?us-ascii?Q?0ZXnqO3YxTEyZXhk6lZvPJF828cOpny7nvg/1R2agGcggt+1EOiZBVy366/P?=
 =?us-ascii?Q?9F8CTL6WfVhLpr1EaBeuW+ICgLQhl2yv7jjMMc9xUeMNiXekhSWwk+1bl/rj?=
 =?us-ascii?Q?O/VftZZRCPjw8OK6Exn2G0QK+MSk1xdv3V3GqsTYcTwZ0XuVb9YHpT8okyM3?=
 =?us-ascii?Q?S4HkFz4YtkMkpAX44myJ+YT9HdCIRUP41c9WWZN8g0Q+JpRSqMoz1gPeFt9m?=
 =?us-ascii?Q?gZij+czpdG342fxicwLgfQbzeeWSvWmZBY+RbYXunfMqRBjs9DygV9Xn5VR5?=
 =?us-ascii?Q?dloB3frPoC/tENtIIfgAAAKWrEj5pCmFyIdlkiVnbd5+w+ua809zcehZnpUq?=
 =?us-ascii?Q?PCeuY6BDNlgE3A1DPi+OgnAMt6HAB0xH3hqi+wEvMjcmL9Zv0oRRO7YWOXR9?=
 =?us-ascii?Q?pCWjMVp8ZKY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5621.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBYpw73D0x7/CnZFXtTqPfGynMks1rG3vhdqkFckBfIGQEC4vWaecH+QM7Ql?=
 =?us-ascii?Q?HEWRDJm06Z4HFXFgQu9EEYKTh+apLGA253MpJGdrZzZbMbS/wRGbe1Z9tFli?=
 =?us-ascii?Q?OT9lseuBb6oCI7k4zb2N+JNFDBWSLrr6K5+J3Ue9EmBktlFNiQjaUrgrX6Q2?=
 =?us-ascii?Q?r2yOt9Hmm+4hxa8mKDozmOHfpIL+TRmf7zzSg/2N18cEzBJEgXzTr+K/xW2Y?=
 =?us-ascii?Q?WbB89l69ML6fZPfdr1TCti1LDx0Y7CygDceGn1WXhfG3Orl8DE/HCVKlnkSL?=
 =?us-ascii?Q?J0ZMIqagB/IUKBxKREI9q5XIg0eflNM5kohgI7xItwwPMXE+fFupBcNi9FWW?=
 =?us-ascii?Q?sZ1089ZdXg+bc24X5lBJe8jfX6awcavl4vWylvtmcNNEWstczzseI1knVDFj?=
 =?us-ascii?Q?PdFVCRT2SFtxSQIQD8fyg1vGYipGKfAigLfYGzorSUgXi0G3tv1MagMZtfIQ?=
 =?us-ascii?Q?gVsLBaAMqDGujgYV5DYulWG32rkeY2NuHHz1yfRCZc8B0mEmMlXLiSsaqCVz?=
 =?us-ascii?Q?zUAk8UwifEQRnJsdIwLMwAEue3bVtByNuDv/Lmjp7BHQq79NHlpt1XUV9y7G?=
 =?us-ascii?Q?tbtslb6NHTi4SWmFs4XnE06TtGXi9gf62QQd1JnLXSAUHF9uV/AHRGaUPy3p?=
 =?us-ascii?Q?rFsIrxWOL09ZBYIW6kozJIkE9sTR90Mikmsz6y2j7ICErKfwv+v0qzrIKL45?=
 =?us-ascii?Q?g5lT3tXaBnA8bCyrjXUQjpRf6lOCiqsS0dt7LlpevvvPhHQpw5em6E+x845W?=
 =?us-ascii?Q?5XLr/0sZM3TAbFRep/j7zVHZbuNEee06wX7cuoSEZ9+pjGI3aICauFSS2vit?=
 =?us-ascii?Q?9SpTUtsFpZVmD1RO2k0IK1rckmMTntcP4OTvsKVaOj8/ciOK9gyLa1Rnwld+?=
 =?us-ascii?Q?/+jEVqQL/WYcQurmeQfxEIxmERuGlnbcMUApjFzHPFuP/AVaLf1SnfRYWgSF?=
 =?us-ascii?Q?GWQwpXPJdN+5wx9GGWEqWIC7mAE4ELtVzLdn6bc6Odr1KAhZ4aH+WHzNuc5v?=
 =?us-ascii?Q?/tlEHgMkLU3rCO4i0ed2ZYpeoiTTJ42GSc76D5zcWZBu53q8G9rHa9VkqoOI?=
 =?us-ascii?Q?CWpW/AB+k21IQNk16FlYxtz4UCSv9Q7NAdCqjtHEa+LrFhLLT8uBM0YZXv6I?=
 =?us-ascii?Q?UeepRp2t3BIGpy6cax26AIqObnhG/xit8R5wotLtmggiqL28h96O/PCxxD21?=
 =?us-ascii?Q?qfoMN59ZEjUFB+j8p04NV8mSk9VPoMF/mypIN+i60DxQ5w/HamJl/oWGfHkN?=
 =?us-ascii?Q?ydD0rPa1i77zN8vVVwTgjSXR3tJVlWZrUZ4oFfyGcnOhrzGVJZFNzHcsysmF?=
 =?us-ascii?Q?h3quzYMHlnjJGS8csDLnPdXpYDrBGOB0sEeOPzCEUeap0fWur1vzoshNt5NH?=
 =?us-ascii?Q?bb9CHKXGyZ2Ih4D+FAKksIEE4bwFKqea8vcfzLSp4fWcijmG0pSuPw9ODAoF?=
 =?us-ascii?Q?UkRPWygidHjtqM6ZjS5/3o78NWElc/2pdakcCarB4waZqwkmHIHahW+aLXEC?=
 =?us-ascii?Q?wvhDERK3o/tVNiXa5/fdFb1hjzuWFTKHmaIxLW58vyRV/DyYrDWwaT+9jcpq?=
 =?us-ascii?Q?C9R9I30qFXOntpraR+t34oQaZ4YyXe7IM6aaAtQcm9XsxL+yk/GPuJvDhvhn?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fcb1e3-1de8-4afd-2a0c-08dd8704078e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5621.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 09:55:53.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVmF+3KqKSh637gxEslHtY1R7V9HIqQF4KFI4zCnYOQROjkfERBExwX31YdXnvOcQhVPoJjjT00upd+dw4whasMYZPE0BxPlvs3Mu5wzr4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6041
X-Mailman-Approved-At: Tue, 29 Apr 2025 14:26:17 +0200
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

From: Tingting Meng <tingting.meng@altera.com>

A redundant comparison (jtag_usercode >= 0) was removed from the
condition checking jtag_usercode. Since jtag_usercode is an unsigned
integer, the check for non-negativity was always true. The code was
simplified to resolve the Coverity warning.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 arch/arm/mach-socfpga/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 8506d510413..8bec7c6dccd 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -133,7 +133,7 @@ u8 socfpga_get_board_id(void)
 
 	if (jtag_usercode == DEFAULT_JTAG_USERCODE) {
 		debug("JTAG Usercode is not set. Default Board ID to 0\n");
-	} else if (jtag_usercode >= 0 && jtag_usercode <= 255) {
+	} else if (jtag_usercode <= 255) {
 		board_id = jtag_usercode;
 		debug("Valid JTAG Usercode. Set Board ID to %u\n", board_id);
 	} else {
-- 
2.25.1

