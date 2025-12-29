Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B048E9273E
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 16:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B647283E70;
	Mon, 29 Dec 2025 17:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R8I4+yya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8460883E85; Mon, 29 Dec 2025 17:34:55 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA5483E21
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 17:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4C107403B1; 
 Mon, 29 Dec 2025 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767026092;
 bh=oVko6UFrb+YgOl74wpp5dKcJSEjeIM9qN6rxeRsJS3Y=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=R8I4+yya62kUIDIGq9EnyjfJZMcq6PVIqqyGSOaDGNSFVeNR2pZVJdZXeX64ZHj2v
 1y50az/ZnGOLD3NVUk379gBcbtA4Z7Ung1zsJ76SWqIDk1qoZDvF9/42AwBnLb4RNH
 2wHmct9YbTa8tO82F7HVJJZ6kHEL+NhqAD3g7vp5e7a4nd3gEbAjE/8CB+8YqN8CNZ
 T7s++GQntc5M51s8bVN6c0ujIDNNE8ZXLdNtdGa+hdhweGPGNROpCgngF0me/DRmvv
 ejP3LFLG78YwsDH4RdmA7T5iqCjPwWBbC3lD063ZFM8UzQjj7e2kkbnxDqyMVmXAcx
 vItKGWct5OnroNPwdWeeKq2pYrx9ugsiXTr53vM0MbfWyjQkoj8pznRWOzzA8gRtUr
 vdJhXpGluiCx37z0AM4132pc8Inw4nvmBwN2MbgJjnWE8ArBs3Yx073DxQZhoI2bHd
 9ujTV33Y4VRb74d8N1w2+F0g3aXREVsuGbTJfYg2gI9kCumiVkPD2Kf1I9RhUsXkL8
 O+A1bEVuLgtSbApz1ug4xFOu/COQCegFBpqKOkgf/AG5JFrZv6AAdsaJBgzOBlPZe1
 Vra2iI+2Y6dzzEcSXnfnNJ5Lt/k0jjoQzz/XU17u798J5aJFPQfbtgSXklh0IXheB5
 VgT6gz9ugWOfx8PRmgQfwQlI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Manjae Cho <manjae.cho@samsung.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: describe QEMU networking
Date: Mon, 29 Dec 2025 17:34:48 +0100
Message-ID: <20251229163448.182538-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Add a chapter about networking to the QEMU board documentation.

Describe both different types of networking as well as different emulated
NICs.

Suggested-by: Manjae Cho <manjae.cho@samsung.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/emulation/index.rst   |   1 +
 doc/board/emulation/network.rst | 152 ++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 doc/board/emulation/network.rst

diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index f8908166276..896f44c8087 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -8,6 +8,7 @@ Emulation
 
    acpi
    blkdev
+   network
    qemu-arm
    qemu-mips
    qemu-ppce500
diff --git a/doc/board/emulation/network.rst b/doc/board/emulation/network.rst
new file mode 100644
index 00000000000..e997265c297
--- /dev/null
+++ b/doc/board/emulation/network.rst
@@ -0,0 +1,152 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Emulation of network devices
+============================
+
+Networking types
+----------------
+
+QEMU can emulate different types of networks:
+
+User networking
+'''''''''''''''
+
+User networking is the easiest to use. QEMU provides NAT translation and a DHCP
+server.
+
+.. code-block:: bash
+
+    -netdev user,id=eth0 \
+    -device virtio-net,netdev=eth0
+
+Port forwarding
+~~~~~~~~~~~~~~~
+
+The emulated device can access the outside network but cannot be reached from
+outside by default. Forwarding rules can be added.
+
+In the example the SSH port 22 of the default interface of the emulated device
+is forwarded to port 2222 of the loopback interface of the host.
+
+.. code-block:: bash
+
+    -netdev user,id=eth0,hostfwd=tcp:127.0.0.1:2222-:22 \
+    -device virtio-net,netdev=eth0
+
+TFTP
+~~~~
+
+A TFTP server can be added by specifying a file path.
+
+.. code-block:: bash
+
+    -netdev user,id=eth0,tftp=/path/to/tftpdir \
+    -device virtio-net,netdev=eth0
+
+Bridge networking
+'''''''''''''''''
+
+The emulated NIC is connected to an existing bridge device.
+
+.. code-block:: bash
+
+    -netdev bridge,id=eth0,br=virbr0 \
+    -device virtio-net,netdev=eth0
+
+The emulated device becomes part of the same local network as the bridge.
+
+Tap networking
+''''''''''''''
+
+With tap networking a tap device is created on the host.
+
+.. code-block:: bash
+
+    -netdev tap,id=eth0 \
+    -device virtio-net,netdev=eth0
+
+Emulated network interface controllers
+--------------------------------------
+
+QEMU can emulate different NICs. For best performance choose ``virtio-net``.
+
+Intel E1000
+'''''''''''
+
+U-Boot's E1000 driver supports a number of Intel PCI NICs. This includes the
+QEMU devices ``e1000``, ``e1000-82544gc``, and ``e1000-82545em``.
+
+.. code-block:: bash
+
+    -netdev user,id=eth0 \
+    -device e1000,netdev=eth0
+
+Configuration:
+
+* CONFIG_PCI=y
+* CONFIG_E1000=y
+
+Realtek RTL8139
+'''''''''''''''
+
+The RTL8139 is a PCI network card.
+The U-Boot driver only supports the i386 archtitecture.
+
+.. code-block:: bash
+
+    -netdev user,id=eth0 \
+    -device rtl8139,netdev=eth0
+
+Configuration:
+
+* CONFIG_PCI=y
+* CONFIG_NET_RANDOM_ETHADDR=y
+* CONFIG_RTL8139
+
+Virtio
+''''''
+
+U-Boot's virtio network driver supports ``virtio-net``, ``virtio-net-device``,
+and ``virtio-net-pci`` devices. ``virtio-net-device`` uses MMIO, while
+``virtio-net-pci`` uses PCI.
+
+For best performance use ``virtio-net``.
+
+.. code-block:: bash
+
+    -netdev user,id=eth0 \
+    -device virtio-net,netdev=eth0
+
+Configuration:
+
+* CONFIG_PCI=y (only for ``virtio-net-pci``)
+* CONFIG_NET_VIRTIO=y
+
+Network device options
+----------------------
+
+The network adapters provide different configuration parameters.
+Here are some common ones.
+
+mac
+    set MAC address
+
+    .. code-block:: bash
+
+        -netdev user,id=eth0 \
+        -device virtio-net-pci,netdev=eth0,mac=00:00:00:00:01:01
+
+romfile
+    provide the ROM file of the NIC
+
+    .. code-block:: bash
+
+        -netdev user,id=eth0 \
+        -device virtio-net-pci,netdev=eth0,romfile=pxe-virtio.rom
+
+    or provide none
+
+    .. code-block:: bash
+
+        -netdev user,id=eth0 \
+        -device virtio-net-pci,netdev=eth0,romfile=
-- 
2.51.0

