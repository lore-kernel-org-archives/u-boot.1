Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32625C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF391829A1;
	Fri,  9 May 2025 09:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ApOVJrxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E0182A4D; Fri,  9 May 2025 09:04:19 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC4FD829A1
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-309d2e8c20cso2315645a91.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774255; x=1747379055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VksTAc8MfNtj+Zo80Tsk7dVzZ22M2QTVt0cXDy/zQAg=;
 b=ApOVJrxFVtj0TJtQFXpymMD7O4Cn/Xctw4aRlH8mHg03/vlcTHgJXOlBKUiOjsysiF
 UKaGDdSLH+qbtsyO3/HFADF9BTPKM1Kgkae6bJ97BPE2Qjo04ZXQx41MCKrvLoKUXONt
 Rs6K5Lx8pRU2qjkZzT0OZGRJpJpnZqKuOoTvyO4AWGDISezEJiMLg8SFvbhsBp5X4HpI
 Pe8+ZFDqrgwVEsrS1T1Smq55f/+ayydcg0IW+U5TfXMhx6VUL30KKDs2AcyTCOjaQplr
 jRN3/vdA7C2XrYixY7qz5mJ0DKL5upDez2H9VdNgAk95jh4wcDHyBT9gy67gxdbSczut
 NyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774255; x=1747379055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VksTAc8MfNtj+Zo80Tsk7dVzZ22M2QTVt0cXDy/zQAg=;
 b=Px6Kik28fjjSNGL/sngBLApr1NXPtxYA5omtO91hOmwIGrxaJzRuoYfmA0mPXSEZ9+
 dN118j583GuDkbQN/x6kwfd7Yn1C/RvHz1zRM+07g1JGC7w7xPcxnJMT9xGvxF7JtW/p
 XUHcCS5AbhN01MEEWBWtGffsEctRCrtXsvLBZqGZ0rcY33uHyQHQBoiPABiQIxd2EPSH
 8Ow/JrVXaFtQ7YCgyrUd/vmKIMKnqqp2aGDfH3UHzvAgen00jNOa7+k7s9tz6OjZ/p/o
 QgPVZt9Q8d7mX/mxF5bOB3DZIDfTa72P+drK5oIOy5S5TFqmf2uhOYrlZPO8MRA+YKE2
 dGnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU42ieW4u033/3T5YUEi6fmMbdW9kbaF4LZLG2Y208WgdI5WL5K/OwMEtIonEqjlpLYQbEVTA4=@lists.denx.de
X-Gm-Message-State: AOJu0YwW6qhVoVJ5cVgB2mI80Myb1m/1fUduMJiZ2/dpoXJB/Wa8jiTQ
 xF1rc8DbhZgYq72LwNYoW28/8VS5IT9jojbUbSkB3WhRhk14Fj4c
X-Gm-Gg: ASbGncvxg5CCoYVtOcphtXvUuoz8EgxeDGV+M6f7JHDk9BcgTLolFFL50usTxhlATBH
 Hr2Ad336Fi/a6K+xb0FBANq7ZpMgt77TTy6Deu4e/bVi4c7cEdT4MvCZl9wKQYIk6u8HFMFsSWC
 m2N7PUSqj3nmGDQDm0ceRN7g5wFgF78x5zAC/ks/qmDtvqVzRfCc/9cKbsIpxKSZZqv3DHd0HpZ
 zba0WROtx8ms9M8vVoBmxbIZnlhLwENnHIQzeijO47EaYanZoBiDPuhSjfsakeUEMrfKDJIrUmD
 6jed6AuBa8S8shUZz77h4s4cvURH0KUgTKiWszuvmi/CNa3vjY6MV6O4c8doFh4=
X-Google-Smtp-Source: AGHT+IGYOoQXT9TsOq5YEK1vhXpUdE1ezLVSnzq5QPWWManGeJD5veYDMeg1Sgf8GpZHVc8FJmr5rg==
X-Received: by 2002:a17:90b:2701:b0:2ff:6f8a:3a13 with SMTP id
 98e67ed59e1d1-30c3d6290d6mr3853219a91.25.1746774255375; 
 Fri, 09 May 2025 00:04:15 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 00:04:14 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de (open list),
 u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for I2C
 initialization
Date: Fri,  9 May 2025 12:32:12 +0530
Message-ID: <20250509070258.5077-8-linux.amoon@gmail.com>
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

Add conditional compilation for the usb5744_i2c_init() function based
on the CONFIG_DM_I2C configuration, to avoid compilation failure.

  CC      net/net-common.o
  AR      net/built-in.o
  LDS     u-boot.lds
  LD      u-boot
aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function `usb5744_i2c_init':
/home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined reference to `i2c_get_chip'
aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0): undefined reference to `dm_i2c_write'
aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8): undefined reference to `dm_i2c_write'
aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0): undefined reference to `dm_i2c_write'
Segmentation fault (core dumped)
make: *** [Makefile:1824: u-boot] Error 139
make: *** Deleting file 'u-boot'

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 common/usb_onboard_hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 1242513c631..92e3f3a92c9 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -30,6 +30,7 @@ struct onboard_hub_data {
 	int (*init)(struct udevice *dev);
 };
 
+#if CONFIG_IS_ENABLED(DM_I2C)
 static int usb5744_i2c_init(struct udevice *dev)
 {
 	/*
@@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 int usb_onboard_hub_reset(struct udevice *dev)
 {
@@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
 };
 
 static const struct onboard_hub_data usb5744_data = {
+#if CONFIG_IS_ENABLED(DM_I2C)
 	.init = usb5744_i2c_init,
+#endif
 	.power_on_delay_us = 1000,
 	.reset_us = 5,
 };
-- 
2.49.0

