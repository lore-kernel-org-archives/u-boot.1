Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0E3C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 012F260776;
	Wed, 26 Aug 2026 13:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7iD9x_eDIjxH; Wed, 26 Aug 2026 13:42:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751752;
	bh=4GH6LwX3PfRhTn9+pOuclcvfG7bXbMWIr2Ai83binxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JXzQPuFzsLXWY3JMWmXPK0ot4rKWG+TfBdbddHznfQP/TJsHo+QfeZv/vbUPA0g27
	 PpewmQ99NCUW6vGeHCYIjLJQCUxDsMgTph5UmtW4M/YayzMmhIlHq3ypVfjYfI4LZa
	 6nDpf7ou7E0JEIONS50Q6kIBGAChngf4dIjViO8w57LJMfAOxioFm6onzdoWy8S88g
	 1RDoYGOD81GKF0fAgl2vxOCKPaAmP1X6RgnSO5uUMjRiinqu0onzK7Y3IDsW9IQfD1
	 +SjCpoP2GkGWwEyBFFrcoMc0LVNHtco97G3Z0B4z400vgqHpguCv8Dq/+Sc3phiDQR
	 PI/ixLDTQmsFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50E646075E;
	Wed, 26 Aug 2026 13:42:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09CAF39E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F012D6067B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5HLPsrchQxlt for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:34:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=QjhxhcLm
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp3.osuosl.org (Postfix) with ESMTPS id 13D00605E1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751295; bh=4GH6LwX3PfRhTn9+pOuclcvfG7bXbMWIr2Ai83binxs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=QjhxhcLmVUtGr0QWiISNcJPGFbMHWgyU4zp2T0mNvQjjKT1QpoRdrOjzvn1d/YywaK183BJEiR2smBCKhiBYSfhKEiX+0JW7qOqWewguw3MfFiQGjRFA28qXZM9adcm9vHRWcC6rfLj4lF9anAOLNN1rrdOiXUJdxBtgM9hKT/kkoYN4wxPu71PKJHfHQSNLTj1YBTtVmZm2lHOMoJJUeQu3KKezxlHUf4PhwFDzPY3EwpUqYdMUvw8DpFdDbgoT81K8N1GiurBsf6aahtW8PrMOzKpZYmRsPExOSLPZjEs+J0CvPWn3HEmyYeEPB2cZoaPvqgScbKbh2Zcn151SkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751295; bh=Ejh4y0MIk/XjoNG/2wh0VlH3IjpgZU28w7OUTt7SR96=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=rNDXq8YxDxzTjj2v6PFUw/VG4YtnlT10wE7uBZJTgpDHryyOSj397FdVW6s8wgFLrJztxYWghvPpYxTCCkpzt5GYHHxu/FMO5dZRq2EbGU0JfWt2bnKgez7xrfp5S7LnTjYFLcyPLw3uYAI68UQWJ4L90hCgryDD9EOC26iy0RrI1DHfY4DGmuJ2cc8OsXepCd7kgABIz+9l67am2cjGrbU2+7tXgbdyPKE2qjLwZ9DUGeGh7A2B9IrGwpq8pK/ZIsiT60cOer7zV5e4NzrxJS99QgjUeCP0QOfCDRg8YESX0aZaCfFSqVJtoPLleNNHYYwqhvsaQrR/+Q37IM80uA==
X-YMail-OSG: AEIZYKQVM1nx.BvQ7W6U9YrQFib1SO9RREiQsgMvwJPS3fMTL6m7DH7mvhyjndR
 Zaj23ljANVNb113H6YvV7i05QJzq3u.bvdJ4CRhnYdb8TWidGoq4ipOGGqQAaLiZeEPmU0J7DM3B
 ue8fMxv_kIh.nJFLMkwYpM99U6JnCa.6W9gUVhhX5N28KO0AoZSAoDLRjUfz1mBhMJf84HI_9Rw2
 zPtP5NKp9t_GJU8Te3F50fri.8AD7BGb6GqsSM4kdqfER6rgh1YMW1pn3VGVEs0XrKCjNdHRDlUy
 X9HPD64ban5s0HijCOKUrrQeZSU_Hf1sb89TUB2tdhO0CguJIb5BJMhK.SYjYtH93rb8f7LuQrhP
 sQ2JMGX9yWArYvlLvlTLEKQsO4ucm8i1ovUAQnePt5XdFZ3Fvwl3vQ7d8LciOyXuycfFUhu.oRwf
 SYIdIYauVCnIfZ3KVl3f1ZSBvc9.SpLKMCJ29_4awIykj6XDfTP8gmaqj4O.BHjFqf_ocqIZHsJl
 lwMbQDw88Rp7NyoNtcbIkvwzHY_OWZqLQD9wz4Uy.C980WQ9XhAp.CAPbJ71wgUf7qQND_EP9NDH
 WAP32y2U0LSc51GNqJVBTPqtbs2ThZnecwi_tgPJ_lM5fyo4qEsG5uXA_gzfs1YHVBBxE4Y4zW5n
 9tJLcoLlZovpGBz7MsHkQYj3egoaqymi0wakdy.LRkb54AHTiUKiga3xmZ1OVbotTZxpwqFmzzNw
 n5VJ8hP6k.xbr4fF.enpf7M5Aqu94XP635m8YU.rGhFWI7x4SXnq28OrSm0jWkcoTlgmQ7f0x_mE
 yjVzwJA.LE4HYU3Io91N_r1W7rc.naCv5YY2Wy6HcVJ2Gk5xRzdKTcgq2UJOH3KOqN.Sk88__4sn
 O121iaq24dYsll3CwbgvB91XunjcBqis69M06cVaNp0FHcoNJ09wW7Xu.qBdZgfOPlsIrs_VJH.8
 iOoJda2nO7I9jgQOq0.JIMHQ1HwnW_cDbNFt2b4cVCTzJcD_z1P28f4tD_6bIKsspg7F76p6fzBP
 TvRqIkV3idKZyMi8pkpHVQHbP0D0znK7LPDDVQK.Il0gCfeCfFQYAVIyBqR2xtuc9BkOLF_xgkq4
 7RTC3.XGb8Nz5nujb1oL_quuYuy0nIC1KHDCd.FJ0ggmCCNRo511cAf8IJ3LjvTIfC7IhnI29Odv
 CzsTcRtbW2mTqpoO86ERl3xwDBEBwxOutiPEUIuEZ22lCT6uQ8PIJEwsT5e_uSn7L7mdXrnQSDzC
 U35IXAKiccjIMBDaR3j09Pi8mIb75IrGh7yaoB38a_ttEFu25Tl2u38yL3EmjOB5oVvuh8Ya0ICn
 AGezcHU97SoS6_0DFeg.WsctElSikFt3LsLlqIJSsE4_q.6GecOBIQBOpwz1ovlIWod0hXNKNbqa
 8MbfzaBEdxwQfkKAh.wsnB6sLGViHxWiSRFPyxKWfAsbXHqAw6KHl7nr1VpItYGllhSvc9tAQh51
 Ub5L1qBE2.fAyRJuz5Bl7tswG9FJwZc12hOuuGLXk0C3XC2gkybeEVI26VBdWYZWCneezyFjpEbA
 sKXaH9pvc6qH8doe3DiukBSa.qonjE.w3C08XSIOY4bDCU.f36oL0n68wwSAaQgAs3_sg4ALjYr8
 IiQMujKxd_YnwZLRTgDDq81ggM1nQDZ_32DqE5KHiJzzcsieKW3czKru7LGKGbcezzxgVwcvZ0rd
 2dF6nNdJnFRX7KMxuBozp_xI2y5z5MbTQISnLVh.JfywPKQ9fQhNgjqJAtPTtbqUhgerMsIBXQHB
 j8qMoXAup4iQQM3BNUmRk_8eu6cIZKtbnMViv6qN9T9xSZhKeKIFOaIxb2PyyMriAdRpEMTUFm9j
 2Or.T9wpInkog8iTFrClfpnmvg5FOPDavj28LP2TTx6W4DdoBUMmxaylHej.f2BYKlXTBXq8zYR9
 v9gFyjTdODdskmvN4k5djBJTncUedBExlhjhyRiC.XmxVpepya1z884icQOWhgFqvqYsWQlu7YfF
 60OKfIasmAUbFsgsR3wiyJJTZ0nj.Q68x5jfT5_idj4x0NfXuXUAlBZJXHiyunWwxfBF_arg5MIZ
 iZhQ-
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: d78c7834-eebf-4818-9af6-4ee1bf23bce0
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Wed, 26 Aug 2026 13:34:55 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:34:51 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 2/9] mips: en75xx: add TPL and SPL early boot stages
Date: Wed, 26 Aug 2026 19:04:36 +0530
Message-ID: <624fa6727c5540de89f98a8ef0015c413eb79699.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add the TPL and SPL stages for the EN75xx. The TPL brings up the cache
and SoC straps, runs the vendor DDR calibration stage from flash via the
early SFC (serial-flash controller) reader, then the SPL loads U-Boot
proper.

The DDR calibration stage is a vendor artifact read from flash at boot
and is not shipped in-tree; see doc/board/econet/en7528.rst for
how to obtain it and its checksums.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 arch/mips/mach-en75xx/early_sfc.c  | 352 +++++++++++++++++++++++++++++
 arch/mips/mach-en75xx/spl/Makefile |   2 +
 arch/mips/mach-en75xx/spl/spl.c    |  47 ++++
 arch/mips/mach-en75xx/tpl/Makefile |   3 +
 arch/mips/mach-en75xx/tpl/start.S  | 101 +++++++++
 arch/mips/mach-en75xx/tpl/tpl.c    | 158 +++++++++++++
 6 files changed, 663 insertions(+)
 create mode 100644 arch/mips/mach-en75xx/early_sfc.c
 create mode 100644 arch/mips/mach-en75xx/spl/Makefile
 create mode 100644 arch/mips/mach-en75xx/spl/spl.c
 create mode 100644 arch/mips/mach-en75xx/tpl/Makefile
 create mode 100644 arch/mips/mach-en75xx/tpl/start.S
 create mode 100644 arch/mips/mach-en75xx/tpl/tpl.c

diff --git a/arch/mips/mach-en75xx/early_sfc.c b/arch/mips/mach-en75xx/early_sfc.c
new file mode 100644
index 00000000..39fc070d
--- /dev/null
+++ b/arch/mips/mach-en75xx/early_sfc.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Minimal EN7512/EN7521 serial-flash reader used before driver model.
+ * Reconstructed from the vendor TCBoot move_data stage.
+ */
+
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <mach/en75xx.h>
+
+#define SF_READ_IDLE_EN		0x004
+#define SF_MTX_MODE_TOG		0x014
+#define SF_RDCTL_FSM			0x018
+#define SF_MACMUX_SEL			0x01c
+#define SF_MANUAL_EN			0x020
+#define SF_MANUAL_OPFIFO_EMPTY		0x024
+#define SF_MANUAL_OPFIFO_WDATA		0x028
+#define SF_MANUAL_OPFIFO_FULL		0x02c
+#define SF_MANUAL_OPFIFO_WR		0x030
+#define SF_MANUAL_DFIFO_FULL		0x034
+#define SF_MANUAL_DFIFO_WDATA		0x038
+#define SF_MANUAL_DFIFO_EMPTY		0x03c
+#define SF_MANUAL_DFIFO_RD		0x040
+#define SF_MANUAL_DFIFO_RDATA		0x044
+#define SF_SI_CK_SEL			0x09c
+#define SF_STRAP			0x114
+
+#define SF_STRAP_ADDR_4B		BIT(0)
+#define SF_STRAP_SPI_NAND		BIT(1)
+#define SF_STRAP_DUMMY_APPEND		BIT(2)
+
+#define OP_CSH				0x00
+#define OP_CSL				0x01
+#define OP_CK				0x02
+#define OP_OUTS				0x08
+#define OP_INS				0x0c
+
+#define OP_SHIFT			9
+#define OP_CMD_MASK			0x1f
+#define OP_LEN_MASK			0x1ff
+
+#define SPIN_LIMIT			1000000
+#define NAND_PAGE_SIZE			2048
+#define NOR_READ_CHUNK			1024
+
+static inline void __iomem *sf_reg(u32 reg)
+{
+	return (void __iomem *)(EN75XX_SFC_BASE + reg);
+}
+
+static int sf_wait_eq(u32 reg, u32 expected)
+{
+	unsigned int timeout = SPIN_LIMIT;
+
+	while (timeout--) {
+		if (__raw_readl(sf_reg(reg)) == expected)
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int sf_op(u32 op, u32 len)
+{
+	u32 val = ((op & OP_CMD_MASK) << OP_SHIFT) | (len & OP_LEN_MASK);
+	int ret;
+
+	ret = sf_wait_eq(SF_MANUAL_OPFIFO_FULL, 0);
+	if (ret)
+		return ret;
+
+	__raw_writel(val, sf_reg(SF_MANUAL_OPFIFO_WDATA));
+	__raw_writel(1, sf_reg(SF_MANUAL_OPFIFO_WR));
+
+	return sf_wait_eq(SF_MANUAL_OPFIFO_EMPTY, 1);
+}
+
+static int sf_put_byte(u8 val)
+{
+	int ret = sf_wait_eq(SF_MANUAL_DFIFO_FULL, 0);
+
+	if (ret)
+		return ret;
+
+	__raw_writel(val, sf_reg(SF_MANUAL_DFIFO_WDATA));
+	return 0;
+}
+
+static int sf_put_bytes(const u8 *buf, size_t len)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < len; i++) {
+		ret = sf_put_byte(buf[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sf_get_byte(u8 *val)
+{
+	int ret = sf_wait_eq(SF_MANUAL_DFIFO_EMPTY, 0);
+
+	if (ret)
+		return ret;
+
+	*val = __raw_readl(sf_reg(SF_MANUAL_DFIFO_RDATA)) & 0xff;
+	__raw_writel(1, sf_reg(SF_MANUAL_DFIFO_RD));
+	return 0;
+}
+
+static int sf_finish(void)
+{
+	int ret;
+
+	ret = sf_op(OP_CSH, 1);
+	if (ret)
+		return ret;
+
+	return sf_op(OP_CK, 5);
+}
+
+int en75xx_sfc_init(void)
+{
+	int ret;
+
+	__raw_writel(0x9, sf_reg(SF_SI_CK_SEL));
+	__raw_writel(0, sf_reg(SF_READ_IDLE_EN));
+
+	ret = sf_wait_eq(SF_RDCTL_FSM, 0);
+	if (ret)
+		return ret;
+
+	__raw_writel(0x9, sf_reg(SF_MTX_MODE_TOG));
+	__raw_writel(1, sf_reg(SF_MACMUX_SEL));
+	__raw_writel(1, sf_reg(SF_MANUAL_EN));
+
+	return 0;
+}
+
+static int sf_nand_load_page(u32 page)
+{
+	u8 page_addr[] = { page >> 16, page >> 8, page };
+	u8 status;
+	unsigned int timeout = SPIN_LIMIT;
+	int ret;
+
+	ret = sf_op(OP_CSL, 1);
+	if (ret)
+		return ret;
+	ret = sf_op(OP_OUTS, 1);
+	if (ret)
+		return ret;
+	ret = sf_put_byte(0x13);
+	if (ret)
+		return ret;
+	ret = sf_op(OP_OUTS, ARRAY_SIZE(page_addr));
+	if (ret)
+		return ret;
+	ret = sf_put_bytes(page_addr, ARRAY_SIZE(page_addr));
+	if (ret)
+		return ret;
+	ret = sf_finish();
+	if (ret)
+		return ret;
+
+	while (timeout--) {
+		ret = sf_op(OP_CSL, 1);
+		if (ret)
+			return ret;
+		ret = sf_op(OP_OUTS, 1);
+		if (ret)
+			return ret;
+		ret = sf_put_byte(0x0f);
+		if (ret)
+			return ret;
+		ret = sf_op(OP_OUTS, 1);
+		if (ret)
+			return ret;
+		ret = sf_put_byte(0xc0);
+		if (ret)
+			return ret;
+		ret = sf_op(OP_INS, 1);
+		if (ret)
+			return ret;
+		ret = sf_get_byte(&status);
+		if (ret)
+			return ret;
+		ret = sf_finish();
+		if (ret)
+			return ret;
+		if (!(status & BIT(0)))
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int sf_nand_read_cache(u32 column, u8 *dst, size_t len,
+			      bool dummy_append)
+{
+	u8 address[3];
+	size_t i;
+	int ret;
+
+	if (dummy_append) {
+		address[0] = column >> 8;
+		address[1] = column;
+		address[2] = 0;
+	} else {
+		address[0] = 0;
+		address[1] = column >> 8;
+		address[2] = column;
+	}
+
+	ret = sf_op(OP_CSL, 1);
+	if (ret)
+		return ret;
+	ret = sf_op(OP_OUTS, 1);
+	if (ret)
+		return ret;
+	ret = sf_put_byte(0x03);
+	if (ret)
+		return ret;
+	ret = sf_op(OP_OUTS, ARRAY_SIZE(address));
+	if (ret)
+		return ret;
+	ret = sf_put_bytes(address, ARRAY_SIZE(address));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < len; i++) {
+		ret = sf_op(OP_INS, 1);
+		if (ret)
+			return ret;
+		ret = sf_get_byte(&dst[i]);
+		if (ret)
+			return ret;
+	}
+
+	return sf_finish();
+}
+
+static int sf_nor_read_once(u32 offset, u8 *dst, size_t len, bool addr4b,
+			    bool dummy_append)
+{
+	u8 address[4];
+	size_t addr_len = 0;
+	size_t i;
+	int ret;
+
+	if (addr4b)
+		address[addr_len++] = offset >> 24;
+	if (dummy_append) {
+		address[addr_len++] = offset >> 8;
+		address[addr_len++] = offset;
+		address[addr_len++] = 0;
+	} else {
+		address[addr_len++] = offset >> 16;
+		address[addr_len++] = offset >> 8;
+		address[addr_len++] = offset;
+	}
+
+	ret = sf_op(OP_CSL, 1);
+	if (ret)
+		return ret;
+	ret = sf_op(OP_OUTS, 1);
+	if (ret)
+		return ret;
+	ret = sf_put_byte(0x03);
+	if (ret)
+		return ret;
+
+	ret = sf_op(OP_OUTS, addr_len);
+	if (ret)
+		return ret;
+	ret = sf_put_bytes(address, addr_len);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < len; i++) {
+		ret = sf_op(OP_INS, 1);
+		if (ret)
+			return ret;
+		ret = sf_get_byte(&dst[i]);
+		if (ret)
+			return ret;
+	}
+
+	return sf_finish();
+}
+
+static int sf_nor_read(u32 offset, u8 *dst, size_t len, bool addr4b,
+		       bool dummy_append)
+{
+	while (len) {
+		size_t chunk = NOR_READ_CHUNK - (offset % NOR_READ_CHUNK);
+		int ret;
+
+		if (chunk > len)
+			chunk = len;
+		ret = sf_nor_read_once(offset, dst, chunk, addr4b,
+				       dummy_append);
+		if (ret)
+			return ret;
+		offset += chunk;
+		dst += chunk;
+		len -= chunk;
+	}
+
+	return 0;
+}
+
+int en75xx_sfc_read(u32 offset, void *dst, size_t len)
+{
+	u32 strap = __raw_readl(sf_reg(SF_STRAP));
+	u8 *buf = dst;
+	int ret;
+
+	if (!(strap & SF_STRAP_SPI_NAND))
+		return sf_nor_read(offset, buf, len, strap & SF_STRAP_ADDR_4B,
+				   strap & SF_STRAP_DUMMY_APPEND);
+
+	while (len) {
+		u32 page = offset / NAND_PAGE_SIZE;
+		u32 column = offset % NAND_PAGE_SIZE;
+		size_t chunk = NAND_PAGE_SIZE - column;
+
+		if (chunk > len)
+			chunk = len;
+
+		ret = sf_nand_load_page(page);
+		if (ret)
+			return ret;
+		ret = sf_nand_read_cache(column, buf, chunk,
+					 strap & SF_STRAP_DUMMY_APPEND);
+		if (ret)
+			return ret;
+
+		offset += chunk;
+		buf += chunk;
+		len -= chunk;
+	}
+
+	return 0;
+}
diff --git a/arch/mips/mach-en75xx/spl/Makefile b/arch/mips/mach-en75xx/spl/Makefile
new file mode 100644
index 00000000..d19fc6e6
--- /dev/null
+++ b/arch/mips/mach-en75xx/spl/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+obj-y += spl.o
diff --git a/arch/mips/mach-en75xx/spl/spl.c b/arch/mips/mach-en75xx/spl/spl.c
new file mode 100644
index 00000000..a42b2837
--- /dev/null
+++ b/arch/mips/mach-en75xx/spl/spl.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <errno.h>
+#include <init.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <mach/en75xx.h>
+
+void __noreturn board_init_f(ulong dummy)
+{
+	spl_init();
+
+	if (IS_ENABLED(CONFIG_SPL_SERIAL))
+		preloader_console_init();
+
+	board_init_r(NULL, 0);
+}
+
+static ulong en75xx_spl_read(struct spl_load_info *load, ulong offset,
+			     ulong count, void *buf)
+{
+	if (en75xx_sfc_read(offset, buf, count))
+		return 0;
+
+	return count;
+}
+
+static int en75xx_spl_load_image(struct spl_image_info *spl_image,
+				 struct spl_boot_device *bootdev)
+{
+	struct spl_load_info load;
+
+	if (en75xx_sfc_init())
+		return -EIO;
+
+	spl_load_init(&load, en75xx_spl_read, NULL, 1);
+	return spl_load(spl_image, bootdev, &load, 0,
+			EN75XX_UBOOT_IMAGE_OFFSET);
+}
+
+SPL_LOAD_IMAGE_METHOD("EN75XX SFC", 0, BOOT_DEVICE_BOARD,
+		      en75xx_spl_load_image);
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_BOARD;
+}
diff --git a/arch/mips/mach-en75xx/tpl/Makefile b/arch/mips/mach-en75xx/tpl/Makefile
new file mode 100644
index 00000000..da834c75
--- /dev/null
+++ b/arch/mips/mach-en75xx/tpl/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+extra-y += start.o
+obj-y += tpl.o
diff --git a/arch/mips/mach-en75xx/tpl/start.S b/arch/mips/mach-en75xx/tpl/start.S
new file mode 100644
index 00000000..1c192e2e
--- /dev/null
+++ b/arch/mips/mach-en75xx/tpl/start.S
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <mach/en75xx.h>
+
+	.set noreorder
+
+ENTRY(_start)
+	b	reset
+	 mtc0	zero, CP0_COUNT
+
+	/*
+	 * TCBoot image descriptor. The magic is byte-reversed in the vendor
+	 * format, while section offsets are stored as big-endian words.
+	 */
+	.org	0x0c
+	.byte	0x36, 0x35, 0x37, 0x38
+	.word	EN75XX_DDR_BLOB_OFFSET
+	.word	EN75XX_DDR_BLOB_OFFSET + EN75XX_DDR_BLOB_SIZE
+	.word	EN75XX_SPL_IMAGE_OFFSET
+	.word	EN75XX_UBOOT_IMAGE_OFFSET
+
+	/* The vendor reset code begins at offset 0x48. */
+	.org	0x48
+reset:
+	/* Disable interrupts and force KSEG0 uncached before DDR exists. */
+	mfc0	t0, CP0_STATUS
+	li	t1, ~(ST0_IE | ST0_KSU)
+	and	t0, t0, t1
+	li	t1, ST0_BEV | ST0_ERL
+	or	t0, t0, t1
+	mtc0	t0, CP0_STATUS
+	mtc0	zero, CP0_CAUSE
+	mtc0	zero, CP0_COMPARE
+
+	mfc0	t0, CP0_CONFIG
+	li	t1, ~7
+	and	t0, t0, t1
+	ori	t0, t0, 2
+	mtc0	t0, CP0_CONFIG
+	ehb
+
+	/* Arbiter and static-memory mappings copied from TCBoot. */
+	li	t0, EN75XX_SYSCTL_BASE
+	li	t1, 0x80071f1e
+	sw	t1, 0x20(t0)
+	li	t1, 0x00071f1f
+	sw	t1, 0x24(t0)
+	li	t1, 0x80050000
+	sw	t1, 0x34(t0)
+
+	li	t0, EN75XX_SMC_BASE
+	li	t1, 0x102d1040
+	sw	t1, 0x00(t0)
+	li	t1, 0x200028d0
+	sw	t1, 0x14(t0)
+
+	/* Disable the interrupt controller. */
+	li	t0, EN75XX_INTC_BASE
+	sw	zero, 0x00(t0)
+	sw	zero, 0x04(t0)
+
+	/* Enable PBUS access to the 48 KiB FE SRAM. */
+	li	t0, EN75XX_FE_SRAM_SEL
+	lw	t1, 0(t0)
+	ori	t1, t1, 1
+	sw	t1, 0(t0)
+	sync
+
+	li	sp, EN75XX_TPL_STACK_ADDR
+	li	fp, EN75XX_TPL_STACK_ADDR
+
+	la	t9, tpl_main
+	jalr	t9
+	 nop
+
+1:	b	1b
+	 nop
+END(_start)
+
+LEAF(en75xx_run_ddr_blob)
+	li	t0, EN75XX_TPL_SAVED_RA
+	sw	ra, 0(t0)
+
+	la	t1, 1f
+	li	t0, EN75XX_SCREG_WR0
+	sw	t1, 0(t0)
+	sync
+
+	li	t9, EN75XX_DDR_BLOB_ADDR
+	jr	t9
+	 nop
+1:
+	li	t0, EN75XX_SCREG_WR0
+	sw	zero, 0(t0)
+	li	t0, EN75XX_TPL_SAVED_RA
+	lw	ra, 0(t0)
+	jr	ra
+	 nop
+END(en75xx_run_ddr_blob)
diff --git a/arch/mips/mach-en75xx/tpl/tpl.c b/arch/mips/mach-en75xx/tpl/tpl.c
new file mode 100644
index 00000000..ca2b2ca8
--- /dev/null
+++ b/arch/mips/mach-en75xx/tpl/tpl.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <compiler.h>
+#include <linux/byteorder/generic.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <mach/en75xx.h>
+
+#define IH_MAGIC	0x27051956
+#define IH_HDR_SIZE	64
+
+struct en75xx_legacy_header {
+	u32 magic;
+	u32 hcrc;
+	u32 time;
+	u32 size;
+	u32 load;
+	u32 ep;
+	u32 dcrc;
+	u8 os;
+	u8 arch;
+	u8 type;
+	u8 comp;
+	u8 name[32];
+};
+
+static u32 get_be32(u32 val)
+{
+	return be32_to_cpu(val);
+}
+
+/*
+ * 16550 register access differs by SoC endianness:
+ *   EN7512 (big-endian): 8-bit registers live in the top byte of each 32-bit
+ *   word, i.e. at byte offset (reg << 2) + 3.
+ *   EN7528 (little-endian, reg-io-width=4, reg-shift=2): 32-bit word access at
+ *   (reg << 2); the 8-bit value sits in the low byte.
+ */
+#if defined(CONFIG_SOC_EN7528)
+static inline void tpl_uart_wr(u32 reg, u32 val)
+{
+	__raw_writel(val, (void __iomem *)(EN75XX_UART0_BASE + (reg << 2)));
+}
+
+static inline u32 tpl_uart_rd(u32 reg)
+{
+	return __raw_readl((void __iomem *)(EN75XX_UART0_BASE + (reg << 2)));
+}
+#else
+static inline void tpl_uart_wr(u32 reg, u32 val)
+{
+	__raw_writeb(val, (void __iomem *)(EN75XX_UART0_BASE + (reg << 2) + 3));
+}
+
+static inline u32 tpl_uart_rd(u32 reg)
+{
+	return __raw_readb((void __iomem *)(EN75XX_UART0_BASE + (reg << 2) + 3));
+}
+#endif
+
+#define UART_RBR_THR	0	/* +0x00: receive/transmit, DLL when DLAB=1 */
+#define UART_IER_DLM	1	/* +0x04: interrupt enable, DLM when DLAB=1 */
+#define UART_IIR_FCR	2	/* +0x08: FIFO control */
+#define UART_LCR	3	/* +0x0c: line control (DLAB) */
+#define UART_MCR	4	/* +0x10: modem control */
+#define UART_LSR	5	/* +0x14: line status (bit5 = THR empty) */
+
+static void tpl_putc(u8 ch)
+{
+	while (!(tpl_uart_rd(UART_LSR) & 0x20))
+		;
+	tpl_uart_wr(UART_RBR_THR, ch);
+}
+
+static void tpl_hang(u8 code)
+{
+	tpl_putc(code);
+	tpl_putc('\r');
+	tpl_putc('\n');
+
+	for (;;)
+		;
+}
+
+static void tpl_uart_init(void)
+{
+#if defined(CONFIG_SOC_EN7528)
+	/*
+	 * EN7528 UART fractional divider: 115200 8N1 = XYD 0xEA00FDE8
+	 * (X=round(baud*13/25)=0xEA00, Y=65000), DLL=1, DLM=0. XYD is reg 11 @
+	 * +0x2c.
+	 */
+	tpl_uart_wr(UART_LCR, 0x80);		/* DLAB = 1 */
+	tpl_uart_wr(11, 0xea00fde8);		/* XYD fractional divider */
+	tpl_uart_wr(UART_RBR_THR, 0x01);	/* DLL = 1 */
+	tpl_uart_wr(UART_IER_DLM, 0x00);	/* DLM = 0 */
+	tpl_uart_wr(UART_LCR, 0x03);		/* 8N1, DLAB = 0 */
+	tpl_uart_wr(UART_IIR_FCR, 0x07);	/* enable + clear FIFOs */
+	tpl_uart_wr(UART_MCR, 0x00);
+	tpl_uart_wr(UART_IER_DLM, 0x00);
+#else
+	void __iomem *base = (void __iomem *)EN75XX_UART0_BASE;
+
+	__raw_writeb(0x80, base + 0x0f);
+	__raw_writel(0xea00fde8, base + 0x2c);
+	__raw_writeb(0x01, base + 0x03);
+	__raw_writeb(0x00, base + 0x07);
+	__raw_writeb(0x03, base + 0x0f);
+	__raw_writeb(0x0f, base + 0x0b);
+	__raw_writeb(0x00, base + 0x13);
+	__raw_writeb(0x00, base + 0x27);
+	__raw_writeb(0x00, base + 0x07);
+#endif
+}
+
+void __noreturn tpl_main(void)
+{
+	struct en75xx_legacy_header *hdr =
+		(struct en75xx_legacy_header *)EN75XX_SPL_HEADER_ADDR;
+	void (*entry)(void);
+	u32 load, size, ep;
+	int ret;
+
+	tpl_uart_init();
+	if (en75xx_sfc_init())
+		tpl_hang('I');
+
+	ret = en75xx_sfc_read(EN75XX_DDR_BLOB_OFFSET,
+			      (void *)EN75XX_DDR_BLOB_ADDR,
+			      EN75XX_DDR_BLOB_SIZE);
+	if (ret)
+		tpl_hang('F');
+
+	en75xx_run_ddr_blob();
+
+	ret = en75xx_sfc_read(EN75XX_SPL_IMAGE_OFFSET, hdr, IH_HDR_SIZE);
+	if (ret || get_be32(hdr->magic) != IH_MAGIC)
+		tpl_hang('H');
+
+	size = get_be32(hdr->size);
+	load = get_be32(hdr->load);
+	ep = get_be32(hdr->ep);
+
+	if (!size || (load & 0xe0000000) != 0x80000000 ||
+	    (ep & 0xe0000000) != 0x80000000 || load + size < load)
+		tpl_hang('L');
+
+	/* Write through KSEG1 so no dirty cache lines hide the SPL image. */
+	ret = en75xx_sfc_read(EN75XX_SPL_IMAGE_OFFSET + IH_HDR_SIZE,
+			      (void *)(load | 0x20000000), size);
+	if (ret)
+		tpl_hang('S');
+
+	__asm__ volatile("sync" : : : "memory");
+	entry = (void (*)(void))ep;
+	entry();
+	__builtin_unreachable();
+}
-- 
2.53.0

