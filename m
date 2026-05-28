Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D226BCD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E29847C4;
	Thu, 28 May 2026 19:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JX0KlW1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D62398484F; Thu, 28 May 2026 19:11:12 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFDB184659
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e62b6163c8so1772195a34.2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988269; x=1780593069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95spaWtnuevJ+9dB+PSF7SEICe+3TgQv0Oc40hAYzzU=;
 b=JX0KlW1Dcx+z15oDKKIze0mATwKREErGfRJj4SIbOuFYIdcdtQQxZnE+SfN6/nz7kc
 kAvtZRsoaYyAAG5L26EqWOTRRtAbTodqGkuXErpz3bmdeso+ABBbg+LkYe5PHN5j3oIZ
 1nwRuHTi71ys6NHk8azYqNbrhuMKRZICQVVYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988269; x=1780593069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=95spaWtnuevJ+9dB+PSF7SEICe+3TgQv0Oc40hAYzzU=;
 b=W2jAweUVzLAlGkNQF9kdtt0O2JPeLz6kT3ENLqWSM914n8kyy5bDBX/juO5KCPLcew
 HnFYd0c1iDemSKqDtC9XVKVLeIH28oWaEdDE3RhQGdK7on6w7sF1WjUAER9b5H13lIYZ
 JJZWA6R835dnKnspEUfIAyuLZ1/MCoqG3g25MSRtt5K+XZodrABxWTX406rgAGu/gtb+
 d2qrsyaU9jNLLJud229pRhpgg6ouCcFZRMwKZ4urLyEOifQ1YwskK/FfIP1yFuPpCKb0
 bVf8itDJqyqmIn5kZAV/fU3OAPE1Dx/hBGkKYI8hVf9dplAworDpa8RV7OtrwAsH+uOU
 T3xA==
X-Gm-Message-State: AOJu0YwXu55xHkS18tgb87exXrGxFY568LYWtz7eF4wo+lcLSJFB88yW
 NEqDE5kJVqOnyDnbyRkrh0h75lmlad8nwqAk8SkIlhixK2KMfB48t5BKCs9yIsVYaOHpb6ePpFN
 XekssLY1TWrA=
X-Gm-Gg: Acq92OG5dqbB+1GrVdOc/6JD3lKE4F0B23yyeb3+FvGuP2iXgqwTB88DRcJzh7v1vaZ
 G3AhiW1DDKX3Gf87sHX82+KlxMU/yQRplsUNXvWPLSoxt3sTydUDf4fXXF5kJnjSTi8QNuhhvuj
 D6Pn/aRQ2Gq2tZ22jUC+uiDE/IMc6ADJy2z669CLqjOthD4empg2Kd2VXxFsqeaCsAfz64a+xmh
 qPOVpEkeuH3De2z/vgL2C04yAJ5DW+ZIVuy9Iaist91PJHbD9sxbGQRSWDWPq3fo1IJD0OwpyTJ
 2guEunQrsx/9zLgTemtonJIN+wf10x4mwjInr7zqOetrXEZSNAy78GX0rfb7RM3SqBaHo19Cs2k
 hAerukl9Z4+PwU/jJ+df7596b9Zgve/TC7s5UzHOiZejefaQF7RHFfJSGwn0oNwxearOCZ9LkuL
 hyre4fh6f9OLKPsxxSwR6RbNdVvQVs
X-Received: by 2002:a05:6830:270f:b0:7d7:419a:7ac8 with SMTP id
 46e09a7af769-7e5feece82bmr17073188a34.15.1779988269465; 
 Thu, 28 May 2026 10:11:09 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 07/22] rockchip: Provide a bootstd configuration
Date: Thu, 28 May 2026 11:10:14 -0600
Message-ID: <20260528171043.910264-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

Add bootstd information for VBE. Put it in a separate file to avoid
cluttering the main one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add a comment about the offsets

Changes in v2:
- Move VPL things into a separate file

 arch/arm/dts/rockchip-u-boot.dtsi     |  4 +++
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 40 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index f4c6a14fefd..daf4f489d44 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -273,3 +273,7 @@
 #endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
 };
 #endif /* CONFIG_SPL */
+
+#ifdef CONFIG_VPL
+#include "rockchip-vpl-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
new file mode 100644
index 00000000000..475dbc53796
--- /dev/null
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/ {
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		/*
+		 * This is used for the VBE OS-request tests. A FAT filesystem
+		 * created in a partition with the VBE information appearing
+		 * before the partition starts.
+		 *
+		 * Offsets are aligned to the media block-size, typically 0x200
+		 *
+		 * The start of the VBE area is set at 8MB, adjusted for the
+		 * skip-at-start offset. Before that is a block containing the
+		 * version information and before that is the state. These could
+		 * be stored in a different storage device if available, but so
+		 * far VBE only supports MMC.
+		 *
+		 * The total area size is 8MB which should be enough for a FIT
+		 * containing U-Boot and a number of devicetrees.
+		 */
+		firmware0 {
+			bootph-verify;
+			compatible = "fwupd,vbe-abrec";
+			storage = "mmc0";
+			skip-offset = <0x8000>;
+			area-start = <0x7f8000>;
+			area-size = <0x800000>;
+			state-offset = <(0x7f8000 - 0x400)>;
+			state-size = <0x40>;
+			version-offset = <(0x7f8000 - 0x200)>;
+			version-size = <0x100>;
+		};
+	};
+};
-- 
2.43.0

