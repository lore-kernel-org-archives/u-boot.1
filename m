Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA0C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 07:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73972886F1;
	Wed, 10 Jul 2024 09:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="XT9Dp2jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F4788714; Wed, 10 Jul 2024 09:17:35 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D588F88707
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqW+9THx0lIG8it+VN/wwa1wDy/vAxjVcV3xOIIrn5EArWNQwstpz/mnqlfvXUMrOsaVyQdRlpkI67dOVK9uG4DrUbcS5mt+0kZhuDyCGOcwlSDY+lkxaQZZlRl42ePdwH3c6joO7WrWKubTiwaFP+LHcIOMr+s6u1jYj4h1nr8f7Uri2h6QydML/rrCcL2zZXRG5fpaC7Wj9XL4KrgnaRXoq/PJtWVFzscmQsxgZmhFURP3Oh9s7qN8ZC+a4etM7Zq30yH5ZEvShqTY3Nh6u5kxfume5qdiHLypZX/3d5DBLKk/uJl5tY2EyOgbO3OooC2CqOdFlAXK8b35cVhwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVEgUDUC2fQNP/SUkKT+VRvooEL7BFnX3OmurkmfLSM=;
 b=O4h0qgQXeQ7K6AuSSgjdb2qQsA/oADYf4N722iuCIqnPElrT3EV8EPscg5m8MwEG2C02yF5WiCackJm3/Cf6dvBjL3A6yhet4Y5GY0rT/G6W6jD4XAQeUkEfbezXKAM/8RIJLVb7Tr9SUwFD5GkcSV7B9qRV+qFR94fOzMThuBuvLAlW6wDgBYd7f95aiTd+QZQgBtyhxjHZdEZlgfDkYJmBsCsRWV2kB/6UxAtWE/7ZgUi5RtbYUaMmWvE/fb9MKCD62EAJFTwrIyXKjGK+yR7Diq+1Ujq+SCG9JEoGMBbd9KUTG2IqrjwT6DsqYhY3cwyYSmnTFTXvSe7CMAqdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVEgUDUC2fQNP/SUkKT+VRvooEL7BFnX3OmurkmfLSM=;
 b=XT9Dp2jl/ZrHQRye3BSzbagjsNhsji+j3yMrqUlnvL8NTHKEdg4FFOr2iVBVkoEf6INOH0FbRrd4DpnwJJvNcRAyj1JMp3z9U2k68zxsfNXGTK3MQPGQomwkbnhYHEsozY151N1prUTBpYybvdQ0KmxJVJu3VQE19JpOCGEOnrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Wed, 10 Jul
 2024 07:17:31 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 07:17:30 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 2/5] kbuild: Allow DTB overlays to built into .dtbo.S files
Date: Wed, 10 Jul 2024 09:16:09 +0200
Message-ID: <20240710071612.1717460-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0107.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::10) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: c13129b8-9aa2-4240-2b51-08dca0b05c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L9UZm/+XLi3B4c13TbUBFUJek2VG7xEJaV69RpJd4Z0nJ6zJ8uuUq60GonmY?=
 =?us-ascii?Q?6YSYpd78gl/NRY/eI+YhzZI1uPg/Cexc1xl3twEX4IeAK95bDOBRHpAop/hx?=
 =?us-ascii?Q?Oie/gPpkF7ZOeOay9I6B19DgxYmtWOMSZFWOW3vCyK6ZUYdbcy4onNcVq28f?=
 =?us-ascii?Q?xv4hJ1AgwJ9RFyH4DbPF4L6e6Rdugsu3kh/jq0u6U7DUE3osN4alH3LF6IiY?=
 =?us-ascii?Q?6xUdIt1wnR3UFZCoUfK3a2YKo87ney3KC6vhW5u4goYhDw3FBiEjqbVRgzFr?=
 =?us-ascii?Q?gZqvD47TMH2YO6rTCmIe1hAOywHvnCMZdcWbW8zY5li+Kh9nUjqWeYE+y1jw?=
 =?us-ascii?Q?h7oZVeouCH63PowxFXHZVrWzDahiKGg2C9CZdjVCtKEA9N20CzOdUBsr1XjK?=
 =?us-ascii?Q?4taaq6MHBuRt7codVW9JuscQRvI31SlPQ6cObEMRMPjG8OaOIrulpFDgtBFO?=
 =?us-ascii?Q?KVR22jB1rjgzwroGurRDwwIEYYBBvYNTEQo6UaYUJVlbxcks9eeZFjTtAfGB?=
 =?us-ascii?Q?hKEFX1nPfCHb0C7L3uU/OncuYxXyTwdxq3ET9XxVteqz0HAIeMDapqQLLP1t?=
 =?us-ascii?Q?2sSXfnXyBNdpr6eapJEZHMd6HUQ8ePp3DR0PgP00ShhZtwc0VSCG2Y5j2rTr?=
 =?us-ascii?Q?8EtwUlxQUuAXBRZZQdXdJgazX5ruCuIc1IxtJBNxUSh6ol0X0ZZ2AKjfZVZf?=
 =?us-ascii?Q?2nQ5Sx9Ximl/LiTOR8grPF8kS/Own6kp2kXyF2qdN4vkFUqC/elZ3kK9m5Jg?=
 =?us-ascii?Q?qrERpID7x4Uyn1RHzcX8xWLu+dAQ4dwLk6MyfZVb98wiWddKKZzMCtzTGmnI?=
 =?us-ascii?Q?Oq+tIqp/X9FaTMe9PnrPyqXTK1C3gC/kKDg1Nsa73qHYIgr63JusS6/lXELV?=
 =?us-ascii?Q?Sqw66d3Ik0fVanFZ7QU8HedKRIKTPv51rEcEUdYEWb/zwMvqBSF20HVhOb9o?=
 =?us-ascii?Q?DXT5AvYhEk8Ja2kf/hel6r2y57VeaLfaTYPbVFkZawa1JKhM899D1smkpa8V?=
 =?us-ascii?Q?yNjiAIj/PS17PJC4i79kC+WE/vK/lFVKvzPufRbTjJgWIujnCOJcsVvQ/eaO?=
 =?us-ascii?Q?Kx4Uh/ZGq8YllSl/H2TMsufGtI0bjf8c84gWsU5Lv7ued4Ei3GaHXRTC9mb9?=
 =?us-ascii?Q?uBHGFIcL0jIVpLMRb6zV9q3oTAk64bhYAEnaRoCj3D7X3FNJRH+5J5WyDyeo?=
 =?us-ascii?Q?7xBtk4xpsPjdGFuO4pD1SK2VsmatnEKbgaGxMwwst4ALKU6MgxR78bwlsqWz?=
 =?us-ascii?Q?OA5C3KZv2da7GoC0o5ie+SjMlcFMVYzYczrDLJXx2g+e0zMNp31efFQOKIQr?=
 =?us-ascii?Q?7mV5IezeeIdC8vpWb6ZOhjuLzzeGDK40Kpr+Wn+vqqB+YWbdqdnvAYMFIMR7?=
 =?us-ascii?Q?pSQk5JZbQAjj6ls8oknTz0h9jBLmexoZLcIrmp+bYqFzqPfwrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KEb1/AHeq1Iqcse7nk0HAqHZFPKP6F3ndVC42NWiE+PzL3Nr/Lj3QObQRP9N?=
 =?us-ascii?Q?iKCWlxHVOug7vayi+5H90wxo44llJn/xkmZKxtIRe1Ey/qpHC3RVeQFJWq1x?=
 =?us-ascii?Q?tQoW2sSDUP1U6HX5Flss2xnZLZhrJ49t0mM8bhwd2YfLCmr09XKQ84LgIL/6?=
 =?us-ascii?Q?ScB3UTNBct/CiGhDwkvo2tyBg3Jf2NORzxI6FeVwZPqlmc6ZCVGw+tKmAJOR?=
 =?us-ascii?Q?UYY5lOuWj1My3J7KnHy420ic26Y8+F1PSfYdgKn+ZgFHUGsOG9012UFRWqH4?=
 =?us-ascii?Q?bSvhm2CU96UFLuoloqqZ8oSXMGXeBmuq6+vrYglHeY1mxFbHIKbIXXGMrE9c?=
 =?us-ascii?Q?2M7dkmz0lJStg5vvMNniPv3EdK1TF6xMvwlu+4Ioyz5TAXJf20aE1mahgfas?=
 =?us-ascii?Q?2/LAay+x7ax29eHnm90M6Sf3R7wzjR/DfmmaJfS7cHt2WSd0s1Fn3ydMezdk?=
 =?us-ascii?Q?Hur8GePPYNGWX6x7hB3LegTHHA3g7FWhFPYmkgu2mJ97H0lkJjTBv50D0UbD?=
 =?us-ascii?Q?FZMBALqS1F6WiKb1qq+poEf2Bmg5usVUIYpht97lqd5gGkDrrS0RU5rcEr+X?=
 =?us-ascii?Q?8ymsMqtA7E8HAgaHhNaSDqmO1uGwwgUSMDnLiPq4i1ERqWWmm9xNmubgGMIM?=
 =?us-ascii?Q?hKHHihN2Bv8CnUu9UebaT6sfztCq1EJo8dNnlPdXQRLjY/lsGNFy04FgfIPI?=
 =?us-ascii?Q?9c5GtDWa5wUrH4aCv/Q47DgLZoBoEbRIddCpKikuUt5uolCOEvXnh6Mw9ZH7?=
 =?us-ascii?Q?Daes206/YqVMiiRQeVdsx6MKUcoqMJ1FoWjReXloihTmme+HQ7OmKsuYRuXp?=
 =?us-ascii?Q?vJR777SfxxqiG9jRv052RRpkNxV/iuFDvP+JagIh3CQpYIc0VYBT+XL8WOIR?=
 =?us-ascii?Q?XJsPxjiAI0JgVfHZaTIhynvaF6KVXvy0ZpMlCsf0/Nu6IvVTio5Tru8CnmUf?=
 =?us-ascii?Q?Y1DO2DPKWb/S/FCZxltff5wHAVP7diZHpbba8AIYxnT2CcVhI5jgb79KopOI?=
 =?us-ascii?Q?WECewh67/7e6eo4r8IvcZf5M9CcWC7K67g75Kpct9Rit841ESQoyqvEobsYV?=
 =?us-ascii?Q?c3JrTp+CgHdWFvOHd14GcWrDDAJT3XRDngD+p7tw0FfO5nRkDYmGUTV6dPm/?=
 =?us-ascii?Q?B+TXiDXNmR6WqF9j1DrIard0qDW5BNnXX1OJNSa+GsKeMCJdFtTiG7hertwD?=
 =?us-ascii?Q?FFSqLoKMOPHVSGse6GeAJDKXGKEMf544G/N35PnxUV1doM19ekQmHUNSdRtl?=
 =?us-ascii?Q?IMLA1zTrcZBD/tRIVRn1ch2z7985TtE3dkx/2yARnmrVYLB2eOauTktLIP95?=
 =?us-ascii?Q?vyfwKsWwmvG7FHRdaekz1pHD97TYXT2nacEYaiCcMxavso4kd2UWPKwvGJZx?=
 =?us-ascii?Q?tKVuJ8CcTwHq6AzzqbAzG8irkBEOoxiIHyQuknU3PSU3ZB/gR92cbvCo1xtW?=
 =?us-ascii?Q?z1PMnTz38MjTvQQJ0Ubv4QaEW8kcZmGjNpjZSNxJz5RFJyVUXW9b4biiXvm8?=
 =?us-ascii?Q?fV3t5QC3uQeOOQvwOUsan+tag60qsmTYvOVp0LdvmntWJYc0MnUIVXNgk7Vs?=
 =?us-ascii?Q?hVygAxQoqHU4rV7OjCQH8pE+enVrWegjT3F+5Hf+wAmk1H2oig/jgSC8l2AP?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c13129b8-9aa2-4240-2b51-08dca0b05c57
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 07:17:30.4948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuE+PAqz+tC98Kl14hKEBl2GHOcFn+ua3hwSfS869CQIBI2FunKiHNc4ez5f3IUnT+kliQGIOhPGETxoKc3Bea6vPeEJ9plQ4rn6ExYMna0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8831
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

[linux commit 941214a512d8, modified for U-Boot by removing the
include of vmlinux.lds.h and replacing STRUCT_ALIGNMENT by 16.]

DTB files can be built into the kernel by converting them to assembly
files then assembling them into object files. We extend this here
for DTB overlays with the .dtso extensions.

We change the start and end delimiting tag prefix to make it clear that
this data came from overlay files.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 scripts/Makefile.lib | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3e68d5aa803..549c3619472 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -305,7 +305,7 @@ endif
 DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
 
 # Generate an assembly file to wrap the output of the device tree compiler
-quiet_cmd_dt_S_dtb= DTB     $@
+quiet_cmd_dt_S_dtb= DTBS    $@
 # Modified for U-Boot
 cmd_dt_S_dtb=						\
 (							\
@@ -322,6 +322,24 @@ cmd_dt_S_dtb=						\
 $(obj)/%.dtb.S: $(obj)/%.dtb
 	$(call cmd,dt_S_dtb)
 
+# Generate an assembly file to wrap the output of the device tree compiler
+quiet_cmd_dt_S_dtbo= DTBOS   $@
+# Modified for U-Boot
+cmd_dt_S_dtbo=						\
+{							\
+	echo '.section .dtb.init.rodata,"a"';		\
+	echo '.balign 16';				\
+	echo '.global __dtbo_$(subst -,_,$(*F))_begin';	\
+	echo '__dtbo_$(subst -,_,$(*F))_begin:';	\
+	echo '.incbin "$<" ';				\
+	echo '__dtbo_$(subst -,_,$(*F))_end:';		\
+	echo '.global __dtbo_$(subst -,_,$(*F))_end';	\
+	echo '.balign 16';				\
+} > $@
+
+$(obj)/%.dtbo.S: $(obj)/%.dtbo
+	$(call cmd,dt_S_dtbo)
+
 ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
 DTC_FLAGS += -@
 endif
-- 
2.45.2

