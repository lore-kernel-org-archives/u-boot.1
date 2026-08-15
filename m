Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DE4C5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 19:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FEC080C98;
	Sat, 15 Aug 2026 19:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNRdcMB4BEMV; Sat, 15 Aug 2026 19:39:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9454180C43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786822771;
	bh=hnK6yHaovixTBqvJhdbSlhutMh2Qp+EGTnWHpbZuZiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JqwDG80Y6TtyKpyoJWrFl50Fq001VuMF76c7ZOTouYrD1ZIRyCysaFKjCkDkofzds
	 fcZRn4hu6FHAmgE6XRqKS+hY12Z21gNTlMFIIzlc5tgYFxYqp7VzPZp0yyRs3PWoRu
	 WNxuMbQVQKvxOLyM3OzBP/f0iqNJ038lwQvBkbMNRPu9rORFQLjIaO7dU5V+/Bs35L
	 EKgV74voKKgimG6GH1DWlmetMiIko31FCK3BmYiZ9tiILVH2spQiFpsEOcdi+8rINn
	 KLObRqJjCSIN5ftbEUjtObyrkIHaSEtlXi4s8fpJwNQT9EOn96IRWAFDSk1Z+KLe/S
	 eIMo1L/KeC4Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9454180C43;
	Sat, 15 Aug 2026 19:39:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B5A333
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 19:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08236407AD
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 19:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsBdfIgvRaMp for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 19:39:29 +0000 (UTC)
X-Greylist: delayed 4201 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 15 Aug 2026 19:39:28 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 71A0140770
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71A0140770
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=hlLJZTa5
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3006:206::35; helo=outbound.qs.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
Received: from outbound.qs.icloud.com (qs-2004e-snip6-11.eps.apple.com
 [IPv6:2a01:b747:3006:206::35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71A0140770
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 19:39:28 +0000 (UTC)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 4B29E1800123; Sat, 15 Aug 2026 18:23:32 +0000 (UTC)
X-ICL-RepId: 01a006aa-3188-7af6-85dd-0e8a244cf93c
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YBWQ9LVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBE8TBVIHXU1WDUcPWB5cFBcJQENeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVaDlsERxQXG1wAFwZbFAREAV0FXQJICE0CVQVYAEIXTQBaB0YDXU8ZXwhZH1seVRFGLV4IXh9MHB0OWAYMUE0BQwgKAlEcVg1X
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1786818213; x=1789410213; bh=hnK6yHaovixTBqvJhdbSlhutMh2Qp+EGTnWHpbZuZiE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=hlLJZTa5779z1J3/4crhCjf6LZONm1SFXVXO/yI9SkGFEmVnmCxoifo20mTntWYum/rtHCdJtf9uR/D7xodP24C8oZz9dBH53jE5XZSBrs9vvMg117aMbOpO0YkPzBu9vVqQVsC/agSK4fHC5279u4E+TPuhRO4JR05bMzuReW0NRml4YJfU0bnEcr/ERhtMI+cP86PiNP7FAxs0OkbYRsdlgOFQxPs6vhwWD9n/0eoHUXnthuM2WOPjiJh/6Vk88Kf+R5ABq6Xlu5W4/8MA6QD4eLrQws9UlV26JPHsfujO5tn3xc0oK4Uvj6YwhZn9I4O7hVFbOPjI2h3hODyrEg==
Received: from DESKTOP-GUOEOAE.lan (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 0121518004F9; Sat, 15 Aug 2026 18:23:28 +0000 (UTC)
From: Valentin Liu <valentinliu@icloud.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Valentin Liu <valentinliu@icloud.com>
Subject: [PATCH v2] arm: rockchip: spl: Add hotkey detection support.
Date: Sun, 16 Aug 2026 02:23:22 +0800
Message-ID: <20260815182322.5370-1-valentinliu@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815170844.1196849-1-valentinliu@icloud.com>
References: <20260815170844.1196849-1-valentinliu@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y1FN6PFlFhqUE0PGM6Gsd6Ydye7sX4hJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzOCBTYWx0ZWRfX1ytjeoSNyZF2
 tE2HFGnvDc4eorN3Zres095FidEfvteFahqB17UoJMimxsq81w+euBd2xFcJvq0BNZ5c07+ZCVh
 0C22f4VnpktPMkwioyVENZuG/uHO5YbEkxl7A/SreMzqFenSG7nChzhQ1MaIcmjsDkgWiaw9nJn
 ihQUwxDOUrCRqQ9J/vJKq5minTn/Am1ZxctoW0hfqUbk9pq2L8a8/hVXjo4vwlV3jBd9AuuRFZd
 B+CmTn1pEnMbW58hoH9a8TSi6ZHQ7/ZD8nF0jx4AdsG0hb0bq8pY8XPoYKK7o3De5Yd6OvQEAj1
 v5hY1jd8D0lk8sQ5CeFgaaPCJNMMt5Krl6H81vpgcliWUBab7pLV0DYccclcNI=
X-Authority-Info-Out: v=2.4 cv=EfjFgfmC c=1 sm=1 tr=0 ts=6a80aea5
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=LQAHsTbMm04A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=dZgUxksGFSRSUUpnT4MA:9
X-Proofpoint-GUID: Y1FN6PFlFhqUE0PGM6Gsd6Ydye7sX4hJ
X-JNJ: AAAAAAABXnUD/hpyRwMgE4uy+vKlnR+ha9xaqO9aDUOADUizHUAbjTRZxolyDaEaR7QcLFEY+/e87GWq5vKoFqh8DY75VvTpp5kjtnZ6k7gO6WfDm0psscfS10Dkbu3O2OS6KeIki3SGTBaXv79bxQazs4BeMTQhNIzB96/PIrjZovt7ZL4URAFI74h/HFhSE4C7AUvbuIzL9jivv6Lftg6MI0G0tEjjaIQgXfLgnQCYjPoQ7jWd0N8Z63QWsh45fo6p9TufLSK7QDAKEzc0SG13hvuZfi474YwPkAVlJm3ibmfQLlw8JWWjrmt70ecwoVBI2PSTcENhFc9KKNiHgcdaVIoPZWjmgrUfHpbpXs70/HB62Mgf2uxMzh8CBPvo7awp0IJdPLMdbKf1rgKyxTxGuEccC0MrgXZ5yZxF2aHeWeaKGWaGrpdJThebelpA3hgY2lK1prX1+Gdql68oUCasIx7q8HNzI+dD+d0ptBJSDhU2f+oiOlrWlipQHt8pH8tPJUvd78Lzo6evAgOSGj6PGWAYwjyRpAx4CnfVqfUBn4BXvGw/cILeGaaBGb8I9i0AJA7mVQITUDm5r55CSfnX0i3VbOoOLeXpIcYWTq5Mu4s2eXKokA8pC4kwkj9r68TOjshMIjCcZ8EteHtLgiOMLOaVxFH6Sr0xyhkXqLwguf7O6wYekpfEuUh/B3srDGahgQzq0AqD1xBDzOKxp/aNFhAn/gaFuLvnscXUxLLStuCeGwlPm7FpZ2lgcSm6qquAMayDDDFqCx7NXWglgiVCi8S55Tb68fNv6hqkBA71SBsQkQb0gNwFqCfcfY5RwGusGNcsCKN8oLpv4fC9lWyMMLRmhuLAWHK9EJTtrgw8uSImBmhgLr1CuH1zX+i+DyF/wZRZuxYeJSggaZLRznDwDn+uKXOQCJXd0WGi8RyfyeuBXlcj769L+bD1gpzJmWWnynNVvfHPzZX/1ZFt8bK6AIvysYD
 ZCi0MJUAEqSjnocif67akvrwh18rvVXGKTQyK/blcIA/fZKuy+mex5zRuA4La/Du4jyGyDd/LF5dcpXTrg6A/2Jy4e2jnlRC4BSEHO8V1DfQz2OZ4ZPFGG9vQ461OJEpEJCqKi9K4uXHSj0AqsXmvK2HHbCdHUkgYNSn2bfssvslAgx2Aa4HqHhmWlN1cK1dgG7NO3sKe6sOE4JE3+82vAdWVW8rcT0IGx6aQxKMverBYuvSCc2srnPeY0d9q7Z4jHs/U1M/Wb9x0HZMLUvU9MQpOsl3knt1N0wDgafp+hgr2PesWbc0daEM9ghE=
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

