Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3089CC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E6A188B63;
	Fri,  9 Aug 2024 02:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G8x2jMmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E92988B8B; Fri,  9 Aug 2024 02:49:01 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF11E88B81
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so251518566b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164538; x=1723769338; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NUIaIDYuarjZ2xvaAjlE4GF6abjF8tFPSzm38GjGbjU=;
 b=G8x2jMmVKM94AqLASjd7VxHrESTRRKO+QCOfaXOlvWM97Qcbqd3RiVfZpgXrKbKhYS
 6u4B5vJzTKJ6wS5sDsEvRbQm942uj6eU/Y9PXwLx0ZC+KiYA8pjvT75qGIWnpR9iefUL
 ISaFOdf6A5fvqc8g3e73cZZTkisetl3SX+fpqBXdG1Dzmp9MJAE89Q6clGSDKAmdzwMf
 u1u7ee7Z2FXeWXvZqhqy0uFHuRpUpRw6/KVNJlPo2hNdGEX4SVY2l4kTrc9CzhZ3d5oh
 sQx8UrqmErP8MMr06aMm8ENXA32wrNRQdjrkMPS4UYqx3KoP8cRh7VYAEmfQDJRBUUFP
 wbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164538; x=1723769338;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUIaIDYuarjZ2xvaAjlE4GF6abjF8tFPSzm38GjGbjU=;
 b=sXtdpUq1FKBM8rlwyp3oWaYCIAbSzEEx0l3+i9GmkJpBhwXQpT2PsZbMeJ8pBsUw49
 CW3ICHs0wvhzltHMNBM7Jvn2JGmgaqkKha5EXAfvtTvc3iWcZFesQ9Ns6HHB9J8we2Es
 1yc5HUqGB5VbmP/zDAr4ckTh3fsENkpwzXl+4tx8qUA4D6Wxy55gq3h3qYys8njdRYLj
 VvUNnC8ABcqJpnH2IwHcysnEhlCA5vEH4ZSn3vZgMeam6Tiros1guse9J4c08Tx/76+D
 s6vp9m+DX2vOmyUATa38hS4tqD9tdnIWNYTx+8GWOKF4baxYTLqvkRHUVTs35L2Th9yX
 OBWQ==
X-Gm-Message-State: AOJu0YxDbFuxDKxx5rIMNYL7cy+z40P8mfvoXxQ+zHHhHMa3DXPaIgTu
 aKfkzaWLNdC5XeP+SyEbwjngsmNSm8yqvzdxcrR9bD3iIr4gbMs1VpP/q5zDIIY=
X-Google-Smtp-Source: AGHT+IHOGQh+ZfEqqLsTf/XK2eF5MEx2wL6T71ZAtucC1DyM5A+yHd7DWkpfY98nr996hYKA3XXvCg==
X-Received: by 2002:a17:907:8692:b0:a7c:d284:4f1d with SMTP id
 a640c23a62f3a-a8091fd825emr299663466b.28.1723164538202; 
 Thu, 08 Aug 2024 17:48:58 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9f5sm789811466b.50.2024.08.08.17.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:48:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:48:50 +0200
Subject: [PATCH 7/7] doc: board/qualcomm: document rb3gen2
 building/flashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-rb3gen2-v1-7-7c73fe05b37a@linaro.org>
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
In-Reply-To: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=fa/zwrgeBCF/rj9hYeapEO2qsL2gMploXGaV1bqs5n0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWdwDbDFcSMC7Qy6n4f8cEfUDtoAcY/uwczEQ
 nmSCYP8ZGeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVncAAKCRAFgzErGV9k
 tmByD/9swVPZ0LryqY/GV8lk50fCIwc5XNT1gFkFGnhv6OM7sYflnpqI4+esT4FAa0J7PURDrgq
 exYXro0iJ8/Apf3na6hQ9yFW/7CrHdl8ZTb9rU9kpe8+DDQ43/M/MhvG9onkMTL+SCLzMGVRT1N
 vU6kaMekeNTTpyjuNmTk8n1zD8tJmLrXy9EaHgYLikBK8hF3cPxnebpHjvtgh9HocDqLr/ByZ0x
 zazk8dPBnFMEpP4OqNcZvrOLXfZWb+iCnbTkFbXLS4i1oAUcV79DDGJ+945OL7K6htX5MSa9Vpj
 Jd+7giiVUxEY3OmS/fFEcX6k7kl6ZB4za3GgjHslBXYvg/H8I1BGo09uBWJ3TS8PVrTpmW2cB3w
 cvPWoxtlBgdOASh3UKG3igf73mLtHietMgtQqxXprBRxXLzKHXUlUf+WIhlEhHc80hpuzkJ3s/8
 qFlBjiBmmoVmh55ymG+bnKW+AGqmnHsEG/zIZdfXvYgecyr/4Tf3XD7R88CAmRYiUgbGV7V3ZU8
 yUQEFCbUv6ZobKXQJ5A7sIxDcaqA/hHYrGst0UcqTrfsCsg8dbIN/xRoABtDwUSJwZuGGgDvlVH
 isXWgWAAGzmYMyGHRZ2G+65Grdob31viWVm4x2q1j1dinEqmiwxfPTwn4tD0BpCO80MHzSg4Fh2
 QngBiG2M4bfTINA==
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
 doc/board/qualcomm/rb3gen2.rst | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

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

