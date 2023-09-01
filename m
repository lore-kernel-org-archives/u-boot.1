Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3456CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0EC98692D;
	Fri,  1 Sep 2023 11:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561823;
	bh=IpShtkwkpsImbfZmkAlVw/JzQY0xc39cpMQ6pn5NBGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QmyxgEjGsUC9d3IJHfFQMcpfj4pvyoLy2t5u+Rfsfvqt3BYO2KssEKsExTIGWddVh
	 mAjOHCHGGvgiOk5FhCigpuznf2HYJ4iqFtjssqeGbbs9DEg+mD0iKCaNXLBdVtIpPE
	 VWwk/39QkZi1onpiy47N9hNSYKrmf1mZ+A29izgLZif0AjT1c/zPc+UnCMS8os1ftf
	 9A5RfxwM+S2NatXxvvXQhhU8dfoyz8NaIn9IMc56mQ+o8PVlp4o3CQCMInltFfuOFM
	 1uqV6TOG+kdutsc+3yy8DjKshELB1yoWDPww9y8CEPrYOvFJb3p4EW+9aaihRnugEg
	 dMWViwhJeWecg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D26BC868C9;
 Fri,  1 Sep 2023 11:50:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561822;
 bh=IpShtkwkpsImbfZmkAlVw/JzQY0xc39cpMQ6pn5NBGo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UPnuRKtr7iV2sVBplO3Vb54yN5cN5KhyfQLAGl+Rey5/4IbkVrBCRRErKholgVCyz
 xnWMrgTlRjXZLbksQCBZcLKu3hK/tNX8Hp081rywZHMSlYD8aOpm8er4HLEDs8kU+N
 6cslWqKqNml80JYb4+SMVXcreJiq0i7Q64RHbEasOxy+cqp3CI9erw1Ljoqty3A4Bj
 6I3s/LOBIp/qlLLPHC1azpnC2HvA73kzfk4RKH3rkttUvDgQkDr4nfocn2YUHTXkb3
 ui6UtYxw4UF0X6/hobPQ6c69OboXsw54wtZvy478o23Y9OVjizRihCk+6VsInvVjf+
 648XRFwREoWaA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH v2 06/17] cmd: sdp: Reorder variable declaration
Date: Fri,  1 Sep 2023 11:49:52 +0200
Message-Id: <20230901095003.352930-6-marex@denx.de>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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
V2: Add RB from Mattijs
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

