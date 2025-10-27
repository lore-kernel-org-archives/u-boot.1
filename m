Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44D4CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D01838D7;
	Mon, 27 Oct 2025 14:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CBHUOGZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2601580107; Mon, 27 Oct 2025 14:00:26 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4EC838AB
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RD0Itg1268415;
 Mon, 27 Oct 2025 08:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761570018;
 bh=QUzgzaKMfwc5gly2YcYEl5chZzJFgfChPzs4xiB/vlM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CBHUOGZUfMBXDucdMV/4QylAzZ8pNxTM8sPew33qh5tkLOHEWYPLUl/KXSD8RsZDY
 1YdGkFtrEUGPB09Q48JiNimkrq/NWOomd7pRzKA4Nb296+zU1B/JTBBQwlhdcMj/xt
 sjoMuMyCdAPAXCxjuRnjzQSFrYDb3f22eZKqTGqY=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RD0IaR993411
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 08:00:18 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:00:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:00:18 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RD0Gww680516;
 Mon, 27 Oct 2025 08:00:17 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v8 6/8] mach-k3: r5: common: add bootargs to kernel's dtb
Date: Mon, 27 Oct 2025 18:30:01 +0530
Message-ID: <20251027130004.2156121-7-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027130004.2156121-1-anshuld@ti.com>
References: <20251027130004.2156121-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The bootargs are passed to the kernel in the chosen node, this patch
adds support for populating bootargs in the dtb if missing.

The values for kernel boot params is taken from the env with, 'boot' and
'bootpart' specifying the rootfs for the kernel.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/r5/common.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 4788aaff3ea..9e20b7ae93d 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -406,6 +406,46 @@ int k3_r5_falcon_bootmode(void)
 		return BOOT_DEVICE_NOBOOT;
 }
 
+static int k3_falcon_fdt_add_bootargs(void *fdt)
+{
+	struct disk_partition info;
+	struct blk_desc *dev_desc;
+	char bootmedia[32];
+	char bootpart[32];
+	char str[256];
+	int ret;
+
+	strlcpy(bootmedia, env_get("boot"), sizeof(bootmedia));
+	strlcpy(bootpart, env_get("bootpart"), sizeof(bootpart));
+	ret = blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, 0);
+	if (ret < 0) {
+		printf("%s: Failed to get part details for %s %s [%d]\n",
+		       __func__, bootmedia, bootpart, ret);
+		return ret;
+	}
+
+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+		printf("ERROR: Failed to find rootfs PARTUUID\n");
+		printf("%s: CONFIG_SPL_PARTITION_UUIDS not enabled\n",
+		       __func__);
+		return -EOPNOTSUPP;
+	}
+
+	snprintf(str, sizeof(str), "console=%s root=PARTUUID=%s rootwait",
+		 env_get("console"), disk_partition_uuid(&info));
+
+	ret = fdt_find_and_setprop(fdt, "/chosen", "bootargs", str,
+				   strlen(str) + 1, 1);
+	if (ret) {
+		printf("%s: Could not set bootargs: %s\n", __func__,
+		       fdt_strerror(ret));
+		return ret;
+	}
+
+	debug("Set bootargs to: %s\n", str);
+	return 0;
+}
+
 static int k3_falcon_fdt_fixup(void *fdt)
 {
 	int ret;
@@ -415,6 +455,13 @@ static int k3_falcon_fdt_fixup(void *fdt)
 
 	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
 
+	if (fdt_path_offset(fdt, "/chosen/bootargs") < 0) {
+		ret = k3_falcon_fdt_add_bootargs(fdt);
+
+		if (ret)
+			return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
 		ret = ft_board_setup(fdt, gd->bd);
 		if (ret) {
-- 
2.51.0

