Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAA0E66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2CB893A5;
	Sat, 23 Nov 2024 22:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PVPVz9lV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D4689248; Sat, 23 Nov 2024 22:46:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688B2891B1
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9E3474100B; 
 Sat, 23 Nov 2024 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732398401;
 bh=DDcYdHmk4ySqIlCYyTzBILfzzJR7hTci+vDGJHw/vaA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PVPVz9lVM9h5z9V13XmOYk6QwL1qA/YM2+ZzYObqlGsw2fVLZKzprVZ1jiJv9lbEG
 GCIsZNB0ZmaaDpF/PPtKbb1V5gHS9Mx+t1jTrg6IdInPLN/lE+2PTH4YrSqB7FHj3a
 NyIP7eXJTBvWdqS8duS/Gc2o4r4/JppmjZVe7uTUsNs/0f2zPOkI/G1k3uk+4YITvu
 KVr7Mp0qzY2pvxls4M9ttCzuLxuwPti3QJPQIM1RjnqNdDd9PXZOq8yGxvTkMS6N9E
 t5sJo4BZKjF+VNxJpQB+bKLCJVpK75zqdfjm2/YQt9i/ajvwKKmLNaMNoTcIB/oeOv
 2SO1Zn4xpcvwA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/6] configs: sandbox_deconfig: remove
 CONFIG_AMIGA_PARTITION
Date: Sat, 23 Nov 2024 22:45:50 +0100
Message-ID: <20241123214554.305285-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
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

We do not actually test the code.
Scanning for Amiga partitions of the sandbox is extremely slow,
especially on the partially implemented USB device.

For build testing the other sandbox defconfigs are good enough.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 configs/sandbox_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 718e4a8283c..683888f238f 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -142,7 +142,6 @@ CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_STACKPROTECTOR_TEST=y
 CONFIG_MAC_PARTITION=y
-CONFIG_AMIGA_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
-- 
2.45.2

