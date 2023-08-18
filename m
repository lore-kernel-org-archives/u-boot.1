Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1ADC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FAD86C48;
	Fri, 18 Aug 2023 02:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xc1GDi1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2862886C47; Fri, 18 Aug 2023 02:27:27 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B8486C03
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3499936a13eso1456525ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318442; x=1692923242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neyX9TvDLR7s8x7j113d44nnSDMXnZoAIe8DXjYD+jY=;
 b=Xc1GDi1KEx11bDxuenR2ggtXrxeeo7/wH8O/Uos2pWxOS/OW/Ev3jfXQ/GtnMiVm++
 3duYp64xLFoI4XKBTiiMEangLS7c1kJWRM6riwTa/isuBbuVgLSuNN6qB085eGaKxcbe
 RDtCRVqnrxSUa1+fQcb1xU9TZu1N9TeTzsc6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318442; x=1692923242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neyX9TvDLR7s8x7j113d44nnSDMXnZoAIe8DXjYD+jY=;
 b=gjRAeZ+6LNXQHt1cuZ0vtMuacYejI534NhaiLUdz+TLQkXVGO/zmRixfY12lfJGiYX
 ifD8TxcImPR++LCemMLLUjjXAIFBquPymwSRIHYpeTI2h4mjTKQhiUsBK6xOl3CiaASm
 2r1wGx/NdoeaVH/ZhS+0vmFQlWc8eRNfSV8FjofCuTvd7cRkp0WnT5OssURCJTRzZo+B
 ver/gdmkO/JzQRLzhkH2NPF+LxneZ9q5kbip3m/+9J2x63Uq0Ot68o7CRYQ4MuZKuLJo
 OvSwNrCMRLnveE40Ymez+9cPkRyqUIqTe0xRZO4A2qx1MM/5xOxhHzaH6aHHnh7kKA0t
 fY+Q==
X-Gm-Message-State: AOJu0Yzna6hfj15A+d01E4y5AU4e0Y5DdZCuZA/MBDJJBZFYtjITeF6c
 gvHCMII9PCeTdOGB5uvMSHrXhZLhMi+4zsTYVhg=
X-Google-Smtp-Source: AGHT+IEyaKXa8wASm4VHJGSNl7T2wnkkUHMB+DMnq1Xr0yqcohDdoIQu2aEWvzHsIpiefhlAXEdcGw==
X-Received: by 2002:a05:6e02:c63:b0:348:8576:15b5 with SMTP id
 f3-20020a056e020c6300b00348857615b5mr1180984ilj.3.1692318442800; 
 Thu, 17 Aug 2023 17:27:22 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 11/20] efi: x86: Correct the condition for installing ACPI
 tables
Date: Thu, 17 Aug 2023 18:26:50 -0600
Message-ID: <20230818002706.853550-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

It is not always the case that U-Boot builds the ACPI tables itself. For
example, when booting from coreboot, the ACPI tables are built by
coreboot.

Correct the Makefile condition so that U-Boot can pass on tables built
by a previous firmware stage.

Tidy up the installation-condition code while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch

 lib/efi_loader/Makefile    |  2 +-
 lib/efi_loader/efi_setup.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 1a8c8d7cab5c..0eb748ff1a59 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_EFI_ESRT) += efi_esrt.o
 obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
 obj-$(CONFIG_NETDEVICES) += efi_net.o
-obj-$(CONFIG_GENERATE_ACPI_TABLE) += efi_acpi.o
+obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index 58d4e1340233..ad719afd6328 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -321,11 +321,11 @@ efi_status_t efi_init_obj_list(void)
 	if (ret != EFI_SUCCESS)
 		goto out;
 #endif
-#ifdef CONFIG_GENERATE_ACPI_TABLE
-	ret = efi_acpi_register();
-	if (ret != EFI_SUCCESS)
-		goto out;
-#endif
+	if (IS_ENABLED(CONFIG_ACPI)) {
+		ret = efi_acpi_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
 #ifdef CONFIG_GENERATE_SMBIOS_TABLE
 	ret = efi_smbios_register();
 	if (ret != EFI_SUCCESS)
-- 
2.42.0.rc1.204.g551eb34607-goog

