Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ADFCCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 13:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13BA883DA7;
	Fri,  7 Nov 2025 14:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="0zBQFCUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BD483D4A; Fri,  7 Nov 2025 14:03:11 +0100 (CET)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525CC83D86
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 14:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2zkf0Qb8zjQZ;
 Fri,  7 Nov 2025 14:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762520585;
 bh=5luIxRWBxDJpQQ3++qn75E64V1pl0stsh1hulerxBug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0zBQFCUS5sOpiuk1RcWJCJ/VkTmJrlsXPW710Bfl5BUNAMk9xGKl0CoAMTbvqus+E
 EZA+zyOi9bXheeCmgCJa09tgSYhtKxP8eKirodK9gGWvOb+lVNqsm+SLqhwmprsEEl
 D/3tw9fk1YazJ2Yp3y5hB56Ez8Yp/ZpLEZ+2vJPY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d2zkd3S10zSVJ; Fri,  7 Nov 2025 14:03:05 +0100 (CET)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 6/6] remoteproc: k3-r5: Implement is_running operation
Date: Fri,  7 Nov 2025 14:01:05 +0100
Message-ID: <20251107130216.3084134-7-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107130216.3084134-1-dev@pschenker.ch>
References: <20251107130216.3084134-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

From: Philippe Schenker <philippe.schenker@impulsing.ch>

Add is_running callback to query the R5F core halt status via the
TI-SCI processor control API. This allows the remoteproc framework
to determine whether the R5F core is currently runnin.

The core is considered running when the PROC_BOOT_CTRL_FLAG_R5_CORE_HALT
bit is not set in the control flags.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>

---

Changes in v2:
- Made sure there are no build-warnings caused by this series.

 drivers/remoteproc/ti_k3_r5f_rproc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 36ea449f5121..78739ca55942 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -570,6 +570,22 @@ static void *k3_r5f_da_to_va(struct udevice *dev, ulong da, ulong size, bool *is
 	return map_physmem(da, size, MAP_NOCACHE);
 }
 
+static int k3_r5f_is_running(struct udevice *dev)
+{
+	struct k3_r5f_core *core = dev_get_priv(dev);
+	u32 cfg, ctrl, sts;
+	u64 boot_vec;
+	int ret;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = ti_sci_proc_get_status(&core->tsp, &boot_vec, &cfg, &ctrl, &sts);
+	if (ret)
+		return -1;
+
+	return !!(ctrl & PROC_BOOT_CTRL_FLAG_R5_CORE_HALT);
+}
+
 static int k3_r5f_init(struct udevice *dev)
 {
 	return 0;
@@ -587,6 +603,7 @@ static const struct dm_rproc_ops k3_r5f_rproc_ops = {
 	.stop = k3_r5f_stop,
 	.load = k3_r5f_load,
 	.device_to_virt = k3_r5f_da_to_va,
+	.is_running = k3_r5f_is_running,
 };
 
 static int k3_r5f_rproc_configure(struct k3_r5f_core *core)
-- 
2.51.2

