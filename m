Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648FEC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 17:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8EC887D1;
	Tue, 16 Jul 2024 19:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="5Z+daMFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8322F889EC; Tue, 16 Jul 2024 19:16:27 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7866A887D1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 19:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=walter.lozano@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1721150184;
 bh=juGs3/L9E2g07UG8JmB0zdxQM/ZYq5INDGdC7JZe8T8=;
 h=From:To:Cc:Subject:Date:From;
 b=5Z+daMFrXGx4LXrKxs9Q8mrh5qrmCoGpFn8IpNoHGiLTeZrSKm2qel/EUhY5avB8U
 L1I5us92gRqefoSk8A+KsRGE5yXsIMxLb7u1fQ2zMY4/O0zhetgvUr8cj0Sh66bnD8
 nq+/4ibVFBduuoCe+JClB9ypS5VyqeUtoIP/H882c6ylFlkLgc/T8NYYp/AIV6s0k4
 1oKrXa51o+6HuJDlNGmTi0ewKYSptMRjwjUGyQrlVMtSjWEPWsxuB9sMktus3UwoPd
 muvhvBfg/uQsSIUV7O5RqUmnVUAR7VmHiPxLe5RSEOowIpy9+8/N9oDIkd3ZUF2wtU
 YPOIJOk+/9rGA==
Received: from notebook3.fibertel.com.ar
 (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: wlozano)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 995EC37821D8;
 Tue, 16 Jul 2024 17:16:22 +0000 (UTC)
From: Walter Lozano <walter.lozano@collabora.com>
To: u-boot@lists.denx.de,
	Martyn Welch <martyn@collabora.com>
Cc: Walter Lozano <walter.lozano@collabora.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: rpi: Update memory layout for Aarch64
Date: Tue, 16 Jul 2024 14:16:02 -0300
Message-Id: <20240716171602.2279766-1-walter.lozano@collabora.com>
X-Mailer: git-send-email 2.40.1
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

ARM and Aarch64 have different restrictions and trying to accommodate
larger kernels like the ones used in distros can be challenging. For this
reason, separate the layout and rearrange the map for Aarch64 to support
kernels larger than 36 MB.

Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
---

 board/raspberrypi/rpi/rpi.env | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285edd..37c7f6a920e 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -42,13 +42,19 @@ dfu_alt_info+=zImage fat 0 1
  *   For Aarch64, the kernel image is uncompressed and must be loaded at
  *   text_offset bytes (specified in the header of the Image) into a 2MB
  *   boundary. The 'booti' command relocates the image if necessary. Linux uses
- *   a default text_offset of 0x80000.  In summary, loading at 0x80000
- *   satisfies all these constraints and reserving memory up to 0x02400000
- *   permits fairly large (roughly 36M) kernels.
+ *   a default text_offset of 0x80000.  However, loading it at 0x80000
+ *   will allow to reserve only up to 0x02400000 which permits medium size
+ *   kernels (roughly 36M). This is good enough for customized kernels but
+ *   not for distros which by default enable drivers for many different
+ *   boards. Under these circumstances, using 0x00200000 provides room for
+ *   larger kernels.
  *
  * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
  * conflict with something else. Reserving 1M for each of them at
- * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
+ * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty for ARM.
+ *
+ *   For Aarch64, since the kernel is placed in different location,
+ *   accommodate them to reserver 1M for each of them.
  *
  * On ARM, both the DTB and any possible initrd must be loaded such that they
  * fit inside the lowmem mapping in Linux. In practice, this usually means not
@@ -62,16 +68,21 @@ dfu_alt_info+=zImage fat 0 1
  * large initrds before they start colliding with U-Boot.
  */
 #ifdef CONFIG_ARM64
+pxefile_addr_r=0x00080000
+scriptaddr=0x00100000
+kernel_addr_r=0x00200000
+fdt_addr_r=0x03400000
+ramdisk_addr_r=0x03500000
 fdt_high=ffffffffffffffff
 initrd_high=ffffffffffffffff
 #else
-fdt_high=ffffffff
-initrd_high=ffffffff
-#endif
 kernel_addr_r=0x00080000
 scriptaddr=0x02400000
 pxefile_addr_r=0x02500000
 fdt_addr_r=0x02600000
 ramdisk_addr_r=0x02700000
+fdt_high=ffffffff
+initrd_high=ffffffff
+#endif
 
 boot_targets=mmc usb pxe dhcp
-- 
2.40.1

