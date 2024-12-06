Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8F9E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF8D89607;
	Fri,  6 Dec 2024 23:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JJXOJwsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF358870D; Fri,  6 Dec 2024 23:56:48 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4584889607
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4668486dec2so22188841cf.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525805; x=1734130605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZsByYhbybUJ/b9kHGU44fSVl2pF79dnrJpAYeV/jEA=;
 b=JJXOJwsk2oezF9NyMR3TOKzxYbA8pIFEt1q0/bFOA4Vfu+fy3jUnNohZkDYxQIWU8d
 yBSAVsWnQ9CoAsphA5PyXWfIbU6309HYzYHy6NAioFuWIUo0RYTGIXLc6G6i/tZdXIUv
 qYvBN3Do3RgqWpWCcxlSEC2J7q/PyAzhX+1KV+EOS/7DUuRfsP/1+xMmvh5E2Vx5XwSx
 Vok/B9r+74r/9g5kIY1N5hTUdN1GovAwR7bV9OXtj9ZxcsuRuws5nKJFEfOsKqe2s9Jl
 W3w0Ez0lnU3cgHrb4rjd7x2wpbVQunMsg9FajVYUDg6FkSAd/7cLSKWhG8203MN1XolE
 xqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525805; x=1734130605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZsByYhbybUJ/b9kHGU44fSVl2pF79dnrJpAYeV/jEA=;
 b=OenXJiyxpzVgVI8A9Qef84eDRF9BxwOgzKAZkEF8Y5IZTTkQrie92n83KmfZgioFHa
 AWY6Ag7//UYAOMXDQli2RHMRaE1Px/qvozi7Z0xqNR5STnrB50tmH7UE7eBqePtvfJg9
 3OGk8TVCb2l4TlVg5hwIq5N+EpokBSVEiG0G89joR783t0BPYOwUuEeus2vVHEurk3O4
 H0fU79WY1hEL4/0tChV4XtYnZthxamRnc7f2xyzTuk8k2ffBIu+XsUwqbwDR9BFwEwEA
 l0WRJrWk/WZ1+JnrfOOzNk5mVaF6gStEwOaVk11iquLsfvtJ96lVogaAw9woqZorTX95
 FyLw==
X-Gm-Message-State: AOJu0YybU3ZmiwfAiXDoxQeTWCYfn6xFqgK6M84gT87AqYIPWGgdquEJ
 duCIVEtyjxGSxjPiTEpo3/zftTI7BMDsFvudvj/zBNOjyzW2ogoi9wZ8HzxNtgQuLIwz9lR5Aat
 P
X-Gm-Gg: ASbGncv2JvtxDRiQ1H1j7GIzfrD4DnloxAnZns+onK51xwa80ffg4MOJ84y/dLw3PNl
 NatwrPDhU/E9Keo9CaxXjPL331HbOZDHuK3eVaQ416aRIQ244fi3VLQFdhqTtbCg5aFxl5esovq
 dDQUljQbdEu8iomhP5TXsWUK0dwUHb8KxCdivSX7ckWK4MKbvKXVVuyfQs70ZgWM3MpAERvdBu/
 Z/na3IwSXd9If1fsr5T6cpV/nPtrEQKijZRUe1xNute2JJ5oP5LaHjG/1Ikzwt11zxR0+0lQpRY
 IX7YjHpUKDm0sEnTb/z2kfA4sJ/h8nGRPvod8CRdGA5AHjPJ
X-Google-Smtp-Source: AGHT+IE3Sy3qzCHf3DEoSEwz/6n4KBTQKNDhS71MuYsuQoGsOAcsQE5BHQef3vS3O8e9Y7kMMr0MLw==
X-Received: by 2002:a05:622a:20e:b0:466:a0cf:b06c with SMTP id
 d75a77b69052e-46734fa95ecmr97377871cf.56.1733525804746; 
 Fri, 06 Dec 2024 14:56:44 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:56:43 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 08/10] armv8: Add generic smbios information into the
 device tree
Date: Fri,  6 Dec 2024 14:54:25 -0800
Message-Id: <20241206225438.13866-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206225438.13866-1-raymond.mao@linaro.org>
References: <20241206225438.13866-1-raymond.mao@linaro.org>
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

To run this with QEMU arm64, we need to dump the generated DTB
from QEMU first, merge it with the one we build and then re-run
QEMU with the merged DTB.
```
qemu-system-aarch64 -machine virt -machine dumpdtb=qemu.dtb
cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | \
  grep -v /dts-v1/) | dtc - -o merged.dtb
qemu-system-aarch64 -machine virt -nographic -bios u-boot.bin \
  -dtb merged.dtb
```
For details please take reference on dt_qemu.rst

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- Remove all "Not Specified" strings.
- Update the commit message.

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
index 00000000000..fc168317c9e
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
+				version = "";
+				serial = "";
+				wakeup-type = <SMBIOS_WAKEUP_TYPE_UNKNOWN>;
+				sku = "";
+				family = "armv8";
+			};
+
+			baseboard {
+				manufacturer = CONFIG_SYS_VENDOR;
+				product = CONFIG_SYS_BOARD;
+				version = "";
+				serial = "";
+				asset-tag = "";
+				chassis-location = "";
+				feature-flags = <SMBIOS_BOARD_FEAT_HOST_BOARD>;
+				board-type = <SMBIOS_BOARD_TYPE_MOTHERBOARD>;
+			};
+
+			chassis {
+				manufacturer = CONFIG_SYS_VENDOR;
+				version = "";
+				serial = "";
+				asset-tag = "";
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
+				version = "";
+				processor-type = <SMBIOS_PROCESSOR_TYPE_CENTRAL>;
+				processor-status = <SMBIOS_PROCESSOR_STATUS_ENABLED>;
+				upgrade = <SMBIOS_PROCESSOR_UPGRADE_NONE>;
+				family = <SMBIOS_PROCESSOR_FAMILY_EXT>;
+				family2 = <SMBIOS_PROCESSOR_FAMILY_ARMV8>;
+				socket-design = "";
+				serial = "";
+				asset-tag = "";
+				part-number = "";
+			};
+
+			cache {
+				l1-cache {
+					socket-design = "";
+					config = <(SMBIOS_CACHE_LEVEL_1 |
+						   SMBIOS_CACHE_ENABLED |
+						   SMBIOS_CACHE_OP_WB)>;
+				};
+
+				l2-cache {
+					socket-design = "";
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

