Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30512E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DC780657;
	Mon,  6 Jan 2025 15:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pc4Y3GQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0665801DE; Mon,  6 Jan 2025 15:48:19 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C75F805FE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3cdce23f3e7so17859815ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174895; x=1736779695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bs+BWCPcHqD6lpqMrFUFPKuC51gpGUrBQIFeXMIbr10=;
 b=Pc4Y3GQ84PjJsjWPFC4Li9g02hkYSUXLzf9a+LCE904Jm5Hc7uggWgQ4HSLifEpKrP
 1Z50RnrloOu19eml+CSxEoIwy+yNRrbgdEFtr2djFBsSJjTr/MMMIhgg1oGvtVjbf5sN
 JKVUWbV6pZzMjslhVXh2/fLB0/NxgY/6pIoCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174895; x=1736779695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bs+BWCPcHqD6lpqMrFUFPKuC51gpGUrBQIFeXMIbr10=;
 b=QtOyoWCJheA4gmlP6l3AawybPqS8jlI66DEkJvvDr27+HtIKX7xg+ZsdcEeUt2oLUb
 BocnFw/fjrjElimzYwK5kygZi43GwftOMSk/nv+XANo5pl0O+DuBNW9BrqHAgOu4a++o
 /XzH+//wBmNcS2dOssMQ28HMZLconrblweJt23dgLp+HCOp6R3YSIn0JJ95Rk9sAGCxw
 rs1ACUj4GrRLwQUGKkAXl2l65Pvns3+ANLHfIWKs2WKHGHTmJ54n5Ski2BatnMlBLxxB
 /YYbWCFFnOEK9ND6h9iGstJvmOIDYGu3NxSE34aD5+y/heOd1bdi4lRAmEDFEBvysJno
 8e0w==
X-Gm-Message-State: AOJu0YxONaA0KR/+VmyW0nuXpHtnR8VG4j02YFWlctmP+D+gRaxqNiYx
 v20ABxrP8H3AfJWFPA9G7Q1qEw4T4AEqXpAVqfk7ek1g2+3QDnPp3GG6RVsFBq7ImN2Y0VOTtqs
 =
X-Gm-Gg: ASbGncuozGKPGabz/moV1zUVF/k7hj2k1/3AOase3hz2228B/TI+m4jj30D5uozL71h
 763Y4gnea+l8OqH5AlK0H+81eQr0tDc1C9BL3WqLtXG0oxekHucdH1mB2jfJ5XaVZvoRyL66TaS
 yuZe7+0MWKCtmj+nn74KyHivXQaxtQoubfnHrPJrGYR+Ghf00pLiYP2yfPhkJJrg6rvkTvDnVxB
 CEVVJNR8rtl2EN6a0UtTn85u5joVY31FbjVggzsHFa5lJ2w/7kNppwYYel50pppXLDeG/1q/gbw
 8893NvjBxQ5yomPVJA==
X-Google-Smtp-Source: AGHT+IHIzvCmaRnLcDkuQhGxOdV6cgUZcGXyPsJi6n6N9+IIXJ2Y5wATwiWC95Wvp8GnNo4ICOraSg==
X-Received: by 2002:a05:6e02:20e4:b0:3a7:1f72:ad3c with SMTP id
 e9e14a558f8ab-3c2d514ff8cmr428795185ab.19.1736174895348; 
 Mon, 06 Jan 2025 06:48:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:48:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] efi_loader: Check memory allocations in bootflow_efi
 test()
Date: Mon,  6 Jan 2025 07:47:52 -0700
Message-Id: <20250106144755.3054780-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
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

Add checks that all memory allocations complete successfully and that
only expected parameters are provided. Check that memory addresses are
within range.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/bootflow.c | 64 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 35580cee90c..8b1bc9f10ab 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -6,6 +6,7 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <bloblist.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
@@ -14,6 +15,7 @@
 #include <dm.h>
 #include <efi.h>
 #include <efi_loader.h>
+#include <efi_log.h>
 #include <expo.h>
 #include <mapmem.h>
 #ifdef CONFIG_SANDBOX
@@ -1271,10 +1273,13 @@ BOOTSTD_TEST(bootflow_android_image_v2, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 /* Test EFI bootmeth */
 static int bootflow_efi(struct unit_test_state *uts)
 {
+	struct efil_hdr *hdr = bloblist_find(BLOBLISTT_EFI_LOG, 0);
 	static const char *order[] = {"mmc1", "usb", NULL};
+	struct efil_rec_hdr *rec_hdr;
 	struct bootstd_priv *std;
 	struct udevice *bootstd;
 	const char **old_order;
+	int i;
 
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	std = dev_get_priv(bootstd);
@@ -1325,7 +1330,64 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	ut_assert_console_end();
 
-	ut_assertok(bootstd_test_drop_bootdev_order(uts));
+	/* check memory allocations are as expected */
+	if (!hdr)
+		return 0;
+
+	for (i = 0, rec_hdr = (void *)hdr + sizeof(*hdr);
+	     (void *)rec_hdr - (void *)hdr < hdr->upto;
+	     i++, rec_hdr = (void *)rec_hdr + rec_hdr->size) {
+		void *start = (void *)rec_hdr + sizeof(struct efil_rec_hdr);
+
+		switch (rec_hdr->tag) {
+		case EFILT_ALLOCATE_PAGES: {
+			struct efil_allocate_pages *rec = start;
+
+			ut_assert(rec_hdr->ended);
+			ut_assertok(rec_hdr->e_ret);
+			ut_asserteq(EFI_ALLOCATE_ANY_PAGES, rec->type);
+			log_debug("rec->memory_type %d\n", rec->memory_type);
+			ut_assert(rec->memory_type == EFI_RUNTIME_SERVICES_DATA ||
+				  rec->memory_type == EFI_BOOT_SERVICES_DATA ||
+				  rec->memory_type == EFI_ACPI_MEMORY_NVS ||
+				  rec->memory_type == EFI_LOADER_CODE);
+			ut_assert(rec->e_memory < gd->ram_size);
+			break;
+		}
+		case EFILT_FREE_PAGES: {
+			struct efil_free_pages *rec = start;
+
+			ut_assert(rec_hdr->ended);
+			ut_assertok(rec_hdr->e_ret);
+			ut_assert(rec->memory < gd->ram_size);
+			break;
+		}
+		case EFILT_ALLOCATE_POOL: {
+			struct efil_allocate_pool *rec = start;
+
+			ut_assert(rec_hdr->ended);
+			ut_assertok(rec_hdr->e_ret);
+			log_debug("rec->pool_type %d\n", rec->pool_type);
+			ut_assert(rec->pool_type == EFI_RUNTIME_SERVICES_DATA ||
+				  rec->pool_type == EFI_BOOT_SERVICES_DATA ||
+				  rec->pool_type == EFI_ACPI_MEMORY_NVS);
+			ut_assert(map_to_sysmem((void *)rec->e_buffer) <
+				  gd->ram_size);
+			break;
+		}
+		case EFILT_FREE_POOL: {
+			struct efil_free_pool *rec = start;
+
+			ut_assert(rec_hdr->ended);
+			ut_assertok(rec_hdr->e_ret);
+			ut_assert(map_to_sysmem((void *)rec->buffer) <
+				  gd->ram_size);
+			break;
+		}
+		default:
+			break;
+		}
+	}
 
 	return 0;
 }
-- 
2.34.1

