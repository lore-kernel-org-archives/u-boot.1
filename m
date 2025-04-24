Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4C8C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938768209F;
	Thu, 24 Apr 2025 08:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FTr6nQvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF3A8082A; Thu, 24 Apr 2025 08:08:54 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E9B817C4
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6209a59483=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O64QLt005346;
 Thu, 24 Apr 2025 08:08:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 MRRm/L8ksNL1BwMYq+gX63RSRhYQGS2ZK5DuybJLR3E=; b=FTr6nQvyciBWzmyQ
 G6fjERRSjCR186+j10WAsvBGpuyQP9TUVMJWpy45bnlNpXJ1V9OF+RnqzBk0s56z
 UglzCpoOPRdf7JO/3e0W9jZLb3oq+RnRHgkI+h9CBpoDG7PrZRdrPCBKBzgsoWcI
 8s7ahei4unKgZ1KvnSWs/AZiGrUxXZdV8wupvjG2z+kg9ajoeV4meupkg55ehk6g
 AO/CM1qm4fdTmQrxSb+V99nb4MIm7Qzp4SLJ+T9AtyEGJxbjts1kUYN4vPd2Nm+h
 B2JxL7MBmYr4Uv1RJlSSr4sH/2FpVdgt0lxCMzgf61pwVBakamm9cNi6J+dbS86S
 8kS8BQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jk3e1ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 08:08:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 97F634002D;
 Thu, 24 Apr 2025 08:08:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D3BCFA52445;
 Thu, 24 Apr 2025 08:07:56 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:07:56 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>,
 Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/21] arm: stm32mp: add helper function stm32mp_is_closed()
Date: Thu, 24 Apr 2025 08:07:21 +0200
Message-ID: <20250424060723.2695014-20-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
References: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Add the helper function stm32mp_is_closed() to check the "closed" state in
product life cycle, when product secrets have  been provisioned into the
device, by "secure secret provisioning" tools (SSP) for example.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/mach-stm32mp/cmd_stm32key.c          | 22 +++++++++++++++++++
 .../arm/mach-stm32mp/include/mach/sys_proto.h |  7 ++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
index d6bf72d8e32..6bfa67859e1 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32key.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
@@ -618,3 +618,25 @@ U_BOOT_CMD_WITH_SUBCMDS(stm32key, "Manage key on STM32", stm32key_help_text,
 	U_BOOT_SUBCMD_MKENT(read, 2, 0, do_stm32key_read),
 	U_BOOT_SUBCMD_MKENT(fuse, 3, 0, do_stm32key_fuse),
 	U_BOOT_SUBCMD_MKENT(close, 2, 0, do_stm32key_close));
+
+/*
+ * Check the "closed" state in product life cycle, when product secrets have
+ * been provisioned into the device, by SSP tools for example.
+ * On closed devices, authentication is mandatory.
+ */
+bool stm32mp_is_closed(void)
+{
+	struct udevice *dev;
+	bool closed;
+	int ret;
+
+	ret = get_misc_dev(&dev);
+	if (ret)
+		return false;
+
+	ret = read_close_status(dev, false, &closed);
+	if (ret)
+		return false;
+
+	return closed;
+}
diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
index bf1c39742c1..19073668497 100644
--- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
+++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
@@ -120,3 +120,10 @@ u32 get_otp(int index, int shift, int mask);
 
 uintptr_t get_stm32mp_rom_api_table(void);
 uintptr_t get_stm32mp_bl2_dtb(void);
+
+/* helper function: check "closed" state in product "Life Cycle" */
+#ifdef CONFIG_CMD_STM32KEY
+bool stm32mp_is_closed(void);
+#else
+static inline bool stm32mp_is_closed(void) { return false; }
+#endif
-- 
2.25.1

