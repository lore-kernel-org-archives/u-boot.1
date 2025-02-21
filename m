Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADC2C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 11:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AE18056B;
	Fri, 21 Feb 2025 12:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s3xcWv3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B20806FE; Fri, 21 Feb 2025 12:04:12 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5400F8007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAIMiiUU+LJ4LicxqEl5pXkFlAopRXRIzlWDq3YZi1Kb6a13/7KXlHuVFgVISgc08+ejfXfWWoPyQCjBva1CyHgakiEILB4LL6Z9XEv8hQzPJeoulnkI880ifo7F3DgqSybBtn8cymhSSmuxgLIkXaoOqZmXBpjwn7Tx/9Gjtzz7G6Ar52gnOzHq2cuqGJm4XEkZD5F7fvjgHuxe2c/8IkFJVbWWgCgg+vq6Z770c+8E5tZyebgYgRhwMvEJh/YO458YkD6z77PkoCjhuTsWj3VULqD1mFu29D4+pgc9A6tO7SwBQpzfh+abPZS+nFAaco6boAR9/1m5PFvqEJ7Jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKQ1mDVTd+i8LC2g8r54NR5kqyZgQp4d8D07jpg7TIg=;
 b=RB3ILzDb2LzILph3DOUssDe2k///qmD/hrEj1mSNu99I9chi5DGAyGdPePN126zcdselHWRm5/LZhChYLNQTV0cypNtjje/f5tSUV+ujaNJnO8FN3JQZD+oshwSFQCWQIzJ4on/wkstw6EVJj3/RKnJkX+RqP09XxBEIKB4vusIRJqTlZBreWaCOA/uWoyEXDKWNwysOJOp1C6acJZANUYvHJ6fTAaJtV5bRsfMNx8RM+c1JtwRxPsjsyi1FZ9mS6LL08Y7vBZ7hHBTIBQ8MiK45z4hkJzb4cpXNLSV+OmJU1qEckqEAit/wLLtrDx7VRbPME8ARPEa5VOndRuG+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKQ1mDVTd+i8LC2g8r54NR5kqyZgQp4d8D07jpg7TIg=;
 b=s3xcWv3e+2XbA7VcGJPZFG3bjVNIeD7d5uGviWVLQ50cMagsGRDrLpHF7B99+mJz1KOdu1MJ0r7r/ggr4dP6iWUENRS4WycDKaWP6tJyORDWPj29PD20adAnB7ZiSt4LINTX6eWgqj1DZnwlIPO8UhPe1neYOxUegwsVrm1FgBs=
Received: from BN9P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::34)
 by PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 11:04:04 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::fd) by BN9P221CA0019.outlook.office365.com
 (2603:10b6:408:10a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 11:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 11:04:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 05:04:03 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 05:04:02 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
CC: Michal Simek <monstr@monstr.eu>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v1] cmd/fpga: use config node for loadmk
Date: Fri, 21 Feb 2025 11:03:35 +0000
Message-ID: <20250221110344.2301862-1-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: ae37a9d1-cb14-481e-b8b1-08dd52677477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+z6qP1x1Y5KcS0cw3FlcgTNGN/sDN6H2jSq7srmB+Xr3Wc70w3Du3VPDPOR?=
 =?us-ascii?Q?Y0gq/TDFjWhzpL0EdoqcTeIFiVTM6pTuUVvN5yE/6r4yfnsSfhOR8n2Edk1C?=
 =?us-ascii?Q?a9nHfr9eBpx0EA/dx1reCfdjHVE4HNV8YYLuaH1zoHUNVnVdQRIAKuL25x0t?=
 =?us-ascii?Q?WXiQnG9Z1wjr6xnU+4w7JN3BQ+hHXDjC27rlHgn4Se/ZhC7MxWdOK8MccPdv?=
 =?us-ascii?Q?kD0GvKyMr+G/V7SEx+AZq/LnMTbnGRptMxBhmUoDkcTy18tLB8K4mpk85QgH?=
 =?us-ascii?Q?ZTc7b8BfbjnycebtlqA4uoaG6omM1E03n9PTj1EgbbtEFeXKayQwivrMEDpP?=
 =?us-ascii?Q?krNZseMrXQFc6a8cHMMDL77CGhXiJr+2c8G2cQvn1kugUYEb17Gb1A80bOL6?=
 =?us-ascii?Q?KinH2iQHpOQVxOvX40eo+0FFTv/8wggtya/mH+5F5R1vN9S85yTPUxVTxKUZ?=
 =?us-ascii?Q?sTUF5+95758zB+h1VCTSrF9394waXxk+srrxOgQoh0A6pA8D8EHs8jW8Xd6Z?=
 =?us-ascii?Q?YNzAoNW1sGmxPx27UGAxG6LdQYWX0/Ql0T/ugL8SFaq/QKsc7ztWD/kcqx5j?=
 =?us-ascii?Q?zHTBYsGenmXBH8LSmWN0hy8oHiiPGcFV1VchHoMGxyjwMr+3Jr8A6YDoP8jb?=
 =?us-ascii?Q?/Sedjb6p7ph0wtnstRFyKk/CJcHFkb4gm3EzzJVUqE01pyOBhIqHbcu4NpSX?=
 =?us-ascii?Q?5kKgjy8KDN/cez1yoC2MTfJSxffVpHn3AxkL2fLsNX0BS5E4VikS3So0iav+?=
 =?us-ascii?Q?mtlplHw6CsGcj1KnjS9NhUAcUU5ss12FoE11aJpnQYKkpD6YfAAKH+Km593B?=
 =?us-ascii?Q?NLLaqjIFQkPzEkwcUZKTcOJBpejK9tcxu9qXP+kSYqlCeU/amwkGnQJjJkCq?=
 =?us-ascii?Q?KSmuZY6lVqb3g74z7if8TcZDh8UPS5Y6sJVBJU6f1vJ+QwctR0HuqYiznCE1?=
 =?us-ascii?Q?XMWWt0JoLtV45MPbco2xqCQblqa/+BVqmw5AuV5wAFdUiC1K5ySE1hOkN5OH?=
 =?us-ascii?Q?fciYLAaJAELd2veQA+LhzRqg9TuBjK0+G4e7jMQ87LXxjNwvwUVT8bk7aOIv?=
 =?us-ascii?Q?hq1Jdgwl2xvfPnLr+3qqnjxb804pMalD4ndoI/IR3DqZaJciM158jdRqmw/a?=
 =?us-ascii?Q?V+svWqMcsiEDA6QCm9y4IMkii7dyMXWEb8e9nAisZRAU9OD7kjEew+Lsw246?=
 =?us-ascii?Q?zrEBnhtwHkag6MpK38s49Wo04T1XqWTCMWOqldXBza/3o3RSc0Y1T7qWhy9h?=
 =?us-ascii?Q?xsZvC3Iyv2Gjrli/1HgiI0d38QLk4QZgskM5EvosRNk89YTCOrVgAQ6yRskD?=
 =?us-ascii?Q?ffhEF1DM9SM3rMmqLoezcE//51F6AIwGCYmBRcKjoOW0v3cEC6L/QrXx76hK?=
 =?us-ascii?Q?G5+GIzHGb3UZB18qV7TveTQXa9jCfqUDuJjMqrfrx96GZ2EqffE3HnaDkMw6?=
 =?us-ascii?Q?9Jt6pMmLF6UkzDk+pweNsl63iTMEWjD7p6ONGYiJY8xKUnnDkx4lxkwry9wF?=
 =?us-ascii?Q?TXJPSgg69bZzgME=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 11:04:04.5121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae37a9d1-cb14-481e-b8b1-08dd52677477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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

Current implementation requires to provide the name of the FPGA image
within the FIT image. As the configuration node is mandatory according
to the spec and includes an optional property "fpga" to define the
bitstream image, use this approach instead.

This way there is no need for an additional information in the loadmk
command for FIT, and signature and hash verification of both the image
and configuration is performed.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

 cmd/fpga.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index 9dc7b63db5d..7ff8802dd77 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -238,10 +238,6 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	size_t data_size = 0;
 	void *fpga_data = NULL;
-#if defined(CONFIG_FIT)
-	const char *fit_uname = NULL;
-	ulong fit_addr;
-#endif
 	ulong dev = do_fpga_get_device(argv[0]);
 	char *datastr = env_get("fpgadata");
 
@@ -265,20 +261,10 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 		datastr = argv[0];
 	}
 
-#if defined(CONFIG_FIT)
-	if (fit_parse_subimage(datastr, (ulong)fpga_data,
-			       &fit_addr, &fit_uname)) {
-		fpga_data = (void *)fit_addr;
-		debug("*  fpga: subimage '%s' from FIT image ",
-		      fit_uname);
-		debug("at 0x%08lx\n", fit_addr);
-	} else
-#endif
-	{
-		fpga_data = (void *)hextoul(datastr, NULL);
-		debug("*  fpga: cmdline image address = 0x%08lx\n",
+	fpga_data = (void *)hextoul(datastr, NULL);
+	debug("*  fpga: cmdline image address = 0x%08lx\n",
 		      (ulong)fpga_data);
-	}
+
 	debug("%s: fpga_data = 0x%lx\n", __func__, (ulong)fpga_data);
 	if (!fpga_data) {
 		puts("Zero fpga_data address\n");
@@ -323,24 +309,28 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 	case IMAGE_FORMAT_FIT:
 	{
 		const void *fit_hdr = (const void *)fpga_data;
-		int err;
 		const void *fit_data;
+		int err;
+		int noffset;
 
-		if (!fit_uname) {
-			puts("No FIT subimage unit name\n");
+		noffset = fit_conf_get_node(fit_hdr, NULL);
+		if (noffset < 0) {
+			log_err("Could not find default config node, err:%d\n",
+				noffset);
 			return CMD_RET_FAILURE;
 		}
 
-		if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
-			puts("Bad FIT image format\n");
+		err = (fit_config_verify(fit_hdr, noffset));
+		if (err) {
+			log_err("Configuration node verification failed, err:%d\n",
+				err);
 			return CMD_RET_FAILURE;
 		}
 
-		err = fit_get_data_node(fit_hdr, fit_uname, &fit_data,
-					&data_size);
+		err = fit_get_data_conf_prop(fit_hdr, "fpga", &fit_data,
+					     &data_size);
 		if (err) {
-			printf("Could not load '%s' subimage (err %d)\n",
-			       fit_uname, err);
+			log_err("Could not find fpga image, err:%d\n", err);
 			return CMD_RET_FAILURE;
 		}
 
@@ -433,10 +423,6 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADMK)
 	 "fpga loadmk <dev> <address>        Load device generated with mkimage\n"
-#if defined(CONFIG_FIT)
-	 "            NOTE: loadmk operating on FIT must include subimage unit\n"
-	 "            name in the form of addr:<subimg_uname>\n"
-#endif
 #endif
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
 	 "fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]\n"
-- 
2.42.0.325.g3a06386e31

