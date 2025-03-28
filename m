Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA236C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E967781EC0;
	Fri, 28 Mar 2025 16:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IVy00Nt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C7F81FAA; Fri, 28 Mar 2025 16:36:09 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6A981F4D
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85b40a5120eso65976539f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176165; x=1743780965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gy90ii9VAyw3WAE5cHKvnwjK6x8tvqRHNakT7TnEfDw=;
 b=IVy00Nt9VRNqSOYjj/Azfcu3HT6pnsNLbm+tts0e7FgGQ1JNnIaYLkn+SPXZ/78weS
 OePt6EsDnBL5TA3ypQrepjt8utlLIkPnOOBuF3bPV8MJTPnN0G4rp/xr+N43KCiOeDvg
 X6R8xh2gYKByyWSlJJgyjDhEktzLg29CUzRU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176165; x=1743780965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gy90ii9VAyw3WAE5cHKvnwjK6x8tvqRHNakT7TnEfDw=;
 b=DpiB3AL1yBohH6nV4iHK3C5OKaUDNdHLNX4Qm1pZxxg1VxLvlP0IQS7ZR54hdJFLHx
 aJ6ODa9JFj1ELBe24CbBvHFsJwGXbZSZxgi18sr+c9gRcNrjOr/otmCab3Irqa3ujazN
 XCYrD1vehVuj/QznKluIIYZ/AK19Cry8M6FoJ+8f2EjUBHTi/8QBwwQV0hUOTBh4gRa0
 Ok8XL3foP2oKm4DUBWsxVSalLG05qXg5xCihj8CbAuMYLp4v2g6rIDYqwdNocNQo1Ohh
 qWGMQMElWpUQPH496BlnPWhRuUZauXssi9hkG2UGE0gItt6W3xNs228+1DRiwssUEsXr
 yWOw==
X-Gm-Message-State: AOJu0YzOjVqpvqRBNx4YXMiYxDh/7sL/o0BNfbNnrunOdeTpk0bKf4QF
 bXNYPSDYdFHQAWyJeZXXmrJSqNbxgk7UdHF+U2QrE7BbimzU0rG3M0TpREhqocrYoWGTYR/M3EY
 =
X-Gm-Gg: ASbGnctnramy1CXRK3cqpCv01e2XCs9nM5dHomINzluYm7HGbPTITz45bhIUYyy7CmR
 uTNMuZ3D9o6opshAzDMQimbD9YuL+0TOA3DHQdJPB1UAHWzXVQ+2Dp3A4SlMQJ3U33qg7RXUlyi
 wK4ZmD4pGRwfQ5LxnVLIcpsTb7YB5YsC3Qke1D8Hv9RUuyGuhkBgzx5BRoylWUzjTrlPafGEQrt
 U77oPGUNT/EkcivK4OxnYpTpDYdAt8ANTB9tzJKIrlQjg7m3iPT+JD2ZxsR8v7RzkbQ31V4obLR
 0y7JJN9LA37nRCjzlcVgOV5OQPRttTkQFIWAKtodf/+S66iQ9moLgId/fE6Fb5LX1vplvuBNUOK
 g+6LtzQ==
X-Google-Smtp-Source: AGHT+IGVfJnuMdAgNWtTwHn5r3eerI+nUFy0n2zMUqcP3SLhgbWKjkSNrD8PagveL5YN35TgyjXJVw==
X-Received: by 2002:a05:6602:3a03:b0:85b:b82f:965b with SMTP id
 ca18e2360f4ac-85e82147058mr1053795939f.12.1743176164975; 
 Fri, 28 Mar 2025 08:36:04 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 12/31] rockchip: Provide a bootstd configuration
Date: Fri, 28 Mar 2025 09:34:52 -0600
Message-ID: <20250328153522.3555472-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Changes in v3:
- Add a comment about the offsets

Changes in v2:
- Move VPL things into a separate file

 arch/arm/dts/rockchip-u-boot.dtsi     |  4 +++
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 40 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 465f54b8b09..85a89e3a596 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -226,3 +226,7 @@
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

