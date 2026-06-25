Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C2FCDE007
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D83849F0;
	Thu, 25 Jun 2026 14:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dh2bAdrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E81B84894; Thu, 25 Jun 2026 13:55:23 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 874C58460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 13:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jakobunt@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4922244f7c7so19191995e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 04:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782388520; x=1782993320; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7/LKdzfdk67aRtpqP1RDK1c3dG1t9Mo3djwDk0CSedQ=;
 b=dh2bAdrW0+pWYGgM7bi+NNv74cecsJnSUjA81s12wABXKPL9OgHI050kbiYvyqNaEB
 zSirTCQmyHaPWgz2kac9f6LwG86f3KuhOHk/4zLnEDO/xnsQAt3iO+t04h/Asupd+Y25
 cmc73s3xHEXz87HWawioK8fjfvhk3qGPm4RI9eu4LnZci5fsugYKtn90O2v9uvEUY90O
 didSNz/PaPQl2BZwpKo0oSflhByX9A5ZfRIduJi7wGbkSZfxD+UyeUI5bDQ+/CuCFXeL
 POmLt5+7YpU81Ztjqmx/PWh6pp43nX0gd2Eu8D5DbG9MmVk3EFmBosJbHVm9lpXuutTj
 YW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782388520; x=1782993320;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/LKdzfdk67aRtpqP1RDK1c3dG1t9Mo3djwDk0CSedQ=;
 b=knzTbNJVNjeE8v/tQEfUkAugTdBi4TbaOnTC6PEXaBGkfvoPu3tJ/djVfltsdBeAMw
 mHRUFu7PnZ/vJEzLtozsqPSPtRJY91a3+d45G6akZyOJwz2/4gqR2UhBy1hUyBqZEsAa
 jWU+GyxLdsVT0p/jZf5ChcFn3AjOMKACeIeSbZnrC7zzJgKJOldut+s6IQnta74Q4/0J
 qTYMsR+bz/HBrn7kBEfSylXqPYKRRwobO3MOMyyvlZkFIFRMjnmLkVPjs7jVparkFGci
 5hfMx8MEILqGPk6NByUlOBHzxkGXgs18mAe1l/Fu+ksT0AN8p7NH46ZRgZ4gFVvWPTsz
 8BZw==
X-Gm-Message-State: AOJu0YxJTvOidedKkCB9VXuO2CP4evj9wEgexXcSh42VL2v9KWbdDuCW
 FbqlF1QfFludJbw72uayokTQ4MLPpEXhzO4C4MCcPrXqFWvUNRnLOzxa
X-Gm-Gg: AfdE7clEJ+ZIzvvGBNNm9DDRa/GvOoSBdB9m/bODamSonRC+yDNweXaxnouVQgxTUY3
 oI5MyzoJbEErSFanUfwK9f5kml9DUhbXDSDrTQTzUNQO+yPZrkcZ0gHv5KGHHJ9NavTalF8KDLd
 +oJUw2ZJK7IdjOvTBUKynA8HUuQMuBQAfIZvzqBJh2CwjA/HBAJlocGz95CICDEDBLHEEHkfYPm
 ltV2ky9e0MJBadQfBPOZQcAM7wrZzTH8q29rqKN7qLIApZHOzBtDJNoOb24PGozkMjP7kKzv4y9
 NnSNmUHjpME905qMIpFLEj0XpBgq+QA6C9olG0ZTfQ2a7iESznH+AwQFGisamiJ3XiqRm+WoHzG
 vQy8lIBpbLijNU24H9XmhILzuu/N14+qtoMlKi+iUyiTvcxBd+fdxISKiOeVPMh214AwnI0q63I
 XLJs8UWKFokrTVb8OHeFj20GBcqy6hRAEy7bk4irEHVElJ6dLkuYH5UP/RsSWb6lLE2bdJ
X-Received: by 2002:a05:600d:15a:20b0:492:465a:7e5b with SMTP id
 5b1f17b1804b1-4926687e816mr23458095e9.22.1782388519729; 
 Thu, 25 Jun 2026 04:55:19 -0700 (PDT)
Received: from [127.0.1.1] (ip092042140082.rev.nessus.at. [92.42.140.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49264082417sm72892825e9.11.2026.06.25.04.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 04:55:19 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Date: Thu, 25 Jun 2026 13:55:15 +0200
Subject: [PATCH v2] board: rockchip: set M.2 NVMe PERSTN low in
 spl_board_init on Jaguar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260625-pub-jaguar-puma-ringneck-tiger-v2025-07_nvme-v2-1-c57bf1020d63@cherry.de>
X-B4-Tracking: v=1; b=H4sIACIXPWoC/yWNUQrCMBAFr1L224UYTQteRaQk6Rq30lg2TRBK7
 25a/97AY2aFRMKU4NasIFQ48SdW0KcG/MvGQMhDZdBKt6rVBufscLQhW6lzsigcQyT/xoUDCZZ
 6NKi6PpaJ8GycJ3e5DqYjqMpZ6MnfI3d//DllN5Jf9gZs2w+1MgFRkAAAAA==
X-Change-ID: 20260625-pub-jaguar-puma-ringneck-tiger-v2025-07_nvme-15bceb34d57e
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

As it is, an NVMe's built-in PERSTN pull-up fights against the
SoC's built-in pull-down which results in an undefined logic state
on the Samsung SSD 980 and likely others.

Fix that by forcing PERSTN low as early as possible, which is SPL.

Both Linux and U-Boot (via "pci enum") set the pin high later
as needed and the NVMe is detected fine.

Oscillocope shots ("x" means undefined logic state at around 1.5V):

Before:

	3V3     ____|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
	PERSTN  ____xxxxxxxxxxxxxxx_|‾‾‾‾‾
	PCICLK  ____∿∿∿∿∿∿∿∿∿∿∿∿___∿∿∿∿∿∿∿
                    ^U-Boot     ^ Linux

After:

	3V3     ____|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
	PERSTN  ____x_______________|‾‾‾‾‾
	PCICLK  ____∿∿∿∿∿∿∿∿∿∿∿∿___∿∿∿∿∿∿∿
                    ^U-Boot     ^ Linux

With this change, the power-up sequence conforms to PCIe specs,
except a remaining short PERSTN glitch. The glitch is about 400ms
long. It could be shortened by moving the logic to TPL, but
completely fixing it is only possible in hardware.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
v2: Address offline comments: Move TODO comment to rk_setreg, add newline between code blocks
v1: https://lore.kernel.org/u-boot/20260609-b4-master_nvme-v1-1-36cb53f74651@cherry.de/
---
 arch/arm/dts/rk3588-jaguar-u-boot.dtsi               |  6 ++++++
 .../theobroma-systems/jaguar_rk3588/jaguar_rk3588.c  | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/dts/rk3588-jaguar-u-boot.dtsi b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
index dcda4f99d6e..0fbbb50fc5a 100644
--- a/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
@@ -21,6 +21,12 @@
 	bootph-some-ram;
 };
 
+&gpio0 {
+	/* Need gpio0 in SPL for spl_board_init() to control GPIO0_D0 */
+	/* TODO: once we have a U-Boot TPL, use bootph-pre-sram; */
+	bootph-pre-ram;
+};
+
 &gpio2 {
 	bootph-pre-ram;
 	bootph-some-ram;
diff --git a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
index 3f484646701..5177aa9d6e8 100644
--- a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
+++ b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
@@ -54,6 +54,8 @@ int rockchip_early_misc_init_r(void)
 
 #define GPIO0B7_PU_EN BIT(15)
 
+#define M2_NVME_PERSTN	24 /* GPIO0_D0, PERSTN signal to the M.2 NVMe slot */
+
 void spl_board_init(void)
 {
 	/*
@@ -67,6 +69,24 @@ void spl_board_init(void)
 	 * pull-up.
 	 */
 	struct rk3588_pmu2_ioc * const ioc = (void *)PMU2_IOC_BASE;
+	int ret;
 
+	/* TODO: once we have a U-Boot TPL, move this to tpl_board_init() */
 	rk_setreg(&ioc->gpio0b_p, GPIO0B7_PU_EN);
+
+	/*
+	 * Set the M.2 NVMe slot PERSTN to a defined low
+	 * state as early as possible
+	 */
+	ret = gpio_request(M2_NVME_PERSTN, "M2_NVME_PERSTN");
+	if (ret) {
+		log_err("M2_NVME_PERSTN: gpio request failed: %d\n", ret);
+		return;
+	}
+
+	ret = gpio_direction_output(M2_NVME_PERSTN, 0);
+	if (ret) {
+		log_err("M2_NVME_PERSTN: gpio direction set failed: %d\n", ret);
+		return;
+	}
 }

---
base-commit: 50e1c662589b4e296cf260e8255fe48ba90b887e
change-id: 20260625-pub-jaguar-puma-ringneck-tiger-v2025-07_nvme-15bceb34d57e

Best regards,
--  
Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

