Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B6606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g2rIVfVa;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=njVh1Nr3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38D8040832;
	Mon, 16 Nov 2026 17:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wjAWak5ezmCs; Mon, 16 Nov 2026 17:42:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20BC34080C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850957;
	b=GPNpvY9zScYV9XIvaGKxQ6nasI8W9enn732GDj/Npz79tcYJUSrE+rk8Ffs7dsL2XiZd
	 iBwUxdjw/MHVJUtHvHjeEkm7E9rUsvtoMHHzowRmgkNypQz/G7B3hJi0/H6LkpZWtguaB
	 44k/zz7Gfbd/t+KhLs4zqRLTsXtiuHXveJp3lU85U0qkMBDlH2c2rcXvkOvg9R6CrxJeJ
	 pT4ZqzXf3hofXK8+TNZ+IAuXwXhjQRaWBMm7zmqHj8ZgY4m9xZt4IAsaIfVQ//ofTGMsq
	 U+9gBmVUG4NrVqAMYVtgV9P854fSYhHIASFximObSFaQNhzwdogkiuwMvNMxTKmbyqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zuwVW1fpHIHeXC40XXLBwYLh/XLNVqeKJ9fkWJiCyx0=;
	b=jccEf/LyCgf7I+dCZ2z54gqK4oZJ2kFydVr9JrHWe+ZQW81e06vnllcfbK8cI5Io6N2n
	 KBBWRxjd5KzzH1IkO5grwkngg+cq80tpA0h2Dx2VMzYZOB5Y7i2Y9g42x8FfMXrAVI3du
	 wk4N8UviNru4UP6tOyd+RLf2XQOvYRRALD5gNt/F1TpA94zsVvnPq+oOWwnkc6zu5akll
	 wCTzqJF3Vkjs8pZDYx+if0jMSte8cZRcOfAZrD5sYMemVwsC9yOiGpShBV5ldtvbXld0X
	 OLYVy+rVoxGiVkEmKmeNCWtdsBHS9tQ2dnR1yI+mXeWOjAgyUTWrdtIm6z89zpg/yLQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=njVh1Nr3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850957;
	bh=zuwVW1fpHIHeXC40XXLBwYLh/XLNVqeKJ9fkWJiCyx0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g2rIVfVa55z6QXfybxdvGtNPYqy6kRxiWIcP3ihY300V6R6wICWut8/ezVAeNmYJ+
	 XEeySPk50y4tcATMfTfWTLIbv/fiCQTh1gvV7fgadBhg1I0dOEe5lwa+WYPJFy4KJ2
	 en1aK7JBzxJlgOjykEpKuz7OhJ1nnaxRkFrgo3KMjuRFCrHO+KvLlYtswzxTlNMhZ+
	 Ydqt/GPUsUuQ6U4ysYGQmmgbu9+AOG4PAs7mEsTlw6UOF5dX8eqqM1omonu+CQx616
	 +JOrG94HoychycAI5voKr/RBezvpK1iPNoGIkRiU1gZABIMzF+Ju77Aiw5iMkNcn5r
	 a4ACvz0EvDpLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20BC34080C;
	Mon, 16 Nov 2026 17:42:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E410B4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5210407FA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8FKzeQ0POof for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:42:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A5A2B40807
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=njVh1Nr3
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5A2B40807
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:42:34 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSwDR41VGzMltx;
 Mon, 16 Nov 2026 18:42:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zuwVW1fpHIHeXC40XXLBwYLh/XLNVqeKJ9fkWJiCyx0=;
 b=njVh1Nr3ING2zunNuAhY42aqF586LjWBtZgb+h5WuOp29T6/tkHa+k4jEvNguc0Z16wRdR
 NqU7ttyzGunTjt3y/JMCJw67zhKz8KBYmlbKloOSgwAAS4cye61aZoomywUQkI4hGUIGmE
 iW7/h1Ys8Rk0FW/05WF0KUndve2KUfFpmAE+cB/NUTMwDEqIrBuhxZXksYL94GNl+Qz3zD
 zlCEXbWGhfdkAIP7xDvx+MjA3C3u3YSrfxXvWMZUihnaYg1d0Ye9SUYpOq2cMmUE3TfZMm
 8wnKzCNkGsPRABWo0hDtZqh2HGUyOzImtj/crR8lct1qBnweSTm+jWeCzVWDtA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Bin Liu <b-liu@ti.com>,
 Bradley Morgan <bradley.morgan@linux.dev>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>, Fabio Estevam <festevam@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Joel Stanley <joel@jms.id.au>, Julien Stephan <jstephan@baylibre.com>,
 Mario Six <mario.six@gdsys.cc>, Minda Chen <minda.chen@starfivetech.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ram: Constify driver ops
Date: Mon, 16 Nov 2026 18:42:19 +0100
Message-ID: <20261116174226.3488225-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dd436fbdc3f1578a374
X-MBO-RS-META: tj7iw9tet7nnzjnr1ydm76gtmk7515jf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Bin Liu <b-liu@ti.com>
Cc: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Hal Feng <hal.feng@starfivetech.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Minda Chen <minda.chen@starfivetech.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.u-boot-project.org
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/ram/aspeed/sdram_ast2500.c   | 2 +-
 drivers/ram/aspeed/sdram_ast2600.c   | 2 +-
 drivers/ram/aspeed/sdram_ast2700.c   | 2 +-
 drivers/ram/imxrt_sdram.c            | 2 +-
 drivers/ram/k3-am654-ddrss.c         | 2 +-
 drivers/ram/k3-ddrss/k3-ddrss.c      | 2 +-
 drivers/ram/mediatek/ddr3-mt7629.c   | 2 +-
 drivers/ram/mpc83xx_sdram.c          | 2 +-
 drivers/ram/octeon/octeon_ddr.c      | 2 +-
 drivers/ram/renesas/rzn1/ddr_async.c | 2 +-
 drivers/ram/sifive/sifive_ddr.c      | 2 +-
 drivers/ram/starfive/starfive_ddr.c  | 2 +-
 drivers/ram/stm32_sdram.c            | 2 +-
 drivers/ram/stm32mp1/stm32mp1_ram.c  | 2 +-
 drivers/ram/sunxi/dram_sun20i_d1.c   | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/ram/aspeed/sdram_ast2500.c b/drivers/ram/aspeed/sdram_ast2500.c
index 0d6ab79f96f..6a63b72a8f8 100644
--- a/drivers/ram/aspeed/sdram_ast2500.c
+++ b/drivers/ram/aspeed/sdram_ast2500.c
@@ -420,7 +420,7 @@ static int ast2500_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops ast2500_sdrammc_ops = {
+static const struct ram_ops ast2500_sdrammc_ops = {
 	.get_info = ast2500_sdrammc_get_info,
 };
 
diff --git a/drivers/ram/aspeed/sdram_ast2600.c b/drivers/ram/aspeed/sdram_ast2600.c
index 2cf9296468d..5bd3ed8c4ea 100644
--- a/drivers/ram/aspeed/sdram_ast2600.c
+++ b/drivers/ram/aspeed/sdram_ast2600.c
@@ -1158,7 +1158,7 @@ static int ast2600_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops ast2600_sdrammc_ops = {
+static const struct ram_ops ast2600_sdrammc_ops = {
 	.get_info = ast2600_sdrammc_get_info,
 };
 
diff --git a/drivers/ram/aspeed/sdram_ast2700.c b/drivers/ram/aspeed/sdram_ast2700.c
index 8605a92abb2..b8c2f5336b2 100644
--- a/drivers/ram/aspeed/sdram_ast2700.c
+++ b/drivers/ram/aspeed/sdram_ast2700.c
@@ -1021,7 +1021,7 @@ static int ast2700_sdrammc_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops ast2700_sdrammc_ops = {
+static const struct ram_ops ast2700_sdrammc_ops = {
 	.get_info = ast2700_sdrammc_get_info,
 };
 
diff --git a/drivers/ram/imxrt_sdram.c b/drivers/ram/imxrt_sdram.c
index 3df106c9b79..f5a1e5e60e0 100644
--- a/drivers/ram/imxrt_sdram.c
+++ b/drivers/ram/imxrt_sdram.c
@@ -434,7 +434,7 @@ static int imxrt_semc_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops imxrt_semc_ops = {
+static const struct ram_ops imxrt_semc_ops = {
 	.get_info = imxrt_semc_get_info,
 };
 
diff --git a/drivers/ram/k3-am654-ddrss.c b/drivers/ram/k3-am654-ddrss.c
index 21ff9d761e1..13a11f0626a 100644
--- a/drivers/ram/k3-am654-ddrss.c
+++ b/drivers/ram/k3-am654-ddrss.c
@@ -1078,7 +1078,7 @@ static int am654_ddrss_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops am654_ddrss_ops = {
+static const struct ram_ops am654_ddrss_ops = {
 	.get_info = am654_ddrss_get_info,
 };
 
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index c406998b20a..4595ef47b9a 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -1011,7 +1011,7 @@ static int k3_ddrss_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops k3_ddrss_ops = {
+static const struct ram_ops k3_ddrss_ops = {
 	.get_info = k3_ddrss_get_info,
 };
 
diff --git a/drivers/ram/mediatek/ddr3-mt7629.c b/drivers/ram/mediatek/ddr3-mt7629.c
index e9791697066..597f9e51ad3 100644
--- a/drivers/ram/mediatek/ddr3-mt7629.c
+++ b/drivers/ram/mediatek/ddr3-mt7629.c
@@ -750,7 +750,7 @@ static int mtk_ddr3_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops mtk_ddr3_ops = {
+static const struct ram_ops mtk_ddr3_ops = {
 	.get_info = mtk_ddr3_get_info,
 };
 
diff --git a/drivers/ram/mpc83xx_sdram.c b/drivers/ram/mpc83xx_sdram.c
index 28a663289a2..9003febd7d1 100644
--- a/drivers/ram/mpc83xx_sdram.c
+++ b/drivers/ram/mpc83xx_sdram.c
@@ -1074,7 +1074,7 @@ static int mpc83xx_sdram_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops mpc83xx_sdram_ops = {
+static const struct ram_ops mpc83xx_sdram_ops = {
 	.get_info = mpc83xx_sdram_get_info,
 };
 
diff --git a/drivers/ram/octeon/octeon_ddr.c b/drivers/ram/octeon/octeon_ddr.c
index ff2899d7484..23a36fc32ae 100644
--- a/drivers/ram/octeon/octeon_ddr.c
+++ b/drivers/ram/octeon/octeon_ddr.c
@@ -2710,7 +2710,7 @@ static int octeon_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops octeon_ops = {
+static const struct ram_ops octeon_ops = {
 	.get_info = octeon_get_info,
 };
 
diff --git a/drivers/ram/renesas/rzn1/ddr_async.c b/drivers/ram/renesas/rzn1/ddr_async.c
index 4d470aae191..306193f8678 100644
--- a/drivers/ram/renesas/rzn1/ddr_async.c
+++ b/drivers/ram/renesas/rzn1/ddr_async.c
@@ -250,7 +250,7 @@ static int cadence_ddr_get_info(struct udevice *udev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops cadence_ddr_ops = {
+static const struct ram_ops cadence_ddr_ops = {
 	.get_info = cadence_ddr_get_info,
 };
 
diff --git a/drivers/ram/sifive/sifive_ddr.c b/drivers/ram/sifive/sifive_ddr.c
index c555d2af2d0..007989c4f16 100644
--- a/drivers/ram/sifive/sifive_ddr.c
+++ b/drivers/ram/sifive/sifive_ddr.c
@@ -387,7 +387,7 @@ static int sifive_ddr_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops sifive_ddr_ops = {
+static const struct ram_ops sifive_ddr_ops = {
 	.get_info = sifive_ddr_get_info,
 };
 
diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/starfive_ddr.c
index e151179398f..9083f421b41 100644
--- a/drivers/ram/starfive/starfive_ddr.c
+++ b/drivers/ram/starfive/starfive_ddr.c
@@ -138,7 +138,7 @@ static int starfive_ddr_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops starfive_ddr_ops = {
+static const struct ram_ops starfive_ddr_ops = {
 	.get_info = starfive_ddr_get_info,
 };
 
diff --git a/drivers/ram/stm32_sdram.c b/drivers/ram/stm32_sdram.c
index 954995c499c..533892582d6 100644
--- a/drivers/ram/stm32_sdram.c
+++ b/drivers/ram/stm32_sdram.c
@@ -395,7 +395,7 @@ static int stm32_fmc_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops stm32_fmc_ops = {
+static const struct ram_ops stm32_fmc_ops = {
 	.get_info = stm32_fmc_get_info,
 };
 
diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
index 5f9b91d50e4..1c50e3164f8 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ram.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
@@ -397,7 +397,7 @@ static int stm32mp1_ddr_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops stm32mp1_ddr_ops = {
+static const struct ram_ops stm32mp1_ddr_ops = {
 	.get_info = stm32mp1_ddr_get_info,
 };
 
diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
index 79cf0a51e47..ae2b421e1cc 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.c
+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
@@ -1431,7 +1431,7 @@ static int sunxi_ram_get_info(struct udevice *dev, struct ram_info *info)
 	return 0;
 }
 
-static struct ram_ops sunxi_ram_ops = {
+static const struct ram_ops sunxi_ram_ops = {
 	.get_info = sunxi_ram_get_info,
 };
 
-- 
2.53.0

