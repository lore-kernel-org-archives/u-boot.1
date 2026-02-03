Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088FAE87827
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2304784212;
	Tue,  3 Feb 2026 14:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="OoR8co5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C99BA84101; Tue,  3 Feb 2026 14:09:00 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7AE83FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AF49E27109;
 Tue,  3 Feb 2026 14:08:58 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0mxO72NVa1JY; Tue,  3 Feb 2026 14:08:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124138; bh=aEz7lby/jrsiOYuCdAlzkDV/F2HYC89z/mnUzDFoxM0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OoR8co5u5chWAinvQxrJeftEdyRTk6/5mMLguHJNGnxnMp9lOh3PpGgMH0dQHKMXT
 AahznbDEKBLXRDOi5IuAzQKSiKHVjfreZgytxQ/W6jnh2E+L3fK8jPvInsog1aPm4v
 DPWK2jqxZZUQxsvYM6mKxzNa2i7hDTrcWAYgqzYXo0ILhrsz0iivNhsA4Z0lHYjbhp
 AWQelyFXOhMxi1VUm5ZKmv2mCTwRxaN5RX8G4QWhwkS3q7bHtJgyBxGwM6e/P5YQUH
 DLb0+4C1lcX4IXXa5ZwL5OaZQa1OZXm7Fod00+xXKlqF5wcQz+TJBzSyQ3erWQm+78
 +RKHHwdl77Vsw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:42 +0530
Subject: [PATCH 04/11] board: samsung: exynos-mobile: enable OF_BOARD support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-4-a16a0e57991c@disroot.org>
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

OF_BOARD allows to choose the internal device tree in runtime. Use it to
pass the external FDT as an internal one if it is not present. This
approach is also used by qcom-phone, and it reduces boot image size. It
is expected that an external FDT is present as U-Boot is packaged as an
Android boot image.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 board/samsung/exynos-mobile/exynos-mobile.c | 9 +++++++++
 configs/exynos-mobile_defconfig             | 1 +
 2 files changed, 10 insertions(+)

diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index 412dfa7555c..1f61f28de5f 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -231,6 +231,15 @@ static int exynos_fastboot_setup(void)
 	return 0;
 }
 
+int board_fdt_blob_setup(void **fdtp)
+{
+	/* If internal FDT is not available, use the external FDT instead. */
+	if (fdt_check_header(*fdtp))
+		*fdtp = (void *)get_prev_bl_fdt_addr();
+
+	return 0;
+}
+
 int timer_init(void)
 {
 	ofnode timer_node;
diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index ead4ea4493e..846f9e24bd3 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -25,6 +25,7 @@ CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
+CONFIG_OF_BOARD=y
 CONFIG_BUTTON=y
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
 CONFIG_CLK_EXYNOS7870=y

-- 
2.52.0

