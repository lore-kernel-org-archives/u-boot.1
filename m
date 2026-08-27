Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97E9C61DCD
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A413E40822;
	Thu, 27 Aug 2026 19:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t4ATmFyy0YVL; Thu, 27 Aug 2026 19:54:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860469;
	bh=gJ/SeMppFy3pOHRIeFR9WFTApK8jIAepwTGVN6EkdZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFbR6XPGVNY2arYiPu3c6HaMvs9P4fMM7AOhl3FP0i5gA+7TzvBSNZlmn0u3Kg3rV
	 leBJtVNPZintPq1c3uOiDHcRLzVvjIdvwJqUNzdxPLf6/zjNUy/zcoXc5ju1zA/2BC
	 fprh96xUvp7BMfC1MnDXJeLjgpb+KUsYeJgC7oT/0dkVfYQxhCs06+8EKB//5WuBaL
	 tLPiwEEXbPXjAk2hZWjRYkc+Q1b2kwn2vnNzP19YvyRJ5O8t/kHWP3i09c82mIFTtp
	 qOV70q7h3HEElQftnmgsG/MYxk8X1oT79Eqlm4Nm0auCxd1wSNtAiDVj44T1bKS5c8
	 5IzPTDheX7FHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3CD340871;
	Thu, 27 Aug 2026 19:54:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8096C105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73341400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fFWYBLd8SgZ1 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.173;
 helo=smtp-42ad.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=BO0HaThy
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 257DC400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:15 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzn50jPzq1s;
 Thu, 27 Aug 2026 21:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860452;
 bh=gJ/SeMppFy3pOHRIeFR9WFTApK8jIAepwTGVN6EkdZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BO0HaThyKh6SPtqUll3cAzXAGt+EGgzgcJbYg5nVxElx+QWRIMKvT/E62Fh1++1RA
 M65utBtDMg1cy2Dy0BdzVKqSjmayRWC65GmpKcz5Y8BM4vjvGjxs6Aaa6HyIpPsbRA
 AvOd/NP04tMZ3o3/N28Do4WvN7ch2eQsdQIGO3g7ful5FPxs/XG3Y+BTmzVVw4dcWq
 6fHwrQHD4S5GCuf4P6+ciaAL2P6lfbI6ff4z6IO2NZHIpbBQyPEx3xNnjFPZoNhwI+
 Izwm9LmZRaTJS1e76rke2D2i6/khRKRbOOBDYKjZb9N/FsMbWdThHA7BN6J6Pu9tZG
 cxwF9xt4+gUvA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzl3RR0zQfJ; Thu, 27 Aug 2026 21:54:11 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 43/45] doc: switch to HTTPS for a few links
Date: Thu, 27 Aug 2026 21:53:11 +0200
Message-ID: <20260827195313.129994-22-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

It's 2026, we really should be using HTTPS wherever possible. The links
in this commit were individually tested, they work fine (the sipeed one
sometimes times out but I'm guessing it's hosted in China and it's not
uncommon for Europeans to have issues reaching servers there).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/nios2.rst                  |  2 +-
 doc/arch/x86/x86.rst                |  6 +++---
 doc/board/amlogic/index.rst         |  2 +-
 doc/board/sipeed/maix.rst           |  2 +-
 doc/develop/driver-model/virtio.rst |  2 +-
 doc/develop/process.rst             |  2 +-
 doc/develop/sending_patches.rst     | 12 ++++++------
 doc/develop/uefi/iscsi.rst          |  4 ++--
 doc/usage/dfu.rst                   |  2 +-
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/arch/nios2.rst b/doc/arch/nios2.rst
index 90b4ddf387bf..a825b244ab7b 100644
--- a/doc/arch/nios2.rst
+++ b/doc/arch/nios2.rst
@@ -10,7 +10,7 @@ Please refer to the link for more information on Nios II:
 https://www.altera.com/products/processors/overview.html
 
 Please refer to the link for Linux port and toolchains:
-http://rocketboards.org/foswiki/view/Documentation/NiosIILinuxUserManual
+https://rocketboards.org/foswiki/view/Documentation/NiosIILinuxUserManual
 
 The Nios II port of u-boot is controlled by device tree. Please check
 out :doc:`/develop/devicetree/control`.
diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 28726f717f6e..9ba5c2893379 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -480,9 +480,9 @@ TODO List
 - Audio
 - Chrome OS verified boot
 
-.. _coreboot: http://www.coreboot.org
-.. _QEMU: http://www.qemu.org
-.. _microcode: http://en.wikipedia.org/wiki/Microcode
+.. _coreboot: https://www.coreboot.org
+.. _QEMU: https://www.qemu.org
+.. _microcode: https://en.wikipedia.org/wiki/Microcode
 .. _SFI: https://en.wikipedia.org/wiki/Simple_Firmware_Interface
 .. _MP: https://en.wikipedia.org/wiki/MultiProcessor_Specification
 .. _SeaBIOS: https://www.seabios.org/
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 23380ac33f2b..e8bb421ed8c9 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -6,7 +6,7 @@ Amlogic
 Hardware Support Matrix
 -----------------------
 
-An up-do-date matrix is also available on: http://linux-meson.com
+An up-do-date matrix is also available on: https://linux-meson.com
 
 This matrix concerns the actual source code version.
 
diff --git a/doc/board/sipeed/maix.rst b/doc/board/sipeed/maix.rst
index 4568bb3e4b74..9bbc2a93c5b0 100644
--- a/doc/board/sipeed/maix.rst
+++ b/doc/board/sipeed/maix.rst
@@ -19,7 +19,7 @@ Currently, only the Sipeed MAIX BiT V2.0 (bitm) and Sipeed MAIXDUINO are
 supported, but the boards are fairly similar.
 
 Documentation for Maix boards is available from
-`Sipeed's website <http://dl.sipeed.com/MAIX/HDK/>`_.
+`Sipeed's website <https://dl.sipeed.com/MAIX/HDK/>`_.
 Documentation for the Kendryte K210 is available from
 `Kendryte's website <https://kendryte.com/downloads/>`_. However, hardware
 details are rather lacking, so most technical reference has been taken from the
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 9a5e3240c3ce..e5da9f4301ca 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -284,5 +284,5 @@ for the remove method to be called before jumping to OS.
 
 6. do funny stuff with the driver
 
-.. _VirtIO: http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.pdf
+.. _VirtIO: https://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.pdf
 .. _QEMU: https://www.qemu.org
diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 3c783ed5a0e9..8ade440d84b1 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -236,7 +236,7 @@ Tooling
 
 There are a number of tools available to help custodians and
 contributors alike with their contributions. As a project we make use of
-the Patchwork project hosted at `OzLabs <http://patchwork.ozlabs.org/>`__
+the Patchwork project hosted at `OzLabs <https://patchwork.ozlabs.org/>`__
 and more discussion on how it is used from both a contributor as well as
 custodian point of view can be found :ref:`here <patchwork>`.
 
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 27363a448b23..b4f82eb18e16 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -15,7 +15,7 @@ resource - use it. Being familiar with the :doc:`process` is also important.
 
 A good introduction how to prepare for submitting patches can be found in the
 LWN article `How to Get Your Change Into the Linux Kernel
-<http://lwn.net/Articles/139918/>`_ as the same rules apply to U-Boot, too.
+<https://lwn.net/Articles/139918/>`_ as the same rules apply to U-Boot, too.
 
 .. _b4_contrib:
 
@@ -313,7 +313,7 @@ to observe the following rules.
   Note: it is *not* sufficient to provide a change log in some cover letter
   that gets sent as a separate message with the patch series. The reason is
   that such cover letters are not as easily reviewed in our `patchwork queue
-  <http://patchwork.ozlabs.org/project/uboot/list/>`_ so they are not helpful
+  <https://patchwork.ozlabs.org/project/uboot/list/>`_ so they are not helpful
   to any reviewers using this tool. Example::
 
    From: Joe Hacker <jh@hackers.paradise.com>
@@ -380,12 +380,12 @@ Notes
 Patch Tracking
 --------------
 
-Like some other projects, U-Boot uses `Patchwork <http://patchwork.ozlabs.org/>`__
+Like some other projects, U-Boot uses `Patchwork <https://patchwork.ozlabs.org/>`__
 to track the state of patches. This is one of the reasons why it is mandatory
 to submit all patches to the U-Boot mailing list - only then they will be
 picked up by patchwork.
 
-At http://patchwork.ozlabs.org/project/uboot/list/ you can find the list of
+At https://patchwork.ozlabs.org/project/uboot/list/ you can find the list of
 open U-Boot patches. By using the "Filters" link (Note: requires JavaScript)
 you can also select other views, for example, to include old patches that have,
 for example, already been applied or rejected.
@@ -470,7 +470,7 @@ Apply patches
 ^^^^^^^^^^^^^
 
 To apply a patch from the `patchwork queue
-<http://patchwork.ozlabs.org/project/uboot/list/>`_ using ``git``, download the
+<https://patchwork.ozlabs.org/project/uboot/list/>`_ using ``git``, download the
 mbox file and apply it using::
 
    git am file
@@ -495,7 +495,7 @@ The `pwclient` command line tool can be used for example to retrieve patches,
 search the queue or update the state.
 
 All necessary information for `pwclient` is linked from the bottom of
-http://patchwork.ozlabs.org/project/uboot/
+https://patchwork.ozlabs.org/project/uboot/
 
 Use::
 
diff --git a/doc/develop/uefi/iscsi.rst b/doc/develop/uefi/iscsi.rst
index 52fa79f35620..104ef87705fc 100644
--- a/doc/develop/uefi/iscsi.rst
+++ b/doc/develop/uefi/iscsi.rst
@@ -131,11 +131,11 @@ For running iPXE on arm64 the bin-arm64-efi/snp.efi build target is needed::
 
 The available commands for the boot script are documented at:
 
-http://ipxe.org/cmd
+https://ipxe.org/cmd
 
 Credentials are managed as environment variables. These are described here:
 
-http://ipxe.org/cfg
+https://ipxe.org/cfg
 
 iPXE by default will put the CPU to rest when waiting for input. U-Boot does
 not wake it up due to missing interrupt support. To avoid this behavior create
diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
index c825cdcbe5c9..987f287b483e 100644
--- a/doc/usage/dfu.rst
+++ b/doc/usage/dfu.rst
@@ -334,7 +334,7 @@ When U-Boot runs the dfu stack, the DFU host tools can be used
 to send/receive firmware images on each configured alternate.
 
 For example dfu-util is a host side implementation of the DFU 1.1
-specifications(http://dfu-util.sourceforge.net/) which works with U-Boot.
+specifications(https://dfu-util.sourceforge.net/) which works with U-Boot.
 
 Usage
 -----
