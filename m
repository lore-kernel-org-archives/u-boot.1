Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC14C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32F4060B27;
	Fri, 31 Jul 2026 17:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KJbOWQ9fPdqx; Fri, 31 Jul 2026 17:19:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC70260AE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518348;
	bh=dJaM5vWhBrRzcK/E0/qdTvjIlpp4N4oSto0zv9yOAlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P2hSpn3lrufDIK1/92NG544U2VoxElcYcKQVxrKzwszU7xaGaKBze7aW4Nwd2O61t
	 EIYW7z0fPkNu8qFqspiJxcpzuP+ppirQge37ZPmqEGYVCQX2akCmhf8q+ZDcUPsY7t
	 YZ1cqI0vvI+J56A0p3Ja1vdcy4unRdshbjYs5m5lAWu9s164hyx0n1adyYnGHgVq7/
	 3zrSYHUO7Im6PXCUvoMkvQoep9fN39XRuEn8du7JY+22IN3vyFJT1BNE8RITj90BQ+
	 LPPUleZ5r56tKhaBxkkucCKuC7Id7WDRTVjPl644Wx0S2X3Jk2Zz4GUjUv5fpNlTWq
	 aaj5fG5e40x/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC70260AE5;
	Fri, 31 Jul 2026 17:19:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B586669
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B83580EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:12:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-3IfzfkJFCS for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:12:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 492B780E41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 492B780E41
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 492B780E41
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:12:07 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so1191977f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517925; x=1786122725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dJaM5vWhBrRzcK/E0/qdTvjIlpp4N4oSto0zv9yOAlA=;
 b=UfEtP4KTe753kB9e06/tX7l5Jl+Rg3DO6Y7nr9cgBPVRIJHFPTNJZRZW/bspAOGvFn
 l2iwc/fJOt2Z4HyX6dImWRsbFfxNus4s8b6ypd1E5YQRYdX0LZiGLwkeqYQxWapglrfs
 uEwnTfkfYAp3g12m/83VTPnwmCDHic/o/MXQmS+XrrhIGoN49GqlxtYGlDi5WyCwzB5w
 /NuhOdetKtInoQRd/XCZREpPd8TfGgdlP7Tdd8QZ6DmlYRJutKC6oN1AySyS3i6LwsDq
 cuthI+h1D49HtfeDL03kF84rKtyfdJdHmzc0526B2onQx3B7ywKXzAlr7QLL8daYAq7H
 H1RQ==
X-Gm-Message-State: AOJu0Yy7UCs3JD6xtLuM2NskbWpcEmoy3dRni2Fa7hb9oBDbp6LlksmB
 1X9xnDUvdSCIH7klvt201lCbaGD4yN3rJnViTuGfScCmxShbLM3DoiPwrvNTWIa9ipM=
X-Gm-Gg: AR+sD11AfPwXzPHd7c/no/OugcjZtHAn/BworecgofyuUKgnQ/lz4zQcodVb3B7kd7u
 x18oujp7s7Ts5MBU4a5wsFJG2Onmiz5yy/Ak5djI2eS/SghqATqT9D4/sE4PPy8l2Zp/OP8fTwU
 c2V4ahcLZjyswOZyACrSaKu+f4SR75hol0bvjXdO9m/56YbTHbBBHv82sRQDSvEx1Ri4sjv8ba9
 fYQ1mP50n+yZjG//eFVBUZi0AR+aF8YdEmrneswEVXf/g28D6a794H5TqIcfYdSoNqKvxVCe/F7
 lrcCX+xW/bQsBR2URGYGcTaDCmAbyLCOvmBQursipHEsYtykmGrwyhzyuPFRFd/gA2xf8MP7aE+
 HfnXv9IbWWVj5yXlwflD0XbBjCe5ZRCzx6Ar8lbPpSjjFodFp33EiKSDm/dtFjQJX6/aVX9roCc
 NVpX70BLNziKNn1d5x4RTyuRgLUwCnSE27Ix4Ytr2fZybCFgn/UUWE6zUwl25opZUD6d2WjvC8N
 vytHZoCx/YQkKmK3En5UKJQdL12V84FtQr5/K++Wg==
X-Received: by 2002:a05:6000:2489:b0:475:3a97:8e2c with SMTP id
 ffacd0b85a97d-47fd72a8634mr976751f8f.16.1785517925164; 
 Fri, 31 Jul 2026 10:12:05 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:12:03 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:54 +0400
Subject: [PATCH v2 10/10] doc: falcon: Describe booting the OS through TF-A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-10-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8594; i=alchark@flipper.net;
 h=from:subject:message-id; bh=sHseLqyV60cNfyUusJxOEMbAuP8Cl3WUT5WZlTlsh0A=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFfW+/Ttl1bg4tfVz42Od4ZWC7X7z7q8t3rz/kDHa
 TXT911b0DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUR9xj+F9S3XnS9GeO75Q0Vefv886XBUbc8Zu3Lf/PT/bTT63O/fjKyLDKwyH
 YW+PY4YJJy7OjDBbdPBauMD04c0OIuuDDgwoVF1gB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517925; x=1786122725;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dJaM5vWhBrRzcK/E0/qdTvjIlpp4N4oSto0zv9yOAlA=;
 b=onyNbdwmGmiCzm75Q3Ic5GLxzZs6AoePyDHlsWZys6tsIU9SomRLQ1DptUX3q8xEx1
 MFOYf/GNLqVxcFxq5y+p6IHjk38noziD0ht2+VqKz5GatMJRy3CvpxXraryfzO5aoYZm
 QF5k8CeymTkXfyAD+5+wRdwiHEGqKYNbVGAu1dBeavLcJ1ZvKarVUObI/6g5G33pBagD
 i4hf4fBU8iEz0blDPtGJIqzGUprh0HeOopyfEcUPv41Po8HZuWzWzxtmZHUuy02IG1TC
 Ezctszic6Ggl5c5I3NP6qTSYFKHuCVizQRwpfK7rvXoX2tr/pz7Ww7V0fto6rYvlD516
 CnQw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=onyNbdwm
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Falcon Mode documentation only covers SPL entering the kernel itself, which
is not what happens on ARM64 SoCs needing ARM Trusted Firmware resident to
provide firmware services: SPL loads a FIT holding BL31 as its firmware
image and the kernel as a loadable, and BL31 enters the kernel as BL33.

Describe that flow, what the kernel image may be given that neither
booti_setup() nor bootz_setup() runs, how it differs from the classic flow,
and how to configure and build it on Rockchip.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 doc/board/rockchip/rockchip.rst |   9 +++
 doc/develop/falcon.rst          | 131 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e28..42c47c51036f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,6 +325,15 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+Falcon mode
+"""""""""""
+
+ARM64 Rockchip SoCs can also boot Linux straight from SPL through TF-A,
+without U-Boot proper running at all. Enabling CONFIG_ROCKCHIP_FALCON_IMAGE
+makes binman build a ``u-boot-rockchip-falcon.itb`` holding TF-A, the kernel
+and an optional initramfs, which are passed in with LINUX_KERNEL and
+LINUX_INITRD. See :doc:`../../develop/falcon` for the details.
+
 Flashing
 --------
 
diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
index 3fc23f65c458..f29aaee06a10 100644
--- a/doc/develop/falcon.rst
+++ b/doc/develop/falcon.rst
@@ -95,11 +95,138 @@ Function that a board must implement
 ------------------------------------
 
 void spl_board_prepare_for_linux(void)
-    optional, called from SPL before starting the kernel
+    optional, called from SPL before starting the kernel. Not called when the
+    kernel is entered through TF-A, see `Falcon Mode with TF-A`_; use
+    spl_board_prepare_for_boot() instead, which is called on every path.
 
 spl_start_uboot()
     required, returns "0" if SPL should start the kernel, "1" if U-Boot
-    must be started.
+    must be started. It may be called from more than one place in a single
+    SPL run, so prefer spl_falcon_boot() when querying the result - that
+    caches the answer, which matters for implementations that are not
+    idempotent, such as those sampling a button.
+
+Falcon Mode with TF-A
+---------------------
+
+On ARM64 SoCs which need ARM Trusted Firmware resident to provide firmware
+services to the OS, the kernel cannot usefully be entered directly from SPL.
+Instead SPL loads a FIT holding BL31 as its ``firmware`` image and the kernel
+as a ``loadable``, hands control to BL31, and BL31 enters the kernel as BL33.
+
+SPL picks BL33 in spl_invoke_atf(), which looks for an image with
+``os = "linux"`` in the ``/fit-images`` node it appended to the device tree
+and falls back to ``os = "u-boot"``. The kernel is entered at EL2 with the
+device tree address in x0, as the arm64 boot protocol requires.
+
+Nothing generates a FIT holding both an OS and a U-Boot payload, so the two
+are separate images, and it is the loader which decides where to read from.
+In Falcon mode it tries the OS image first and falls back to the U-Boot one
+if that cannot be loaded, unless secure Falcon mode is in effect, in which
+case there is no fallback. For UFS the two are addressed by
+CONFIG_SPL_UFS_RAW_OS_DEVNUM and CONFIG_SPL_UFS_RAW_OS_SECTOR against
+CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM and CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR, so
+they can live on different logical units, at different offsets, or both.
+spl_invoke_atf() then hands over to whichever of the two actually loaded,
+which is what makes that fallback work.
+
+Pointing both at one location is also possible, and is what the defaults do:
+only one region then has to be reserved, at the cost of having nothing left
+to fall back to.
+
+What the kernel image may be
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The payload is an ordinary FIT image node with ``type = "kernel"`` and
+``os = "linux"``. SPL copies it to its ``load`` address, and BL31 enters it
+at ``entry``, or at ``load`` if no entry point is given.
+
+Neither booti_setup() nor bootz_setup() runs in this flow - SPL does not
+enter the kernel itself, it only places it in memory for BL31 - so there is
+no inspection of the arm64 Image header and no relocation to the text offset
+the kernel asks for. The addresses in the FIT have to be directly usable,
+which for an arm64 ``Image`` means 2 MiB aligned, and clear of the device
+tree, of the initramfs and of every region BL31 and OP-TEE are linked to run
+from - each of those is split into several regions when it is supplied as an
+ELF, rather than occupying one contiguous range.
+
+The image is loaded verbatim unless CONFIG_SPL_GZIP or CONFIG_SPL_LZMA is
+enabled, in which case the FIT ``compression`` property may be set to
+``gzip`` or ``lzma`` and SPL decompresses while loading. Two limits apply
+then. The uncompressed image has to fit in CONFIG_SYS_BOOTM_LEN. And the
+compressed one is first staged at CONFIG_SYS_LOAD_ADDR, so that address has
+to clear both the region being decompressed to and, when the FIT is itself
+already in memory, the FIT: booting from RAM reads the image out of DRAM at
+CONFIG_SPL_LOAD_FIT_ADDRESS, and a staging buffer landing inside it makes
+the copy overwrite its own source, which shows up as::
+
+    ## Checking hash(es) for Image kernel ... sha256 error!
+
+The device trees in the FIT
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Each device tree in the FIT can be pre-patched at build time with a
+``/chosen`` node holding the kernel command line and the initramfs location,
+so that nothing has to fix them up before boot. See the ``fit,bootargs`` and
+``fit,initrd`` properties of binman's :ref:`etype_fit`.
+
+Differences from the classic flow
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* The device tree comes from the same FIT as the kernel, so no separate
+  'args' file is involved and CONFIG_SPL_OS_BOOT_ARGS is not needed.
+
+* CONFIG_SPL_BOOTI provides an entry path which is unused here.
+
+* Because U-Boot proper is never loaded in this flow, SPL panics rather than
+  jumping to CONFIG_TEXT_BASE if neither a kernel nor a U-Boot image can be
+  resolved from the FIT.
+
+Neither of the first two defaults to y when CONFIG_SPL_ATF is enabled, so
+nothing has to be turned off by hand.
+
+Example: Rockchip RK3576
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Set the following in the board defconfig::
+
+        CONFIG_SPL_OS_BOOT=y
+        CONFIG_ROCKCHIP_FALCON_IMAGE=y
+
+On a board whose SPL can load from SPI flash, CONFIG_SYS_SPI_KERNEL_OFFS
+becomes visible and has no default, so give it a value suiting the flash
+layout even if the kernel is loaded from elsewhere. The load addresses of
+the kernel, device tree and initramfs default to offsets from the start of
+DRAM which clear BL31 and OP-TEE, and can be adjusted with
+CONFIG_ROCKCHIP_FALCON_KERNEL_LOAD and friends.
+
+Enabling CONFIG_SPL_LZMA or CONFIG_SPL_GZIP additionally compresses the
+kernel in the image, trading some decompression time for a smaller one - for
+a 30 MiB arm64 Image, roughly 35% of the original with LZMA and 39% with
+gzip. Note that this compresses U-Boot itself as well, since both use the
+same setting.
+
+The kernel and, optionally, an initramfs are passed in at build time::
+
+        $ make BL31=.../bl31.elf \
+               ROCKCHIP_TPL=.../rk3576_ddr_lp4_2112MHz_lp5_2736MHz_v1.13.bin \
+               LINUX_KERNEL=.../Image \
+               LINUX_INITRD=.../ramdisk.cpio.zst
+
+This produces ``u-boot-rockchip-falcon.itb``, to be written at
+CONFIG_SPL_UFS_RAW_OS_SECTOR (or the equivalent for the boot medium in use).
+Its default shares the region with U-Boot, which suits Falcon-only boot;
+point it elsewhere to keep a U-Boot image to fall back to.
+
+With CONFIG_ROCKCHIP_MASKROM_IMAGE enabled, an equivalent maskrom payload
+``u-boot-rockchip-usb472-falcon.bin`` is built as well, which can be loaded
+straight into RAM::
+
+        rockusb download-sram u-boot-rockchip-usb471.bin
+        rockusb download-ddr u-boot-rockchip-usb472-falcon.bin
+
+Rockchip attempts Falcon Mode boot whenever it is enabled. Boards which need
+a runtime choice override board_spl_start_uboot().
 
 Environment variables
 ---------------------

-- 
2.54.0

