Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0807C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 15:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5113187600;
	Tue, 19 Dec 2023 16:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="O9feCxll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1155187725; Tue, 19 Dec 2023 16:04:34 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AB1876A8
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 16:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0907442F72; 
 Tue, 19 Dec 2023 15:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702998264;
 bh=4K79tdNxrOVuOEbPvE7tP7D1phv7HnVlbSTaPbx9nMc=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=O9feCxll6bEg9nmZEIWPsNjv91wCpQS2grlrtAAV6cb0RwsDRsu+0sDbi5K4SKW9p
 dWJuCS3ZU7a+EWxm86RgGgAe+VLfE48RbO3Ye8NiITfK7f7AK+HuV4B6WxOe3teGwf
 7dnwngduliVimMN7QPnXQ17UrdNjI7CMnS0qlhnzpSmkJKZ6XKUitzViGd/5yk2RAW
 fXj4w0fQHLSO7RCL1JJLmjrye+/QLyKB1SGj0vUIaUFfGsQpnhT1saj+ije8QiCeig
 6U7RqpTn/OcCREJkbJzq0l37MqXObVvEf9FXEoSwlOcWqYOzQ+wZwo0mBZnlJElV/m
 AGGAY+l/taT3w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 6/9] riscv: add support for QEMU firmware tables
Date: Tue, 19 Dec 2023 16:04:05 +0100
Message-Id: <20231219150408.10949-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
References: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
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

Enable the QEMU firmware interface if ACPI tables are to be supported on
the QEMU platform.

Enable the QFW MMIO interface if the QEMU firmware interface is enabled.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v4:
	no change
v3:
	no change
v2:
	no change
---
 board/emulation/qemu-riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index cdd0d0d95f..d5f302ffda 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -33,6 +33,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	select GENERIC_RISCV
 	select SUPPORT_SPL
+	select QFW if ACPI
+	select QFW_MMIO if QFW
 	imply AHCI
 	imply SMP
 	imply BOARD_LATE_INIT
-- 
2.40.1

