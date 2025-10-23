Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDC9CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 09:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99AA9836B4;
	Thu, 23 Oct 2025 11:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="A2Ep5rkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B2A83303; Thu, 23 Oct 2025 11:47:38 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71390835B0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 11:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4csh601JQCz9cq;
 Thu, 23 Oct 2025 11:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1761212856;
 bh=TyoehzBElJ0plFqAlgHEm4wfQe14KmlwDCExXZmWSeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A2Ep5rkWhJ7nJwNqNBdW/zfvnnIL1oY33fkKGWzt/OHkjn9jYXEsv+uYbbvlBW948
 rbG6PA4ZZDNHl+d01x5scrOi6jTXrt9/6rLxeh9NCJD1W7iQijppvSX93hOoBShZH7
 vsM6vgVTsoj2932rthUMafzkPwRGcN2hp4ZDABPY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4csh5z4sTfzHJ4; Thu, 23 Oct 2025 11:47:35 +0200 (CEST)
From: Philippe Schenker <dev@pschenker.ch>
To: u-boot@lists.denx.de
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 Hari Nagalla <hnagalla@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 6/6] remoteproc: k3-r5: Implement is_running operation
Date: Thu, 23 Oct 2025 11:46:24 +0200
Message-ID: <20251023094631.16742-7-dev@pschenker.ch>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023094631.16742-1-dev@pschenker.ch>
References: <20251023094631.16742-1-dev@pschenker.ch>
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

 drivers/remoteproc/ti_k3_r5f_rproc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 40163e992da8..a2d3b817e406 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -570,6 +570,22 @@ static void *k3_r5f_da_to_va(struct udevice *dev, ulong da, ulong size)
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
2.51.1

