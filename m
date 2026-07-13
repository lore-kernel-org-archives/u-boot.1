Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D07DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3392084C10;
	Mon, 13 Jul 2026 15:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pl5sQgP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3645E84C10; Mon, 13 Jul 2026 15:31:14 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42EBE84B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=3VZNiI1FMkOK8z/5nwRiL5wzi/ANa2wm9Ba/1OQGozY=; b=pl5sQgP9aBK3r1Vso79MwqBFE0
 IXlWHFH8AnY+5Iq8suvjQxoH3vzzh8aFMoSIKz9KUtCkgKyJu2OX4eAv0PBt42Sr645k4kHuH7pJ/
 nGJN+fBrV/UUXGvPvTRttAkHbcHnBRcAGbxKVqklwQpX1NZ4z3qed9SIzSupNzYj4cMO80p26ZhDy
 HP1JxwRobf2vm9qS5Ulx+JzsdJ41A/dJLcwCS53rOQfALJMYtEfLWLGxxooyulJOIRT1tvJshR+hw
 P71grkqlqVpaI7p06AYV34bcFSjKMyjlEw3X3iUUoTdZEB6awiZcJSwdea5hK7112qsKKd6R+HukH
 2HxfWFPA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHu-000Dms-0a; Mon, 13 Jul 2026 15:01:34 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHt-000Hfn-0u; Mon, 13 Jul 2026 15:01:33 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 5/6] board: tqma6: implement ENET errata workaround detection
Date: Mon, 13 Jul 2026 15:01:05 +0200
Message-ID: <20260713130109.321862-6-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
References: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

TQMa6 SOM beginning with hardware rev. 0200 comes in two flavours:
With and without a hardware workaround for ENET errata err006687.
Therefore we need two flavours of device tree. To be able to detect
the presence of the workaround we need to check GPIO1_6 is connected
to I2C bus or not. If the I2C bus is detected, the workaround is not
used and separate I2C buses are used for the SoM and the baseboard.

Later on this detection will be used to select the correct devicetree
at runtime.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/tqma6.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 board/tq/tqma6/tqma6.h | 13 ++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 board/tq/tqma6/tqma6.h

diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 005f08c4e5f..b740ac7d5b1 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -31,6 +31,18 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/*
+ * Rev. 0200 and newer optionally implements GIGE errata fix.
+ * Use a global var to signal presence of the fix. This should be checked
+ * early. If fix is present, system I2C is I2C1 - otherwise I2C3
+ */
+static int has_enet_workaround = -1;
+
+int tqma6_has_enet_workaround(void)
+{
+	return has_enet_workaround;
+}
+
 int dram_init(void)
 {
 	gd->ram_size = imx_ddr_size();
@@ -38,6 +50,36 @@ int dram_init(void)
 	return 0;
 }
 
+#define GPIO_REVDET_PAD_CTRL  (PAD_CTL_PUS_100K_DOWN | PAD_CTL_SPEED_LOW | \
+			       PAD_CTL_DSE_40ohm | PAD_CTL_HYS)
+
+static const iomux_v3_cfg_t tqma6_revdet_pads[] = {
+	MX6_PAD_GPIO_6__GPIO1_IO06 | MUX_PAD_CTRL(GPIO_REVDET_PAD_CTRL),
+};
+
+void tqma6_detect_enet_workaround(void)
+{
+	int ret;
+	struct gpio_desc desc;
+
+	imx_iomux_v3_setup_multiple_pads(tqma6_revdet_pads,
+					 ARRAY_SIZE(tqma6_revdet_pads));
+
+	ret = dm_gpio_lookup_name("GPIO1_6", &desc);
+	if (ret) {
+		pr_err("error: gpio lookup for enet workaround %d\n", ret);
+		return;
+	}
+
+	ret = dm_gpio_get_value(&desc);
+	if (ret == 0)
+		has_enet_workaround = 1;
+	else if (ret > 0)
+		has_enet_workaround = 0;
+
+	dm_gpio_free(NULL, &desc);
+}
+
 int board_early_init_f(void)
 {
 	return tq_bb_board_early_init_f();
@@ -99,11 +141,27 @@ int board_late_init(void)
 {
 	env_set("board_name", tqma6_get_boardname());
 
+	tqma6_detect_enet_workaround();
+
 	tq_bb_board_late_init();
 
 	printf("Board: %s on a %s\n", tqma6_get_boardname(),
 	       tq_bb_get_boardname());
 
+	puts("Enet workaround: ");
+	switch (tqma6_has_enet_workaround()) {
+	case 0:
+		puts("absent");
+		break;
+	case 1:
+		puts("implemented");
+		break;
+	default:
+		puts("Unknown");
+		break;
+	};
+	puts("\n");
+
 	return tq_bb_checkboard();
 }
 
diff --git a/board/tq/tqma6/tqma6.h b/board/tq/tqma6/tqma6.h
new file mode 100644
index 00000000000..0cf38a4d1e3
--- /dev/null
+++ b/board/tq/tqma6/tqma6.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Paul Gerber
+ */
+
+#ifndef __TQMA6_H
+#define __TQMA6_H
+
+int tqma6_has_enet_workaround(void);
+
+#endif /* __TQMA6_H */
-- 
2.43.0

