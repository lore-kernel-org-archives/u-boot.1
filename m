Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AF1D1CA15
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7131788D29;
	Tue,  5 Nov 2024 04:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OUYZsZGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA4088F27; Tue,  5 Nov 2024 04:16:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862C088CBA
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BF3714027B; 
 Tue,  5 Nov 2024 03:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730776602;
 bh=GyjxAqG7Zp0Ai4+BDwocIcCZsyJCs/I6huTkXTrf/yY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=OUYZsZGjGpLx3LdBcE55hiE94hRbW/5o6hg8QXkvnMiCAmwKTWkbyo6J3VU+wLbYg
 GeqmZoIKCwRbuPSmKDtIJ1M3sUeT42GDXtihJH0J0TrE2ru2IsGrkydVrWTD+rUXnR
 6I2dSlaHM+5ZXpsFPPtIBCtTjXE9cxza7Q3RDSS7/GzTdFjj+gPI4DJzxjPYFdK+t8
 o9kq8DE3a6kIF8frVo++blLzuTVQFcOXVodxM7NDJa1wlMqd0VNjLITcIEx+McgRUa
 bReq60zSfI5Jd8GEs3vpJ+E4cW31GOumElu8VQ6fFl0mbYwp64zvHaH151FCwSPtRr
 TSaWfNc8GHDdg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: qemu-riscv: describe CONFIG_DEBUG_SBI_CONSOLE
Date: Tue,  5 Nov 2024 04:16:31 +0100
Message-ID: <20241105031631.20535-1-heinrich.schuchardt@canonical.com>
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

In main U-Boot the SBI DBCN extension can be used to supply a debug
console.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/emulation/qemu-riscv.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index 8a5eb1eda56..8388e13d96d 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -171,3 +171,8 @@ The following settings provide a debug UART for the virt machine::
     CONFIG_DEBUG_UART_NS16550=y
     CONFIG_DEBUG_UART_BASE=0x10000000
     CONFIG_DEBUG_UART_CLOCK=3686400
+
+To provide a debug UART in main U-Boot the SBI DBCN extension can be used
+instead::
+
+    CONFIG_DEBUG_SBI_CONSOLE=y
-- 
2.45.2

