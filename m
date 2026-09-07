Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD28BC79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AFB3606AA;
	Mon,  7 Sep 2026 15:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bk_N3YCC4fKq; Mon,  7 Sep 2026 15:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 893C76066F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795412;
	b=CqaFjojcOl9Iz4HUQNq7sqcBXkCTbisGGMViTfEYJOSme9bbCgt0URc3OeBX6c11MaR1
	 TS/ulmCzO3vcgd69Ob4tJAeug3qVjA9E4I9sp6NHjd9TeCDm0b6VYQgbFS4eogFL/uaYD
	 PqMWcu91HWu/Nd16CRIHDgSUW60pnYA/MDZDls9R55+1xdnS3cjZ7xoQSVBZ1GjJr20M9
	 hQRiMEGO/QcNhQ4nKoYlX8zZ6I/mXAe/7Crz61neLfsimS48L1suwI5UDkWBIa1nqEwhT
	 E1ld6C+HgHykZbJ+deZO2gNjxZqeElthOwtj+cy2oih7euiTt+BZhGmCJ3ahAmbOVfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mSnsw7j9wM9iL2jXNWl3K9B54LQHiMV5qx96zbTHqpM=;
	b=nWK5QMUUALqHoTfD1hSF1xf3ZQSbS2NdbCrWjF2NfhIVAiTEQZ27nugheg1G1fvAJEW3
	 Sc5UPVQEM1/vVnkvcw0zvQAPffhhUix4zRwpuJHZWoV2/a+bBGhLmiFrt3w6ZXiLdb67s
	 Ej7xzV6KqIjPGkfqsnBkmV300NlBHc4i9fxl+f03f/tguzExa67zdbsw4raA8zpoLPWxY
	 ahc9siAW8bwcsrFpqDYy4NS0og58fUY8L7z1+EiYZC58iuzOAmQy/gsFdia8S3LTw7stx
	 JyZ/6FjKuInSd7RRn3XdKLbYmVDa/oJxFjBrNjCVnbs+7xLTlV+TzPzaOl0bhMQ/EMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ERxY5LZE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795412;
	bh=mSnsw7j9wM9iL2jXNWl3K9B54LQHiMV5qx96zbTHqpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mKjTZwZPYDed5VlBN/fQKD0c2e/jQMrOZBupapr16iaEDoikmS4s+IMX9WTjnNZF/
	 RGkSDRXOeMYRxcZGoy5MQEF12D+qMMHdQOiLhDyd1bczqLVTv51gZVqSIjsBECw9r4
	 5dXcLtNtGUVQ3Ec9/Z+KGr/TSX+oXE3dyS8AlePwIWOMkIJJjfrcti5GfdwWhSY3kg
	 P5Z9NLCv84ufjN4x9s8jh0XXBFo2c9gKm/j55fMt3X0591028/zRYrgiJH2JjB/9XK
	 IEIzS9jhf6zzYqH6NzRcUUa+1ihAsCkMdu3gLx4cUii+j31Yd8YDlZAbYvMelIyCSM
	 29Xr8IM0nxQ4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 893C76066F;
	Mon,  7 Sep 2026 15:36:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B712B9CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8A1A6066F
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id upx7VN8upZgX for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BBE856066E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795410;
 b=Ha85N+d8zr4vKVtV4fuDZKOhGWVNKqKTp+oDL9VvNyHxL822swnTXBXlPCh9rVsPy4Bn
 QnaqMJ1bPPCDXJME4tY+5Wzu+kGYdftW5/61s6TyxC+ngRdvCF4eK4ULUOpZHOV4/dhfG
 UK/oVVeUNSWbcBpFa1mn4k4eFtKrPAzEsu/PEzjsgJZkbWxIxI3c5NfYbxflR9Wi3PB+/
 z3UeHriDvhpZ3qIigevl6sQmy6jfV9Qm5liwLqFdB5cFr6gINYDzyEN6eY5VJKC0t+t3M
 gYP5EOvOscG9otrg8YUkvSpDwJXshMhIXQQU87AkzfT9D1LE5mDGkWTlmBT7RKa69FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795410;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=mSnsw7j9wM9iL2jXNWl3K9B54LQHiMV5qx96zbTHqpM=;
 b=TQGG4gEe3kXwM+qWIlbODQihHu+w8W0ilAHjGf6X8h7yK5iMxzro38LxHvY5uxZRVorX
 tLUicODrAnLUiy+UW1OIr+cV1yLMwWJjYc9yFeRFiXoJo8QH9zQGMXZQz40UGsNxvcelP
 qqSvxECCOFVJqBAk8f/GVZrmUlbO9MqHKHR/qMl9b9n7U9GdaC3hyXtmIuoBdy97HyLi3
 UFW1b5lLO7ISzRNYUR04bYU4QduRzf4E7RE1+/0cgc08c6pwwiIDCoIqSd4F17N6bMFqK
 K/ZRc1fIAc5nuEm+gsszFPirPcaF766zASQGjuWYOUjjnQdLe2xnr12NWzUyJSiR60A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=ERxY5LZE; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=ERxY5LZE
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBE856066E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 234D7B0054C;
 Mon,  7 Sep 2026 17:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795407;
 bh=rxYMZrX3GtiSUX233NkN2feVkuEY8y4TimqwsdBijNY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ERxY5LZEAO0zcvGgJGPsr84YiUXCjQQj/TD5fqK/bRFpKJG5RJk//CxJYhUV16CmA
 fO3U/HO/DCcdhQn5cMaaMPF36YLuYUdPf4iXMk5NNKa72fcMGK6n7istN8iM1zbV8+
 8U6qXNhpu5mSZiSLh50MJ5C9nfMNmKlUz9IxadgUPgkpp3+HLdebf0vVKqdMR6c4LY
 ffYdSNWxqa9pbN4kc66LbE4Kb2eykDpznzAgv5EVxXGHtZqbK4kQrY+EwOO5QAdSCu
 ylw5LYnrbpEPlZUcTfnG5vdTVEIU4OCj3/QNu36W3xdwgpFNDr06eBk0Pxq0byotlQ
 ceCMdp/m7HBcg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 7/8] board: nbxv3: add DPLL status (ZL30733, ZL30643)
Date: Mon,  7 Sep 2026 17:34:09 +0200
Message-ID: <20260907153411.2207773-8-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907153411.2207773-1-vjardin@free.fr>
References: <20260907153411.2207773-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a boot time probe/trace for each Microsemi/Microchip DPLL on the
board:
 - ZL30733
 - ZL30643

The dpll_info command is board code built only for this target, so it
has no sandbox test.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/nbxv3/Makefile       |   1 +
 board/nxp/lx2160a/nbxv3/dpll_zl30733.c | 184 +++++++++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/dpll_zl30733.c

diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index f6df35ed7c5..bea6b0aae8b 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -7,3 +7,4 @@ obj-y += mps_pmbus.o
 obj-y += psu_pmbus.o
 obj-y += vid_handoff.o
 obj-y += carrier.o
+obj-y += dpll_zl30733.o
diff --git a/board/nxp/lx2160a/nbxv3/dpll_zl30733.c b/board/nxp/lx2160a/nbxv3/dpll_zl30733.c
new file mode 100644
index 00000000000..737aadb8eb8
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/dpll_zl30733.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Nodebox v3 - DPLL identification probe (both DPLLs).
+ *
+ * It reads a small set of read-only descriptor registers from each
+ * Microsemi/Microchip DPLL on the board and prints the result on the
+ * console at EVT_LAST_STAGE_INIT time, just before the prompt.
+ * It is purely a basic power on test diagnostic: no configuration
+ * register is written, the DPLL register profile loaded at power-on
+ * is left untouched.
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <event.h>
+#include <log.h>
+#include <spi.h>
+#include <vsprintf.h>
+#include <linux/delay.h>
+
+#define ZL30733_SPI_HZ		12500000
+#define ZL30733_SPI_MODE	SPI_MODE_0
+
+/* The two DPLLs sharing the ZL3073x register protocol on this board */
+static const struct nbxv3_dpll {
+	const char *label;	/* expected part at this location */
+	const char *devname;	/* DM device name for the ad-hoc slave */
+	int bus;		/* U-Boot SPI bus number */
+	int cs;			/* chip select on that bus */
+	u32 hz;			/* SCK ceiling */
+	const char *hint;	/* what to check when reads are implausible */
+} nbxv3_dplls[] = {
+	{
+		.label = "ZL30733", .devname = "zl30733_dpll",
+		.bus = 0, .cs = 0, .hz = ZL30733_SPI_HZ,
+		.hint = "check PROG_DPLL_EN mux",
+	},
+	{
+		.label = "ZL30643", .devname = "zl30643_dpll",
+		.bus = 2, .cs = 1, .hz = 10000000,
+		.hint = "check CS1 rework / RST_B",
+	},
+};
+
+#define ZL30733_REG_INFO	0x00
+#define ZL30733_REG_ID_HI	0x01
+#define ZL30733_REG_ID_LO	0x02
+#define ZL30733_REG_REVISION	0x03
+#define ZL30733_REG_FW_VER	0x05	/* 6 bytes 0x05..0x0A   */
+#define ZL30733_REG_FW_VER_LEN	6
+#define ZL30733_REG_RST_STATUS	0x18
+#define ZL30733_REG_PAGE_SEL	0x7F
+
+#define ZL30733_CMD_READ	0x80	/* OR'd into the 7-bit address */
+
+#define ZL30733_INFO_DEFAULT		0x21
+#define ZL30733_INFO_ID_MASK		0x7f
+#define ZL30733_INFO_EEPROM_BOOTED	0x80
+#define ZL30733_REV_DEFAULT		0x03
+
+static int zl30733_read_block(struct spi_slave *slave, u8 addr, u8 *buf,
+			      size_t len)
+{
+	u8 cmd = ZL30733_CMD_READ | (addr & 0x7F);
+	int ret;
+
+	ret = spi_xfer(slave, 8, &cmd, NULL, SPI_XFER_BEGIN);
+	if (ret)
+		return ret;
+
+	return spi_xfer(slave, len * 8, NULL, buf, SPI_XFER_END);
+}
+
+static int zl30733_select_page0(struct spi_slave *slave)
+{
+	u8 cmd[2] = { ZL30733_REG_PAGE_SEL & 0x7F, 0x00 };
+
+	return spi_xfer(slave, sizeof(cmd) * 8, cmd, NULL,
+			SPI_XFER_BEGIN | SPI_XFER_END);
+}
+
+static int zl30733_dump(struct spi_slave *slave, const struct nbxv3_dpll *d)
+{
+	u8 info, rev, rst;
+	u8 fw[ZL30733_REG_FW_VER_LEN];
+	u8 idbuf[2];
+	u16 id;
+	int ret;
+	bool plausible;
+
+	ret = zl30733_select_page0(slave);
+	if (ret) {
+		printf("DPLL: %s page select failed (%d)\n", d->label, ret);
+		return ret;
+	}
+
+	ret = zl30733_read_block(slave, ZL30733_REG_INFO, &info, 1);
+	if (ret)
+		return ret;
+	ret = zl30733_read_block(slave, ZL30733_REG_ID_HI, idbuf, sizeof(idbuf));
+	if (ret)
+		return ret;
+	id = ((u16)idbuf[0] << 8) | idbuf[1];
+	ret = zl30733_read_block(slave, ZL30733_REG_REVISION, &rev, 1);
+	if (ret)
+		return ret;
+	ret = zl30733_read_block(slave, ZL30733_REG_FW_VER, fw, sizeof(fw));
+	if (ret)
+		return ret;
+	ret = zl30733_read_block(slave, ZL30733_REG_RST_STATUS, &rst, 1);
+	if (ret)
+		return ret;
+
+	plausible = (info & ZL30733_INFO_ID_MASK) == ZL30733_INFO_DEFAULT &&
+		    id != 0x0000 && id != 0xFFFF;
+
+	printf("DPLL: %s @ spi%d:%d  info=0x%02x (%s) id=0x%04x rev=0x%02x\n",
+	       d->label, d->bus, d->cs, info,
+	       (info & ZL30733_INFO_EEPROM_BOOTED) ? "EEPROM boot" : "MCU default boot",
+	       id, rev);
+	printf("      fw_ver=%02x:%02x:%02x:%02x:%02x:%02x  reset_status=0x%02x",
+	       fw[0], fw[1], fw[2], fw[3], fw[4], fw[5], rst);
+	if (!plausible)
+		printf("  [implausible; %s]", d->hint);
+	printf("\n");
+
+	return plausible ? 0 : 1;
+}
+
+static int zl30733_probe_print(void)
+{
+	struct udevice *bus;
+	struct spi_slave *slave;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(nbxv3_dplls); i++) {
+		const struct nbxv3_dpll *d = &nbxv3_dplls[i];
+
+		ret = _spi_get_bus_and_cs(d->bus, d->cs, d->hz,
+					  ZL30733_SPI_MODE,
+					  "spi_generic_drv", d->devname,
+					  &bus, &slave);
+		if (ret) {
+			printf("DPLL: %s spi%d:%d not reachable (%d)\n",
+			       d->label, d->bus, d->cs, ret);
+			continue;
+		}
+
+		ret = spi_claim_bus(slave);
+		if (ret) {
+			printf("DPLL: %s spi_claim_bus failed (%d)\n",
+			       d->label, ret);
+			continue;
+		}
+
+		zl30733_dump(slave, d);
+
+		spi_release_bus(slave);
+	}
+
+	return 0;
+}
+
+static int nbxv3_dpll_last_stage_init(void)
+{
+	zl30733_probe_print();
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, nbxv3_dpll_last_stage_init);
+
+static int do_dpll_info(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	return zl30733_probe_print() < 0 ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(
+	dpll_info, 1, 0, do_dpll_info,
+	"display ZL30733 + ZL30643 DPLL identification + reset status",
+	""
+);
-- 
2.43.0

