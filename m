Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EE7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5AA38762C;
	Tue, 31 Oct 2023 18:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="Ry9FB+TV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E44B287B58; Tue, 31 Oct 2023 17:13:49 +0100 (CET)
Received: from smtpo55.interia.pl (smtpo55.interia.pl [217.74.67.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45AD87CA1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 17:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sst@poczta.fm
Received: from localhost (ipv4-80-68-225-159.net.internetunion.pl
 [80.68.225.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
 Tue, 31 Oct 2023 17:13:46 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 2/2] configs: orangepi-5-plus-rk3588: Build SPI image by
 default
Date: Tue, 31 Oct 2023 17:13:27 +0100
Message-ID: <20231031161327.1104885-2-sst@poczta.fm>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031161327.1104885-1-sst@poczta.fm>
References: <20231031161327.1104885-1-sst@poczta.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1698768827; bh=EnaMnOl2EXbr9edR1TvBL1Jy4e53+WtRl0U7i2UwCC8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=Ry9FB+TVzrlfrTWvcJL7I1iA/J6/IS3AeI1Nqg5vXuYoyV4vb29Jdc/GYr9KpIxGT
 9VKdW1wO6RdkNAtmWEfjw1hNsDCIae6IvlaPZRyBQI3/lAIUy+Zgmhg4Gik3jNTZlA
 hSAwdUioUvRk0NEwHjqIKqUoaJgqawbhRbUMHRqA=
X-Mailman-Approved-At: Tue, 31 Oct 2023 18:35:53 +0100
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

Flashing this image to the on-board flash is useful when you want to
start Linux from a medium (e.g. nvme) without flashing u-boot elements
to it.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 configs/orangepi-5-plus-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index 0473699621..9af65026a0 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -103,3 +103,4 @@ CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_ERRNO_STR=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
-- 
2.42.0

