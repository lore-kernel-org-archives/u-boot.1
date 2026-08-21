Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E68C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 14:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72263811A7;
	Fri, 21 Aug 2026 14:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPtZOMIWkEOe; Fri, 21 Aug 2026 14:13:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787321628;
	bh=GknP3OpHXBykakHT5HAmpWkybfxBoxwR8cmnSqRUzpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xvG6DkFzibiDkQKMOX9W/1tbTkhoBRRThigYlgnKUrobEPkoVPKZklC/sIFaMC6M4
	 mZyyL5WrthK9cXPzsta4102BCpytfFbqU7SlRCODB/+wbDDTLCutyF0AF9fQUGTPWc
	 CkImhADu80yW92z9y8qEQH4g1LDOcMouaMzmof2wg97JxXkfBSydIbuty2BmvN9xrs
	 gY0snRdWdXIDo15J36AMClpoTwuLEP9mAE3zFj7GX7ds499f7CqCguD+wMQgIYvStt
	 Sj4f1IsnwX4vBtf2VOx/cE8Jlz9KqNSfMiSw5rd30klH+SCoM8N9XhRNU2fM1qdThS
	 l4cKCZCGPJNxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DA0881193;
	Fri, 21 Aug 2026 14:13:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 88CAF336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 14:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E76D40CA2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 14:13:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cL5ZsQFgYb8p for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 14:13:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:204::34; helo=outbound.mr.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=OmvnSL/W
Received: from outbound.mr.icloud.com (mr-2006e-snip6-2.eps.apple.com
 [IPv6:2a01:b747:3000:204::34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE60440CA0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 14:13:46 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPS id
 A1D3618001EF; Fri, 21 Aug 2026 14:06:44 +0000 (UTC)
X-ICL-RepId: 01a024a5-3f7b-7129-9074-3f9f76d0c262
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YCXwBLVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEETBVIHXU1WDUcPWB5cFBcVQUNeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAV0FXQJIC0kCWQddAEkXSwZVAlsCXQhVRQxbDlwEUBZfBEIrWxNVF0YJGQhdHQdYRxRHDg8ZWhRcGFM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787321208; x=1789913208; bh=GknP3OpHXBykakHT5HAmpWkybfxBoxwR8cmnSqRUzpA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OmvnSL/WTIAoGBjzMRi0NljBH5eSrFqhtWZgDvyfZCRuqMfd1uV6OuxMjrj9C3hu5GG4fPaB8gzE7CLPOLR8Hrlm4gRCOarGSjvCylX/Z5PrNos/XiJlyYC/WQGoAYN+DcVKcEd9YwpDh2qSuk/nB/vWyRvAdN/lLV9d+5VJkujaYOI6OUK/Bty1nqBmW/mLJhhewGdA7fmkjhiHLfgXeG+s9DYQftGEpmp9urpyKS64x+Iceax52v4tZ3qK162twdO8j0iDXqOj+PhjiRKDidH2gzkvF66EPRAyjSK8ws0qcRZejBLCMOSEmZdgKRWylj9wKCygCyayDl08Ax8dlw==
Received: from DESKTOP-GUOEOAE.lan (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPSA id
 2844E1800ACB; Fri, 21 Aug 2026 14:06:40 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v5] arm: rockchip: spl: Add hotkey detection support.
Date: Fri, 21 Aug 2026 22:06:29 +0800
Message-ID: <20260821140629.358500-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820162757.665777-1-valentinliu@icloud.com>
References: <20260820162757.665777-1-valentinliu@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=VKDQXtPX c=1 sm=1 tr=0 ts=6a885b75
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=Zvh_IqAvKHogKX7maQ0A:9
X-Proofpoint-GUID: SlO5HJaOaGykga8XWfoQ2ydMrJhQnJBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX7abJlU3t3rdp
 pYIFa4ZOa58g+EW6xaY4cNgZpbht83yTC3WuJKXnQPXG38zaOzDi+sKSlrTjAhxy7aiSSBVzr13
 Psdn1k+KzkPf653skvMFXRywm57kGAa418FtkK0NvHP1fpmM56qpAZF9bw8/8xobcnXhLaSUV6H
 IDLY3aHzkxqFhmTQupY0RSQMactVkS84yKNFrMpf2yOC/ExekdQmQmvlDBVlBHuDtZURa+tjyrz
 wLK7HqBPA1qAZytkaGU7HyhQv+SGJamUKcxDFMj+6f+A221ldWEcEOBZ8k7CQzGvUVZHbaTecPA
 xtWJrNR5nrLkxujrap8VPm/FJkiout6r5mfDpIZ/ohM6AymAJ/NtaIgXH1Yv5s=
X-Proofpoint-ORIG-GUID: SlO5HJaOaGykga8XWfoQ2ydMrJhQnJBf
X-JNJ: AAAAAAABtCvHvxt4ddJNVQ0Pj6jGjeSyQea+U1h86p2Nv1XMwyixOPxam+foHO/XFwf8wXWfmqrJOUgjXU2v+bud2NoEaVunaJuAVu3k7/Zz5tJ58ZX/peVUflsAVa0yH0qLEsXw4ANAAX7X0kiXGaCD0qTkBsHF6hMXAbWxjjZJqWGt+UxKnq40YQHHxAhi1W6yKAYdDixzSkz7T8qLSQ9gXFB7jvNLc0j7Ab6LcJBOrUEVl5cpTR0wfp0RrghSn0gBLixyW2Wy5vPYRRYE1Mk726W40TkA9uI71f6cfRAL7Qu/rHWUbTnms3bUCoSvE0MXsw7TDIqUFKmptn8tEOOz8n6XEC+KY/MWLPgSJPasSc8lZW5rGPcUWsDxVWl68qKmqj71NUCa4l5BTOXiu1CYSC1hA96i/i/csDc642JdZj1/TOtOZFucYXU7mKWTv1vtdQSvmFlU5POKLV1PBuj/HEVozcSSlaTzDXzasvE4Ns5hakrZa7Ww7EewpKSP2l+BF1VoLKr/JIQpfO3GUBjco8r82ZQB0BdEPrbRmfCqtrM3sjM/qe3nnJFRdobBsbpZLf9r//ol10DKS8d6RWg+k8QFII3P3sJRMvmxlHQGEuh3Gh64rowbtOME3APhOdNO0Ux7+XXdzK2OxPm2GSOHmA+GAoU6vWOpcN+k3CAsd/KsQpC1hdK76zavj9HFWNAQGAKgu9MvY1HPEs9+KOXI53u1Cg+FmevCjHdmqV28IDUBjDMC0PMM9S8NTNwJbDhHudE7WY5I94dSKJ/xAfw6SyZ+ei5ghdCC11zIVRSVKok0cQeq4+GEenv61qRN25yna4gXVQ+UTHFurWeIYbatibmNAizlurzdYsZU1/Lr7mIQy7jW83SRkiFNFnv+e2MXjKEyvjKKrGz6ZGeMjhlROwdDOuAxfUcYqZ6aBIij1kBaWyJTw0Pdo+xGvlJmEWUMR8FTYbRWOZBNpjIZNkP8d1kWX0K
 5fp3Ah+J277wW2Dwq3GhOAMSOFUUXXGSclaJPxiEL2JXNFXWm1K4czvNOOyx/Nl3Zad1eOV+9WnFMVd9BxZRrWn9gW1kNrsCj6TcKShkCoquhjNRk4Jt/LKUK1u1Axi636gOU9Bwj8zKUox3paGTp0y4uFwp15I3Pw7+va99x7pD5uP1Sfiqloz5n9jfYn9GtHGnK8RPWxvC0tg3+KNn55EL3wjIkty/zEwf+LJhemX7zpvRZ7saTzza9+gW/5pGOZjTNyJO4N7wPYc2dLhS6Iarh/dITY1MsSD6nToblw3GqrjPnJXXis/xIKe1erjRpCmFFavAKAMByXstjPkeS
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
---
Changes for v5:
- Fixup the CONFIG_IS_ENABLED() call.

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
index e989c148079..b61ccc30a22 100644
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
 
+#if CONFIG_IS_ENABLED(ROCKCHIP_HOTKEY) && (CONFIG_ROCKCHIP_BOOT_MODE_REG != 0)
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
+	if (CONFIG_IS_ENABLED(ROCKCHIP_HOTKEY))
+		spl_hotkey_init();
 }
 
 void spl_board_prepare_for_boot(void)
-- 
2.53.0

