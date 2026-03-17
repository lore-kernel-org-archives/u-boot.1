Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE59FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD9584159;
	Tue, 17 Mar 2026 02:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c8QbU5xm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E73F88407E; Tue, 17 Mar 2026 02:24:29 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA5FE83BC8
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d73e0e0a36so2280108a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710664; x=1774315464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JBlgmIxhFy9Q8CmhARNR+JjUpi6ITjzkLOky7LULoMc=;
 b=c8QbU5xms3OrdVq2A5HdG4WSDjUpJK1W+aT/to0zEiin+SDHc6ERYTh6ZkoUIglLq1
 iT++PY+i19W7coULIOuKoOPVEc3NswyypTxV2rBEvrSNRx49gsGGk1Th3xkCPkOxdtPY
 HfOOyJAg/7NnrHYOItXakdvPSXe9ZmH3Dti3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710664; x=1774315464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBlgmIxhFy9Q8CmhARNR+JjUpi6ITjzkLOky7LULoMc=;
 b=BhZDk6DjoTXTX6BiwrnEb/F/8DpncDMJ5eWTi9fAz9pCFnYrXtiqq/z+8PLO2Wl36l
 BujalQdrzD6GM4w6FGp1g9tWpgjtsTSHGnkV9tZ/CAYhlUFQ5l5PaTKndsqrAWd3B9EK
 dV3dQutFvnM5rL5SLyZ/H5EBEr0wkScgcYkzx9oM1uk2O95oZuQ47x/QyFxndlABdKJZ
 spOLlq0kk9IZgG/aLpDr/YEXhQU7oAfUuVcefHdQo8na7efCR0yr4c2ERHuSXwW2SkFT
 YT6IM8qcHSKD+P8IlgzqiF6WRLkTKCbiDqFtjM9VNnO6ZjyBgaAL35h9jvpm2fO/35cU
 JrHQ==
X-Gm-Message-State: AOJu0YwPshBSkoacc2lbMtphOr5is4xdF4MYrG9ooZcEGL1KMngV31Vj
 hO27Z4hAyQkLmc0SLHq5rZ9paGZPqfEgryuwli5CFsa11RvCQCRpXSQYOJ/KhN18vB0ei8iFyz0
 UWv0K1SE=
X-Gm-Gg: ATEYQzwYQeHTJwf4hZvJ1Ur4ZdZnwiiodaJKEASJNYFMbGfdpZ19l86n74seQ1BAPHw
 MelqEMWpOHWKQaLSkAiUlpSZuIS6iaZDS+p8RBET2hCHU4Jh22ao6jif6oQBukIooFDPUesmThG
 AxDnTW57+SmpUXoecoQQBRBWOXKFYhPsZt6yNrR2kohlEkbPt+XfeqrHSUoacoIea9TYUmFVXPe
 VPHIQr2YBKtpTQtP4NUCXAWBEqkpqVFrtyWQtrmrdgFeo9qYr9hsE4Ph3aIprH+RHaxzi48+z+r
 Pw+mGOH0z8uvl+27vjO2HMmz/30nt9imCR4VubiuYcM9qKx5+Z1Wen5mQME+4QTUpE6K8vDkBCq
 gvFDe1Q0bqBGaJEtssOwhoI66Ra2+XToVDpZWXrYsGf0D7PwEigqSSqGZiITWyeMfzuu1q+KfCR
 7mdLfQRRJA9UWdSg3grlANUnbTaw96CJMIJ1ODYSTyUERZFRq6GcB3ZDFsS67fDh+pRqD1WNukK
 AD6CcfyINiqWPSUnSxkJmdbgnz1maEwBT3B9xK7hmuiIejDkqk=
X-Received: by 2002:a05:6830:15:b0:7d7:b680:8e73 with SMTP id
 46e09a7af769-7d7b6809441mr1398721a34.7.1773710664586; 
 Mon, 16 Mar 2026 18:24:24 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac8e5b4sm13946112a34.12.2026.03.16.18.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] net: Rework some symbol dependencies
Date: Mon, 16 Mar 2026 19:24:23 -0600
Message-ID: <20260317012423.4162427-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have a few dependency issues with
some network drivers:
- Both HIFEMAC_ETH and HIGMACV300_ETH functionally require both DM and
  OF_CONTROL. Further, HIFEMAC_ETH needs DM_CLK not just CLK to be
  selected.
- BNXT_ETH deals with it's PCI requirement in a backwards way. The
  symbol PCI_INIT_R is board specific, PCI alone is required to build.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
---
 drivers/net/Kconfig      | 3 +++
 drivers/net/bnxt/Kconfig | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index cd07b117a5f0..02063ce3aa91 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -979,7 +979,9 @@ source "drivers/net/mtk_eth/Kconfig"
 
 config HIFEMAC_ETH
 	bool "HiSilicon Fast Ethernet Controller"
+	depends on DM && OF_CONTROL
 	select CLK
+	select DM_CLK
 	select DM_RESET
 	select PHYLIB
 	help
@@ -996,6 +998,7 @@ config HIFEMAC_MDIO
 
 config HIGMACV300_ETH
 	bool "HiSilicon Gigabit Ethernet Controller"
+	depends on DM && OF_CONTROL
 	select DM_RESET
 	select PHYLIB
 	help
diff --git a/drivers/net/bnxt/Kconfig b/drivers/net/bnxt/Kconfig
index 6ff3ffa137be..e25ed479678e 100644
--- a/drivers/net/bnxt/Kconfig
+++ b/drivers/net/bnxt/Kconfig
@@ -1,6 +1,6 @@
 config BNXT_ETH
 	bool "BNXT PCI support"
-	select PCI_INIT_R
+	depends on PCI
 	help
 	  This driver implements support for bnxt pci controller
 	  driver of ethernet class.
-- 
2.43.0

