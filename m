Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D645BEE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266F48705F;
	Sat, 19 Aug 2023 16:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455084;
	bh=qrCHkqbq3SOfbpMWbpSvto+JNg8yz6oTKPPc3BPxOX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lhEHhi6Le5Acc5ASVobGHlpyldn+DN9qzj0vnNqsvt5xA+4JkXkdl0kGmmAfzN8U8
	 6i9xmBf610XTNYFRbKrPPvOlNmGSKPb06ECh6KE2h1B38601xIj9Hp7stFXR1yWNDi
	 kf+MezCVklKTqANs53F+JSmpf/ta5D2fRZtYyZ6yHpTkzABvkrRjeR3YDtkMFQyPnZ
	 goYx0Ed+LfKt1bPnOJUGvBIP81mLvySfyMWrUIKzr1Xixsco4/ePm8uO97Aj4J8V6R
	 bQqfLBHRBJDycBdZvFABGUs0gt0x+9XzRMtr2QA4NJCroXPDNEl69y3jaZhKGzehtB
	 I2QYA33vaxnaQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 31F0C86F9B;
 Sat, 19 Aug 2023 16:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455081;
 bh=qrCHkqbq3SOfbpMWbpSvto+JNg8yz6oTKPPc3BPxOX0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n9JMEFOW2nF6paINBmaplA02CwXA2kWiZYHPRkLcbPIxLQcspDgm0PbSMoXTQgSG2
 ntaYUWiRlIysNtXDvy0x4nJF4/yiXMTAsv+rjA6OYt2d5YBh7NV6WvdO0qM2ifM0tx
 F7UZrDzboSQamucbS610Hz6gGPbjvbwMIQ8eXC3gaMmwHqO/bJHkh77Myzh61+FWud
 fM0IsB6rsg6W5C2h0rd7yvVxWCCBhxiP2oW62cZ08y+sZiU1z5kH+yAN44GgSEXqpx
 hZjNsJPi3qIvKAqEgdGFwIDqRvJKB25UNXUGe1L/kKZK/9uAtuycQz1AL+6laHlQxo
 UQfDxlv/mAR8Q==
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
Subject: [PATCH 08/17] cmd: ums: Use plain udevice for UDC controller
 interaction
Date: Sat, 19 Aug 2023 16:23:58 +0200
Message-Id: <20230819142407.49632-8-marex@denx.de>
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

Convert to plain udevice interaction with UDC controller
device, avoid the use of UDC uclass dev_array .

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
 cmd/usb_mass_storage.c              | 10 ++++++----
 drivers/usb/gadget/f_mass_storage.c |  8 ++++----
 include/usb_mass_storage.h          |  2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
index c3cc1975f9d..9c51ae0967f 100644
--- a/cmd/usb_mass_storage.c
+++ b/cmd/usb_mass_storage.c
@@ -143,6 +143,7 @@ static int do_usb_mass_storage(struct cmd_tbl *cmdtp, int flag,
 	const char *devtype;
 	const char *devnum;
 	unsigned int controller_index;
+	struct udevice *udc;
 	int rc;
 	int cable_ready_timeout __maybe_unused;
 
@@ -164,13 +165,14 @@ static int do_usb_mass_storage(struct cmd_tbl *cmdtp, int flag,
 
 	controller_index = (unsigned int)(simple_strtoul(
 				usb_controller,	NULL, 0));
-	if (usb_gadget_initialize(controller_index)) {
+	rc = udc_device_get_by_index(controller_index, &udc);
+	if (rc) {
 		pr_err("Couldn't init USB controller.\n");
 		rc = CMD_RET_FAILURE;
 		goto cleanup_ums_init;
 	}
 
-	rc = fsg_init(ums, ums_count, controller_index);
+	rc = fsg_init(ums, ums_count, udc);
 	if (rc) {
 		pr_err("fsg_init failed\n");
 		rc = CMD_RET_FAILURE;
@@ -215,7 +217,7 @@ static int do_usb_mass_storage(struct cmd_tbl *cmdtp, int flag,
 	}
 
 	while (1) {
-		usb_gadget_handle_interrupts(controller_index);
+		dm_usb_gadget_handle_interrupts(udc);
 
 		rc = fsg_main_thread(NULL);
 		if (rc) {
@@ -247,7 +249,7 @@ static int do_usb_mass_storage(struct cmd_tbl *cmdtp, int flag,
 cleanup_register:
 	g_dnl_unregister();
 cleanup_board:
-	usb_gadget_release(controller_index);
+	udc_device_put(udc);
 cleanup_ums_init:
 	ums_fini();
 
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index f46829eb7ad..1d17331cb03 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -435,7 +435,7 @@ static void set_bulk_out_req_length(struct fsg_common *common,
 static struct ums *ums;
 static int ums_count;
 static struct fsg_common *the_fsg_common;
-static unsigned int controller_index;
+static struct udevice *udcdev;
 
 static int fsg_set_halt(struct fsg_dev *fsg, struct usb_ep *ep)
 {
@@ -680,7 +680,7 @@ static int sleep_thread(struct fsg_common *common)
 			k = 0;
 		}
 
-		usb_gadget_handle_interrupts(controller_index);
+		dm_usb_gadget_handle_interrupts(udcdev);
 	}
 	common->thread_wakeup_needed = 0;
 	return rc;
@@ -2764,11 +2764,11 @@ int fsg_add(struct usb_configuration *c)
 	return fsg_bind_config(c->cdev, c, fsg_common);
 }
 
-int fsg_init(struct ums *ums_devs, int count, unsigned int controller_idx)
+int fsg_init(struct ums *ums_devs, int count, struct udevice *udc)
 {
 	ums = ums_devs;
 	ums_count = count;
-	controller_index = controller_idx;
+	udcdev = udc;
 
 	return 0;
 }
diff --git a/include/usb_mass_storage.h b/include/usb_mass_storage.h
index 08ccc97cf22..83ab93b530d 100644
--- a/include/usb_mass_storage.h
+++ b/include/usb_mass_storage.h
@@ -25,7 +25,7 @@ struct ums {
 	struct blk_desc block_dev;
 };
 
-int fsg_init(struct ums *ums_devs, int count, unsigned int controller_idx);
+int fsg_init(struct ums *ums_devs, int count, struct udevice *udc);
 void fsg_cleanup(void);
 int fsg_main_thread(void *);
 int fsg_add(struct usb_configuration *c);
-- 
2.40.1

