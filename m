Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6769E66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F2489160;
	Sat, 23 Nov 2024 22:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mafLT/QG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773B489410; Sat, 23 Nov 2024 22:46:50 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2D7893F6
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 72DD741010; 
 Sat, 23 Nov 2024 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732398405;
 bh=BFP03de4EqFL+Rcw1OqeYTXZ34BDt79mHGfjkXt2r5E=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mafLT/QGf1djJAq49bHj3EGFXxng0+X1S9o/zRD8QglYxm3cds2h8kHypTZ6RyViH
 wyrtD0TxIi6X2G89DUWbFU8teIqDDE98x+mjc8RcUWoSAgiZ+T6PAaDcmf//LR+yTd
 DqSCB3aFAxeFs/kMra8SJDRZmzu518zssHX0PD8LpuEHgaCi6MQv9KFpGxKM9lYveU
 aNRT8p02h5c9xLazlDTEA+NVQ1MbL33KaTAlzMSRVmTGWU/WG7g3Q3HsuHdYjTT84D
 eeDMdgC1QIM35dFiQV1PekMSqm4M4R/1UHeMHu9T8SXB1u/U6+EMn2B7yB+0qbcBY+
 LJrgTHljo442A==
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
Subject: [PATCH v2 6/6] efi_loader: run bootdev_hunt() to find ESP
Date: Sat, 23 Nov 2024 22:45:54 +0100
Message-ID: <20241123214554.305285-7-heinrich.schuchardt@canonical.com>
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

Some hard devices need specific routines to scan for block devices,
e.g. NVMe (nvme scan), SCSI (scsi start).

Invoke bootdev_hunt() to find all block devices.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	no change
---
 lib/efi_loader/efi_setup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..8e0ff16f3eb 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
+#include <bootdev.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
 #include <log.h>
@@ -228,6 +229,13 @@ efi_status_t efi_init_obj_list(void)
 	 * Probe block devices to find the ESP.
 	 * efi_disks_register() must be called before efi_init_variables().
 	 */
+	if (CONFIG_IS_ENABLED(BOOTSTD)) {
+		int r;
+
+		r = bootdev_hunt(NULL, 0);
+		if (r)
+			log_debug("No boot device available\n");
+	}
 	ret = efi_disks_register();
 	if (ret != EFI_SUCCESS)
 		goto out;
-- 
2.45.2

