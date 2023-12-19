Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A9CC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B168D876FA;
	Tue, 19 Dec 2023 13:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pW7Usi0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51CAB87630; Tue, 19 Dec 2023 13:25:06 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456CD87600
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AC5ED420F5; 
 Tue, 19 Dec 2023 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702988698;
 bh=SI8WvafmjL389msrE91/cu6ehuo12zuSAd2CvCBDf+w=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=pW7Usi0ZnS4IRCi24svwQOBuFzk+mzYoJNclnFliKULcQYJVBgFwmJJVoJsHRfvwo
 z938nqcesHJ7Tb/HiWB+Z0UjPkeFS4uV3DO14SffDFQSYj8FGy3/gwliKfpIrR1i+L
 vlurr8b4Iu8hoT5+N5Wy7cBr+bm0xkhzz6aAmV3aPcUc+fbutEDdLnbHUjGRxRciMl
 HOMRZ2sElKVEFBUhrbO3Vi0RqeHz9TD1iizbCx92AC3diBvlAn3Rnsrgjt2QiRKOzz
 uXhuBW5xrAQT2EQGnJPZ/UqrTyFrKULOLc9CSTIy8LsZmktox4strx9Oy8AnFGl8cf
 ouMRmhHwste+A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 9/9] arm: enable support for QEMU firmware tables
Date: Tue, 19 Dec 2023 13:24:39 +0100
Message-Id: <20231219122439.31983-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v3:
	no change
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

