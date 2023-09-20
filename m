Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3BBCE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2381C86C97;
	Wed, 20 Sep 2023 05:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EJ4LRAaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A9F86C24; Wed, 20 Sep 2023 05:00:44 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B346086C24
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79f292f0ac2so916239f.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178841; x=1695783641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TQYfyZ34eBRGvR3eRxUiACmi0s7dix7PO3v3DvgE6c=;
 b=EJ4LRAaX2Aue2SjsGGR+6hTkhSwJ9nh5sxL1BqGRUUmBx1T5x69ZWLSjD5swQpI700
 nDQeU8tibZEsfT63Eg7QEV1U3nP/h4d913BUWe/pTVTZhFXbJWJ6Qg6VI+srIycYdRDq
 SCYy5oz2PzjrC6aMeTaloiN+P6qCV9ih27HX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178841; x=1695783641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/TQYfyZ34eBRGvR3eRxUiACmi0s7dix7PO3v3DvgE6c=;
 b=cbtgdKGcZDNCz24OopIFMDHMlvwTntg4vCfmxyjnef6o/DvssmK2lQtDeU+oiofueX
 n5SzsZlOeiSUyUvTIZPigGRs9Fg4iSoADcvDaxMpH7WA+VJymzmbVrK75ipsJSpa3nFC
 CWk6xTjCYvhKlgCJ3JkbfTbyPsOv5Jj+8badxRbfn3qwM3+IIScq1ejarsLA3lnFg84I
 Np0jC8dIIKcMLJx8Mj7RbgxXuiLfP9wSgdiyUoYMgRcgupim5XjfG2jNsGIgsf4LPDKT
 y656JesESIk9VevyQOPed5Xm3wBtx/0hDd+phvxk52SGhcMDVbCUZpySA2mJpQ7zbPno
 IppA==
X-Gm-Message-State: AOJu0YzIwKxKftOeA/mPPYhfQykSKFVhF7NgLOYv4KfdanNexph7JfjZ
 IvpqjM2m89k8ZWGAYv8Di0vke62yqSvHuBiAqCo=
X-Google-Smtp-Source: AGHT+IFOw5d8OnXmCF3+on6aYsDLUZLO/gebuJjLZiK+AE9LoxzEKjaIR4XU6gfYceQNall6op6nPg==
X-Received: by 2002:a92:c54d:0:b0:34f:1e9c:45d9 with SMTP id
 a13-20020a92c54d000000b0034f1e9c45d9mr1484032ilj.12.1695178841362; 
 Tue, 19 Sep 2023 20:00:41 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v5 11/20] efi: x86: Correct the condition for installing ACPI
 tables
Date: Tue, 19 Sep 2023 21:00:12 -0600
Message-ID: <20230920030027.1385833-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v2)

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
2.42.0.459.ge4e396fd5e-goog

