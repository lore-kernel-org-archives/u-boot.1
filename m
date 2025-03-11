Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D605AC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 12:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F49D81782;
	Tue, 11 Mar 2025 13:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A06YDzSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 746FC811C1; Tue, 11 Mar 2025 13:31:40 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84EF8169D
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 13:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso23328885e9.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741696297; x=1742301097; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LXKWFEA3RTPR8bp2OOouaWZul+3Id24Z2qdnUFM+ZYM=;
 b=A06YDzSeXpFcU7CtnxWfSw7wxpQcLE7nW2sfgBI9WANcXMCLVw5or3y5Cp6a9bjuP6
 kqbkB09XmNkvfblJC8g5c9kbUDzQtBJe+lYIJs8hvQV3JnCmEnp+33RJf3b4LdVfE661
 pVPf1sOpR90v6oWlG089SnLRhnZ/g/hg/3Gw5D8y24qjp63/WKruYYXjY4qP3KVAyFxv
 G/hz+0oGJWN60qI2eA89ZxXXAtyv2ycivvM90LNGsgur/24y8tcdNIIY0ujvFCiMZvhi
 lpXYVSNVH9cGVQST52JGxY3vrC3H+eBLXJwmZay1EcGtj3YGEIOWq+WSn2uTABYsGkqV
 UzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741696297; x=1742301097;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXKWFEA3RTPR8bp2OOouaWZul+3Id24Z2qdnUFM+ZYM=;
 b=K6F9S2+e56lz2uJR2UWTvF7YCXiYZ+wzn0AGjmMnBD+wjT8L0jpTMOfRgqIZvnLMKT
 IqfXWuQFw1DLjhXnt9PClbInWJNOBBou7Zwpsl3Vc78Mx/POH4q4nNBLNexGiJ99JEDn
 z+rCxuee02tujFRvCKVXlCE/H9JN7J3I07ZSncZxzB09VoLsOOQJmDhiOcXJib36u+Vp
 qEbuNK5H+VO43wuaKP8esSILPh+f2+78JoumnfgCk1EV/bz2Wx1LuB2SQ5RQRGc0p5iz
 HKriSL46QAKJytURZ4jgpdgmMQ7S8Bwc/0rNNnZo5dSB13oTHj+oZmREaevMLRwuVHkc
 MPSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfrwFEEYbycAlTtLDT3lrOPHv0DspfWA78legjRADGTAVN8U1/uAbxs9IGp5axmDp7ctRWLag=@lists.denx.de
X-Gm-Message-State: AOJu0YwNXuVBdwXbHrPMei04jNTbfJ0pA82oxZQ9TZ0itX1SyuD5n/e4
 8LzxIuJcXWFVl1dPeIP1XjHUeSiu6YA5nwA6FX4Zqu83MHlNE0WkgtUBLjQqLXhLfB7crzlZUBJ
 /X7s=
X-Gm-Gg: ASbGncs6ZdPYXwuveFdllyd91jQHwTqQNsEMPJew5psuJPIQoUtxmPVRNyH0XUAICv1
 VBJ+uowE+MXvfO1T29yOI9QiRE/njIyj1L+NBE3T9qOVMX8+VZIieUOKe97q7rom+HyLOGaDDD8
 YaNljNfcZzFbG08Zp9oKO0eo5xxQ1ErWjTa7dmVmCwEFpuJ+OlFWHEZWDuK0NQYzKLMQ/HDMgkq
 ozsPo3BrXy4zoFH084hVjfaqUEyVVuQsAG4X/GV0dYPkLnWhF5uN6ZHv/aWPGxPy0VMeSlj7YaZ
 D69rHXpEG+QFj/sU2kdcaxB3jxWVid2cDqR7FyhTPJKeWZqCf5ZK+f+5OD7BYBWwM2ImXoSZ
X-Google-Smtp-Source: AGHT+IHRGx1obvmPvyb0bu0Y23XyXPjtRgeaozqkraZZIj3T3AFQ4uYEXjrTjZscj4Tik2HtjLMCNw==
X-Received: by 2002:a05:6000:1867:b0:390:f987:26a1 with SMTP id
 ffacd0b85a97d-39132d885bcmr11453219f8f.29.1741696297188; 
 Tue, 11 Mar 2025 05:31:37 -0700 (PDT)
Received: from toyger.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:f578:9a7d:3957:bef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f44sm17788586f8f.76.2025.03.11.05.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:31:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 11 Mar 2025 12:31:19 +0000
Subject: [PATCH v2 4/4] doc: board/qualcomm: describe phone support and bringup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-qcom-phones-v2-4-83dcd88a6a87@linaro.org>
References: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
In-Reply-To: <20250311-qcom-phones-v2-0-83dcd88a6a87@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7654;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=L/tAuYJFfDPRVAWBwa+C90Y1usOWEnRNv9NpP444+3I=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn0C0hzDBTG8F6klL7lKQ2QfcbAbVtLxMwDGHhH
 caZWjMsabWJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9AtIQAKCRAFgzErGV9k
 tm5qD/kBErXU02w/XDFi25WoAmvlbSRPkkjkjWgHhi3H71s3iowbZ3eWYVQumtGhwweiWoUW1ID
 GpWTvatAbmo96ozQvuNDcabasgrPab5hBu6463o1YgXHCbxXprkDtXv3Lgsn83FPpYQ20pEuqPe
 3rbp6sR8dBySjKvu0wCYhQCW8b+68YTnOnCW7lNVXwog5kmuSt8RJbYquN3zg0awt0cMxY3J7Ag
 eMNFo7tv6iW/Xt48jCBKNMqmydFw38TLriuyOl/ZTTVLKauFoyzX4r8ZMyDMjGwBKFYtpYzn5tj
 VPuuD5Zsx87VQCv9qWYNwxf/YaghJ6OAp/W6MxAxG9SRR0ByPMCdHeDnI6QgtEtV+uTrfJwL7Y6
 IRo2EtO692vNZxwIA63lp2dBImAku8MDlnUre+x0zyPqzWTTEe3OFbZ0nJOdnvLfRb/DuqFt8Nn
 hELBLi7ttRYGQdHgYqN9FgqxFzS0qhhez/XErM6+iEtfEOI0AmTwh+BtP05zXU6z01CwsrFmdyi
 qH5vwxF23hU7l4G9MoNYFNq5yQevG26cSEoISfS5s1KQSklIdclw7mA52Ymnw6FUXK+o9dEOQMS
 L78kqY3l1zSTXLznlhjwhb07pLwMWBHbQ72abO/5GkNy3AaJK2fRrJcAiQbS/FZeC0HJZk213Ft
 2hTlUldI2DxAw4g==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add some documentation which attempts to describe Qualcomm smartphone
support with the qcom-phone.config fragment, as well as a high level
debugging guide for diagnosing U-Boot issues when UART and framebuffer
are unavailable.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/board/qualcomm/board.rst  |   5 ++
 doc/board/qualcomm/index.rst  |   1 +
 doc/board/qualcomm/phones.rst | 122 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)

diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 4d793209f9e31e6447c696ccd07af206dba99645..003d59a18ebd3f19db568fa59e9fd06906e209f2 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -89,8 +89,13 @@ Or for db410c (and other boards not supported by the generic target)::
 
 	make CROSS_COMPILE=aarch64-linux-gnu- O=.output dragonboard410c_defconfig
 	make O=.output -j$(nproc)
 
+Or for smartphones::
+
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig qcom-phone.config
+	make O=.output -j$(nproc)
+
 - gzip u-boot::
 
 	gzip u-boot-nodtb.bin
 
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 8c7969987a9704bd6044197574f8da16b3848bd4..db59b81134b84cd5865a07cd1a294de9bdf12c5f 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -9,4 +9,5 @@ Qualcomm
    dragonboard410c
    rb3gen2
    board
    debugging
+   phones
diff --git a/doc/board/qualcomm/phones.rst b/doc/board/qualcomm/phones.rst
new file mode 100644
index 0000000000000000000000000000000000000000..d9a582f5abec7801cad997ccae464975dfb24ac3
--- /dev/null
+++ b/doc/board/qualcomm/phones.rst
@@ -0,0 +1,122 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
+
+======================================
+Booting U-Boot on Qualcomm smartphones
+======================================
+
+About this
+----------
+
+This page attempts to the describe U-Boot support for Qualcomm phones, as a user guide but also a
+technical introduction to How Stuff Works to help new porters.
+
+In broad strokes, U-Boot should boot if the SoC is supported, and the device is already capable of
+booting an upstream Linux kernel.
+
+The list of supported Qualcomm SoCs changes often, for now it is best to look in
+``drivers/clk/qcom/`` to get a rough idea.
+
+For building instructions, see :doc:`board`.
+
+Phone bringup
+-------------
+
+It is usually easier to get Linux booting first, there are many good resources for this such as the
+`postmarketOS wiki`_. Once the device can boot Linux with logs on the display and ideally USB gadget
+support, it is highly likely that U-Boot will boot as well.
+
+For logs on display, you should have a simple framebuffer node defined in your DT, newer devices
+require that this follow the downstream naming scheme (that the DTB is compiled with labels enabled
+and the framebuffer reserved-memory region is labelled ``cont_splash``). Once this is working in
+Linux it should also work in U-Boot.
+
+In practise, U-Boot still has many more papercuts than Linux, which can be sticking points when
+porting a new device. In particular, drivers failing to bind/probe (especially pre-relocation) can
+be tricky to debug without UART since U-Boot will simply panic with no way to inform you of
+the error. As a result, bringing up a new device can be quite frustrating, but there are quite a few
+things you can try.
+
+The phone config
+^^^^^^^^^^^^^^^^
+
+Since most phones lack a physical keyboard or serial port, a special config fragment and environment
+file can be used to provide a more seamless experience. This can be enabled by generating the config
+with::
+
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig qcom-phone.config
+
+The config and associated environment file can be found in board/qualcomm/. The main changes are:
+
+- Panic on hang (so the panic message can be read on the display)
+- Boot retry (to automatically open and re-open the bootmenu)
+- A boot menu with helpful shortcuts (including USB console gadget)
+- Launch the boot menu if power is held during boot or on boot failure
+
+Hang/crash bisection
+--------------------
+
+Without a way to get logs, we can still get quite far with only a few bits of information: what
+happens when you ``fastboot boot u-boot.img``?
+
+Does the device disconnect?
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This can be verified by watching ``dmesg -w``. If it stays connected, it likely means the boot image
+doesn't match what the bootloader expected, use ``unpack_bootimg`` to compare it with a known-good
+boot image (ideally one with an upstream kernel).
+
+Does the device hang?
+^^^^^^^^^^^^^^^^^^^^^
+
+If it stays on a black screen and does nothing, then that's a hang! Since ``qcom-phone.config``
+enables CONFIG_PANIC_HANG, this likely means that you're successfully executing U-Boot code (yay!),
+but something is causing a panic.
+
+It could also be due to a bad memory or register access triggering a secure interrupt, it's worth
+waiting for around a minute to see if the device eventually reboots or goes to crashdump mode. You
+can also disable CONFIG_PANIC_HANG and see if that causes the device to reboot instead, if so then
+it is definitely a U-Boot panic.
+
+With enough time and patience, it should be possible to narrow down the cause of the panic by
+inserting calls to ``reset_cpu()`` (with CONFIG_PANIC_HANG enabled). Then if the device resets you
+know it executed the ``reset_cpu()`` call.
+
+A good place to start is ``board_fdt_blob_setup()`` in ``arch/arm/mach-snapdragon/board.c``, this
+function is called extremely early so adding a reset call is a good way to validate that U-Boot is
+definitely running.
+
+You can then do a binary search starting from the end of ``board_init_f()`` / start of
+``board_init_r()`` and work from there using the init sequences for reference.
+
+The Qualcomm RAM parsing code is a likely culprit, as ABL is known to sometimes give bogus entries
+in the memory node which can trip U-Boot up.
+
+To rule out crashes that might be caused by specific drivers, it's a good idea to disable them and
+re-enable them one by one. Here is a non-exhaustive list of drivers to disable:
+
+- pinctrl
+- mmc
+- scsi/ufs
+- usb (dwc3)
+- phy (usb, ufs)
+- clk (remove clock references from your framebuffer node in DT)
+
+Ideally, it would be possible to use the framebuffer as an early console / debug output, at the time
+of writing there are out of tree patches for this but they haven't been submitted upstream yet.
+
+Does the device reboot or go to crashdump mode?
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+On many devices crashdump mode is disabled, so they will reboot instead (maybe after some delay).
+The same approach as suggested above can be used to figure out where the crash occurs.
+
+If the device is rebooting, you can insert calls to ``hang()`` instead of ``reset_cpu()`` when
+following the instructions above.
+
+The most likely cause of a crashdump is the pinctrl/gpio driver or the SMMU driver, ensure that the
+``apps_smmu`` node in your SoCs devicetree file has one of its compatible strings referenced in
+``drivers/iommu/qcom-hyp-smmu.c``, you can also try disabling the pinctrl driver for your SoC (or
+``CONFIG_PINCTRL`` altogether).
+
+.. _`postmarketOS wiki`: https://wiki.postmarketos.org/wiki/Mainlining

-- 
2.48.1

