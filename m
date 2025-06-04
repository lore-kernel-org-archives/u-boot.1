Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B049BC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F1081F0D;
	Wed,  4 Jun 2025 21:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NCc/Z/pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AEDE82998; Wed,  4 Jun 2025 21:56:23 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5627F800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIHDtzu6U2O0GjPUjAVcp0hb2+A5Pv+BFJ/I9j9o6CrVKoUGR47aATqfNU3DJXaYnpSWYxGgkmBNVP6y52Ypoy4orPR5rs1OLIMOX9JErtaVOF0UMxh6+IbtoGJUNnyezIH041DUTEtpDdAo0jF2t7PyGRXl212ri82H7RjeBtEG5LfN+RMRMCeoE+4lmK/CYEPzVAc0Jw2CeB6w+w9xm+FV2X3+dOVw0LHL+mZQhDFDz1djlEr4Acn0rlchcSyaaGfJ4IT7KccjHreKKl2oBKBMsKIo9QA+3TUmLMyCASX0eglOujHWvFyQcFj0oYsy/3yL3fz+4RlRcUoPbtxT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd9d/chYZOtiJ2g7MjUtKth1HRmUs/yns/tH8ucpai0=;
 b=H2u6AbsR87lnOscD/7YzMswMzk9L+GXBSoGltGss10oxdIyMPYR0+6FcJU+GffQsZdFev6PN9Pkykyw1RVXEGhrVN+o7aw/7IweYjua2qqWsMd/R7EAFOdH+hQwwbbu87rnP5eDrCiAdIpbhYi1C04DixkLcDnKpQFvh5H/PdbycJc/O3BqypGIoQ52L6KlirKbgM37gdm9TCUjqdqYcwT6RLisDxwQQIWPYFSHrp/kdfM1jKrhUdwJO2+v6xPjW81+El11fREmOCOeh466Zv3dvZPGs2OiU8hHJCOraJWxKIebvIDpZGFJbC0TKPFURMoC1H37N/FAFbJ4QOukiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd9d/chYZOtiJ2g7MjUtKth1HRmUs/yns/tH8ucpai0=;
 b=NCc/Z/pnLTXOzjugTHgJOPrGyIqTKPp4NcxkzX1W5epxGwh7JWz7hKUay+i1ZgJ7iJyscOA4eSwpq9+inxt3iGzXKnEAvEzWD96f5bl7FmcVF2Od8V3xVndyyX3FYb/JndIJNlxDvgYFRXLRK0q1xclXo1RvDbGyJsZ2HQ267iM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:19 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 04/12] microblaze: drop volatile qualifier from gd pointer
Date: Wed,  4 Jun 2025 21:56:04 +0200
Message-ID: <20250604195612.2312979-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: c97ab7f2-b225-45e5-3cf7-08dda3a1dfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Aeogp/UHJVYp7B7IoZhdHdi9IYpRMhSM0WNrWicv2CVPyChlTwkzOhIqFHD?=
 =?us-ascii?Q?4yP0osU2pfL2nDdz3daKwxni2JLtVu4CQL2S16vhivfI4GUJ6mPHNDVdhRvu?=
 =?us-ascii?Q?HeLpECFXPc3AVsom54zo8RveNWAufKFXL8VAhSN5KwH56+zkfs9ndnx0nIMJ?=
 =?us-ascii?Q?dapHqkSqglUFo+rB5Tg+jUmNShGdrP2SVuKKQXf48QgSXrbx8cJqZ9HGZBwc?=
 =?us-ascii?Q?jG6F2aqOW7Lll0StEYksnljrMHZzm4dw5rWWDW47nNiCoO2gBYTw1BCzaxJn?=
 =?us-ascii?Q?WAYCTYR5uJ+sTG+OoTxIExCtL+avwRUlTZDylyiux1gy0jT3nNBEpreFpIwG?=
 =?us-ascii?Q?7UWFPj5CXsdXx9r6M0vS0batz2FOd016vrwuj5XtrIW4v8TxXrgWI0o+5dj4?=
 =?us-ascii?Q?fesEdT4s7vZx9uE1YfXNJ1AsDQ6iHi3RuWJVmO06F4WH7sV4ZNzEjzUI+tHb?=
 =?us-ascii?Q?a6cLhY6KRSlOCh+fPnUGJVyfvs40fki61T4ar/QrS30302D4/Im69QO9DfQv?=
 =?us-ascii?Q?tIMtYFp07sm1k3NoDzh1U2KA/JHnAe+hkBtd+MqKbwlxjD78fJF/ZU99vfHa?=
 =?us-ascii?Q?ybhQk72lovgSiBSogx09vFqed7cIr99ABCXSYYwjvCa4DqoBPhg7TNnKjhAK?=
 =?us-ascii?Q?eHAtHQxiWOwSOIndbEf760suuaiin70mrtFRcytGWjX64FA9P74+vWGqxnpT?=
 =?us-ascii?Q?dkoy6yRbgf8eRdnsLw03PgiZ8J556F1BH/ug3t5XZm5q0tCohz1Y7L2+QvdE?=
 =?us-ascii?Q?sOpCz+MHYD5hfCDA2a342pAtIIdC440vlhJH9G9y9I48Wkv4g+IR7zJcP6Tr?=
 =?us-ascii?Q?sKZhZPwiYQD+dIb2XUP2EQ20WwfMDUsHf0nCuFECl4+G6azMy8UuQoniLmK0?=
 =?us-ascii?Q?bGPxA6H9z7aAanwEPoDsmjFnT6epMa/20K3YNrW5LoqkDcShoqymbyyusDMz?=
 =?us-ascii?Q?Xh4AN7RqdKVT8nwlia6AbZo2Uqnk5N3cQP75U+IcmxH5HTyriFBoDQ0GbfYE?=
 =?us-ascii?Q?JOfeCs0IO+MduSLiZzrKnqAq819VcDkpmozF5szBMpNxmSMGaGoNQI7o/Knk?=
 =?us-ascii?Q?9NtIWTG2QU3qK2rrM3s3Hw/57ErxlLeQZUGD2eN/AmAwbmDGDd/vGg9ZYDFm?=
 =?us-ascii?Q?Uoxl4CtWHDgkoaSMmfcgvwyJGyxdkSolB04878FEbTUZYDke6ts35APZ9A6B?=
 =?us-ascii?Q?BYSj8UG+oCO75kT7SzeYTA6ieaJ/uyVVppoWf1Cao/E7wNGwr7mFmyPXPoWE?=
 =?us-ascii?Q?/Y03EjMzEYqylM+t7zDZR59YyNtIj57YSAK7mNwstUE1ytM4I8Qu4ZgaiRKe?=
 =?us-ascii?Q?B43l1YbsdpPujMd4dcZ7Pk47U+nll+6TnHhgmpG+a9PEZcf8XKzHHEVtTdHt?=
 =?us-ascii?Q?YtOcLY0fGpuos4lVoB5vnFjjUSuNRqr/uwtRgEDQyExiAb9aPqR+/3v4nTv+?=
 =?us-ascii?Q?ofce20rwye8TlKnD0NHP3ZUUISDHcffhB4tZY6c766h4EMg6dyXiQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cu5Ch6X1P0fklT1ObFf+XVG71eEqB+L9SSLLwoDgElC/9B88bwqrsQIdb6fq?=
 =?us-ascii?Q?uVzviXVuCxftYXnu80R9fVoAaeqH3cdvm+0CfYgWoQBdpVLftLrJGUs2RqJz?=
 =?us-ascii?Q?4wFbIBuUZ98PkLeoxGA1gxbgsy1/lzTZR/HPbi8Sg75pGqST4tgQVXYN8vzJ?=
 =?us-ascii?Q?iG7wkkKCrQbOtLtQyqpt/kE9Sr4T7uA9oVOsv2CtNuQw/Qwo6jTlvIqqCKBB?=
 =?us-ascii?Q?0JW5YDTPccAa5BAI6R6KCRBUxFjPwQLEVY2h4EAjnJpsOYLTAR7Brjg+5/qL?=
 =?us-ascii?Q?sPTJNlHAGAO5veN2NiTdHLqKp8lrhwtHrZOmBV3OtX7hLqUklc2jgJmTf3if?=
 =?us-ascii?Q?Azn48r4vKW0WSK3YaWBJDlLfgVDujh1akkFML9F1nslpec9FC6ZW+fywzm7t?=
 =?us-ascii?Q?LrxxgVJ/zBaRer/6nqZ7J3v7XDIlM/geYFNCAl6webYSa10Dh2NyWQyvuaCw?=
 =?us-ascii?Q?lQJSybLbIV1wf5qe1qWRAmc8OGhgywSKDQYUeJwxBBuTjA9jxeXeUHRetX2/?=
 =?us-ascii?Q?U+tjU8QUaGHbFnsKahG12bHzqsXRuZ6mrsfCQDTwAY23S8yNyejvfmok6aGE?=
 =?us-ascii?Q?t8Blyz/jyOAVcBJHf7+Z9t6Q3HYp3+fO6iX+0wXU1ljlLs1qD7wRGVm/xiS6?=
 =?us-ascii?Q?JfejxunVGYohDb2o83yZNpBtdk4UoVWqEVZiZcY29sNGpUw6GpZpE9NDE577?=
 =?us-ascii?Q?49gZif62tjW+xEa7tJZl3h62bHFOolffBOZgDcbyxpWTg4yUpSPNzt0MQpLg?=
 =?us-ascii?Q?Q1PMVAuw7tMmhnbTxJYJ6i3wAX9NzcpJAhfylasTQ+GQlVrvfB6kfy4mNXul?=
 =?us-ascii?Q?w0le13aLqGaz5CeLIut+QJ9nrO4K7BMIoEMWcEGP28LNEekcTGX+KGS+d2sC?=
 =?us-ascii?Q?WgR1yb9qLWl2Iq+Kpp/nXjKSIzb5rOaQg3m9yb8RPYejqmqkr7IetoOBh+zF?=
 =?us-ascii?Q?KshejQpalDDWs05YdQ6TpYGZl2IM8Q7KbE5q8RoBqiVhxMUq+ul3SHq08ZQj?=
 =?us-ascii?Q?KxOLguGEwODGd8dUqJLtaZnUKpZhgfO0GkvPRBKfEWXFHD0jzf6ICfXvofv2?=
 =?us-ascii?Q?//6r4bnqkNahUw8ToOBNCJYFNVH7uWvP91FCICSAsgaRXm9I8IdOckiiXa/r?=
 =?us-ascii?Q?SkFTljA9BEYhs+iUFEucYbDdTqBX9HTcbMaZo1eEP+GOf5gge2ZdASJMUzXx?=
 =?us-ascii?Q?HiTSnTXu4cxLq2vSq3t7CfbN9+lQ0yt7HxnYdcwEnIDtzIOA/CyNe9x47Y91?=
 =?us-ascii?Q?5cKLOmufIlBIp+agPQHundcmtlUMFbbutEwcCYTqehVoHdF8qKECxlvZ7tDu?=
 =?us-ascii?Q?QViE3JDhmM96oaWwyGGPCZDtqDspzHR780jQFkQxgYPAzS+vvpBmsSSP/RRc?=
 =?us-ascii?Q?KajvWnjfedngivCWiPQKwmazfYGkLwczXQTekz5NB4d7MAvrNq9Q6ZCsnktp?=
 =?us-ascii?Q?GD28AP57EfiKkvyJ6yUf0YD/V76r555Boi3o5WK5ltSNPoPUmk4PDDR9UDiT?=
 =?us-ascii?Q?y14KVChlZrvVFtwnRvPIxyi8ctqZljC8hGTQti9xIADqWPZQ6p8quXj9s6vp?=
 =?us-ascii?Q?cnF/vg4jdSSdeihZP9EgEcBDt4A7TIPPAJQRzqJ33ZWmzn8Ko/rGSseUEl6p?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c97ab7f2-b225-45e5-3cf7-08dda3a1dfd2
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:19.7866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3KU9CPtFB0ZkQ2L1+6yvfckcZaWd6BM8BfS/8zGTmhj4EoSMm1DOrr9rJR2BLcc21rdK6Z+8nL9JHyWTTG5WH4u3N0tKPsGosrEY9aicGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/microblaze/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/global_data.h b/arch/microblaze/include/asm/global_data.h
index bb4112f22a3..f7922fac41c 100644
--- a/arch/microblaze/include/asm/global_data.h
+++ b/arch/microblaze/include/asm/global_data.h
@@ -18,7 +18,7 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
-#define DECLARE_GLOBAL_DATA_PTR     register volatile gd_t *gd asm ("r31")
+#define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("r31")
 
 #define gd_cpuinfo()	((struct microblaze_cpuinfo *)&gd->arch.cpuinfo)
 
-- 
2.49.0

