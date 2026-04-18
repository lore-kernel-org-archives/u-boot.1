Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C06F99C7C
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 11:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0125183B99;
	Sat, 18 Apr 2026 13:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yEVGBTbz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80EF83B99; Sat, 18 Apr 2026 13:21:16 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E0083BC8
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 13:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JI9wmW2S7LVJRNmm6SNJHLK3yrBdFemtmgrw8LFAxtnPZr0A3T6ZP3VhJd7K7He2UkFQlWCmOJqtrmkTcqN1xwu1yJLXloc5fI1R6srFGEIWTxmZz9rR00zLnt+wq8YkTsQ49A5b3NdYGvmjTBGMmftlf2XfwPhycE/Yyq9AzWciG/qjG0E0+cSD7GQrSkeNotCAAtC25TzNtX2c99CaiN1bhjzjIDtlipGjRoTRQZAUPvGbrCoIJZt1defenDdgSnkXE+QVLqCZ6HuL6OHMw5WIUzS9VxxHVQIGQ3gwNIj4vw/PQXjOm7DosvlzXzSoHhavn9CKH8XbPBF2RAq1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfH8NdprdCxReFmmTh1LXzSGSUexkxGOcMfhM74nTN0=;
 b=EhB0j+t3Yb0jZypPCNn9qG5A63HZiMXKYI//Pxxbf66Z7rV3NdOhEoAWon4Ahjw2wCB/MAnClQWLu6DeAelvfOXXA6NSeYiaSdyAm7SaIoA93oFFW6DKAP1x4441GKUdnhoiuMvAk7Az31GVdkNu9sKwYE1JoZoeB4ZTZhyIqito9SjSj05noJDFQdOezsugf4UQJ1uQDhnfusxzb3l0sVpiy4kggFa9C0KwcPjYPUGrKkzH1s3X4XeX8gXwxXkG7z1WqaNopANMtbvPWxNoK3k/7K/g/5hzklciVg07GAOYrgdlgmsOL4o5IjgWt1069UVxL9gEZ1sZEywg66MBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfH8NdprdCxReFmmTh1LXzSGSUexkxGOcMfhM74nTN0=;
 b=yEVGBTbzT6mRQFykcQ4B+PHs0FHyfRbpQakx/GRa6gsvlBN7TqupiXNTtAqHkVSVLY0KYq00ScY7i3DLD7VXlh9Xkh9hMFbt2jKkelrWQrkytTpI1Ubt4rbLBjECvfQYfzGNL2a8uy/BRRLbBN5fwHdmevq7UacPkMnHmpd5366m9TJ4tG9x7G5tGLR8C8JbizsDQ8b759ZS8U25lXouxGMuf7lY8wwW4WPBlXaoNVVqWZ+22kN54tXleofBwah3xfzb5ZLnnZzQSH+cBwXTK/xyYsNpgWaTcz5tL4qKumScNTMzbLEf+ziUzTHskEaVx+fRrbY4nEr5GoEAyBY6pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10756.eurprd04.prod.outlook.com (2603:10a6:150:226::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Sat, 18 Apr
 2026 11:21:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.023; Sat, 18 Apr 2026
 11:21:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 18 Apr 2026 20:37:32 +0800
Subject: [PATCH 1/4] power: regulator: pfuze100: Fix min_uV usage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-pfuze100-v1-1-80d2a96dd927@nxp.com>
References: <20260418-pfuze100-v1-0-80d2a96dd927@nxp.com>
In-Reply-To: <20260418-pfuze100-v1-0-80d2a96dd927@nxp.com>
To: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: 761860ef-b6f1-44d0-e3f8-08de9d3c9806
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PPoe9D0M3lO2EPKKi0rPj0HLuKdFB8AK3ZWxoqnVva/4fSz/spkcr0xpIK5VIwNsnbUpW4x6hrE4iUA4gNsvZE3NkUZUi077Iqgag9gaW0xA3Ur5Q8/EumLqpC+Xyap+v6tytbLnEZsN285NIQTMMj2pcJO1NSgmxudamPyy14o0v0GvcGVTyRs8ugDpmIpfZEoGD+/sw2Ap5mvkzSnY9ykX41ANzPub76cozmaqTu4OjugWIdYdCMnvrU5qPu/O4NF00UvUGS+R4+TMBu6EvX557pFGlkJ875TfKhNZqmki0L1yR2adansnd4lwN6ySDFMHwkp49wF8VvzJObuhTB6POnbHJmzh24x6cGG71KOZk30IsBdfOb+MafYslXigKPoupgKwz4oujQIh8RBrtlF8ggPBJntcoa7tfBcO3OjfsAIVIg8gXxlXuGHwsHn6LGpxlNIcckZ30pNTR1BS3/QFwRXAHcnj58SJedA2bHaDVMEZlSFAwz11vze4I31ea6N981KKOmfKRHmKjz/SNJZNgUFrotXUuILpjupVH4Tpu78YhD8Jny/VM1lPW9eeMevpY/i6Zj85XpQ3btdeWl7UtjwB9fJyTU4tTPBNCCHbaCyfUYzoBsQ2dkD60UH81SBnuy2kTvGpLJtJDhhEMlBWdcKHHz8OJ6M+weasYbpxSmxqVJkZecPdi2zvKBPeyY5MWbxM8f40emVelMYzD0fzPlOmjUbyEp80tSxRYPTwcSnKFNqVqui5YwBYvXlmmtorfj0wbXbU+eMCsxQEbodukUjBHZtKbNwF1ti+Fhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UklwRVFja2tRdWd2SjhVZnF2N29qRXZLZkdYUFZRSlF6anlmTDlVV1BWaDBk?=
 =?utf-8?B?K091VzIzZVRWS1NyYkRXK0pXNGlUMFQ4V1lrY0pHeWw3MytOOFRkZCtnOG5o?=
 =?utf-8?B?WGxUNXdxeXF1TmUxSDFseE5wbEM5TFhRSnBLejJNQVF1ZFpjYktWMzdmK1RN?=
 =?utf-8?B?MlVia1gxekM4TzE4b3BQTkladVc3eGtJZDVHamlLK05idTlmcjlNNFRnK0dR?=
 =?utf-8?B?R2s2NlJodWxHWTFqcm9wdW0xcjl3Qzh1N3JjSTl4dHNrVGIxakdsQ3loNWF4?=
 =?utf-8?B?NVlYb25hc2ZpRk1nZlc1VXl0eWZ3M2xnUXcyM1U1WTFuaHZxc2dBWkk2ZmZm?=
 =?utf-8?B?dUVwSWN2V0N2SUZIUlRCK1poSmhwbTBzQmtlQVhvTG9YdkdmWnhHYUQ4ejUv?=
 =?utf-8?B?NGpZalV0UC9DZHg2S1gxR1JPRG5vZ3A5YWVhZzIrd0RLc0VsNkcxOUNSQ0Ew?=
 =?utf-8?B?RDBPU2x2eGx1YUdyb0NHWk1yN2lpeDBJWHlNTEp1KzdsVFpCWTVlZlJuSnN0?=
 =?utf-8?B?YTJ5U0NFREsxdXNBbmZORS9PVE91WU5OWmJMSFZJaGVVZjE2cURqT1hVR1Bm?=
 =?utf-8?B?U1ZVRG0yc1I5QU1KbXBaQU5aTHpKWkxsWldiK2NZSEtxbXVNaVZCSTZqbi9l?=
 =?utf-8?B?dU1BOWZUQmswOHdlOTFLZkMxTGltRm5RVE5wUXFOUDBqVEhJY1QzU2JSOFJF?=
 =?utf-8?B?MHR5eENWL3BKNkJEZU84YW5XdEYvSlp2NjVyaXU5UnNTYzZqRlliSEpVT21w?=
 =?utf-8?B?c1ZHMm82UmtNME5iS1VlMHZpelFTWlZKemIwSTBOY25hOEFPRERKcmNUaC9T?=
 =?utf-8?B?bE4zajhyMGMyWUg3VEJ4eHpnMXFwNHdlTkk0bTNNd291bVdxakIrOE52MzNH?=
 =?utf-8?B?cWlnRlNKZmJLcnlBZFBZQWU3U2xhTlFWRHhuWGVOR0hjL2VxT2RFM3RndmF1?=
 =?utf-8?B?M3A4eDdhQ1RhZ3NPL3ZKWGRmdkpTUHgyNFY1L3RrN2tTdk4ydjN3NEduVlRP?=
 =?utf-8?B?aWZ4cTVZQ3owZkdIR3pyVHY4V1NrSEY1S2s2Z3NNM3pwOTQ0dUx4WkFxSU1J?=
 =?utf-8?B?aTEvNjM3TlRsQkFveUl5ZFlyYkRvYjdsZXRwUUpZRWg2c1E5Z1RuZG9NOWlE?=
 =?utf-8?B?MUZsWG96bytrVm54S0I3cXltdVRaNXZ4OWlicHg0aVdPWmhta0xVMTJuR2l0?=
 =?utf-8?B?S2xzdERVUUxSTlcwbUlqYkQzNUU4UE9EWVpwYkJ6eXhKdlZXcnplaVUvMzRT?=
 =?utf-8?B?RWJmM3JoVDlkSUVkRTBSdGdxV09TeXRIU05tcEpiNklCM2xxbkI2SHA3RGp1?=
 =?utf-8?B?Y3pwTW1SMW9JbWVvTjQ2OVVYY2kxU0VUVmJ1T3Q0bzVqb0I5dWMwRTVHK1dq?=
 =?utf-8?B?YnlMNXZick5vTkgyTDBkL1hlQWt5RXV2SFNVakllZEN0R202RlpDZkpWckdl?=
 =?utf-8?B?bUoyM3RtRFI5aEpYd0xOS29KL2ZkUTlBRFd4S3J6UmFCdGhIQWRLV1NUNnRZ?=
 =?utf-8?B?QjdNa2YyMkU4NWNubmJ6eVZqWmd2MnRieTRESU45VUdMWXBmZXorMS9NeFpw?=
 =?utf-8?B?UExBYnRDS3FHWUtlVVBPRXFDN2tiT0llQTl2YkQrNlVxMEZ4NnNVZWNuVHdF?=
 =?utf-8?B?SkJ6NVF0Rm51MHFjalRNMEQ0Y2VPSWszN3hRR1Q1N3ZxdEQ2QTk2TTZ4UEFa?=
 =?utf-8?B?UzdrNkRndkpkRmRDaTY4eEpEcnNYZ3lMdVBnVTY5Ty9ialBwU2NMcmdGbjR0?=
 =?utf-8?B?bHlwNnA1WjBvK2lnMHU3K2RabTMvbVZEWFRnbm1kZmhTTW1jMlJQTGZReEVm?=
 =?utf-8?B?dUpVc2E3c1FPaUs5aEE4RkQ0MDYyNGlLSTVxMTE0MmdmelBuQVFUdHQybjJ6?=
 =?utf-8?B?VnVKQnhOOGdnRzVJbkh5MGtLbWd2SnMzV0UvejhoU0t6eDZVR3k3eHQvUEVi?=
 =?utf-8?B?SDhDREhML3lXSVNnaFVGZFp6RmJHK2xRRjExT1NLMHRjRVdWMW54MmFmN21C?=
 =?utf-8?B?emY5ZnByNy9DZnUvd3EvYUlSVFNtdG14LzlINVhqNEZla1JVRGtlREtNaEFa?=
 =?utf-8?B?R1pXVllBcDZrYWtOZmRsbUx1eUF3MitvenhVZ3VMUFRwMklQK0Rna1RFMm9l?=
 =?utf-8?B?OWZLcjAvMGlnK0hYTUNLRTU0WHF3SG1reXcrN1RMZVdFZUt3VlVlSE1YQWdI?=
 =?utf-8?B?V3VwYlI4MHoydHB6NkFJdGNzS0EyazM5VFFSZnN6bzI4cEdidlIwZWpwQWhy?=
 =?utf-8?B?bytKUWlSSU9vMW1taFlKOGE2RmpUcmFuZUdNZmFvWmc3cVRmWGh2cTFTd0tY?=
 =?utf-8?B?ckhBaWVla2NKUUdubWJGUVkzeDU2ZlA5allGWEZGZStiSGkxRExVQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761860ef-b6f1-44d0-e3f8-08de9d3c9806
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 11:21:10.8634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbCFFtI7uDaxmvKmnD6R4KTD6eJFVO/ZROzyt3II8pgm1df1Mj4PkiVi7T5ONfc3zHMQLjY789AXoOaT9w2SVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10756
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

regulator-min-microvolt in device tree is not always match the minimal
voltage in the pmic datasheet, direclty using the min value from device
tree as base may cause wrong voltage settings being written.

Directly use the min_uV from datasheet to avoid wrong settings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/pfuze100.c | 87 +++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index f864b1d8834..f055c610ad1 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -19,6 +19,7 @@
  * @name: Identify name for the regulator.
  * @type: Indicates the regulator type.
  * @uV_step: Voltage increase for each selector.
+ * @min_uV: Indicates the minimal voltage supported.
  * @vsel_reg: Register for adjust regulator voltage for normal.
  * @vsel_mask: Mask bit for setting regulator voltage for normal.
  * @stby_reg: Register for adjust regulator voltage for standby.
@@ -30,6 +31,7 @@ struct pfuze100_regulator_desc {
 	char *name;
 	enum regulator_type type;
 	unsigned int uV_step;
+	unsigned int min_uV;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
 	unsigned int stby_reg;
@@ -54,11 +56,12 @@ struct pfuze100_regulator_plat {
 		.voltage	=	(vol),				\
 	}
 
-#define PFUZE100_SW_REG(_name, base, step)				\
+#define PFUZE100_SW_REG(_name, base, step, min)				\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
 		.uV_step	=	(step),				\
+		.min_uV		=	(min),				\
 		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
 		.vsel_mask	=	0x3F,				\
 		.stby_reg	=	(base) + PFUZE100_STBY_OFFSET,	\
@@ -84,32 +87,35 @@ struct pfuze100_regulator_plat {
 		.volt_table	=	(voltages),			\
 	}
 
-#define PFUZE100_VGEN_REG(_name, base, step)				\
+#define PFUZE100_VGEN_REG(_name, base, step, min)			\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_LDO,		\
 		.uV_step	=	(step),				\
+		.min_uV		=	(min),				\
 		.vsel_reg	=	(base),				\
 		.vsel_mask	=	0xF,				\
 		.stby_reg	=	(base),				\
 		.stby_mask	=	0x20,				\
 	}
 
-#define PFUZE3000_VCC_REG(_name, base, step)				\
+#define PFUZE3000_VCC_REG(_name, base, step, min)			\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_LDO,		\
 		.uV_step	=	(step),				\
+		.min_uV		=	(min),				\
 		.vsel_reg	=	(base),				\
 		.vsel_mask	=	0x3,				\
 		.stby_reg	=	(base),				\
 		.stby_mask	=	0x20,				\
 }
 
-#define PFUZE3000_SW1_REG(_name, base, step)				\
+#define PFUZE3000_SW1_REG(_name, base, step, min)			\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
+		.min_uV		=	(min),				\
 		.uV_step	=	(step),				\
 		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
 		.vsel_mask	=	0x1F,				\
@@ -128,11 +134,12 @@ struct pfuze100_regulator_plat {
 		.stby_mask	=	0x7,				\
 	}
 
-#define PFUZE3000_SW3_REG(_name, base, step)				\
+#define PFUZE3000_SW3_REG(_name, base, step, min)			\
 	{								\
 		.name		=	#_name,				\
 		.type		=	REGULATOR_TYPE_BUCK,		\
 		.uV_step	=	(step),				\
+		.min_uV		=	(min),				\
 		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
 		.vsel_mask	=	0xF,				\
 		.stby_reg	=	(base) + PFUZE100_STBY_OFFSET,	\
@@ -157,55 +164,55 @@ static unsigned int pfuze3000_sw2lo[] = {
 
 /* PFUZE100 */
 static struct pfuze100_regulator_desc pfuze100_regulators[] = {
-	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000),
-	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 25000),
-	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000),
-	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000),
-	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000),
-	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 25000),
+	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, 300000),
+	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 25000, 300000),
+	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, 400000),
+	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, 400000),
+	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, 400000),
+	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 25000, 400000),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
-	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 50000),
-	PFUZE100_VGEN_REG(vgen2, PFUZE100_VGEN2VOL, 50000),
-	PFUZE100_VGEN_REG(vgen3, PFUZE100_VGEN3VOL, 100000),
-	PFUZE100_VGEN_REG(vgen4, PFUZE100_VGEN4VOL, 100000),
-	PFUZE100_VGEN_REG(vgen5, PFUZE100_VGEN5VOL, 100000),
-	PFUZE100_VGEN_REG(vgen6, PFUZE100_VGEN6VOL, 100000),
+	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 50000, 800000),
+	PFUZE100_VGEN_REG(vgen2, PFUZE100_VGEN2VOL, 50000, 1800000),
+	PFUZE100_VGEN_REG(vgen3, PFUZE100_VGEN3VOL, 100000, 1800000),
+	PFUZE100_VGEN_REG(vgen4, PFUZE100_VGEN4VOL, 100000, 1800000),
+	PFUZE100_VGEN_REG(vgen5, PFUZE100_VGEN5VOL, 100000, 1800000),
+	PFUZE100_VGEN_REG(vgen6, PFUZE100_VGEN6VOL, 100000, 1800000),
 };
 
 /* PFUZE200 */
 static struct pfuze100_regulator_desc pfuze200_regulators[] = {
-	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000),
-	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000),
-	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000),
-	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000),
+	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, 300000),
+	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, 400000),
+	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, 400000),
+	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, 400000),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
-	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 50000),
-	PFUZE100_VGEN_REG(vgen2, PFUZE100_VGEN2VOL, 50000),
-	PFUZE100_VGEN_REG(vgen3, PFUZE100_VGEN3VOL, 100000),
-	PFUZE100_VGEN_REG(vgen4, PFUZE100_VGEN4VOL, 100000),
-	PFUZE100_VGEN_REG(vgen5, PFUZE100_VGEN5VOL, 100000),
-	PFUZE100_VGEN_REG(vgen6, PFUZE100_VGEN6VOL, 100000),
+	PFUZE100_VGEN_REG(vgen1, PFUZE100_VGEN1VOL, 50000, 800000),
+	PFUZE100_VGEN_REG(vgen2, PFUZE100_VGEN2VOL, 50000, 800000),
+	PFUZE100_VGEN_REG(vgen3, PFUZE100_VGEN3VOL, 100000, 1800000),
+	PFUZE100_VGEN_REG(vgen4, PFUZE100_VGEN4VOL, 100000, 1800000),
+	PFUZE100_VGEN_REG(vgen5, PFUZE100_VGEN5VOL, 100000, 1800000),
+	PFUZE100_VGEN_REG(vgen6, PFUZE100_VGEN6VOL, 100000, 1800000),
 };
 
 /* PFUZE3000 */
 static struct pfuze100_regulator_desc pfuze3000_regulators[] = {
-	PFUZE3000_SW1_REG(sw1a, PFUZE100_SW1ABVOL, 25000),
-	PFUZE3000_SW1_REG(sw1b, PFUZE100_SW1CVOL, 25000),
+	PFUZE3000_SW1_REG(sw1a, PFUZE100_SW1ABVOL, 25000, 700000),
+	PFUZE3000_SW1_REG(sw1b, PFUZE100_SW1CVOL, 25000, 700000),
 	PFUZE100_SWB_REG(sw2, PFUZE100_SW2VOL, 0x7, 50000, pfuze3000_sw2lo),
-	PFUZE3000_SW3_REG(sw3, PFUZE100_SW3AVOL, 50000),
+	PFUZE3000_SW3_REG(sw3, PFUZE100_SW3AVOL, 50000, 900000),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze3000_vsnvs),
 	PFUZE100_FIXED_REG(vrefddr, PFUZE100_VREFDDRCON, 750000),
-	PFUZE100_VGEN_REG(vldo1, PFUZE100_VGEN1VOL, 100000),
-	PFUZE100_VGEN_REG(vldo2, PFUZE100_VGEN2VOL, 50000),
-	PFUZE3000_VCC_REG(vccsd, PFUZE100_VGEN3VOL, 150000),
-	PFUZE3000_VCC_REG(v33, PFUZE100_VGEN4VOL, 150000),
-	PFUZE100_VGEN_REG(vldo3, PFUZE100_VGEN5VOL, 100000),
-	PFUZE100_VGEN_REG(vldo4, PFUZE100_VGEN6VOL, 100000),
+	PFUZE100_VGEN_REG(vldo1, PFUZE100_VGEN1VOL, 100000, 1800000),
+	PFUZE100_VGEN_REG(vldo2, PFUZE100_VGEN2VOL, 50000, 800000),
+	PFUZE3000_VCC_REG(vccsd, PFUZE100_VGEN3VOL, 150000, 2850000),
+	PFUZE3000_VCC_REG(v33, PFUZE100_VGEN4VOL, 150000, 2850000),
+	PFUZE100_VGEN_REG(vldo3, PFUZE100_VGEN5VOL, 100000, 1800000),
+	PFUZE100_VGEN_REG(vldo4, PFUZE100_VGEN6VOL, 100000, 1800000),
 };
 
 #define MODE(_id, _val, _name) { \
@@ -436,7 +443,7 @@ static int pfuze100_regulator_enable(struct udevice *dev, int op, bool *enable)
 static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 {
 	int i;
-	int val;
+	int val, min_uV;
 	struct pfuze100_regulator_plat *plat = dev_get_plat(dev);
 	struct pfuze100_regulator_desc *desc = plat->desc;
 	struct dm_regulator_uclass_plat *uc_pdata =
@@ -461,7 +468,8 @@ static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 			if (val < 0)
 				return val;
 			val &= desc->vsel_mask;
-			*uV = uc_pdata->min_uV + (int)val * desc->uV_step;
+			min_uV = desc->min_uV ?: uc_pdata->min_uV;
+			*uV = min_uV + (int)val * desc->uV_step;
 		}
 
 		return 0;
@@ -487,9 +495,10 @@ static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 			debug("Need to provide min_uV in dts.\n");
 			return -EINVAL;
 		}
+		min_uV = desc->min_uV ?: uc_pdata->min_uV;
 		return pmic_clrsetbits(dev->parent, desc->vsel_reg,
 				       desc->vsel_mask,
-				       (*uV - uc_pdata->min_uV) / desc->uV_step);
+				       (*uV - min_uV) / desc->uV_step);
 	}
 
 	return 0;

-- 
2.51.0

