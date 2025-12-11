Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C696AD41D5B
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 15:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9BD83A5A;
	Thu, 11 Dec 2025 16:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="WY3hFEuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E8783A5A; Thu, 11 Dec 2025 16:37:17 +0100 (CET)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CD7835C6
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 16:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1765467433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jDVqPewuZE1BcNDCVahYkytsQRChkBx1yMC2B6BpfUI=;
 b=WY3hFEuUmoeYmrsrcSMgDOFacJ0reFbffFEV7dqf4St4vxY0LC0S3RxoislUONQRYrVCS/
 co9mgNwvPNV18ijaNMq4+TsYgBDDnBtiu7sxo/SRWiFDKV/D3ctH09TppbY4RRio3PWlkY
 JfO1DGMGKlJDbiaAO8bOhI/HA4sdNMxVjTQnarj0jQwT1oMQQ39r11rMFK7I96xMCCHwFE
 /GZnXV1YtnVB6fR2saFVNxty8VT/Tloi5G58gQ5Zmcu96VRqDhlS3bMzBB4/16j5NCEldv
 cBBKPhJngYr0lE1BtxlDWzDabkzyey52jX85T19doaXzYOOMkO632QZP8n4Njg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v4 0/2] Support EFI capsule updates across Amlogic boards
Date: Thu, 11 Dec 2025 15:36:59 +0000
Message-Id: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzlOmkC/3XMQQ6CMBRF0a2Qjq3pLxSoI/dhHJTygUalpMVGQ
 9i7hYlGZXhf8s5EPDqDnhySiTgMxhvbx8h2CdGd6lukpo5NOOMCGCvoDb3tqVaDv1+RKpAilci
 UyJDEz+CwMY/VO51jd8aP1j1XPsCybkkBKNAcCtEUVaYbicfB+vGm3AVH6/fWtWQBA/9AAL4RH
 hGRqrLCXEiht5D0jfBfJKWMgm5AKF7zTJZ/kHmeX2MyUzk7AQAA
X-Change-ID: 20251007-meson-capsule-a19539e0a54e
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=wdJihL4Qv6Rlxngb+g14G1wx0F6tuliKl3RwsyPIF6c=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpOuUnLTeQ0g3zg3P3A0KIvM5wErc4eNbE+WWaS
 FIx18Dn/HiJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaTrlJwAKCRCEr8vQ14ma
 A9HFD/9Gejl+erZ2C5a/WUr4Qx3mF/1qdol6o17yRfBblITY8OqsPi8Bd7iZ1oJnUEa+LNFBooC
 pus1y27WvBjjGB1g15ctDDDuE8RYClTxsqh2UocD+Agg4DOaHZpnCeiVgY8sIydepEV63nCrFRB
 NUvrqMKvHntJWKYSvyRRNkrNbFXzdy26qGD0PGtpmnQ6WonWDmvWrRLaXOEiFhiZXQimB8xQoms
 tNzsatW/14yrNZhCkve6unZXGW7+AyaXiL4BDJkST5lZYql0YCpWRaRGvcKdPPaNKulivFzXVG+
 6zgiixjL0K2+XjZYDwy0Gj1U8sP7QfipVVHVwQcN1w2Usz9z/oxhWmar3fS+zLjoI/iqpoTYjEC
 1Ptofe3yw50uB7+JtGDrkF4z60G6qxdhrIE3lHMU/R591gI3UpT6I5HOzsjaLN1DlALi/zgoQRb
 cnY8DWakRcmZuHru6gyUoDrwB4XHkI+4O5xMbhvQCsMYMXThndZ7vJQlj2dla0XNgKwjAv3w0p6
 N7U8tMJl//0DBpFPSIKG6NnwYBuEAKNauaqRA2uHW3hYkV4VvdX7+MbvTlPyui5ZDgv7yd9GxgU
 WqPWrzQi6xYAlWP16Uiikv+0G1mq6DWTJx/GMS6SQc+AI0wcQ8WJW01GuUou2dgEUZiHaBTy5n2
 JCWycPyBM7yb0Wg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Currently EFI capsule updates are only supported on the following
Amlogic-based boards:

 - Libre Computer AML-S805X-AC
 - Libre Computer AML-A311D-CC
 - Libre Computer AML-S905D3-CC

This is done with board-specific configuration in board/libre-computer/.

With this patch, EFI capsule updates can now work on most of the other
Amlogic boards supported by u-boot, such as the Libre Computer
AML-S905X-CC, without the need for board-specific configuration
beforehand.

Please note that flashing to the eMMC bootX partitions is not yet
supported.

(Also: with these patches, the Libre Computer boards are switched to use
the new common EFI capsule support. This will mean GUIDs will change, as
fw_image name is different.)

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v4:
 - Add missing R-b's
 - Link to v3: https://lore.kernel.org/r/20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org

Changes in v3:
 - Remove board-specific Libre Computer EFI capsule support and use the
   common EFI capsule support code
 - Link to v2: https://lore.kernel.org/r/20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org

Changes in v2:
 - Don't run meson_setup_capsule unless CONFIG_DFU and CONFIG_EFI_LOADER
   are enabled
 - Coding style fixes
 - Return when boot device is unsupported
 - Link to v1: https://lore.kernel.org/r/20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org

---
Ferass El Hafidi (2):
      arm: meson: add support for EFI capsule updates
      board: libre-computer: use common Amlogic EFI capsule support

 arch/arm/include/asm/arch-meson/boot.h             |  2 +
 arch/arm/mach-meson/Makefile                       |  2 +-
 arch/arm/mach-meson/board-common.c                 |  5 ++
 arch/arm/mach-meson/capsule.c                      | 61 ++++++++++++++++++++++
 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 14 -----
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 13 -----
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 14 -----
 7 files changed, 69 insertions(+), 42 deletions(-)
---
base-commit: 072264c4b3406aee50dad08355588577a547ab48
change-id: 20251007-meson-capsule-a19539e0a54e

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>

