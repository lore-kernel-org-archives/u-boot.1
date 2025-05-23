Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7648DC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2BC9834AD;
	Fri, 23 May 2025 18:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hYH18eZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE6F83448; Fri, 23 May 2025 18:55:17 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405DD833DB
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4c9024117so99849f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748019312; x=1748624112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e0SAIsxA+/yd6dCyUuHIBDLPRifKsFsRmSXqkKHefs8=;
 b=hYH18eZBCXSLFv/2Oc9Ki2X0SlpLt6/Vmejw1odALMr/2TxXwjMTh5xs8ur3l7/4Tb
 m0HdanoRr1/PbDjEZa4WKcvm0LV5pYdErtwiviKEtpISF9Y+74ufA8ABXVeM6+lDdhX6
 mEbK9qTuT2d0mIBbrXkTH9v+QLxJjEJHYOBG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748019312; x=1748624112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e0SAIsxA+/yd6dCyUuHIBDLPRifKsFsRmSXqkKHefs8=;
 b=NtQg00vz4MadqaEIox6UQP8vKeltMfeNy+FOUor5G+aqAOz1QymkuP0oS7uHNbpIkd
 mAHtFZhF+hCA/0sMHMJ65hV02dgIVnAUmR4Wr5Z0A4kn9/8htiKKfkNEuqfCt1cVxpaO
 22VvO9PrAX0a+YSZMnihhPWnNH0pndZ4PaE5OCZY4uFrfLQ7C6c6Vd6lRkspJEH6JrZB
 C0WpGsLiPZEnKWm8Tx30Or+jQ/oVw+9WMMctzDZEA6lriQevHTs6hz5VdcjNv0qOzGxO
 OumRrcB3vzCyaxj1zWCXGcJAnj0SPiKx6ijpgxne7aIgyaoVJ1hNtnmQjDAlXE5uwfpS
 1u7w==
X-Gm-Message-State: AOJu0Yz8DcLibVdC7OACMUiEK+mtE1pqJX1zRRg74VjEFYgZYTakarjb
 OYczvvybNYi4/gch1EMXeLAfyNIJg20xp5eN1PIhumrEikIDExzt4rsS6rgQIXoEZD3xCwc/ps2
 7yMxS583p
X-Gm-Gg: ASbGnctkkfXXnusQH/cnpVoX/n5kvYvO/3G05Mef6zvObAJ2OJIHl5D/QthIxs1WMmw
 5b4dxlpXsu2FzwdtAipehQUqogV3spkkGMJV5CRxpJFTjLO1lwaRR31x0elSeM9WXYSHHClNaNp
 XdRgHaYutIeyDO7fuYegJJjFjSbK7oe53+4rQVypZ0Wmt3NIZgUZTU0dJnIHAqP8Nwa1jOo92oZ
 oivLt77DqZHjbAM0Jz9oSp7Rlacz8zpADXyQi9Tv3mTBPylvmSSJYmHDcXmPh6ol/VklEBzAHif
 hKMpzKTINaeQSUCNUlfcGNZl1dPlbsIq+uJFgVkqTNJXm/VgB6WLFqKtdNi/0qPKY11G
X-Google-Smtp-Source: AGHT+IEwUpjvO5rwOTVqAz6cpFx/GObso70TdBvF0ReQD0XBUbZH7D3wc59KNeSsMQFD9bC7ZtIr+w==
X-Received: by 2002:a05:6000:2584:b0:3a3:7465:7e60 with SMTP id
 ffacd0b85a97d-3a4c15589c4mr4729387f8f.26.1748019312205; 
 Fri, 23 May 2025 09:55:12 -0700 (PDT)
Received: from chromium.org (82-132-233-54.dab.02.net. [82.132.233.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447eee9d8desm153476265e9.0.2025.05.23.09.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 09:55:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Niklas Sombert <niklas.sombert@uni-duesseldorf.de>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2] x86: efi_loader: Ensure the SMBIOS tables are sent via EFI
Date: Fri, 23 May 2025 17:55:04 +0100
Message-ID: <20250523165508.1416716-1-sjg@chromium.org>
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
Tested-by: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
---

Changes in v2:
- Drop unwanted debugging

 arch/x86/lib/tables.c            | 2 ++
 board/emulation/qemu-x86/Kconfig | 1 +
 2 files changed, 3 insertions(+)

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
-- 
2.43.0

base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
branch: fix-smbios2
