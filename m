Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0609ECD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3129F881ED;
	Thu, 11 Apr 2024 06:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="r/qc+QET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD49881ED; Thu, 11 Apr 2024 06:28:54 +0200 (CEST)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D9087FA0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ndmw9EoGFOkwrg4HAacK103v5QjvNF30TsMgj55xx78=;
 b=r/qc+QET10aA8LehkWT7tMwOVAbjU5pcfryLoSvJT15nPmeanKQZEmR81SX+BDVVwjcbUp
 3XBfhTSDP9MUNx82A8VGzllgJPAvpkZq4wXdIeHEFPVcrvbGJ0YlHwLH4O7pjTCVJsIE5c
 xPp21C96ZYj1YhwwzC5TQ032xvkTDn6t6A3fxkXfZfj88irz1PJq/TiIDdUjTGT0RzXU/V
 erBgLc9P3AOz2OBL8PpQjcxnRATAYN4U1+Bvv0UMODTwnTnpZK1kZyEaCZas+6AsRTUjQ5
 aJSv4r94UttK1QLSs1w66qPcCI8Ox+7tpk91zOT5CRyYVATFcPttQuuPHyyzRw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:31 +1000
Subject: [PATCH RFC 14/15] spl: Support SPI NAND boot in UBI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-14-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809591; l=1613;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=K7004TES0uyJJQeZPLgqmp916jd9SmnINVNsn+TfY84=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAz4Dv3JSv959NKqLPc9sSGkm
 yQBEM9QixMLP6f1OssL0er67gQu+Hp0DQwcT+8nA8cU6AU06SIaXmoeOJJmKoCAUAAOmA
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

UBI supports traditional NAND and oneNAND devices already, so add
support for booting from SPI NAND devices.

Signed-off-by: John Watts <contact@jookia.org>
---
 common/spl/spl_ubi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_ubi.c b/common/spl/spl_ubi.c
index d7ab9efd11..72b4b195ed 100644
--- a/common/spl/spl_ubi.c
+++ b/common/spl/spl_ubi.c
@@ -21,6 +21,13 @@ int spl_ubi_load_image(struct spl_image_info *spl_image,
 	int ret = 1;
 
 	switch (bootdev->boot_device) {
+#ifdef CONFIG_SPL_SPINAND_SUPPORT
+	case BOOT_DEVICE_SPINAND:
+		spinand_init();
+		info.read = spinand_spl_read_block;
+		info.peb_size = CONFIG_SPL_SPINAND_BLOCK_SIZE;
+		break;
+#endif
 #ifdef CONFIG_SPL_NAND_SUPPORT
 	case BOOT_DEVICE_NAND:
 		nand_init();
@@ -77,12 +84,18 @@ int spl_ubi_load_image(struct spl_image_info *spl_image,
 	if (!ret)
 		spl_parse_image_header(spl_image, bootdev, header);
 out:
+#ifdef CONFIG_SPL_SPINAND_SUPPORT
+	if (bootdev->boot_device == BOOT_DEVICE_SPINAND)
+		spinand_deselect();
+#endif
 #ifdef CONFIG_SPL_NAND_SUPPORT
 	if (bootdev->boot_device == BOOT_DEVICE_NAND)
 		nand_deselect();
 #endif
 	return ret;
 }
-/* Use priorty 0 so that Ubi will override NAND and ONENAND methods */
+
+/* Use priority 0 so that UBI will override all NAND methods */
 SPL_LOAD_IMAGE_METHOD("NAND", 0, BOOT_DEVICE_NAND, spl_ubi_load_image);
 SPL_LOAD_IMAGE_METHOD("OneNAND", 0, BOOT_DEVICE_ONENAND, spl_ubi_load_image);
+SPL_LOAD_IMAGE_METHOD("SPINAND", 0, BOOT_DEVICE_SPINAND, spl_ubi_load_image);

-- 
2.44.0

