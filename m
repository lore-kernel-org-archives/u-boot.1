Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3418C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9513D83631;
	Fri, 23 May 2025 18:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lFUtCPYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AD3830B4; Fri, 23 May 2025 11:48:11 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F311B83211
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7238a91f03=antonio.borneo@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N821VG005102;
 Fri, 23 May 2025 11:48:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 xwOITI/2hsvhERLqfmjAhHSsl7uqAkMgDz3yMq3GAEs=; b=lFUtCPYNYhMQY51D
 Dp6RYIko03XAtKC44ZXiFyDXxlLsBIgftnTEx8A+uNhDhxh37S2bERIiGRtK4yHi
 8o5iDDCVqt5ztVfsXlrkUnYXQLa9FedmkMAT/Z715fsx5HlbBjINr0g/HknKksfo
 IHFyoLp9NTTs0m33UVzRqQccYhyX9jQg/5GDjEDha1pkrR9oBXde0jjDyDP7x5yt
 k+q3UTYqPwF9kmCfVXBxxdtrgWwaAHETJk2DSXNpj8wbdHcTtP6cuQZHrpoKH6e9
 qSyau1ObGt6k/3AjfMRHSw9Y9M6tTafPyXTnZ50mz6yAmuzgIZ43ohOBI9RfHlm0
 rGX/8Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfad8j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 11:48:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A0F2C4004F;
 Fri, 23 May 2025 11:47:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F1EE5ADC011;
 Fri, 23 May 2025 11:47:11 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 11:47:11 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
 <clement.legoffic@foss.st.com>
Subject: [PATCH v2 1/4] watchdog: wdt-uclass.c: add wdt_set_force_autostart()
 helper
Date: Fri, 23 May 2025 11:46:55 +0200
Message-ID: <20250523094658.299730-2-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521122755.265760-1-antonio.borneo@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.132]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Mailman-Approved-At: Fri, 23 May 2025 18:55:43 +0200
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

The watchdog could have been already started by a previous boot
stage (e.g. bootrom or secure OS). U-Boot has to start and kick
the watchdog even when CONFIG_WATCHDOG_AUTOSTART is not enabled
or when the DT property u-boot,noautostart is present.

Add the helper wdt_set_force_autostart() that can be called by the
driver's probe() when it detects that the watchdog has already
been started and is running.

Co-developed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/watchdog/wdt-uclass.c | 9 +++++++++
 include/wdt.h                 | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 10be334e9ed..b32590069d9 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -46,6 +46,15 @@ struct wdt_priv {
 	struct cyclic_info cyclic;
 };
 
+int wdt_set_force_autostart(struct udevice *dev)
+{
+	struct wdt_priv *priv = dev_get_uclass_priv(dev);
+
+	priv->autostart = true;
+
+	return 0;
+}
+
 static void wdt_cyclic(struct cyclic_info *c)
 {
 	struct wdt_priv *priv = container_of(c, struct wdt_priv, cyclic);
diff --git a/include/wdt.h b/include/wdt.h
index 5026f5a6db4..1ef656585c4 100644
--- a/include/wdt.h
+++ b/include/wdt.h
@@ -18,6 +18,15 @@ struct udevice;
  * which typically include placing the system in a safe, known state.
  */
 
+/*
+ * Force watchdog start during init. Called by driver's probe when the watchdog
+ * is detected as already started.
+ *
+ * @dev: WDT Device
+ * @return: 0 if OK, -ve on error
+ */
+int wdt_set_force_autostart(struct udevice *dev);
+
 /*
  * Start the timer
  *
-- 
2.34.1

