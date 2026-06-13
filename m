Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3221CD98CE
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 02:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FFE7839A8;
	Sat, 13 Jun 2026 04:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="D/1mTnI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17D883FEC; Sat, 13 Jun 2026 04:55:19 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E538063E
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 04:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C0469117BC0; Sat, 13 Jun 2026 04:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781319316; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=uMswIrQUR43IzfcSzirdjGLKPjcmCNoWP6k71oPSLhQ=;
 b=D/1mTnI926WL3fvEI9Aruha4FilyPnvhySraXBoT6R19+q4EvvKG1IIF/9bocG+yMgcjMo
 Vf/IDoUaezvv8TQBYk1XpAPae8wue92PIJFBzW0JaXoovm0C6NSFYgQmBTdlXpTvmRkT8k
 hDHpl6L36wmk/Pce+D89Br5s4tMvbKtgmvMlTi3wMrnThUbebv9I4u0PVoosHWD0FLf9on
 MvM06SiQMMPidtfjHyDzmdmxdnp5KfkjDA2FovsMVPByVbTRgqVi8LPzDlE66PAKRNtqjJ
 CPntMLsASEh7/ZWcQy2Juu1jt7p6qRx1LLq20d7ZBdpuFMfUACyW8fpE/Jgyrg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: ums: Set Device Descriptor iSerial based on serial# env
 variable
Date: Sat, 13 Jun 2026 04:54:23 +0200
Message-ID: <20260613025510.134239-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The DFU code currently sets the content of "serial#" environment
variable into Device Descriptor iSerial field. This is useful when
there are multiple devices connected to the same host PC and they
have to be told apart. Replicate the same behavior in the UMS code.

Example without serial# set, which is the original behavior:
"
u-boot=> ums 0 mmc 1
UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000

$ dmesg -w
...
usb 5-2.3.7: New USB device found, idVendor=0525, idProduct=a4a5, bcdDevice=7e.a7
usb 5-2.3.7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-2.3.7: Product: USB download gadget
usb 5-2.3.7: Manufacturer: Vendor
                            <------------------------------- NOT HERE
usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
...

$ lsusb -vd 0525:a4a5

Bus 005 Device 051: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB File-backed Storage Gadget
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0525 Netchip Technology, Inc.
  idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
  bcdDevice           7e.a7
  iManufacturer           1 Vendor
  iProduct                2 USB download gadget
  iSerial                 0 <------------------------------- NOT HERE
...
"

Example with serial# set to 1234abcd, which is the optional new behavior:
"
u-boot=> setenv serial# 1234abcd <------------------------------ HERE
u-boot=> ums 0 mmc 1
UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x1d5a000

$ dmesg -w
...
usb 5-2.3.7: New USB device found, idVendor=0525, idProduct=a4a5, bcdDevice=7e.a7
usb 5-2.3.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 5-2.3.7: Product: USB download gadget
usb 5-2.3.7: Manufacturer: Vendor
usb 5-2.3.7: SerialNumber: 1234abcd <--------------------------- HERE
usb-storage 5-2.3.7:1.0: USB Mass Storage device detected
...

$ lsusb -vd 0525:a4a5

Bus 005 Device 052: ID 0525:a4a5 Netchip Technology, Inc. Linux-USB File-backed Storage Gadget
Negotiated speed: High Speed (480Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0525 Netchip Technology, Inc.
  idProduct          0xa4a5 Linux-USB File-backed Storage Gadget
  bcdDevice           7e.a7
  iManufacturer           1 Vendor
  iProduct                2 USB download gadget
  iSerial                 3 1234abcd <-------------------------- HERE
...
"

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 cmd/usb_mass_storage.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
index e8b87045bdc..335258d7a56 100644
--- a/cmd/usb_mass_storage.c
+++ b/cmd/usb_mass_storage.c
@@ -9,6 +9,7 @@
 #include <blk.h>
 #include <command.h>
 #include <console.h>
+#include <env.h>
 #include <errno.h>
 #include <g_dnl.h>
 #include <malloc.h>
@@ -65,7 +66,7 @@ static void ums_fini(void)
 
 static int ums_init(const char *devtype, const char *devnums_part_str)
 {
-	char *s, *t, *devnum_part_str, *name;
+	char *s, *t, *devnum_part_str, *name, *sn;
 	struct blk_desc *block_dev;
 	struct disk_partition info;
 	int partnum;
@@ -76,6 +77,12 @@ static int ums_init(const char *devtype, const char *devnums_part_str)
 	if (!s)
 		return -1;
 
+	if (CONFIG_IS_ENABLED(ENV_SUPPORT)) {
+		sn = env_get("serial#");
+		if (sn)
+			g_dnl_set_serialnumber(sn);
+	}
+
 	t = s;
 	ums_count = 0;
 
-- 
2.53.0

