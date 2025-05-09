Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D264C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3AC82999;
	Fri,  9 May 2025 09:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SsbFGkSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E411682977; Fri,  9 May 2025 09:03:43 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5609828BC
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so1913310a91.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774220; x=1747379020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xcvuA7gy3MBpfwHOmy/JJn+/ftmt+pamZfSXgCJk5M=;
 b=SsbFGkSJAF3nZQsA0+JKpRzinIgSHbqq/Of1j4PExUyoZr9tTGA7h+oLmZ9IaOnX6B
 Fn8fkN9Is59gf7bRGECJTt/LaH0qs9B9vtsfrHSc4dyL3V4jpE/6e9PoVuEUi5Igt2fY
 cAM0pyV9xhSzh+mHCOX3l2vPVqBHddE0sVCAnO9jc2Z/nyp0QSeuA/kITUDGyF3b1IV8
 caURZiMc1VvnvUZuJIZkfWQNVAaor54THjRVnNCHM68Ff/KPjykmdx1+xAlyoKB03vtG
 fVGIQ+IrP1O0d85BFKgSWasRYC91QdkOtJm0VqjzhTz12xz0ZjtOkJ7Hxhg14+7uOCX5
 uUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774220; x=1747379020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xcvuA7gy3MBpfwHOmy/JJn+/ftmt+pamZfSXgCJk5M=;
 b=VjcGergoUmV3Pp/qKbXFo9iETem2kfM7xpoC3eLxjItxGkviCt4ne2l3ia/cPRLCag
 dWGQ6XEVKHdmm2GfKxC6a9PGL16Xda0lOW8WS3cEqxJz4MSxaqIIQrypIxljKGPAVvms
 zFTyTy+kiCHpk11SVfyw4r4aoXlQEcT4dDh7G1wPxHi9Fe89pELcygVjJyYSGOetCnK7
 AFffp+5y/nn9hhBb6OR3u9Zw58FbSA/k/Hta3vi/C8ei78nUy6GUWiGizYt3z+PbylMB
 87QpshJ5Iv42WG+Bz2LhKHzl5o316YSeaN3irPKeA7ugUVc01dvns68AwJccqrjHhuJ0
 Z5iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWCbn5hND4Vms/MZ2kVJChNg55y2FwrNcl1GIi7XC924MTwmy4ozJI2B6JrmEyUrviwpLDzIo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywxr2YBYvXV2lQj8neI8+1aKWnxGc6UFyhZE8tFaWndsmNDGYaB
 c+I+a0fM6OdTtzZK0O50tCmFZdSNuSWYP0GuhEg9QKtaF6MG6DMV
X-Gm-Gg: ASbGnctmQazqruBge4UCv5D/7GUL79gjC4X3G9zk2lHnUNUbdFEVqWILcJwTnZlKATs
 EXddyzEPIHl6VLYwhvTLHLmRwuiAKNk+I3a41WxDgCiF2TGn8dQ7pE7I6zA/cKRq3AZK3SC+Hfs
 zqHS920kOqjSgOad2ZrHWY599Hkr1OIX94zWWBQi2LVOfAdRbEDrti7pb2jfE2hGqItBD6bL+gh
 zX7/EuAKXdBxfUe720qmeZGcU2KoxAm+WT08Yxwu613UvvdIYZy2LcpLLizVFomlnEg9TF8OdAo
 zsOv2gFVSfLRM0RGDN5R0bwcE31gS0GWa5qLOaJkLKN/wQd/QZ7K
X-Google-Smtp-Source: AGHT+IHE7PN4f/X10crVsA/8xZG43L0XBejwETPHL7ljm1iyZmzwQ9aaPvNaWHAzXe+bLq8kvW20ug==
X-Received: by 2002:a17:90b:1344:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-30c3d62e499mr3784106a91.27.1746774220178; 
 Fri, 09 May 2025 00:03:40 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 00:03:39 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.denx.de (open list), u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 3/7] usb: onboard-hub: Add support for Genesys GL853G
Date: Fri,  9 May 2025 12:32:08 +0530
Message-ID: <20250509070258.5077-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509070258.5077-1-linux.amoon@gmail.com>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
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

Enable support for the Genesys GL853G USB2.0 and USB3.1 Hub on
the Odroid N2 and N2-plus. The GL853G driver activates the hub
reset signal, which toggles the GPIO.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
=> dm tree

 simple_bus   11  [ + ]   dwc3-meson-g12a       |   `-- usb@ffe09000
 usb_gadget    0  [   ]   dwc2-udc-otg          |       |-- usb@ff400000
 usb           0  [ + ]   xhci-dwc3             |       `-- usb@ff500000
 usb_hub       0  [ + ]   usb_hub               |           `-- usb_hub
 usb_hub       1  [ + ]   usb_hub               |               |-- usb_hub
 usb_mass_s    0  [ + ]   usb_mass_storage      |               |   `-- usb_mass_storage
 blk           2  [ + ]   usb_storage_blk       |               |       |-- usb_mass_storage.lun0
 partition     0  [ + ]   blk_partition         |               |       |   `-- usb_mass_storage.lun0:1
 bootdev       3  [   ]   usb_bootdev           |               |       `-- usb_mass_storage.lun0.bootdev
 usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
 clk           2  [ + ]   fixed_clock           |-- xtal-clk
---
 common/usb_onboard_hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 39bbc1aefa2..3914e2f773d 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -231,6 +231,10 @@ static const struct onboard_hub_data genesys_gl852g_data = {
 	.reset_us = 50,
 };
 
+static const struct onboard_hub_data genesys_gl853g_data = {
+	.reset_us = 50,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -244,6 +248,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb5e3,610",     /* GL852G USB 2.0 */
 		.data = (ulong)&genesys_gl852g_data,
+	}, {
+		.compatible = "usb5e3,620",     /* GL852G USB 3.1 */
+		.data = (ulong)&genesys_gl853g_data,
 	}
 };
 
-- 
2.49.0

