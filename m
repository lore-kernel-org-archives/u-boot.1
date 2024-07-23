Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9420C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 19:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAAD8708B;
	Tue, 23 Jul 2024 21:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ft2LQv+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E275871C9; Tue, 23 Jul 2024 21:34:41 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC6186E35
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 21:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=walter.lozano@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1721763277;
 bh=zXnVLWb2Eq9+YDl6tIhiD++e+F/5HmM+DeIukF8HO50=;
 h=From:To:Cc:Subject:Date:From;
 b=Ft2LQv+Y8JLFwZp02x6cpmPx088ejgxE2yu91X4BXKTe5vQU1okqN7UcuXXGvYheo
 cm21U3SeBB8kokDcaY/UAHwlcIuNqTmcVyiqTIv3QB5IWBMgbEoP4aZ7cXgmP6PL8f
 Q9x1BiOjDNLixcBpZzP+LfVqq6hGgy+pgegtznwlvrEL6oAbXhAEf05X0lpQujegp1
 S91cI3PR+8wlXrP2wB7WkcMQuThd4UzvyB5bhdKcUIm+FgZBR4bHrTkst4r0JHh7jw
 KAlpG+7doUu4rugGjRI1uV2Bqtby+/aXi7qAUUQh+eiy9MLvcR3g5tA8noDtVUeArl
 KOKBY/uBq6ZqQ==
Received: from notebook3.fibertel.com.ar
 (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: wlozano)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E57E43782016;
 Tue, 23 Jul 2024 19:34:34 +0000 (UTC)
From: Walter Lozano <walter.lozano@collabora.com>
To: u-boot@lists.denx.de,
	Martyn Welch <martyn@collabora.com>
Cc: Walter Lozano <walter.lozano@collabora.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] board: rpi: Update memory layout for Aarch64
Date: Tue, 23 Jul 2024 16:34:30 -0300
Message-Id: <20240723193430.3050251-1-walter.lozano@collabora.com>
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

The current approach is to reserve 128 MB for the kernel to allow boards
with 512 MB to have enough free space for other artifacts, such as
ramdisk.

Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
---

Changes in v2:
    Bump space reserved for linux from 50 MB to 128 MB

 board/raspberrypi/rpi/rpi.env | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285edd..68221678f16 100644
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
+fdt_addr_r=0x09800000
+ramdisk_addr_r=0x09900000
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

