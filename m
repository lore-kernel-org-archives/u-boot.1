Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9274ECD13DD
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 16:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D262D88DA1;
	Sat, 31 Aug 2024 18:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qaju6DEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF6F88D8E; Sat, 31 Aug 2024 18:49:02 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4EBF87DC7
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 18:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42bbd16fcf2so13804345e9.2
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725122939; x=1725727739; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oKfpWRguJHD+jXwfwlBIWenXJmpbT25T0w0dd9vvlao=;
 b=Qaju6DErV3j8u+nBdNFLPWNCDN/9iCuJ0cOF/6AynWb1uZ3YLKc3JXlB0ZO0Ro5DF8
 Utf/E6GrTTfhkaAQv4mxk1g8+oHkRhjJnzBF7cxMZcZUpW+bokiw0YLh3+1v/r//Bd+X
 7YtFhvNkPgooo0CmAsFr4EjSww/4jBBLTgMiLX1dpCPe0tpQBDk6kjdKi7kYMOlZA5zm
 vN5zqho0xKapxkEEXGPZkmasMCePSw3rx0kPLGTg3UK0Qk2EA3Q/7JSfeZAnLKwm8P4n
 cHkV7OefpGp1U2WVjJNtUIER1tAovDqUHhj3OtV5SZV5+EoE8MtxLmkI8aQzBLBW99Ez
 axzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725122939; x=1725727739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKfpWRguJHD+jXwfwlBIWenXJmpbT25T0w0dd9vvlao=;
 b=djBp2OpnL69Q3c5CFrTbc/s2adFNcwTAvqqCbvlYHSReGq4dmjYNyFAkoam4Y95fjy
 I+SqFjr4n2TiuLuSKvUYU2k4/GWlrtZ9Am609F4lPYalbFmta10xxzEGg5mqI4/AG+Wk
 fi6bP3pnc2Aydqd7R7dTO7I95/o8CDFIle4xjFRPLZum0oIS8Wcu32mkfhu1H5IJc9Ju
 eY7aqbP+2DPy3JfdufAZt417f4Tu6w0PCjWTfkYL6Dp7O9bcOmyqKMBiIL0g4rMmvx1x
 HVNCSnVtDTwCOBBX0RuDfOS19WvyuYAOfZI9c6W+7YUoGv4uqFYvuHkDmxwVpIKJU90x
 UP3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyOE5aN/sxZjVwYxKf/rYZtAJQTXt6M31Sx/OwAFxQpDhFDlYd0lk9DxDBUEVoJjDzkl8OxlI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh54bzIVqhBh8KMxR1JT1ID5YvHx9NE78Zeu6PedgudKE1HTKr
 Si6mQgJuADKQU8flFhb05F1U90Fv+KRA+DftFa0j8I9iX7BEAJbaGGUCxDYrmvM=
X-Google-Smtp-Source: AGHT+IEM7m6ni1G+yUX3X8+HmKg20uKgvKOvZ/hPFNHGdQ3wZCdyAGG849VLTGuXTgheWtASIOeVcQ==
X-Received: by 2002:a05:600c:154a:b0:428:1b0d:8657 with SMTP id
 5b1f17b1804b1-42bb01c1136mr71492375e9.22.1725122938895; 
 Sat, 31 Aug 2024 09:48:58 -0700 (PDT)
Received: from [172.18.168.79] (ip-185-104-138-67.ptr.icomera.net.
 [185.104.138.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425a77sm116699105e9.45.2024.08.31.09.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2024 09:48:58 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sat, 31 Aug 2024 17:48:54 +0100
Subject: [PATCH 4/4] doc: board/qualcomm: describe phone support and
 bringup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240831-qcom-phones-v1-4-08614edd8e35@linaro.org>
References: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
In-Reply-To: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7379;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=AKDusgfxS6Tm1yZ/1J43dGM/5/VHn9rXIsI/ZnHv/6k=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm00l0xvLzKHCxRVoxSW0tjqGng0ff2NxK7iPny
 WO02i28ZISJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtNJdAAKCRAFgzErGV9k
 tj7XD/wOqWJTLLzQQRX4cIMA4m16C3yttKGPFM2AqCSYn073w/7TbLT1fYdWwLcGvOChMCHQQSS
 z2nrj7pTFlMp5xfKFKMgzg1MvXqIN8HSWLpvdxGMPN2DQja4f/1j6iBQRNI0Y1N2AizRqF3rJnv
 s9rngnWMS8Qdu2oeB9JdQtmowAFPhxtOzvM7W/IamsMrAyH1368M4QPKClsNbyeKEqPubJ8u6vH
 B221yCMfJYNgORhzdBIvfgS3j3m2ycrAdk6phR1rAWL5M1aHaL3DE01HC+AVEFSANDqjbPqfmzV
 i0fPHqEfV2V0a16skRYZqvjb4KUOR7bVzPuMqxs0wT42zNX877h6sWwuUi6ve3jy2T1ebNuD3rD
 r3upVdax0JCVpUibd++AHWAsSPtzLUHL18sT3qsrjCoKChbOnaYXFka2xrmMatgdVwDrcUUrhZf
 I3TvjA+lc0g4fb9CnbR7EeKSAFHhQeNQPtxcVY7bwV0u7uX8rp6yuIQY29t93BzrrPsfP7AcyBc
 p73wPoH8rniyUqIiwKuRrM1IaHNBZx71YyuWiBuw0Ev/UyMSFbKnqFKAuXn8uVEl9gZYiJSmrJv
 C5e0mYbKkHkLzh21Gbvfs0fc+WI6Wn/esoQsgjsgah/JG6dS3KSBeRMlAhexfCn8COS8rfRZpK0
 Hp3Xudd2y2Wl5/g==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/board/qualcomm/board.rst  |   5 ++
 doc/board/qualcomm/index.rst  |   1 +
 doc/board/qualcomm/phones.rst | 122 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)

diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 4d793209f9e3..003d59a18ebd 100644
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
index 4955274a39bc..690d80c4ab1b 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -8,4 +8,5 @@ Qualcomm
 
    dragonboard410c
    board
    debugging
+   phones
diff --git a/doc/board/qualcomm/phones.rst b/doc/board/qualcomm/phones.rst
new file mode 100644
index 000000000000..0726f782b675
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
+be near-impossible to debug without UART since U-Boot will simply panic with no way to inform you of
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
+This can be verified by watching ``dmesg -w``. It likely means the boot image doesn't match what the
+bootloader expected, use ``unpack_bootimg`` to compare it with a known-good boot image (ideally one
+with an upstream kernel).
+
+Does the device hang?
+^^^^^^^^^^^^^^^^^^^^^
+
+Since ``qcom-phone.config`` enables CONFIG_PANIC_HANG, this likely means that you're successfully
+executing U-Boot code (yay!), but something is causing a panic.
+
+It could also be due to a bad memory or register access triggering a secure interrupt, it's worth
+waiting for around a minute to see if the device eventually reboots or goes to crashdump mode. You
+can also disable CONFIG_PANIC_HANG and see if that causes the device to reboot instead, if so then
+it is definitely a U-Boot panic.
+
+With enough time and patience, it should be possible to narrow down the cause of the panic by
+inserting calls to ``reset_cpu()``. You can then determine where execution stops by seeing if the
+device hangs or resets.
+
+A good place to start is ``board_fdt_blob_setup()`` in ``arch/arm/mach-snapdragon/board.c``, this
+function is called extremely early so adding a reset call is a good way to validate that U-Boot is
+definitely running.
+
+You can then do a binary search starting from the end of ``board_init_f()`` / start of
+``board_init_r()`` and work from there using the init sequences for reference.
+
+The Qualcomm RAM parsing code is a likely culprit, as ABL is known to sometimes give bogus entries
+in the memory node which can trip U-Boot up. We should eventually handle all of these correctly
+upstream.
+
+To rule out crashes that might be caused by specific drivers, it's a good idea to disable them and
+re-enable them one by one. Here is a non-exhaustive list of drivers to disable:
+
+- pinctrl
+- mmc
+- scsi/ufs
+- usb (dwc3)
+- phy
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
2.46.0

