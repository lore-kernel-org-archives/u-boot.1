Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D58C3ABBC
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 17:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412768215B;
	Mon,  5 May 2025 19:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="CGqFHPVd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B7C282163; Mon,  5 May 2025 19:59:07 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26E298210D
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 19:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545HJo3a020692;
 Mon, 5 May 2025 17:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pps0720; bh=Ckds/vkrr4YI5
 47607DrL2y/dL5BVykolSky6Gc/9Hc=; b=CGqFHPVdElSAx3ZU8vSCL5tu3sLDg
 F44JR0JFSzAqbDfe5z1HeJjTyQmza5iBtaPAjF3forRLpDipYoA76lhCHkIoufIZ
 FzbI86vt9QtBKEQu1eHIkamlL9HZAONlGRh/9JH/zYjlCg78fRY+aT9LJ5lU8cSx
 dXcTEO25gVmxlVwib5mwLJak7u2xl79gzi9WkPlWmJ9V28Gb2aX+40zQucSvd6hB
 RFHKknXl/X7mnKljqNJz3t/pbrWX1O5TG/5vQthhkVILaOJs5EB8JWb0v6LMzFXd
 p1kmZ9PBuYi8tfRhcXFJ3WoM99x4SlYFJpiE3cy++3TnZVdyQzACjUffw==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 46evp5384y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 17:58:55 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 1AF1080045E;
 Mon,  5 May 2025 17:58:55 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
 by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 7B80780806C;
 Mon,  5 May 2025 17:58:53 +0000 (UTC)
From: verdun@hpe.com
To: verdun@hpe.com, jmverdun3@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v3 1/1] Initial support for Wiznet W5500
Date: Mon,  5 May 2025 17:58:34 +0000
Message-ID: <20250505175834.26874-2-verdun@hpe.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505175834.26874-1-verdun@hpe.com>
References: <20250505175834.26874-1-verdun@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE3MCBTYWx0ZWRfX1eO4/XbGYLWl
 CU//DUaT+VuIgozT2MlTFTsOemZalYgQKWTUL0zkO82+PVaqyyUKcxwJPH8B0OQ0W3/Z+be7Q03
 wUFpwQ9f5r5TSmj3a3tEccxhA/97OXHh7r4xDpEA9x9JR7raTX8LSAIvlX0oODAxEDkfvrqAk5O
 bo/Qd9+q2jXWfsBQlGxQxxCibWzV0WhjoefiMXncsb3hcGrPP/13lpQ3WPuIb/LssX+L4CsUlNQ
 pYPKO1xYYWj8xjxx2rIzYjxdkaww5LhT/ox3BdZ2n58OKB6NF0NcOt+aESqPO/iBd/I5KRjE9GB
 y+o/RhaT5cs/ltsX5Ji1fX96requShtUlsT6S5wJT/qU50KbDZbNUoezY3ab3ZBsfh+OnIDWXXR
 LCQfrun2
X-Proofpoint-GUID: 47-rj4OU0CCxp7hje7cPh3kFjnJGeWM_
X-Proofpoint-ORIG-GUID: 47-rj4OU0CCxp7hje7cPh3kFjnJGeWM_
X-Authority-Analysis: v=2.4 cv=TvLmhCXh c=1 sm=1 tr=0 ts=6818fc5f cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=LRAzMRsBAAAA:8 a=n3L1Gg68AAAA:8
 a=e4MKTBlXAAAA:8 a=MvuuwTCpAAAA:8 a=RAAhVHCUAAAA:8
 a=WMS3Zvg_s6Hi7s_pieIA:9 a=eiwAIEGCQfgA:10 a=d6GWgvC6fySyAPvCsraX:22
 a=p_7pKuLLFrodEiwWNAVu:22 a=y3a8Nef1vbq10CTKF07I:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_08,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505050170
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

From: Jean-Marie Verdun <verdun@hpe.com>

Add support for the Wiznet W5500 spi to ethernet controller

Signed-off-by: Jean-Marie Verdun <verdun@hpe.com>
---
 drivers/net/Kconfig  |   9 +
 drivers/net/Makefile |   1 +
 drivers/net/w5500.c  | 618 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 628 insertions(+)
 create mode 100644 drivers/net/w5500.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 950ed0f25a9..74668f477ae 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -19,6 +19,15 @@ config SPL_DM_ETH
 	depends on SPL_NET
 	def_bool y
 
+config W5500
+	bool "W5500 device driver"
+	depends on SPI
+	help
+	  Enable w5500 driver
+
+	  Adds support for Wiznet W5500 device. The device must be attached
+	  to a SPI bus.
+
 config DM_MDIO
 	bool "Enable Driver Model for MDIO devices"
 	depends on PHYLIB
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 67bba3a8536..6d85c38d869 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_SUN8I_EMAC) += sun8i_emac.o
 obj-$(CONFIG_TSEC_ENET) += tsec.o fsl_mdio.o
 obj-$(CONFIG_TULIP) += dc2114x.o
 obj-$(CONFIG_VSC7385_ENET) += vsc7385.o
+obj-$(CONFIG_W5500) += w5500.o
 obj-$(CONFIG_XILINX_AXIEMAC) += xilinx_axi_emac.o
 obj-$(CONFIG_XILINX_AXIMRMAC) += xilinx_axi_mrmac.o
 obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
diff --git a/drivers/net/w5500.c b/drivers/net/w5500.c
new file mode 100644
index 00000000000..6519339949b
--- /dev/null
+++ b/drivers/net/w5500.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright Hewlett Packard Enterprise Development LP.
+ *
+ * Jean-Marie Verdun <verdun@hpe.com>
+ *
+ * inspired from the linux kernel driver from
+ * Copyright (C) 2006-2008 WIZnet Co.,Ltd.
+ * Copyright (C) 2012 Mike Sinkovsky <msink@permonline.ru>
+ *
+ * available at
+ *
+ * https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/wiznet/w5100.c
+ *
+ * Datasheet:
+ * http://www.wiznet.co.kr/wp-content/uploads/wiznethome/Chip/W5100/Document/W5100_Datasheet_v1.2.6.pdf
+ * http://wiznethome.cafe24.com/wp-content/uploads/wiznethome/Chip/W5200/Documents/W5200_DS_V140E.pdf
+ * http://wizwiki.net/wiki/lib/exe/fetch.php?media=products:w5500:w5500_ds_v106e_141230.pdf
+ *
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <spi.h>
+#include <net.h>
+#include <asm/global_data.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#ifndef __ETH_H
+#define __ETH_H
+
+#include <net.h>
+
+#define BUFFER_SZ       16384
+#define W5100_SPI_WRITE_OPCODE 0xf0
+#define W5100_SPI_READ_OPCODE 0x0f
+#define W5100_SHAR              0x0009	/* Source MAC address */
+#define W5500_S0_REGS           0x10000
+#define S0_REGS(priv)           ((priv)->s0_regs)
+#define W5100_MR                0x0000	/* Mode Register */
+#define   MR_RST                  0x80	/* S/W reset */
+#define   MR_PB                   0x10	/* Ping block */
+
+#define W5100_Sn_MR             0x0000	/* Sn Mode Register */
+#define W5100_Sn_CR             0x0001	/* Sn Command Register */
+#define W5100_Sn_IR             0x0002	/* Sn Interrupt Register */
+#define W5100_Sn_SR             0x0003	/* Sn Status Register */
+#define W5100_Sn_TX_FSR         0x0020	/* Sn Transmit free memory size */
+#define W5100_Sn_TX_RD          0x0022	/* Sn Transmit memory read pointer */
+#define W5100_Sn_TX_WR          0x0024	/* Sn Transmit memory write pointer */
+#define W5100_Sn_RX_RSR         0x0026	/* Sn Receive free memory size */
+#define W5100_Sn_RX_RD          0x0028	/* Sn Receive memory read pointer */
+
+#define W5100_S0_MR(priv)       (S0_REGS(priv) + W5100_Sn_MR)
+
+#define   S0_MR_MACRAW            0x04	/* MAC RAW mode */
+#define   S0_MR_MF                0x40	/* MAC Filter for W5100 and W5200 */
+#define   W5500_S0_MR_MF          0x80	/* MAC Filter for W5500 */
+#define W5100_S0_MR(priv)       (S0_REGS(priv) + W5100_Sn_MR)
+
+#define   S0_MR_MACRAW            0x04	/* MAC RAW mode */
+#define   S0_MR_MF                0x40	/* MAC Filter for W5100 and W5200 */
+#define   W5500_S0_MR_MF          0x80	/* MAC Filter for W5500 */
+
+/*
+ * W5100 and W5200 common registers about the same with the W5500
+ */
+#define W5100_IMR               0x0016	/* Interrupt Mask Register */
+#define   IR_S0                   0x01	/* S0 interrupt */
+#define W5100_RTR               0x0017	/* Retry Time-value Register */
+#define   RTR_DEFAULT             2000	/* =0x07d0 (2000) */
+#define W5500_SIMR              0x0018	/* Socket Interrupt Mask Register */
+#define W5500_RTR               0x0019	/* Retry Time-value Register */
+
+#define W5100_S0_CR(priv)       (S0_REGS(priv) + W5100_Sn_CR)
+#define   S0_CR_OPEN              0x01	/* OPEN command */
+#define   S0_CR_CLOSE             0x10	/* CLOSE command */
+#define   S0_CR_SEND              0x20	/* SEND command */
+#define   S0_CR_RECV              0x40	/* RECV command */
+#define W5100_S0_IR(priv)       (S0_REGS(priv) + W5100_Sn_IR)
+#define   S0_IR_SENDOK            0x10	/* complete sending */
+#define   S0_IR_RECV              0x04	/* receiving data */
+#define W5100_S0_SR(priv)       (S0_REGS(priv) + W5100_Sn_SR)
+#define   S0_SR_MACRAW            0x42	/* mac raw mode */
+#define W5100_S0_TX_FSR(priv)   (S0_REGS(priv) + W5100_Sn_TX_FSR)
+#define W5100_S0_TX_RD(priv)    (S0_REGS(priv) + W5100_Sn_TX_RD)
+#define W5100_S0_TX_WR(priv)    (S0_REGS(priv) + W5100_Sn_TX_WR)
+#define W5100_S0_RX_RSR(priv)   (S0_REGS(priv) + W5100_Sn_RX_RSR)
+#define W5100_S0_RX_RD(priv)    (S0_REGS(priv) + W5100_Sn_RX_RD)
+
+#define W5500_TX_MEM_START      0x20000
+#define W5500_TX_MEM_SIZE       0x04000
+#define W5500_RX_MEM_START      0x30000
+#define W5500_RX_MEM_SIZE       0x04000
+
+#define W5500_Sn_RXMEM_SIZE(n)  \
+		(0x1001e + (n) * 0x40000)	/* Sn RX Memory Size */
+#define W5500_Sn_TXMEM_SIZE(n)  \
+		(0x1001f + (n) * 0x40000)	/* Sn TX Memory Size */
+
+/**
+ * A packet handler
+ *
+ * dev - device pointer
+ * pkt - pointer to the "sent" packet
+ * len - packet length
+ */
+typedef int w5500_eth_tx_hand_f(struct udevice *dev, void *pkt,
+				unsigned int len);
+
+/**
+ * struct eth_w5500_priv - memory for w5500 driver
+ *
+ * host_hwaddr - MAC address of mocked machine
+ * disabled - Will not respond
+ * recv_packet_buffer - buffers of the packet returned as received
+ * recv_packet_length - lengths of the packet returned as received
+ * recv_packets - number of packets returned
+ * tx_handler - function to generate responses to sent packets
+ * priv - a pointer to some structure a test may want to keep track of
+ */
+struct eth_w5500_priv {
+	uchar host_hwaddr[ARP_HLEN];
+	bool disabled;
+	uchar *recv_packet_buffer[PKTBUFSRX];
+	int recv_packet_length[PKTBUFSRX];
+	int recv_packets;
+	w5500_eth_tx_hand_f *tx_handler;
+	const struct dm_spi_ops *spi_ops;
+	struct udevice **spi_dev;
+	/* Socket 0 register offset address */
+	u32 s0_regs;
+	/* Socket 0 TX buffer offset address and size */
+	u32 s0_tx_buf;
+	u16 s0_tx_buf_size;
+	/* Socket 0 RX buffer offset address and size */
+	u32 s0_rx_buf;
+	u16 s0_rx_buf_size;
+	bool promisc;
+	u32 msg_enable;
+	u16 offset;
+	void *priv;
+};
+
+static int w5500_spi_write(struct udevice *dev, u32 addr, u8 data);
+static int w5500_spi_read(struct udevice *dev, u32 addr);
+static void w5500_enable_intr(struct udevice *dev);
+static int w5500_spi_read16(struct udevice *dev, u32 addr);
+static int w5500_spi_write16(struct udevice *dev, u32 addr, u16 data);
+static int w5500_writebuf(struct udevice *dev, u16 offset, const u8 *buf,
+			  int len);
+static int w5500_readbuf(struct udevice *dev, u16 offset, u8 *buf, int len);
+static int w5500_writebulk(struct udevice *dev, u32 addr, const u8 *buf,
+			   int len);
+static int xfer(struct udevice *dev, void *dout, unsigned int bout, void *din,
+		unsigned int bin);
+
+#endif /* __ETH_H */
+
+static int w5500_spi_read(struct udevice *dev, u32 addr)
+{
+	u8 bank;
+	u8 cmd[3];
+	u8 data;
+	int ret;
+
+	bank = (addr >> 16);
+
+	if (bank > 0)
+		bank = bank << 3;
+
+	cmd[0] = addr >> 8;
+	cmd[1] = addr & 0xff;
+	cmd[2] = bank;
+
+	ret = xfer(dev, cmd, sizeof(cmd), &data, 1);
+
+	return data;
+}
+
+static int w5500_spi_write(struct udevice *dev, u32 addr, u8 data)
+{
+	u8 bank;
+	u8 din = 0;
+	u8 cmd[4];
+
+	bank = (addr >> 16);
+
+	if (bank > 0)
+		bank = bank << 3;
+
+	cmd[0] = (addr >> 8) & 0xff;
+	cmd[1] = addr & 0xff;
+	cmd[2] = bank | 0x4;
+	cmd[3] = data;
+
+	return xfer(dev, cmd, sizeof(cmd), &din, 0);
+}
+
+static int w5500_spi_read16(struct udevice *dev, u32 addr)
+{
+	u16 data;
+	int ret;
+	u8 bank;
+	u8 cmd[3];
+
+	bank = (addr >> 16);
+
+	if (bank > 0)
+		bank = bank << 3;
+
+	cmd[0] = addr >> 8;
+	cmd[1] = addr & 0xff;
+	cmd[2] = bank;
+
+	ret = xfer(dev, cmd, sizeof(cmd), &data, 2);
+
+	return data;
+}
+
+static int w5500_spi_write16(struct udevice *dev, u32 addr, u16 data)
+{
+	int ret;
+	u8 buf[2];
+
+	buf[0] = data >> 8;
+	buf[1] = data & 0xff;
+
+	ret = w5500_writebulk(dev, addr, &buf[0], 2);
+
+	return ret;
+}
+
+static int w5500_readbulk(struct udevice *dev, u32 addr, u8 *buf, int len)
+{
+	int i;
+	u8 data[9000];
+	u8 bank;
+	u8 cmd[3];
+	int ret;
+
+	bank = (addr >> 16);
+
+	if (bank > 0)
+		bank = bank << 3;
+
+	cmd[0] = addr >> 8;
+	cmd[1] = addr & 0xff;
+	cmd[2] = bank;
+
+	ret = xfer(dev, cmd, sizeof(cmd), &data, len);
+
+	for (i = 0; i < len; i++)
+		buf[(len - 1) - i] = data[i];
+
+	return 0;
+}
+
+static int w5500_writebulk(struct udevice *dev, u32 addr, const u8 *buf,
+			   int len)
+{
+	int i;
+	u8 bank;
+	u8 cmd[9000];
+	u8 din = 0;
+
+	bank = (addr >> 16);
+	if (bank > 0)
+		bank = bank << 3;
+
+	cmd[0] = (addr >> 8) & 0xff;
+	cmd[1] = addr & 0xff;
+	cmd[2] = bank | 0x4;
+
+	for (i = 0; i < len; i++)
+		cmd[i + 3] = buf[i];
+
+	return xfer(dev, cmd, len + 3, &din, 0);
+}
+
+static int w5500_readbuf(struct udevice *dev, u16 offset, u8 *buf, int len)
+{
+	u32 addr;
+	int remain = 0;
+	int ret;
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	const u32 mem_start = priv->s0_rx_buf;
+	const u16 mem_size = priv->s0_rx_buf_size;
+
+	offset %= mem_size;
+	addr = mem_start + offset;
+
+	if (offset + len > mem_size) {
+		remain = (offset + len) % mem_size;
+		len = mem_size - offset;
+	}
+
+	ret = w5500_readbulk(dev, addr, buf, len);
+	if (ret || !remain)
+		return ret;
+
+	return w5500_readbulk(dev, mem_start, buf + len, remain);
+}
+
+static int w5500_writebuf(struct udevice *dev, u16 offset, const u8 *buf,
+			  int len)
+{
+	u32 addr;
+	int ret;
+	int remain = 0;
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	const u32 mem_start = priv->s0_tx_buf;
+	const u16 mem_size = priv->s0_tx_buf_size;
+
+	offset %= mem_size;
+	addr = mem_start + offset;
+
+	if (offset + len > mem_size) {
+		remain = (offset + len) % mem_size;
+		len = mem_size - offset;
+	}
+
+	ret = w5500_writebulk(dev, addr, buf, len);
+
+	if (ret || !remain)
+		return ret;
+
+	return w5500_writebulk(dev, mem_start, buf + len, remain);
+}
+
+static int w5500_command(struct udevice *dev, u8 cmd)
+{
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	u8 val;
+	u16 check;
+
+	w5500_spi_write(dev, W5100_S0_CR(priv), cmd);
+	check =
+	    read_poll_timeout(w5500_spi_read, val, val != 0, 10, 5000, dev,
+			      W5100_S0_CR(priv));
+	if (check != 0)
+		return -EIO;
+
+	return 0;
+}
+
+static int w5500_eth_start(struct udevice *dev)
+{
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+
+	debug("eth_w5500: Start\n");
+
+	u8 mode = S0_MR_MACRAW;
+
+	if (!priv->promisc)
+		mode |= W5500_S0_MR_MF;
+
+	w5500_spi_write(dev, W5100_S0_MR(priv), mode);
+	w5500_command(dev, S0_CR_OPEN);
+	priv->offset = 0;
+
+	return 0;
+}
+
+static int w5500_eth_send(struct udevice *dev, void *packet, int length)
+{
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	u16 offset;
+
+	if (priv->disabled)
+		return 0;
+
+	offset = w5500_spi_read16(dev, W5100_S0_TX_WR(priv));
+	w5500_writebuf(dev, offset, packet, length);
+	w5500_spi_write16(dev, W5100_S0_TX_WR(priv), offset + length);
+	w5500_command(dev, S0_CR_SEND);
+
+	return 0;
+}
+
+static int w5500_eth_recv(struct udevice *dev, int flags, u8 **packetp)
+{
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	u16 rx_len;
+	u16 offset;
+	u8 data[9000];
+	u16 tmp;
+	u16 rx_buf_len;
+
+	rx_buf_len = w5500_spi_read16(dev, W5100_S0_RX_RSR(priv));
+
+	while ((tmp =
+		w5500_spi_read16(dev, W5100_S0_RX_RSR(priv))) != rx_buf_len)
+		rx_buf_len = tmp;
+
+	if (rx_buf_len == 0)
+		return 0;
+
+	offset = w5500_spi_read16(dev, W5100_S0_RX_RD(priv));
+	rx_len = rx_buf_len - 2;
+	w5500_readbuf(dev, offset + 2, data, rx_len);
+	w5500_spi_write16(dev, W5100_S0_RX_RD(priv), offset + 2 + rx_len);
+	w5500_command(dev, S0_CR_RECV);
+	*packetp = data;
+
+	priv->offset += rx_buf_len;
+
+	return rx_len;
+}
+
+static int w5500_eth_free_pkt(struct udevice *dev, u8 *packet, int length)
+{
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	int i;
+
+	if (!priv->recv_packets)
+		return 0;
+
+	--priv->recv_packets;
+	for (i = 0; i < priv->recv_packets; i++) {
+		priv->recv_packet_length[i] = priv->recv_packet_length[i + 1];
+		memcpy(priv->recv_packet_buffer[i],
+		       priv->recv_packet_buffer[i + 1],
+		       priv->recv_packet_length[i + 1]);
+	}
+	priv->recv_packet_length[priv->recv_packets] = 0;
+
+	return 0;
+}
+
+static void w5500_eth_stop(struct udevice *dev)
+{
+	dev_dbg(dev, "eth_w5500: Stop\n");
+}
+
+static int xfer(struct udevice *dev, void *dout, unsigned int bout, void *din,
+		unsigned int bin)
+{
+	/* Ok the xfer function in uboot is symmetrical
+	 * (write and read operation happens at the same time)
+	 * w5500 requires bytes send followed by receive operation on the MISO line
+	 * So we need to create a buffer which contain bout+bin bytes and pass the various
+	 * pointer to the xfer function
+	 */
+
+	struct udevice *bus = dev_get_parent(dev);
+	u8 buffin[BUFFER_SZ];
+	u8 buffout[BUFFER_SZ];
+
+	if ((bout + bin) < BUFFER_SZ) {
+		for (int i = 0; i < bout; i++) {
+			buffout[i] = ((u8 *)(dout))[i];
+			buffin[i] = 0;
+		}
+		for (int i = bout; i < (bin + bout); i++) {
+			buffin[i] = 0;
+			buffout[i] = 0;
+		}
+		if (bus) {
+			dm_spi_xfer(dev, 8 * (bout + bin), buffout, buffin,
+				    SPI_XFER_BEGIN | SPI_XFER_END);
+			for (int i = bout; i < (bin + bout); i++)
+				((u8 *)(din))[bin + bout - i - 1] = buffin[i];
+		} else {
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int w5500_eth_write_hwaddr(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	u8 eth[6];
+	u8 mode;
+
+	if (memcmp(priv->host_hwaddr, pdata->enetaddr, ARP_HLEN) != 0) {
+		memcpy(priv->host_hwaddr, pdata->enetaddr, ARP_HLEN);
+		w5500_writebulk(dev, W5100_SHAR, priv->host_hwaddr, ARP_HLEN);
+	}
+
+	w5500_readbulk(dev, W5100_SHAR, eth, 6);
+
+	mode = 0x84;
+	w5500_spi_write(dev, W5100_S0_MR(priv), mode);
+	w5500_command(dev, S0_CR_OPEN);
+	w5500_enable_intr(dev);
+
+	return 0;
+}
+
+static const struct eth_ops w5500_eth_ops = {
+	.start = w5500_eth_start,
+	.send = w5500_eth_send,
+	.recv = w5500_eth_recv,
+	.free_pkt = w5500_eth_free_pkt,
+	.stop = w5500_eth_stop,
+	.write_hwaddr = w5500_eth_write_hwaddr,
+};
+
+int w5500_eth_of_to_plat(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	u8 mac[8];
+	ofnode remote;
+	const void *ptr;
+	int size;
+
+	size = 0;
+	ptr = ofnode_read_prop(remote, "local-mac-address", &size);
+	if (size == 6) {
+		mac[0] = ((u8 *)ptr)[0];
+		mac[1] = ((u8 *)ptr)[1];
+		mac[2] = ((u8 *)ptr)[2];
+		mac[3] = ((u8 *)ptr)[4];
+		mac[4] = ((u8 *)ptr)[5];
+		mac[5] = ((u8 *)ptr)[5];
+	} else {
+		return -1;
+	}
+
+	memcpy(pdata->enetaddr, (void *)mac, ARP_HLEN);
+
+	priv->disabled = false;
+
+	return 0;
+}
+
+static void w5500_socket_intr_mask(struct udevice *dev, u8 mask)
+{
+	u32 imr;
+
+	imr = W5500_SIMR;
+
+	w5500_spi_write(dev, imr, mask);
+}
+
+static void w5500_disable_intr(struct udevice *dev)
+{
+	w5500_socket_intr_mask(dev, 0);
+}
+
+static void w5500_enable_intr(struct udevice *dev)
+{
+	w5500_socket_intr_mask(dev, IR_S0);
+}
+
+int w5500_eth_probe(struct udevice *dev)
+{
+	struct eth_w5500_priv *priv = dev_get_priv(dev);
+	int i;
+	u16 rtr;
+	u8 cmd[3];
+
+	if (device_get_uclass_id(dev->parent) != UCLASS_SPI) {
+		debug("Error device not attached to a SPI controlled\n");
+		return -ENODEV;
+	}
+
+	cmd[0] = 0x00;
+	cmd[1] = 0x19;
+	cmd[2] = 0;
+
+	w5500_spi_write(dev, W5100_MR, MR_RST);
+	w5500_spi_write(dev, W5100_MR, MR_PB);
+
+	rtr = W5500_RTR;
+	if (w5500_spi_read16(dev, rtr) != RTR_DEFAULT) {
+		debug("RTR issue in probe .... %x\n",
+		      w5500_spi_read16(dev, rtr));
+		return -ENODEV;
+	}
+
+	w5500_disable_intr(dev);
+
+	/* Configure internal RX memory as 16K RX buffer and
+	 * internal TX memory as 16K TX buffer
+	 */
+
+	w5500_spi_write(dev, W5500_Sn_RXMEM_SIZE(0), 0x10);
+	w5500_spi_write(dev, W5500_Sn_TXMEM_SIZE(0), 0x10);
+
+	for (i = 1; i < 8; i++) {
+		w5500_spi_write(dev, W5500_Sn_RXMEM_SIZE(i), 0);
+		w5500_spi_write(dev, W5500_Sn_TXMEM_SIZE(i), 0);
+	}
+
+	priv->s0_regs = W5500_S0_REGS;
+	priv->s0_tx_buf = W5500_TX_MEM_START;
+	priv->s0_tx_buf_size = W5500_TX_MEM_SIZE;
+	priv->s0_rx_buf = W5500_RX_MEM_START;
+	priv->s0_rx_buf_size = W5500_RX_MEM_SIZE;
+	priv->offset = 0;
+
+	return 0;
+}
+
+static const struct udevice_id w5500_eth_ids[] = {
+	{.compatible = "wiznet,w5500" },
+	{ }
+};
+
+U_BOOT_DRIVER(eth_w5500) = {
+	.name = "eth_w5500",
+	.id = UCLASS_ETH,
+	.of_match = w5500_eth_ids,
+	.of_to_plat = w5500_eth_of_to_plat,
+	.probe = w5500_eth_probe,
+	.ops = &w5500_eth_ops,
+	.priv_auto = sizeof(struct eth_w5500_priv),
+	.plat_auto = sizeof(struct eth_pdata),
+};
-- 
2.43.0

