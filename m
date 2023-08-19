Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7258FEE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807EB8704C;
	Sat, 19 Aug 2023 16:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455083;
	bh=QGPmx7CO/S8R6DCmDzE7TTFwJa3Q/tQnGFpVD7+b/Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LbPvmQv+5ArAEVh5RlVvkG0OcI9baf8bO44CTNu2bHs3kQFbZN2GjxRbCZhWZiNbX
	 RpUH/A6ILR0MJjcE9/De3Iz/E1pXCfRbpzBaWW2gr8uL2z1nilCpY8Zhdh1Qm9DjKp
	 uvm8T/GpolORr8/4iYY1boEsUPHe9blFBILwy0PIJO4zYV9CX+15nm067CR06+kAoD
	 +dPoKD50ufy/J22K+ZuBhkVfpCB8nF8EsKq/0OEj/VqUg0iXY4Y9OUjpwxhjp4dseA
	 nmwY1CZ/kaEMphqBtLmonaVvNueNveIsuT9U9kWaz9U1JgF872sxEM/pfGoEyeSkM0
	 MRbY8GjhhnURw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E04C087022;
 Sat, 19 Aug 2023 16:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455080;
 bh=QGPmx7CO/S8R6DCmDzE7TTFwJa3Q/tQnGFpVD7+b/Bk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EzQAWswuDT0rABDJTcB+UXABVDiteT3ZSqT+6HkKvEeMv302eKN404qJyCCOf8ooQ
 M6OQhKV6XTHu1JWXvD39XTWZDTo2xE9OO35WMWGy1etAak8J8Mf1jNaAl50FPh1rKe
 5eExEZzRiluU5Cb1oaS/pz+A8lJ76Wd4M4Hbra2x6A2A4cUz4atodTG7DfAWaBlkpn
 HviD8sVVP231LaBKMseTOo7nhdtGasJLruDPXjg/YDyhJvL5IWO7obTe7sx7YzqcTZ
 9irWlzD96HowpTYlSWzttiCFuLCURSa9lKHpevQrAajep4tfGjSFPN4w1hvfXuzxHL
 mP6N7jv4fsszA==
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
Subject: [PATCH 06/17] cmd: sdp: Reorder variable declaration
Date: Sat, 19 Aug 2023 16:23:56 +0200
Message-Id: <20230819142407.49632-6-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
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
 cmd/usb_gadget_sdp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/usb_gadget_sdp.c b/cmd/usb_gadget_sdp.c
index 1af82e11366..784d1b49768 100644
--- a/cmd/usb_gadget_sdp.c
+++ b/cmd/usb_gadget_sdp.c
@@ -14,13 +14,13 @@
 
 static int do_sdp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	int controller_index;
 	int ret;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	char *usb_controller = argv[1];
-	int controller_index = simple_strtoul(usb_controller, NULL, 0);
+	controller_index = simple_strtoul(argv[1], NULL, 0);
 	usb_gadget_initialize(controller_index);
 
 	g_dnl_clear_detach();
-- 
2.40.1

