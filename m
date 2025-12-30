Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8D3EE0213
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 15:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C51583F53;
	Tue, 30 Dec 2025 16:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="F8VKW96A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 196C783F70; Tue, 30 Dec 2025 16:45:51 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5643A83DA9
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manjae.cho@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20251230154545epoutp04764d0dc66ed87aed684f730eb74be911~GCMTnyyEq1304513045epoutp04Q
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 15:45:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20251230154545epoutp04764d0dc66ed87aed684f730eb74be911~GCMTnyyEq1304513045epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1767109545;
 bh=wINHWN8O5NRubWx+JWqF+AkoY7ieIHr+V2vw8skbmRk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F8VKW96A3x4GIgWHYdLYCNl1XhduEgMAtm5Fe2tggnvcLDj3c0s1TOEEqNHerNoXj
 CQ4jbV3MEyd1vnXcb+uLHRvxtqj+J1oNw2LqNKUfWnFT0ovmplqchQf1uvByL3p3Wk
 p1lkInEWahoFQY5wpt7y1kT6spwYJkn+DQ7H32d8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
 20251230154545epcas1p3dd360b75066935abb9a4f2d40067026f~GCMTXcjcJ2016520165epcas1p34;
 Tue, 30 Dec 2025 15:45:45 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.117]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4dgcqr6dlBz6B9m4; Tue, 30 Dec
 2025 15:45:44 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20251230154543epcas1p1fccdde722bb4c0c3de6e64ef12d4a334~GCMR7Wahk1941219412epcas1p1A;
 Tue, 30 Dec 2025 15:45:43 +0000 (GMT)
Received: from manjaecho-VirtualBox.. (unknown [10.89.15.251]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20251230154543epsmtip18ae083cc502cf58bca8d4c50d872d087~GCMR5R03-3032630326epsmtip1N;
 Tue, 30 Dec 2025 15:45:43 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: u-boot@lists.denx.de
Cc: heinrich.schuchardt@canonical.com, trini@konsulko.com,
 sujin.u@mobis.com, Manjae Cho <manjae.cho@samsung.com>
Subject: [PATCH v2 2/2] doc: emulation: Add network testing documentation
Date: Wed, 31 Dec 2025 00:45:29 +0900
Message-ID: <20251230154529.29724-3-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230154529.29724-1-manjae.cho@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251230154543epcas1p1fccdde722bb4c0c3de6e64ef12d4a334
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251230154543epcas1p1fccdde722bb4c0c3de6e64ef12d4a334
References: <20251227142036.10661-1-manjae.cho@samsung.com>
 <20251230154529.29724-1-manjae.cho@samsung.com>
 <CGME20251230154543epcas1p1fccdde722bb4c0c3de6e64ef12d4a334@epcas1p1.samsung.com>
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

Add network testing documentation for QEMU emulation based on actual
runtime testing with qemu-system-riscv64 and U-Boot.

Tested and verified:
- VirtIO network device detection (virtio-net-device)
- DHCP client functionality
- TFTP file loading from QEMU's built-in TFTP server

The documentation covers VirtIO devices for both MMIO-based (RISC-V)
and PCI-based (x86) machines, with practical examples of U-Boot commands
and expected output.

Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
---
 doc/board/emulation/index.rst   |  1 +
 doc/board/emulation/network.rst | 58 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 doc/board/emulation/network.rst

diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index f8908166276..507c38825c1 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -8,6 +8,7 @@ Emulation
 
    acpi
    blkdev
+   index
    qemu-arm
    qemu-mips
    qemu-ppce500
diff --git a/doc/board/emulation/network.rst b/doc/board/emulation/network.rst
new file mode 100644
index 00000000000..6a08a6611b4
--- /dev/null
+++ b/doc/board/emulation/network.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Emulation of network devices
+-----------------------------
+
+QEMU can emulate network devices for testing U-Boot networking functionality.
+The device type depends on the machine architecture:
+
+* VirtIO (for RISC-V and other virtio-bus machines)
+
+  .. code-block:: bash
+
+      qemu-system-riscv64 -nographic -machine virt -bios opensbi.bin \
+      -kernel u-boot.bin -m 256M \
+      -netdev user,id=net0 -device virtio-net-device,netdev=net0
+
+* VirtIO PCI (for x86 and other PCI-based machines)
+
+  .. code-block:: bash
+
+      qemu-system-x86_64 -nographic -bios u-boot.bin \
+      -netdev user,id=net0 -device virtio-net-pci,netdev=net0
+
+The 'user' networking backend provides a simple way to test DHCP and basic
+networking without host configuration. In U-Boot, you can verify the network
+device is detected:
+
+.. code-block:: none
+
+    => net list
+    eth0 : virtio-net#0 52:54:00:12:34:56 active
+
+TFTP boot
+^^^^^^^^^
+
+QEMU's user networking includes a built-in TFTP server. To enable it, specify
+a host directory to serve files from:
+
+.. code-block:: bash
+
+    -netdev user,id=net0,tftp=/path/to/tftp/root
+
+From U-Boot, you can load files using DHCP and TFTP:
+
+.. code-block:: none
+
+    => setenv autoload no
+    => dhcp
+    DHCP client bound to address 10.0.2.15 (1 ms)
+    => tftp ${loadaddr} test.txt
+    Using virtio-net#0 device
+    TFTP from server 10.0.2.2; our IP address is 10.0.2.15
+    Filename 'test.txt'.
+    Load address: 0x80200000
+    Loading: *
+             15.6 KiB/s
+    done
+    Bytes transferred = 16 (10 hex)
-- 
2.43.0

