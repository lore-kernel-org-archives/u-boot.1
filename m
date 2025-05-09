Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A74CC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C4082935;
	Fri,  9 May 2025 09:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nEK8qCEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C7D8210D; Fri,  9 May 2025 09:03:27 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7444B8210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b2093aef78dso1365523a12.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746774204; x=1747379004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6WaWaGti2jOFc4xoLrVWLq95qjK+jEHVMYJ0hjSqEc=;
 b=nEK8qCEPqsTIR8udTdfGHfMsSkS4Rg1fBQLyWOCzTQ5uXqQxADyz4O+nj6oOCkD4h5
 jkd7SoXXrkt4NHWfuiXt8POeedrn8Pbfv8/2Pc+DaiY54QBgdZfxY5wqc02XQ73FiT3D
 Xv+9l8jf96E1tn9eKGl35ZRcnzsS1S3SC2BRehFagR6egdqZuKsEzwSXrn/FaCe2lveN
 NYaTiLfY3adZnhoQFmF/m4CPhF2fcaeVP8wgWM7i0kQmB2cfu1emPVY/7huUbDbQMU5e
 wHh0Sk+9jWWueO+/M6byuFHiGBzAvl5lUdhsJFPaTfJQNbsQ+GfueTdbsoOSp+NEx2yu
 XFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774204; x=1747379004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c6WaWaGti2jOFc4xoLrVWLq95qjK+jEHVMYJ0hjSqEc=;
 b=Ay6QGBitlmIhkb82+3pgv0G6049PTLd6Pe/OM3RAos9YdvLVx3bkUWNgRBXeCAHpb9
 9RCgyUzdbNkeAgcS9eNqrZWO4lo6O38ncNM01VrKtiKFjptI5YGToo2IwgQLS+xj0MNc
 9Yxo7N9+aQrnxHuTkb/qn/ihaQENwaPKoj+TwshGo3oEkjqleSNJY+WdTcGbF08epkK8
 VN4d9RJ5LzipSItuHT9vo4Wm1Gm+PAXs5ePWq0doVH4GiH0qnK8mIiZmf93wncT1ZrzH
 xM8N2yKXyhXW5f4IV4OEhWB8VCecGZPWuU04PMtEOICA8v8g/Kb241OpZdHXv5+1dx3R
 vzgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK1ngwbcVT5sT3F1uJSCt3UGuNq/kEjtz2Pdvn2k01lVr09BRf7sir+4VVZ0XnrVIb43cV548=@lists.denx.de
X-Gm-Message-State: AOJu0YzuF/10OqGocY/a9pQXbisPK29vg12H15v6Ok8+X4U+JgxYlMWy
 MJz0hV7OMNiufV7qX21ExNrzePyOLRE9tz9yz7szi6IFV2SH7vhB
X-Gm-Gg: ASbGncsj43nH4gjC5fRM5GNdeRrE+kDBy7T6WPDUqgfYqtVEi+LrSF6TXZpxQwnfcsG
 B3rIVtlHXWzUyoUzSu0kuiKwxpm9GCN7b3iFYhp8xbciIA6heUsM7/8qlNynUUpSuZhNzkicg6s
 xoW9Qfm8DRjkTDPTbY7TRUPIx2YwZrfuizFysWZGLHLtkAsmK2YReYMLlQDEQdmSNvpKfYluNhP
 /gakcbVIqx4N8a7H+kBNJ/GP97bjmWVNbsSvPWoWKUTKDe/23Rxkf0+iJrDGHd+/is7NExDKlKe
 VZAkixzyTwV7shNL+PtMe/YHXIfUDxnG+4l0SvBaFFg/hxTa9VCi
X-Google-Smtp-Source: AGHT+IE1CMIaBMP8h05icnfujyvdGIJ2JZTOieI9QsES85yA0Z56G3z01ca2/73qUlAPCDW9dV3/wg==
X-Received: by 2002:a17:90b:1b06:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-30c3b918c9fmr4939686a91.0.1746774202524; 
 Fri, 09 May 2025 00:03:22 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.38])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dc8aeasm1173932a91.2.2025.05.09.00.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 00:03:21 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.denx.de (open list), u-boot-amlogic@groups.io (open list:P200)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Wayne Schroeder <raz@chewies.net>
Subject: [RFC v1 1/7] usb: onboard-hub: Add support for Genesys GL852G hub
Date: Fri,  9 May 2025 12:32:06 +0530
Message-ID: <20250509070258.5077-2-linux.amoon@gmail.com>
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

Add support for the Genesys GL852G USB2.0 Hub on Odroid C1+
and Odroid C2. The GL852G driver trigger hub reset signal
which toggles the gpio.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Still some issue with USB hub on Odroid C2
=> dm tree

 vidconsole    0  [ + ]   vidconsole0           |   |   `-- vpu@d0100000.vidconsole0
 display       0  [   ]   meson_dw_hdmi         |   |-- hdmi-tx@c883a000
 phy           0  [ + ]   meson_gxbb_usb2_phy   |   |-- phy@c0000020
 usb           0  [ + ]   dwc2_usb              |   `-- usb@c9100000
 usb_hub       0  [ + ]   usb_hub               |       `-- usb_hub
 usb_hub       1  [ + ]   usb_hub               |           `-- usb_hub
 regulator     0  [ + ]   regulator_fixed       |-- regulator-usb-pwrs
---
 common/usb_onboard_hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 7fe62b043e6..39bbc1aefa2 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -227,6 +227,10 @@ static const struct onboard_hub_data usb5744_data = {
 	.reset_us = 5,
 };
 
+static const struct onboard_hub_data genesys_gl852g_data = {
+	.reset_us = 50,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
@@ -237,6 +241,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
 		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb5e3,610",     /* GL852G USB 2.0 */
+		.data = (ulong)&genesys_gl852g_data,
 	}
 };
 
-- 
2.49.0

