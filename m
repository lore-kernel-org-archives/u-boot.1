Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFDBCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E95B83A91;
	Mon, 11 May 2026 15:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EyJuBhmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0309884666; Mon, 11 May 2026 15:58:01 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85BC48394E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bccb9dca1beso303330966b.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507878; x=1779112678; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=39y7gNinOlLetUo96ETHbfB+81x37gGbV9+WWeJWJh4=;
 b=EyJuBhmUE539FOSJvPhI9ai5/PZL0qnxeaOcd0uLzy+EqxoDOUdcFbY7n7tW6mGR2j
 bkJjNLecrAx2BfBmQ6Rgoag9cJuxNjeJrd+m0BtkU/d9+ldK8cPAtZ50QfAvJJuzzs2C
 lCuHKh0+fgOKyESKZiQr2x/pMshLOIGiIfHPyfX07JWtpUPTA0+cHdhyIdNtBL+t+xDu
 LWUtlwnuyd8QesesZirM4g2U9kMAZjRyG6zvD3+z/WwckBFgeGKirj7IVRHq6/kJYBxe
 iz+RykYDNM695Xh5m6n1zGTe5KSnSU/0qeQjKZk8hrrUN6rRTFNxYYROpVbu3eKFHqZw
 HsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507878; x=1779112678;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=39y7gNinOlLetUo96ETHbfB+81x37gGbV9+WWeJWJh4=;
 b=TyRw5MS+aqwzF3wCLgi58aFurt8wholxONl6leWaKuzftYE2NZoAD/pMCeldWdPCVp
 H7Y6kJf3WgdHFEWgAmR3PURQ7BQNd245m4w3DyIg57aMbp2ecC8gLbXhQAYDKdnzi+Km
 /TmelT4W8Y/Acab0V3lN+E9hdcAIrREn1ZyTZBXK7fQUADQ+fIsqh0sDpDKLkzqxUNd7
 DfBkDlPJ8+1NHNUkDqRYuW1zo3ZCC2VGv1A7OIPfUgWJ2K+AZlnjLpGB2NZNNd4pY+8V
 zfDLMV5E4TNHQahCePHeBNKhisEprSJrkqQmXLxlXhmTVtC/84ZaRYgZNc6Xn/Cewa4C
 5m+Q==
X-Gm-Message-State: AOJu0YwKHFITptkb6WfRezVWXerhBvzJs35UQ2y/EAYurMDL1OUXAgTA
 lVNRWDmA0fRavc0sDTmXNk3IfQ0svdCzByPYtQyZrDZ7UGrT0bQpctqj+6WQeCL+OUI=
X-Gm-Gg: Acq92OEELhm10x4WJNzxSrKUoLINoTXdJzVptrx7I4nKN5ZmZ1tFPzgDobinCEfGfTf
 P9ecDnkMmBankpZW91quQ6hjiN9KZCeR8f6FxO3WGrwKw78aFxF3DMiVo27EZnwAYIvk3+xoScf
 H27tlNx6cDMCfPjgJ4N3cQe4YtIFq2saBljMHE3ByCoebQZiuI2FupRjDgJ5GvjDO/q3oOIafj6
 SvflkYgjE40x6GRuzRFk6b3GqujAnrj+exkMuLk+FLmBdOvNoKWoDUsvsXC+1P6YXHvJZpoWPft
 pzSHDHvooZ+lKfTw+NKeOe2W3dz7s6UE5VFjSNX+G/0DnzG1myAzWfVmRkDvSdrhAvwwWK9Wx3p
 kWsGlU8SNO0TfQxIB2Csx2QkoK0ssOwlkqdwpRxA6IetEVy140IolDTLL8ViNHaSVm70M6+Supa
 eB+w40Y0sYg8DNOOuIZhjpww9CPDloZVjmhQrzBVnyWlWvgKbIFtB8qaltSdIaJPdjB8fxZrqV/
 B2C1OA=
X-Received: by 2002:a17:907:803:b0:bcc:d9d:c228 with SMTP id
 a640c23a62f3a-bcc121552efmr532563966b.10.1778507878001; 
 Mon, 11 May 2026 06:57:58 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0dfd34fsm3805377a12.14.2026.05.11.06.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:57:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 11 May 2026 15:57:47 +0200
Subject: [PATCH v7 5/6] mach-snapdragon: add kconfig infra for building MBN
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-b4-qcom-tooling-improvements-v7-5-0c06346e79a9@linaro.org>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizGB7F3as4eO3Txq0bOn5NXupQzj5tf+nRYfqPEZf2vq
 ktTbsms6ChlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATqedgZJjAYSv4bcbR2z80
 4nyT997Ldw3UcpweP0EuR3WSjGji7FcMf7g1Zt6sS5Lg7WDbKFwW+pCh7PITG5PS+2lcq6rfczs
 xOQMA
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

