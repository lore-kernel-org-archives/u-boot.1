Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158D51075275
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 08:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABA5383FC0;
	Thu, 19 Mar 2026 09:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B152083F2D; Thu, 19 Mar 2026 09:30:37 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6DD183E16
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8TtpH014939;
 Thu, 19 Mar 2026 16:29:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:29:55 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 1/6] riscv: sbi: Add Andes vendor extension and PMA call
 wrappers
Date: Thu, 19 Mar 2026 16:29:46 +0800
Message-ID: <20260319082951.3310908-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8TtpH014939
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

Add support for the Andes SBI vendor extension (EXT_ID 0x0900031E)
with function IDs for PMA (Physical Memory Attribute) operations:
probe, set, and free.

These SBI calls allow S-mode software to configure memory attributes
through OpenSBI, which is needed for setting up noncached memory
regions on Andes RISC-V platforms.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/include/asm/sbi.h | 22 ++++++++++++++++
 arch/riscv/lib/sbi.c         | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 47124dbaac8..8642954d272 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -37,6 +37,7 @@ enum sbi_ext_id {
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_DBTR = 0x44425452,
 	SBI_EXT_MPXY = 0x4D505859,
+	SBI_EXT_ANDES = 0x0900031E,
 };
 
 enum sbi_ext_base_fid {
@@ -98,6 +99,23 @@ enum sbi_srst_reset_reason {
 	SBI_SRST_RESET_REASON_SYS_FAILURE,
 };
 
+enum sbi_ext_andes_fid {
+	SBI_EXT_ANDES_FID0 = 0,
+	SBI_EXT_ANDES_IOCP_SW_WORKAROUND,
+	SBI_EXT_ANDES_PMA_PROBE,
+	SBI_EXT_ANDES_PMA_SET,
+	SBI_EXT_ANDES_PMA_FREE,
+};
+
+/* Andes PMA configuration flags */
+#define ANDES_PMACFG_ETYP_OFFSET	0
+#define ANDES_PMACFG_ETYP_NAPOT	(3 << ANDES_PMACFG_ETYP_OFFSET)
+#define ANDES_PMACFG_ETYP_OFF		(0 << ANDES_PMACFG_ETYP_OFFSET)
+#define ANDES_PMACFG_ETYP_MASK		(3 << ANDES_PMACFG_ETYP_OFFSET)
+#define ANDES_PMACFG_MTYP_OFFSET		2
+#define ANDES_PMACFG_MTYP_MEM_NON_CACHE_BUF	(3 << ANDES_PMACFG_MTYP_OFFSET)
+#define ANDES_PMACFG_MTYP_DEV_NOBUF		(0 << ANDES_PMACFG_MTYP_OFFSET)
+
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
 	SBI_EXT_DBCN_CONSOLE_READ,
@@ -176,4 +194,8 @@ int sbi_get_mimpid(long *mimpid);
 void sbi_srst_reset(unsigned long type, unsigned long reason);
 int sbi_dbcn_write_byte(unsigned char ch);
 
+int sbi_pma_probe(void);
+int sbi_pma_set(unsigned long pa, unsigned long size, unsigned long flags);
+int sbi_pma_free(unsigned long pa);
+
 #endif
diff --git a/arch/riscv/lib/sbi.c b/arch/riscv/lib/sbi.c
index 35a7d3b12f5..f8a2da5c271 100644
--- a/arch/riscv/lib/sbi.c
+++ b/arch/riscv/lib/sbi.c
@@ -220,6 +220,57 @@ int sbi_dbcn_write_byte(unsigned char ch)
 	return ret.error;
 }
 
+/**
+ * sbi_pma_probe() - Probe for Andes PMA support
+ *
+ * Return: Number of PMA entries on success, SBI error on failure
+ */
+int sbi_pma_probe(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_PMA_PROBE,
+			0, 0, 0, 0, 0, 0);
+	if (ret.error)
+		return ret.error;
+
+	return ret.value;
+}
+
+/**
+ * sbi_pma_set() - Set a PMA region
+ * @pa:		Physical address of the region
+ * @size:	Size of the region
+ * @flags:	PMA configuration flags
+ *
+ * Return: 0 on success, SBI error on failure
+ */
+int sbi_pma_set(unsigned long pa, unsigned long size, unsigned long flags)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_PMA_SET,
+			pa, size, flags, 0, 0, 0);
+
+	return ret.error;
+}
+
+/**
+ * sbi_pma_free() - Free a PMA region
+ * @pa:		Physical address of the region to free
+ *
+ * Return: 0 on success, SBI error on failure
+ */
+int sbi_pma_free(unsigned long pa)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_PMA_FREE,
+			pa, 0, 0, 0, 0, 0);
+
+	return ret.error;
+}
+
 #ifdef CONFIG_SBI_V01
 
 /**
-- 
2.34.1

