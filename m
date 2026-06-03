Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03EDCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2217A8490B;
	Wed,  3 Jun 2026 17:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="oZ0QYWQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD2583FF5; Wed,  3 Jun 2026 14:46:07 +0200 (CEST)
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com
 [23.90.104.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70BFF8486B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 14:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raz.benyehuda@mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
 t=1780490764; x=1812026764;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rg7hKjpNRhwc9kX2SyqwKW0v/HoCUNSl4fjm7tHdMBQ=;
 b=oZ0QYWQgtgZjqUxWSXAVBUJIOSBemiyOW1v7IdMYbE8yn9aBadUE5BgM
 fcnUhhnLm6nzS9/0Y1eD1KrC9IUE3H1F2RPVwukUzScyJu/5uaNZ3+Q42
 Xi4f86u9fWRDSnieDxqR7rUYjT6+mSMie7mcR6n9zgc6txcscy1f6Canp
 PvFYK0JvmttYP5GTrhc2FRbHRpurulPuWj+gA2wCkkmrZhKPOk3lHQDLI
 B+e0TkChbYR34oTy31QMrFmzOiMhoAUBpSdQyzk4dfSVu9kiSwt3vILeC
 tu+XlL4iQBfTkXwLix5wOZAqA4a+ICk55IFUu9nmRm/EMqvi0ctftWQ7p w==;
X-CSE-ConnectionGUID: ISKhnPtRT9Whak6WMdCesA==
X-CSE-MsgGUID: +6kX7VavSG6xZt4ksRO1vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
 by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 15:46:03 +0300
X-CSE-ConnectionGUID: +j4awV4US9S0uNGJkK1kXw==
X-CSE-MsgGUID: R1GLGCM3SHq365CQn4hl5Q==
Received: from unknown (HELO epgd041.me-corp.lan) ([10.154.54.2])
 by ces02_data.me-corp.lan with SMTP; 03 Jun 2026 15:50:49 +0300
Received: by epgd041.me-corp.lan (sSMTP sendmail emulation);
 Wed, 03 Jun 2026 15:46:02 +0300
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
To: u-boot@lists.denx.de
Cc: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Subject: [PATCH 4/5] ufs: add ufs_tool to Kconfig and Makefile
Date: Wed,  3 Jun 2026 15:45:38 +0300
Message-ID: <20260603124553.3763516-4-raz.benyehuda@mobileye.com>
In-Reply-To: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
References: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 17:58:19 +0200
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

Add support for the UFS tool to Kconfig and the Makefile.
The HBA ID defaults to 0 and can be overridden by the user.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/Kconfig  | 15 +++++++++++++++
 drivers/ufs/Makefile |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..8f67d916a72 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,6 +8,21 @@ config UFS
 	  This selects support for Universal Flash Subsystem (UFS).
 	  Say Y here if you want UFS Support.
 
+config UFS_TOOL
+	bool "ufs tool"
+	depends on UFS
+	help
+	  Add a UFS tool implementation for querying, printing, and updating
+	  UFS descriptors and configuration parameters.
+	  Please see doc/README.ufs for details.
+
+config UFS_HBA_ID
+	int "Id of the ufs hba"
+	depends on UFS_TOOL
+	default 0
+	help
+	  Default UFS HBA ID.
+
 config UFS_AMD_VERSAL2
 	bool "AMD Versal Gen 2 UFS controller platform driver"
 	depends on UFS && ZYNQMP_FIRMWARE
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..0e472782261 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_UFS) += ufs-uclass.o
+obj-$(CONFIG_UFS_TOOL) += ufs_tool.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
-- 
2.43.0

