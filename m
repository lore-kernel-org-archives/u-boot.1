Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3223D3C531
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 20:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941FC890FD;
	Thu, 17 Oct 2024 22:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sugm+pY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB2C890DF; Thu, 17 Oct 2024 22:01:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A38E88F23
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a54c=RO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1729195273; bh=6U6VffIiA2PyaoQYKQWu+On75h75p1ZuSJY1IIex7GE=;
 b=sugm+pY2iVGLyqUInqQuxUvTjjifGC6juqsZ3ZnccaZVlLfBIUqVQvOhcSeqwR0VBZ449hEMu
 25PCjCn3833nLZrsjUbgIFV3WLYexKzsrf04eA0QyVNMbPYUKsLU2KgunnsFvW3sAdN94CsQkQA
 XRRL2CZyzjPLS4dsePetAvIwh4V6/puEUwi3gIkZYL7XEay3YArBuq/vyUDYU6i+7LZtkhHi3rP
 i3UujPr9tKFTtiI+3aiNvoDo5T5mu7yAAq+lwJyznVwfWJbXNhKf/7vdx4sMccnaPy1nnBdhitM
 GPxyu8o71LmI8DNBMG+4Eqy6NBbSX5Q0z9djlwWAZpZg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH 8/8] rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6 LTS
Date: Thu, 17 Oct 2024 20:00:27 +0000
Message-ID: <20241017200039.1235524-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67116d096385e073f5ab1435
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

Update defconfig to enable features included in pending upstream DT and
implement board_fit_config_name_match() to load correct DT for LTS and
non-LTS version of the NanoPC-T6.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     |  5 ++
 board/friendlyelec/nanopc-t6-rk3588/Makefile  |  3 +
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c       | 59 +++++++++++++++++++
 configs/nanopc-t6-rk3588_defconfig            | 12 ++++
 4 files changed, 79 insertions(+)
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c

diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
index 3261b2c42b4b..8465dcd4c9cd 100644
--- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
@@ -11,6 +11,11 @@
 	bootph-some-ram;
 };
 
+&saradc {
+	bootph-pre-ram;
+	vdd-microvolts = <1800000>;
+};
+
 &sfc {
 	flash@0 {
 		bootph-pre-ram;
diff --git a/board/friendlyelec/nanopc-t6-rk3588/Makefile b/board/friendlyelec/nanopc-t6-rk3588/Makefile
new file mode 100644
index 000000000000..2858e0d7c26f
--- /dev/null
+++ b/board/friendlyelec/nanopc-t6-rk3588/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += nanopc-t6-rk3588.o
diff --git a/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c b/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
new file mode 100644
index 000000000000..05cf55e4291d
--- /dev/null
+++ b/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <adc.h>
+#include <env.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+
+#define HW_ID_CHANNEL	5
+
+struct board_model {
+	unsigned int low;
+	unsigned int high;
+	const char *fdtfile;
+};
+
+static const struct board_model board_models[] = {
+	{  348,  528, "rockchip/rk3588-nanopc-t6.dtb" },
+	{ 1957, 2137, "rockchip/rk3588-nanopc-t6-lts.dtb" },
+};
+
+static const struct board_model *get_board_model(void)
+{
+	unsigned int val;
+	int i, ret;
+
+	ret = adc_channel_single_shot("adc@fec10000", HW_ID_CHANNEL, &val);
+	if (ret)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
+		unsigned int min = board_models[i].low;
+		unsigned int max = board_models[i].high;
+
+		if (min <= val && val <= max)
+			return &board_models[i];
+	}
+
+	return NULL;
+}
+
+int rk_board_late_init(void)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model)
+		env_set("fdtfile", model->fdtfile);
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model && !strcmp(name, model->fdtfile))
+		return 0;
+
+	return -EINVAL;
+}
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index d62c8168a8d6..772b7df15557 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -32,6 +32,7 @@ CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
+CONFIG_CMD_ADC=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -43,13 +44,20 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_LIST="rockchip/rk3588-nanopc-t6 rockchip/rk3588-nanopc-t6-lts"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SPL_ADC=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
 CONFIG_SPL_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_DW=y
@@ -69,12 +77,16 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SFC=y
+CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.46.2

