Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B84C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 17:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B370360871;
	Thu, 20 Aug 2026 17:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 95f00adUvj2G; Thu, 20 Aug 2026 17:04:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787245491;
	bh=9PQuqYB+CkIi2VU/gDJ1c4xmFvmVGPRo869ViYDO7+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g6W4FuTT0Nr/3Xz4y6y93Uvi7japP7oQH4MCmDlk00Hp4qC/eYcMv7ss+mlG/+9bw
	 JVe3HuHBL5nQb0A8mQfCsbK/ybr2lyTfC4HIr76QMapyNLEXafOUe7WoHhA62sLZAq
	 EJdohcNjP+ZFUYhJw6kVxSrTy1784TtNnieT8wodWs89tvSKOO1YQAZIGenmJdXMn5
	 EMsMYD/+b2aTED7TJlunczWJWmmDcbCgIGIdSt9KX8s9qKt5pPI918SHKnNWOn7xQ8
	 +Ha8VFua05RdbK0n5YAea7wsbtwzq2n9J6JGdF03o53b55Kl0oCCWOjMk+8XY6pHPz
	 y9gNwko7wECuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E71CC6084A;
	Thu, 20 Aug 2026 17:04:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CDB88279
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF0AE6084A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4LKUpe8ghYP for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 17:04:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3001:201::5a; helo=outbound.st.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com
 header.a=rsa-sha256 header.s=1a1hai header.b=n6Zm8N+2
Received: from outbound.st.icloud.com (st-2004i-snip6-10.eps.apple.com
 [IPv6:2a01:b747:3001:201::5a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0DD160823
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:04:48 +0000 (UTC)
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-8 (Postfix) with ESMTPS id
 979C2180012E; Thu, 20 Aug 2026 16:28:10 +0000 (UTC)
X-ICL-RepId: 01a02000-5f78-7192-ab2d-cd5539a2a277
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YCXwBLVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEETBVIHXU1WDUcPWB5cFBcLR0NeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAV0FXQJIC0gCWwVcB0cXTgVYAFwFXQhVRQxbDlwEUBZfBEIrWxNVF0YJGQhdHQdYRxRHDg8ZWhRcGFM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787243294; x=1789835294; bh=9PQuqYB+CkIi2VU/gDJ1c4xmFvmVGPRo869ViYDO7+U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=n6Zm8N+2Rqy2iCeoL8wIfpEMf3dB5+E+m2PEyuBGiWSc9F99RPgYGkZucNpcyuDFPf4SjgP0kQ+mqG908cRlW1uX141De78XcZ6zhx6xSJhd5nI+PbAY87JNEeSv5kZe21yTvnkeDubEw9aqtUbZ6zcQVm4MI9LU1j1jQ+W40Qoydi8BcqoKQUc+zTAsH2DCHsd6kvNXGANsaROtu81nXqOoXJQLXjQPG3OtmUk3iqBC/R1PKwwCxhia0M7vG7nY3ot4FW5eVCrrG1gteyfNmZjwnVcxV+dlGt4e1gr/FDoI7jh7veXlMOVuD/AIPMLnfjZOBLa4TCKg4Q18MvROgQ==
Received: from DESKTOP-GUOEOAE.lan (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-8 (Postfix) with ESMTPSA id
 B9C8718003E9; Thu, 20 Aug 2026 16:28:06 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v4] arm: rockchip: spl: Add hotkey detection support.
Date: Fri, 21 Aug 2026 00:27:57 +0800
Message-ID: <20260820162757.665777-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818165526.764686-1-valentinliu@icloud.com>
References: <20260818165526.764686-1-valentinliu@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IKro9RxyT4rSMs3lARiJIFIHhZIA3t8f
X-Authority-Info-Out: v=2.4 cv=LOxrgZW9 c=1 sm=1 tr=0 ts=6a872b1b
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=Zvh_IqAvKHogKX7maQ0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNCBTYWx0ZWRfX8IwpZEXCbV59
 IoFNS+huL3xhWjCxjwRbyTpTQA0zCHzmXCXj0GRN1VMP8lUqJvFCeYv8y2SYodb42+/9FNSevYH
 ir3JrcrZNkgdODJsdrOUPW9JtYKQ6vOqaHTZnQAPxVwRVhFYm0Ze3jGOktUAWNHu9IuElRk6Wpj
 21th0jXD38GdQAg3uZwkg0bRj6i7ia7ZAxH/xiy2gcgdSfWdvu0fYIZ5x9kW52VVtGUwrRIlzt9
 6FhIXRL18bC+0AQH4krDGtQdE+lEWVWjI2G8tQ1GfCyFU9+nmsFiiqNdkHQVN8T8lNR54ibJyXI
 /0JePQ/utyr0crWK5Ic8sO1IX2hJp0SPDhKht3FVsT321LC4eUTArSHYV8YRBE=
X-Proofpoint-ORIG-GUID: IKro9RxyT4rSMs3lARiJIFIHhZIA3t8f
X-JNJ: AAAAAAABgJhGiKqlAKZOu10+3Y8w+krylEIM8brwqKS7f/mtkfGhYkp7Lwqbc3zmk16wub+rb+to9pQwO+59nE7mJNJYuvl9UXNoRz2fPPE2UEmBBCRLc2RKAtV+sucNpQ0yaKJbQxYLXu3KQoeM3Y5iQRPS494UPZD+c/AtZEcZHQVFsxoaehVsCyA1ImtKMPoSwi/tr+usPgoXd8VJSQfGCm0cnQvIKENf0JmujKvCT2/KIMe74tdYsy5JMyKVSBp36w1WzBbLo9t66mPXkveGDeHSm/GXnMM8ZXjUKa0dzljjYNB118qu8kgcIpHsHI/i0jPJaAnl38L8RFHGl7pN2SJE1c5lmc7YXRCOVNfIclgKIo12EKGOtO98+pnrlgbE1iYf7fFvr04w4GnhSfGFk/Q+NsGuuNtyKPCz7fNG3KHfyGKLBV3npGqUCAxIPw7eq+L8Wdtbp79laWeEgM3PiVgwoYjkqDb1bvfo1TZJ3GjeaL+bBD+/teHqQmpAA/u6fNPf8barg8H9oRK63rEUZ2o9UGf5MSf5NfrHvPSb975y9fcZwcxNcAOE9En06R+QHeEYi/xcABWwLTBKyAlN+VWd7fYZQcEZK6q/2lJLM6lbD9yEVmE1S+lAOTueiGY5gBV7eqXFVo+bf5whoNqomAI8RhFikFOW9udpD58MMxV2+EqaKHyonKq4UGRgCSYBOpqdCLTxZ4hWZns+9D76WPvikOQZWlHY9H/RUSRncu8dGWMRiYZK07h/Qfl99bDiwg+IFDENKRH04Z/GIYO/+a9nHlTlX/U4xDKGYapp4N3Hg2+d4aFraniFXP0+3xl+Lau2Hr0U15X4u4hnGlgJd68sDPy73hzUYdImHvjndfsrJ0bVamDQc4pbsJ8nprTMMn4zN+Sc36eXeEJ5KP/cKaOCEvgDHvRfeInD9gd1b5TjH7FcZPTwbqIw8cGW8M3Z3Z6YaWzde2SOCXa4/FLXIYgRzjP
 pL8HisHTdYlUpQES6d0MyMx7iRw/3Wu+hqcwxOpi57TsOCBoH0UWnapaHu03UfJ8hqdNALbuhBEkFVrjiijYQ5iriBNhkD/hLxG1h/aO9maNt39r54jPd5X33VWSZn72GSMtacI4ZTgQFuljLpFk/F+fR7/UV0HuzBDVzxAXrli7KZfnHoblamEfrW1+YirREhJPzNplJfb3JKHBNCH+qrUEUDBLryJMhR0Szpm83noYgDo4P0sXnGMx5VjwiQ/5W+RMD7fo5xAz+eNAj00KTyJmBc3K3NomxYjeXFn6y5j0jCKa83JUAe9G8SKN2UFDiNeQ9XoLMVdRiWCUCgh7dMQZk+X6aUqnC2RvTjD505w==
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a configurable Rockchip SPL hotkey feature that checks the
serial console during SPL startup.

Ctrl+B can be used to enter MaskROM mode and be widely used.
Ctrl+D can be used to enter Loader mode, Ctrl+F for Fastboot mode.
We can add more boot mode support in future.

Add CONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for
the serial port to be ready to receive input before checking for
hotkeys.

Signed-off-by: Valentin Liu <valentinliu@icloud.com>
---
Changes for v2:
- Simplify the dependencies of SPL_ROCKCHIP_HOTKEY.
- Remove the conditions for the newly added includes.
---
Changes for v3:
- Add a dummy spl_hotkey_init() to avoid undefined reference errors
  when building without CONFIG_SPL_ROCKCHIP_HOTKEY.
---
Changes for v4:
- Add condition of CONFIG_ROCKCHIP_BOOT_MODE_REG != 0 to prevent
  SPL hotkey be compiled and used on unsupported platforms.
- Add more hotkey support (Ctrl+D and Ctrl+F).
- Remove prints on the standard path.
- Add some code comment.

 arch/arm/mach-rockchip/Kconfig | 14 +++++++++
 arch/arm/mach-rockchip/spl.c   | 54 ++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e..0e485e8caf6 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -743,6 +743,20 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
 config SPL_MMC
 	default y if !SPL_ROCKCHIP_BACK_TO_BROM
 
+config SPL_ROCKCHIP_HOTKEY
+	bool "SPL hotkey support"
+	depends on SPL_DM_RESET && SPL_SERIAL
+	help
+	  Enable hotkey detection during SPL booting stage.
+
+	  When enabled, SPL checks the serial console for a control
+	  character and can execute Rockchip-specific hotkey actions,
+	  such as entering MaskROM mode with Ctrl+B, entering Loader
+	  mode with Ctrl+D, entering Fastboot mode with Ctrl+F.
+
+	  The hotkey is checked after the SPL console has been
+	  initialized.
+
 config ROCKCHIP_SPI_IMAGE
 	bool "Build a SPI image for rockchip"
 	help
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079..8d0f605040f 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -13,11 +13,14 @@
 #include <log.h>
 #include <mapmem.h>
 #include <ram.h>
+#include <serial.h>
 #include <spl.h>
+#include <asm/arch-rockchip/boot_mode.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/timer.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/delay.h>
 #include <linux/bitops.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -107,6 +110,54 @@ __weak int arch_cpu_init(void)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(SPL_ROCKCHIP_HOTKEY) && (CONFIG_ROCKCHIP_BOOT_MODE_REG != 0)
+static void rockchip_reset_from_hotkey(const int code)
+{
+	switch (code) {
+	case 0x02: /* Ctrl+B */
+		printf("Ctrl+B pressed, entering download mode...\n");
+		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
+		do_reset(NULL, 0, 0, NULL);
+		/* NOTREACHED */
+	case 0x04: /* Ctrl+D */
+		printf("Ctrl+D pressed, entering loader mode...\n");
+		writel(BOOT_LOADER, CONFIG_ROCKCHIP_BOOT_MODE_REG);
+		do_reset(NULL, 0, 0, NULL);
+		/* NOTREACHED */
+	case 0x06: /* Ctrl+F */
+		printf("Ctrl+F pressed, entering fastboot mode...\n");
+		writel(BOOT_FASTBOOT, CONFIG_ROCKCHIP_BOOT_MODE_REG);
+		do_reset(NULL, 0, 0, NULL);
+		/* NOTREACHED */
+	default:
+		if (code <= 0x1a) /* 'z' */
+			log_debug("SPL Hotkey: Ctrl+%c\n", code + 'A' - 1);
+		else
+			log_debug("SPL Hotkey: Unknown code: 0x%x, ignore\n", code);
+	}
+}
+
+static void spl_hotkey_init(void)
+{
+	if (!gd || !(gd->flags & GD_FLG_HAVE_CONSOLE))
+		return;
+	if (gd->flags & GD_FLG_DISABLE_CONSOLE)
+		return;
+
+	/* Wait for the serial port to be ready to receive data. */
+	mdelay(100);
+
+	if (serial_tstc())
+		rockchip_reset_from_hotkey(serial_getc());
+	else
+		log_debug("SPL Hotkey: No key pressed, continue\n");
+}
+#else
+static void spl_hotkey_init(void)
+{
+}
+#endif
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -143,6 +194,9 @@ void board_init_f(ulong dummy)
 	}
 #endif
 	preloader_console_init();
+
+	if (CONFIG_IS_ENABLED(SPL_ROCKCHIP_HOTKEY))
+		spl_hotkey_init();
 }
 
 void spl_board_prepare_for_boot(void)
-- 
2.53.0

