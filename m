Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA5BCE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 02:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C6E86B20;
	Wed, 20 Sep 2023 04:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b924N+R9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4758686BB0; Wed, 20 Sep 2023 04:06:05 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A50E86B20
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34fcd361e91so12559615ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695175561; x=1695780361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bs3qDSKhGGO2rF8QZluioyqDKZfDrUbyaXHy9WR+37M=;
 b=b924N+R9tuyTxhj+hgwtF2ouNX/IuCfqfEdlfkv7hP6L1dcxcmJYm/LBIXKX8Yxng7
 eecxDCOTfTaEIsO54mGKBX2B6c3Jku0o4xa8TgBNaLSMZnJQnCCzqXVcjndLPvwo4wZO
 1+xrSmd1t3RQrP3gejlxsjVLQMxXCm/LxzvuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695175561; x=1695780361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bs3qDSKhGGO2rF8QZluioyqDKZfDrUbyaXHy9WR+37M=;
 b=Z5T11Yt2CoGWeZUIQuKh5v8aaZCZXW3Zxd18XAsZ6KV7d7DrFCl0pCy5voDlCA+E6r
 XML19e2lNF45ixgixqdGjstBGKZBEIwWPHMb9wGc9Kgt22iH63argKXJBVY43TyEfczA
 AR1birvyWLp+6MvQeUL2eVYOZQiV5R33KHXcqpmuukd+QZKe2NsDPHkIHxiHzFXoWJxd
 Q+yo+ATg4auvyQ9hONaGe8BOOf9SFccSdSdKhsLD1/krvIvGVzgNGCjsiuIbNl00XGXH
 URYtcoSTWdTQtKxkYAWlJDU7jIswDfSh4p8VtqmXWnPheaKxWgd1Kfa0QRTjF1Kt/xak
 Pj5Q==
X-Gm-Message-State: AOJu0YwB+j1qurpNGXzwO/QU2wC7twBGdbhQGHyPBCJ0s38DMz+auqkm
 mSPbzqMRKPoKWFPEv6cqjRtzGmuKp2YhfszarKQ=
X-Google-Smtp-Source: AGHT+IFsxne/ggwTIB+/f5VvyCEb9mggyohztw0HQ2qyhBygtZ5WFtAYYTDrcOQqSzrIgXI1Q6+r4g==
X-Received: by 2002:a92:c26f:0:b0:350:f510:3990 with SMTP id
 h15-20020a92c26f000000b00350f5103990mr1820883ild.2.1695175560960; 
 Tue, 19 Sep 2023 19:06:00 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 h6-20020a02c726000000b0042b3a328ee0sm3820576jao.166.2023.09.19.19.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 19:06:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 1/2] dm: core: Correct references to DM_SPL
Date: Tue, 19 Sep 2023 20:05:47 -0600
Message-ID: <20230920020558.1373955-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
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

This does not existing anymore. Update the two in-tree uses of it to the
correct Kconfig option, which is SPL_DM

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to correct references to DM_SPL

 drivers/block/Kconfig | 2 +-
 drivers/core/Kconfig  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1abea3f10db4..ef41aba03555 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -13,7 +13,7 @@ config BLK
 
 config SPL_LEGACY_BLOCK
 	bool # "Enable Legacy Block Device"
-	depends on SPL && !DM_SPL
+	depends on SPL && !SPL_DM
 	default y if SPL_MMC || SPL_USB_STORAGE || SCSI || NVME || IDE
 	default y if SPL_AHCI_PCI
 	help
diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index f0d848f45d8e..6c287c68a1c2 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -88,7 +88,7 @@ config DM_STATS
 
 config SPL_DM_STATS
 	bool "Collect and show driver model stats in SPL"
-	depends on DM_SPL
+	depends on SPL_DM
 	help
 	  Enable this to collect and display memory statistics about driver
 	  model. This can help to figure out where all the memory is going and
-- 
2.42.0.459.ge4e396fd5e-goog

