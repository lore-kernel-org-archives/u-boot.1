Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB5FC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 13:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D6FC88C7E;
	Wed, 21 Aug 2024 15:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N7ncWeh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78A2D88BF6; Wed, 21 Aug 2024 15:42:05 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0804988BBC
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f3bfcc2727so47717401fa.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247722; x=1724852522; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IvOluZPLzD78/HF1gfteCSftNGDnvO7+RNQKT4a8rSE=;
 b=N7ncWeh3cbNIFm16gC0ycocqUu7FjIH/X5KUs3ng3VOMDiDB9bx6yqvhqYvjQxyBc0
 NtX/AEn+6kLdyYda7FlKDaCMV9zQy5kNC993I5rZ4A9iW9QyJTuwBSzH7qa4sO6gQ1ol
 8Lo1+ZJhhBum9Ni+61giewvGR09iEusCmwVImeU5GAZaibju4E3OPBByXLzP8iW1CXee
 Td0YEp/5GqF/suNSfz0LIe3u7qAf4ym1XGfXSuoSZTlAKYusX8Hr8p7r6eeQe98FId8k
 K8EtjvWCpjafWWcaMyS2hMQJ9qVg2oN+O0BWIVzab1rmcZfKqTsdCdRmT5zJ8/UuskiJ
 ovww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247722; x=1724852522;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvOluZPLzD78/HF1gfteCSftNGDnvO7+RNQKT4a8rSE=;
 b=irJmZUIlQ9YqUetM6kgCgWcp0L2t2cRcBdc7BANQ6GSkyblKM0IhcjmShs/YQLTvfD
 kcy+qKFJUBLqwl/GS2t28MNGXs5+jyhkJJtmlWXg0jksArLnCgxQNWggqkJHxHr4QXWm
 yQUR1tfzoSdEPgisANBnh6pIR2x4I+INopwPke0bJOnMgq6gauZ6e7Sb5DK8+XfB+ub7
 4BwZrBRNSgdQL4GZy7yJ7/tDy+Rb77CKeC82GlbeYSYWjhnyNHiApHXii7b3P9K1dIpH
 TuIXX+CoDUWK9SpsTDPZQ9TKah8sMs4lll+6bxADx28pav2gXGoDzIq8+8njC4mnAW8D
 QRKA==
X-Gm-Message-State: AOJu0YxQDsjOdfe21vx3pm9NQzQM6F9uuV8kmavTQJuc2Dc6UIFEBXIw
 Yp6RPVVelZ9sExmiTtDcpYm6jM3fkV9MKKhMmd5jCa8HvsIjbjln6JXyuICIMFA=
X-Google-Smtp-Source: AGHT+IFOXObF674O6U9t5YWoWgiOsh1cr3c2B3a47ilhjVWpLEAWrw7hptc9n6o8T5A7NFea+26OwA==
X-Received: by 2002:a05:6512:118f:b0:52f:d17e:46b with SMTP id
 2adb3069b0e04-533485eff58mr1798728e87.54.1724247721704; 
 Wed, 21 Aug 2024 06:42:01 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm904164066b.137.2024.08.21.06.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:42:01 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 21 Aug 2024 15:41:52 +0200
Subject: [PATCH v2 7/7] doc: board/qualcomm: document rb3gen2 building/flashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-b4-rb3gen2-v2-7-49b07633f3a8@linaro.org>
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Zfbm5IKZooOMQaYWVdjsboSGnZBH9tpLor1DsgqeCLA=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmxe6eOpavbRRq/Mmd1u2iOzwt3wx46uoOvpDbB
 SjdW6jqdcuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsXungAKCRAFgzErGV9k
 th2IEACXQhOGwtEPSr0Jpv9CdMJZvP6O7/us/hUgF9Bir4ETF1KQoReZ18goCIPH2bfLWQIT4eN
 CS7gQ46J/jZfFKYl2ORIB7BUUfe58/nB4VvbfGfmskbHi4sdVSemgHxu04xNtj1ttCaiVKX58D5
 GLThMjr4w80H1RLlEnlJmDf8RC/bp6PPHv1a9f0mDH3y00HDTJInV1+p8Bp5T/foomvjYfdcB86
 okdAJzhvNDYeA+xQxp5zTAzDoGI1K/5NYiLyqYoNzpb2sVBTjEBl6fiQqZ6q9b6TWoP5H64s3VC
 OsD4ZgATKSXgEYuNYGx5XwDd66lN31jnu4BRhav643sBpOwpN/UN3cLVeqHbD5K3QiI6j+afC7w
 o1QNNxNE9pBp3ZBWWWWFbbOv+rwy5npvZHZKWUSNC21l2/4hI6XwAFLDlu5nm+yQ+fYdb4HnMc0
 1kGJhpGz0/guwKXxpSVxijQT5lFbr81ADvFLzoRD33x8EnbG4aFGa6PhIU+H/9TNpDOaDWHQdIb
 18rqauYLxwejAvFKDC8EIWM9n+6Qkn8caR37H11EnKkNX15ZRKn3Oiv7n8Wy6CukVoFquvjL4IU
 t/2E8nV32ksuehndbsDXnpRpSAefggkQ9TjkuGaV29j0nvSrlJiCud0Dzj0lTdjxBvJKpaXG7XN
 YCCZ/x5nTtnxdyg==
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

The process here is almost identical to the Dragonboard 410c, we've come
full circle!

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/board/qualcomm/index.rst   |  1 +
 doc/board/qualcomm/rb3gen2.rst | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 4955274a39bc..8c7969987a97 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -6,6 +6,7 @@ Qualcomm
 .. toctree::
    :maxdepth: 2
 
    dragonboard410c
+   rb3gen2
    board
    debugging
diff --git a/doc/board/qualcomm/rb3gen2.rst b/doc/board/qualcomm/rb3gen2.rst
new file mode 100644
index 000000000000..4240606224f5
--- /dev/null
+++ b/doc/board/qualcomm/rb3gen2.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
+
+Qualcomm Robotics RB3 Gen 2
+===========================
+
+The RB3 Gen 2 is a development board based on the Qualcomm QCM6490 SoC (a derivative
+of SC7280). More information can be found on `Qualcomm's product page`_.
+
+U-Boot can be used as a replacement for Qualcomm's original EDK2 bootloader by
+flashing it directly to the uefi_a (or _b) partition.
+
+.. _Qualcomm's product page: https://www.qualcomm.com/developer/hardware/rb3-gen-2-development-kit
+
+Installation
+------------
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``qcm6490``::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make qcm6490_defconfig
+  $ make -j8
+
+This will build ``u-boot.elf`` in the configured output directory.
+
+Although the RB3 Gen 2 does not have secure boot set up by default,
+the firmware still expects firmware ELF images to be "signed". The signature
+does not provide any security in this case, but it provides the firmware with
+some required metadata.
+
+To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+
+  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+
+Then install the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
+on your device with ``fastboot flash uefi_a u-boot.mbn``.
+
+U-Boot should be running after a reboot (``fastboot reboot``).
+
+Note that fastboot is not yet supported in U-Boot on this board, as a result,
+to flash back the original firmware, or new versoins of the U-Boot, EDL mode
+must be used. This can be accessed by pressing the EDL mode button as described
+in the Qualcomm Linux documentation. A tool like bkerler's `edl`_ can be used
+for flashing with the firehose loader binary appropriate for the board.
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _edl: https://github.com/bkerler/edl
+
+Usage
+-----
+
+The USB Type-A ports are connected via a PCIe USB hub, which is not supported yet.
+However, the Type-C port can be used with a powered USB dock to connect peripherals
+like a USB stick.

-- 
2.46.0

