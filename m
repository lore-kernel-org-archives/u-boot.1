Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB154C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 15:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F42876CB;
	Sat, 16 Dec 2023 16:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QDvhG6se";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5600A876D3; Sat, 16 Dec 2023 16:20:03 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D26876C0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 16:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E8F1E413B9; 
 Sat, 16 Dec 2023 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702740000;
 bh=JXm6MGZK1pa9FlX03Qj2eJAwmeQHGRCRb9VDY/TygXY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=QDvhG6seGIXfmtl5ZpN0xZ7kgJrm4Xfx09Wsp5QsFesbzqT4VrnI6L+bDQmGam0hc
 jeigJ14jpgfyF3nTH3Nq/YPOZdkcR3Evb0uslPee9Go+gpkjawhW6bDDeQ+Q8XOE7J
 dLg3ua5vUC5gkyOh4buYur3XK1TaY93wf2pGRvkS/may5/V/gUjjN3z6Nl2LQ4xZCr
 rnmepcQMen0M7VUisNIkKNDtkGUrx5/WMzXqDx9o3XbjzgV6u+chGKDNs74S9zpp2L
 9z4SpRUD8qTAkFO4JDgNlx8hECIYVEiq8+lmIKW9INDq952ITCl/xeiw2EiF6PTVRq
 jCqNvr4xvdosw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: build test/boot for CONFIG_UT_BOOTSTD=n
Date: Sat, 16 Dec 2023 16:19:54 +0100
Message-Id: <20231216151954.66658-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Building sandbox_defconfig with

    CONFIG_UT_BOOTSTD=n
    CONFIG_MEASURMENT=y
 
results in an error:

    /usr/bin/ld: test/cmd_ut.o:(.data.rel.cmd_ut_sub+0x408):
    undefined reference to `do_ut_measurement'

Fixes: 5999ea20fa42 ("test: Add sandbox TPM boot measurement")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/Makefile b/test/Makefile
index 6b8a1506f5..feba097543 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
 ifeq ($(CONFIG_SPL_BUILD),)
-obj-$(CONFIG_$(SPL_)UT_BOOTSTD) += boot/
+obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-y += log/
 obj-$(CONFIG_$(SPL_)UT_UNICODE) += unicode_ut.o
-- 
2.40.1

