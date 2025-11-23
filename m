Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A192CFD2F6
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2F283C5A;
	Sun, 23 Nov 2025 23:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Eqqd+1px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6CEC83B7E; Sun, 23 Nov 2025 23:58:34 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF1483C6C
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6617944975; 
 Sun, 23 Nov 2025 22:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938685;
 bh=JnLuJaRuRCY0kVWOlnEMGf3wD7atdkVqTuUsXyoJ5mY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Eqqd+1pxMz1Q1wtK+Jq0Y79ZV+qa9EBWk22PWfPeRI4ciGjl7FjuIeOMKgp/XtNm+
 0mdCy6Ay8eBrL6PPxBldC71lP8CjQ8nCu+Hzw+dqXie/vaxFcCGy4sVU/4uKW/rdg/
 f9rml3NbyX9heagAC4ohqgdZmpXGDdnyzOnZpFL63oASzMq+SCuIDSTGvlDrxTOli7
 pSL5X+PTl1iom0YVEofz0xC/gMHZRwUq/yjIl/z41FiqEiKIyvHRWEaMKwivGOGUKs
 uLi+ospaEVOvBHyuKuNb81iRcKHq0s3aP/sSzozJ54Y3Y025530mrueh9PDSFhMSTo
 v+nnJ/ZI6uYCfC/wrX91ECYiSz1JLafaMiydkDWwh91qecHN9VvqjUoqGWkIraLo0Q
 PCU0tXmHAHUHViTv3v6wRyrEmVSiRrwoKu4xSOjKtG/SaomCtYIjWjxMzhGH8R196x
 U5AQCNYq2qw49mz8tFoq7VmU2cj4v7BGjXWw2r4hmiM8k3ZOQUkpp6eWXSVZW3rTZd
 Q8/O4uz2926JEtbpzZNI8/ni+qj65M6GavfVQ31OX0iCMGZRIyEnFLITgOXECZnDI6
 X08ssCsR3xrSd2uGon2OvhNkWCGwLxsTLoIfi16AHRsf/a4edTEyUVkDsoFUV+u29L
 F0EnZMgCAzg+KZ4MtPrTce6E=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 10/19] test: the cmd/font test requires the sandbox
Date: Sun, 23 Nov 2025 23:57:02 +0100
Message-ID: <20251123225711.227016-11-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

The font test makes assumptions about video devices and selected fonts that
may not hold true on other configurations like qemu-x86_64_defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index d7ff11e458a..2476068aee6 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -19,7 +19,6 @@ endif
 obj-$(CONFIG_CMD_BDI) += bdinfo.o
 obj-$(CONFIG_COREBOOT_SYSINFO) += coreboot.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
-obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
 obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_I3C) += i3c.o
@@ -33,6 +32,7 @@ endif
 obj-$(CONFIG_CMD_QFW) += qfw.o
 obj-$(CONFIG_CMD_SEAMA) += seama.o
 ifdef CONFIG_SANDBOX
+obj-$(CONFIG_CONSOLE_TRUETYPE) += font.o
 obj-$(CONFIG_CMD_MBR) += mbr.o
 obj-$(CONFIG_CMD_PINMUX) += pinmux.o
 obj-$(CONFIG_CMD_PWM) += pwm.o
-- 
2.51.0

