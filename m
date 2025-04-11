Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F0FC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E2383F8F;
	Fri, 11 Apr 2025 10:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SIB2mCb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E356183F8F; Fri, 11 Apr 2025 10:14:09 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE8BB83F85
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1XEFjwijMQVpZ/dudqt99ri9rsel7K7VKP1btofIQUctHZgF/tXoGjGuQHFQ5N6nLgz7a8SWGXDPO6L18rGnZYSCZM5TwoNLr3yND7TPVoaK22LN8E/C0nYEQiWTbXOg4Q/p7ATiCxLHveulTSBIXFvtF4pNKE7KZ7ub6kVvGyYvZu3O/Yc7TwwblvW/3YjbWXl3I/0OS0zhPGnjoto8qmxDVE0x3sdMeL1C2ZwpdU3oHTTsb00rXyzOtwVRHzcjc3EtcVTCNPPGMvGZXP/4egVjyD7x9Iv9GXDi9jHOIz+NH0cUMe3ruqiix3uedhTu5Mo5Oldj7xdAv5BzkiQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gxLiiUFkTa5mGQFnWa6pXyRBR21ynB+BeYOqjDwN94=;
 b=mPwyVoj4U9wDOYr921pgIO8bEK341BEPxisouO4doYotIeIRyPu1z+b/+Jd34u55zvtXmmD5qtdYOWsVuMtUP76QSpQIZKQb9T66cY82A9klqYqzVrQ/YquHZiOFrFakEd6Mt4zleY+6vfwdQxZoVfMzHGwsGqZwnBaIL4JX/BKqNB1dTavgtoxu/G3oSkXq4tkvy+rX7+X3mGu88aDujSYbBtzS4U+hPyf6tgUDvZ3b08WcehYOFP8FMrO2pd20X04yoopayvs3UBrriZZidY/SvCNBoLjJJvw8Lb1/Nx0wcnFqEiKv1VSfrTWfGi+hyt+tPypFTpvMQGoaBM5+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gxLiiUFkTa5mGQFnWa6pXyRBR21ynB+BeYOqjDwN94=;
 b=SIB2mCb4fHCfU+hbgUm2rewl/jJ76U1H6apgjqU4lvYeWKYQ6qidROE0+v3q/C0Tlu/ElRo1Ds+V/IGmdzoYxof6uM7kgHpbiBzZAwMBqm5FkKyEDwAA8JrKJhVCnZAuynd3Bs+EioMkJaxV/1rUXQzMWCgL7OVMf2RAP4eghTlc66g9jcAHmqyQKs96WJ8xvG/phW7vHhxES4nuE1A3cV0krZ+XhISrHH3g1cM69IP/JBWQv8gInScNp7d7DOnr5RTQjQNQCB7BPycr35oL/+cJJ0kH/jfmP7AHGepi1TJqubjz2mQgkIRLOy0jIzhPxpCXkHlPwAg0MGMHBh7fHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Fri, 11 Apr
 2025 08:14:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:14:06 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 17/20] imx: container: add V2X container support for i.MX95
Date: Fri, 11 Apr 2025 16:07:00 +0800
Message-ID: <20250411080707.602371-18-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: f477b1be-2863-421b-a465-08dd78d0d3c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BRj1WbhbxxCgTysP686zkmbL93X4CmN9wAV+YCFPexWUjF3UlqQepllOFbJj?=
 =?us-ascii?Q?6+Fr8FdMYQS+TMMM495a1H8CC80v+9UnhHAUmeREyO+nPXxbCZc6YIbVvIfb?=
 =?us-ascii?Q?dneV46MPhgUic7CNM8sN+ZfnJAFfTWt+LQK+ZOf1rEjbA5DYlI0e6HlYXbgD?=
 =?us-ascii?Q?1mj3lV5QG4OMnDa7zjWDa200euN6Gav47u3CP6LPMBwH4uqGZegcnEIAv9bL?=
 =?us-ascii?Q?JaW0nQkMiH7oOjhZkxUjwOTdwMPHjI5XVPETRD/4PcG7ahIqrLWf1TzF1RI2?=
 =?us-ascii?Q?c/X3sSQZmSS4RkxSSCFjSAAAOxx6YknWnBV/lkm+jkLES9Hf6XVCMjAce8io?=
 =?us-ascii?Q?IXdLcFInngJXTrxOHwJZbzIDV7+9mvNU/08sdsICF+2qu/tMYrXKEVDmskNy?=
 =?us-ascii?Q?LI6zn+KeyhzxZ/SKPqlUE1pwL4Xir538rGVvi+G+TRUPG/Hnj11gjBhLp3Ic?=
 =?us-ascii?Q?bPjPAUoVf8iAPhqOJzJwhY9SGiyhfv4LmJN7wgYR/DWKayaJke7psE9HoKrB?=
 =?us-ascii?Q?PQXuKC1eY4c5vMU78VLvPv/57GsZvh660EjENh4B2OiZWAYh5hS/EdHCG+s8?=
 =?us-ascii?Q?QycGLGhjvRB9zR8q7PPcT6vpb2NBpG2xdyOc+72LErH5H27sZBkzu/gGAC3d?=
 =?us-ascii?Q?1d6zai3MV01FeMhC8Q5oQ8MI+R6m4HluTOpBsDz5y2M+Y7rcYztETLDCRTTG?=
 =?us-ascii?Q?G61JNU3Z3GxNF+q1ze7amAiiVkerAQnnlEDPFqTmZXMbEoDTH3QGAYeL7cwG?=
 =?us-ascii?Q?zBN5yzqh9AgLTJzuw45Q+nHlWjf6kTbKoNiACz4TEStcMSfQ6CtBJP15loOc?=
 =?us-ascii?Q?J19Iw2x0Rx/jwBdowsejPHFUhSLDfzsz5GNNeWVkQrdqp0HXnaED+sAJa/Fe?=
 =?us-ascii?Q?6cEoFdb4mGlgPbXR3gECwzjHu7YyB86BPWReG4GsmV2iD4E5LuRO4I7CVi9D?=
 =?us-ascii?Q?JqkVMjvaeIw1HZt7XcnaZGb5/OfAjveXKd8zZ1sgAQu8y4AaECfMG5hmzl1Z?=
 =?us-ascii?Q?WFtOIL5//cl0t8io+Xad8PMol2kIVKCoQ5YOGcu74hfTtt4vh9doDRRAnwmo?=
 =?us-ascii?Q?APMUpHMlzlDEndE++N8NlhLNiYqqcv7t7QioDoOMAPjGLn0lsqU6Wap9nGrb?=
 =?us-ascii?Q?jtzLqZPNz8qjOTeBXnm+WxE+F1+1CzP1ezx0MFBxVmbrSLHE1tRODa8RDoSZ?=
 =?us-ascii?Q?D1rPtGyBQS9vB9dO7b+bUw2hli01otSELB3IEDs0fQTDCheagNxRv/zSz1aL?=
 =?us-ascii?Q?l78A1TS+EpGjWO+7H3gqkGu/crIk+D6/lzdRcigOHS8ehCGIQGv9qRfwW/U2?=
 =?us-ascii?Q?fNDQtMIa7u39+O/MozjuuzVFVFXFaj+rCGtFXtX/BOwme05aHWF8Ik3utPCz?=
 =?us-ascii?Q?R+8N3QMirNq3zsADKxZ4eVmoX+7LthT5ZcSkq0mstJQwPmAiSF3iKH9Bn7n3?=
 =?us-ascii?Q?Ug7WNWMFGMGD++l743oqWRJ+tvHLUWRJwXmDkrsDEss8PO0DSqhRAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FI2kB0ou5ezRpCwqTGZ/C1/aw2xhfvRX4aJpqfmLI7L4Oh8vJ5CPsZIC3DD+?=
 =?us-ascii?Q?3RxRVUW+l0ZGVXzRtvpVLVxDMomr6GVZOVGfGpjD7rnpA4jC0mW0NESazb99?=
 =?us-ascii?Q?Kp8AVMnzIdb5uUSbiHAVBJnaxLEwoW1NesGoNswGC1sHy7O1E0RdXdhZXQaa?=
 =?us-ascii?Q?vvMj3q0Llbl2qY/dd3QpGLbNLDQxvpimGIaMpmQmPI8RSWbwKBjN6JAzB4s4?=
 =?us-ascii?Q?6oxJ07xjg7kv2m5SGxfwJt50cA5rF7I15wql7AtxBZaEfb246mpKA9NdF4BI?=
 =?us-ascii?Q?wJ66aBRDpHS/w6mxs7qayRIjIjX45oPoOYmAoaB9ai7aHU/50MNe8xKHNecn?=
 =?us-ascii?Q?4Qo+HAvDA1zlX15M6j0nU0tNw2KCi05bh4ru8dVy163fbhDZBU0iq3cN13mc?=
 =?us-ascii?Q?+sCo4wc5fqz3GfzWTGOshtUblUcWsGhGFKoZ1VktUl6FUrdEhp0sxhBfX1kC?=
 =?us-ascii?Q?ZuDlX5LsWWAJNuBhJ5yuHC9Y5CCfrwurIRqhH5FgMNsiaqPhkFK05s97Va5V?=
 =?us-ascii?Q?lOEsD+av/CFkLh56zfsaYupsY7cFdflNNAi2qzmwtwDnlxX6R8EIaM/thDJV?=
 =?us-ascii?Q?CxBXkykBIPRxWutsaOsw/7sYOeOrfxMzrQlgxHtueNz+qoKlb+io09R1GBR+?=
 =?us-ascii?Q?6Mwe/HZ0M1QNuSghhxsvf8pXAAwU/gdQmcSaECjQWYExv+qNXIUmCRifSVO5?=
 =?us-ascii?Q?y5IdfUo+kUuXCFWNpUzSWKbxgLP9gmaHH/O471aqsafP/Dc7jPubALgYGZGy?=
 =?us-ascii?Q?BuUXi0lwoxtI1T/pdVuUmyge6rheJq+BoT7O5x8P2mAuQ51kdOQtr1CWQTAt?=
 =?us-ascii?Q?l6R13DT6GuQvEFQNr2TZL0OQLy31cbERkU+5uD6KoqY5ByQ4++tdNOhk7Rld?=
 =?us-ascii?Q?VNZmj9a2h8w0liuwVvBe7viQTXDf3fFYwP4NuA9M2yL5qrC/zKokHSh/DEwV?=
 =?us-ascii?Q?PzDDK6jqhn9cu91VqtfxOwHVCMyG/g7AthBjSbh1dD6EairY/Y0GsWtYiBQc?=
 =?us-ascii?Q?GvtpzZCIsd/Y2l+lg0YA8ROAvhX+QKI5yZN54punbVJ0L2scktIdM0+rK7Xn?=
 =?us-ascii?Q?cB0Cfx6lNmRTiYbmJtTGZQWpYoEwNZbpsc7iZtchriGemDtuPFtCwsc/xFsN?=
 =?us-ascii?Q?w0t6U46rUDtbSSe113Bo3HaZOEVt6m6QYnU5PBNYCJ/u1gv7vhaeL8b6Lk+q?=
 =?us-ascii?Q?0WT/WHdmp3y/hG+LmimvEDOH6kDZFJlMMU4/dOHJoz5iUJ4mLUz9m3N8T49f?=
 =?us-ascii?Q?8+RuIL5iq7EfnDbVOMWTQLLEFPxTGaKlBnGvA0QHSgQ/pAGZlaDENdOOdNRH?=
 =?us-ascii?Q?5hdrYFejMo+u7n1WbtWXvVfMfZo9p5gq9/K2ZYjhR/65b1yqJN5h9D6cBCw1?=
 =?us-ascii?Q?RcsqZJ/hY/qxBSf07lniOBcATS2x5Ms2f1dLKlg8IV5C/VMSHEpPwlN6SA9m?=
 =?us-ascii?Q?aatVrfv9vwTbRb5SxEnUoDEeqEwhGEnVsvIQU8MsBSZ6kd+4En+R/wnfcGju?=
 =?us-ascii?Q?MU8XpK796QM6KH2lGWrNlUnjkxwuyXR3phs7ApyjheflpCdNrzzpvg16esbs?=
 =?us-ascii?Q?PWalY817TChJHxxwn2qtv46zXjRakorDiu8MqNbw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f477b1be-2863-421b-a465-08dd78d0d3c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:14:06.1680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haycT9FeL5mr6PyUWjcTKBf9vi0hBqf35aWO8MRvHOKTC8uEbwKhc0cpKZKZLDgIK9pLqiJL4/be4C55ThKwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932
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

From: Ye Li <ye.li@nxp.com>

This patch adds V2X container support for i.MX95. Since V2X container
may not be included in ahab-container.img of i.MX95, check if V2X
container exists in order to get the correct image end.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 119 ++++++++++++++++++++++------
 1 file changed, 95 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a06..f84e23f4b2a 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -41,6 +41,52 @@
 #define FUSE_IMG_SET_OFF_WORD 720
 #endif
 
+#define MAX_V2X_CTNR_IMG_NUM   (4)
+#define MIN_V2X_CTNR_IMG_NUM   (2)
+
+#define IMG_FLAGS_IMG_TYPE_SHIFT  (0u)
+#define IMG_FLAGS_IMG_TYPE_MASK   (0xfU)
+#define IMG_FLAGS_IMG_TYPE(x)     (((x) & IMG_FLAGS_IMG_TYPE_MASK) >> \
+								   IMG_FLAGS_IMG_TYPE_SHIFT)
+
+#define IMG_FLAGS_CORE_ID_SHIFT   (4u)
+#define IMG_FLAGS_CORE_ID_MASK    (0xf0U)
+#define IMG_FLAGS_CORE_ID(x)      (((x) & IMG_FLAGS_CORE_ID_MASK) >> \
+								   IMG_FLAGS_CORE_ID_SHIFT)
+
+#define IMG_TYPE_V2X_PRI_FW     (0x0Bu)   /* Primary V2X FW */
+#define IMG_TYPE_V2X_SND_FW     (0x0Cu)   /* Secondary V2X FW */
+
+#define CORE_V2X_PRI 9
+#define CORE_V2X_SND 10
+
+static bool is_v2x_fw_container(ulong addr)
+{
+	struct container_hdr *phdr;
+	struct boot_img_t *img_entry;
+
+	phdr = (struct container_hdr *)addr;
+	if (phdr->tag != 0x87 || phdr->version != 0x0) {
+		debug("Wrong container header\n");
+		return false;
+	}
+
+	if (phdr->num_images >= MIN_V2X_CTNR_IMG_NUM && phdr->num_images <= MAX_V2X_CTNR_IMG_NUM) {
+		img_entry = (struct boot_img_t *)(addr + sizeof(struct container_hdr));
+
+		if (IMG_FLAGS_IMG_TYPE(img_entry->hab_flags) == IMG_TYPE_V2X_PRI_FW &&
+		    IMG_FLAGS_CORE_ID(img_entry->hab_flags) == CORE_V2X_PRI) {
+			img_entry++;
+
+			if (IMG_FLAGS_IMG_TYPE(img_entry->hab_flags) == IMG_TYPE_V2X_SND_FW &&
+			    IMG_FLAGS_CORE_ID(img_entry->hab_flags) == CORE_V2X_SND)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 int get_container_size(ulong addr, u16 *header_length)
 {
 	struct container_hdr *phdr;
@@ -83,7 +129,7 @@ int get_container_size(ulong addr, u16 *header_length)
 	return max_offset;
 }
 
-static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length)
+static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length, bool *v2x_cntr)
 {
 	u8 *buf = malloc(CONTAINER_HDR_ALIGNMENT);
 	int ret = 0;
@@ -150,6 +196,9 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 
 	ret = get_container_size((ulong)buf, header_length);
 
+	if (v2x_cntr)
+		*v2x_cntr = is_v2x_fw_container((ulong)buf);
+
 	free(buf);
 
 	return ret;
@@ -231,45 +280,67 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
+	bool v2x_fw = false;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length, NULL);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		if (v2x_fw) {
+			debug("v2x container size 0x%x\n", value_container[1]);
+			offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+		} else {
+			printf("no v2x container included\n");
+			offset[2] = offset[1];
+		}
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+	}
+
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	debug("scu container size 0x%x\n", value_container[2]);
 
-	return value_container[1] + offset2;
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +350,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +383,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +397,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +410,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }
-- 
2.43.0

