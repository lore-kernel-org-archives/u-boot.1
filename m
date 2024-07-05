Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB1FC2BD09
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 13:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E05C88286;
	Sat,  6 Jul 2024 15:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="kVJmEL8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0813C889DF; Fri,  5 Jul 2024 22:30:13 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE7C388629
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 22:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxy/XwVJQhBhwabc14sSUwLJR/7syXAhmSA3ZUpYnDeCAFU3Xhw+nBwtrgbWzpbbKWxAs0KFXsMDeXIku0kY0eayFTfyvroOjuQvmR9gMT/w6KPRzUOY/DjsWB1lbT9RyPp30TILl2jFamtwPYKRYmeUaJX3KdkfxymSg9QXAlBfIxi4sAym0ikVRLaNkM17yaExiSWfhzl3p9/7R4S7vCrUzry5zjq3vlUb5l8GGHgGvFtA2/qimGsbYLrSe7QZEUiucNeGhFluQ7IUVNpv11EOgbn1aEFujnNLlZoHvD1sOKuLUGmNGgfHZOptH6OjmZ41zutJ9dN1LKFZ9I8wcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVEgUDUC2fQNP/SUkKT+VRvooEL7BFnX3OmurkmfLSM=;
 b=PHtaRWnC8oAaz55y0UgPcjFw54/RXIY3ynJMLWWAtcceABXfJDWhvKRdzREmg7BKI7l2Widi/yVjk2UbXe72A5Trg9gb5+pQ40WSJAzSRLwM9ijt249Lv7mFVKqf5f3OJmiiUF4W5uuP0AArrpEEyqyES+Q7BpiA0oGVW/c+HUhRFDeJUDA5pW0DSRe1FMPaD9NvMWMin2aJWZWGlf4IXotmwkEOnXS/X+9Xvu0IeexX+nAOAzWE77qzJYGLruPQEmtSdVyR/jnArpwoDNeXtv5wjnL0BEUdEVRrKEEgfKQqc0gWXu55wX3W4ohc1dY6gnpRaaRTmHBOK+htTBORSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVEgUDUC2fQNP/SUkKT+VRvooEL7BFnX3OmurkmfLSM=;
 b=kVJmEL8SaXeJG95wiQoJaHA/Mpq+e9ZTOj6paciVAO0qM+IoQJT+fnzW20mdd1kus8Hvja5E8HsN9VumhmwskbSb8Sic1dQ7W4xnnfOI8+AoA14ije5FRup54LdRwud3GdSFlSG120Ni1amCdVTbC+qwzadLxLhUr9Y18stmkgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 20:30:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 20:30:07 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/5] kbuild: Allow DTB overlays to built into .dtbo.S files
Date: Fri,  5 Jul 2024 22:29:51 +0200
Message-ID: <20240705202954.1149590-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
References: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0111.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 61078d37-93e1-434f-9fa4-08dc9d3142a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NMGnq2KVQupOK8yRhqFLlml/8fUumySyShYFKZqrrJkfrIAGf/OvjuEeym0b?=
 =?us-ascii?Q?issViKds0mabyPs+lFKsuzzc1gLDmAKOBpA1dYOaX2+BPe1JaOUct6HsT0Ig?=
 =?us-ascii?Q?/VyDtMYW5w+RslnZ6Oo/liuF/ojD4r2cpMV39eKEVqNL4b6tfEsvm5Ky+u7q?=
 =?us-ascii?Q?wp/WHRtj05EBzg9XBC0rf/IaEYe4Yu2rpezsgcf5scwbdOoVIVtcKuODkzBO?=
 =?us-ascii?Q?fxFspfx2QILIcvnigjKyOOLdl2/0OcBPtJf/JtuqZ6VyiFsAXgtOTChXy1mW?=
 =?us-ascii?Q?4qUOGAqWqqpo4Ft0PyyssLdkjML42ATSlkh9bR2WElgXPjLSgafcvQkMDVna?=
 =?us-ascii?Q?/4IBTjodL1AuiF640khilnakRIsG/Gk2T1mhGP3UOgDABGci3ZL9+fWKF0Uv?=
 =?us-ascii?Q?qIGXXbW/6kACtk+HLnPUAHNn10EYe8gUzBO+a1bihBkAGL6YTluhyYAHnr+e?=
 =?us-ascii?Q?kBnwV6YULELJueI86lZuVA9bliAkJoSfXxOOfS32eEI7kv9P9Yw5ePpMq+cW?=
 =?us-ascii?Q?Lv3Zs4GyoCGeoxPdqNgK2doAxSdYW9LQlpPHZqQ73JybBrsZmYO4FO7fJ8oI?=
 =?us-ascii?Q?Cjtw4jJd5O53Nl6u3gO5p7A7JuBRkqQKxD2ed1dMsySpYfSgDPUfFo3dfok9?=
 =?us-ascii?Q?+eHCiqE7RZ+7jUgOs+od0MgpA1V0l1w5plHRtPfx47MzXtf8XLi0hkYNpgET?=
 =?us-ascii?Q?AvKq61W/DEVFMDV3Ch09buMT2uWq5LIkN2vOXPSkRW4IhdImjlgUqGyDkTIC?=
 =?us-ascii?Q?WEg6eiO9+t1owu7X8C5Kwh0fxGyEcwkCx+7hODKdREkj9/T9qbXlJmvQN52+?=
 =?us-ascii?Q?nULDpXLc4e2iNK0iI10uJBRIFCFY+7b3TxfjYpZ9/Xz26zrgMkre5nhV/k4X?=
 =?us-ascii?Q?6hTTE7Rk7A3V9lTKhgzvynB3H4bZwDG3Cd1Dxn6+XEmCZv9+khSXAzbHB8MT?=
 =?us-ascii?Q?3NhvgEv2ALz41gSnjH+mou1BZZekVQ8I0tSn75QzcA628IWcsRTbQXtbnEJT?=
 =?us-ascii?Q?Oh4HE02bANnQzhPQgD0uzdUR00/Uamoq6pWw5RuIWTQVdDumiLe1Ne2u/cZT?=
 =?us-ascii?Q?r7yXLN8+g+8F6y76oVkWYm8MUYYdfqzkmTQ1AbdJzFICHs+7C9dQrp1ayRUL?=
 =?us-ascii?Q?UGE6fR83RDX4G7CVSaihZJnodMa/XZ/49jZ8aJyEZ+Hssr/8gDByDHnwZUAL?=
 =?us-ascii?Q?WVuKSX7hhSTukpH2jNsh/D5ZiISexVHppuhHMQ+VmTcTSDuH1V+DtecmD+iB?=
 =?us-ascii?Q?QIeMRQSAz1ZJI1myuHuN8+v4Y/aol6ff29zfDELD3EXVbyipCeXVCwxpb3CA?=
 =?us-ascii?Q?y4j989hSvpRWIsYpzjqrNQQING0u0lCShLByp8KkQW5q+kWcJgYj9eifwOAI?=
 =?us-ascii?Q?oO+za8uWCL4GGvGaH+b4Oh9GPKmr95WgywhpEShsbG9T3RRhNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GeEYgLHogKDHyJfel4CvrkwRAkBmX5OOxXgMXQ6fftoVvV6AvikPFUZULUv5?=
 =?us-ascii?Q?5h03ikoB3pW2ChUOs81Ud6CtRwNzTYG+78orprBZM52fpNsIoYJALG23XjXL?=
 =?us-ascii?Q?IDdteivo4s+4mZ7qpOI2f21ov39nq7eyStGuLg29NJ0g5kS3Fz9feam5aurB?=
 =?us-ascii?Q?HedZABugRqq0maXlZOt+s85EXmvrR7H6q4K2b77zOQp+LCcsnLEbflUyJc16?=
 =?us-ascii?Q?APkg3TyniTtYItWYaSWw8JNUSKCDjzQ81OwGba+0+183KHVN4nRo3mkjvIbQ?=
 =?us-ascii?Q?rB1jCa6wSEteNtcuRUqKuhQjAczQA4gj4EkZoT0oiFfQk/on7XUZd7ErlDS7?=
 =?us-ascii?Q?4Qct5Mva2FuME/YBZLo/k9qGuJBu1qEm0ob1nwkTZwI4SlVK16XoijQHl0PZ?=
 =?us-ascii?Q?vDMbLJVJoaAmTvj6xQMUIq3VGnN0P4cTEFB7MnKzZ6IMI84IzDJ0pBw1Jxis?=
 =?us-ascii?Q?2XKQ7uiUpHyh+vmhYE07ArDP6+gesvPciolh8m/9J9FQF63aVuS0MqZvL1nq?=
 =?us-ascii?Q?ZB+vNmT7xtOQWzWZumGaFO0AhE24/PgEAuxJIuvhERcrHyLWDewswfEEdJAw?=
 =?us-ascii?Q?zLLU4EecqQ0fbyOuHQJoEsPut8VY+ba89dGThhBMws4RTPOQV7rIwYX76uFQ?=
 =?us-ascii?Q?Te1/XAASiV2jukdOyo8w4KS4UN63zBYXPZGtJdXvmYoI/xc2kQbQ7XbShlN0?=
 =?us-ascii?Q?HLmdqXnaS26URw8QkRKphH7K+lSK1r8JQxMekf802Sv1T9/kCTppurHE2N2C?=
 =?us-ascii?Q?aX3vEQ9gJ14yz0i3jdEU5j8SSwrvDcvhla/tFA0eDKhiuAJys9NItLdBuedA?=
 =?us-ascii?Q?CQM4kaXtAMopbQCmaTukrRStl8O4TgTp7x3RDoKYacbR48JCWHt/tpUBihgh?=
 =?us-ascii?Q?hBnnP2W3n0HWxYbG2IkRNZYAbgmCTeTBmSi0FSv2p3ScQzusPs2oPekI7g0d?=
 =?us-ascii?Q?L07ZqdXl/LaWnwn3tPOw25iHljrQWGczDOG+qdWwEpQlPKhy2Ms/BR8eFBUv?=
 =?us-ascii?Q?JbIiStHC8vkh8yqjPV7B/nd+BPnp0osmPSFaxVzFLoAXye8g2cpDS31+p3kJ?=
 =?us-ascii?Q?K8a6rUbZ+avdAk2OUVO7V/7raq7jq3oADlQkWqijmbOKSCp8X2RdePDfXIPS?=
 =?us-ascii?Q?FAkG09Q8UQsgICLMYIFpcMpWK6y2n1rk7hp71P6SC6YZxr083eDtGG2lnnfP?=
 =?us-ascii?Q?lt6A5BScu7FlQ97Q+Knccx2nGKW4JVfxpaL9SJyic/8DsZvEZJrmp0NPSY1z?=
 =?us-ascii?Q?mY92TpUtamB63VHzkmbuA8S96CKL23QD4QSXD8GbDF6LjT/nvwHEfjX16OQJ?=
 =?us-ascii?Q?Ix2Rtc74i07GWGRMrp2fn1eSRmZOum10IiOfskQWKDuTEre4MEBiwfA9Ay5Z?=
 =?us-ascii?Q?eobAIeCrDvPDA4bcshb8RMRsCkjq/468vd2pvrCN1P59rFJEX52oQqpLBAYD?=
 =?us-ascii?Q?TXp0Xzz9sCvqU3/ldyFGUpPjWamhsy0qagJwuITQ7OVUbRtaSvG3B80WiEk+?=
 =?us-ascii?Q?XSjPbdpuxiO4564NAXiqFUTXfUSGrNBbrZpggoYYs1F0IYpMFIjDMFUCLGP4?=
 =?us-ascii?Q?IqYQIGOL/nzGfMxiQYuAgqanYjSqhzw721VourBX/Om+Zn4NtmHW4XaH2d7r?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 61078d37-93e1-434f-9fa4-08dc9d3142a5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:30:07.7451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lqUYbMknHMe0Vd5of9nhU16RUCemd78C62yW7g+3ZOCSwT0qkPAcH8/GfdRNHKxXrksRvqzOeTiGIQol2jn7M0c6zBA9A2nT9BQ1061O6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6307
X-Mailman-Approved-At: Sat, 06 Jul 2024 15:37:18 +0200
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

