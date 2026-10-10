Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D55CA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37F7660625;
	Sat, 10 Oct 2026 22:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGukrQ8LQo2e; Sat, 10 Oct 2026 22:32:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 46201605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671539;
	b=km8VbdVgHxVo3jnz9I74HZCr8wVwwklcF0Uzemfq9aVUek+NRZd36YBozTQ2L40tynIp
	 6LVTO2Pw3NW91dgSLmAeO/HHff20NTminirKRdchz6Co/a3KKHQ3sBL7XvwFMxoKbGAEF
	 dhEz/BT4jlZR90tVpfv1929mzTdJaoSHSF8j3Sy3NLCDTQkWg03/PeDO3DezsglRF2u66
	 Mz51ACvWsPUKJ8GC4a13eO9UarAMicElPjWhx/fn3gREhAcPZ5lAPffAFBzTXu3mnRIyU
	 qovgVsbCeki8talv127bgOuKrZkez8u/NIwyy1r1IJEq6p0R8H0YTd0pf/SRE/BbD8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=U6WKvRSTfJV2/vkLOQKZ9BSBRVqR4+3qxmfq47x6uXQ=;
	b=KF2k2wLK7e4BiyLQsK7fwEMTe+5kNx8Gbz+KPUET4rhTzXaANh+QGce7gwOS6xXWSt60
	 A5xMSoCG5g+77GdqB4JqXvpfz9JgQxxwAARicnvBoxtbIcIdHRnnDURJ77YZ53Hqd5CH3
	 VLIw5RlErzUYyCNXA2aurxM/byVrTldV3R7X2Uu13xq35ojXh2Si4EXt6Z4oDyVFlAmsm
	 9Tfv/GzYUgNtJwyRl0+MeZ/ez+C0V66SBR3KKmnqEPztu3a+/VQ0oTrctHoUW4+QhQUGQ
	 SFjX+/dLWHc2mkd5DoNVG8ahmDCryXvpQf9mtho2l3XNXryCLv8tNe5kLd2UR54ExvQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671539;
	bh=U6WKvRSTfJV2/vkLOQKZ9BSBRVqR4+3qxmfq47x6uXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=J6RapSkS4OvJlooWhTXoFjYgrJkRKZmwRSqoy8mCYyi8pFzX0iXxLRwQ14nq99xCg
	 a2/SYwZl2vjmXrwZtCmeDfVJLvmcv6uAghWBuvBuW9iaRFmHfz2mwiousKAks5Rc4x
	 R/XWAM06EzmCzKlXsd699UnpQNhoZQFuWP8gGjEXzEIiI/4FT49gLteOw76pzZmms7
	 I0VpTljNBstfU5mnSulblk7PKsi4ZAinzPPrKsOTcXgApeRddpqdj4/gw5MuHwt1pv
	 TxKIcwgJxU9/vtBadIggAfdboIscXYAqSy4UJ+pzQDcMHaVTiiVO/WRupM8lEjPcWr
	 RkCxId3ad/twg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46201605FD;
	Sat, 10 Oct 2026 22:32:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BFCDE105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A62F7400AF
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zHz9tTNDHTAk for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8821E4005A
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666488;
 b=ITcJz/h1Ob0Xhe3Dvqdquc9Pf8nCk4dwYw8t7r348ToqZdmfocYtv3d1vNXD0BN4/ZyW
 JkpRtGQCZtVO+0pdaxeNZlHmZzUikh3u/2KMzm0NbXk71gGpjzygEMKMgfE0ctv3Kwq0g
 Lrr0fRL14u+bFtAXLqdUhKz4z5FjVZoPegSHZF5dAibbuwVj83fElOfal5VOlcSoKpD6m
 JECjPRSK7FN5Nc9f1uxeHYuZauEkHbQNK8JF7UNdvQP09pxWvrdUI/+VYyj53xseqRODl
 UM7SuHMrTSLySAaJexQWbPUoks+iVFZr0TWYlEncQ1WBFMLx8Rpj5IKWME5ZuJt1giA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666488;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=U6WKvRSTfJV2/vkLOQKZ9BSBRVqR4+3qxmfq47x6uXQ=;
 b=O86GLuFsL5MI4u3U9pAA0XvQo7JE6Hab7AArhEkK+8uJZ7deKQB7TQz9v0tI9TnYSWw5
 iqjIqoD5zX7Ivdds510dJo8BZ6GfM9A2NyNQlnp1LlYkUIz3emPI4GXCAuypruaGqBOdv
 4HliaNHKhEQZ0ykvOv2fsvtou8+EizBfr4qAvuEMBYC9NtRAFS8u0OpLJHiRf4JVAwmnz
 7pLHgGOGjuP35qwHg9etNmFUAuuwURi+IR/Ivl/PZ0ml71J1NEV9j39leYTUwtN4zTvrH
 dp4sehPWOWaYsjQcUiwWeiQlIVSOUCry0wdf5GnOKenQ7D8MhR8OT71T20Gwm+q+/+w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RBNuqwOt; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RBNuqwOt
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8821E4005A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 38E9742B38;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17181C2BCFB;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=j6M4pPT392PCqcGsWMQHnBVW+QOXyMGiadon/EP6+LU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=RBNuqwOtqhgA9oP985g9ZcfvadHwPc/XmelMPy5rp+uj2bMJCyEUNTZXmndR9CrKv
 St1pAq9mV3jWWSxOTOGPu+o29fquUd8B3giuhIN+nVW5H9MMm1PIp2ucRzXnlIOCRz
 0NRKyvSdyKXtGS5S/pDwhSxsOLxqJ/w33/9Tn0hRejUcZPVdleOR1kmDoakdsMmDNT
 NhElDIe9qGhBbX2yxhnzSPgL9kZ3NWqipr5YCQMUX0IsAnQAGu7KqLoiiR1dPkLQFe
 806whzZBAwd2quN5ba/EUiGiZjW/TlGK+OWvp9g6KjNdXT5/O9x8hMFZncGv/x5txO
 LB8h4038YDXjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC0CA6017;
 Sat, 10 Oct 2026 21:08:06 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:49 +0200
Subject: [PATCH 01/11] cmd: phone_util: add poweroff, dfu_pwr and USB
 Ethernet commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-1-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=5321;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=ipns/rRhdwFduSLrtTa8xA4XHuqDuWoshEjGFZzNTqc=;
 b=WFSlL3FK83EoBqSQp68T+zXQCw/iQo4o9im0mAQl43aZ9EOyJXY7H35h7GIPYwndvhNXewZYO
 Ct/+yUCB643D1aRgoYhJEA9DcVdswFTibAqUj2QCDHcMHIizh5zkFyK
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add CONFIG_CMD_PHONEMENU for cmd/phone_util.c which adds two
commands to be used as menu actions:

- qcom_poweroff: power off via PSCI SYSTEM_OFF
- usbether: bind and probe the USB Ethernet (RNDIS) gadget on demand
- dfu_pwr command which handles power button press to exit the DFU mode
  without board reboot

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 MAINTAINERS      |   1 +
 cmd/Kconfig      |  11 ++++++
 cmd/Makefile     |   1 +
 cmd/phone_util.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de67..4b0b0b2f3a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -687,6 +687,7 @@ R:	Sumit Garg <sumit.garg@kernel.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
+F:	cmd/phone_util.c
 F:	configs/qcm6490_defconfig
 F:	configs/qcs9100_defconfig
 F:	drivers/*/*/pm8???-*
diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a19..09dbf73afdc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -521,6 +521,17 @@ config CMD_BOOTMENU
 	help
 	  Add an ANSI terminal boot menu command.
 
+config CMD_PHONEMENU
+	bool "Boot menu for devices with high resolution display"
+	depends on VIDEO && ARM
+	select MENU
+	select CMD_BOOTMENU
+	help
+	  ANSI-styled boot menu laid out in labelled sections, intended for
+	  devices with high resolution displays. Navigation reuses the bootmenu
+	  key handler, so volume up/down and power work through
+	  BUTTON_REMAP_PHONE_KEYS.
+
 config CMD_ADTIMG
 	bool "adtimg"
 	help
diff --git a/cmd/Makefile b/cmd/Makefile
index bbbdfcc4ded..762572156cd 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_CMD_BMP) += bmp.o
 obj-$(CONFIG_CMD_BOOTCOUNT) += bootcount.o
 obj-$(CONFIG_CMD_BOOTEFI) += bootefi.o
 obj-$(CONFIG_CMD_BOOTMENU) += bootmenu.o
+obj-$(CONFIG_CMD_PHONEMENU) += phone_util.o
 obj-$(CONFIG_CMD_BOOTSTAGE) += bootstage.o
 obj-$(CONFIG_CMD_BOOTZ) += bootz.o
 obj-$(CONFIG_CMD_BOOTI) += booti.o
diff --git a/cmd/phone_util.c b/cmd/phone_util.c
new file mode 100644
index 00000000000..1389b2ca6cd
--- /dev/null
+++ b/cmd/phone_util.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <button.h>
+#include <command.h>
+#include <cyclic.h>
+#include <dfu.h>
+#include <g_dnl.h>
+#include <net-common.h>
+#include <stdio.h>
+#include <asm/system.h>
+#include <linux/delay.h>
+
+#if CONFIG_IS_ENABLED(USB_ETHER)
+static int do_usbether(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	int ret = usb_ether_init();
+
+	if (ret < 0) {
+		printf("usb_ether init failed: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(usbether, 1, 0, do_usbether,
+	   "start USB Ethernet (RNDIS) gadget for tftp/pxe boot",
+	   "\n"
+	   "    - Bind the USB Ethernet gadget driver. After running, set");
+#endif
+
+static int do_phone_poweroff(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	if (!CONFIG_IS_ENABLED(PSCI_RESET)) {
+		printf("PSCI not enabled on this board - cannot power off\n");
+		return CMD_RET_FAILURE;
+	}
+
+	puts("\nPowering off via PSCI SYSTEM_OFF\n");
+	mdelay(50);
+	psci_system_off();
+	return CMD_RET_FAILURE;
+}
+
+U_BOOT_CMD(phone_poweroff, 1, 0, do_phone_poweroff,
+	   "power off the device via PSCI SYSTEM_OFF",
+	   "\n"
+	   "    - Invoke PSCI 0.2 SYSTEM_OFF. TZ handles the PMIC sequencing");
+
+#if CONFIG_IS_ENABLED(CMD_DFU)
+/*
+ * DFU with a power-button exit. The stock DFU loop in common/dfu.c polls
+ * g_dnl_detach() and ctrlc() on every iteration so a call to
+ * g_dnl_trigger_detach() will return us back to the menu.
+ */
+static bool dfu_pwr_pressed;
+static bool dfu_pwr_exit_requested;
+static struct udevice *dfu_pwr_btn;
+static struct cyclic_info dfu_pwr_cyc;
+
+bool dfu_usb_get_reset(void)
+{
+	return !dfu_pwr_exit_requested;
+}
+
+static void dfu_pwr_poll(struct cyclic_info *c)
+{
+	if (dfu_pwr_pressed)
+		return;
+	if (button_get_state(dfu_pwr_btn) == BUTTON_ON) {
+		dfu_pwr_pressed = true;
+		dfu_pwr_exit_requested = true;
+		g_dnl_trigger_detach();
+	}
+}
+
+static int do_dfu_pwr(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	int ret;
+
+	ret = button_get_by_label("Power Button", &dfu_pwr_btn);
+	if (ret) {
+		printf("Power Button not found (err=%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	puts("\nDFU mode active. Press the power button to exit.\n");
+
+	dfu_pwr_pressed = false;
+	dfu_pwr_exit_requested = false;
+	cyclic_register(&dfu_pwr_cyc, dfu_pwr_poll,
+			50 * 1000, "dfu_pwr_exit");
+
+	ret = run_command("run dfu", 0);
+
+	cyclic_unregister(&dfu_pwr_cyc);
+
+	/* Debounce release so the press doesn't cascade into the menu. */
+	while (button_get_state(dfu_pwr_btn) == BUTTON_ON)
+		mdelay(20);
+
+	return ret;
+}
+
+U_BOOT_CMD(dfu_pwr, 1, 0, do_dfu_pwr,
+	   "enter DFU mode; exit on power-button press",
+	   "\n"
+	   "    - Run the `dfu` env alias with a cyclic that triggers a\n"
+	   "      gadget detach when the power button is pressed.");
+#endif /* CMD_DFU */

-- 
2.55.0


