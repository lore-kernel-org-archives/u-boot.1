Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A362CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 237D88693C;
	Fri,  1 Sep 2023 11:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561824;
	bh=1lKlCl1IaGBNxrdIRpvr+T2GP4HCyKoqvjfBn/0eBBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AxV2EK9TkQbCeaMAuFSMuEjCtp9RQ2K2M9VbOGx1FpT+fk7tPRUHuAmIGkLU0SKQI
	 y2W31N9XGuq+ZwOepls9Hx5fgff4G74xYWp2dYRm+k8chvO2mWG8BGBdj7rzlrD2Q7
	 VBrXNFdASray61IqVAz9shtNZ9xNaOrbnzvSavTnR6d6ITQSRXcxQjxlnvgBK+u3+q
	 +jsWy7N4e54m6x9bDkvhZ9m26CHKdKOujYbYiz2xekR+vQCaOS9iTXLY1VsgzjONhX
	 /QPcrJhDgZ3gNpmjI3iv1lpFEmC5TsQBBmECoWHc+bHuw4R9la4WdRGpYGnOCbdSBq
	 /dgffcV6s5rmw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 75176868E8;
 Fri,  1 Sep 2023 11:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561823;
 bh=1lKlCl1IaGBNxrdIRpvr+T2GP4HCyKoqvjfBn/0eBBs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GagahCcQyBk0ZABGJ/3m3InPLD8nraA/V36Sq23vP5D5FJN+ul0/I1qaxJk99cRNk
 8Q1cZS572JkPXu4W/A4QOb2QWj6LQW16ievECxUAKxSK4Ir2XQ+RDWrSwufYxOpZRo
 MyKHWXMu0QFbWzPuHHTS+jLGinHvqOEZ5QoEA2mIniqCZTjXCI2siLcBw1037fa7Dc
 3g9oE1/nGMoWD54oCFBDDy3HxpYEQObeCFLbXGu3I78D0583Enr2L7Yf4yUe++4wNU
 3aUa29jsIvD8pGAJpUbEK2p4JMVXkjTfCx0CEYdIEPBn2SObh1xmf2zgCdDtqkxVL/
 siedlG8P7Bz4Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH v2 07/17] cmd: thordown: Reorder variable declaration
Date: Fri,  1 Sep 2023 11:49:53 +0200
Message-Id: <20230901095003.352930-7-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230901095003.352930-1-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
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

Move the variable declaration around to improve code readability.
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: kernel@puri.sm
---
V2: No change
---
 cmd/thordown.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/cmd/thordown.c b/cmd/thordown.c
index 838764ccef7..0d8dcee5314 100644
--- a/cmd/thordown.c
+++ b/cmd/thordown.c
@@ -15,22 +15,23 @@
 
 int do_thor_down(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	char *interface, *devstring;
+	int controller_index;
+	int ret;
+
 	if (argc < 4)
 		return CMD_RET_USAGE;
 
-	char *usb_controller = argv[1];
-	char *interface = argv[2];
-	char *devstring = argv[3];
-
-	int ret;
-
 	puts("TIZEN \"THOR\" Downloader\n");
 
+	interface = argv[2];
+	devstring = argv[3];
+
 	ret = dfu_init_env_entities(interface, devstring);
 	if (ret)
 		goto done;
 
-	int controller_index = simple_strtoul(usb_controller, NULL, 0);
+	controller_index = simple_strtoul(argv[1], NULL, 0);
 	ret = usb_gadget_initialize(controller_index);
 	if (ret) {
 		pr_err("USB init failed: %d\n", ret);
-- 
2.40.1

