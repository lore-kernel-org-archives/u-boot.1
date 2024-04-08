Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706E0C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 08:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C123587FA3;
	Mon,  8 Apr 2024 10:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l7GcF+A1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F7A8800C; Mon,  8 Apr 2024 10:50:35 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8957687947
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 10:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so2355527b3a.1
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712566232; x=1713171032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2WiVyr3KhEMRv+2m6ButUw/PNeVo6sjHFNftN/JTiGQ=;
 b=l7GcF+A1Y+ldnzytlO28pV4bPgaizkkv4HhfmhdAgcO86+oZkbNH/6h01crSqvJAk5
 M0hScnGXaMwVRZ7GAqwIRo0vUOdJVY93qPrVdMrP0sc6YeHCQOG242jllzsSKyEdzj1v
 JxrBDWp5/QEh2+FFsKB0V6JHESfEnC7uPfGP7rti/xvmlVrRQs4vOsovfxh44wI+Tmb1
 /1dJC2/sUVsO77xpke/44x4zvHywMx2fvMSJMD/+cxf4t1hfxw24zttJVz+2ox28lIOt
 kkXG7YVP+iIpqp3hvaqfJnN16cDUTRg5LrzZ6FSaMMZd4vFUdjbFosLE7PB/cODdloU7
 LwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712566232; x=1713171032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2WiVyr3KhEMRv+2m6ButUw/PNeVo6sjHFNftN/JTiGQ=;
 b=m6Oy4ecCVsbq40k9Ky0RZPrMqxGIxGIfGYvABb63w1TvsB30wzcFuSF/AhyiXD7A3k
 Jh5jDwyh2La7jvXhw5VHzqWfGDCu0tjGb+Vy/KMSj4NYUSzn+SNNVwHd4z8WlGBv9PeE
 h0B0OMnc0AYiBaY/iYcmugIicg7ABnaL1uomVaAirEl0TrP8A+yDHXLT54DZxZ0peOY6
 OKEV785NxVgkMVscTLUPNVlI81ktfZCACdPanLNOOz9BLpwbu+zq9Yjdqdxc45w+IWlZ
 IGaeaEEttfwhST/c/z9ABU6nRmKu7M2IjAiJSWj9AsHM8vPpBLX/m1Xhi1Pexm4QF8An
 fDBg==
X-Gm-Message-State: AOJu0Yw28HQwXR36FUd2w6FXcq/MJyNxRCzaqRujPF5ZB+L7ALo4SDgn
 eIk5OFJ9OkT7kfiUyMesxwDui63MX3jee4XB6jZRo+63TUzpr4JA
X-Google-Smtp-Source: AGHT+IGlwGoKJatk/2H9Pntq+VgsKSn3wFxaUYf/tT0JSSIrGtGXcZdztEQ7BKKiJw/+Qc/P43vUWg==
X-Received: by 2002:aa7:8884:0:b0:6ed:41f4:1886 with SMTP id
 z4-20020aa78884000000b006ed41f41886mr1757493pfe.8.1712566231996; 
 Mon, 08 Apr 2024 01:50:31 -0700 (PDT)
Received: from localhost.localdomain ([116.89.141.171])
 by smtp.gmail.com with ESMTPSA id
 z18-20020aa79912000000b006eaa21301a7sm5973228pff.162.2024.04.08.01.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 01:50:31 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Parvathi Bhogaraju <pbhogaraju@microsoft.com>
Subject: [PATCH v1] net: designware: Pass all multicast frames in designware
 driver
Date: Mon,  8 Apr 2024 16:50:17 +0800
Message-Id: <20240408085017.2849211-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Allowing multicast packets is required for IPv6 neighbor discovery
protocol.

Signed-off-by: Parvathi Bhogaraju <pbhogaraju@microsoft.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/net/designware.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 03b531c667..4c1642b29a 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -352,6 +352,11 @@ static int dw_adjust_link(struct dw_eth_dev *priv, struct eth_mac_regs *mac_p,
 	       (phydev->duplex) ? "full" : "half",
 	       (phydev->port == PORT_FIBRE) ? ", fiber mode" : "");
 
+#ifdef CONFIG_ARCH_NPCM8XX
+	/* Pass all Multicast Frames */
+	setbits_le32(&mac_p->framefilt, BIT(4));
+
+#endif
 	return 0;
 }
 
-- 
2.25.1

