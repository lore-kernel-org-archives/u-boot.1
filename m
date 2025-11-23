Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD180CFD314
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 01:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A629E83BB1;
	Sun, 23 Nov 2025 02:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="W7OiNRW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55BEA83B8B; Sun, 23 Nov 2025 02:19:33 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8168683B95
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 02:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C5A1142649; 
 Sun, 23 Nov 2025 01:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763860770;
 bh=3QuAH6cE7+KUhNFWCSTgXapfEyBq+XwlaPoDGC5G3NY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=W7OiNRW6J+clUQB1IigNkPBRPdb9s1bW143RU9zVhwiRUYHWjGBppvoSmiNl4X/dc
 8UXR1BDkmLQsCMNRJmqiz13FzNIILZACtFBHCXQZ55tAjNwiprLLDdltGKWOdXOHea
 sNMq55lXDBl/NLIjyhT+uC5FxRBjcyBEL9JIK1xxHjy5JkgU0XUUlVD22m7MB4L1Mg
 FEK0a7DhW4FNhSDHZRmSH/0ig7qsw9UQoWZFXXCI07UI+3N1FNj2HWmWHv7puuUb8K
 hr39Zjg2nhEp2ycilffHtfx/61s1O1Vl9tZKG1iA7aE/1dLgFdnuddy1FOrx2IjEZX
 paikfPQ37MBtRAYzX0dz3gBQCGZZUm4th3jixfhUcAXG+wiy8UucQMVFk6z4zCQStX
 uDgLTVA8O9LDWTYiDw1xzwbH/U60dsrEKXqvb1pwqwjzNo0mr+VxLsSUeVhy5JxIYu
 HUvhATv/aYj2Y1Bk1q8NHhKTnt++bFfXqbyLynqtCYN2i2PCjCkcav+ZG3PtzCI8Bj
 oIHB5WQ5qk1Faktj2iew43UtoyNO11eu6QHpsefW2DzDuViI2UpJr3+TNRwhN6Uf1C
 tYGXe6FO/S+ofLhoQ84+In68vhvMYgivWjTtaUTCXgf572yK83hL2Uef10ZtuxSAu4
 fnmVu52qGnjWzA0YiDTFi9o8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] board: qemu-arm: enable CONFIG_CONSOLE_RECORD
Date: Sun, 23 Nov 2025 02:19:00 +0100
Message-ID: <20251123011900.91233-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
References: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
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

Many C unit tests are skipped without CONFIG_CONSOLE_RECORD=y.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index 447061b25cd..d86e3862157 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -8,6 +8,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select HAS_CUSTOM_SYS_INIT_SP_ADDR
 	select QFW if ACPI
 	select QFW_MMIO if CMD_QFW
+	imply CONSOLE_RECORD
 	imply SYS_EARLY_PCI_INIT
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
-- 
2.51.0

