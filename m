Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E666CDD0E2
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C728925A;
	Tue, 22 Oct 2024 22:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zq9reYG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C75C88FA7; Tue, 22 Oct 2024 22:07:38 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC79E892B9
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5ebc1af9137so1387487eaf.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729627652; x=1730232452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPfQNLkT/bDmV8b01AR/XX1uyxB4r9XyRez3+hHeN7k=;
 b=Zq9reYG1GjH1hnhv5qcqOjst2pH948qjJ6H2IpStEfhzi80gohrQr6JyKzKqek44Gh
 lqjvCvM3KUnRXxu3/3cY8uzORBP64YFlz57Fs0DFhiVaQUB7+4um48BISz5Xl8fZfAnM
 UFXwBh4I1ro/DJnrwfv8TJpVIDWbW1YwvJjF6/6SJccbx1dR1JR1ucj9iIcNEmL5DAps
 6t3BXiPTbeSyf6dNkUE1TMyTTSRjQQ+pDvz7idxo9fM9XgzWfMaClJjSQNlUAov7bJeN
 UKGPkEqJZMxfba3moWwpNsPmTr62w4WxVXSy5JFs8AzfIRwvVaNKFTCe0K9vjIndaMZT
 bK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627652; x=1730232452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPfQNLkT/bDmV8b01AR/XX1uyxB4r9XyRez3+hHeN7k=;
 b=E5jNUbA/tx6tSVL6nL8HbunkIeCCU7HRPZTQFF3iSQyQ/YAQzJa+Wc+1Y8k4hijgBa
 fELs7M4e4i2HewVEkf6IkwpKxEWuQ0tm9M4hfNk9K+K1qQqcSDY5fy8MR5DSu/lSiFBF
 98MnMvhxnc5jbUNCYXpRwTCk2uV9CxJNrMGgJtWp6weODLm7A24h8VV2SfhKB/YnMjlU
 +Ncs9P8Nw54H7HBRwSx4IvUMWbi18x7uBdGqb3h+RPkwsbQcVGA5aMA9vgn/6+nWdE78
 302ojDMJ6XKqZJ0aamgByvCkEDblCCVT0C7/h/zq/tZZauu4V1Us3mY+4sdzgZ7DyFEf
 WaKA==
X-Gm-Message-State: AOJu0YwS4H1X//HBKLm+4BFY9hp9lWuvIBvRVezSYnLc0v/TBDE3c6o/
 S37YolnePFTOJAGN5FkwXp8Kl3k5wjmruw/zi3J2YJncfGExT2rdNWoIB9ZGOhsW2FnYtEz72MD
 D86M=
X-Google-Smtp-Source: AGHT+IEp0AADu9baCJjIhqNFzxUA/MCCEIPS7niZM5lkebwA258swixXnVPiYP5Xlr52yYKaK3pmKw==
X-Received: by 2002:a05:6358:783:b0:1bc:58bc:ff14 with SMTP id
 e5c5f4694b2df-1c3d80f8b75mr9549655d.10.1729627651933; 
 Tue, 22 Oct 2024 13:07:31 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a255sm32519956d6.59.2024.10.22.13.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 13:07:31 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org, marek.vasut+renesas@mailbox.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>, Jonas Karlman <jonas@kwiboo.se>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 6/8] armv8: Add generic smbios information into the device
 tree
Date: Tue, 22 Oct 2024 13:05:27 -0700
Message-Id: <20241022200543.116343-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022200543.116343-1-raymond.mao@linaro.org>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
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

Add common smbios information that can be used by all armv8
platforms and set it as default for qemu-arm64.
From now smbios library can load values from here for those fields
doesn't exist in the sysinfo driver.

To run this with QEMU arm64, please dump the generated DTB
from QEMU first, merge it with the one we build and then re-run
QEMU with the merged DTB.
```
qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | \
  grep -v /dts-v1/) | dtc - -o merged.dtb
qemu-system-arm -machine virt -nographic -bios u-boot.bin \
  -dtb merged.dtb
```
For details please take reference on dt_qemu.rst

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.

 arch/arm/dts/qemu-arm64.dts      |  4 ++
 arch/arm/dts/smbios_generic.dtsi | 82 ++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 arch/arm/dts/smbios_generic.dtsi

diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 096b3910728..95fcf53ed74 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -7,5 +7,9 @@
 
 /dts-v1/;
 
+#if defined(CONFIG_SYSINFO_SMBIOS) && !defined(QFW_SMBIOS)
+#include "smbios_generic.dtsi"
+#endif
+
 / {
 };
diff --git a/arch/arm/dts/smbios_generic.dtsi b/arch/arm/dts/smbios_generic.dtsi
new file mode 100644
index 00000000000..c9f07283403
--- /dev/null
+++ b/arch/arm/dts/smbios_generic.dtsi
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Default SMBIOS information for Arm64 platforms
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <config.h>
+#include <smbios_def.h>
+
+/ {
+	smbios {
+		compatible = "u-boot,sysinfo-smbios";
+
+		smbios {
+			system {
+				manufacturer = CONFIG_SYS_VENDOR;
+				product = CONFIG_SYS_BOARD;
+				version = "Not Specified";
+				serial = "Not Specified";
+				wakeup-type = <SMBIOS_WAKEUP_TYPE_UNKNOWN>;
+				sku = "Not Specified";
+				family = "armv8";
+			};
+
+			baseboard {
+				manufacturer = CONFIG_SYS_VENDOR;
+				product = CONFIG_SYS_BOARD;
+				version = "Not Specified";
+				serial = "Not Specified";
+				asset-tag = "Not Specified";
+				chassis-location = "Not Specified";
+				feature-flags = <SMBIOS_BOARD_FEAT_HOST_BOARD>;
+				board-type = <SMBIOS_BOARD_TYPE_MOTHERBOARD>;
+			};
+
+			chassis {
+				manufacturer = CONFIG_SYS_VENDOR;
+				version = "Not Specified";
+				serial = "Not Specified";
+				asset-tag = "Not Specified";
+				chassis-type = <SMBIOS_ENCLOSURE_DESKTOP>;
+				bootup-state = <SMBIOS_STATE_SAFE>;
+				power-supply-state = <SMBIOS_STATE_SAFE>;
+				thermal-state = <SMBIOS_STATE_SAFE>;
+				security-status = <SMBIOS_SECURITY_NONE>;
+				oem-defined = <SMBIOS_ENCLOSURE_OEM_UND>;
+				height = <SMBIOS_ENCLOSURE_HEIGHT_UND>;
+				number-of-power-cords = <SMBIOS_POWCORD_NUM_UND>;
+			};
+
+			processor {
+				version = "Not Specified";
+				processor-type = <SMBIOS_PROCESSOR_TYPE_CENTRAL>;
+				processor-status = <SMBIOS_PROCESSOR_STATUS_ENABLED>;
+				upgrade = <SMBIOS_PROCESSOR_UPGRADE_NONE>;
+				family = <SMBIOS_PROCESSOR_FAMILY_EXT>;
+				family2 = <SMBIOS_PROCESSOR_FAMILY_ARMV8>;
+				socket-design = "Not Specified";
+				serial = "Not Specified";
+				asset-tag = "Not Specified";
+				part-number = "Not Specified";
+			};
+
+			cache {
+				l1-cache {
+					socket-design = "Not Specified";
+					config = <(SMBIOS_CACHE_LEVEL_1 |
+						   SMBIOS_CACHE_ENABLED |
+						   SMBIOS_CACHE_OP_WB)>;
+				};
+
+				l2-cache {
+					socket-design = "Not Specified";
+					config = <(SMBIOS_CACHE_LEVEL_2 |
+						   SMBIOS_CACHE_ENABLED |
+						   SMBIOS_CACHE_OP_WB)>;
+				};
+			};
+		};
+	};
+};
-- 
2.25.1

