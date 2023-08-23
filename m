Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1852CC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F388651D;
	Wed, 23 Aug 2023 23:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZQWn2MpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E85C855CE; Wed, 23 Aug 2023 23:11:20 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2800A864CF
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79241bb5807so88290939f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825076; x=1693429876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vilHKmgTbuN+hSI9okOrsomzMkvAHmwNMJT0goA+yzc=;
 b=ZQWn2MpS/VTqp6TjtSWyYEx8d7exSYddEU8fLT+PrgshQzcREh6FL4Emrlm7wxGz7R
 Ho7Fw0APSkXthued579kH5KnuIVBgsLlDizd8SIJTOLBqnPW8BYeIyP1XGJbR7ANtWyA
 I84amxt2oNzrhoiEpCYESO7flEyZoE6+FquA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825076; x=1693429876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vilHKmgTbuN+hSI9okOrsomzMkvAHmwNMJT0goA+yzc=;
 b=d9ZxD6oel3XroMpbjAteDz7w+U49PDGOIcb+cYuoou/SRfzlHv3onpbRXm7BYhu3PL
 sHMFFbMlb0UfTv+8h92I7fN5gcC7vO5ym5Xsvs2CWxLy1MUCbICxLxVR9fP75B/CIlTn
 lsZNX7MBNexai3SBiPD8sRNmyx/fqZi3hmPGJuK4ar5AlW8ifp3mz/UurOoTmjnno1EU
 Bma4RkQr6GCKUJelcKMhdZB1rpLrzBMMIoO99QAQBiu5DoIwBdn5IJ3zIfrpky47mxwF
 Ay+LxN8anltRrZ36VVf4J/hSHETL2ZwVajnGuUnxTvomqkXhOgDZM25EyxvRna74g+LZ
 HG6A==
X-Gm-Message-State: AOJu0Yzh8l/5gLPKJGVvMPWMVPfVE4LYOUxz/uaTqI3wP3CzfeCUeEqI
 Gj4fTErmtJV+FXvpn1YsP+s7X+K9xFJRj8NEBSg=
X-Google-Smtp-Source: AGHT+IEMoJH17n5pcm2YeqviC3z6bb8QewGdeKrMZ0jgIaxlYUNDibc+clbcShBCLPdkdK8dJ8CSmA==
X-Received: by 2002:a5d:9e59:0:b0:786:ca40:cc88 with SMTP id
 i25-20020a5d9e59000000b00786ca40cc88mr4071498ioi.11.1692825076805; 
 Wed, 23 Aug 2023 14:11:16 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v4 11/20] efi: x86: Correct the condition for installing ACPI
 tables
Date: Wed, 23 Aug 2023 15:10:28 -0600
Message-ID: <20230823211059.1235147-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
---

(no changes since v2)

Changes in v2:
- Add new patch

 lib/efi_loader/Makefile    |  2 +-
 lib/efi_loader/efi_setup.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 1a8c8d7cab5..0eb748ff1a5 100644
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
index 58d4e134023..ad719afd632 100644
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

