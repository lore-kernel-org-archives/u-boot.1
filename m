Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53103EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 17:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065128697E;
	Mon, 14 Aug 2023 19:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QsofhgJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44A98697E; Mon, 14 Aug 2023 19:40:08 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5098694B
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe4b45a336so41430535e9.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692034806; x=1692639606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8g0G95uplBTC5nG01BrLZ6HAKrRlSJw9w9pGTjBnzc=;
 b=QsofhgJ0+Q97nizvrIk2W92glUJk2Wq2+tMEEVWV4MflaQIoJ4WAXPHvmecqXzX1eg
 WFrei4s2HzkevmXK531O3VvRfeCpKEh0tV1g5yL4lbKOFba327ieQfHNy+j+hHWdNWMO
 TXllq/FVg6vM/6prtDRucG2CWJ6YTyOxZeLiDdI0I1Nb67/N8WW+sByb9L4DSuSuMmlw
 Nw5Xc7mVOya99kFv0Er5NGe/cPzBtHNpzgV+LnIFmTFduxCkFbzM4yHo/a/x229UMs6L
 PmZz3b8ZfnPdy5V54Yp4zZVVSGP7oy6XIvnhS2BLwoCSl0NQ+qO5PFsyEtuXNJbjEgAZ
 gl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692034806; x=1692639606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8g0G95uplBTC5nG01BrLZ6HAKrRlSJw9w9pGTjBnzc=;
 b=QdM4fhuCyevthtEAsSF7alL8SCDpsM6FznZTETdRyi6Pxh55YD2ij8EG7wPXW//qip
 ImeomtKHEngs/UGkaYRxHiYM2bO5APU9Y3yodNCLswNbdamra91RWNcW+amnSR75kQPF
 CyIplPUNtkK6VkYO1ewn9vxEGHi6YIrThf6xHYOPmdPKhP3SsONUcq55jinwWbw9VL1H
 ccNM+0dXyF6C8+Lx4jCVzB/HUpmAQREqP15OG4kcbl1hdhsw1THwPujaKnAEFelZojM4
 Dk5uTlFhT+ImfcSmAFfq7KzVrTnudzElhKactd2/igcrOnsirKsC+FcovQ1NILaGBq5A
 tHjA==
X-Gm-Message-State: AOJu0YxENE0ggW95uBEBGD+O+QIUaFIzASYm07TVCtTLUa8JkWGSQnPd
 Zbq5nGzrJ3W5BFsnQ+SUftnaa8i9pA8=
X-Google-Smtp-Source: AGHT+IHKWjepfp7dCgJ+gs1oh+iO3I0j/8hy05eqyElUx1r4MUlx/hzTr6bB2C47NJUeQBcUDHVJIw==
X-Received: by 2002:a1c:6a14:0:b0:3fd:2f8e:2c69 with SMTP id
 f20-20020a1c6a14000000b003fd2f8e2c69mr8055775wmc.32.1692034806229; 
 Mon, 14 Aug 2023 10:40:06 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 n24-20020a7bcbd8000000b003fbb0c01d4bsm15002406wmi.16.2023.08.14.10.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 10:40:05 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng@tinylab.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 4/4] doc: qemu: arm: Add a section on booting Linux distros
Date: Mon, 14 Aug 2023 20:39:44 +0300
Message-Id: <20230814173944.288356-5-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814173944.288356-1-alpernebiyasak@gmail.com>
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
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

Add an example qemu-system-aarch64 command that can make U-Boot on QEMU
boot into the Debian Installer, along with resulting console messages
from U-Boot, based on the existing documentation section for the x86
version.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
I actually want to put the root.img device first so that the VM can boot
into the installed system when it reboots, but U-Boot can't find the
bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
scan -lab`, but it seems to only ever search the first virtio-blk.
However, `eficonfig; bootefi bootmgr` makes it boot somehow.

Changes in v2:
- Add new patch for doc section on booting Linux distros

 doc/board/emulation/qemu-arm.rst | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 8ec5349fc9ea..78bcc3ee44c0 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -98,6 +98,74 @@ can be enabled with the following command line parameters:
 
 These have been tested in QEMU 2.9.0 but should work in at least 2.5.0 as well.
 
+Booting distros
+---------------
+
+It is possible to install and boot a standard Linux distribution using
+qemu_arm64 by setting up a root disk::
+
+    qemu-img create root.img 20G
+
+then using the installer to install. For example, with Debian 12::
+
+    qemu-system-aarch64 \
+      -machine virt -cpu cortex-a53 -m 4G -smp 4 \
+      -bios u-boot.bin \
+      -serial stdio -device VGA \
+      -nic user,model=virtio-net-pci \
+      -device virtio-rng-pci \
+      -device qemu-xhci,id=xhci \
+      -device usb-kbd -device usb-tablet \
+      -drive if=virtio,file=debian-12.0.0-arm64-netinst.iso,format=raw,readonly=on,media=cdrom \
+      -drive if=virtio,file=root.img,format=raw,media=disk
+
+The output will be something like this::
+
+    U-Boot 2023.10-rc2-00075-gbe8fbe718e35 (Aug 11 2023 - 08:38:49 +0000)
+
+    DRAM:  4 GiB
+    Core:  51 devices, 14 uclasses, devicetree: board
+    Flash: 64 MiB
+    Loading Environment from Flash... *** Warning - bad CRC, using default environment
+
+    In:    serial,usbkbd
+    Out:   serial,vidconsole
+    Err:   serial,vidconsole
+    Bus xhci_pci: Register 8001040 NbrPorts 8
+    Starting the controller
+    USB XHCI 1.00
+    scanning bus xhci_pci for devices... 3 USB Device(s) found
+    Net:   eth0: virtio-net#32
+    Hit any key to stop autoboot:  0
+    Scanning for bootflows in all bootdevs
+    Seq  Method       State   Uclass    Part  Name                      Filename
+    ---  -----------  ------  --------  ----  ------------------------  ----------------
+    Scanning global bootmeth 'efi_mgr':
+    Scanning bootdev 'fw-cfg@9020000.bootdev':
+    fatal: no kernel available
+    scanning bus for devices...
+    Scanning bootdev 'virtio-blk#34.bootdev':
+      0  efi          ready   virtio       2  virtio-blk#34.bootdev.par efi/boot/bootaa64.efi
+    ** Booting bootflow 'virtio-blk#34.bootdev.part_2' with efi
+    Using prior-stage device tree
+    Failed to load EFI variables
+    Error: writing contents
+    ** Unable to write file ubootefi.var **
+    Failed to persist EFI variables
+    Missing TPMv2 device for EFI_TCG_PROTOCOL
+    Booting /efi\boot\bootaa64.efi
+    Error: writing contents
+    ** Unable to write file ubootefi.var **
+    Failed to persist EFI variables
+    Welcome to GRUB!
+
+Standard boot looks through various available devices and finds the virtio
+disks, then boots from the first one. After a second or so the grub menu appears
+and you can work through the installer flow normally.
+
+After the installation, you can boot into the installed system by running QEMU
+again without the drive argument corresponding to the installer CD image.
+
 Enabling TPMv2 support
 ----------------------
 
-- 
2.40.1

