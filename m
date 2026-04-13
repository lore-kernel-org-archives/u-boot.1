Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48393EBFD15
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E509883EC6;
	Mon, 13 Apr 2026 10:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Ep8tnRKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594D984119; Mon, 13 Apr 2026 10:13:32 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1442D83B99
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzvdJA8YNrD3ctffCL8M4B32sUGlcEE5lERaMg7khyabz+AynfyoDacs8HwLRgKubSeTK/NQ+/U/2rmcleWtMgyAEXNPxkW8P5Fdt3L3BCEBcJUECXHF80sSNsrR/vLkzgDa9a0eNjvafMOCJfoI6ZfEvyXZ5n4DZl4XFhP/XVD6OdqFZ5qLYkenOeaZAq3nxWP/v1bhWXdE3pKFsDZCQa6SnP2jwe4KKZk6hKj3h4BWO3Wcd+rmrtdncRMh/XKQhtHbIXYD2lpf7VuKerQAL2Juzsih/Q72hpZAX5unxggzXg8lfp7L8wG1rIfL/QmmtFneSdvCXpFc48YrvdpzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOqAJt4Acm6VZ8R142NweLkcAwIjeLRXK5ToBJ/O/jc=;
 b=A0LJpA/PHQePM5bTZy5Pl/1TJGoWCO+HMjz3QA1QGjd0HCjjYdNKG4MQjrBxYntE9tiiye5Fev6Ef+JYEqG00RP3Xbs8a/ptVR77C5icFgGX25/KN3iOWF941n9xLwuJvK5yyfpsoxmtfKcr7b3freJiodn4yzH+crcASHXFFYa7rj5KaQhghJh3Qzn35sixG6r/5B0wvW9toKOh+dhkWbvWEd2i6faK7mNQJSigLhxrx4prn5TnuMs7ZNoGuV0iwEE80gecoBqgIrou6QZC4dyG2aF9p5ceoq3zm5ILgcuXuKEXYdLjkNxDF/TA0Sjol8qdmY0HTRzH64HU6wehhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOqAJt4Acm6VZ8R142NweLkcAwIjeLRXK5ToBJ/O/jc=;
 b=Ep8tnRKSuYdlSSJE55xCKgPMLfO1kNlc4gqc5f6g3xZd7/+LyYs4wrKO/TeqhmXtvXE4Vt0YnweyjNhM6RdDQQlXvEJ4Ijn5heaUYPDUqjQqhyScuuLdnj4Vv/oQc2MiO3/Ou3gcUrM7FDBaBYqXoI/1sdimwysBiqxk0hpbAVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:389::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:13:25 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:13:25 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] cmd: mmc: allow 'mmc rst-function' to show the current value
Date: Mon, 13 Apr 2026 10:13:22 +0200
Message-ID: <20260413081322.2226374-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0085.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d18b30-44c8-49ee-a0f5-08de99348906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: uFbejoTpVIUdf2mYOp1bVTIoZCyLXQ/jIBC6BC9gb3H1UsD+gMXFz67kHTCg3rXcMcfmZ3DQGNZLASc6LNusVch0tfoXr082UiQx6LeDde3KsGCXAN/fMX52W6o4nUMSGA3gs62GPTJPJG329MJF3OlB1VWgPxSa5yZ8VcAzRCy7p3nyrpbHSa5nV1LEj2h5E9ZBsxHKJzzjYgKHdHwFMHs3dQzUv88QHEnuDDvdci/TjNQ+sTeBupNQiOIpoVFMf6QrFK30QfSJtu2CQQF28K1v6v8fk07hwA/+0sfVni0Sbm5KAvb8M/7GBHwLNV1VE+pVwj51sDJ2+IeMjfLOKkvtzBMkjV0GL24wkK7skDpu+HejapMIuPylipzTKnNSXm39jmd0VGZhmspMTWussqBBRaWofrZlQDJfRBP94HkwummZiCZQUNcPi8A5LcMHlClwJz40PVKMIZmIwDXqUPTx5KhiRv6PSoY/KsVlJ028xT0wZxFRqRHJssuxfC41SEMdDqUmesKEJXc/BsHc47FTDAKPRzlaYh4Z+VMA6KIszcNBODAtLLZsVioOiIixaBn0vVMbUD7o916SExwo/Jw31Fy+AER5KAKGL4Ys0T9nYp87xo2kCJyOmig8DlilhnHesA6lZ6fGyoLxWrUVKDbIsUqs13B3FuXJkyzQK5NTZ+LHMxYPEnXOx1+n8IZPmR02keEaAvtjjD3YldckwghpZOB7mrFj/V90ZNEPVXplnoFB0RbZfYtyY/7JsTO8Vp9hHuQouWDC+95fYFYrKVa4XI7Wvqjm4ePFI5JJ/Y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CEOo29YjQs9MedXypLV0iXNGGcwrti4hANWjoQQzCWYvoi+BcizOp2WxSq/8?=
 =?us-ascii?Q?SEabi3x+XnVYQFw6ffJPcUdvB/1U863QwSu0RpB0gWA6FT9sHtBWWU0BMvoA?=
 =?us-ascii?Q?j4OMYkWlSTS4sJFbKUEh7JJMKqsjoNGkOjf63DpXQg4Pw3C5qeMg9NMEuKi7?=
 =?us-ascii?Q?mlPv7k8UctSuAB1aQ+L6EWjjw89H6CcCch1vjwi1eEZc9H97XfdYYJD6UATn?=
 =?us-ascii?Q?SHJ4bpLGAtCHhEZ9/15eucUi3PjBXdVJaEOdlWZ2AZ8ulsuATpsnwELofwn8?=
 =?us-ascii?Q?ER9Pf4EzB4EKb7B/U0y+Kk7zPzKjP38j9OHv/9ypCUMjbN+DIMOcdv3uladn?=
 =?us-ascii?Q?3FdC8p4p4TCbMR7k867qYxOZbaEh2RNYVXYAizIPOIoJON9b+kdZ64c3D0R+?=
 =?us-ascii?Q?yTwuyaWgH58im1QaT8l+7qH3TaLHLeXY1dvA39LzRArJUbFI2Jiiu1LxGMng?=
 =?us-ascii?Q?rNsjLTuB5aLWwHhtQCePwoTTCAWRnjJlulTtBeYNOidgByLhuglYWuT4Nyc9?=
 =?us-ascii?Q?fK2FVJR3jIs/kX8JjcbIa/YIBdJC6gzsn6S/KFTGiBy7i2Dif8ItbjpkdBqI?=
 =?us-ascii?Q?fiVkt6i1A4GcWodtB2l50HzUMAXfq4LWwLOgHSCyiArhzdR2DdNJEOvtUtOy?=
 =?us-ascii?Q?2AxPAWd/gcPhiD9fUsEfHgTvDPRZ9FSdXZMlToFDL/1wp1GK10WokH2K2L1E?=
 =?us-ascii?Q?vra7AIlqw07GgifwmVwTUcNNdG4FkeDedF5etaMvpAxxFBac21I4g95oWWgJ?=
 =?us-ascii?Q?53bd3ccC2ghVDptMTt+W7N0S5dEytcwgJnQ/VSaV66IP46rP5cLADZEj0zVK?=
 =?us-ascii?Q?ead1IsH0tzQcC4gzTcDHgCOYzJ82Ij3KCtLVf3Zo0x++LkRpfp1EcksM+kvf?=
 =?us-ascii?Q?/3JLMdy6b2fQzpFkwAosiGrWx+780XlKNaTo+WzkppDJylJby0inyAyjDxTb?=
 =?us-ascii?Q?NcTdW8IwI2G7UHEPRX216JafYUTQGMY+KFfZCYCQY6ztW+ZX07N0wAuic0/p?=
 =?us-ascii?Q?h/AlE8N1xmncWLeNzglarl2coasxo43CxJIKxmLvXeXZk2JP4RT1GsgBYmEw?=
 =?us-ascii?Q?hCrSM0ZYXNa1ZtBRtYVO1BOoOcdfZSL6FEaEOkpNUO2xE8GUyYR4iyzvuV32?=
 =?us-ascii?Q?gfkpsBvtJxc/cQmnKGPEEl+nXjg/bP5jpXDPXsR4/p88xtPs7fX6ND/sY0el?=
 =?us-ascii?Q?Ow6OvTpleSxpn3n6Pl2O4YhwjFfrJrJOoguHirtxS3wB7QyjI+E73DwdiSvU?=
 =?us-ascii?Q?LYHZvGuUavzSxoDjZnapgLLnsKG8uNrK6kxxAY59Aewh9bTJT9Wp0m+m/wMl?=
 =?us-ascii?Q?vjacFSKGHmEkmg3CiQt7A5k70SG0lUXgkq1qbehyebPKG3l8WAC9bRo9qTFm?=
 =?us-ascii?Q?55hSC38PhmNS2in5YkEglQB494DtoRnR7vJstlto6CY7bTnx/mRlxq5RGIRd?=
 =?us-ascii?Q?9dG2YQZHEO/7OeZ2DVklUG0E/gWIo01JmK37B33QithO28kLKe3nLMWzA0Dz?=
 =?us-ascii?Q?0BrFMhhn/Yw5i7sA8olw0y5lzx/4DQshfz4ttGYzWSb2GXqHOFcWYhyB16sD?=
 =?us-ascii?Q?ZLNYERFTT5eoXsVJTIp26L7No+zcRj926xaHkOftHTYm2BtIy/DQ3ctUYODF?=
 =?us-ascii?Q?oyrm6VKs0CXp/pXRMZG9/9Sf0UxBEpEGDzrAjFnNy7T+UkO3TxRDHiahdt2O?=
 =?us-ascii?Q?ZFb2CCHrAF5eyd7tkwgyNwqZzmPJGisdpLXd3FHR7gPOsGZYHvHpgaYHrXCX?=
 =?us-ascii?Q?uzXYN/lmSIugTEE81VETdn1bWrabnyk=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d18b30-44c8-49ee-a0f5-08de99348906
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:13:25.1566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USQU8EIAhyqpvqisYEaTlIaL3zjrXw0j2/qgEhAPHPOP7ZwlOcVTFdcHQCXkGHxqbVWDgKEyPaLKmHan8oiMZOPK0sE7+wxQGEsnPGEDoxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6166
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

Extend the 'mmc rst-function' subcommand so that lacking a value to
set, it simply prints the current value, and its interpretation.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/mmc.c             | 36 +++++++++++++++++++++++++++---------
 doc/usage/cmd/mmc.rst |  4 ++--
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 81b1ca4ad84..f217dfdacaa 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -1012,16 +1012,10 @@ static int do_mmc_rst_func(struct cmd_tbl *cmdtp, int flag,
 	 * The only valid values are 0x0, 0x1 and 0x2 and writing
 	 * a value of 0x1 or 0x2 sets the value permanently.
 	 */
-	if (argc != 3)
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
 	dev = dectoul(argv[1], NULL);
-	enable = dectoul(argv[2], NULL);
-
-	if (enable > 2) {
-		puts("Invalid RST_n_ENABLE value\n");
-		return CMD_RET_USAGE;
-	}
 
 	mmc = init_mmc_device(dev, false);
 	if (!mmc)
@@ -1032,6 +1026,30 @@ static int do_mmc_rst_func(struct cmd_tbl *cmdtp, int flag,
 		return CMD_RET_FAILURE;
 	}
 
+	if (argc == 2) {
+		ALLOC_CACHE_ALIGN_BUFFER(u8, ext_csd, MMC_MAX_BLOCK_LEN);
+		ret = mmc_send_ext_csd(mmc, ext_csd);
+		if (ret)
+			return CMD_RET_FAILURE;
+
+		printf("RST_n_FUNCTION: 0x%x ", ext_csd[EXT_CSD_RST_N_FUNCTION]);
+		switch (ext_csd[EXT_CSD_RST_N_FUNCTION]) {
+		case 0x0: puts("(temporarily disabled)\n"); break;
+		case 0x1: puts("(permanently enabled)\n"); break;
+		case 0x2: puts("(permanently disabled)\n"); break;
+		default: puts("(unknown)\n");
+		}
+
+		return CMD_RET_SUCCESS;
+	}
+
+	enable = dectoul(argv[2], NULL);
+
+	if (enable > 2) {
+		puts("Invalid RST_n_ENABLE value\n");
+		return CMD_RET_USAGE;
+	}
+
 	ret = mmc_set_rst_n_function(mmc, enable);
 	if (ret != 0)
 		return CMD_RET_FAILURE;
@@ -1344,8 +1362,8 @@ U_BOOT_CMD(
 	"mmc partconf <dev> [[varname] | [<boot_ack> <boot_partition> <partition_access>]]\n"
 	" - Show or change the bits of the PARTITION_CONFIG field of the specified device\n"
 	"   If showing the bits, optionally store the boot_partition field into varname\n"
-	"mmc rst-function <dev> <value>\n"
-	" - Change the RST_n_FUNCTION field of the specified device\n"
+	"mmc rst-function <dev> [<value>]\n"
+	" - Show or change the RST_n_FUNCTION field of the specified device\n"
 	"   WARNING: This is a write-once field and 0 / 1 / 2 are the only valid values.\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MMC_RPMB)
diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
index 55391fda24c..c6ab334b3d4 100644
--- a/doc/usage/cmd/mmc.rst
+++ b/doc/usage/cmd/mmc.rst
@@ -24,7 +24,7 @@ Synopsis
     mmc bootbus <dev> <boot_bus_width> <reset_boot_bus_width> <boot_mode>
     mmc bootpart-resize <dev> <dev part size MB> <RPMB part size MB>
     mmc partconf <dev> [[varname] | [<boot_ack> <boot_partition> <partition_access>]]
-    mmc rst-function <dev> <value>
+    mmc rst-function <dev> [<value>]
     mmc reg read <reg> <offset> [env]
 
 Description
@@ -178,7 +178,7 @@ The 'mmc bootpart-resize' command changes sizes of boot and RPMB partitions.
     RPMB part size MB
         target size of RPMB partition
 
-The 'mmc rst-function' command changes the RST_n_FUNCTION field.
+The 'mmc rst-function' command shows or changes the RST_n_FUNCTION field.
 **WARNING** : This is a write-once field. (*Refer to eMMC specification*)
 
     value
-- 
2.53.0

