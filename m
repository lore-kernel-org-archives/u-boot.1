Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE63FCD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 20:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F15988039B;
	Sun, 31 May 2026 22:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="beNQdUer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13541840ED; Sun, 31 May 2026 22:47:51 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 039E980077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 22:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7dee6b76a73so19789387b3.0
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780260467; x=1780865267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LEpL4wSnbNc8tduBLG4REHos2rxf8ScG2EdQSoBH3lU=;
 b=beNQdUerz/1O25wDGqjN8YgnaglL0246YPBMEmTNL9rPGD0YWTLHcMT+IPWlo7GdXU
 U72LT1MewvMrGay4UGZW/Mw+xE5RDVWwgXUW5HIx1P777FojkaOg2OgMaEtLuJaMALE2
 CLoqq+MHwVra4rCqG8oV5YxA6m3lgCPfU0jTWsHMwIjzBpi4BKS1woS88cmbVEmRLGaM
 23LXJVMdsevy1jEK/OplI1FHlEgg3ftr4aAWOCZoYDnbqCFgDYjlxw6gwW5+RT9OoAoG
 2xU/XD9ncuYOxBxKyOO1kzzsvL/grwJKIabHA7MeqKPtwX5NmRGMgyhNQEIPd1ghAR9K
 WcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780260467; x=1780865267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEpL4wSnbNc8tduBLG4REHos2rxf8ScG2EdQSoBH3lU=;
 b=npohhJUSwNe493QAEIAgER2j+rJxPTVTqhDhfWx18YDyyWUPNGOe6Wn9OFjRb9MM4y
 IY3HiCs23Sf6ZRNp7me9+XAEI3npEMPD0oONo5JBlgq1n7xD2fLrLsPAHLDYY74P9Nyi
 jq343FeV1+xyHFTkYa5QI7znQMLGDSUp56riv9PMJGmCw017a+965FHoDuyUD0jxDwLq
 wwKlHYoVhOZ0g1HEPrVnHUh7Nq+G+ZolBs3ICwB7Ps0l4gUfqBFs5dPbOFMKy5c/LPGc
 YpQ+m+3kaZj6C3syzNvtKvNaFgiEGn9rllVWGC6QZYIVhinMaZDb887Gl8HV9CYns4J7
 i/7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/C2jUg7iQe1f0A8TuwTKN9AGc8hIUHVsKoQu3b8yFp8VV8898sM2vrM29Y58jTELNQmejEh1g=@lists.denx.de
X-Gm-Message-State: AOJu0YxO2RmENlWBj71RE3eatat+dAQFPcouJ7zf/b88eXcSpC7Au5g9
 VR/ZMcmY9g3ZRARvx9gxj0ssQ+PYexS32dRcXTF9WNDdRjJo58gmmvv+
X-Gm-Gg: Acq92OErqWHF9W7C/zAaDXrzkzIN/14FhdA9KeJL8BkLDgj0ovjhMCGnR+6Df8EkcBg
 qC12LeuNCbGAdQeSGQNDoPbcFl27yvJAJ1CeP5xSqr748j6WMSHZqB0dAwjfEzvsF5+NFZw+d86
 PC6lDPA+Mw5cCLcIavK2F4VpsASR5wO7oEuy5/xavWlPF+aaJ25JUHWI83Xp5Qx44hKlqYnIXFO
 i3CHUBOp7CjDpRkm6wktnWvgaPBuOr9eoWTOSmE9VLcwa+oH2vRasz3s4tozD/AgdFyJ0BRO0eZ
 /BdczAC4Kj1Uot7tnTjwLfUGKh3HZnYMJs8qeTHCH712RJR1q2FNH7gt12DlCUjWQYqASrrdMDe
 NfzeEsxuY6ZAyEoi9byY2f9wFAqQAOhzaxywwESSAAuW+Em2OMHYUKiAXAm018HTfTAmLLeCXJ4
 Dc0SQ6au2N0UaWN0w/1GV6ymhMc4dNJ84ztXzFE6I/DA0SOvSJOYsG/WxywW5zUboertYarhnHM
 lrUoAgmHMWNlF1vck+HcwUMl9N2VAO8aAM=
X-Received: by 2002:a05:690c:c4d0:b0:7db:d730:4b8e with SMTP id
 00721157ae682-7e05c6649cemr74462557b3.26.1780260467602; 
 Sun, 31 May 2026 13:47:47 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7e177149a9fsm28244117b3.19.2026.05.31.13.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 13:47:46 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tony Dinh <mibodhi@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v2] arm: mvebu: usb: enable Armada 375 in XHCI driver
Date: Sun, 31 May 2026 13:46:04 -0700
Message-ID: <20260531204723.5422-1-mibodhi@gmail.com>
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
