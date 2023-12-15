Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47509C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D5487BF5;
	Fri, 15 Dec 2023 14:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="k1Isk4II";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FBA87BB9; Fri, 15 Dec 2023 14:32:59 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6509687BB9
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B68D042F63; 
 Fri, 15 Dec 2023 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702647177;
 bh=c6JUneQWwAh9EiM6MQB3eY2Bo9PyUWJv9QAyGsSPQF8=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=k1Isk4II/5JZvazHYek3120y876n8W4uSB5YGak+e4hBVM+PqvV74fQBkG/b8kL2p
 fjrJY716HLrrpzkJh2SEOSel59If4J/lCw8zWDUruBuV75r058gx9WZMFZ43KW3gcX
 VVHQHryLZEP7uIf9924iP817EhRgJsI6VGGoTd3Wipho+b3dLmLwzL/Os/N/A9RKDG
 0DlpOoMLlyAY+iuO3PMh+2187RI6mhDAEllk5aoJCNSfKp3xBBlZdh63eNpU/FXx6s
 ZP7mvKyL2FH2y0qY07EofEzphFXse3PQfiwW0KMADvGvUmIph7i5yPeslrwOFhMyR4
 x+lV75GLV2AtQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 9/9] arm: enable support for QEMU firmware tables
Date: Fri, 15 Dec 2023 14:32:45 +0100
Message-Id: <20231215133245.7923-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 board/emulation/qemu-arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index ac2d078f42..e21c135e86 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -5,6 +5,7 @@ config TEXT_BASE
 
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
+	select QFW if ACPI
 	select QFW_MMIO if CMD_QFW
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
-- 
2.40.1

