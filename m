Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E43C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 18:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C6F480E2A;
	Sat, 15 Aug 2026 18:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eok7Uze0741v; Sat, 15 Aug 2026 18:34:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 624BF80E14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786818890;
	bh=hnK6yHaovixTBqvJhdbSlhutMh2Qp+EGTnWHpbZuZiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CdqEOth0gNkA3gwUYsnQltFAU62HYKCp4GU/+dZm+bqwBO0MzPPG3u1mgeZrFg12E
	 yMjG5+j07Xi2cwUxBQN9HQPnoIOAa7QF4+A9akY15se5nqdLLB5WQ1nvXos5xC9and
	 xUTIsM5DBqFPS4odhE0nDC9ro6V8O+BWGRWM6pNiWFfpson6RJ2n43x4XdslJvqQ2b
	 mOEap/oF+vDMeOduI0ON2sBK5fOssdbh15xW51zDxf8KB2Dulfl8gq26lDs1xriWkH
	 PkOGrH+lI0D5EmNWtvg3aJ486yKN5y8t9QjqK0FyQ8q5uK0XsA83KG4MZ6HiEIeMQa
	 eB1rQsdg21WkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 624BF80E14;
	Sat, 15 Aug 2026 18:34:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62F8B109
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4938E4082F
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9PaFUTDQ0Yjo for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 18:34:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:201::33; helo=outbound.mr.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9C5D84082D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C5D84082D
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=K7JZWPAt
Received: from outbound.mr.icloud.com (mr-2002d-snip6-8.eps.apple.com
 [IPv6:2a01:b747:3000:201::33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C5D84082D
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:34:48 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPS id
 C92D4180009F; Sat, 15 Aug 2026 18:34:45 +0000 (UTC)
X-ICL-RepId: 01a006b4-7880-761e-ba0a-f16fc2f660a0
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YBWQ9LVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBE8TBVIHXU1WDUcPWB5cFBcVQUNeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAV0FXQJICE0CVQRfAUcXTwBVAEYDXU8ZXwhZH1seVRFGLV4IXh9MHB0OWAYMUE0BQwgKAlEcVg1X
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1786818887; x=1789410887; bh=hnK6yHaovixTBqvJhdbSlhutMh2Qp+EGTnWHpbZuZiE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=K7JZWPAtICHvizhQZgrzpGMdIOAmEQ3WVU3rEQH2AF9F3X9gdaZq+JfkrpofhEm6Ezvj5kGguzuK0c/yiNUPOBqlCzYrnlmzv2+7zGskCFlPsNRp3zJvMngGpn//Wq679XtJpCXhUQV3eWEZv8P2V0T7avjiLNBSUt0L/sCoSkGGHPhwzm3kp6xQelnbmRIa/myfUEueq9YNHq5NS8wqZZLCSxB33iiZ2aUb2eHq2klmGFtr2CBK08LaMrU7K7dOJwcAbWgIerGmS9JeN8/IcoInxOYLHWk9NII8hl7iUd00GK2KrCg8hBOUScuIHr7WL/4yEkk327WK6gq5Td198Q==
Received: from DESKTOP-GUOEOAE.lan (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPSA id
 03AB81802290; Sat, 15 Aug 2026 18:34:42 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>,
	Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v2] arm: rockchip: spl: Add hotkey detection support.
Date: Sun, 16 Aug 2026 02:34:37 +0800
Message-ID: <20260815183437.7387-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815170844.1196849-1-valentinliu@icloud.com>
References: <20260815170844.1196849-1-valentinliu@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _3aouBFDIrR62I-hFvRtUk80NHQC5kDn
X-Proofpoint-GUID: _3aouBFDIrR62I-hFvRtUk80NHQC5kDn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzOSBTYWx0ZWRfX63193bKonKQ/
 edaJWkkD5MZUOSWtdwIIojRBoFZWX7IY6LWP6TGcSVG17znZfDKp/yOcorQeJmRZAF013cLQdaA
 vcKCeJFNDJXKYxVIHakZ5qAgoj0Fcit0AYasUP2jQOcMievZUeX7sjXzlJec55JwqpEgDVjuKkn
 TcFnicFtqgNZNWyWzjTW4nMlSyoeCbhPKY5r49uR4XM+JLCpkbOXK7acOXxf5GrITgMkIT9Wkc+
 QQpYBtLMIiznAerpIUiP0rJ3rQ9144nMM8zr6YIfDaQvtgOy4JPiPGWbp+Ox5rki4w64lCtHjd+
 lOMd15jWZAoivvIhNVWp1S5m2Fmyz3ox9BBYq1lduG4YS2AU9ynt4QytOnidgY=
X-Authority-Info-Out: v=2.4 cv=b8i/I9Gx c=1 sm=1 tr=0 ts=6a80b146
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=dZgUxksGFSRSUUpnT4MA:9
X-JNJ: AAAAAAABMChmwzpVJXsD1XMLgtJeSbGeWdcapd/GnJkU1DAoFKmhX/Nx5+1HOffyXjastpTI8MLh6R31fKJtzb+9Tuj8tewfHY/euKoTM68vDsCkZT4lm5Vn8LGTTobs8MQcAWUAw2ZUj8iiNT2jrR5TjbbxFufaqD02MnwwU0ii9Cj8DK/LGZcAuHsyg69aD7GTz5W6n7oxbbgkdMplk1jS8lnqer6UIlZBLeI0E/l/R/N7xIKcZTVZaQJJvlW00KARf8zGARRtGlQOOqh0pMMUczK5rcC6ZK/byzrGgkAN/ClKsZBJvKt433OiJ4SSiQffP7pYuzqMmruxZ2hawCCQLVKZwqyY/fNk/AVRzRBRlV6VK6yhLK0mkqVeHuzxdwhjZXFIfTW6qNyHMemfAGBAN8mVKcV+8QrjP4x637HxXYs5gCfnFDUnFsYvr5MKYQWFmlr8Gs75Q8k1mQpgwTIajjEOr8/Em7X7sIxaO+nNq1DbUOpLfQA7TPM5VsYYxbhWw0K5/gnBsX8rjvSPn6ZQVFvDZruL4UevT+jjmAoP5j6j/NAGulyDEhdALHZ265WYbkZdp1I2zEhEQ4d8Y3Tx3looCrtcdiw9Pp123mXQykwW2zc3lJbU/vmT5H7eXF+JpWFVCARm4dWskGrULcPqgqmLbr+9am/b8rDO1wso+A0ykmSprE+RuGD5xlXqzvdqIqEZP0OEHIipiU0o68Nn65fcUWFwhkzOciWRAMu5mhMw6K1GrJqX9jpkPyi7ajT5aR/Rlo5uTkq7Ng3Ulw0z2gehBx7StJCgiqHs/t6ydsDuGXwvHQcgwSw4DbOeh9e6WJ8jtUtwKNqu4NK8k/XZx77dVIwivXe5JvheN83qALW8KomgUY8nf/bAxk6NFkPg8z3YU/jtYNxabGUtUvEfhx6Ak0k5rcXOLSTgUX0NIiLOGYgILHnEF4S2fU/LJGvJx5JS/XSjPJ8kAk1h0osX32geGzH
 RMwJMVnDlweN4V77aJniaCmcLq4NbSdzieNqj8PdrkDworT1h/bZk2+YNpKKqNNY5mPHYVjOphQSACex66PY8idRQE5aeZlmYEpHAf5TcydxOlR0Z+B3vGFWxf9zskHzxfsm5BfaePa0RCmoZspC8vFjxdLdBRqwL62rJ76I5lQnb+CKgXK6HOoNQ6wgJz7GvyaXsjC9hzwjg+HkFsSNJi5h7XbCKtce2wYXUbh654664Fq9mX3u2dtPpn+jN+v/8Aog/IoM6urapDUVFumwrVxbSXXiXm+ReZ+RZbPoL/XdvaOf8RNJvAd/s7rA83TsSaEx1zwEcuf2K/SQsjgKL
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
Changes for v2:
- Simplify the dependencies of SPL_ROCKCHIP_HOTKEY.
- Remove the conditions for the newly added includes.

 arch/arm/mach-rockchip/Kconfig | 13 +++++++++++
 arch/arm/mach-rockchip/spl.c   | 40 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e..f2d2b5520ef 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -743,6 +743,19 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
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
+	  such as entering BootROM download mode (MASKROM) with Ctrl+B.
+
+	  The hotkey is checked after the SPL console has been
+	  initialized.
+
 config ROCKCHIP_SPI_IMAGE
 	bool "Build a SPI image for rockchip"
 	help
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index e989c148079..0422415b06e 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -13,12 +13,15 @@
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
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -107,6 +110,40 @@ __weak int arch_cpu_init(void)
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
@@ -143,6 +180,9 @@ void board_init_f(ulong dummy)
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

