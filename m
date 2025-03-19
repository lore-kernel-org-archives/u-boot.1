Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616D9C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 20:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE83B81D0B;
	Wed, 19 Mar 2025 21:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="k+7Ut2ag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF910810F2; Wed, 19 Mar 2025 21:21:05 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FC88198A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 21:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 63A06120011;
 Wed, 19 Mar 2025 23:20:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 63A06120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1742415659;
 bh=ILk/xCgiNIi3MmSne25n+5S5JV5ESGJWkXGtCFAVYL0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=k+7Ut2agEW56cq7iIWCah4GBtiK1cnEOvOvH4WKRUKIlodCMp9ZGI/uFrqAiIRsy7
 Tt9N/o5z+b09B4lfGkPfGbfJuRMHrA4bATmz1YQk5G1gdCIkL9tnRjIms/u/dEQ++D
 Rs/mKZcml5GOLVlSwn4r0A1dW+qkA03jjTwRq5Xwlog/jyJRfkIllWCRilnOe6q8To
 vQPaes5js/oFcBVh2ly9+Dpan+MDud6BgkraVzWqCLE+25pedUXuSCklWjDuLw8i71
 OL+mLGwF1JpwLo0ge/eQgNQ6j9JfoVbLESPy31RYQ9+zM2qzh3ultUxJek6g/O+oGa
 J8r0zRQ+pOSMQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru
 [172.24.201.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 19 Mar 2025 23:20:59 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
 Viacheslav Bocharov <adeep@lexina.in>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, <oxffffaa@gmail.com>,
 <avkrasnov@salutedevices.com>
Subject: [PATCH v1 04/11] usb: gadget: amlogic: common code for Amlogic
 flashing commands
Date: Wed, 19 Mar 2025 23:20:38 +0300
Message-ID: <20250319202045.1407-5-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319202045.1407-1-avkrasnov@salutedevices.com>
References: <20250319202045.1407-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.65.111]
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191951 [Mar 19 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2025/03/19 19:45:00 #27804052
X-KSMG-AntiVirus-Status: Clean, skipped
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

Amlogic has Optimus and ADNL protocols to update firmware image.
Both are operatable by special commands and such commands use same
approaches, so let's implement such code before implementing both
protocols.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 cmd/meson/gadget.c | 183 +++++++++++++++++++++++++++++++++++++++++++++
 cmd/meson/gadget.h |  28 +++++++
 2 files changed, 211 insertions(+)
 create mode 100644 cmd/meson/gadget.c
 create mode 100644 cmd/meson/gadget.h

diff --git a/cmd/meson/gadget.c b/cmd/meson/gadget.c
new file mode 100644
index 00000000000..6155043ae5a
--- /dev/null
+++ b/cmd/meson/gadget.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#include <hexdump.h>
+#include <command.h>
+#include <g_dnl.h>
+#include <mtd.h>
+#include <time.h>
+#include <asm/arch/sm.h>
+#include <asm/types.h>
+#include <linux/delay.h>
+
+#define BURN_BOOT_UDELAY	(2 * 1000 * 1000)
+static unsigned long burn_identify_time_ms;
+static unsigned long burn_start_time_ms;
+
+void amlogic_gadget_set_times(unsigned long start_time, unsigned long identify_time)
+{
+	burn_start_time_ms = start_time;
+	burn_identify_time_ms = identify_time;
+}
+
+/*
+ * This function utilizes serial from inside Amlogic chip_id with one
+ * distinctive feature that this serial must be in big-endian.
+ *
+ * This is needed, because serial string, utilized in BootROM, must match
+ * the serial string, used inside U-Boot. But BootROM utilizes serial string
+ * in big-endian: being in BootROM try
+ * - for new SoCs (a1, s4, etc - those which utilize ADNL protocol): run
+ *   host command 'fastboot devices'
+ * - for old SoCs (axg, g12a, g12b, etc - those, utilizing optimus protocol):
+ *   send "chipid" command to bootROM
+ */
+static int amlogic_serial_hex(char serial_str[SM_SERIAL_SIZE * 2 + 1])
+{
+	u8 serial[SM_SERIAL_SIZE];
+	int ret;
+
+	/*
+	 * ADNL/OPTIMUS uses serial value in big-endian order.
+	 * meson_sm_get_serial() returns exactly such value.
+	 */
+	ret = meson_sm_get_serial(serial, sizeof(serial));
+	if (ret)
+		return ret;
+
+	bin2hex(serial_str, serial, sizeof(serial));
+	return ret;
+}
+
+int amlogic_gadget_run(const char *mode, int argc, char *const argv[])
+{
+	char serial_string[SM_SERIAL_SIZE * 2 + 1] = { 0 };
+	unsigned long identify_timeout_ms;
+	unsigned long start_timeout_ms;
+	struct udevice *udc;
+	char *saved_serial;
+	int ret;
+
+	if (mtd_probe_devices()) {
+		pr_err("Mtd devices probe failed\n");
+		return CMD_RET_FAILURE;
+	}
+
+	/*
+	 * During ADNL/OPTIMUS burning process, device enters USB gadget mode
+	 * twice: first time when it was stopped in ROM boot, second -
+	 * here, after ROM and BL2 stages are done and we are ready
+	 * to run BL33 (U-boot) stage. From the PC side, client waits
+	 * reentering to USB gadget mode (in BL33 stage). Without delay
+	 * below, PC client waits for USB device forever with the
+	 * following message.
+	 *
+	 * OPTIMUS do not use timeout described below
+	 * MSG[TLS]Waiting for DNL[<serial>] with timeout 0
+	 *
+	 * At the same time, there is no difference (from the PC point
+	 * of view) between USB device state with or w/o this delay, so
+	 * seems this delay is needed only to make PC client work
+	 * correctly due to is internal logic.
+	 */
+	udelay(BURN_BOOT_UDELAY);
+
+	ret = amlogic_serial_hex(serial_string);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	saved_serial = env_get("serial#");
+	if (saved_serial) {
+		saved_serial = strdup(saved_serial);
+		if (!saved_serial)
+			return CMD_RET_FAILURE;
+	}
+
+	/*
+	 * Use "force" flag, because 'serial#' is protected
+	 * from both delete and rewrite. This variable is used
+	 * by USB gadget code as serial number of USB device.
+	 */
+	ret = run_commandf("env set -f serial# %s", serial_string);
+	if (ret) {
+		ret = CMD_RET_FAILURE;
+		goto exit_ret;
+	}
+
+	amlogic_gadget_set_times(get_timer(0), 0);
+
+	ret = udc_device_get_by_index(0, &udc);
+	if (ret) {
+		pr_err("Failed to get UDC device: %d\n", ret);
+		ret = CMD_RET_FAILURE;
+		goto exit_ret;
+	}
+
+	g_dnl_clear_detach();
+	ret = g_dnl_register(mode);
+	if (ret) {
+		ret = CMD_RET_FAILURE;
+		goto exit_ret;
+	}
+
+	if (!g_dnl_board_usb_cable_connected()) {
+		pr_err("Usb cable isn't detected\n");
+		ret = CMD_RET_FAILURE;
+		goto exit;
+	}
+
+	identify_timeout_ms = (argc == 3) ? simple_strtoul(argv[2], NULL, 0) : 0;
+	start_timeout_ms = (argc >= 2) ? simple_strtoul(argv[1], NULL, 0) : 0;
+
+	while (1) {
+		if (g_dnl_detach())
+			break;
+
+		if (ctrlc())
+			break;
+
+		schedule();
+
+		if (start_timeout_ms && burn_start_time_ms) {
+			unsigned long start_delta = get_timer(burn_start_time_ms);
+
+			if (start_delta > start_timeout_ms) {
+				pr_err("Burn init timeout: %lu > %lu\n",
+				       start_delta, start_timeout_ms);
+				ret = CMD_RET_FAILURE;
+				goto exit;
+			}
+		}
+
+		if (identify_timeout_ms && burn_identify_time_ms) {
+			unsigned long identify_delta_ms = get_timer(burn_identify_time_ms);
+
+			if (identify_delta_ms > identify_timeout_ms) {
+				pr_err("Burn identify timeout: %lu > %lu\n",
+				       identify_delta_ms, identify_timeout_ms);
+				ret = CMD_RET_FAILURE;
+				goto exit;
+			}
+		}
+
+		dm_usb_gadget_handle_interrupts(udc);
+	}
+
+	ret = CMD_RET_SUCCESS;
+
+exit:
+	g_dnl_unregister();
+	g_dnl_clear_detach();
+	udc_device_put(udc);
+
+exit_ret:
+	if (saved_serial) {
+		env_set("serial#", saved_serial);
+		free(saved_serial);
+	}
+
+	return ret;
+}
diff --git a/cmd/meson/gadget.h b/cmd/meson/gadget.h
new file mode 100644
index 00000000000..a3771fb4746
--- /dev/null
+++ b/cmd/meson/gadget.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 SaluteDevices, Inc.
+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
+ */
+
+#ifndef __GADGET_H__
+#define __GADGET_H__
+
+/**
+ * amlogic_gadget_set_times() - set timeouts for ADNL/Optimus protocols
+ *
+ * @start_time: timeout in ms, until device enters ADNL/Optimus mode
+ * @identify_time: timeout in ms, until device gets first command from host
+ */
+void amlogic_gadget_set_times(unsigned long start_time, unsigned long identify_time);
+
+/**
+ * amlogic_gadget_run() - switch device to USB gadget mode
+ *
+ * @mode: USB function name.
+ * @argc: number of arguments in 'argv'
+ * @argv: arguments, passed from command
+ * Return: 0 (CMD_RET_SUCCESS) if there is no error.
+ */
+int amlogic_gadget_run(const char *mode, int argc, char *const argv[]);
+
+#endif /* __GADGET_H__ */
-- 
2.30.1

