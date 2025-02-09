Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74287C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D7F080B9E;
	Sun,  9 Feb 2025 22:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dX46vXE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB93080EAF; Sun,  9 Feb 2025 22:16:06 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD83803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d13e4dd0f2so22917495ab.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135763; x=1739740563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTyMlNM04OXxirR3aGFfObhZbt9iRsvJlt7NqAZZ95Q=;
 b=dX46vXE9Cg/VlL1Fn4hUn5RgpYFeLbphBPPWRUdHByCLcMnbVmtFAaFwvI3LzUiD3L
 ciuVfVKjIcQmMOvUQqbZEK2yAQr5WTIcK+qsL7AUGNImlEoweYCW7KL7HrG76kjoFtTh
 7h75oHRtyFtkkBu/7JAcv+l8VmTetaWMmtRt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135763; x=1739740563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTyMlNM04OXxirR3aGFfObhZbt9iRsvJlt7NqAZZ95Q=;
 b=rhz7oO5B8/Q+uGNPPhtcdrJdQyINFSbZrmA2LHLPFvF+wGHDIo/k5WtinCdVThOHsF
 X5YScZROixnopaU6um2rihpURkpe0pjf+KmJRU8acuVLzSEJYT674rZBQE6LNDB1wEuO
 9iK5uA7r4usJ1cHcWL7tFxuBJY0MNY13fMhvHXgWfyvN8asZzZAtzoHwgd6unDKMdgY2
 vCvWnKXgkP/vtWi0yHztQuGQgtlBE8snuNsjTCwPbclCzYD8QsJZc2sSfoEv/uPv8lHo
 6jIx1+3ehZJP3ZBC6GSyK7b+Ha9JVFxQ3dyThI4lneLFlyk0IT8i+HgDfB0t/66q/Sqd
 FliA==
X-Gm-Message-State: AOJu0YznM+JKVhXdgrolWYukhriFcGB6gaK6PTlPzAnrAF2cE9Nb2G8n
 /B/7X0KS1ZUAAza70dJrYzW7xjzYKU48kaTgUFXbvVAYtaFDjboL0dimPZOZeydiPdDl5KubKzU
 =
X-Gm-Gg: ASbGncswZ6ZLJSYqA/JFGki6PwwYbUJ1M+HQWY8IfQrIHJwclC4V0ChYTLp0aYqbld1
 LR7mX4wpVPtIGz7goYgI/IMuEmyajom4PMD9OCs9b5cmo0NUdPof+D7v1yEJOBcKuo/RkzeDsju
 OIc+fK0lG7JSnG8Di0Qfk4UCzmzbR5kT70YL8/DWPhXRrNFvyj5qaPl3gB0vGRkAfYstXk/bYAt
 aUOcBKI5bav6BrRXmKy/CpPSplfFmGHBlJkWJlkOgyjtmFKm+1N3KZ84rPMwVjD+kiWlUhKjxd1
 YFe9wnlrzl7w8P0/hFY6wUqqxKzQ7ac25QfvLgwqLaRQVvR22+3g
X-Google-Smtp-Source: AGHT+IFT6scy1JZrNxHuM5SnrB+uHW1OuEgxJ4XXxvU53TX/2y6yH1OgEYrXRartUIp5T0R1ySFoZA==
X-Received: by 2002:a05:6e02:156f:b0:3d0:239a:c46a with SMTP id
 e9e14a558f8ab-3d13dd38629mr94559935ab.9.1739135762726; 
 Sun, 09 Feb 2025 13:16:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 16/35] rockchip: Provide a bootstd configuration
Date: Sun,  9 Feb 2025 14:14:37 -0700
Message-ID: <20250209211502.2299245-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Changes in v2:
- Move VPL things into a separate file

 arch/arm/dts/rockchip-u-boot.dtsi     |  4 ++++
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 31 +++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c899e8e6005..10563e273a9 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -224,3 +224,7 @@
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 };
 #endif /* CONFIG_SPL */
+
+#ifdef CONFIG_VPL
+#include "rockchip-vpl-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
new file mode 100644
index 00000000000..26b77e67c80
--- /dev/null
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -0,0 +1,31 @@
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
+		 */
+		firmware0 {
+			bootph-verify;
+			compatible = "fwupd,vbe-abrec";
+			storage = "mmc0";
+			skip-offset = <0x8000>;
+			area-start = <CONFIG_SPL_PAD_TO>;
+			area-size = <0x800000>;
+			state-offset = <(CONFIG_SPL_PAD_TO - 0x400)>;
+			state-size = <0x40>;
+			version-offset = <(CONFIG_SPL_PAD_TO - 0x200)>;
+			version-size = <0x100>;
+		};
+	};
+};
-- 
2.43.0

