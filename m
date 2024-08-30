Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0A9CA0EF6
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDA388D87;
	Fri, 30 Aug 2024 11:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="iZohnPUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B93088D7D; Fri, 30 Aug 2024 11:10:06 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 578B088D8B
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009004; x=1727601004;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TGlQtTmBdf81nHIeSK+1AzYoVUu9JU31uoVPZO1mLrQ=;
 b=iZohnPUIObE2qIqsbM8iCjI84YDItXrEBe1b+/z5mLsTbgTyk5aO8HMWB7HXtM6m
 y5TaM14Du1osyaoiFzdgMR5BzJPDOlHje6TXyD40054HSCTjR8qY5/yvm33tR6nL
 839KfXhPwJmZ2rtt2o5VBGzoZka5KJVQ8FOVTRwUGqI=;
X-AuditID: ac14000a-03e52700000021bc-24-66d18c6c0db0
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F8.42.08636.C6C81D66;
 Fri, 30 Aug 2024 11:10:04 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:02 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 05/13] include: env: phytec: Add K3 boot logic for OSPI/QSPI
 flashes
Date: Fri, 30 Aug 2024 02:09:32 -0700
Message-ID: <20240830090940.2592157-6-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBRzen52KawfHlAhafdj5mtZg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+tntjMFsERx2aSk5mSWpRbp2yVwZcx8MJWx
 YA9nxb7LlxgbGLs5uhg5OSQETCT2/9jO2sXIxSEksIRJ4vKOrYwQzn1GiZO7P7KCVLEJaEnc
 2TKXGcQWEUiS2PVkGRuIzSzgIrH4xgewGmGBEIkbh7ezg9gsAqoSK76tAIpzcPAKWEnsuc8P
 sUxeYual72AlnALWEpu/PgCzhYBKjk87BzaSV0BQ4uTMJywQ4+UlmrfOZoawJSQOvnjBDFGv
 IDF722RGmJnTzr1mhrBDJY5sWs00gVFoFpJRs5CMmoVk1AJG5lWMQrmZydmpRZnZegUZlSWp
 yXopqZsYQWEuwsC1g7FvjschRiYOxkOMEhzMSiK8J46fTRPiTUmsrEotyo8vKs1JLT7EKM3B
 oiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAqHz0WY7P9Q3TNV2fRZ5ZfuE7f5qJ24Ijwkvr
 ODdLJ4vU2Vy55Zbfs12Np7Zzp4Wyho3+jfyLW3QXny6Ym+vyLPXo1vg1wZGvF2gnsmwJj14R
 EGCU28s6S3px+e/ePRITQndGBczY+/04p6RJqd/jj6bWhS3bO2ctNhN7LB8beezBxksSrobH
 lViKMxINtZiLihMB71G0yGECAAA=
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

This boot logic allows to boot a Kernel image, Device-Tree blob
and a initramfs from an external OSPI/QSPI NOR flash.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_spi.env | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/env/phytec/k3_spi.env

diff --git a/include/env/phytec/k3_spi.env b/include/env/phytec/k3_spi.env
new file mode 100644
index 00000000000..97d3a157058
--- /dev/null
+++ b/include/env/phytec/k3_spi.env
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Daniel Schultz <d.schultz@phytec.de>
+ */
+
+/* Logic for TI K3 based SoCs to boot from an OSPI/QSPI NOR flash. */
+
+spiargs=setenv bootargs console=${console} earlycon=${earlycon}
+spiloadimage=sf read ${kernel_addr_r} ${spi_image_addr} ${size_kern}
+spiloadfdt=sf read ${fdt_addr_r} ${spi_fdt_addr} ${size_fdt}
+spiloadramdisk=sf read ${ramdisk_addr_r} ${spi_ramdisk_addr} ${size_fs}
+spiboot=run spiargs;
+	sf probe;
+	run spiloadimage;
+	run spiloadfdt;
+	run spiloadramdisk;
+	booti ${kernel_addr_r} ${ramdisk_addr_r}:0x${size_fs} ${fdt_addr_r}
-- 
2.25.1

