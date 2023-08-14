Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A21C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 17:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7388886983;
	Mon, 14 Aug 2023 19:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IzC53aCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C64833BF; Mon, 14 Aug 2023 19:40:03 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A557B86927
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 19:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe501e0b4cso42813345e9.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692034801; x=1692639601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hvx8F42W7FnGkq9m+OnLhNvr03+8QiTVretqhV2Re6c=;
 b=IzC53aCPZbkj3N89hhUgZi9TSJV2U5Dm+HgC23UP9PoUgpFibkFPce7iHnPKaYcV+Z
 Z76bl+nnQx5+aXJW5X6ZfIFqyB/J4uO5ELQieSSbVJh9BgGQY+PADj1MkHzWQRTwJVGy
 KWr7/cXY4gl69oE0yqTQTQ5cU59g7/H2YVaLe74lIixcCKvxAe2+35qxXQq3ATzTBv9w
 EhEliu1w65WTHtoMOfTGlLsSxvrGzDmkIMnXcebdUxGdaUjeIB+tjIil2My3tVK42bam
 X29SCbrtJjCgezAjwSGIDp9IE0QvrS/25/43+UOENTYYYeXU9z+gDFUQLKorA7GvDRDZ
 LINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692034801; x=1692639601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hvx8F42W7FnGkq9m+OnLhNvr03+8QiTVretqhV2Re6c=;
 b=PdXORLg8wFWB68Nyfm3jycoWuJgWmChf4hgKqqwTP1NGJ8fLBpRmWCKkE/f6YU5xuc
 1FgZ7AdH4Y2fnFFDDDdOd4LLeRfMxdqXwzwz4W7XDkKODPcHCGqcgJhzsIVqiI/7p+DH
 W2j83Veoz/9K4VJ9PuMjpIgi24gyjbxx+wcVF0fA3f6N5FV5KivAaVw+UFZTvoACssUJ
 RY4ZZYQkZ63yK2D3UUOTf0pUc2oxVsXfedkSH66gQgMU3ebLDd7YvivEpo1olrBXBQx3
 hh7NjWzOMJ1VrnbdltFZNufZVd2YS2+4cC1GPUbTbpUwWmt9Zv7FjdqSSZUXSra0PkWE
 GwDQ==
X-Gm-Message-State: AOJu0YwNakAh/RXpAoD3mMRcrfPVVWf3cwInQLTsZjHju7wnsMQmVdb+
 eVvD/XufEQXK5zX2V/ijJ9DMxz0y6+4=
X-Google-Smtp-Source: AGHT+IGwY7ExaRSGN9MvXpQPYhDtrpzBdhA0s1PJAJXgiPYA8qjjdME05rVnIC92cEmp2UVeDPyHSw==
X-Received: by 2002:a7b:ca59:0:b0:3fe:6640:f536 with SMTP id
 m25-20020a7bca59000000b003fe6640f536mr7007966wml.40.1692034800854; 
 Mon, 14 Aug 2023 10:40:00 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 n24-20020a7bcbd8000000b003fbb0c01d4bsm15002406wmi.16.2023.08.14.10.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 10:40:00 -0700 (PDT)
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
Subject: [PATCH v2 2/4] arm: qemu: Enable PRE_CONSOLE_BUFFER
Date: Mon, 14 Aug 2023 20:39:42 +0300
Message-Id: <20230814173944.288356-3-alpernebiyasak@gmail.com>
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

Commit 608b80b5b855 ("riscv: qemu: Enable PRE_CONSOLE_BUFFER") enables
buffering console messages for QEMU RISC-V virtual machines so those
printed before the video console is available will still show up on the
display. Similarly, enable it for ARM virtual machines as well.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng@tinylab.org>
---
Here are select values from bdinfo and env:

    DRAM bank   = 0x0000000000000000
    -> start    = 0x0000000040000000
    -> size     = 0x0000000008000000
    relocaddr   = 0x00000000476d6000
    fdt_blob    = 0x0000000046595d90
    lmb_dump_all:
     memory.cnt = 0x1 / max = 0x10
     memory[0]      [0x40000000-0x47ffffff], 0x08000000 bytes flags: 0
     reserved.cnt = 0x2 / max = 0x10
     reserved[0]    [0x45591000-0x47ffffff], 0x02a6f000 bytes flags: 0
     reserved[1]    [0x46591760-0x47ffffff], 0x01a6e8a0 bytes flags: 0
    TLB addr    = 0x0000000047fe0000
    irq_sp      = 0x0000000046595d80
    sp start    = 0x0000000046595d80

    fdt_addr        = 0x40000000
    scriptaddr      = 0x40200000
    loadaddr        = 0x40200000
    pxefile_addr_r  = 0x40300000
    kernel_addr_r   = 0x40400000
    ramdisk_addr_r  = 0x44000000
    fdtcontroladdr  =   465e5ea0

Changes in v2:
- Add tag: "Reviewed-by: Simon Glass <sjg@chromium.org>"
- Add tag: "Reviewed-by: Bin Meng <bmeng@tinylab.org>"

 arch/arm/Kconfig                 | 1 +
 board/emulation/qemu-arm/Kconfig | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0d4654fb9dfc..89b978797720 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1040,6 +1040,7 @@ config ARCH_QEMU
 	imply VIDEO_BOCHS
 	imply SYS_WHITE_ON_BLACK
 	imply SYS_CONSOLE_IS_IN_ENV
+	imply PRE_CONSOLE_BUFFER
 
 config ARCH_RMOBILE
 	bool "Renesas ARM SoCs"
diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index ed9949651c4b..09c95413a541 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -12,6 +12,10 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply VIRTIO_NET
 	imply VIRTIO_BLK
 
+config PRE_CON_BUF_ADDR
+	hex
+	default 0x40100000
+
 endif
 
 if TARGET_QEMU_ARM_64BIT && !TFABOOT
-- 
2.40.1

