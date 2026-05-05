Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82A4FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E37984995;
	Tue,  5 May 2026 17:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ftheiVS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC9284951; Tue,  5 May 2026 17:48:58 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C09848B7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 17:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so85724395e9.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777996136; x=1778600936; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=39y7gNinOlLetUo96ETHbfB+81x37gGbV9+WWeJWJh4=;
 b=ftheiVS0IcrjKAK6OwCtk65Aa5mDg2IQcDSfoua2W+isOVz9dq9ehAGmWcSo5RDUT1
 pj7f7OmkKGRKzE9MTcZhgxuqfaN1ALWshdgSfsGld0md/rmGcr6/EuSOxt28Sc4g1mMM
 /VF3rnmOZdcp7WPC2EJbdsd4NlOL6+MA6dKQGm9wsib6z2kxl2pXGyL/J70vOBXcYw+c
 b2n1NnvReKp2v9f+DajwarR9L2xMiOw1oyaBsVOb6LlPGqzJ10VWDDuAov0k/0okjfqA
 vQGGnWKD0X84DQuqZ/sSlHUeKtVi/GMMGdJ2DATqfEWKH9Wo17T1vt/0JeTVHuQiIb+o
 Rxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777996136; x=1778600936;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=39y7gNinOlLetUo96ETHbfB+81x37gGbV9+WWeJWJh4=;
 b=IKGNZ8NDNTjm5kE3b+knKXCkjaH+OEsqSkz9mQCG0GVSoxp+TwvZlczKP62Pnzqsz0
 Yzydr6zBPUdiAUGy8V82mrLNTZ2i+Smp6jpDvdnnIYfnxxjDZ7e5MhOR5CvsHCbK13kq
 qQ/Yb1HKN1Hj4dt63d0wldlHav1TvD9qbipYK32CiYbLPS1EdDeSpRJmZBBv9fzBYdrP
 +3uAuczED/CdTJeK0Z9Kd7502ZgTTbxaClKJQ/z+PKgh2Jrkk00fnMFffWKL8MS7HR0M
 7jccC0OPUVzgx/TTbVVQGy21HrhltUSjLge2sJzu8A/Wl7ehlgv724g99P6uUcZTLAe2
 3TIQ==
X-Gm-Message-State: AOJu0YxGUFEu3Mvi0RS2TZvaNvFIh5VVmUTCIlXnsvDIVdi9oaEZAwCc
 9zwOk7UIxadoIYENMNyprMna9gQK2qGSTW2xJUewGSMAl8rHCCqTYdcQjJakJy2h8Rs=
X-Gm-Gg: AeBDieurB29k+JZ5OdmVsmtAmE91yXUlUmk+h0SRBeWkMmjQSYd/1R6hV6n9PQXscE/
 xsPuj5F/1r9VbzSixXsNbzzmpN6NBWXBj8q/9cy+FCr3pupWmyp+HoO+llk4r0gLDhiHkJ58kvt
 JavcETibeOPH/Q8cP1u9m70wKaRGB1DdBfWdKF/0b3tAkHWzwC/Np866sqDZpiSJt8NB1nKOE6v
 qCAANL4ENhdV5RRVGygUg/PmLyBdTafhCSUEuhxM03BZpS9UM9eoDrrueIiG7c2Rj65qslf/hjn
 GVuX6JgElyhnZsAkOGfSsNJk85XSlX5BzH1ARkwJGF2UZvVcgtBaU4aV0c5LNVB9AM2NnqL4qSE
 he8GvdK5V1v7qfhLkjraf4df+NvGibIfoz9QSbvV0fKvbV/bq7OP9AGnKPlCp8pptZYoTiruidG
 kB5P9Qg+bbyjTnVvmmR5TUcMivByAt5MEIqWslo1aAKVvb+zQ+8yfvZ/M5ZblSVs6pnotJYPmIu
 q3aCQ8=
X-Received: by 2002:a05:600c:a111:b0:488:a2ac:a34c with SMTP id
 5b1f17b1804b1-48a9863cde5mr171139505e9.12.1777996135585; 
 Tue, 05 May 2026 08:48:55 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d182ee923sm20305955e9.27.2026.05.05.08.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 08:48:55 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 05 May 2026 17:48:45 +0200
Subject: [PATCH v6 5/6] mach-snapdragon: add kconfig infra for building MBN
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-b4-qcom-tooling-improvements-v6-5-a5fb673f4af6@linaro.org>
References: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
In-Reply-To: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2455;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=xNBl772678bX3pMRK2ILHqAEnKdLM+zFZttaj+nLKJY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsxfgrGsCV+9Ty5Uj/+cne8o/IX/8aHNvh131k4KW/A2T
 atHR+ZZRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjI+R6Gv4L5Rdl5oQdE3SaV
 PC2Z9W9jHZdkQgxfYUD1RLe7LR4XOBgZJk8453n+1bvmy6I8c3c++rLqm1j4FIOnvYKLtE+kfm5
 eGAgA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add a qualcomm specific Makefile fragment to make u-boot.mbn a build
target and introduce a kconfig option to build it by default on relevant
platforms via CONFIG_BUILD_TARGET.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 Kconfig                          |  1 +
 arch/arm/mach-snapdragon/Kconfig | 11 +++++++++++
 board/qualcomm/config.mk         | 14 ++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/Kconfig b/Kconfig
index 8428d039a1c0..183c8096030d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -557,8 +557,9 @@ config BUILD_TARGET
 	default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_GEN5
 	default "u-boot.itb" if !BINMAN && SPL_LOAD_FIT && (ARCH_ROCKCHIP || \
 				RISCV || ARCH_ZYNQMP)
 	default "u-boot.kwb" if (ARCH_KIRKWOOD || ARMADA_32BIT) && !SPL
+	default "u-boot.mbn" if ARCH_SNAPDRAGON && QCOM_GENERATE_MBN
 	help
 	  Some SoCs need special image types (e.g. U-Boot binary
 	  with a special header) as build targets. By defining
 	  CONFIG_BUILD_TARGET in the SoC / board header, this
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index d3de8693b5a8..6329cbb9215e 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -41,5 +41,16 @@ config SYS_CONFIG_NAME
 	  This option contains information about board configuration name.
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config QCOM_GENERATE_MBN
+	bool "Generate an MBN-compatible ELF binary"
+	default n
+	help
+	  Enable this if you intend to flash U-Boot as a first-stage bootloader.
+	  The build system will generate a board-specific ELF file with the appropriate
+	  MBN hash segments and test keys.
+
+	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
+	  supported.
+
 endif
diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
new file mode 100644
index 000000000000..769e4a51ca01
--- /dev/null
+++ b/board/qualcomm/config.mk
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright Linaro Ltd.
+#
+# Qualcomm specific make target for MBN signed ELF files.
+#
+
+# Create Qualcomm signed elf images
+CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
+quiet_cmd_mkmbn = MBN     $@
+      cmd_mkmbn = $(CMD_MKMBN) $<
+
+u-boot.mbn: u-boot.bin FORCE
+	$(call if_changed,mkmbn)

-- 
2.53.0

