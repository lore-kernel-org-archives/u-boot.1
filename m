Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B4EC48295
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 23:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D7687EAC;
	Sat,  3 Feb 2024 00:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lGHNw2Ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F3E87E91; Sat,  3 Feb 2024 00:02:00 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A422387EA1
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 00:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9435ACE2E9F;
 Fri,  2 Feb 2024 23:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDF83C433C7;
 Fri,  2 Feb 2024 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706914913;
 bh=Gix55upFRpTbj0sEOU5okjE0nTUWV9r1SFeRhjZR+ao=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=lGHNw2Ir2O2hyySN8NiBEQpZQQasOZR8ieYTjxEUFKsqelmOh0eokaXEVaanvvSk2
 ec9ZwZIEvzFyM3T+k/a7fZhzbokpC0BhK17NCArIEvEIwVwoJKbXu6VSJhd1BJxtMu
 JEM2lZ3xMW5BUYMBg/LRAoAEn6oS08AgASaGdzm2Z2o92Ee4Bt+6RTRdJZBXhKAIo4
 qjQavO4waNbugv4kKcrhK7MId+O62bpIEQRcio3aIXjywbkGXR6WmlR0P90BdW+85G
 eVngwupDvnc1OI9NERRBzV9WZ6ETj1roDHDuQzX7xYHy9yNWnvnnAG1ppWBHAAsCzx
 c5tOl1e0S+SFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B6193C48298;
 Fri,  2 Feb 2024 23:01:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 03 Feb 2024 07:01:55 +0800
Subject: [PATCH 2/3] usb: dwc3: replace argument mode with child ofnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-hisi-dwc3-v1-2-448050c7b690@outlook.com>
References: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
In-Reply-To: <20240203-hisi-dwc3-v1-0-448050c7b690@outlook.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706914914; l=2458;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=fQ5QzLzIEP736TZtMfCMIaL07xA0BFdi1MT0kuti3Io=;
 b=srurWlm0t/x9iDhboAy+9ZAk7JMDkr6dHaCL93HafrQ3rCjJzO+zoRTK9GNSa0llUqiJnDFVT
 3bFIdzp5XmNBPSQbW+o0MI6iqhhwJp4TXlw3NcbTOSHeGVvNNJ+0Cot
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

child ofnode is more useful and can be used to query a lot of other
props of child device. dr_mode can be also queried from it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 12 ++++--------
 drivers/usb/dwc3/dwc3-generic.h |  3 +--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 6fb2de8a5a..d892042b91 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -272,8 +272,7 @@ U_BOOT_DRIVER(dwc3_generic_host) = {
 };
 #endif
 
-void dwc3_imx8mp_glue_configure(struct udevice *dev, int index,
-				enum usb_dr_mode mode)
+void dwc3_imx8mp_glue_configure(struct udevice *dev, ofnode child, int index)
 {
 /* USB glue registers */
 #define USB_CTRL0		0x00
@@ -323,8 +322,7 @@ struct dwc3_glue_ops imx8mp_ops = {
 	.glue_configure = dwc3_imx8mp_glue_configure,
 };
 
-void dwc3_ti_glue_configure(struct udevice *dev, int index,
-			    enum usb_dr_mode mode)
+void dwc3_ti_glue_configure(struct udevice *dev, ofnode child, int index)
 {
 #define USBOTGSS_UTMI_OTG_STATUS		0x0084
 #define USBOTGSS_UTMI_OTG_OFFSET		0x0480
@@ -348,6 +346,7 @@ enum dwc3_omap_utmi_mode {
 	u32 reg;
 	u32 utmi_mode;
 	u32 utmi_status_offset = USBOTGSS_UTMI_OTG_STATUS;
+	enum usb_dr_mode mode = usb_get_dr_mode(child);
 
 	struct dwc3_glue_data *glue = dev_get_plat(dev);
 	void *base = map_physmem(glue->regs, 0x10000, MAP_NOCACHE);
@@ -577,12 +576,9 @@ int dwc3_glue_probe(struct udevice *dev)
 	}
 
 	while (child) {
-		enum usb_dr_mode dr_mode;
-
-		dr_mode = usb_get_dr_mode(dev_ofnode(child));
 		device_find_next_child(&child);
 		if (ops && ops->glue_configure)
-			ops->glue_configure(dev, index, dr_mode);
+			ops->glue_configure(dev, dev_ofnode(child), index);
 		index++;
 	}
 
diff --git a/drivers/usb/dwc3/dwc3-generic.h b/drivers/usb/dwc3/dwc3-generic.h
index 40902c8923..46c14a338b 100644
--- a/drivers/usb/dwc3/dwc3-generic.h
+++ b/drivers/usb/dwc3/dwc3-generic.h
@@ -22,8 +22,7 @@ struct dwc3_glue_data {
 
 struct dwc3_glue_ops {
 	int (*glue_get_ctrl_dev)(struct udevice *parent, ofnode *node);
-	void (*glue_configure)(struct udevice *dev, int index,
-			       enum usb_dr_mode mode);
+	void (*glue_configure)(struct udevice *parent, ofnode node, int index);
 };
 
 int dwc3_glue_bind(struct udevice *parent);

-- 
2.43.0

