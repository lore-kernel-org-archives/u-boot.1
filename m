Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBAFC47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 21:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2C78793F;
	Sun, 21 Jan 2024 22:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hATgJeej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE74487708; Sun, 21 Jan 2024 22:02:15 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A1F8785C
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 22:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5B27960EB8;
 Sun, 21 Jan 2024 21:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BB04C433A6;
 Sun, 21 Jan 2024 21:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705870931;
 bh=fIYxm1hHp4URAyzkpAaMC6Gzasm/I70/PcHDFzDj/Y8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=hATgJeej3/26C/Z21KsLxTtTuGNC2rBiMCFY0vgAlybrv+0lmHwsxYcD5rJ3EQhfy
 DJVmFOdXUrVwUzgDD09MEIHUYicVBTR+41l5aQwuaGf0S0YlNqTQPng2h9CtuoxC7A
 l0V1xaL8B5cM2YLamhEgjEgumiesgreRxfRw4qdm34TbgPouBAXZH/iY+ePWW2b5BU
 8CwA6altgWEHyfuC5hPG++HShs6ZPjF8kGzGuHpmShEcxw8Pr7m5mIP+7YnwOzB+il
 6FVZikkSvVNDcpAefjZVaqyk8zvqpU6uAXierj8nXXsaRzEogwQSc0xCcf6GDaX8mw
 FZ+S9pNsuxj6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E8B6EC47DDE;
 Sun, 21 Jan 2024 21:02:10 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Mon, 22 Jan 2024 05:02:07 +0800
Subject: [PATCH v2 4/4] net: hifemac: implement `net stats` needed ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-net-v2-4-78a368896f62@outlook.com>
References: <20240122-net-v2-0-78a368896f62@outlook.com>
In-Reply-To: <20240122-net-v2-0-78a368896f62@outlook.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705870930; l=4411;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=PWSJQpQzzsBqIpI4NTZc2hndLbZlKCxXE42lOYMvhRk=;
 b=9ZU94XWeu/OfoIAS9JftzYbZKEfpuAbY9alI8b0MamDDf+lcfMnAJJzNXxBuhUvxknCnzG5dc
 uFEtQ+ms29gCe97DEvWmq6X8xgsdIWdyjqX8Rq3ZrZmd7nHsqkTT0ID
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

3 operations needed by `net stats` are implemented. New `net stats`
output some useful info.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/net/hifemac.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index 39c0233b62..24108bee4b 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -16,6 +16,8 @@
 #include <asm/io.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
+#include <linux/bitfield.h>
+#include <linux/ethtool.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 
@@ -125,6 +127,57 @@ struct hisi_femac_priv {
 	u32 link_status;
 };
 
+struct hisi_femac_stat_entry {
+	const char *name;
+	u32 offset;
+	u32 mask;
+};
+
+/* please refer to the datasheet for the description of these entries */
+const struct hisi_femac_stat_entry hisi_femac_stats_table[] = {
+	{ "rxsof_cnt",		0x584,	GENMASK(31, 28) },
+	{ "rxeof_cnt",		0x584,	GENMASK(27, 24) },
+	{ "rxcrcok_cnt",	0x584,	GENMASK(23, 20) },
+	{ "rxcrcbad_cnt",	0x584,	GENMASK(19, 16) },
+	{ "txsof_cnt",		0x584,	GENMASK(15, 12) },
+	{ "txeof_cnt",		0x584,	GENMASK(11, 8) },
+	{ "txcrcok_cnt",	0x584,	GENMASK(7, 4) },
+	{ "txcrcbad_cnt",	0x584,	GENMASK(3, 0) },
+	{ "pkts_cpu",		0x5a0,	GENMASK(15, 0) },
+	{ "addr_cpu",		0x5a4,	GENMASK(15, 0) },
+	{ "pkts_port",		0x5a8,	GENMASK(15, 0) },
+	{ "pkts_cpu2tx",	0x5ac,	GENMASK(15, 0) },
+	{ "rxdvrise",		0x600,	GENMASK(31, 0) },
+	{ "ifinoctets",		0x604,	GENMASK(31, 0) },
+	{ "octets_rx",		0x608,	GENMASK(31, 0) },
+	{ "local_mac_match",	0x60c,	GENMASK(31, 0) },
+	{ "pkts",		0x610,	GENMASK(31, 0) },
+	{ "broadcastpkts",	0x614,	GENMASK(31, 0) },
+	{ "multicastpkts",	0x618,	GENMASK(31, 0) },
+	{ "ifinucastpkts",	0x61c,	GENMASK(31, 0) },
+	{ "ifinerrors",		0x620,	GENMASK(31, 0) },
+	{ "crcerr",		0x624,	GENMASK(31, 0) },
+	{ "abnormalsizepkts",	0x628,	GENMASK(31, 0) },
+	{ "dot3alignmenterr",	0x62c,	GENMASK(31, 0) },
+	{ "dot3pause",		0x630,	GENMASK(31, 0) },
+	{ "dropevents",		0x634,	GENMASK(31, 0) },
+	{ "flux_frame_cnt",	0x638,	GENMASK(31, 0) },
+	{ "flux_drop_cnt",	0x63c,	GENMASK(31, 0) },
+	{ "mac_not2cpu_pkts",	0x64c,	GENMASK(31, 0) },
+	{ "pkts_tx",		0x780,	GENMASK(31, 0) },
+	{ "broadcastpkts_tx",	0x784,	GENMASK(31, 0) },
+	{ "multicastpkts_tx",	0x788,	GENMASK(31, 0) },
+	{ "ifoutucastpkts_tx",	0x78c,	GENMASK(31, 0) },
+	{ "octets_tx",		0x790,	GENMASK(31, 0) },
+	{ "dot3pause",		0x794,	GENMASK(31, 0) },
+	{ "retry_times_tx",	0x798,	GENMASK(31, 0) },
+	{ "collisions",		0x79c,	GENMASK(31, 0) },
+	{ "dot3latecol",	0x7a0,	GENMASK(31, 0) },
+	{ "dot3colok",		0x7a4,	GENMASK(31, 0) },
+	{ "dot3excessivecol",	0x7a8,	GENMASK(31, 0) },
+	{ "dot3colcnt",		0x7ac,	GENMASK(31, 0) },
+};
+
 static void hisi_femac_irq_enable(struct hisi_femac_priv *priv, int irqs)
 {
 	u32 val;
@@ -334,6 +387,37 @@ static void hisi_femac_stop(struct udevice *dev)
 	writel(SOFT_RESET_ALL, priv->glb_base + GLB_SOFT_RESET);
 }
 
+static int hisi_femac_get_sset_count(struct udevice *dev)
+{
+	return ARRAY_SIZE(hisi_femac_stats_table);
+}
+
+static void hisi_femac_get_strings(struct udevice *dev, u8 *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hisi_femac_stats_table); i++)
+		strcpy(data + i * ETH_GSTRING_LEN, hisi_femac_stats_table[i].name);
+}
+
+/* Non-constant mask variant of FIELD_GET/FIELD_PREP */
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
+static void hisi_femac_get_stats(struct udevice *dev, u64 *data)
+{
+	int i;
+	u32 mask, reg;
+	struct hisi_femac_priv *priv = dev_get_priv(dev);
+	void __iomem *port_base = priv->port_base;
+
+	for (i = 0; i < ARRAY_SIZE(hisi_femac_stats_table); i++) {
+		mask = hisi_femac_stats_table[i].mask;
+		reg = readl(port_base + hisi_femac_stats_table[i].offset);
+
+		data[i] = field_get(mask, reg);
+	}
+}
+
 int hisi_femac_of_to_plat(struct udevice *dev)
 {
 	int ret, i;
@@ -523,6 +607,9 @@ static const struct eth_ops hisi_femac_ops = {
 	.free_pkt	= hisi_femac_free_pkt,
 	.stop		= hisi_femac_stop,
 	.write_hwaddr	= hisi_femac_set_hw_mac_addr,
+	.get_sset_count	= hisi_femac_get_sset_count,
+	.get_strings	= hisi_femac_get_strings,
+	.get_stats	= hisi_femac_get_stats,
 };
 
 static const struct udevice_id hisi_femac_ids[] = {

-- 
2.43.0

