Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73827606A33D
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nI3xeEgo;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sEacWSHO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 349A66086A;
	Thu,  5 Nov 2026 14:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YarTMp5-fT3a; Thu,  5 Nov 2026 14:06:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 227A760855
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887586;
	b=hRLciY+3zXA3hWt0MRIOGMgS5YkUKnBFwBdGBjEp7qSp0nrXtNt9/WPypViT4AjpF8+3
	 9D3KM8UTyHzPL8SqsPKxJyznmRF0EBJ0xYplARW3P49WP8a8UF+tnoTZKad7ZIoPIweS6
	 3MYuZzy+gSmQBhcDDLVggMnfrTSZpHy61U0oT0972poVlfsSDQCEmQmx8SuvuxWTiSSrA
	 7tKfxyiYneF4Hg44C3osZ0cmP34azxq8acIS7A0g9y/LUs+oR9p9iHkh9Qx3CMhPSHFJs
	 EqWMorwoc8tU1lURYUp3IH/EnsxCY6SWsD4J8pppXbgZqUCMvxOor4LpPCcgY2d8SaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dQKUZLrQ+y8tKuJtCBhVMvz/64iGEBu8ydH3EXWaItw=;
	b=OPLiS09oz0jpse7GmXQtuvuI2o1TCPvCUBM+SzsBoDAzPtS2NGWgRqEyyBzBUVa5r2Hg
	 yl5wrNmgRqMt72YOVW/mgwJ+T3hSihCId6fh3jeFkIeR3N7RgVb0lbedbEAqlsQMxa2vB
	 T+tvnRgfq6Wh1u58JezmWoU6GJKOhZPbVkTnEA6Oc/gdaCF07AZ38cW7B+uL2aWhyfHxj
	 Jofnp38ba7GpIA7FStNqbtYnCGQ/jYhDxlkeOOc5QnEgga85PLrWgc1outW8rYyLsGzQR
	 AeZsF1ndoGnWXow46XrdsWJng8ttqm4s5R80dVJYV+TKS6T0ztzr0IqvAEGfoh2N3Mw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887586;
	bh=dQKUZLrQ+y8tKuJtCBhVMvz/64iGEBu8ydH3EXWaItw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nI3xeEgovGKRhy1YsdZNZV1DN6wuJWnt3JbbkhSdVLjHYEEZ2sHOSexktOma6SQGw
	 ysdO9hbbv90W9JL1wFBBqid9w8FIR50t6U3aApTE0C1k/z3qOomwmPEvCHXxX9snez
	 8h0dGimMeZN9M+0aBuNhY5n48pa/uRm4OL0fAiM05P2qOQLyhMMur2erS6Y1PE/o4g
	 eW/73FXtRweoAoAHk0wMAtSGsvsnWccpqa10U/uuOICzQdNfY7PU32Ffp8Vh8SOXNz
	 1oBM6r1iTud2QeI1xs/eS67B2wfmLNln8bvHLTcRdEfgX44NdR5VGKLarTMtRKUROe
	 3Pnswvv0VWNQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 227A760855;
	Thu,  5 Nov 2026 14:06:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AAFBB235
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90AE2400B4
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1LLLgtwT0Iii for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:06:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EBC714007E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=thomas.perrot@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=sEacWSHO
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBC714007E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:06:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 536AA1A09F3;
 Thu,  5 Nov 2026 14:06:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 25A055FF85;
 Thu,  5 Nov 2026 14:06:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9BEA41032923C; Thu,  5 Nov 2026 15:06:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793887575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dQKUZLrQ+y8tKuJtCBhVMvz/64iGEBu8ydH3EXWaItw=;
 b=sEacWSHO0gyKt2Rf5mjZWe76vLfSbRXqB9Y7X2Z4zxJrinnURXofnJhIlgA8gAWBmb5jIC
 r6LA85XqDsodNRe/p3dz3xE5PbPtrwG6twnXGVzjLTSKvo0prbm69uj+1jqNCfMO75WrJJ
 9IsMJiKoxNCwbIQ09SkvnKTGuljGa2q0EwS6H+H69Ac/UoVpMsBBaSU2pbyA5HoHDBv7Oi
 XY7SM23C616geFgS02A8+zz/8K6RyqttMjo1sJoihmUb8iYAr39YUbwiSZ0aFWfy4jZT6I
 EfiPYMEWNzVEVgEoGxuNxeJLH9uxb3pbcZ0XvosUQ2JPuOTQunvpux5GP0TKMQ==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Thu, 05 Nov 2026 15:05:58 +0100
Subject: [PATCH RESEND 3/3] doc: board: beagle: Add BeagleV-Ahead documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dev-tprrt-beaglev-ahead-spl-v1-3-ba7472d69ebf@bootlin.com>
References: <20261105-dev-tprrt-beaglev-ahead-spl-v1-0-ba7472d69ebf@bootlin.com>
In-Reply-To: <20261105-dev-tprrt-beaglev-ahead-spl-v1-0-ba7472d69ebf@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Thomas Perrot <thomas.perrot@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe how to generate the DDR firmware, build OpenSBI and U-Boot, and
load the resulting u-boot-with-spl.bin on the BeagleV-Ahead through
fastboot.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 doc/board/beagle/beaglev_ahead.rst | 102 +++++++++++++++++++++++++++++++++++++
 doc/board/beagle/index.rst         |   9 ++++
 2 files changed, 111 insertions(+)

diff --git a/doc/board/beagle/beaglev_ahead.rst b/doc/board/beagle/beaglev_ahead.rst
new file mode 100644
index 000000000000..a70f227c8fd2
--- /dev/null
+++ b/doc/board/beagle/beaglev_ahead.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+BeagleBoard.org BeagleV-Ahead
+=============================
+
+BeagleV-Ahead is an open-source single board computer based on the T-Head
+TH1520 SoC (4x Xuantie C910 @ 1.85GHz), featuring 4 GB of LPDDR4X and 16 GB of
+eMMC flash.
+
+ - SoC            T-Head TH1520
+ - System Memory  4 GB LPDDR4X (single rank, 3733 MT/s)
+ - Storage        16 GB eMMC flash
+ -                external microSD slot
+ - Networking     Gigabit Ethernet
+ -                WiFi + BT
+ - Display        HDMI 2.0, 4-lane MIPI DSI
+ - USB            4x USB 3.0 Type-A, 1x USB 2.0 Type-C
+ - Expansion      BeagleBone-compatible P8/P9 headers
+
+Mainline support
+----------------
+
+The following features are currently supported:
+
+1. ns16550 UART driver
+2. eMMC and microSD card
+3. Gigabit Ethernet (DesignWare GMAC with Realtek PHY)
+4. LPDDR4X controller and PHY initialization in SPL
+
+Building
+~~~~~~~~
+
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: none
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+
+3. Build DDR firmware
+
+The DDR driver requires a firmware blob to initialize the controller and the
+PHY. BeagleV-Ahead has a single rank of LPDDR4X, which needs the single-rank
+variant of the configuration:
+
+.. code-block:: bash
+
+	git clone --depth 1 https://github.com/ziyao233/th1520-firmware
+	cd th1520-firmware
+	lua5.4 ddr-generate.lua src/lpddr4x-3733-singlerank.lua th1520-ddr-firmware.bin
+
+4. Build OpenSBI firmware
+
+The proper U-Boot runs in S mode, thus OpenSBI is required as SBI firmware.
+TH1520 support in OpenSBI requires v1.2 or a more recent version:
+
+.. code-block:: bash
+
+	git clone https://github.com/riscv-software-src/opensbi.git
+	cd opensbi
+	make PLATFORM=generic
+
+5. Build U-Boot images
+
+The DDR firmware must be found by binman. The simplest way is to copy it to
+the U-Boot source directory before building:
+
+.. code-block:: bash
+
+	cd <U-Boot-dir>
+	cp <path-to-ddr-firmware> th1520-ddr-firmware.bin
+	make beaglev_ahead_defconfig
+	make OPENSBI=<opensbi_dir>/build/platform/generic/firmware/fw_dynamic.bin
+
+Alternatively, binman can be pointed to the directory holding the firmware
+with BINMAN_INDIRS, which keeps the source tree clean and works with
+out-of-tree builds:
+
+.. code-block:: bash
+
+	cd <U-Boot-dir>
+	make O=<build-dir> beaglev_ahead_defconfig
+	make O=<build-dir> \
+		BINMAN_INDIRS=<dir-containing-th1520-ddr-firmware.bin> \
+		OPENSBI=<opensbi_dir>/build/platform/generic/firmware/fw_dynamic.bin
+
+This generates u-boot-with-spl.bin, which contains SPL, the DDR firmware, the
+OpenSBI firmware and the proper U-Boot.
+
+Booting
+~~~~~~~
+
+u-boot-with-spl.bin is loaded to SRAM through fastboot. Hold the USB button
+while connecting the board to the host through the Type-C port, then release
+the button and run:
+
+.. code-block:: bash
+
+	fastboot flash ram u-boot-with-spl.bin
+	fastboot reboot
+
+The serial console is available on the debug UART header at 115200 8n1.
diff --git a/doc/board/beagle/index.rst b/doc/board/beagle/index.rst
index e33d39fc677f..58b01d62a7de 100644
--- a/doc/board/beagle/index.rst
+++ b/doc/board/beagle/index.rst
@@ -13,3 +13,12 @@ ARM based boards
    am62x_beagleplay
    am67a_beagley_ai.rst
    j721e_beagleboneai64
+
+
+RISC-V based boards
+-------------------
+
+.. toctree::
+   :maxdepth: 2
+
+   beaglev_ahead

-- 
2.56.0

