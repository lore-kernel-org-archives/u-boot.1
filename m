Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC93C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87EBE878B3;
	Mon,  4 Dec 2023 09:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jL4i8jtu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90AA5870A0; Mon,  4 Dec 2023 09:02:53 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24244878A9
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50be24167efso2215916e87.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701676970; x=1702281770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHnECvDM512DR20/+GXvFlIpxRIVSmc+w5I3t8N03V4=;
 b=jL4i8jtuKFgkXy7wVaRzi/TQQqQiTF3JqgSbQ915AOPWgOxOvF/+4fIMeo4hn0EQXp
 TzXuACAxvAWMBZdyr2vDNuutErbceALnuGnHHkVYR6ZIb0W9A4aNAVMlhITmAEgGn+ai
 wDGRGl5UIxfpvjQZN8vFRqltG3rxmnIhZwJcW0k4KOVvd+tmobN6Q+LR6nO/XxB9emaQ
 l07D5fzdog5RJzgp72VnfubSDHZJSOMgg+T/LMg/dSJZr0KTc0byT36I3A7JI3JjJn9e
 rhUjlrsddXkwCUdgSvJp394uSdYS597ftOwINijg/UOqPDcMmkrmPWZ1MLLFwfnkCsFk
 g2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701676970; x=1702281770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHnECvDM512DR20/+GXvFlIpxRIVSmc+w5I3t8N03V4=;
 b=iInY2PjNrQoRnrUzHcohlQKpnDhLNIUcu9u3iX6wq+z+68z/d+i3hsWOk0qdh1xB5L
 +WlOz+baz55zBR4yMyyb06dR1ktE3dDPrhaYuRcKPgI7C78SGYP9rHxSMvTwESfCeaQb
 l5PAJwojByWADrc21pJHlrDSbq0KvpJGtW1eyhJiCiasOxpHWRVE0nuNSOZ5Z8xxxqtb
 7RdC0L+XkN1CyvIZkFu7+G2kRvtEoQhNftSXOR3eOTJ4qFWIXkw/T8rLC52efKMcKzA5
 X4WbV6jd7jeR7T7tBL55yjQiHIda0f/WH8eok3bKBpxWo2uv2EiZ6KegTXce2F/51ZIw
 XcIg==
X-Gm-Message-State: AOJu0YwI97xQSqQS6AFmKWBJjywjoJOTPF+8r4uX6vAYz/iXq/sp0dIX
 bnssiphAiGI57Zwpn4Xplhg=
X-Google-Smtp-Source: AGHT+IHQEgVXOboI8GeE6T8G06UWjQ7WfVO7t8eMKou7QP2VsE7w/Hf90UxoNO9TSJb+rp1HPtqeKQ==
X-Received: by 2002:a05:6512:124e:b0:50b:fc46:371f with SMTP id
 fb14-20020a056512124e00b0050bfc46371fmr121620lfb.8.1701676970268; 
 Mon, 04 Dec 2023 00:02:50 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 v6-20020ac25606000000b0050572fcf1a2sm1183048lfd.283.2023.12.04.00.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:02:49 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] video: tegra20: dsi: add T114 support
Date: Mon,  4 Dec 2023 10:02:31 +0200
Message-Id: <20231204080231.4316-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204080231.4316-1-clamor95@gmail.com>
References: <20231204080231.4316-1-clamor95@gmail.com>
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

Existing Tegra DSI driver mostly fits T114 apart MIPI calibration
which on T114 has dedicated driver. To resolve this MIPI calibration
logic was split for pre-T114 and T114+ devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/dsi.h   | 235 ++++++++++++++++++++++++
 arch/arm/include/asm/arch-tegra30/dsi.h | 211 +--------------------
 drivers/video/tegra20/tegra-dsi.c       |  78 +++++++-
 3 files changed, 313 insertions(+), 211 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra/dsi.h

diff --git a/arch/arm/include/asm/arch-tegra/dsi.h b/arch/arm/include/asm/arch-tegra/dsi.h
new file mode 100644
index 0000000000..0a399d8d51
--- /dev/null
+++ b/arch/arm/include/asm/arch-tegra/dsi.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *  (C) Copyright 2010
+ *  NVIDIA Corporation <www.nvidia.com>
+ */
+
+#ifndef __ASM_ARCH_TEGRA_DSI_H
+#define __ASM_ARCH_TEGRA_DSI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+/* Register definitions for the Tegra display serial interface */
+
+/* DSI syncpoint register 0x000 ~ 0x002 */
+struct dsi_syncpt_reg {
+	/* Address 0x000 ~ 0x002 */
+	uint incr_syncpt;		/* _INCR_SYNCPT_0 */
+	uint incr_syncpt_ctrl;		/* _INCR_SYNCPT_CNTRL_0 */
+	uint incr_syncpt_err;		/* _INCR_SYNCPT_ERROR_0 */
+};
+
+/* DSI misc register 0x008 ~ 0x015 */
+struct dsi_misc_reg {
+	/* Address 0x008 ~ 0x015 */
+	uint ctxsw;			/* _CTXSW_0 */
+	uint dsi_rd_data;		/* _DSI_RD_DATA_0 */
+	uint dsi_wr_data;		/* _DSI_WR_DATA_0 */
+	uint dsi_pwr_ctrl;		/* _DSI_POWER_CONTROL_0 */
+	uint int_enable;		/* _INT_ENABLE_0 */
+	uint int_status;		/* _INT_STATUS_0 */
+	uint int_mask;			/* _INT_MASK_0 */
+	uint host_dsi_ctrl;		/* _HOST_DSI_CONTROL_0 */
+	uint dsi_ctrl;			/* _DSI_CONTROL_0 */
+	uint dsi_sol_delay;		/* _DSI_SOL_DELAY_0 */
+	uint dsi_max_threshold;		/* _DSI_MAX_THRESHOLD_0 */
+	uint dsi_trigger;		/* _DSI_TRIGGER_0 */
+	uint dsi_tx_crc;		/* _DSI_TX_CRC_0 */
+	uint dsi_status;		/* _DSI_STATUS_0 */
+};
+
+/* DSI init sequence register 0x01a ~ 0x022 */
+struct dsi_init_seq_reg {
+	/* Address 0x01a ~ 0x022 */
+	uint dsi_init_seq_ctrl;		/* _DSI_INIT_SEQ_CONTROL_0 */
+	uint dsi_init_seq_data_0;	/* _DSI_INIT_SEQ_DATA_0_0 */
+	uint dsi_init_seq_data_1;	/* _DSI_INIT_SEQ_DATA_1_0 */
+	uint dsi_init_seq_data_2;	/* _DSI_INIT_SEQ_DATA_2_0 */
+	uint dsi_init_seq_data_3;	/* _DSI_INIT_SEQ_DATA_3_0 */
+	uint dsi_init_seq_data_4;	/* _DSI_INIT_SEQ_DATA_4_0 */
+	uint dsi_init_seq_data_5;	/* _DSI_INIT_SEQ_DATA_5_0 */
+	uint dsi_init_seq_data_6;	/* _DSI_INIT_SEQ_DATA_6_0 */
+	uint dsi_init_seq_data_7;	/* _DSI_INIT_SEQ_DATA_7_0 */
+};
+
+/* DSI packet sequence register 0x023 ~ 0x02e */
+struct dsi_pkt_seq_reg {
+	/* Address 0x023 ~ 0x02e */
+	uint dsi_pkt_seq_0_lo;		/* _DSI_PKT_SEQ_0_LO_0 */
+	uint dsi_pkt_seq_0_hi;		/* _DSI_PKT_SEQ_0_HI_0 */
+	uint dsi_pkt_seq_1_lo;		/* _DSI_PKT_SEQ_1_LO_0 */
+	uint dsi_pkt_seq_1_hi;		/* _DSI_PKT_SEQ_1_HI_0 */
+	uint dsi_pkt_seq_2_lo;		/* _DSI_PKT_SEQ_2_LO_0 */
+	uint dsi_pkt_seq_2_hi;		/* _DSI_PKT_SEQ_2_HI_0 */
+	uint dsi_pkt_seq_3_lo;		/* _DSI_PKT_SEQ_3_LO_0 */
+	uint dsi_pkt_seq_3_hi;		/* _DSI_PKT_SEQ_3_HI_0 */
+	uint dsi_pkt_seq_4_lo;		/* _DSI_PKT_SEQ_4_LO_0 */
+	uint dsi_pkt_seq_4_hi;		/* _DSI_PKT_SEQ_4_HI_0 */
+	uint dsi_pkt_seq_5_lo;		/* _DSI_PKT_SEQ_5_LO_0 */
+	uint dsi_pkt_seq_5_hi;		/* _DSI_PKT_SEQ_5_HI_0 */
+};
+
+/* DSI packet length register 0x033 ~ 0x037 */
+struct dsi_pkt_len_reg {
+	/* Address 0x033 ~ 0x037 */
+	uint dsi_dcs_cmds;		/* _DSI_DCS_CMDS_0 */
+	uint dsi_pkt_len_0_1;		/* _DSI_PKT_LEN_0_1_0 */
+	uint dsi_pkt_len_2_3;		/* _DSI_PKT_LEN_2_3_0 */
+	uint dsi_pkt_len_4_5;		/* _DSI_PKT_LEN_4_5_0 */
+	uint dsi_pkt_len_6_7;		/* _DSI_PKT_LEN_6_7_0 */
+};
+
+/* DSI PHY timing register 0x03c ~ 0x03f */
+struct dsi_timing_reg {
+	/* Address 0x03c ~ 0x03f */
+	uint dsi_phy_timing_0;		/* _DSI_PHY_TIMING_0_0 */
+	uint dsi_phy_timing_1;		/* _DSI_PHY_TIMING_1_0 */
+	uint dsi_phy_timing_2;		/* _DSI_PHY_TIMING_2_0 */
+	uint dsi_bta_timing;		/* _DSI_BTA_TIMING_0 */
+};
+
+/* DSI timeout register 0x044 ~ 0x046 */
+struct dsi_timeout_reg {
+	/* Address 0x044 ~ 0x046 */
+	uint dsi_timeout_0;		/* _DSI_TIMEOUT_0_0 */
+	uint dsi_timeout_1;		/* _DSI_TIMEOUT_1_0 */
+	uint dsi_to_tally;		/* _DSI_TO_TALLY_0 */
+};
+
+/* DSI PAD control register 0x04b ~ 0x04e */
+struct dsi_pad_ctrl_reg {
+	/* Address 0x04b ~ 0x04e */
+	uint pad_ctrl;			/* _PAD_CONTROL_0 */
+	uint pad_ctrl_cd;		/* _PAD_CONTROL_CD_0 */
+	uint pad_cd_status;		/* _PAD_CD_STATUS_0 */
+	uint dsi_vid_mode_control;	/* _DSI_VID_MODE_CONTROL_0 */
+	uint pad_ctrl_1;		/* _PAD_CONTROL_1 */
+	uint pad_ctrl_2;		/* _PAD_CONTROL_2 */
+	uint pad_ctrl_3;		/* _PAD_CONTROL_3 */
+	uint pad_ctrl_4;		/* _PAD_CONTROL_4 */
+};
+
+/* Display Serial Interface (DSI_) regs */
+struct dsi_ctlr {
+	struct dsi_syncpt_reg syncpt;	/* SYNCPT register 0x000 ~ 0x002 */
+	uint reserved0[5];		/* reserved_0[5] */
+
+	struct dsi_misc_reg misc;	/* MISC register 0x008 ~ 0x015 */
+	uint reserved1[4];		/* reserved_1[4] */
+
+	struct dsi_init_seq_reg init;	/* INIT register 0x01a ~ 0x022 */
+	struct dsi_pkt_seq_reg pkt;	/* PKT register 0x023 ~ 0x02e */
+	uint reserved2[4];		/* reserved_2[4] */
+
+	struct dsi_pkt_len_reg len;	/* LEN registers 0x033 ~ 0x037 */
+	uint reserved3[4];		/* reserved_3[4] */
+
+	struct dsi_timing_reg ptiming;	/* TIMING registers 0x03c ~ 0x03f */
+	uint reserved4[4];		/* reserved_4[4] */
+
+	struct dsi_timeout_reg timeout;	/* TIMEOUT registers 0x044 ~ 0x046 */
+	uint reserved5[4];		/* reserved_5[4] */
+
+	struct dsi_pad_ctrl_reg pad;	/* PAD registers 0x04b ~ 0x04e */
+};
+
+#define DSI_POWER_CONTROL_ENABLE	BIT(0)
+
+#define DSI_HOST_CONTROL_FIFO_RESET	BIT(21)
+#define DSI_HOST_CONTROL_CRC_RESET	BIT(20)
+#define DSI_HOST_CONTROL_TX_TRIG_SOL	(0 << 12)
+#define DSI_HOST_CONTROL_TX_TRIG_FIFO	(1 << 12)
+#define DSI_HOST_CONTROL_TX_TRIG_HOST	(2 << 12)
+#define DSI_HOST_CONTROL_RAW		BIT(6)
+#define DSI_HOST_CONTROL_HS		BIT(5)
+#define DSI_HOST_CONTROL_FIFO_SEL	BIT(4)
+#define DSI_HOST_CONTROL_IMM_BTA	BIT(3)
+#define DSI_HOST_CONTROL_PKT_BTA	BIT(2)
+#define DSI_HOST_CONTROL_CS		BIT(1)
+#define DSI_HOST_CONTROL_ECC		BIT(0)
+
+#define DSI_CONTROL_HS_CLK_CTRL		BIT(20)
+#define DSI_CONTROL_CHANNEL(c)		(((c) & 0x3) << 16)
+#define DSI_CONTROL_FORMAT(f)		(((f) & 0x3) << 12)
+#define DSI_CONTROL_TX_TRIG(x)		(((x) & 0x3) <<  8)
+#define DSI_CONTROL_LANES(n)		(((n) & 0x3) <<  4)
+#define DSI_CONTROL_DCS_ENABLE		BIT(3)
+#define DSI_CONTROL_SOURCE(s)		(((s) & 0x1) <<  2)
+#define DSI_CONTROL_VIDEO_ENABLE	BIT(1)
+#define DSI_CONTROL_HOST_ENABLE		BIT(0)
+
+#define DSI_TRIGGER_HOST		BIT(1)
+#define DSI_TRIGGER_VIDEO		BIT(0)
+
+#define DSI_STATUS_IDLE			BIT(10)
+#define DSI_STATUS_UNDERFLOW		BIT(9)
+#define DSI_STATUS_OVERFLOW		BIT(8)
+
+#define DSI_TIMING_FIELD(value, period, hwinc) \
+	((DIV_ROUND_CLOSEST(value, period) - (hwinc)) & 0xff)
+
+#define DSI_TIMEOUT_LRX(x)		(((x) & 0xffff) << 16)
+#define DSI_TIMEOUT_HTX(x)		(((x) & 0xffff) <<  0)
+#define DSI_TIMEOUT_PR(x)		(((x) & 0xffff) << 16)
+#define DSI_TIMEOUT_TA(x)		(((x) & 0xffff) <<  0)
+
+#define DSI_TALLY_TA(x)			(((x) & 0xff) << 16)
+#define DSI_TALLY_LRX(x)		(((x) & 0xff) <<  8)
+#define DSI_TALLY_HTX(x)		(((x) & 0xff) <<  0)
+
+#define DSI_PAD_CONTROL_PAD_PULLDN_ENAB(x)	(((x) & 0x1) << 28)
+#define DSI_PAD_CONTROL_PAD_SLEWUPADJ(x)	(((x) & 0x7) << 24)
+#define DSI_PAD_CONTROL_PAD_SLEWDNADJ(x)	(((x) & 0x7) << 20)
+#define DSI_PAD_CONTROL_PAD_PREEMP_EN(x)	(((x) & 0x1) << 19)
+#define DSI_PAD_CONTROL_PAD_PDIO_CLK(x)		(((x) & 0x1) << 18)
+#define DSI_PAD_CONTROL_PAD_PDIO(x)		(((x) & 0x3) << 16)
+#define DSI_PAD_CONTROL_PAD_LPUPADJ(x)		(((x) & 0x3) << 14)
+#define DSI_PAD_CONTROL_PAD_LPDNADJ(x)		(((x) & 0x3) << 12)
+
+#define DSI_PAD_CONTROL_VS1_PDIO(x)	(((x) & 0xf) <<  0)
+#define DSI_PAD_CONTROL_VS1_PULLDN(x)	(((x) & 0xf) << 16)
+
+#define DSI_PAD_OUT_CLK(x)		(((x) & 0x7) <<  0)
+#define DSI_PAD_LP_DN(x)		(((x) & 0x7) <<  4)
+#define DSI_PAD_LP_UP(x)		(((x) & 0x7) <<  8)
+#define DSI_PAD_SLEW_DN(x)		(((x) & 0x7) << 12)
+#define DSI_PAD_SLEW_UP(x)		(((x) & 0x7) << 16)
+
+#define DSI_PAD_PREEMP_PD_CLK(x)	(((x) & 0x3) << 12)
+#define DSI_PAD_PREEMP_PU_CLK(x)	(((x) & 0x3) << 8)
+#define DSI_PAD_PREEMP_PD(x)		(((x) & 0x3) << 4)
+#define DSI_PAD_PREEMP_PU(x)		(((x) & 0x3) << 0)
+
+/*
+ * pixel format as used in the DSI_CONTROL_FORMAT field
+ */
+enum tegra_dsi_format {
+	TEGRA_DSI_FORMAT_16P,
+	TEGRA_DSI_FORMAT_18NP,
+	TEGRA_DSI_FORMAT_18P,
+	TEGRA_DSI_FORMAT_24P,
+};
+
+/* DSI calibration in VI region */
+#define TEGRA_VI_BASE			0x54080000
+
+#define CSI_CILA_MIPI_CAL_CONFIG_0	0x22a
+#define  MIPI_CAL_TERMOSA(x)		(((x) & 0x1f) << 0)
+
+#define CSI_CILB_MIPI_CAL_CONFIG_0	0x22b
+#define  MIPI_CAL_TERMOSB(x)		(((x) & 0x1f) << 0)
+
+#define CSI_CIL_PAD_CONFIG		0x229
+#define  PAD_CIL_PDVREG(x)		(((x) & 0x01) << 1)
+
+#define CSI_DSI_MIPI_CAL_CONFIG		0x234
+#define  MIPI_CAL_HSPDOSD(x)		(((x) & 0x1f) << 16)
+#define  MIPI_CAL_HSPUOSD(x)		(((x) & 0x1f) << 8)
+
+#define CSI_MIPIBIAS_PAD_CONFIG		0x235
+#define  PAD_DRIV_DN_REF(x)		(((x) & 0x7) << 16)
+#define  PAD_DRIV_UP_REF(x)		(((x) & 0x7) << 8)
+
+#endif /* __ASM_ARCH_TEGRA_DSI_H */
diff --git a/arch/arm/include/asm/arch-tegra30/dsi.h b/arch/arm/include/asm/arch-tegra30/dsi.h
index 7ade132613..811617cd49 100644
--- a/arch/arm/include/asm/arch-tegra30/dsi.h
+++ b/arch/arm/include/asm/arch-tegra30/dsi.h
@@ -4,214 +4,9 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#ifndef __ASM_ARCH_TEGRA_DSI_H
-#define __ASM_ARCH_TEGRA_DSI_H
+#ifndef __ASM_ARCH_TEGRA30_DSI_H
+#define __ASM_ARCH_TEGRA30_DSI_H
 
-#ifndef __ASSEMBLY__
-#include <linux/bitops.h>
-#endif
-
-/* Register definitions for the Tegra display serial interface */
-
-/* DSI syncpoint register 0x000 ~ 0x002 */
-struct dsi_syncpt_reg {
-	/* Address 0x000 ~ 0x002 */
-	uint incr_syncpt;		/* _INCR_SYNCPT_0 */
-	uint incr_syncpt_ctrl;		/* _INCR_SYNCPT_CNTRL_0 */
-	uint incr_syncpt_err;		/* _INCR_SYNCPT_ERROR_0 */
-};
-
-/* DSI misc register 0x008 ~ 0x015 */
-struct dsi_misc_reg {
-	/* Address 0x008 ~ 0x015 */
-	uint ctxsw;			/* _CTXSW_0 */
-	uint dsi_rd_data;		/* _DSI_RD_DATA_0 */
-	uint dsi_wr_data;		/* _DSI_WR_DATA_0 */
-	uint dsi_pwr_ctrl;		/* _DSI_POWER_CONTROL_0 */
-	uint int_enable;		/* _INT_ENABLE_0 */
-	uint int_status;		/* _INT_STATUS_0 */
-	uint int_mask;			/* _INT_MASK_0 */
-	uint host_dsi_ctrl;		/* _HOST_DSI_CONTROL_0 */
-	uint dsi_ctrl;			/* _DSI_CONTROL_0 */
-	uint dsi_sol_delay;		/* _DSI_SOL_DELAY_0 */
-	uint dsi_max_threshold;		/* _DSI_MAX_THRESHOLD_0 */
-	uint dsi_trigger;		/* _DSI_TRIGGER_0 */
-	uint dsi_tx_crc;		/* _DSI_TX_CRC_0 */
-	uint dsi_status;		/* _DSI_STATUS_0 */
-};
-
-/* DSI init sequence register 0x01a ~ 0x022 */
-struct dsi_init_seq_reg {
-	/* Address 0x01a ~ 0x022 */
-	uint dsi_init_seq_ctrl;		/* _DSI_INIT_SEQ_CONTROL_0 */
-	uint dsi_init_seq_data_0;	/* _DSI_INIT_SEQ_DATA_0_0 */
-	uint dsi_init_seq_data_1;	/* _DSI_INIT_SEQ_DATA_1_0 */
-	uint dsi_init_seq_data_2;	/* _DSI_INIT_SEQ_DATA_2_0 */
-	uint dsi_init_seq_data_3;	/* _DSI_INIT_SEQ_DATA_3_0 */
-	uint dsi_init_seq_data_4;	/* _DSI_INIT_SEQ_DATA_4_0 */
-	uint dsi_init_seq_data_5;	/* _DSI_INIT_SEQ_DATA_5_0 */
-	uint dsi_init_seq_data_6;	/* _DSI_INIT_SEQ_DATA_6_0 */
-	uint dsi_init_seq_data_7;	/* _DSI_INIT_SEQ_DATA_7_0 */
-};
-
-/* DSI packet sequence register 0x023 ~ 0x02e */
-struct dsi_pkt_seq_reg {
-	/* Address 0x023 ~ 0x02e */
-	uint dsi_pkt_seq_0_lo;		/* _DSI_PKT_SEQ_0_LO_0 */
-	uint dsi_pkt_seq_0_hi;		/* _DSI_PKT_SEQ_0_HI_0 */
-	uint dsi_pkt_seq_1_lo;		/* _DSI_PKT_SEQ_1_LO_0 */
-	uint dsi_pkt_seq_1_hi;		/* _DSI_PKT_SEQ_1_HI_0 */
-	uint dsi_pkt_seq_2_lo;		/* _DSI_PKT_SEQ_2_LO_0 */
-	uint dsi_pkt_seq_2_hi;		/* _DSI_PKT_SEQ_2_HI_0 */
-	uint dsi_pkt_seq_3_lo;		/* _DSI_PKT_SEQ_3_LO_0 */
-	uint dsi_pkt_seq_3_hi;		/* _DSI_PKT_SEQ_3_HI_0 */
-	uint dsi_pkt_seq_4_lo;		/* _DSI_PKT_SEQ_4_LO_0 */
-	uint dsi_pkt_seq_4_hi;		/* _DSI_PKT_SEQ_4_HI_0 */
-	uint dsi_pkt_seq_5_lo;		/* _DSI_PKT_SEQ_5_LO_0 */
-	uint dsi_pkt_seq_5_hi;		/* _DSI_PKT_SEQ_5_HI_0 */
-};
-
-/* DSI packet length register 0x033 ~ 0x037 */
-struct dsi_pkt_len_reg {
-	/* Address 0x033 ~ 0x037 */
-	uint dsi_dcs_cmds;		/* _DSI_DCS_CMDS_0 */
-	uint dsi_pkt_len_0_1;		/* _DSI_PKT_LEN_0_1_0 */
-	uint dsi_pkt_len_2_3;		/* _DSI_PKT_LEN_2_3_0 */
-	uint dsi_pkt_len_4_5;		/* _DSI_PKT_LEN_4_5_0 */
-	uint dsi_pkt_len_6_7;		/* _DSI_PKT_LEN_6_7_0 */
-};
-
-/* DSI PHY timing register 0x03c ~ 0x03f */
-struct dsi_timing_reg {
-	/* Address 0x03c ~ 0x03f */
-	uint dsi_phy_timing_0;		/* _DSI_PHY_TIMING_0_0 */
-	uint dsi_phy_timing_1;		/* _DSI_PHY_TIMING_1_0 */
-	uint dsi_phy_timing_2;		/* _DSI_PHY_TIMING_2_0 */
-	uint dsi_bta_timing;		/* _DSI_BTA_TIMING_0 */
-};
-
-/* DSI timeout register 0x044 ~ 0x046 */
-struct dsi_timeout_reg {
-	/* Address 0x044 ~ 0x046 */
-	uint dsi_timeout_0;		/* _DSI_TIMEOUT_0_0 */
-	uint dsi_timeout_1;		/* _DSI_TIMEOUT_1_0 */
-	uint dsi_to_tally;		/* _DSI_TO_TALLY_0 */
-};
-
-/* DSI PAD control register 0x04b ~ 0x04e */
-struct dsi_pad_ctrl_reg {
-	/* Address 0x04b ~ 0x04e */
-	uint pad_ctrl;			/* _PAD_CONTROL_0 */
-	uint pad_ctrl_cd;		/* _PAD_CONTROL_CD_0 */
-	uint pad_cd_status;		/* _PAD_CD_STATUS_0 */
-	uint dsi_vid_mode_control;	/* _DSI_VID_MODE_CONTROL_0 */
-};
-
-/* Display Serial Interface (DSI_) regs */
-struct dsi_ctlr {
-	struct dsi_syncpt_reg syncpt;	/* SYNCPT register 0x000 ~ 0x002 */
-	uint reserved0[5];		/* reserved_0[5] */
-
-	struct dsi_misc_reg misc;	/* MISC register 0x008 ~ 0x015 */
-	uint reserved1[4];		/* reserved_1[4] */
-
-	struct dsi_init_seq_reg init;	/* INIT register 0x01a ~ 0x022 */
-	struct dsi_pkt_seq_reg pkt;	/* PKT register 0x023 ~ 0x02e */
-	uint reserved2[4];		/* reserved_2[4] */
-
-	struct dsi_pkt_len_reg len;	/* LEN registers 0x033 ~ 0x037 */
-	uint reserved3[4];		/* reserved_3[4] */
-
-	struct dsi_timing_reg ptiming;	/* TIMING registers 0x03c ~ 0x03f */
-	uint reserved4[4];		/* reserved_4[4] */
-
-	struct dsi_timeout_reg timeout;	/* TIMEOUT registers 0x044 ~ 0x046 */
-	uint reserved5[4];		/* reserved_5[4] */
-
-	struct dsi_pad_ctrl_reg pad;	/* PAD registers 0x04b ~ 0x04e */
-};
-
-#define DSI_POWER_CONTROL_ENABLE	BIT(0)
-
-#define DSI_HOST_CONTROL_FIFO_RESET	BIT(21)
-#define DSI_HOST_CONTROL_CRC_RESET	BIT(20)
-#define DSI_HOST_CONTROL_TX_TRIG_SOL	(0 << 12)
-#define DSI_HOST_CONTROL_TX_TRIG_FIFO	(1 << 12)
-#define DSI_HOST_CONTROL_TX_TRIG_HOST	(2 << 12)
-#define DSI_HOST_CONTROL_RAW		BIT(6)
-#define DSI_HOST_CONTROL_HS		BIT(5)
-#define DSI_HOST_CONTROL_FIFO_SEL	BIT(4)
-#define DSI_HOST_CONTROL_IMM_BTA	BIT(3)
-#define DSI_HOST_CONTROL_PKT_BTA	BIT(2)
-#define DSI_HOST_CONTROL_CS		BIT(1)
-#define DSI_HOST_CONTROL_ECC		BIT(0)
-
-#define DSI_CONTROL_HS_CLK_CTRL		BIT(20)
-#define DSI_CONTROL_CHANNEL(c)		(((c) & 0x3) << 16)
-#define DSI_CONTROL_FORMAT(f)		(((f) & 0x3) << 12)
-#define DSI_CONTROL_TX_TRIG(x)		(((x) & 0x3) <<  8)
-#define DSI_CONTROL_LANES(n)		(((n) & 0x3) <<  4)
-#define DSI_CONTROL_DCS_ENABLE		BIT(3)
-#define DSI_CONTROL_SOURCE(s)		(((s) & 0x1) <<  2)
-#define DSI_CONTROL_VIDEO_ENABLE	BIT(1)
-#define DSI_CONTROL_HOST_ENABLE		BIT(0)
-
-#define DSI_TRIGGER_HOST		BIT(1)
-#define DSI_TRIGGER_VIDEO		BIT(0)
-
-#define DSI_STATUS_IDLE			BIT(10)
-#define DSI_STATUS_UNDERFLOW		BIT(9)
-#define DSI_STATUS_OVERFLOW		BIT(8)
-
-#define DSI_TIMING_FIELD(value, period, hwinc) \
-	((DIV_ROUND_CLOSEST(value, period) - (hwinc)) & 0xff)
-
-#define DSI_TIMEOUT_LRX(x)		(((x) & 0xffff) << 16)
-#define DSI_TIMEOUT_HTX(x)		(((x) & 0xffff) <<  0)
-#define DSI_TIMEOUT_PR(x)		(((x) & 0xffff) << 16)
-#define DSI_TIMEOUT_TA(x)		(((x) & 0xffff) <<  0)
-
-#define DSI_TALLY_TA(x)			(((x) & 0xff) << 16)
-#define DSI_TALLY_LRX(x)		(((x) & 0xff) <<  8)
-#define DSI_TALLY_HTX(x)		(((x) & 0xff) <<  0)
-
-#define DSI_PAD_CONTROL_PAD_PULLDN_ENAB(x)	(((x) & 0x1) << 28)
-#define DSI_PAD_CONTROL_PAD_SLEWUPADJ(x)	(((x) & 0x7) << 24)
-#define DSI_PAD_CONTROL_PAD_SLEWDNADJ(x)	(((x) & 0x7) << 20)
-#define DSI_PAD_CONTROL_PAD_PREEMP_EN(x)	(((x) & 0x1) << 19)
-#define DSI_PAD_CONTROL_PAD_PDIO_CLK(x)		(((x) & 0x1) << 18)
-#define DSI_PAD_CONTROL_PAD_PDIO(x)		(((x) & 0x3) << 16)
-#define DSI_PAD_CONTROL_PAD_LPUPADJ(x)		(((x) & 0x3) << 14)
-#define DSI_PAD_CONTROL_PAD_LPDNADJ(x)		(((x) & 0x3) << 12)
-
-/*
- * pixel format as used in the DSI_CONTROL_FORMAT field
- */
-enum tegra_dsi_format {
-	TEGRA_DSI_FORMAT_16P,
-	TEGRA_DSI_FORMAT_18NP,
-	TEGRA_DSI_FORMAT_18P,
-	TEGRA_DSI_FORMAT_24P,
-};
-
-/* DSI calibration in VI region */
-#define TEGRA_VI_BASE			0x54080000
-
-#define CSI_CILA_MIPI_CAL_CONFIG_0	0x22a
-#define  MIPI_CAL_TERMOSA(x)		(((x) & 0x1f) << 0)
-
-#define CSI_CILB_MIPI_CAL_CONFIG_0	0x22b
-#define  MIPI_CAL_TERMOSB(x)		(((x) & 0x1f) << 0)
-
-#define CSI_CIL_PAD_CONFIG		0x229
-#define  PAD_CIL_PDVREG(x)		(((x) & 0x01) << 1)
-
-#define CSI_DSI_MIPI_CAL_CONFIG		0x234
-#define  MIPI_CAL_HSPDOSD(x)		(((x) & 0x1f) << 16)
-#define  MIPI_CAL_HSPUOSD(x)		(((x) & 0x1f) << 8)
-
-#define CSI_MIPIBIAS_PAD_CONFIG		0x235
-#define  PAD_DRIV_DN_REF(x)		(((x) & 0x7) << 16)
-#define  PAD_DRIV_UP_REF(x)		(((x) & 0x7) << 8)
+#include <asm/arch-tegra/dsi.h>
 
 #endif /* __ASM_ARCH_TEGRA_DSI_H */
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index a48f9c85d0..b9cd63903a 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -21,16 +21,23 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/display.h>
-#include <asm/arch-tegra30/dsi.h>
+#include <asm/arch-tegra/dsi.h>
 
 #include "mipi-phy.h"
 
+/* List of supported DSI bridges */
+enum {
+	DSI_V0,
+	DSI_V1,
+};
+
 struct tegra_dsi_priv {
 	struct mipi_dsi_host host;
 	struct mipi_dsi_device device;
 	struct mipi_dphy_timing dphy_timing;
 
 	struct udevice *panel;
+	struct udevice *mipi;
 	struct display_timing timing;
 
 	struct dsi_ctlr *dsi;
@@ -41,6 +48,8 @@ struct tegra_dsi_priv {
 	int dsi_clk;
 	int video_fifo_depth;
 	int host_fifo_depth;
+
+	u32 version;
 };
 
 static void tegra_dc_enable_controller(struct udevice *dev)
@@ -501,6 +510,41 @@ static void tegra_dsi_pad_calibrate(struct dsi_pad_ctrl_reg *pad)
 	writel(value, TEGRA_VI_BASE + (CSI_CIL_PAD_CONFIG << 2));
 }
 
+static void tegra_dsi_mipi_calibrate(struct tegra_dsi_priv *priv)
+{
+	struct dsi_pad_ctrl_reg *pad = &priv->dsi->pad;
+	u32 value;
+	int ret;
+
+	ret = misc_set_enabled(priv->mipi, true);
+	if (ret)
+		log_err("%s: failed to enable MIPI calibration: %d\n",
+			__func__, ret);
+
+	writel(0, &pad->pad_ctrl);
+	writel(0, &pad->pad_ctrl_1);
+	writel(0, &pad->pad_ctrl_2);
+	writel(0, &pad->pad_ctrl_3);
+	writel(0, &pad->pad_ctrl_4);
+
+	/* DSI pad enable */
+	value = DSI_PAD_CONTROL_VS1_PULLDN(0) | DSI_PAD_CONTROL_VS1_PDIO(0);
+	writel(value, &pad->pad_ctrl);
+
+	value = DSI_PAD_SLEW_UP(0x7) | DSI_PAD_SLEW_DN(0x7) |
+		DSI_PAD_LP_UP(0x1) | DSI_PAD_LP_DN(0x1) |
+		DSI_PAD_OUT_CLK(0x0);
+	writel(value, &pad->pad_ctrl_2);
+
+	value = DSI_PAD_PREEMP_PD_CLK(0x3) | DSI_PAD_PREEMP_PU_CLK(0x3) |
+		DSI_PAD_PREEMP_PD(0x03) | DSI_PAD_PREEMP_PU(0x3);
+	writel(value, &pad->pad_ctrl_3);
+
+	ret = misc_write(priv->mipi, 0, NULL, 0);
+	if (ret)
+		debug("%s: MIPI calibration failed %d\n", __func__, ret);
+}
+
 static void tegra_dsi_set_timeout(struct dsi_timeout_reg *rtimeout,
 				  unsigned long bclk,
 				  unsigned int vrefresh)
@@ -664,10 +708,25 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	u32 value;
 	int ret;
 
+	/* If for some reasone DSI is enabled then it needs to
+	 * be disabled in order for the panel initialization
+	 * commands to be properly sent.
+	 */
+	value = readl(&misc->dsi_pwr_ctrl);
+
+	if (value & DSI_POWER_CONTROL_ENABLE) {
+		value = readl(&misc->dsi_pwr_ctrl);
+		value &= ~DSI_POWER_CONTROL_ENABLE;
+		writel(value, &misc->dsi_pwr_ctrl);
+	}
+
 	/* Disable interrupt */
 	writel(0, &misc->int_enable);
 
-	tegra_dsi_pad_calibrate(&priv->dsi->pad);
+	if (priv->version)
+		tegra_dsi_mipi_calibrate(priv);
+	else
+		tegra_dsi_pad_calibrate(&priv->dsi->pad);
 
 	tegra_dsi_get_muldiv(device->format, &mul, &div);
 
@@ -792,6 +851,8 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 	struct mipi_dsi_panel_plat *mipi_plat;
 	int ret;
 
+	priv->version = dev_get_driver_data(dev);
+
 	priv->dsi = (struct dsi_ctlr *)dev_read_addr_ptr(dev);
 	if (!priv->dsi) {
 		printf("%s: No display controller address\n", __func__);
@@ -814,6 +875,16 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 		return log_ret(ret);
 	}
 
+	if (priv->version) {
+		ret = uclass_get_device_by_phandle(UCLASS_MISC, dev,
+						   "nvidia,mipi-calibrate",
+						   &priv->mipi);
+		if (ret) {
+			log_err("cannot get MIPI: error %d\n", ret);
+			return log_ret(ret);
+		}
+	}
+
 	panel_get_display_timing(priv->panel, &priv->timing);
 
 	mipi_plat = dev_get_plat(priv->panel);
@@ -845,7 +916,8 @@ static const struct panel_ops tegra_dsi_bridge_ops = {
 };
 
 static const struct udevice_id tegra_dsi_bridge_ids[] = {
-	{ .compatible = "nvidia,tegra30-dsi" },
+	{ .compatible = "nvidia,tegra30-dsi", .data = DSI_V0 },
+	{ .compatible = "nvidia,tegra114-dsi", .data = DSI_V1 },
 	{ }
 };
 
-- 
2.40.1

