Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8BDC36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 20:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B7E882B00;
	Sat,  5 Apr 2025 22:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZwqajxGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9675182AAF; Sat,  5 Apr 2025 22:46:33 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A5D82B00
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 22:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so2798166b3a.3
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743885988; x=1744490788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jCL/ePTlrrCQgz1nDZIgW6TQptjkhJjLmxIrxe+kV9E=;
 b=ZwqajxGDyKALT+goRC96DMqzf/fSjiIMr/nEcxZ8ihHfcbqpPqhs6Br3nutenbRran
 8Bv0MNuUYWzwwuTcVv6WmQthzyFgSpqQuVo6hkzMIc5UgRkqkSYGcZBwlvKu8vOo+vbX
 eZDtpV/mEyxjR1HTRnUz9zA7t3LrKoA0EMIQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743885988; x=1744490788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jCL/ePTlrrCQgz1nDZIgW6TQptjkhJjLmxIrxe+kV9E=;
 b=TFaaLRHVuPgu4S9JXePx53QywPvnDdhctkhKaEONbdxNAb9xvzx91MmCQcWfDILbUs
 wi9cchs5sHJwKCWbWLirvPxcLVcEFJFqteRJ0gwUPJlI2uExsRurE7+Gu8EOIGFQFTxw
 Z8A+HGnxrMJj4jsYZ/7cBf2Fc1ZeNQjQgQpqRh3BaHg1tZ/oTukiBDLIZaiwocRkKHjD
 L3g1Hid5S4jk+yqP4axIIoOmqTQYt1W7m5lRBov4RrlMQ+roiV/Lk7/ZI3349TztgYXk
 5rtrtIrp24Av0GvUpRNiDol3qrOtyPhfWDANrZn7xNfu3j3TxUnDbylX5qL23dDkdLso
 M3SQ==
X-Gm-Message-State: AOJu0YynvFpi5++Vx+LLmBwV2AUQScWx/jGqvbffjS48hh2vjpDSfCkO
 DE8VC3N6N9TH1u3C9qYBcxeXDXRX84OTIR38uZ2mcFfFExe/sjxP3UO04V2ipfvhCEtBQwOqBf4
 E6g==
X-Gm-Gg: ASbGnctD+Fx3F+e22Mif2fM0xMJ6v/dxfPJWqcet085EZFYNtqEHYK6+gXqDA07u3vt
 YOjVSUvThC2U7ZmcpZusiHK6FxWNBn/pY4vG72BpEDjh7Z+2hqxcc+qXXa50fIWccJc/3yP23Ox
 7eDzg+qMrBkiBx58sZ2g9msHvwhU0WyP32ge7CQkWAp2jI22i75oKKnQro+J7HpMDVNRfZYagVc
 M3AiIXU3NRSa0CEEq/btZxrYkqfgDxK00+u6ILt3GiCzNSEoYRA2Nttt6be40uL39A/JCGyPE+4
 uVepVE3xKIUxVCqX24Q/2+kUC77pQqch6jTGlIMMhQg=
X-Google-Smtp-Source: AGHT+IGBB0Syx1IUiw2YbOk2EP+VEz4TpYcnp+UlzYSTr3CRiKrABbJeguF1pjOQBlhrCkt5oQzXSA==
X-Received: by 2002:a05:6a21:2d0b:b0:1f5:93cd:59b5 with SMTP id
 adf61e73a8af0-2010473595emr11422680637.28.1743885988440; 
 Sat, 05 Apr 2025 13:46:28 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97f2fdesm5801521b3a.65.2025.04.05.13.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 13:46:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Niklas Sombert <niklas.sombert@uni-duesseldorf.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via EFI
Date: Sun,  6 Apr 2025 08:44:06 +1200
Message-ID: <20250405204409.420738-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The EFI-loader code has not been fully converted to use bloblist, so
relies on the SMBIOS-table address being set in global_data.

Set this up in write_tables() so that the SMBIOS tables are actually
available.

Enable the command for x86 QEMU so that the SMBIOS tests actually run.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 83ce35d6ebb ("emulation: Use bloblist to hold tables")
Reported-by: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
---

 arch/x86/lib/tables.c            | 2 ++
 board/emulation/qemu-x86/Kconfig | 1 +
 lib/efi_loader/efi_smbios.c      | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index ec52992209f..d7f183f95dc 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -126,6 +126,8 @@ int write_tables(void)
 			use_high = true;
 			if (!gd->arch.table_start_high)
 				gd->arch.table_start_high = rom_addr;
+			if (table->tag == BLOBLISTT_SMBIOS_TABLES)
+				gd_set_smbios_start(rom_addr);
 		}
 		rom_table_end = table->write(rom_addr);
 		if (!rom_table_end) {
diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index b2a4e0891a4..c1564fba7cd 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -23,5 +23,6 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
 	imply VIRTIO_BLK
+	imply CMD_SMBIOS
 
 endif
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 8d2ef6deb51..5275e966dfe 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -35,6 +35,7 @@ efi_status_t efi_smbios_register(void)
 	void *buf;
 
 	addr = gd_smbios_start();
+	printf("register %lx\n", addr);
 	if (!addr) {
 		log_err("No SMBIOS tables to install\n");
 		return EFI_NOT_FOUND;
-- 
2.43.0

