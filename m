Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3476DCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B26E846CC;
	Tue, 19 May 2026 00:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="dCiwUWZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6B4846A4; Tue, 19 May 2026 00:30:57 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599C18465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-368f25ff4c4so1348326a91.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143452; x=1779748252;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w8RsMdiCYTk76ONR10qLn8Slm/2w+1FgwtURYxCDdSI=;
 b=dCiwUWZ80QJzeWMrb2l9v1ZEbMOoyAV6QjqGfdmNyv639bTEDVcNCdZdgYFmGo3PHX
 CsoCDh51tSQsRTNSZqmqg2plAZiBHBPV4npCkR4PkgcB+vmI7AVL88QNYvaiE6z3Z71I
 czVcAIMSuCPBkL25U0EYTWBMvUtV8jgNi+G7n5FJIKcjOZ/j/UieG/r0I+q6c5NRGL4M
 LXgOVYehR3khNovk9156+MV3kQl6w4yVLkCy2GufjyvX4Jl8xPBSRPiJFW5nTRW9RIte
 Hyon9ZzFId/AJbwabu8AfoVz1wUyHHneLnhPNIznaBeqUlcA3w0W/QtN/PPShDihY821
 xQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143452; x=1779748252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w8RsMdiCYTk76ONR10qLn8Slm/2w+1FgwtURYxCDdSI=;
 b=DGniTvg10t7tSsr+ODFwk2DF4w5oO1QiIVIKXH59R0GarcVjQlOyHnnYWSbxBfaZpE
 7RBtrRz0pzyJEIdUvQ5RioX9pqFj3c/rGBymJuFWF+2JPQJQLDL/k/f0Cc2Rv0YmJ7xW
 W9bh+sZpMXS0VsXCSa4p56ta/OU1J8iapA1+x7MhqvgHtFypDZzZ8W1ag7XDF6xa0ZxK
 7DStQDJedIEiU0p+VLeeP2xBAbkM35H8NoXQQCAaFBnH/N4bdpIWZOROE14sXZ3uVk6d
 1XAkEglvUvMjXjMQeLf8IuOkLiNqyn/ryS/mO7/xTzwm4KzUjS9rLp3+Js3yhvD2EKPB
 iIwQ==
X-Gm-Message-State: AOJu0YwhkJg6uMEMcvuX3isD2+JBkfNVUlKmpUWuA3TPf9q1kEA98ALF
 LriNmMm2LGTGn4jrtquKtCOg8NuenIcaDa6gDwqzGJhnCIry/3k9m9Dq/QdDep/feaY=
X-Gm-Gg: Acq92OEjWP8c45NKiM9pOpzRYlTIX9u0Snkyxa7dwb97dDj6XIUySr235YyE5fzBJIf
 3M9kblQlgWtY0xHiddnijrl5AC9aI1NMv8sFJSFNXcjTUXdCrumxxJnVYQyhWPwCj/vMJafFRMg
 LR7qRRV7pmKnQPE4+Vh+JinXeAhgO7DUshCpLPhhA5L8TB9xcmwyBnHdXQt/IZbuLYUnDNQGbFb
 5OWu9Qyg/U4Gx+HGmE0vhWwaBeAsOYIVOE41kkdw80RCvta7RZ4mK7o+HwIChEGYplSWu5z+NxC
 pm74wLMzVov43K0wP3B8oO4E97JHPQUTcLSu0lWWQfKSFbegM+iStekH69UAbYX0I3Dj7I/CvXO
 6MehDAphfBEVlroObFFhJM6/Z7j0Gwa3kNOuo5g24Jr9E3si95LLEzzEPaYMgs1fX0rnuSNzjsd
 Ucjbv0UEpL5yToduowFip+/j+Zsq0C+izdUitrN/uFXtcWfcAAdnuCrg==
X-Received: by 2002:a17:902:b181:b0:2b2:6cab:313c with SMTP id
 d9443c01a7336-2bd7e97d287mr117561955ad.20.1779143452008; 
 Mon, 18 May 2026 15:30:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:30:51 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:26 -0400
Subject: [PATCH v4 08/14] i2c: k1: add I2C driver support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-8-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add I2C driver support on Spacemit K1 SoC using driver model.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Heiko Schocher <hs@nabladev.com>

---
v4:
- i2c reset lookup made optional (upstream DT omits 'resets').
- Drop unused 'resets' field from priv.
---
 drivers/i2c/Kconfig  |   7 +
 drivers/i2c/Makefile |   1 +
 drivers/i2c/k1_i2c.c | 523 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/k1_i2c.h |  69 +++++++
 4 files changed, 600 insertions(+)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 37288a47eb7..814a20d629e 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -797,6 +797,13 @@ config SYS_I2C_IHS
         help
           Support for gdsys IHS I2C driver on FPGA bus.
 
+config SYS_I2C_SPACEMIT_K1
+	bool "Spacemit K1 I2C driver"
+	depends on DM_I2C
+	help
+	  Support for Spacemit I2C controller. It's based on
+	  Driver Model.
+
 source "drivers/i2c/muxes/Kconfig"
 
 endif
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 2da649e97d3..0e3a0f9fb5f 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_SYS_I2C_RZ_RIIC) += rz_riic.o
 obj-$(CONFIG_SYS_I2C_S3C24X0) += s3c24x0_i2c.o exynos_hs_i2c.o
 obj-$(CONFIG_SYS_I2C_SANDBOX) += sandbox_i2c.o i2c-emul-uclass.o
 obj-$(CONFIG_SYS_I2C_SH) += sh_i2c.o
+obj-$(CONFIG_SYS_I2C_SPACEMIT_K1) += k1_i2c.o
 obj-$(CONFIG_SYS_I2C_STM32F7) += stm32f7_i2c.o
 obj-$(CONFIG_SYS_I2C_SUN6I_P2WI) += sun6i_p2wi.o
 obj-$(CONFIG_SYS_I2C_SUN8I_RSB) += sun8i_rsb.o
diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
new file mode 100644
index 00000000000..a08ff15803d
--- /dev/null
+++ b/drivers/i2c/k1_i2c.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023-2026 Spacemit, Inc
+ * Copyright (C) 2025-2026 RISCstar Ltd.
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <reset.h>
+#include "k1_i2c.h"
+
+#define ICR_OFFSET		0x00
+#define ISR_OFFSET		0x04
+#define ISAR_OFFSET		0x08
+#define IDBR_OFFSET		0x0c
+#define ILCR_OFFSET		0x10
+#define IWCR_OFFSET		0x14
+#define IRCR_OFFSET		0x18
+#define IBMR_OFFSET		0x1c
+#define WFIFO_OFFSET		0x20
+#define WFIFO_WPTR_OFFSET	0x24
+#define WFIFO_RPTR_OFFSET	0x28
+#define RFIFO_OFFSET		0x2c
+#define RFIFO_WPTR_OFFSET	0x30
+#define RFIFO_RPTR_OFFSET	0x34
+
+/* All transfers are described by this data structure */
+struct k1_i2c_msg {
+	u8 condition;
+	u8 acknack;
+	u8 direction;
+	u8 data;
+};
+
+struct k1_i2c {
+	u32 icr;
+	u32 isr;
+	u32 isar;
+	u32 idbr;
+	u32 ilcr;
+	u32 iwcr;
+	u32 irst_cyc;
+	u32 ibmr;
+};
+
+struct k1_i2c_priv {
+	int id;
+	void __iomem *base;
+	struct clk clk;
+	u32 clk_rate;
+};
+
+/*
+ * i2c_reset: - reset the host controller
+ *
+ */
+static void i2c_reset(void __iomem *base)
+{
+	u32 icr_mode;
+	u32 val;
+
+	/* Save bus mode (standard or fast speed) for later use */
+	icr_mode = readl(base + ICR_OFFSET) & ICR_MODE_MASK;
+	/* disable unit */
+	val = readl(base + ICR_OFFSET);
+	writel(val & ~ICR_IUE, base + ICR_OFFSET);
+	udelay(10);
+	/* reset the unit */
+	val = readl(base + ICR_OFFSET);
+	val |= ICR_UR;
+	writel(val, base + ICR_OFFSET);
+	udelay(100);
+	/* disable unit */
+	val = readl(base + ICR_OFFSET);
+	writel(val & ~ICR_IUE, base + ICR_OFFSET);
+
+	/* set slave address */
+	writel(0x00, base + ISR_OFFSET);
+	/* set control reg values */
+	writel(I2C_ICR_INIT | icr_mode, base + ICR_OFFSET);
+	writel(I2C_ISR_INIT, base + ISR_OFFSET); /* set clear interrupt bits */
+	val = readl(base + ICR_OFFSET);
+	val |= ICR_IUE;
+	writel(val, base + ICR_OFFSET); /* enable unit */
+	udelay(100);
+}
+
+static inline bool is_isr_set_or_clr(unsigned long isr, unsigned long set_mask,
+				     unsigned long clr_mask)
+{
+	return ((isr & set_mask) == set_mask) && ((isr & clr_mask) == 0);
+}
+
+/*
+ * i2c_isr_set_cleared: - wait until certain bits of the I2C status register
+ *	                  are set and cleared
+ *
+ * @return: 0 on success or -ETIMEDOUT.
+ */
+static int i2c_isr_set_cleared(void __iomem *base, unsigned long set_mask,
+			       unsigned long clr_mask)
+{
+	int cnt = 1000, delay = 10, isr, ret;
+
+	ret = read_poll_timeout(readl, isr,
+				is_isr_set_or_clr(isr, set_mask, clr_mask),
+				delay, delay * cnt, base + ISR_OFFSET);
+	return ret;
+}
+
+/*
+ * i2c_transfer: - Transfer one byte over the i2c bus
+ *
+ * This function can transfer a byte over the i2c bus in both directions.
+ * It is used by the public API functions.
+ *
+ * @return:  0: transfer successful or error code
+ */
+static int i2c_transfer(void __iomem *base, struct k1_i2c_msg *msg)
+{
+	int ret;
+	u32 val;
+
+	if (!msg)
+		goto transfer_error_msg_empty;
+
+	switch (msg->direction) {
+	case I2C_WRITE:
+		/* check if bus is not busy */
+		if (i2c_isr_set_cleared(base, 0, ISR_IBB))
+			goto transfer_error_bus_busy;
+
+		/* start transmission */
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_START;
+		writel(val, base + ICR_OFFSET);
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_STOP;
+		writel(val, base + ICR_OFFSET);
+		writel(msg->data, base + IDBR_OFFSET);
+		if (msg->condition == I2C_COND_START) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_START;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->condition == I2C_COND_STOP) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_STOP;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->acknack == I2C_ACKNAK_SENDNAK) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_ACKNAK;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->acknack == I2C_ACKNAK_SENDACK) {
+			val = readl(base + ICR_OFFSET);
+			val &= ~ICR_ACKNAK;
+			writel(val, base + ICR_OFFSET);
+		}
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_ALDIE;
+		writel(val, base + ICR_OFFSET);
+		val = readl(base + ICR_OFFSET);
+		val |= ICR_TB;
+		writel(val, base + ICR_OFFSET);
+
+		/* transmit register empty? */
+		if (i2c_isr_set_cleared(base, ISR_ITE, 0))
+			goto transfer_error_transmit_timeout;
+
+		/* clear 'transmit empty' state */
+		val = readl(base + ISR_OFFSET);
+		val |= ISR_ITE;
+		writel(val, base + ISR_OFFSET);
+
+		/* wait for ACK from slave */
+		if (msg->acknack == I2C_ACKNAK_WAITACK)
+			if (i2c_isr_set_cleared(base, 0, ISR_ACKNAK))
+				goto transfer_error_ack_missing;
+		break;
+
+	case I2C_READ:
+		/* check if bus is not busy */
+		if (i2c_isr_set_cleared(base, 0, ISR_IBB))
+			goto transfer_error_bus_busy;
+
+		/* start receive */
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_START;
+		writel(val, base + ICR_OFFSET);
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_STOP;
+		writel(val, base + ICR_OFFSET);
+		if (msg->condition == I2C_COND_START) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_START;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->condition == I2C_COND_STOP) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_STOP;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->acknack == I2C_ACKNAK_SENDNAK) {
+			val = readl(base + ICR_OFFSET);
+			val |= ICR_ACKNAK;
+			writel(val, base + ICR_OFFSET);
+		}
+		if (msg->acknack == I2C_ACKNAK_SENDACK) {
+			val = readl(base + ICR_OFFSET);
+			val &= ~ICR_ACKNAK;
+			writel(val, base + ICR_OFFSET);
+		}
+		val = readl(base + ICR_OFFSET);
+		val &= ~ICR_ALDIE;
+		writel(val, base + ICR_OFFSET);
+		val = readl(base + ICR_OFFSET);
+		val |= ICR_TB;
+		writel(val, base + ICR_OFFSET);
+
+		/* receive register full? */
+		if (i2c_isr_set_cleared(base, ISR_IRF, 0))
+			goto transfer_error_receive_timeout;
+
+		msg->data = readl(base + IDBR_OFFSET);
+
+		/* clear 'receive empty' state */
+		val = readl(base + ISR_OFFSET);
+		val |= ISR_IRF;
+		writel(val, base + ISR_OFFSET);
+		break;
+	default:
+		goto transfer_error_illegal_param;
+	}
+
+	return 0;
+
+transfer_error_msg_empty:
+	debug("%s: error: 'msg' is empty\n", __func__);
+	ret = -EINVAL;
+	goto i2c_transfer_finish;
+
+transfer_error_transmit_timeout:
+	debug("%s: error: transmit timeout\n", __func__);
+	ret = -ETIMEDOUT;
+	goto i2c_transfer_finish;
+
+transfer_error_ack_missing:
+	debug("%s: error: ACK missing\n", __func__);
+	ret = -EREMOTEIO;
+	goto i2c_transfer_finish;
+
+transfer_error_receive_timeout:
+	debug("%s: error: receive timeout\n", __func__);
+	ret = -ETIMEDOUT;
+	goto i2c_transfer_finish;
+
+transfer_error_illegal_param:
+	debug("%s: error: illegal parameters\n", __func__);
+	ret = -EINVAL;
+	goto i2c_transfer_finish;
+
+transfer_error_bus_busy:
+	debug("%s: error: bus is busy\n", __func__);
+	ret = -EIO;
+	goto i2c_transfer_finish;
+
+i2c_transfer_finish:
+	debug("%s: ISR: 0x%04x\n", __func__, readl(base + ISR_OFFSET));
+	i2c_reset(base);
+	return ret;
+}
+
+static int __i2c_read(void __iomem *base, uchar chip, u8 *addr, int alen,
+		      uchar *buffer, int len)
+{
+	struct k1_i2c_msg msg;
+	int ret;
+
+	debug("%s(chip=0x%02x, addr=0x%02x, alen=0x%02x, len=0x%02x)\n",
+	      __func__, chip, *addr, alen, len);
+
+	if (len == 0) {
+		pr_err("reading zero byte is invalid\n");
+		return -EINVAL;
+	}
+
+	i2c_reset(base);
+
+	/* dummy chip address write */
+	debug("%s: dummy chip address write\n", __func__);
+	msg.condition = I2C_COND_START;
+	msg.acknack   = I2C_ACKNAK_WAITACK;
+	msg.direction = I2C_WRITE;
+	msg.data = (chip << 1);
+	msg.data &= 0xFE;
+	ret = i2c_transfer(base, &msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * send memory address bytes;
+	 * alen defines how much bytes we have to send.
+	 */
+	while (--alen >= 0) {
+		debug("%s: send address byte %02x (alen=%d)\n",
+		      __func__, *addr, alen);
+		msg.condition = I2C_COND_NORMAL;
+		msg.acknack   = I2C_ACKNAK_WAITACK;
+		msg.direction = I2C_WRITE;
+		msg.data      = addr[alen];
+		ret = i2c_transfer(base, &msg);
+		if (ret)
+			return ret;
+	}
+
+	/* start read sequence */
+	debug("%s: start read sequence\n", __func__);
+	msg.condition = I2C_COND_START;
+	msg.acknack   = I2C_ACKNAK_WAITACK;
+	msg.direction = I2C_WRITE;
+	msg.data      = (chip << 1);
+	msg.data     |= 0x01;
+	ret = i2c_transfer(base, &msg);
+	if (ret)
+		return ret;
+
+	/* read bytes; send NACK at last byte */
+	while (len--) {
+		if (len == 0) {
+			msg.condition = I2C_COND_STOP;
+			msg.acknack   = I2C_ACKNAK_SENDNAK;
+		} else {
+			msg.condition = I2C_COND_NORMAL;
+			msg.acknack   = I2C_ACKNAK_SENDACK;
+		}
+
+		msg.direction = I2C_READ;
+		msg.data      = 0x00;
+		ret = i2c_transfer(base, &msg);
+		if (ret)
+			return ret;
+
+		*buffer = msg.data;
+		debug("%s: reading byte (%p)=0x%02x\n",
+		      __func__, buffer, *buffer);
+		buffer++;
+	}
+
+	i2c_reset(base);
+
+	return 0;
+}
+
+static int __i2c_write(struct k1_i2c *base, uchar chip, u8 *addr, int alen,
+		       uchar *buffer, int len)
+{
+	struct k1_i2c_msg msg;
+	int ret;
+
+	debug("%s(chip=0x%02x, addr=0x%02x, alen=0x%02x, len=0x%02x)\n",
+	      __func__, chip, *addr, alen, len);
+
+	i2c_reset(base);
+
+	/* chip address write */
+	debug("%s: chip address write\n", __func__);
+	msg.condition = I2C_COND_START;
+	msg.acknack   = I2C_ACKNAK_WAITACK;
+	msg.direction = I2C_WRITE;
+	msg.data = (chip << 1);
+	msg.data &= 0xFE;
+	ret = i2c_transfer(base, &msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * send memory address bytes;
+	 * alen defines how much bytes we have to send.
+	 */
+	while (--alen >= 0) {
+		debug("%s: send address byte %02x (alen=%d)\n",
+		      __func__, *addr, alen);
+		msg.condition = I2C_COND_NORMAL;
+		msg.acknack   = I2C_ACKNAK_WAITACK;
+		msg.direction = I2C_WRITE;
+		msg.data      = addr[alen];
+		ret = i2c_transfer(base, &msg);
+		if (ret)
+			return ret;
+	}
+
+	/* write bytes; send NACK at last byte */
+	while (len--) {
+		debug("%s: writing byte (%p)=0x%02x\n",
+		      __func__, buffer, *buffer);
+
+		if (len == 0)
+			msg.condition = I2C_COND_STOP;
+		else
+			msg.condition = I2C_COND_NORMAL;
+
+		msg.acknack   = I2C_ACKNAK_WAITACK;
+		msg.direction = I2C_WRITE;
+		msg.data      = *(buffer++);
+
+		ret = i2c_transfer(base, &msg);
+		if (ret)
+			return ret;
+	}
+
+	i2c_reset(base);
+
+	return 0;
+}
+
+static int k1_i2c_xfer(struct udevice *bus, struct i2c_msg *msg, int nmsgs)
+{
+	struct k1_i2c_priv *i2c = dev_get_priv(bus);
+	struct i2c_msg *dmsg, *omsg, dummy;
+
+	memset(&dummy, 0, sizeof(struct i2c_msg));
+
+	/*
+	 * We expect either two messages (one with an offset and one with the
+	 * actual data) or one message (just data or offset/data combined)
+	 */
+	if (nmsgs > 2 || nmsgs == 0) {
+		debug("%s: Only one or two messages are supported.", __func__);
+		return -EINVAL;
+	}
+
+	omsg = nmsgs == 1 ? &dummy : msg;
+	dmsg = nmsgs == 1 ? msg : msg + 1;
+
+	if (dmsg->flags & I2C_M_RD)
+		return __i2c_read(i2c->base, dmsg->addr, omsg->buf,
+				  omsg->len, dmsg->buf, dmsg->len);
+	else
+		return __i2c_write(i2c->base, dmsg->addr, omsg->buf,
+				   omsg->len, dmsg->buf, dmsg->len);
+}
+
+static int k1_i2c_set_bus_speed(struct udevice *bus, unsigned int speed)
+{
+	struct k1_i2c_priv *priv = dev_get_priv(bus);
+	void __iomem *base = priv->base;
+	u32 val;
+
+	if (speed > I2C_SPEED_STANDARD_RATE)
+		val = ICR_FM;
+	else
+		val = ICR_SM;
+	clrsetbits_le32(base + ICR_OFFSET, ICR_MODE_MASK, val);
+
+	return 0;
+}
+
+static int k1_i2c_probe(struct udevice *bus)
+{
+	struct k1_i2c_priv *priv = dev_get_priv(bus);
+	struct reset_ctl reset;
+	int ret;
+
+	priv->id = dev_seq(bus);
+
+	/*
+	 * The upstream K1 dts intentionally omits the 'resets' property
+	 * on i2c nodes — the apbc clock-enable path performs the
+	 * controller reset internally as part of clock gating. Treat the
+	 * reset lookup as optional so we work on the kernel-mainline DT.
+	 */
+	ret = reset_get_by_index(bus, 0, &reset);
+	if (!ret) {
+		reset_assert(&reset);
+		udelay(10);
+		reset_deassert(&reset);
+		udelay(10);
+	} else if (ret != -ENOENT && ret != -ENODATA) {
+		dev_err(bus, "%s: reset lookup failed (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = clk_get_by_index(bus, 0, &priv->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&priv->clk);
+	if (ret && ret != -ENOSYS && ret != -EOPNOTSUPP) {
+		debug("%s: failed to enable clock\n", __func__);
+		return ret;
+	}
+	priv->clk_rate = clk_get_rate(&priv->clk);
+
+	priv->base = (void *)devfdt_get_addr_ptr(bus);
+	k1_i2c_set_bus_speed(bus, priv->clk_rate);
+	return 0;
+}
+
+static const struct dm_i2c_ops k1_i2c_ops = {
+	.xfer		= k1_i2c_xfer,
+	.set_bus_speed	= k1_i2c_set_bus_speed,
+};
+
+static const struct udevice_id k1_i2c_ids[] = {
+	{ .compatible = "spacemit,k1-i2c" },
+	{ }
+};
+
+U_BOOT_DRIVER(i2c_spacemit) = {
+	.name	= "i2c_spacemit",
+	.id	= UCLASS_I2C,
+	.of_match = k1_i2c_ids,
+	.probe	= k1_i2c_probe,
+	.priv_auto = sizeof(struct k1_i2c_priv),
+	.ops	= &k1_i2c_ops,
+};
diff --git a/drivers/i2c/k1_i2c.h b/drivers/i2c/k1_i2c.h
new file mode 100644
index 00000000000..856947aa43b
--- /dev/null
+++ b/drivers/i2c/k1_i2c.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023-2026 Spacemit Ltd.
+ * Copyright (C) 2025-2026 RISCstar Ltd.
+ */
+
+#ifndef __SPACEMIT_I2C_H
+#define __SPACEMIT_I2C_H
+
+/* Shall the current transfer have a start/stop condition? */
+#define I2C_COND_NORMAL		0
+#define I2C_COND_START		1
+#define I2C_COND_STOP		2
+
+/* Shall the current transfer be ack/nacked or being waited for it? */
+#define I2C_ACKNAK_WAITACK	1
+#define I2C_ACKNAK_SENDACK	2
+#define I2C_ACKNAK_SENDNAK	4
+
+/* Specify who shall transfer the data (master or slave) */
+#define I2C_READ		0
+#define I2C_WRITE		1
+
+#if (CONFIG_SYS_I2C_SPEED == 400000)
+#define I2C_ICR_INIT	(ICR_FM | ICR_BEIE | ICR_IRFIE | ICR_ITEIE |	\
+			 ICR_GCD | ICR_SCLE)
+#else
+#define I2C_ICR_INIT	(ICR_BEIE | ICR_IRFIE | ICR_ITEIE | ICR_GCD |	\
+			 ICR_SCLE)
+#endif
+
+/* ----- Control register bits ---------------------------------------- */
+
+#define ICR_START	0x1		/* start bit */
+#define ICR_STOP	0x2		/* stop bit */
+#define ICR_ACKNAK	0x4		/* send ACK(0) or NAK(1) */
+#define ICR_TB		0x8		/* transfer byte bit */
+#define ICR_MA		BIT(12)		/* master abort */
+#define ICR_SCLE	BIT(13)		/* master clock enable, mona SCLEA */
+#define ICR_IUE		BIT(14)		/* unit enable */
+#define ICR_GCD		BIT(21)		/* general call disable */
+#define ICR_ITEIE	BIT(19)		/* enable tx interrupts */
+#define ICR_IRFIE	BIT(20)		/* enable rx interrupts, mona: DRFIE */
+#define ICR_BEIE	BIT(22)		/* enable bus error ints */
+#define ICR_SSDIE	BIT(24)		/* slave STOP detected int enable */
+#define ICR_ALDIE	BIT(18)		/* enable arbitration interrupt */
+#define ICR_SADIE	BIT(23)		/* slave address detected int enable */
+#define ICR_UR		BIT(10)		/* unit reset */
+#define ICR_SM		(0x0)		/* Standard Mode */
+#define ICR_FM		BIT(8)		/* Fast Mode */
+#define ICR_MODE_MASK	(0x300)		/* Mode mask */
+
+/* ----- Status register bits ----------------------------------------- */
+
+#define ISR_RWM		BIT(13)		/* read/write mode */
+#define ISR_ACKNAK	BIT(14)		/* ack/nak status */
+#define ISR_UB		BIT(15)		/* unit busy */
+#define ISR_IBB		BIT(16)		/* bus busy */
+#define ISR_SSD		BIT(24)		/* slave stop detected */
+#define ISR_ALD		BIT(18)		/* arbitration loss detected */
+#define ISR_ITE		BIT(19)		/* tx buffer empty */
+#define ISR_IRF		BIT(20)		/* rx buffer full */
+#define ISR_GCAD	BIT(21)		/* general call address detected */
+#define ISR_SAD		BIT(23)		/* slave address detected */
+#define ISR_BED		BIT(22)		/* bus error no ACK/NAK */
+
+#define I2C_ISR_INIT	0x1FDE000
+
+#endif

-- 
2.43.0

