Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB083EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516F387015;
	Sat, 19 Aug 2023 16:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455079;
	bh=WjPmyfX4URKekUdiboAzH2mcTfDPUlO1Iha+HPCx83Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ohk1yUZSDTNd1ukNJ9PKsCghPmXjgIBKk3qcFoFhCNtPxHuBDTdIEs0M3BU9eH7z2
	 ERDpjjE+fqafCi9DDrkjS12NGQiKJTLciGscYaSpBD3L2liJ+RJzdNE/u7YwzIPjw8
	 bkbBRHgLn7RMFEKUvCekK2M53dvisW/iwXaU8HUCrnIxWzAl2mbeh7eM9ZnDldbCQZ
	 /c+iUqfpa7u3MBuXhpChjkUo+GPhMlzKia278n3hIq22n8z7YkviZU/LTJYoVxOc/o
	 lGPlUPU8OvnlRDJIDmXoR+0gWg5wb1XdIHxMXgLhW1z8na3ycT1EuLMMHIJJAcazQz
	 zEy3bmu5UCALA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5A8F586F9B;
 Sat, 19 Aug 2023 16:24:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455077;
 bh=WjPmyfX4URKekUdiboAzH2mcTfDPUlO1Iha+HPCx83Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qM21Wg1pM33e4vaYjBdaaJvq9qfrdAjBdjk/xqXTj6bv5bkzZjwHaNafF1dmuU83G
 Zt2VFdN+b54IJpdl5gHnifM2lQYMhiJXu6XvJAnERlafgSAlITihnQZolhNVfY1Byl
 xHyCAwr7TnP31SPNxK5T0Y58nolC9eO1P9FM7/Vu5OEBy5CuqfI2l+V8KSJ3TnQmhT
 Y1p+EvS/E/mcSwNtmbLJd9XtQu1bz9uWWmOPPr9MXR/V0CWz/5oFZeVXF7Lx0cHSAI
 lyu1JpI6vNlsswPcftvMieaJbIouJ/uqs4T7HBqDs3RPrcMzARcAs4aBcdfq6LxLPN
 BxeoTYlZY4WvA==
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
Subject: [PATCH 02/17] usb: sandbox: Add DM_USB_GADGET support
Date: Sat, 19 Aug 2023 16:23:52 +0200
Message-Id: <20230819142407.49632-2-marex@denx.de>
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

Remove local usb_gadget_register_driver()/usb_gadget_unregister_driver()
implementation which is implemented in udc-core.c instead if DM_USB_GADGET
is enabled. Add no-op dm_usb_gadget_handle_interrupts() implementation.

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
 drivers/usb/host/usb-sandbox.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbox.c
index d1103dcb2e9..582f72d00c1 100644
--- a/drivers/usb/host/usb-sandbox.c
+++ b/drivers/usb/host/usb-sandbox.c
@@ -124,6 +124,12 @@ static int sandbox_submit_int(struct udevice *bus, struct usb_device *udev,
 	return ret;
 }
 
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	return 0;
+}
+#else
 int usb_gadget_handle_interrupts(int index)
 {
 	return 0;
@@ -144,6 +150,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 
 	return 0;
 }
+#endif
 
 static int sandbox_alloc_device(struct udevice *dev, struct usb_device *udev)
 {
-- 
2.40.1

