Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C31CD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 08:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B9486405;
	Mon, 18 Sep 2023 10:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F1986416; Mon, 18 Sep 2023 10:32:40 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id 2D9E783F7A
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 10:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1.arvanta.net (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id A49F628E8D;
 Mon, 18 Sep 2023 10:32:35 +0200 (CEST)
From: =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>
To: u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>, Jami Kettunen <jamipkettunen@gmail.com>,
 =?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>
Subject: [PATCH 1/1] starfive: visionfive2: add mmc0 and nvme boot targets
Date: Mon, 18 Sep 2023 10:32:29 +0200
Message-ID: <20230918083231.20092-1-mps@arvanta.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

boot from SDIO3.0 (mmc sdcard) first if it is plugged.
If mmc is not plugged try to boot from emmc if it is plugged.
If emmc is not plugged then try to boot from nvme.

Signed-off-by: Milan P. Stanić <mps@arvanta.net>
---
 include/configs/starfive-visionfive2.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/starfive-visionfive2.h b/include/configs/starfive-visionfive2.h
index 4ee02b8420..13cf2aeef9 100644
--- a/include/configs/starfive-visionfive2.h
+++ b/include/configs/starfive-visionfive2.h
@@ -19,6 +19,8 @@
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 1) \
+	func(MMC, mmc, 0) \
+	func(NVME, nvme, 0) \
 	func(DHCP, dhcp, na)
 
 #include <config_distro_bootcmd.h>
-- 
2.42.0

