Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB7FC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB97836C5;
	Mon, 26 May 2025 12:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AZXOAv7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E849982E27; Mon, 26 May 2025 12:16:18 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63610836A7
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so11359075ab.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254574; x=1748859374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbgPwT/3EkaBDc+jBpIns0ogqhwP0Rw/rk9L5JajsMw=;
 b=AZXOAv7oYroRFs8s0AJSFtrIrh1cTPSXxjDNX2veygLs8aFv0ayOa00uwNjsZ35DzW
 HZGPtzyQvZlIWzwcmuo3/OInXShLhro2rU20GnJO6lNWc5NrpLTY3X4UakqcBxzEYMN2
 bHjEF2ET7/yymwOsDKmqsLYfZDNQlNgDFYZwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254574; x=1748859374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbgPwT/3EkaBDc+jBpIns0ogqhwP0Rw/rk9L5JajsMw=;
 b=OoaJO+VUqIIRQQSu155LGak6MJfbuJjAQJ+7ITpunU25Ugb9FcVVy/SbTuFuUlFJ0/
 OZgkw4+C5PaIirZ0ZbaQQpHne4KF0psK9qwgH2u9wf5Q1njx1GwDZ2WEZ5Af3BYfIFCx
 +cymDJ6OXI3LV79p2iAAPojNqmidECMXvo1l/NSrsI4CeXlkeDBX6dQc+wrMIxgHYZk7
 Ka7Cqzc8FPRDFRryZ40330bzGY9r/N3Q1DBEfyGUtImkrNatSeGsiD5f64cRo6C9owdX
 lku/FLWZMm2UA8oqlhV6dNxiC0dNA8ir5M4d+Qtx4eNx0htSwz1oHPnxLquAq0SCnMid
 p4hw==
X-Gm-Message-State: AOJu0YxhOZnC0ItAQF+a51f9lp5x+sDeiziQM7pQrl+L0q7aHiKMl1m2
 sHlRMhVFmcQOnwQC+BIlGZIuhZAhIgTSnsFwhKZerE3FRTv52mOfvjJju3L5jbHrXp4CvFSYlWK
 UnHLz1yf1
X-Gm-Gg: ASbGnctLhDOo2L5xFscpJWVUkHkXgF+sqGDoiC5jMya5wMggArqYyUjoTWVy+MCtAzZ
 vBcQfs4Mci0f/6vnCsI0pUxgmvogylOXk+pMDQMB2L4VVOZT1S8Jfj3cfEcGAhXM9+eTv04Mrri
 xYc1nF26d5UHplGjTYh6apTe0S0xZqZ4LgDvhXV6GrNvxCkHdKR8nSJbLPTfcB353BcpGJuew9w
 /EPP9yxIVrUXVFcK4fnB3oa/H2l++PHTyDXj5Go0v/7Xx1uC0jLx9SeIKuHb9KC9UP3Wh7q8oj4
 8igTfNa90x5ZK+e9pGGp1CLl2DfkfYtw8atymc2iCv83GyE3Sa73LzsoJvOKLsCzRljBsNrwqbQ
 C0rYc2q9+IaA4Di7S8b+xnnU=
X-Google-Smtp-Source: AGHT+IFaVEt3vqr2St/9kTmOrZK7Xi8TioyudURvhOiX6A3HBXecCHuKS7BrNNEK55XjU9Brx6ld+A==
X-Received: by 2002:a05:6e02:3301:b0:3dc:7ba2:7a39 with SMTP id
 e9e14a558f8ab-3dc9b773bb0mr79765655ab.20.1748254574606; 
 Mon, 26 May 2025 03:16:14 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 07/25] rockchip: Provide a bootstd configuration
Date: Mon, 26 May 2025 04:14:53 -0600
Message-ID: <20250526101541.3254628-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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
index 54b567cc3c7..f1e8f129cb4 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -238,3 +238,7 @@
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
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

