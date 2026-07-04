Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F79C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 13:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 622F083FEE;
	Sat,  4 Jul 2026 15:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="cXOOAO0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFAB84119; Sat,  4 Jul 2026 15:54:13 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA7F8341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 15:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-92e52c9fddfso62506685a.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783173250; x=1783778050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5T9giRr+7Gh7z3OgL5oVe8bhtG3uB6TgHE5PsbvZKW8=;
 b=cXOOAO0KxyET6AiGaKNvSmB3fTDp9kJQX3JN4BKc4XhH2DQudVRPeU1Ddhd1GXvooH
 1nXYRdXQ5hSRk3VMLHqXd2EpuSrJjNYxCliMEDc7eTFPmUI9/ohaCaVrN1f2+d1r4Rc6
 hi/etzRtr3UREX55uZNECMDBJBcpntIjZXT+9b6cJv9tjg+gsZZHUPH3J5Bpg/EEONIA
 zLVB1lSc3s2Iv8UeurlDnk+jdKYm1oyXf/209iWN34jkIxLWJPi4Nhdt8aoBuI7XmnO6
 aqjiFrg9rta3sxqVuwDBGF3Pcdc+WaXEbbTvTj8FiUYtT/QGISnxWIEJLeAzEgTqwSXy
 kY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783173250; x=1783778050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5T9giRr+7Gh7z3OgL5oVe8bhtG3uB6TgHE5PsbvZKW8=;
 b=TUFGrv3s56V3Z4Zb3yNDFfeAF17obADexQy+M4y6w737iYbMe4Q3I1kRyDOkOTBsU8
 0YZRf5s4UJwQfDKqOEcZDCimHMkjenA8iSllujrxrA+st42BQqVUj0xueKsEmZeGBoC2
 //RkSAlk1gQfjRQMd5Q4jH65W7KjNB1DPqnEYUOelo/DP85BtUL4oFG9TzAok/M/A50v
 hfmK5Wp2d4vUteisrMgm7InpZ9fR8NrpZdckR24T3bLvMYRR5Cp+8f63tC28A3wTMryu
 AS5q4kfQn+WaK7TYTikB2BXHsDVwJExvNnk17dU5qkpYm85oN6x+ypFzFgaijVeT/bsu
 8Ogw==
X-Gm-Message-State: AOJu0Yy9kfmizY2ikvaLfIzH0ouAwG0ZCYjz5Rhk+Rwioj3H1IE4+0lj
 vlRRP9xqcmD0yfiYLFjM8z3HNQmbBFkxR69IqC8I55MEDBCNJhF3ZefAtvDRMCfEmo3jXoRFHoE
 z2Ftp6Tg1A/kv
X-Gm-Gg: AfdE7ckd27+osihbPXuAUgr/ZCid7gi4OTB8/QljOje9niPXAzdxGfuYX7igQlUek9v
 hJmV2evnt2iuvYfHWoEK4B17kJ6AxJcoqkID/1ZZ8MDvCTKmAKdRpVQS/4WKUQTc2m77huz0D+w
 vzZthWjcZwwUX5KLUXfTaYPA3ppC6/P0+tCOEFUFvLnFsK/W2Knai653lGCKPJZF4vrYMoGgkKZ
 Ns7bo42rPZxDrDgjP68eB3EVIsJTJvwuEIb7wQ+FBKZLQ4D+ySnJsSahVEy5pkh0rW3KXCuS5wd
 gLzE3rT6XQ9UcFUdbAD4QvBjkbFoLieUohLa1J596psH4+XoGxyz93Tv4lGfVGA2dBvyY1lkONQ
 9x8V/1qmWb95mioZnfrk0cg6rw8G7yrvD/RfUfXpj76ytfBhXnrnuc6KNFSw8mbLHnJ76IDmVmJ
 24JWaYSstrhRom4TDa0chaYWE=
X-Received: by 2002:a05:622a:e19c:20b0:51c:1d67:379 with SMTP id
 d75a77b69052e-51c4c21bc49mr35054071cf.23.1783173249947; 
 Sat, 04 Jul 2026 06:54:09 -0700 (PDT)
Received: from macbook ([45.144.113.217]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41abe73csm44657011cf.5.2026.07.04.06.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Jul 2026 06:54:09 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
To: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 trini@konsulko.com
Cc: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH] efi_loader: stop watchdog devices in ExitBootServices()
Date: Sat,  4 Jul 2026 15:52:29 +0200
Message-ID: <20260704135258.68543-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

U-Boot can autonomously start a hardware watchdog
(CONFIG_WATCHDOG_AUTOSTART, default y) and service it from its main
loop, but the EFI boot path never stops it: efi_exit_boot_services()
tears the devices down without calling wdt_stop_all(), and a watchdog
driver without a .remove hook leaves the hardware ticking across the
firmware-to-OS handoff.

An EFI-booted OS that does not take over the SoC watchdog within the
remaining timeout is reset mid-boot at a wall-clock-dependent point.

The UEFI specification (v2.11, section 7.5 "Miscellaneous Boot
Services", EFI_BOOT_SERVICES.SetWatchdogTimer()) is explicit about the
one watchdog it allows across the handoff:

  "The watchdog timer is only used during boot services. On
   successful completion of EFI_BOOT_SERVICES.ExitBootServices() the
   watchdog timer is disabled."

U-Boot's UEFI watchdog (an EFI timer event) complies by construction. A
platform watchdog silently surviving the handoff defeats the purpose of
that rule: the OS has no generic way to know it is running, let alone to
service it.

Stop all watchdog devices in efi_exit_boot_services(), before the device
teardown.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/efi_loader/efi_boottime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index de57823bd44..9588d9b9739 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -22,6 +22,7 @@
 #include <u-boot/crc.h>
 #include <usb.h>
 #include <watchdog.h>
+#include <wdt.h>
 #include <asm/global_data.h>
 #include <linux/libfdt_env.h>
 
@@ -2245,6 +2246,8 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 		if (IS_ENABLED(CONFIG_DM_ETH))
 			eth_halt();
 		board_quiesce_devices();
+		if (IS_ENABLED(CONFIG_WDT))
+			wdt_stop_all();
 		dm_remove_devices_active();
 	}
 
-- 
2.55.0

