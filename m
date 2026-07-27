Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCD0C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC942606F5;
	Mon, 27 Jul 2026 12:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJCOro_glept; Mon, 27 Jul 2026 12:06:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4DAE606F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153991;
	bh=+ALekMEOnb4nTgAovv6BTWbs5Z7fzytk8AmiNcKhQ/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGv5ehn65d9r6PUl/Ngaak7C8bol0KKyeHCOUdFN4frGMV8hBWmTcvvTHrnS6gBwh
	 G4JyA2yU48bCx0U3YkOeLCrGKrWIHnJ7MXkcaTOxNia/cfsNcBh+NZOZKmyIGA79AP
	 16QEOZQwu4Iq8CX3W0ArTFgjmQTCPVkHTMPjK3shrXoLNUFmfKB7cS6N4Rb5FUy094
	 fiqLY2mXo7LMYXUR9Vtqpo1o4+bC8frqisOcXDbrkkDO1VCm7M0UO8HfbAHVCSzNmK
	 5F8RrmzWSU+S95r5qd7DexJv7qVBpDCZ3CRNhBKNZ9Dsq+VxQInSb9FiPHdrZcbgjI
	 oRHiYFWbKj7UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4DAE606F6;
	Mon, 27 Jul 2026 12:06:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CB1069
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E38580D77
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MOCeXowi4T2X for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 79C7480C88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79C7480C88
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79C7480C88
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK66-000JNZ-23; Mon, 27 Jul 2026 14:06:18 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK66-000I7f-1D; Mon, 27 Jul 2026 14:06:18 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 14:06:19 +0200
Subject: [PATCH RESEND 5/6] board: tqma6: implement ENET errata workaround
 detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6_bis_spl-v1-5-27673934830f@ew.tq-group.com>
References: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
In-Reply-To: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+ALekMEOnb4nTgAovv6BTWbs5Z7fzytk8AmiNcKhQ/s=; b=caVx8EFCypvQgHrRbXwGmL0Li4
 LHUUXCeaajxuhsUfgRLzCK3PXX8VP25MUMOzb68bew0VJs6kz8OQ5nF9VU1srXERabm5nSPu7/iUT
 nSJHBdXO17ON6kldZPkFiQhmCrv5APZjUyguOkFrtrR/u12NR4e4lmDN3RopDe2Dk4L8o2/+UmFNZ
 /6h0QBSEE+8czHFZjFWcwVS1AdKqui3SaoT8Bx17crsn0FDIUTZ5sMtn62BNX0ea0Wl+6Ne72OYM2
 gqpUgzlLgtK8ZfbmFkv9NLWyQRdS/5T5mP1iMiuJlN8Kp2ebYQuKG7NoXr8mtbPt9DLm3SBwpPnZj
 gJ8h8rNA==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=caVx8EFC
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 board/tq/tqma6/tqma6.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 board/tq/tqma6/tqma6.h | 13 +++++++++++
 2 files changed, 71 insertions(+)

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

