Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46393C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C83B8497A;
	Fri, 26 Jun 2026 16:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HtRCx2yX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E44849F3; Fri, 26 Jun 2026 16:45:52 +0200 (CEST)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D65F849C5
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-139edc6bfc0so5037c88.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782485148; x=1783089948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lBedHLodvewoIsAc6dMvbiN6nTfjEPBNXL86Vul3K8=;
 b=HtRCx2yXxt6pFN4m+IPBKC6LR3EPnmO9gzUkSKcdYJXtiIxMARk/lf9Bdh4FxD/xwT
 5ZWhgHfn18vI4km624kq2glvDhAWSIkgX8T6ZPhx20jW0UBGfCAdsPeBuBYIKNQ/ICUl
 6uz0uL/qAzneYfz9Xo3oc45MtpAio+UZlQXCFL/6JdYsP5d480v0RN9p63WkB0xa1tFT
 PdDRKcpr/YZsgc5qMHYrExcKEdGjzu3nvah/iPz2R06BJawtjKDm1ucq4mVQaqTGnWoU
 2GC53cvmPoZ3OHSHY4aRS4DfBnxrLZi0Zz64k37/7h0hK07WQhJqV8uoK8PsgU7amDbG
 ZAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485148; x=1783089948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3lBedHLodvewoIsAc6dMvbiN6nTfjEPBNXL86Vul3K8=;
 b=JeuNv7M5bMa+SoWuYQZpUv0hnpSx2tO5SWO6N1PNGi3BdUMbgNpFdbtZ3wEcY+0tVu
 X8mHDTQRVFXP1euE4eokneDbcK26hQ3ps/aE+mpEFNcT/Xsq1GK4SqmRJu6xMymZxkZ6
 kEDiq5pQDJcag9fVzrd/nPCNKInkZYTw023sFZD+mpudlUg4ErL5heO4AmCtsY0BQVw2
 cHdeM6Ph07jJkHFuVYxSivgd2+S6HRKwr8uWLB/82nt877bHLWOc4iN5Ob/tReImFg7p
 /Z1ggedP+8pYLmYpJzq0+VvObXrCBdvRjkpa3Y4zICxC+c/cRJyJgGjwGvOJT8ruKDRj
 b7Xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cglEdq2PeS7x4xAbDaQ7LfBmDIPdRgT5jiJXP2Qm+0o1Mqrek8q010/UQ0N8Ah5+mKOn5xJw=@lists.denx.de
X-Gm-Message-State: AOJu0YyrkIx/dpggGmzgzIeZ5imIDd6LHpyHJYj7vaMjQgBt78eyPMeJ
 kzTDj7ErBJqEw1tPpNnUIlKUZVsp0iN4pi20HCAhMlE0wlk6KDmPNI5vsF2dsw==
X-Gm-Gg: AfdE7cmkH++EVRup96Sz8WthakdwmLnio1VbXHNoJoPaAwLfSiwZ/Y3DNd/omD0oTGb
 0KnKvcBhPDed1kqIhFTNOowivdOCNIGK0qHe2kdhf0fwjRL3ISem74kTxEGN6oL2N0SHLz9+xEG
 q3OI71uPqvA6GxljerysgAAzd/ToZDvbavtVvZW23uKZCKwxepfAbiOuJrjI+Zp5VVeACZGutgJ
 eFvG9E4NzocFmJszpBQPRKQhnxBL1WePzgvxPrcKD6yWCnLMGyB2I6/rrW0YTArnje4u4suZVt0
 bvhknhmQoxq+G+wDUp0oLX3ULQu/qN/oVyU/iOGsRxKMaqFiNXBgvQY/TfZZjk66V0XEV3jAWvV
 NMFhRF/XSUyz+agPdYNU0Tg+BA/jpqPeuc8X7W78/k3U4sB8d61iVO7bzIqD3THQcLZn8kH4wXk
 jmSzA1PDX0sagPd/J+i9SNqje8W8oZuIPD4bZ9RvnsG1gGIg0AMVEDAXaCnn4=
X-Received: by 2002:a05:7022:6626:b0:139:8172:76a6 with SMTP id
 a92af1059eb24-139dbaa5c0fmr5852449c88.1.1782485147996; 
 Fri, 26 Jun 2026 07:45:47 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:381f:62d1:5cfb:ac63])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d9105b57sm18823739c88.14.2026.06.26.07.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 07:45:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, sunil@amarulasolutions.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 4/5] roc-pc-plus-rk3399: Introduce new variant
Date: Fri, 26 Jun 2026 11:45:32 -0300
Message-ID: <20260626144533.2925490-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626144533.2925490-1-festevam@gmail.com>
References: <20260626144533.2925490-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

The roc-pc-plus-rk3399 board shares a lot of features with the
existing supported roc-pc-rk3399 board.

Its devicetree is also supported in the upstream kernel by the
rockchip/rk3399-roc-pc-plus.dts.

The plus variant has only a 12V supply and different USB circuitry.
It contains an XMC XM25QH128C SPI NOR flash.

Add support for the roc-pc-plus-rk3399 variant.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi | 9 +++++++++
 board/firefly/roc-pc-rk3399/MAINTAINERS     | 1 +
 configs/roc-pc-plus-rk3399_defconfig        | 4 ++++
 doc/board/rockchip/rockchip.rst             | 3 ++-
 4 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
 create mode 100644 configs/roc-pc-plus-rk3399_defconfig

diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
new file mode 100644
index 000000000000..7d5af3e234da
--- /dev/null
+++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3399-roc-pc-u-boot.dtsi"
+
+/delete-node/ &vcc_hub_en;
+
+&dc_12v {
+	/delete-property/ vin-supply;
+};
diff --git a/board/firefly/roc-pc-rk3399/MAINTAINERS b/board/firefly/roc-pc-rk3399/MAINTAINERS
index 2c0de4432fa8..d32b078431ab 100644
--- a/board/firefly/roc-pc-rk3399/MAINTAINERS
+++ b/board/firefly/roc-pc-rk3399/MAINTAINERS
@@ -5,5 +5,6 @@ S:	Maintained
 F:	board/firefly/roc-pc-rk3399
 F:	include/configs/roc-pc-rk3399.h
 F:	configs/roc-pc-rk3399_defconfig
+F:	configs/roc-pc-plus-rk3399_defconfig
 F:	configs/roc-pc-mezzanine-rk3399_defconfig
 F:	arch/arm/dts/rk3399-roc-pc*
diff --git a/configs/roc-pc-plus-rk3399_defconfig b/configs/roc-pc-plus-rk3399_defconfig
new file mode 100644
index 000000000000..4ec2f7d44b5f
--- /dev/null
+++ b/configs/roc-pc-plus-rk3399_defconfig
@@ -0,0 +1,4 @@
+#include <configs/roc-pc-rk3399_common.config>
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc-plus"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc-plus.dtb"
+CONFIG_SPI_FLASH_XMC=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index ae18b08031d2..b87d857a312e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -81,7 +81,8 @@ List of mainline supported Rockchip boards:
      - 96boards RK3399 Ficus (ficus-rk3399)
      - 96boards Rock960 (rock960-rk3399)
      - Firefly-RK3399 (firefly_rk3399)
-     - Firefly ROC-RK3399-PC
+     - Firefly ROC-RK3399-PC (roc-pc-rk3399)
+     - Firefly ROC-RK3399-PC Plus (roc-pc-plus-rk3399)
      - FriendlyElec NanoPC-T4 (nanopc-t4-rk3399)
      - FriendlyElec NanoPi M4 (nanopi-m4-rk3399)
      - FriendlyElec NanoPi M4B (nanopi-m4b-rk3399)
-- 
2.43.0

