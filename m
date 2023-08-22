Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3472BEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9402F864C0;
	Tue, 22 Aug 2023 14:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IQ4cdnfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6317864E3; Tue, 22 Aug 2023 14:10:48 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5354D864C0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-307d20548adso3768730f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692706246; x=1693311046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyn3pRQj3b20QrU+yP9Pgl3F4OJdXxpyYRvoLWL+0xM=;
 b=IQ4cdnfgnVDFlnsy4XfQuX80ObjT/EDM9dHkAc5ZLtJVPNAc2z8FBOs9uNWlfPRXYj
 bCYS8sSHz2bbeXiGOidD1b4qDGeZvCwU9t/2Fx0gA0Nl+9eYxKeLZzJZ9I7uXwumkdxd
 48l5fUcqEQY8RlRXvvhMHSZWWbH1aYJgDjKfx/nJ+pz4ycyxOiyqjcNLZxgjAhDZUinM
 WfSI47DaEatebhXCGlpt7cTwIJqtOImMnVYOq14VPMPAXOoTLmg4dCvhUdO7laKVgRKy
 UpqQH8SUbUPNDCIPdndaBuKekjOxDmKLxXhN92rRszpIp15Ji/1liJ8YcTCevUeNnxK4
 1rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692706246; x=1693311046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyn3pRQj3b20QrU+yP9Pgl3F4OJdXxpyYRvoLWL+0xM=;
 b=VIVATdNhxGpHJCwde6I4RoHLDp7BWdDK4ykeUWDGb85EdnOESuLTO1On1FiF7eg2Vt
 my0CgEa74kPp0rql6grEammVAZGz8PPLYjYXW0mTUOIQVMNtKMdz5MsLSkwJ1rR/yDPZ
 SSUvKaQA4uh63A3kHJOh8mZqKHbeD1qAbcTKyjeomTruX6PomqP6w3skVCa0ggwpxhzQ
 WL0aY97S+/0pOCh5dMTbWRQkTDjHQG1R///2uxfs/tmT8IDpYEVxmi1dgTQjGurlgd2H
 itHqPSWgaXlmZdAAlR7mvMROOrkrlBedl9iQ8y8Qu/8wGKu3tZfXAnWWsYntSwlufpHz
 7Dtg==
X-Gm-Message-State: AOJu0Yx8tnlGWdF1cuFUyV+QePIdk0LQF66CGkkAFpdout3alKbP4JNU
 X4Pky6SgnQWa5nBUUb9i2oCiAKG4JyM=
X-Google-Smtp-Source: AGHT+IER0zMvv5p2SPSSaACTEYmPmuLE+9hTIEmGsunQgxi8oapU8ncS7mpZ1DpXSw1/AITy6wjEMw==
X-Received: by 2002:a5d:49c2:0:b0:317:f702:70d8 with SMTP id
 t2-20020a5d49c2000000b00317f70270d8mr6392760wrs.67.1692706245604; 
 Tue, 22 Aug 2023 05:10:45 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffac2000000b0031753073abcsm15704611wrs.36.2023.08.22.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 05:10:45 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 3/7] qfw: Spawn ramfb device if its file is present
Date: Tue, 22 Aug 2023 15:10:21 +0300
Message-Id: <20230822121026.1007105-4-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
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

From: Alexander Graf <agraf@csgraf.de>

Now that we have a ramfb device driver, let's add the necessary glueing
magic to also spawn it when we find its qfw file node.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
[Alper: Use if IS_ENABLED() instead of #ifdef]
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v2:
- Use if (IS_ENABLED(CONFIG_VIDEO_RAMFB)) instead of #ifdef

 drivers/misc/qfw.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
index 7c01bf23d53b..4e4260982cce 100644
--- a/drivers/misc/qfw.c
+++ b/drivers/misc/qfw.c
@@ -16,6 +16,7 @@
 #include <malloc.h>
 #include <qfw.h>
 #include <dm.h>
+#include <dm/lists.h>
 #include <misc.h>
 #include <tables_csum.h>
 #include <asm/acpi_table.h>
@@ -307,6 +308,27 @@ void qfw_read_entry(struct udevice *dev, u16 entry, u32 size, void *address)
 		qfw_read_entry_io(qdev, entry, size, address);
 }
 
+static void qfw_bind_ramfb(struct udevice *dev)
+{
+	struct fw_file *file;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_VIDEO_RAMFB))
+		return;
+
+	ret = qfw_read_firmware_list(dev);
+	if (ret)
+		return;
+
+	file = qfw_find_file(dev, "etc/ramfb");
+	if (!file) {
+		/* No ramfb available. */
+		return;
+	}
+
+	device_bind_driver(dev, "ramfb", "qfw-ramfb", NULL);
+}
+
 int qfw_register(struct udevice *dev)
 {
 	struct qfw_dev *qdev = dev_get_uclass_priv(dev);
@@ -323,6 +345,8 @@ int qfw_register(struct udevice *dev)
 	if (dma_enabled & FW_CFG_DMA_ENABLED)
 		qdev->dma_present = true;
 
+	qfw_bind_ramfb(dev);
+
 	return 0;
 }
 
-- 
2.40.1

