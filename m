Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650D1CD6E5D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 19:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C7BF84852;
	Tue,  2 Jun 2026 21:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b5xpz3hK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563AF84855; Tue,  2 Jun 2026 21:25:50 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A858005D
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 21:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e6b571750bso2322348a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780428347; x=1781033147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kyn+Zec8rKDrRZQZAtIsiL+D15DbFK01iURi9VyzD8Q=;
 b=b5xpz3hKZmlzM77gKOYSSqa8V4VpAI0ERDjFJAv6SYLoKVPHS2tRzj/5hHE1N912YK
 722pIHIl5k9arqVgyOLL+I3azIQv8ff7rUQJWvUuguCjaesGdJJneUmiixQN1fFDRiI8
 9HywrnS/gZ3wtIQpHUtzrEDjglkt7W8vjWjwIOTllNAQHuy6x0JfuwlhKAWgDyB0x4AO
 N5inz7lB0mApfx/gEHk9wt97YWH78p7S5pp2OMFomm9bHJs1/KuG9J8Zh2BXI/Qf22qZ
 QXiLle0Ydn6HwWzIud5uiIlBOJM5H3HhgBTb7gsk3vhLp4O11RgWD/JoDJG/Ta2KW4i6
 NbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780428347; x=1781033147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyn+Zec8rKDrRZQZAtIsiL+D15DbFK01iURi9VyzD8Q=;
 b=lZz8GYlBth8ssYgEnbLNbM+WVn21dGjs2Q5T5BV4z/3AQiB1BuUZ5TvOFAvYU4VTMv
 HeQhQ2Yj+fbYfLY/CkJdT8Q+cSrTUQuQ+Zxn4PYCdg+jBBDMyTQSqp1eqxcjI1m0bJ5Z
 8vXKyvmwGXCRHhpzGAdOBds29SquZepkV6cHehvK4b8otBjlRZg7mNOi1FNYQ2ig0rHs
 xRNQ5q9P8DjP0O4APIuu4+fsoq9+N4fZpX7BoJUITOqqAw2XZ0mIxtzXQePZhDKxwzTm
 SwNOcG08sQtKz6kEfMRSNRjt4fQNFI0hFRkmy4r+g+eXwmjhszySksL5SV+NoMXZ8D2i
 0eGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ93QoY/bTp5yRBURWZ3HQHHt1w62JgFlcK25yVXzTrfFmRT4fdv399YB+QS0yXxsFLqGTVfZMQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqt8GLNUj7WhryeNbCNS3ulUPHIIxolrMzj2K9f9FL0LwyDCJZ
 xOF0nwMQq68uy8gfyPeyitI8GMzLpesVlXV6U9KCcta/LtV3rnmvaAIA
X-Gm-Gg: Acq92OHyVON28FTzIIEKpI9r8Ww/pHu5oYSR5GaMk6Q7IVEEOZIPNk5ulQzXOv3Twng
 h3rgakJxdlwVVr5A3p3YDBUcguXyrOCxVTbAIxYwdcxTMu6gENZVU5MNZF//D6UcRLdDOzbrS7J
 1TZsTD82IUbi9LlnxJQLs58ErCTKVDVvL9TijvGuOaEAg5l6TxSUkIZbcySOwrPtCGpZ96SOKVS
 E6MHa+lneLe9+wDrk2xKli6jjS/iX2CN+3l09pNARN3B5pU9cHJwc1HtsQjUV1RZFCCpNmZHzi9
 NCB9lmX/jTDE3Q7KJgbMHGFBvro6BbrDuO2nzNhXXZ2RWUmAw45efr8/LwkRggfvnD1Y008gnlG
 jaSDm/gPk5yepbPq6Nk6hh1Hi2z3NP+wI+EuBGkdp3he8dfr9BfFCLEP3o9+1DhZuybGasTX/ti
 vQkRe4MapqDpmH5giDY7q4z2cwLikj3OJUYajifHsQfOwyzaYh2zXNjMcU0vwEoX4L5+F/OpBZ8
 /3olWH/NXbVsoc2Tosb97Xz
X-Received: by 2002:a05:6830:67e3:b0:7dd:9b19:a875 with SMTP id
 46e09a7af769-7e6e636eafdmr561802a34.2.1780428346753; 
 Tue, 02 Jun 2026 12:25:46 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78e7f9csm177484a34.17.2026.06.02.12.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 12:25:46 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>
Cc: Tony Dinh <mibodhi@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v3] usb: xhci-mvebu: Enable Armada 375 in XHCI driver
Date: Tue,  2 Jun 2026 12:24:42 -0700
Message-ID: <20260602192524.11108-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Add armada-375-xhci to the compatible list in XHCI MVEBU driver.
Tested with WD MyCloud Gen2 NAS.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

Changes in v3:
Correct subject prefix to "usb xhci-mvebu"

Changes in v2:
Correct the typo in string "marvell,armada-375-xhci"

 drivers/usb/host/xhci-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 12dc61aee9d..c294a56b3c9 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -82,6 +82,7 @@ static int xhci_usb_of_to_plat(struct udevice *dev)
 
 static const struct udevice_id xhci_usb_ids[] = {
 	{ .compatible = "marvell,armada3700-xhci" },
+	{ .compatible = "marvell,armada-375-xhci" },
 	{ .compatible = "marvell,armada-380-xhci" },
 	{ .compatible = "marvell,armada-8k-xhci" },
 	{ }
-- 
2.47.3

base-commit: 32f40f9c7602910466c42eb184329a54045bee6f
branch: master
