Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB10C54E58
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 02:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A4787F69;
	Tue, 26 Mar 2024 03:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="SJqRGfNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906DB87E91; Tue, 26 Mar 2024 03:34:07 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8FB87F69
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 03:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dcbf82cdf05so4549364276.2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 19:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1711420444; x=1712025244;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kj4jOzV8QSsZD806ujSuF9sk2exUd6wdHZs7lFppY4g=;
 b=SJqRGfNL3Pf0ck8qfEEyR83WAexuIgJhxeL+2iMLdrcaoa2qZyImNDl/RWDz+yW1Om
 M4l8Kn9f4zFCBrbuIAGo4j6zRFIM73IU8Ea4ZQP69BC93O5JhQrQtUJUo07VEvbSS98Y
 f00MHShg9A4KQSPDRX1IF7ma4TmC0fpljVcEb1i/QsxGC2NB36D18hVgt1veiBvQadnC
 mYx9jrnk1QKR0zESaeaTDhC3pxQohfeoK+vFQTtHWvDDQL3dPr9vbzJSglYoUm18xxFT
 qfNlGELl+Tmu58BeBizG/a1DHkwhYVRZ4zezg0ygCqi6bCDwsqcXgvybOd7ssJyf7JEG
 8djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711420444; x=1712025244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kj4jOzV8QSsZD806ujSuF9sk2exUd6wdHZs7lFppY4g=;
 b=C55eUWULV+2YtRCVXBr4xQUpI+nn2znx9awBHE3ERX14vM/1sCYChW12ppDeDNMN1M
 4ofh3Fw7HG3hakDpO3aLIrjxRG1D7p3e7qzSb1yLfOR+esm9Y8HOPw3OdD8tOjiO/F7X
 +2EVGu57GqtJBNRNr3s7/Z66/vD7KfAgG/E+LTKYo9QpLhRfHbI6CdQnUq2iY5flc4PO
 3CYa+5Wr3dlZE2UV/Z/rKNA0WodW7bM0NMpnqezyoY7wKuakHxT6LkshjlZTrpaqTgWV
 W4psSTzTmPcznorJS3dXKMNIrURIofPw/8SsQ1m69UxbL/GIa26saAsHgprPxACFV61l
 lnRQ==
X-Gm-Message-State: AOJu0Ywfx39/d3o7kdagvm4IssWu1oUogNvxGuHBCnFJN/H2j3/5+SB/
 ZTJOcMf7065cLAchNT6nAqK5/bSKsQPf8MrRa1W1YcMw9b3OtdMcddfiQTKbqcxcLOwOh7/u8LG
 dDg==
X-Google-Smtp-Source: AGHT+IEheKTlJjlVi3Wg7c1VlFHWbmX2TDZWTrfE24/YMfQ8iqscjPED2gD27rDG0YnlMIplvU8jFQ==
X-Received: by 2002:a25:744c:0:b0:dc6:6307:d188 with SMTP id
 p73-20020a25744c000000b00dc66307d188mr6021091ybc.25.1711420444299; 
 Mon, 25 Mar 2024 19:34:04 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 v75-20020a25abd1000000b00dc9c5991ecdsm1266233ybi.50.2024.03.25.19.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 19:34:04 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: dwc2: Add in version 4xx compatibility
Date: Mon, 25 Mar 2024 22:32:02 -0400
Message-ID: <20240326023208.3525-1-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

This adds the Synopsys device id for version 4xx of the designware
IP block and extends the version check to include it to permit
new hardware to run. It does not add any 4xx-specific features.

Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

---


---
 drivers/usb/host/dwc2.c | 3 ++-
 drivers/usb/host/dwc2.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 637eb2dd06..6fdde6a9a7 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -1180,7 +1180,8 @@ static int dwc2_init_common(struct udevice *dev, struct dwc2_priv *priv)
 		 snpsid >> 12 & 0xf, snpsid & 0xfff);
 
 	if ((snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_2xx &&
-	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx) {
+	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_3xx &&
+	    (snpsid & DWC2_SNPSID_DEVID_MASK) != DWC2_SNPSID_DEVID_VER_4xx) {
 		dev_info(dev, "SNPSID invalid (not DWC2 OTG device): %08x\n",
 			 snpsid);
 		return -ENODEV;
diff --git a/drivers/usb/host/dwc2.h b/drivers/usb/host/dwc2.h
index 6f022e33a1..f202d55eb2 100644
--- a/drivers/usb/host/dwc2.h
+++ b/drivers/usb/host/dwc2.h
@@ -739,6 +739,7 @@ struct dwc2_core_regs {
 #define DWC2_PCGCCTL_DEEP_SLEEP_OFFSET			7
 #define DWC2_SNPSID_DEVID_VER_2xx			(0x4f542 << 12)
 #define DWC2_SNPSID_DEVID_VER_3xx			(0x4f543 << 12)
+#define DWC2_SNPSID_DEVID_VER_4xx			(0x4f544 << 12)
 #define DWC2_SNPSID_DEVID_MASK				(0xfffff << 12)
 #define DWC2_SNPSID_DEVID_OFFSET			12
 
-- 
2.43.2

