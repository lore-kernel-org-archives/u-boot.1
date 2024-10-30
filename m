Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C5D5CCAA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9B589215;
	Wed, 30 Oct 2024 14:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="EPgPdlP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA5288FAB; Wed, 30 Oct 2024 14:17:43 +0100 (CET)
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE2A88BB7
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1730294261;
 bh=PUTQaqgRMNmDdSXF/ESiB6Bpq8lxIFE8h/rwCF2vTDY=;
 h=Date:From:To:Subject:Message-ID:Content-Type:From;
 b=EPgPdlP61Cf/Sv7m/39pN1T93z6U0tQXdKuyt4lx6G8tm6bKwtkd2L1NDKnMzXYKN
 PZslZg10Ef2QVGpXko5c7NehSHxmRf5ffUbZ19coDU2SSDSU7P5K7e6ZkNZr51jTHT
 sluVbZamBvlGrOSXzvJwAN74EIgPJ7cJY8Hy+mNA=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr3.vodafonemail.de (Postfix) with ESMTPS id 4Xdnjd3H02z2HSw
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:17:41 +0000 (UTC)
Received: from qrv-systems.net (ip-095-222-025-162.um34.pools.vodafone-ip.de
 [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XdnjY1ccFz905C
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:17:34 +0000 (UTC)
Date: Wed, 30 Oct 2024 14:17:33 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Subject: [PATCH] drivers/video/vesa: use MTRRs only on x86
Message-ID: <ZyIx7WVAeVqZ7mY2@qrv-systems.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1153
X-purgate-ID: 155817::1730294257-9FFFE477-8440CC3A/0/0
X-Mailman-Approved-At: Wed, 30 Oct 2024 14:17:59 +0100
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

MTRR functionality is available only on x86, so this driver cannot be compiled
on other architectures. Fix this with preprocessor directives.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/video/vesa.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/vesa.c b/drivers/video/vesa.c
index ab756ac8ea..e96f6747a6 100644
--- a/drivers/video/vesa.c
+++ b/drivers/video/vesa.c
@@ -8,21 +8,26 @@
 #include <pci.h>
 #include <vesa.h>
 #include <video.h>
+#if defined(CONFIG_X86)
 #include <asm/mtrr.h>
+#endif
 
 static int vesa_video_probe(struct udevice *dev)
 {
-	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
-	ulong fbbase;
 	int ret;
 
 	ret = vesa_setup_video(dev, NULL);
 	if (ret)
 		return log_ret(ret);
 
+#if defined(CONFIG_X86)
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	ulong fbbase;
+
 	/* Use write-combining for the graphics memory, 256MB */
 	fbbase = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
 	mtrr_set_next_var(MTRR_TYPE_WRCOMB, fbbase, 256 << 20);
+#endif
 
 	return 0;
 }
-- 
2.39.5

