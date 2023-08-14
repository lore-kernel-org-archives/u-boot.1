Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4DBC04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521EF86978;
	Tue, 15 Aug 2023 00:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kp70oiAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80CB986996; Tue, 15 Aug 2023 00:34:23 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C99855CE
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bc83a96067so29821805ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692052459; x=1692657259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+THrukBplMqQBpH8UgKnlz7NqftWxNpIb6REibEWvGQ=;
 b=Kp70oiApJ8+NcmUWMibilWu2exnT0GZytucpRBBC6oSY9YcCzR8PKHYA8W2oLjIDa3
 x13UTRug8/OcLwK37NtPgMct1Z0hNNLNJlfehEy1+vmuF7PdPyWWws9Wn3XnF588Sd4n
 wEgrK7N3HBC9i37d/uyBG+BtGA8Ny5UUEarSoW8cj4/Kd+XbJYi6/P53W2W3ykbgv1mr
 u8yjfQgeUXHqv46/NBti/6VMsvg/HlSEnQhdppnNmn13eOVDOgDnjHcLTxPb0JGF82qh
 89mc9eVNNseMCuC7IdZ7EUmFVBYu+ZLOBivTSofYuja+DmH9JsnkAg8RPc8T/0R5tnaH
 ifpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052459; x=1692657259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+THrukBplMqQBpH8UgKnlz7NqftWxNpIb6REibEWvGQ=;
 b=OHlpDrb/f3oIaGd11LwFxOVzGTcSsWopYQmWAhwG/3aVhzs8Vu6was+/jno6X7qD8h
 6DrFJEQkpT20B4QcpWAvqG98znAabE2PPu4kjUzNo7tLas3o3uq25WPXV6Vg1A0dv7ju
 wB4GtXYu/bA6YbhyE3XmsQa1z+wGtN4PaVgZcYgJsS32zLMvY/qCo/BqF+f3T0vPLdi9
 2+Aqiq8CY3WpOb/X5uA7tgoXppsVbG6X8iu8QzJ86U4LpQXmVGWBwqNm7ztenl4ud0n9
 LtI7FW8xGzKktsVPiLYtZsr+erP76EC8B8fP5fNpNvytw57vOJDllnrxOWKO4RomIqKS
 wqdA==
X-Gm-Message-State: AOJu0YzUjThzVnAJTi6U0fUynfutTGNe11fWjf+w00OAzxAwP87bCqoP
 iTZXgeFmD5UWFVIqW33BvUNNGcsQqoavDA==
X-Google-Smtp-Source: AGHT+IGr6h2udd5hqirUDS33ezwrjRocoe8erMPlBkzdZ7HFMAv0ED4xdpNtz804hkhpWGDG03ZlJA==
X-Received: by 2002:a17:902:f549:b0:1bb:d59d:8c57 with SMTP id
 h9-20020a170902f54900b001bbd59d8c57mr11847441plf.18.1692052459143; 
 Mon, 14 Aug 2023 15:34:19 -0700 (PDT)
Received: from celestia.nettie.lan (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 u12-20020a170902e5cc00b001b80de83b10sm10010401plf.301.2023.08.14.15.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:34:18 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de,
	Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] pci: pcie-brcmstb: bring over some robustness improvements
 from Linux
Date: Mon, 14 Aug 2023 16:34:13 -0600
Message-ID: <20230814223413.169955-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Since the initial U-Boot driver was ported here from Linux, the latter
has had a few changes for robustness/stability. This patch brings over
two of them:
- Do not attempt to access the configuration space of a PCIe device if
  the link has gone down, as that will result in an asynchronous SError
  interrupt which will crash U-Boot.
- Wait for the recommended 100ms after PERST# is deasserted.

I sent this patch while debugging a crash involving PCIe, but these
are unrelated improvements. I do not believe that this patch fixes any
real-world bug.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/pci/pcie_brcmstb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 1de2802113..a159952822 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -223,6 +223,10 @@ static int brcm_pcie_config_address(const struct udevice *dev, pci_dev_t bdf,
 		return 0;
 	}
 
+	/* An access to our HW w/o link-up will cause a CPU Abort */
+	if (!brcm_pcie_link_up(pcie))
+		return -EINVAL;
+
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(pci_bus, pci_dev, pci_func, 0);
 
@@ -505,6 +509,12 @@ static int brcm_pcie_probe(struct udevice *dev)
 	clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1,
 		     RGR1_SW_INIT_1_PERST_MASK);
 
+	/*
+	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
+	 * sections 2.2, PCIe r5.0, 6.6.1.
+	 */
+	mdelay(100);
+
 	/* Give the RC/EP time to wake up, before trying to configure RC.
 	 * Intermittently check status for link-up, up to a total of 100ms.
 	 */
-- 
2.41.0

