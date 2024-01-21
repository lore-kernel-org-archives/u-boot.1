Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E1DC47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 021A9879D5;
	Sun, 21 Jan 2024 18:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Uke/Vmqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9FE87960; Sun, 21 Jan 2024 18:44:10 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEFD877F8
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TJ11f4nZsz9sWB;
 Sun, 21 Jan 2024 18:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705859046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v01T79hY8/r7CN9mtQuC7MjoXxdDNxj9YR9hGX96GEw=;
 b=Uke/Vmqgrcmobd2dbKu3lp81BrkChnZ+QNnvZlQsHTGdFOIZL5m/SfAY1DxGfNdRTajP6H
 6oqJk8k/qBUPYHGgN+HwDlhzbfI2VQwRW+cyJeyCj9Y/ft0UcUKAc17H4aGFtHjD7MEa2Y
 aNpRFIZYYWFKQ4km+E6AYcYJ4H68Rq0qToaLw3ezWYv4O+g3VCxLCvaBZl8ZN+P3L+feDw
 fWL31dbuNnzWFin2XBpYGmACmvOWLU/wbcZsggZAKTlcuBiJVl1qnti5CBRYKfkuWtjHT9
 MquYLPmOweQyM076IO7XnsciFzNuZikbl8MFUrqwFc+1ADTHJK6O/ypyTmStBg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 07/11] ARM: renesas: Add R8A779H0 V4M Kconfig entry and PRR ID
Date: Sun, 21 Jan 2024 18:41:10 +0100
Message-ID: <20240121174340.279465-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 69d2a6eeef88c0a518d
X-MBO-RS-META: zyh185qmi4tdrgf5zak8m6cdoer8543q
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

From: Hai Pham <hai.pham.ud@renesas.com>

Add Kconfig entry and PRR ID to support R8A779H0 V4M SoC.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/mach-rmobile/Kconfig.rcar4          | 6 ++++++
 arch/arm/mach-rmobile/cpu_info.c             | 1 +
 arch/arm/mach-rmobile/include/mach/rmobile.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-rmobile/Kconfig.rcar4 b/arch/arm/mach-rmobile/Kconfig.rcar4
index d4f93c89cac..3c8d683974c 100644
--- a/arch/arm/mach-rmobile/Kconfig.rcar4
+++ b/arch/arm/mach-rmobile/Kconfig.rcar4
@@ -20,6 +20,12 @@ config R8A779G0
 	imply CLK_R8A779G0
 	imply PINCTRL_PFC_R8A779G0
 
+config R8A779H0
+	bool "Renesas SoC R8A779H0"
+	select GICV3
+	imply CLK_R8A779H0
+	imply PINCTRL_PFC_R8A779H0
+
 endmenu
 
 choice
diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 895c0f5336b..3d5d5ba79a9 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -78,6 +78,7 @@ static const struct {
 	{ RMOBILE_CPU_TYPE_R8A779A0, "R8A779A0" },
 	{ RMOBILE_CPU_TYPE_R8A779F0, "R8A779F0" },
 	{ RMOBILE_CPU_TYPE_R8A779G0, "R8A779G0" },
+	{ RMOBILE_CPU_TYPE_R8A779H0, "R8A779H0" },
 	{ 0x0, "CPU" },
 };
 
diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/rmobile.h
index 88b8b78671b..f0216210ba9 100644
--- a/arch/arm/mach-rmobile/include/mach/rmobile.h
+++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
@@ -43,6 +43,7 @@
 #define RMOBILE_CPU_TYPE_R8A779A0	0x59
 #define RMOBILE_CPU_TYPE_R8A779F0	0x5A
 #define RMOBILE_CPU_TYPE_R8A779G0	0x5C
+#define RMOBILE_CPU_TYPE_R8A779H0	0x5D
 #define RMOBILE_CPU_TYPE_R9A07G044L	0x9A070440
 
 #ifndef __ASSEMBLY__
-- 
2.43.0

