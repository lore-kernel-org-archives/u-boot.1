Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7EBC5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 17:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65162606A9;
	Sat, 15 Aug 2026 17:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G_mXiH3ZZ2WR; Sat, 15 Aug 2026 17:09:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 860996064F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786813741;
	bh=s2Fyk41gP7vs5CNUq42bEkQcdwKFCfER0Afh5lwYMu8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O1V9EqWyGLz743YaKAigzMBs+thIBpVzxYDOXpznjDSooNO2mRSTsM2CWO3cJBdG1
	 moS048G5/Z3/xyOwDj7CVLTVlhHHBrprBU/f+li1pFCgmOM6QXywVc4YerKG+Tm8Kl
	 NIVDxVz6ZpsPt4qArc6KM6bqJWXLI/OidbR9ul1OSjpzUOkjNayXhbbAsAIRrJxN+D
	 yZIgvt+MUXtFXpWgQbqtgnbjyunwKGzOx74WMsyQMD+uTBsgd+QrxXB/eSXMWnhUwd
	 q0OdsZur+2NjlECD2AsaIv+b56gDAwrUxEV90BF4zCGcEqzZpEUYmuVtu+dDga0yS+
	 1YEIKzBrCJ6ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 860996064F;
	Sat, 15 Aug 2026 17:09:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8142E392
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67007809B0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXsd-sGwcT9u for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 17:08:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:201::1a; helo=outbound.mr.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B447C80BDB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B447C80BDB
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=w8CeC/Yj
Received: from outbound.mr.icloud.com (mr-2002b-snip6-1.eps.apple.com
 [IPv6:2a01:b747:3000:201::1a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B447C80BDB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:08:58 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 4E19C1801689; Sat, 15 Aug 2026 17:08:52 +0000 (UTC)
X-ICL-RepId: 01a00665-d586-73a1-a4cf-eeada906dc06
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YBWQ9LVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBE8TBVIHXU1WDUcPWB5cFBcVQUNeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAV0FXQJICE0CWgdTBkQXSQJUAVMGSRRJHhtWB1ceTRFdAV4echlaFFwYU0VRH1RGExlOG1dNUBtfAkIP
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1786813737; x=1789405737; bh=s2Fyk41gP7vs5CNUq42bEkQcdwKFCfER0Afh5lwYMu8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=w8CeC/YjLiT4cC6hOXKJ+n8N9RizJYy+qLuaurGXBRxR6Cz9Tzl6wp9gXrkJ4PK0g6RSpgd7NDxFJh2evU0Jd5M9HoinUs4dA3USnwdg4d95kcOXQqpVLhU4KO9cVJQqoWdqHcjV1y1Tf3wGN3j/wBrRtfMQVuJZdFYUPOiBeUl8/8jphR4+KkCc6n7KYmfjhsjd45a1ehYh+BP6VR/M+k/hCRuInq4TceTy9x3kZe9QP2bqHMfBwzmVb63OVimio2PSO3/W669JjrDUD09TAUvCdMtXZuXTzLoYOxPlemNT40fg7O2e4Gy/E+1XIOV7NZLRzhj+ESFrUq+yyY9SGQ==
Received: from DESKTOP-GUOEOAE.lan (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 36D4E1800174; Sat, 15 Aug 2026 17:08:48 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>,
	Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH] arm: rockchip: spl: Add hotkey detection support.
Date: Sun, 16 Aug 2026 01:08:44 +0800
Message-ID: <20260815170844.1196849-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iWdzq_MtZdF-d2FH9pz0DbvyVRwn287_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEyNyBTYWx0ZWRfX2bcWWW+DErnT
 TrfuKrSeyV66LIzlWcOt/2XoDpVps0IHW+4Psc18tTe2vfJxlcAiIWhfZ80/8OtU7efZcplR+PC
 CAwJCAMbr+bg4ctk0Uuqbsuw8nzSlfrDiHX8UKEeFdof2b1lihZGkcUcUDwfJG3TVnBq0n7fGmV
 gYkXOdYXqsJ8XqWzMcXhWwXidzImOF//5rF/Fvm6y5lbUd+2hX9wrtPJ3Dd8qubJH7jbHvoaRjR
 frFMnG1hEwlzn7j5wNvN2unbenv7K5dI8TBPbaE95lv6dYiBB/TSFV7rBu7sHFKqLTuvQjWGK2j
 41A20hKVTyfVdo0kphJkbZNCvy48CtjWnAl6iZkCa8Tu0nrAFCMrqTuM2CPetQ=
X-Authority-Info-Out: v=2.4 cv=ZqHg6t7G c=1 sm=1 tr=0 ts=6a809d28
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=dZgUxksGFSRSUUpnT4MA:9
X-Proofpoint-ORIG-GUID: iWdzq_MtZdF-d2FH9pz0DbvyVRwn287_
X-JNJ: AAAAAAABYQROhZke7AJTsd4oBB6Wdxu7yLeoF+8cVofY1V2LDIg+GZF0Rau3WpEVdTro7XJdI5FaiYxLqqrX4ge3friiQOvdvC/fOgSKH0YdXIektbdU9NxWeyi3Tn7BvPvzAoZtCjre+utWblMfjnEL7Vs+EZqKxUxgGUoqmL0T1wmwSr4eG3sQKerLFrTfH/QLJy5ZuOVi/14FqEUTD7F0q8yL/ln2qgsP3Jmz+hpIWC2LE6k47AHvneWnuker19vj+9GeIgaI0g8otS8uw4dBJiU0y5Z266BBZOnDtlhoJlDmV5LFyNJNYggMUIcZXK+Mv6t9/uJKniiCoM+jzXxDJnWn88U2hNTjzw84ny8BIrKpFGWo5J+0LCmP+e1XDsEMxvFsyoLFpgArPyTcMm9bOe+53+22bj4gQK34Ojb5KeDCmakMCCjAWgiYUmMwiP1tP4qpPnniG8lTUihKA+XtDWde0+9kPBw0w0pzJLoi0B4F+7MOR1dhqFCB+r5NZksrWV6qYRO056xFSfxDoy2sh9uaKmx9v7RSPzy3Zv9IA0a6kZUV68t2kyloMITtOKrmCnU7oruNk7GVf6ZaxUToaCt66EDU5vXiqphxk0MDEHguAvCIyIRevMjMBH3QnqHm69ZUj3au7UZF0eN0SeePuSTZn2Llxz6BereQIStxacTqNEiP0YAaXlpW8gVbzZFM5+NVW8JVRKtAKPHmTRFc1XJjrO/bAXZyTrEhtej7ev8YwRp+LNkuJw7EbXb6TLivzRYTW9XRZMupd6Stav8Y1xYPb+2hQLedWGX1XaLzsb0MVprVOl45cqJfE0GEoZ0GLObJGEE+HkHanyNkw6Vv+PilePw3SiwyvRuOnXHfE1iE8ySkID7g9cBez0iWrW8Kt/8GU7vIav4VdpoTvM0Udd15ZhMnoejSTZr3gjCDwsy5wTYD3WsbJ4o2gtD8krRmHsL0XvgLYctrnvdQDzlENgyyo/R
 Fh7tzH1MSlHOKGMhOWFqtg4x+sYnl1zPNkpeylo/kt9UBYsnMazQPgkZJdGvpoYmIJ7vKqO7bk5jk3g0yIoNeJqHYD1BEk2ZxhsZVYfvMMvADDXQpNnMh9XTW/495Qp0IUf+lnj8oEYXneIoUFBj3dqaHWLqsiw2yF+XHWveK8aQH6bBBCV+obfo41flPcOJlIDfVhybOA92JbNsy2QodYFHCtY8P0/OO1haDKuJdoSMZHQsSgtvB9YeL3ljaO2uTTw235j3gjAHyb9jQsBD8iWX5lLc7WCq5E9gyZubm7NPgY4mNXwAsXWpN4bVNQDUJ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a configurable Rockchip SPL hotkey feature that checks the
serial console during SPL startup.

Ctrl+B can be used to enter BootROM download (MASKROM) mode and
be widely used. We can add more boot mode support in future.

Add CONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for
the serial port to be ready to receive input before checking for
hotkeys.

Signed-off-by: Valentin Liu <valentinliu@icloud.com>
---
 arch/arm/mach-rockchip/Kconfig | 15 ++++++++++++
 arch/arm/mach-rockchip/spl.c   | 42 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e..a5de483bbb9 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -743,6 +743,21 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
 config SPL_MMC
 	default y if !SPL_ROCKCHIP_BACK_TO_BROM
 
+config SPL_ROCKCHIP_HOTKEY
+	bool "SPL hotkey support"
+	depends on SPL
+	depends on SPL_DM_RESET
+	depends on SPL_SERIAL
+	help
+	  Enable hotkey detection during SPL booting stage.
+
+	  When enabled, SPL checks the serial console for a control
+	  character and can execute Rockchip-specific hotkey actions,
+	  such as entering BootROM download mode (MASKROM) with Ctrl+B.
+
+	  The hotkey is checked after the SPL console has been
+	  initialized.
+
 config ROCKCHIP_SPI_IMAGE
 	bool "Build a SPI image for rockchip"
 	help
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079..46140e5af3c 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -19,6 +19,11 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#if IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY)
+#include <serial.h>
+#include <asm/arch-rockchip/boot_mode.h>
+#include <linux/delay.h>
+#endif
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -107,6 +112,40 @@ __weak int arch_cpu_init(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY)
+static void rockchip_reset_from_hotkey(const int code)
+{
+	switch (code) {
+	case 0x02:
+		printf("SPL Hotkey: Ctrl+B: BootROM download!\n");
+		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
+		do_reset(NULL, 0, 0, NULL);
+		/*NOTREACHED*/
+	default:
+		if (code <= 0x1a) /* 'z' */
+			printf("SPL Hotkey: Ctrl+%c\n", code + 'A' - 1);
+		else
+			printf("SPL Hotkey: Unknown code: 0x%x, ignore\n", code);
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
+		printf("SPL Hotkey: No key pressed, continue\n");
+}
+#endif
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -143,6 +182,9 @@ void board_init_f(ulong dummy)
 	}
 #endif
 	preloader_console_init();
+
+	if (IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY))
+		spl_hotkey_init();
 }
 
 void spl_board_prepare_for_boot(void)
-- 
2.53.0

