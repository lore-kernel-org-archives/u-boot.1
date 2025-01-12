Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FF0E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 23:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF1B805C5;
	Mon, 13 Jan 2025 00:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nBAYBOxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4E2805DA; Mon, 13 Jan 2025 00:58:49 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 831A880027
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 00:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e2766994bso1945743a34.3
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 15:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736726324; x=1737331124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LK+h4B+lmYFvnyUISlOsq+jhevVmItHBKidcbffGKDY=;
 b=nBAYBOxY5/WQj1jiuG/w8Di+UW2+kNkai0RZQc06Alr8/3SLq7xZbGDkV9P3hcYYmN
 VMAqi6HvcGj+9mE17HgK/dCqVsM2IlPCrXv9bAmMqzrjwbfauDc2DEOc9dRHgUwqw1F9
 O2m4Hn+s6KaeKKc8S/XFBLY6WAKJspiVdOyI65NC5g3jPyX9V753lMub4RRZXFkjSELn
 wsipTkTUMtk4RWxzSoI6N1LH2voD06WxSlzkjKiyhFl10S4EdcB9hbPN/aY1gVCWHT5b
 b2iShLcyc1+GDFC478+qOEUfVZ2HP+E7wtLAekrM5+etGsijr8xsQIdZ5T1CNU4eGirD
 GraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736726324; x=1737331124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LK+h4B+lmYFvnyUISlOsq+jhevVmItHBKidcbffGKDY=;
 b=Hr1jCHm+X8J+eZyj9ALd/+2Fj/tExRDLLN3NbZVjy1T52akzzVgjNV1g2DPoQ5+s7G
 yBj3VYN1OtsBheseD+FZ1h4VKO2V4hk0/+k4egdTe5AcYrurlCkRgA6NDv+c6HWJpgdV
 2aMyA71rmBBLfRLU58x/lR8zAdVbbzRUOYY3lI4usHJ+LhIGSsYLf0nVQlptxRWYYyNZ
 WSZFl2IWPomPBSSErxB9qyDE0yaUat4dtCZ8xRgfIP0nIU50J/szgivi4qixoaQpjfxE
 oEPamYvg1OdRxujLyWYkLRYMDdHchgQpysqAztaX0vwmGvp6mq1iVc1j/0vFCYhjZlM5
 o+gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhUpGv0XRgRtzOJk5Ma6UUjxS6Bw4Ghaa54gLhxY7BQdozoDdgse6s9Kp/7dGiu3iTrKnwDt4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1r1px2+gy1S3KaL6BBxgauHh9NzCU28OVczbhkwikuG7yoiQD
 PF6DV/5edS1E6lnxnr8DHkNbb8SN7JZOCrVwa4VrOjqPC8ipSDd0B7PklNA3QF0=
X-Gm-Gg: ASbGncvL0+jnnGCnXPdzj1A/6CIsd/0b6Ua3+Uc50QOfakZVWKpG10O3OZ+fMmkGMJz
 a2yP8KtrWlgu+ytyekBcIrd5wdkF713RR1uPScuw9+UVcCWqcVLukdi9hndxE9xpU0gQ9u4EZQo
 8zuLG2Je0yzg8LA87mSsTKgvxGYu3pjubLm8tIn30pCFNDYqA3AkvQfZJa76jNA/QmMC+3PIqhp
 /A/niVTX4HKtFiA262yhzeXhPB7EXcLImPqqstrFzoeeTb31xCb71PprD6XIfpG5D8=
X-Google-Smtp-Source: AGHT+IE2bxseI510gocPUwNk3pXYDIKseRbZKq8e/wKNv31r7kkE55k+s34RwL9MyHfMpQHc3Vk7aw==
X-Received: by 2002:a05:6830:470b:b0:71f:bbbd:ab49 with SMTP id
 46e09a7af769-721e2e2e64fmr12235776a34.9.1736726324213; 
 Sun, 12 Jan 2025 15:58:44 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f88266c381sm2867950eaf.22.2025.01.12.15.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jan 2025 15:58:43 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: [RFC PATCH 1/1] efi_loader: Call efi_init_early() even earlier
Date: Sun, 12 Jan 2025 17:58:43 -0600
Message-Id: <20250112235843.25738-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

At least in case of the E850-96 board all DM devices are probed in
initr_dm(), before efi_init_early() call. Eventually efi_bl_init()
registers the EVT_DM_POST_PROBE_EVENT event, but all DM devices
(including eMMC) are already probed by then, so no events are caught.
Because of that efi_disk_probe() is never called, so EFI disk objects
are not created and EFI subsystem can't function correctly, showing the
next symptoms:
  - 'efidebug dh' output shows nothing
  - attempt to add boot devices in 'eficonfig' shows this message:
    "No block device found!"
  - 'bootefi selftest $fdtcontroladdr' shows this warning:
    "Cannot persist EFI variables without system partition"
  - booting GRUB with 'bootefi' runs minimal GRUB shell which doesn't
    see any block devices as well, probably because EFI vars weren't
    passed

Move efi_init_early() call before initr_dm() in init_sequence_r[] so
that EVT_DM_POST_PROBE_EVENT in efi_bl_init() can actually catch all DM
probe events and create corresponding EFI objects. That fixes the
described problem and makes it possible to run EFI apps like GRUB
correctly, add entries in 'eficonfig', and makes 'efivar --list' command
in Linux rootfs actually show EFI variables.

This patch doubles down on the approach taken in commit 5e847f7729b3
("efi_loader: call efi_init_early() earlier"), taking a different path
than another fix proposed earlier in "Pull-request efi-2025-01-rc4" [1].
There was also a related discussion in the "efi_loader: more tightly
integrate UEFI disks to driver model" patch series [2].

[1] https://lore.kernel.org/u-boot/8910d434-2d77-425f-aa81-8eb803078aef@gmx.de/
[2] https://lists.denx.de/pipermail/u-boot/2022-April/481753.html

Fixes: 5e847f7729b3 ("efi_loader: call efi_init_early() earlier")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 common/board_r.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index f63c6aed4d5d..323a56c2018c 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -617,6 +617,11 @@ static init_fnc_t init_sequence_r[] = {
 #endif
 #ifdef CONFIG_SYS_NONCACHED_MEMORY
 	noncached_init,
+#endif
+	initr_lmb,
+#ifdef CONFIG_EFI_LOADER
+	efi_memory_init,
+	efi_init_early,
 #endif
 	initr_of_live,
 #ifdef CONFIG_DM
@@ -636,10 +641,6 @@ static init_fnc_t init_sequence_r[] = {
 	 */
 #ifdef CONFIG_CLOCKS
 	set_cpu_clk_info, /* Setup clock information */
-#endif
-	initr_lmb,
-#ifdef CONFIG_EFI_LOADER
-	efi_memory_init,
 #endif
 #ifdef CONFIG_BINMAN_FDT
 	initr_binman,
@@ -684,9 +685,6 @@ static init_fnc_t init_sequence_r[] = {
 	/* initialize higher level parts of CPU like time base and timers */
 	cpu_init_r,
 #endif
-#ifdef CONFIG_EFI_LOADER
-	efi_init_early,
-#endif
 #ifdef CONFIG_CMD_NAND
 	initr_nand,
 #endif
-- 
2.39.5

