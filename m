Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D988C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D699680719;
	Tue, 14 Jan 2025 18:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="NE9UrvW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15DBC8060C; Tue, 14 Jan 2025 17:47:39 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643C68007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736873254; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WKz1FrxEK+PLtGGjtrsLjpb5y93gmR2mVzA1GbEXfKy6p2K80YT1Y3x8Et9LFymPBmgo5479m7+FYeozlDWXNqAEQZkxfWIE44LW6lIaNFgncNO3oUN2+HXrJlkGsQ7irGOGjHlPfRNerb2YcTOqd3EEVqo+vEm1rHJRP8C+SpI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736873254;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sowDOmbbLwQE5LRvkVWWEIUVztCW9Hs45oAA8h+9g5w=; 
 b=C3h70zZ2v7l5mekmOTOfQUgbYBnna12zLyAGG0blx2XIcUyeDxr2p3fUZO4xl+oL4T1e6LjI8qahRPSFq3HhzrSDJGZjFqbRmoWCWFeb+ULQVFQcsOA2B8K9Cg4qCzUbdxovsDL1gHG198BysKb/3soSQaCqb3zg+fhQa9Gckik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736873254; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=sowDOmbbLwQE5LRvkVWWEIUVztCW9Hs45oAA8h+9g5w=;
 b=NE9UrvW2vc07Nzc/tov7oOuYET8yq8WqE089gsKx/ItEphRFsVtRAYF5cvClZZme
 6v8H4lEyGO6Hl0gwv2xDcbVpe/QE/TALJk6n4j8UxqoXCF3PqZxaNn6EFWf4KSBx+Io
 AfzMb9SCrhy65AmYxz9n8MsG3HBYUCU7RraizOis=
Received: by mx.zohomail.com with SMTPS id 1736873252724117.97056886506834;
 Tue, 14 Jan 2025 08:47:32 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 15 Jan 2025 00:46:41 +0800
Subject: [PATCH 5/5] doc: canaan: Add K230 CanMV board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-k230-dev-1-v1-5-f4b77259e34a@pigmoral.tech>
References: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
In-Reply-To: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736873211; l=4032;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=kgoALCnCzUCJLVcgTUtprD9SvQYcnFdCPECVPkasuoc=;
 b=v6SIa7DPz3tcaDKXbU6ocF77IKKcmmkmruThHKAePgi4/+0SpcBk/ruc76MD++gkWXAoufegf
 UJYM17NRXnXB1H9Gff2kMlsJxWj38+KNXX4DN+cCjNvExXBBe/ZlVU3
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 14 Jan 2025 18:26:11 +0100
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

Add description of compiling u-boot for K230 CanMV.

Since the vendor's u-boot-spl verifies u-boot header [1], it is
necessary to use the Python script from vendor to add the header to the
u-boot image.

[1] https://github.com/kendryte/k230_sdk/blob/v1.8/src/little/uboot/board/canaan/common/k230_board_common.h#L52

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 doc/board/canaan/index.rst      |  8 ++++
 doc/board/canaan/k230_canmv.rst | 88 +++++++++++++++++++++++++++++++++++++++++
 doc/board/index.rst             |  1 +
 3 files changed, 97 insertions(+)

diff --git a/doc/board/canaan/index.rst b/doc/board/canaan/index.rst
new file mode 100644
index 0000000000000000000000000000000000000000..e2892d2a7f342f507516a11eb81cd26181ecf66b
--- /dev/null
+++ b/doc/board/canaan/index.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Canaan
+======
+.. toctree::
+   :maxdepth: 1
+
+   k230_canmv
diff --git a/doc/board/canaan/k230_canmv.rst b/doc/board/canaan/k230_canmv.rst
new file mode 100644
index 0000000000000000000000000000000000000000..534ad7cb7a89ad1de2b18bcac64c120cdaec5003
--- /dev/null
+++ b/doc/board/canaan/k230_canmv.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+K230 CanMV
+==========
+
+K230 RISC-V SoC
+------------------
+The K230 chip is the latest generation SoC product in Canaan Technology's
+Kendryte series of AIOT chips.
+
+Mainline support
+----------------
+
+The support for following drivers are already enabled:
+
+1. ns16550 UART
+2. DWC2 OTG USB controller
+
+Building
+~~~~~~~~
+
+1. Get the RISC-V toolchain.
+2. Setup cross compilation environment variable:
+3. Get the `firmware_gen.py`_ from vendor.
+
+.. code-block:: console
+
+   export CROSS_COMPILE=riscv64-linux-gnu-
+   cd <U-Boot-dir>
+   make k230_canmv_defconfig
+   make
+   cp u-boot-gz.img u-boot-gz.img.tmp
+   pip install gmssl pycryptodome
+   python3 firmware_gen.py -i u-boot-gz.img.tmp -o u-boot-head.img -n
+
+This will generate u-boot-head.img.
+
+.. _firmware_gen.py: https://raw.githubusercontent.com/kendryte/k230_sdk/refs/tags/v1.8/src/little/uboot/tools/firmware_gen.py
+
+Booting
+~~~~~~~
+
+Currently, we rely on vendor u-boot-spl to initialize the
+ddr and load the u-boot image, then bootup from it.
+
+1. Prepare a SD card with the `vendor image`_ burned on it.
+
+2. Write the U-Boot image to the SD card at offset 2MB.
+
+.. code-block:: console
+
+   dd if=u-boot-head.img of=/dev/sd[x] bs=1M seek=2
+
+3. Insert the SD card into the board and power it on.
+
+.. _vendor image: https://kendryte-download.canaan-creative.com/developer/k230/CanMV-K230_debian_sdcard_sdk_1.3.img.gz
+
+Sample boot log from K230 CanMV board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: none
+
+   U-Boot 2025.01-00645-g2d81c4788455 (Jan 14 2025 - 23:15:07 +0800)
+
+   DRAM:  512 MiB
+   Core:  15 devices, 11 uclasses, devicetree: separate
+   Loading Environment from nowhere... OK
+   In:    serial@91400000
+   Out:   serial@91400000
+   Err:   serial@91400000
+   Net:   No ethernet found.
+   K230# cpu list
+     0: cpu@0      thead,c908
+   K230# usb start
+   starting USB...
+   Bus usb@91540000: USB DWC2
+   scanning bus usb@91540000 for devices...
+   Warning: r8152_eth (eth0) using random MAC address - 1e:33:97:47:e6:32
+   2 USB Device(s) found
+   K230# usb tree
+   USB device tree:
+     1  Hub (480 Mb/s, 0mA)
+     |   U-Boot Root Hub
+     |
+     +-2  Vendor specific (480 Mb/s, 100mA)
+          Realtek USB 10/100 LAN 000000000000
+
+   K230#
diff --git a/doc/board/index.rst b/doc/board/index.rst
index b1c470eb2cbb1c07f907eb2282039520c219c72a..74c4dd1f42d7e6a6d877020a79cb0a4f9c7c5335 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -21,6 +21,7 @@ Board-specific doc
    beagle/index
    broadcom/index
    bsh/index
+   canaan/index
    cloos/index
    congatec/index
    coolpi/index

-- 
2.47.1

