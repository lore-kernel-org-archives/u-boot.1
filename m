Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8004AC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 08:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC53C88992;
	Tue, 16 Jul 2024 10:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JZnhF5DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D3588980; Tue, 16 Jul 2024 10:35:40 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD12C88365
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 10:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BDB173F187
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 08:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721118937;
 bh=PyKCSzicyd4TCb2x14Ux9TRaFe9lXwNb/lx5aFiDPNU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JZnhF5DVPtAT61vNP7hZenXiLPcC7mzICw6HPXVdzScM4sHya0VqPK/23pYGGWxus
 2hO/vBMSC9Ir9RnoWIV2wEktJ8CCdFbU56OuGg4+sZdJ+4gmGg7arLMtaVRB9rX1g/
 RYpthIYE2Erk/qigJUvUkhm34kw/WJYR3b3nFNVHL93Qvw6m32wQl9Lj+YtOTx+3p7
 EotDgNsiWInhF5n/9YO5p8q7hD95VME/y1Fjd7twGmY526fQX39O45jmjHKHW7Bdzr
 fHVMqdb4jTYx1hICKVESHdq6AXxfrWpIB79YzqJ8Oa+6OwvTapP0gqnotfOmFh79gO
 Rv2+I0pCBw6wA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-427b7a2052bso10390935e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118937; x=1721723737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PyKCSzicyd4TCb2x14Ux9TRaFe9lXwNb/lx5aFiDPNU=;
 b=ayOtuWochfQYTUFP4m9dv/EcIuyFyq0l3KvgOesznkt3GZZ5U/x8gNxvVdXH1Pe2Va
 pvZbl/6JOidfyCLVC5g/u46ELK3a0NizFSmCsAuo7mM3uOaxtaVgBXHU9PIsC7o/AgMj
 rapWntBII3ElIMKMiSujP9Nsi4jj74Nx7UBk+gwJDpLGYIUokN6TuTwxer2hYGqQ8WSZ
 YxihbVUuNLpTovNfSlTuDyITtTRqzb9/l99qx209350IPbukqK6qpvNDAykyqypz9t7v
 WJ649qDTaLZbZEGIljNQ8ps8BYl1KjHwOOFmeu1g9ibwtQ68nCyPdyLmnRty3THy71jK
 ZUEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXySEy+U9e2jh4E3oV2dnsP52aFRZYhsDSNUhj+MRXvVzr+iWf+rOyR4QPNlQaDuebnrA5rQsw7zEK4/HI5skI2bDbVw==
X-Gm-Message-State: AOJu0YyTjgypnp4tnAX1C54mUkPrE+Yyzvx2pig5b4HgfJ6A8u4f9y4j
 x1ulSPYI34r3VR+YufsnM3kBrzQmJFmgqPB5mU8IbFIRmChfF6kbF5+yekTe8fowSDor0pXTDfK
 m0wphYgTc792aJHi09JQjj9BO2OY9AxaO//gbUAuJLmpRZ7ieL/Nx7GlKqnnjsLciSJc=
X-Received: by 2002:a05:600c:4708:b0:426:673a:2904 with SMTP id
 5b1f17b1804b1-427ba71ecdamr11590515e9.36.1721118937278; 
 Tue, 16 Jul 2024 01:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ujwaaF54Z5NzPfAc/HsFUFbGuwDsahZmQLDrgDAPF4BP5M9rTlO0JQCpqHlsfUYZwZP3Bw==
X-Received: by 2002:a05:600c:4708:b0:426:673a:2904 with SMTP id
 5b1f17b1804b1-427ba71ecdamr11590235e9.36.1721118936900; 
 Tue, 16 Jul 2024 01:35:36 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e77a55sm114578905e9.10.2024.07.16.01.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 01:35:36 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] boot: provide CONFIG_BOOTMETH_QFW Kconfig parameter
Date: Tue, 16 Jul 2024 10:35:34 +0200
Message-ID: <20240716083534.19062-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

U-Boot is often used conjunction with QEMU to boot via EFI or syslinux.
Here the QFW boot method is not needed.

At least for qemu-riscv64_smode_defconfig the kernel parameter is used
to specify the U-Boot binary. Trying to run U-Boot as a kernel makes
no sense.

Provide Kconfig parameter CONFIG_BOOTMETH_QFW to decide if the QFW boot
method shall be provided.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	default y on all architectures
---
 boot/Kconfig  | 9 +++++++++
 boot/Makefile | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 95300b008c5..81e7ef197ae 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -568,6 +568,15 @@ config BOOTMETH_EFI_BOOTMGR
 	  the EFI binary to be launched is determined. To set the EFI variables
 	  use the eficonfig command.
 
+config BOOTMETH_QFW
+	bool "Boot method using QEMU parameters"
+	depends on QFW
+	default y
+	help
+	 Use QEMU parameters -kernel, -initrd, -append to determine the kernel,
+	 initial RAM disk, and kernel command line parameters to boot an
+	 operating system. U-Boot's control device-tree is passed to the kernel.
+
 config BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded"
 	depends on FIT
diff --git a/boot/Makefile b/boot/Makefile
index 84ccfeaecec..92e6adb887c 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
 
 obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
-obj-$(CONFIG_QFW) += bootmeth_qfw.o
 
 endif
 
@@ -31,6 +30,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
+obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_QFW) += bootmeth_qfw.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
-- 
2.45.2

