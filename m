Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1255DEA3F2B
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 09:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D19C8341A;
	Tue, 10 Feb 2026 10:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wkWSCzeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A3083CB5; Tue, 10 Feb 2026 10:34:11 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599988309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so29825625e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 01:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770716047; x=1771320847;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5sFpWSbv7L6f0JRkDaGpohYdkbu8BCxyEVPOeiAHTS8=;
 b=wkWSCzeUW44miM22IAYS4usuY6VeRyqopJ1mKqybNG8t7BdDEaMrzcBFU93RPZcJpY
 o9FAodDztT+pgfk/5y+AdbzXGOMmW4u8bZm7X5XQWuo/+oBJNP3LWI9bDJ9wH3yS17YO
 Gc7uaP6R4zE8Elti72TrghXQoZGhX6oLdvQhX8or78ga05uVFKw9BKuPaJtt7t9wj3KP
 38ZhVEOpB6OfrjTY0IqfYWI8dT2Q2u/NRPLMU3i3NbgmahrMYxC3aYwfwdJO6Y7Lo/u7
 +ZB+fXtIeRLqJI07M3/W5r0fgjgJPexR3qO+4Bh+yp6+hHwkEt632ND5SPMKcNxyQrcc
 eCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770716047; x=1771320847;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sFpWSbv7L6f0JRkDaGpohYdkbu8BCxyEVPOeiAHTS8=;
 b=oLSEAdu0gbJVLuPtoUynu0SUjj90AQvoxJlyTs/oW8aKesb9lrDXOr3f7xaDv0WScR
 Aemz98o8nccM3RPXc8OvljuPwUqc5c1gKV+PUv7Qsi2sGKdZwxrv8bxb+8Ynr9swRzvB
 xbcCyZ2wXc/BmkDFcsExPxPloegrl8W1i08tJ0nct+fCJkEI5dguoA+lzXVIaPPUPJZG
 RgupQo6iQLkAiheceoFzpulrwSMBdHUkLz9ImFa9paiWbfzepfKPngbaL59mGtga/du1
 me+E31SWKqwPQFluj/C2OmdH7BkphWyKTQNw8/WaWjnkvZSMJLymYSDkDVyCiQXULDvT
 f/1g==
X-Gm-Message-State: AOJu0Yx3/zPNhROsdipREtI4mTDx1cHOPu2phVi3bfAwAshdp6yWIVoZ
 mSfPGK9emNH07CMKk40m+JJ+o+dlwn7hDDVeDXxQHh7wnmsyBbcAHaJOLPVJin7GRAg=
X-Gm-Gg: AZuq6aIJToRR3bkurt8WrKe5FhQbEqKfbNlamCRdkAT7BwppLg9sU1i7TgLoPWC2AHk
 SLlE3cDswqducTFonMqS/Y0zWJdLwURyJHQ2D2QGW7AiipK2wCC7cS7UnbXk2krAWgd+KYbB2TC
 ZVW0m8Sp1pvaTlLUPDG1gbO220YfWC4693MGfShw3XD9QG5PrUsdppznqEQiiW6Uo9Co8Z2w30j
 m/Jqv3yF/9jweD1ZibGUcs3F2qDAq63wuX76AjSzd5dS8kTKFbQOoYLa61C+unnakqkna853Pve
 DG2XhB1DIK1haFRq6kQbPFtWOHlksH5W6yLngac/Y7CJdaSXt+GGizFS1uG+7TFIUOuwvjK1k3L
 Z71Yt7AKnD1+ZixSbR5/jX1hInhUuAIbhI92CMWHQCXCYZMxXEo8D5DjQBcSCN2uZMLOo89YRVi
 A3Gaxni3eW6/JIhEp0Anc8I0cp13snbx6MAGSwTkAOvpks9Hnr0cj647T44D++Uq0U+1jUPBpRR
 F5sk7ItIWWQeoAhfVQJug==
X-Received: by 2002:a05:600c:37c8:b0:47e:e952:86c9 with SMTP id
 5b1f17b1804b1-4832017dcfcmr204887105e9.0.1770716046667; 
 Tue, 10 Feb 2026 01:34:06 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e63b9sm39890715e9.10.2026.02.10.01.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 01:34:06 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 10 Feb 2026 10:34:01 +0100
Subject: [PATCH v3] board: mediatek: add MT8370 EVK board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-add-mt8370-evk-board-v3-1-faf40de5f402@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Py07DMBBFfyXymkF+xI9kxX8gFh57TK3mUZw0o
 qr675iURYUEy2vJZ865soVKpoX1zZUV2vKS56kO9dSwcPDTO0GOdTPJpeGSt+BjhHF1ynKg7Qg
 4+xLBRJm61iiOxrL69VQo5c8d+/p234U+zpW+3h8Z+oUgzOOY175BLYVCTDGgcEIiacFbaZ22T
 loihxSwSy6xR6u++XHS1ecIow8HCAP5Cc4niOfTkIOv18CbaNG2Wgnb9Ztk3z6HvKxzuezVm9i
 F/g/cBAhQQtVMraJr9Qv6y5Cx0HON2JkV/cAxf3Bk5Qiug+EmOR7DL87tdvsCZyveGJMBAAA=
X-Change-ID: 20260204-add-mt8370-evk-board-6d2f94630b67
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

This adds support for the MT8370 EVK board with the following
features enabled/tested: Boot, UART, Watchdog and MMC.

MT8370 is based on MT8188.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
This series depends on [1] for several cleanups such as memory map.
---
Changes in v3:
- Rebased on master
- Updated deps to v2 of [1]
- Added mt8370 defconfig to board/mediatek/MAINTAINERS file
- Link to v2: https://lore.kernel.org/r/20260206-add-mt8370-evk-board-v2-1-105c606f80dc@baylibre.com

Changes in v2:
- Add defconfig file, missing on v1
- Add dependency to [1], for memory map cleanup
- Remove board/mediatek/mt8370_evk
- Link to v1: https://lore.kernel.org/r/20260204-add-mt8370-evk-board-v1-1-3132f953d845@baylibre.com

[1]: https://lore.kernel.org/all/20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com/
---
 board/mediatek/MAINTAINERS   |  5 +++++
 configs/mt8370_evk_defconfig | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 5d19892e26b..5954607439a 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -3,6 +3,11 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
+MT8370 EVK
+M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
+S:	Maintained
+F:	configs/mt8370_evk_defconfig
+
 MT8390 EVK
 M:	Julien Masson <jmasson@baylibre.com>
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
diff --git a/configs/mt8370_evk_defconfig b/configs/mt8370_evk_defconfig
new file mode 100644
index 00000000000..48d3f64a42e
--- /dev/null
+++ b/configs/mt8370_evk_defconfig
@@ -0,0 +1,28 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
+CONFIG_TARGET_MT8188=y
+CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_IDENT_STRING="mt8370-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_CLK=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8188=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y
+# CONFIG_RANDOM_UUID is not set

---
base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
change-id: 20260204-add-mt8370-evk-board-6d2f94630b67
prerequisite-change-id: 20260205-mtk-mach-clean-up-duplicates-a6d7b7453179:v2
prerequisite-patch-id: ae9193f433954e32e91389fc1b144a3a6c31d518
prerequisite-patch-id: 2985130c9247aa746578d0999ef36afae5bfe81a
prerequisite-patch-id: d7f2bde6b8c257d93ae3155dbe51c2b1e956a87d
prerequisite-patch-id: 68791866bda399c0744095f456da7e5e50f50a48
prerequisite-patch-id: ea092efba54b2558bc7ea44d1a53f5f1a6f4f291
prerequisite-patch-id: 5f11d6653f725af32874115536d08e0772e2c36e
prerequisite-patch-id: 4875497d56eaf57175465888abd53de2738b1099

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

