Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B99BD3C902
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 10:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68FB089286;
	Sat, 19 Oct 2024 12:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g++p3t+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3287D8928D; Sat, 19 Oct 2024 12:24:58 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7638925C
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 12:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-156.46.114.pool.telefonica.de
 [46.114.105.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5880D408CC; 
 Sat, 19 Oct 2024 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729333495;
 bh=AKSIe03De5KK91UzbSV/axOlox6v8UNshYt56iSNCrQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=g++p3t+Dk5qBS2hA5zrdehLDYk7SLTxA0eZYduPp11uUJX2sJM2PPrhg7j9F1/niY
 rdxM9IsaYoYOxu1Ys+e3PSi4ov01Y3X4J1bPknS8uSNVUNTc5taNMOX0+NDYi1RleN
 HzxNdRpq9c79VBo2BTEBAAUXWpn4I3rD7ucv44CHXy9rJegBZJsAK40hG24Ik2oekI
 ACNgCYDuAsfSNbF/qm8kvSEOEetUKcmFC5VNlTfooBxtbiVdVpSUFwJSoMTW2yDCKY
 +yt+koX+YC8GvVQyiziSxDt7Zgj3Jysu4OPQeOCPkK8rqF19SGeAEIwJkvvSaz/zKi
 jqJ5ca3nkxE/Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: simplify network definitions in Makefile
Date: Sat, 19 Oct 2024 12:24:45 +0200
Message-ID: <20241019102445.48624-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

/Makefile already adds lib include paths to UBOOTINCLUDE. There is no point
in adding the same paths again.

Clearly separate the lines relating to NET and to NET_LWIP.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Makefile | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/cmd/Makefile b/cmd/Makefile
index 3c5bd56e912..61992112f5f 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -127,13 +127,10 @@ obj-y += legacy-mtd-utils.o
 endif
 obj-$(CONFIG_CMD_MUX) += mux.o
 obj-$(CONFIG_CMD_NAND) += nand.o
-ifdef CONFIG_CMD_NET
-obj-$(CONFIG_NET) += net.o
-obj-$(CONFIG_NET_LWIP) += net-lwip.o
-obj-$(filter y,$(CONFIG_CMD_NET) $(CONFIG_CMD_NET_LWIP)) += net-common.o
-lwip-includes := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
-CFLAGS_net-lwip.o := $(lwip-includes)
-CFLAGS_net-common.o := $(lwip-includes)
+ifdef CONFIG_NET
+obj-$(CONFIG_CMD_NET) += net.o net-common.o
+else ifdef CONFIG_NET_LWIP
+obj-$(CONFIG_CMD_NET) += net-lwip.o net-common.o
 endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
-- 
2.45.2

