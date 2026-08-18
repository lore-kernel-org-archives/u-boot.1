Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9A6C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 16:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A5D7605DB;
	Tue, 18 Aug 2026 16:56:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5UZl6A_aLT43; Tue, 18 Aug 2026 16:56:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 828AC6078D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787072162;
	bh=J3Br7KToi7nzaw4pqmH0dXe6Gxqy4KP5txGEhbQvGxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=doTScicG8YjqNNksDh1dupj5ofeFZTkdg1O0INZ36nqi/txzh9ni15q3eVnl6mDnS
	 rbpys/6zKzKgB4gl3Q3oDH2ADcn42bNYX07J2zHUuUndL8wAi6cOuF4UcPw1EWM2dK
	 o+dz9pkpVF04ZkNQwWfRfa7INICbzOUWOZMDSWUDgCww6sgobX4uUm+gWxKX7URrh9
	 8Y5HsP/ZpibFX4Swj0k34wjhPX92P1lQ8gfBq7q+ndl8poM2J0vG5JR0qUora/mE6M
	 uV0ZWkJJNquGJjpXPpX9VBGU32xhhPwtv9cRCvPAfIA3s/Wz4LX80FYhrp1UhAhvqG
	 1uuRRTnbeSTlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 828AC6078D;
	Tue, 18 Aug 2026 16:56:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E0CB29B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83B6281175
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:56:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tntl35nVZXcw for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 16:56:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:201::3f; helo=outbound.mr.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 05DA980DBB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05DA980DBB
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=UcDI12IN
Received: from outbound.mr.icloud.com (mr-2002e-snip6-11.eps.apple.com
 [IPv6:2a01:b747:3000:201::3f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05DA980DBB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:55:59 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPS id
 E6FA21800F0B; Tue, 18 Aug 2026 16:55:54 +0000 (UTC)
X-ICL-RepId: 01a015cd-0ccb-73f7-bbc7-dde35c995849
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YBWQ9LVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEETBVIHXU1WDUcPWB5cFBcVQUNeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAV0FXQJICEACWwJeAEYXTwVZAVMEXQhVRQxbDlwEUBZfBEIrWxNVF0YJGQhdHQdYRxRHDg8ZWhRcGFM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787072159; x=1789664159; bh=J3Br7KToi7nzaw4pqmH0dXe6Gxqy4KP5txGEhbQvGxo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UcDI12INjFmGZnVNfW1DiW41BI4XN434eQQVG2aAZ73xzKENfhGkoIvjRk3pdfp4+KDxAPspBdu13U8sqWvwB8uiYSA3hI9tZd5wQD3umD9w/UhZSMXINdlYri0G/K39gnZd6Xigi0RNSbLY0QRlf7I1d6nSVu07MJd93ysK07LQIaG2RjTc/V8Eu24Yjdfti9/VGS/8Q1c7A67Dbgf83WKFTGA9DC3whMZ/SGRkEzQIrFYGYuU19Pw9M4wQcVkn0d3Qm8Dx72x6Ig1fhZ15BTlRsBnV7wcpJP1k6zQqU04rYtcIXxQO2oVO91TfEGxs7GfB8s2zvOOC6upKwDp7xQ==
Received: from DESKTOP-GUOEOAE (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPSA id
 D4FCC1800119; Tue, 18 Aug 2026 16:55:49 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, u-boot@0leil.net,
 kever.yang@rock-chips.com, sjg@chromium.org, jbx6244@gmail.com,
 jonas@kwiboo.se, Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v3] arm: rockchip: spl: Add hotkey detection support.
Date: Wed, 19 Aug 2026 00:55:26 +0800
Message-ID: <20260818165526.764686-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815183437.7387-1-valentinliu@icloud.com>
References: <20260815183437.7387-1-valentinliu@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=DIOCIiNb c=1 sm=1 tr=0 ts=6a848e9c
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=dZgUxksGFSRSUUpnT4MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX+NYx7ySx4oNb
 0DUgDuiXMtSxJErO79P9atA1bcJnlc4jmEmU4MSGNFDG8B4FnH7zz7TBEcdONdBO4W5CXEFuw79
 iZzs+LKc0sJ76j+/BTyNX51IFBYMPhARrwFlQK5vkJOd0VPZG40woXDFGyzgaxehWHtKJWRX/Dt
 EMYSyeQI8hlh6R36TKKHkPXWTERckCX87fH6CoBKIlVaapnzEMwE6e+0OE0nHR08GHF515UtIpA
 n/Kf5EKlKxlkur7i8Wylagid4Exc1Rm2jqJteNwUgs3nhqP/wofMmt02w5kyrLiNgzAKnBj9Cyd
 180jr153+D7BANcVtEcCTAglsbqK5bbT8pcW9TFWrhIF4iAmbVVUhc+Gr5mE+8=
X-Proofpoint-GUID: 0DH84RAFOHJo7_60dqkdLp7KONrOTCGU
X-Proofpoint-ORIG-GUID: 0DH84RAFOHJo7_60dqkdLp7KONrOTCGU
X-JNJ: AAAAAAABie0iKJ4Sp7xb0GqwbBy7EroIGW3KJ/Wa3S3cc8NIpaz7P8o3jzcFb5fdk4/N2us27dxhDgqReuz3RFgch08zzG/Zko4iltaGGtuhWFBTMpbsk+DuyWHMevN0goTY0abI2kI7+4eY82K9ELb6c+Cr1zfMYH/i4rllP5ZHW0ArwzyUcczbDCHzXLhdJCY8Soortxaq3nOKMKbVT021lRGTr8F9+GpGEty/+UzjSfHpg3zigurYvYvR2g+U30jHc6EcpS9N05yuioT82XdddFNhyc66Bvzy5ozh8XN1FdyU600YlOIwlhHSCfpYeJLfrEarOm/RZCbx09bFP2efBGSWZu5fzhQtB74ZxiZA6rtTpo00zASQRVAFlUKlIERn88/h6Cj+rFn7Pnn1+A2rvoS+o+EZUbNLRDpqEWJjpbPybZyeMOd4f2imZwcFDysYsqmuY/ziLKRH7b7Bi+LEQt5P1KBHq1tIO7AeDFljUPaiR5kKZliUMo+JcIqCMFf1QJ2fPCQfoXE0B3TxNs0np1USjE2tlgxDusRMqNhtSkp3bQN435nivI7j/G8FfJa6y42YuGs3/AizK1Mb/jlV+IZ9KFDnlsap50hBnCpLYB9nHa0PNskThvEWmSMYl2TyUHX+6Jf9zhGFKE5iQhrvI4NmhoU0M72teXheaX4cwPm1opifZ7zTJIp5U6wc2QiI62YzUybZRyAC04Oebj/Y+iVWfaoVehMNevtek6oG3QqAPHFyWPeji580M+Xc6EtnnELCMK0cxhvnmML3uakiJiP2IJ2/K8PcxCaz4vZ6qPDRDggXUkuQF6cD5EVvrHKAdHmcHpmvJirWTfx5wRHbS0M1gYR8kj4Sr4oymdMOzy0Gk1VmojY7Fe7sPrLfY9ktA0s/xTYbx4N/7lTGB5zuaN1y+1UvB5aGMF90rJoUmomInpl7cwTHkdtJ0KMTU+p9aHFEQlT9kC5h66JINbNOZnfqG+g
 6NnoMfN9P6N7pJmsgwh++jwkctnhqvJpvc5quzysWkMiQraadDMf1pIbJlI8bwjaXIzh2wBbTlgEE/fnMhaBNWgcUV6HxqGHrP9YPzlpK6zVvAf2hHLiprICNAzELBNCcFUADxDnHewKTHr2qUrM5jlNNfRotKQLtzgSilJDglg9Hc3oNViEZOQ3DnkS6km4vBtpJZUrCmztbv8M3mD+tykwacHBox8+2FbH/cWcJow3GOgeH9jwudJYLc3yyZMhOJnuB7wEr+ybTC+YRRYp/OWbQgDThpgyexjGUuI6fkMaQQ3u9APfHvbjo6YxnsT6yriXvWSbrDzlrEabRKPiaQgrBLldOmFAcWw==
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
---
Changes for v3:
- Add a dummy spl_hotkey_init() to avoid undefined reference errors
  when building without CONFIG_SPL_ROCKCHIP_HOTKEY.

 arch/arm/mach-rockchip/Kconfig | 13 ++++++++++
 arch/arm/mach-rockchip/spl.c   | 44 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

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
index e989c148079..0bcfb42c306 100644
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
@@ -107,6 +110,44 @@ __weak int arch_cpu_init(void)
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
+#else
+static void spl_hotkey_init(void)
+{
+}
+#endif
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -143,6 +184,9 @@ void board_init_f(ulong dummy)
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

