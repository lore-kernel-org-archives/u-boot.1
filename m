Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CECFC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3C6829CD;
	Fri,  9 May 2025 09:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N4N5YEzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736CA829CD; Fri,  9 May 2025 09:04:01 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44DC982935
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30c47918d84so384781a91.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774238; x=1747379038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyHznH1A+DORyNVPvNXo5ityR0UWlQJHROY2XWQgK+g=;
 b=N4N5YEzl4Bt+mVZpYNEpYHvlisXdh7vQDKen2/qWiTVIbdOYw01YZEDEv0JWER+/w1
 /tcLkcDdtxXOp+mN64qm8PrK+GU5RWzCpWPMsEoz0Em0JYQ5zARwXYtThbXhy56mY0ZP
 x6nEFwUlSIta3vCNKCWgYJZPfuPMdi3qectGjW+quVe9Zj2I3kJm+Ht/+w4IjoIzLrA0
 W4lm0w3PC8XLyRJgZcBcvz/PgLheLSgtQ6OsHxFcvS3Ga6QqYZ95cq6extGW87xe90Uw
 smdoyai+OB32Hup8+Evv/e1+DyT2YVcfkF5qNZ9qpwuuo6bbPWZuzCJaw8jmrmQIfEnr
 TgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774238; x=1747379038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyHznH1A+DORyNVPvNXo5ityR0UWlQJHROY2XWQgK+g=;
 b=YRaZdexo+Gs/BNfQeauvCv3ppUE/gy0i+Qh1sX6RSO09ejX1XDXJkrgfMtkd6bdmul
 Y2+YmiAehlOTENT5gWKW32fdvLF/1v78VwGGdOryezzy8c9j/l/43cd99Y61W0WAe81c
 DvTtoCdkg4/ENPLgcQJn//7NNSIkIYcu3hfxNYZsnpr8PNv+feUlH9Ckz+jjoWBRbUmo
 OI66SKTM6SorkAAhvfnE139TZLhTMBzBivIA3zm2CBsMXFSqOJMwBVHh4/A3che3TuD6
 yHo5LjF6+4fSZrMmoWglMlVQ3k9prQVozk/mrhCzaFJYt3HEfhfaPhcN99sJYFk+MIXY
 Vq0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/vndSp0Ec7bhhF3312tqssOogXLaHO7WBT0MLFqOwBJmdhYxp0buvbNkk8cWs3rj0tgXIaXE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywhk0t5lFHNRwfCtO8DY57hduEwIytvGzqltbIixy1ga0JG34RH
 ms/ZMpksoGXNxs/jIdwQ6mW0/QiDfJThfk9nKNNKqT0oVmzJD5nS
X-Gm-Gg: ASbGncuk74GNznGcJtV8E/BUX0BLp3jQ4j5DMGA+pq+0HPN80UTlQj4qFox6ROQ67Ge
 7D0kzq6r7jXtaohi1GwxTJFfbQxK0xt0V61UFjoDQpmcuCayKTh1wuGYncY8mvqmk+17F0uyFBG
 Llqjl7MYZ92CyBtnPx5B89KEQQbPDtosh785yQO18ygz7JkTBylWEkLTpFnuLb+v/lxhslF1G2y
 bod+lyg+KlIFaJfLT7eAjvWTTS0HT6AgR4mg9H0kuJ1HinM6qBitVnhxwW8E4HzsPCuqZFKFhGP
 FuVfAbM9GJ3CST6Qsn8f5ALZ/WkndCKYfybtmLNDeufUB5UXElhO
X-Google-Smtp-Source: AGHT+IFXuLGS7f5abZ5FN2zh5pnIBkj7DhZipu7roc0bMfqsjt12sa2AEPAOF3N2sGmXV7Khy17xmg==
X-Received: by 2002:a17:90a:c108:b0:30c:5256:3 with SMTP id
 98e67ed59e1d1-30c52560188mr297615a91.5.1746774237733; 
 Fri, 09 May 2025 00:03:57 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 00:03:57 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.denx.de (open list), u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 5/7] usb: onboard-hub: Add support for VL817 USB hub
Date: Fri,  9 May 2025 12:32:10 +0530
Message-ID: <20250509070258.5077-6-linux.amoon@gmail.com>
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

Enable support for the Via labs VL817 USB2.0 and USB3.1 Hub
on the Odroid C4. The Via labs VL817 USB driver activates the
hub reset signal, which toggles the GPIO.

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
 partition     0  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:1
 partition     1  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:2
 partition     2  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:3
 partition     3  [ + ]   blk_partition         |               |       |   `-- usb_mass_storage.lun0:4
 bootdev       3  [   ]   usb_bootdev           |               |       `-- usb_mass_storage.lun0.bootdev
 usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
---
 common/usb_onboard_hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 3914e2f773d..1242513c631 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -235,6 +235,10 @@ static const struct onboard_hub_data genesys_gl853g_data = {
 	.reset_us = 50,
 };
 
+static const struct onboard_hub_data vialab_vl817_data = {
+	.reset_us = 10,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -251,6 +255,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb5e3,620",     /* GL852G USB 3.1 */
 		.data = (ulong)&genesys_gl853g_data,
+	}, {
+		.compatible = "usb2109,817",	/* Via labs VL817 2.0 */
+		.data = (ulong)&vialab_vl817_data,
+	}, {
+		.compatible = "usb2109,2817",	/* Via labs VL817 3.1 */
+		.data = (ulong)&vialab_vl817_data,
 	}
 };
 
-- 
2.49.0

