Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A30D149EB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 20:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367E289060;
	Fri, 25 Oct 2024 22:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E72488F68; Fri, 25 Oct 2024 19:18:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8ED3E88FBA
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5804497;
 Fri, 25 Oct 2024 10:19:16 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDFD33F71E;
 Fri, 25 Oct 2024 10:18:45 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Jackson Cooper-Driver <jackson.cooper-driver@arm.com>, u-boot@lists.denx.de
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 6/8] arm: total_compute: Dynamically detect block device
Date: Fri, 25 Oct 2024 18:18:19 +0100
Message-Id: <20241025171821.624702-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025171821.624702-1-leo.yan@arm.com>
References: <20241025171821.624702-1-leo.yan@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Oct 2024 22:14:52 +0200
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

Dynamically detect block device in the boot command, this allows to
support both MMC and virtio block devices.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 board/armltd/total_compute/total_compute.env | 21 +++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/board/armltd/total_compute/total_compute.env b/board/armltd/total_compute/total_compute.env
index 9dd50819ea..93460aa5dc 100644
--- a/board/armltd/total_compute/total_compute.env
+++ b/board/armltd/total_compute/total_compute.env
@@ -4,21 +4,28 @@ load_addr=0xa0000000
 initrd_addr_r=0x88000000
 
 bootcmd=
-    if part number mmc 0 vbmeta is_avb; then
-        echo 'MMC with vbmeta partition detected.';
+    virtio scan;
+    if virtio info; then
+        blk_dev=virtio;
+    else;
+        blk_dev=mmc;
+    fi;
+    echo block device is ${blk_dev};
+    if part number ${blk_dev} 0 vbmeta is_avb; then
+        echo '${blk_dev} with vbmeta partition detected.';
         echo 'Starting Android Verified boot...';
-        avb init mmc 0;
+        avb init ${blk_dev} 0;
         if avb verify; then
             set bootargs $bootargs $avb_bootargs;
-            part start mmc 0 boot boot_start;
-            part size mmc 0 boot boot_size;
-            mmc read ${load_addr} ${boot_start} ${boot_size};
+            part start ${blk_dev} 0 boot boot_start;
+            part size ${blk_dev} 0 boot boot_size;
+            ${blk_dev} read ${load_addr} ${boot_start} ${boot_size};
             bootm ${load_addr} ${load_addr} ${fdt_addr_r};
         else;
             echo 'AVB verification failed.';
             exit;
         fi;
-    elif part number mmc 0 system is_non_avb_android; then
+    elif part number ${blk_dev} 0 system is_non_avb_android; then
         echo 'Booting Android non-AVB...';
         booti ${kernel_addr_r} ${initrd_addr_r} ${fdt_addr_r};
     elif iminfo ${load_addr}; then
-- 
2.34.1

