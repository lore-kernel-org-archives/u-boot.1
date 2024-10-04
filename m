Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E1CFA776
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B32488FBB;
	Fri,  4 Oct 2024 14:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rjIGiqJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B235E807F4; Fri,  4 Oct 2024 14:47:10 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA7188F6B
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37cdac05af9so1986705f8f.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728046025; x=1728650825; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+1OvLCmZvn94f1gK8YJOptrAwZ13GYK0JjDSDyj8hE=;
 b=rjIGiqJhuGv2GaiasfvCq3Ze92CB46xYadWQfb5henRGUXhzgkaIw1GTjcURcXf0+p
 JV0QLMuZuSvEsKM0N12qlML6ytEcBXFCFtQd9EHY5eNey6cujtI7fxvfZnckLKyeOFKr
 eA4oNK9if6m94vD6d9mKvGN5Gd7bYQRAkyzjeOjIT1dOetu1YYcPr0xAQWWPXI7F2def
 1VkyttEVNxnQbW7V9oN/p3557XHCLqiDZcxJk/8sTL/05zVfyPGxI8zWYpjh3w7Nkjdi
 Crv9DUcwoe6HpI0rkC+bpTH7P7MQkFU3x0NCYa/SrD/5uIdPsIC0J2NEYr//Co8Ny6vb
 oaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046025; x=1728650825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+1OvLCmZvn94f1gK8YJOptrAwZ13GYK0JjDSDyj8hE=;
 b=xNdQksHrsiHnFkXvieXQ+KG3Dw9mjLaRNHB/qlIoW/QFP4XMOUpoMEZhIGl/VQ+ZHR
 FiJdwFqZBO9tSxqpwgnyKKfLLC1mnou71WjjrGqGbKaL5wXm4EPArkaRHJnZYlFHZCxk
 vcScC8N0sYjCXMKZEU3XpDN3bMdfJtevAj6axl9p7AXCQRmJI+q7EK0EDEBeJZUwWq5q
 4i2Q1IOdBTaceLKG3o5VmmMlsZcQhZvNEeSpg6+3bQAatN1uR4z9RTfh+U2w9zIr3WuL
 AaKEkkOqB23LuzOfwduVnAXkYqhsw7RYW4kfYfwVNxRfuiprx+w9lNACUR+Yupt1aQ+h
 sfnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTOg+fdnxfFdg83GJog3tZL9UXzRrmN12uZsSZBAHHzR+Wk6aQVrNi8oaiP8k2oUrp3u2zuDg=@lists.denx.de
X-Gm-Message-State: AOJu0YzJ4ZaOT4ma6zgSSl/ENORoVzAea7HRAI91ywkQ4OTyqF79xUmq
 lftfWkDd9BPnJJEqxoTq9KEDi5vdDw7NlKdSpW8wyrSChdNo7bKGHeAjQDLMDqo=
X-Google-Smtp-Source: AGHT+IGB9vm5tPcQGUR6qFPt1hZpzd1ZSpOIcYXrNtetfDBdM88TKd3xsdUu4mSoM8QrpJKNoKm07A==
X-Received: by 2002:a5d:5f54:0:b0:37c:cfdc:19ba with SMTP id
 ffacd0b85a97d-37d0e751784mr3137021f8f.28.1728046025386; 
 Fri, 04 Oct 2024 05:47:05 -0700 (PDT)
Received: from [192.168.2.2] ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082d116asm3177348f8f.90.2024.10.04.05.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 05:47:04 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 04 Oct 2024 14:46:53 +0200
Subject: [PATCH v2 4/4] doc: board/qualcomm: describe phone support and bringup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-qcom-phones-v2-4-c7ab67ac3043@linaro.org>
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
In-Reply-To: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7389;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kpwQOXvTFy95nqRCsvLD4VSf7Qar+mdPKA65ALDt0/E=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm/+O9lutJpHRBQKHC0Yb4JmW8uqqx8KBZnTRGs
 KSgV+7l656JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZv/jvQAKCRAFgzErGV9k
 tmR5EACF5yh47sFtBAdoGT8u6OdAQwnzBHsswhbY1yUundonr2dAeSf+19WoCugq+nKA72sDRze
 7XsrkaguCs88W3J4uEP8BBbGlpV1U5PfS7u8QtrY3tcJjxy34JwEaCBJ5ImURvecYhNYGPZfMk1
 XhXT7puCNrj8eqz0GHLBC4Jqsmk0Id4ZAd9ug9B0fZGeVBPky9Mk+1zNK3EIq0U9/iNlyAKsU8v
 CB7lA0Sa1G/k5SjwSJoWlLy/7VFQ8hpc7wwe/YxCq0HAWnoMZwV8xllLyWAYBFiWMo9zjQNSBPp
 RwthMCuhZ4+uRo7lleonQ2zCmKoVu/GOWSL7P4C2I1gRRMUgeSexseth7qLGLUIEb0rXJgh4Dd3
 nf/IOkGkiL0Pu061vmDqOFk/zYKOb3bn40onQAGH7n3uxc1uSaMAHIHV+HZCsHzJX0q07fQTHPU
 rz+wHvsYDgphgazmoBPbY/Xddm4fW/803FkKktIc9+0r3vUj1jAqxor7QGRyBOrTcbMnumL7V/e
 meoIiS+UQtHdR/3qPunUByeziHsGaPUDdONt7+32v65dIrhx5taimuebbKrK/NwfC+6OOaxkiUA
 ZkiUevSxS9X66eDDQ1pka3yS0sC1b8bLurqwKKvlHcRbUZawkrTMpxQpkuPTLOSvTVz3Hb5l5xS
 UsRW0kw+voYkaYA==
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
index 8c7969987a97..db59b81134b8 100644
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
2.46.2

