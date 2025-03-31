Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A35C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C102681F44;
	Mon, 31 Mar 2025 14:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c7SFILlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5466181E6C; Mon, 31 Mar 2025 14:23:53 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C16F68129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so30533155e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743423830; x=1744028630; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9l6TBguCI+1TQM24o3298QYvGo7auXO+JB/eGhaygm0=;
 b=c7SFILloEUGUmgQygKyb4vRImnBo1ixAnioEMJinv4Nh/ys99B/3QF8dsbO5N5Ngcc
 iweexEWqDoZbFTx7OeZlwnXWkgRSWzrVdzur38Gnx2gHS6ZqFO/Pp0sxSXvaui81Ckpw
 5mMPnOAMkiYbZocfXmfMpjgBh9OlydrvZg7ho0BEB2v3B38LbZwkz7NX6k1FfGkDRolC
 dRWYkT8t5GL81i05WtXlSNML6S8egeN1avrIofVN3HBB/QscYQuJIaFJqsLYgOEH+KCX
 CyNOo93Wld31pB77g54aXg2AcHFMZegMimQHA92Iqa5A/RLaZuEoXyA9BOLQzZE/5gCy
 bqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743423830; x=1744028630;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9l6TBguCI+1TQM24o3298QYvGo7auXO+JB/eGhaygm0=;
 b=ZtumZFF9j6A7c5enkOO4toIiJ5kY9rvBAH0zMatqvSRJMGOq7ZlOKd+j7/2hgk7xkQ
 NGNz35eNFHVmXx+t1D3m1+4linXUQ7tFU1GEgympYQfI7k+UHjckMUr6lvC1/d0LjVy1
 QlW3Ijosh24kWrmBN2v9h520EJLLqz0ZQfO2xp3SPNNavO5yrmy6YiMPEfha6HtjYbzX
 J6AQ7h24DHBBxxRPGRyK81RYbSVrlKLhuaPHPzfg5fOJIrL0HRCIOaK2w71lIdPC+ogy
 1gtPpP3IOGjNXmMcrC5SWZtFZC71v8v494iiarpqCaZbUn8Tmz396AA84X1/HLY0Ie20
 kP2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2p8NZ4xeMXSucZtg2sxnKB1SWswrzYEohYrBHxXsB4xOxRt//WSiNy9oT3lKsGkzuP43IAEY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9m0f06pQkeWiAAtHuiZ72OXOb4UyadIzWMrudzYDuswe5dVjV
 9DqEDuNF5mJSEsm5P9fGAY/KvuS6BREnlz9YGBWk4HN1d4eLAmCdzfEA0S6Jwv0=
X-Gm-Gg: ASbGncu41p4Mo57S4LyDYZCr8y0NK1ORzxbt6bYmf2GD7N84LF/kLf8Knw9O1r92yq6
 go8cIr61EU6WCmyWurmZnBvnkRllFORLMYQtv6B+lIdKY2x0s77kgPIRbPEUnvC2BBmpZmx8itE
 AOeOXM6F1Dcu55qKb1LrliZeoNY8KluCUqEt9anRcvgeaYWU2DPNMIJUreKM8Mq6fbiYsBLoXoJ
 0xizF4z+Du+Zl11uDuMAF9ZvEHyvlgA6j32V38RgSXRMmpS1t8viXS0E1yWAYJ/SEZuMRRsoWxh
 297MCuJM+VJf46uXYRyi9zoSnP6o9knjjH+ODO7XqsVkgLwDu9t8chbypC0WNwzCtgA/7M0Rf2K
 E8ye58MQD4uw4
X-Google-Smtp-Source: AGHT+IFGFL1WJMki1Dl4nmp1STq3dOJsrlU1iTqABXSE/5FoWtoAqTCQOS3IACTd2yX6NczPZvtpAg==
X-Received: by 2002:a05:600c:8705:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-43db61b33b9mr98011265e9.3.1743423830115; 
 Mon, 31 Mar 2025 05:23:50 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm11315562f8f.0.2025.03.31.05.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:23:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 31 Mar 2025 14:23:21 +0200
Subject: [PATCH v4 4/6] doc: board/qualcomm: describe phone support and bringup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-qcom-phones-v4-4-f52e57d3b8c6@linaro.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
In-Reply-To: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Danila Tikhonov <danila@jiaxyga.com>, 
 Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8765;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=DlcpebobFqNsX/YsiAYa59rna6gYYXDwYSAb2tmpk84=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn6olNbJBBphgSBfxbLV3v+0pSjAQBfeFx4j6Qu
 j9FgBfXDaOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+qJTQAKCRAFgzErGV9k
 tkAoD/0coqyGzqDtYAhFPO89U7SHlltv/AG3+IO0nZXkfvaTRakPcUFUUwhEvIsTkSS0QKMW34v
 JwUyWB8USkUfrTW+EZMluQ8EgsPXGsjiGGtIifSXzqj6va/0Rca/yNNUfI0jzXiXSY3qgr8XdNo
 lDuqv6alfdy6vmwe7cto6t392c5tYTmWvXj3QISeWBu/L2JaGV8wMhZxNR8PmbIu8AkB8BE61p+
 egBZaJYNKLYFHSe6sPylphjJBfTJL7+EC0fB19+w7A1rY3Lmlo6AuBAWESImanKV5L4CCz12X3O
 MauEz1L72lgZ9Q5JHuK7QfDz2m6AnYXvUhlVeNV+yHC9hNbRu5OvQ9LV1lLkTx+lRlNGCRkTV6v
 qC4hmQRgmaNSfN/P9eCcdJFIWri7b5PT4HeV0iIGF8aO3QxbZ4XiK37hrszB5u2M6l1wG9M/Ru3
 nr8ncGENFF3AsHrZmQqwrIhjsCQRIvzEO8yzBnutqnBnGhAlY0pgNCHxdmnkLrgRZ1fTo1IWz8c
 201FfBn+1bjzHk7hga55KHZC+cFtzawSTMA157JBEYVZZz7knvmPbBcmD9Y0YOwVJJ4xTwWFCF/
 3kMajzlPXZkGe6krmiEcDXs/OD9DTVPDWpmFVjhUZz9zn9KKhpwe3FhhwkRIF25s2TaRoeh24u5
 WVVeDgpmZ1CmukA==
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
Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/board/qualcomm/board.rst  |   5 ++
 doc/board/qualcomm/index.rst  |   1 +
 doc/board/qualcomm/phones.rst | 144 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

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
index 66bc922033a2e30a472db5b5c7dc6c8511f50ed8..e2fcbfa19c2fff36c8551823ca4a53a5fdc7fa9a 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -8,6 +8,7 @@ Qualcomm
 
    dragonboard410c
    rb3gen2
    board
+   phones
    debugging
    rdp
diff --git a/doc/board/qualcomm/phones.rst b/doc/board/qualcomm/phones.rst
new file mode 100644
index 0000000000000000000000000000000000000000..1d27196cf54018b393f3cbc914d0cd26e7f0d8dd
--- /dev/null
+++ b/doc/board/qualcomm/phones.rst
@@ -0,0 +1,144 @@
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
+Fastboot mode
+-------------
+
+U-Boot's fastboot implementation is much more limited than Qualcomm's, and currently does not have a
+backend for UFS storage. If your device uses eMMC or has an sdcard slot, fastboot will use that by
+default.
+
+You may need to run the fastboot command on your PC as root since the USB product/vendor ID may not
+match the android udev rules.
+
+You can also use fastboot to run arbitrary U-Boot commands with ``fastboot oem run``
+
+Retrieving early logs
+^^^^^^^^^^^^^^^^^^^^^
+
+U-Boot is configured to save it's internal log to a buffer, this can help with debugging some driver
+bind/probe issues. If your device can boot and has working USB, you can enable fastboot mode (either
+via the U-Boot menu or by adding ``run fastboot`` to the end of the ``preboot=`` config in
+``board/qualcomm/qcom-phone.env``).
+
+You can then retrieve U-Boot's log buffer with the ``fastboot oem log`` command on your PC.
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
2.49.0

