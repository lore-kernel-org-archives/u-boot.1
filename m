Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8104C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC006888E5;
	Tue, 30 Jul 2024 09:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDFC888BC; Tue, 30 Jul 2024 09:09:50 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D02F88855
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E92932016AF;
 Tue, 30 Jul 2024 09:09:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B1D9A2013F1;
 Tue, 30 Jul 2024 09:09:47 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 20B67183ACAC; Tue, 30 Jul 2024 15:09:45 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org, marex@denx.de, lukma@denx.de,
 seanga2@gmail.com, xypron.glpk@gmx.de
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 10/14] cmd: cpu: add release subcommand
Date: Tue, 30 Jul 2024 15:29:59 +0800
Message-Id: <20240730073003.28892-11-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add a new subcommand 'release' to bring up a core to run baremetal
and RTOS applications.

For example on i.MX8M Plus EVK, release the LAST core to run a RTOS
application, passing the sequence number of the CPU core to release,
here it is 3:
    u-boot=> cpu list
      0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
      1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
      2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
      3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C

    u-boot=> load mmc 1:2 c0000000 /hello_world.bin
    66008 bytes read in 5 ms (12.6 MiB/s)
    u-boot=> dcache flush; icache flush
    u-boot=> cpu release 3 c0000000
    Released CPU core (mpidr: 0x3) to address 0xc0000000

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
V4:
 - Updated the change logs.

 cmd/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/cmd/cpu.c b/cmd/cpu.c
index 9e323069b9..2755250756 100644
--- a/cmd/cpu.c
+++ b/cmd/cpu.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
  * Copyright (c) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
+ * Copyright 2024 NXP
  */
 
 #include <command.h>
@@ -18,6 +19,19 @@ static const char *cpu_feature_name[CPU_FEAT_COUNT] = {
 	"Device ID",
 };
 
+static struct udevice *cpu_find_device(unsigned long cpu_id)
+{
+	struct udevice *dev;
+
+	for (uclass_first_device(UCLASS_CPU, &dev); dev;
+	     uclass_next_device(&dev)) {
+		if (cpu_id == dev_seq(dev))
+			return dev;
+	}
+
+	return NULL;
+}
+
 static int print_cpu_list(bool detail)
 {
 	struct udevice *dev;
@@ -82,10 +96,36 @@ static int do_cpu_detail(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_cpu_release(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct udevice *dev;
+	unsigned long cpu_id;
+	unsigned long long boot_addr;
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	cpu_id = dectoul(argv[1], NULL);
+	dev = cpu_find_device(cpu_id);
+	if (!dev)
+		return CMD_RET_FAILURE;
+
+	boot_addr = simple_strtoull(argv[2], NULL, 16);
+
+	if (cpu_release_core(dev, boot_addr))
+		return CMD_RET_FAILURE;
+
+	return 0;
+}
+
 U_BOOT_LONGHELP(cpu,
 	"list	- list available CPUs\n"
-	"cpu detail	- show CPU detail");
+	"cpu detail	- show CPU detail\n"
+	"cpu release <core ID> <addr>	- Release CPU <core ID> at <addr>\n"
+	"            <core ID>: the sequence number in list subcommand outputs");
 
 U_BOOT_CMD_WITH_SUBCMDS(cpu, "display information about CPUs", cpu_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 1, 1, do_cpu_list),
-	U_BOOT_SUBCMD_MKENT(detail, 1, 0, do_cpu_detail));
+	U_BOOT_SUBCMD_MKENT(detail, 1, 0, do_cpu_detail),
+	U_BOOT_SUBCMD_MKENT(release, 3, 0, do_cpu_release));
-- 
2.17.1

