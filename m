Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7099DEE6452
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 10:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0493B86828;
	Fri, 15 Sep 2023 12:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RFP5nsl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8A1868C0; Fri, 15 Sep 2023 12:18:01 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1699186504
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 12:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso1451063b3a.1
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694773077; x=1695377877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4btGceD5iKx7XC+SvX5hI4qw+NEEZDleq7acA0Pb3s=;
 b=RFP5nsl2KMste4NccYa0A8KZUX9cxgG5oMrhcoB2htgganFbqa2An9KQfaOLjvTK1/
 48FzjKNPDqzYRYIhu+hSj3pMdr+8COCdt72G4Z5LMhIjWp6PC1hm19d+3n9WBXtItkJK
 TNX3SVik1VVZ2I/D0xmypQ7sDR09XufPymLjPit3vnGhNAFoYwhkhE75AWrlfC9RSEGR
 jP8UGZmcDWZWy8Ii8PcqGUp8kng/j0QSPr4S2tQQlao3lJAhSQl+XES+8pHXKR6F+cfr
 sd9cnupO8I2kJbL48STTSpq+HnDrGiJR1RoBBm/jhngjPKtRNX0YMeSFPEKxdbolB+CK
 q1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694773077; x=1695377877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4btGceD5iKx7XC+SvX5hI4qw+NEEZDleq7acA0Pb3s=;
 b=C0dobyeEPgvILxIA1vkx+kTkA0y11rQkn6c8BtnB8BMB/gbB9QLRNfv7PMehTMk5MB
 jgo7PdQpBQDbdMnSbegnDyIXAQcmKeOoeae3PRjq0OeonNlFc1yuL+R3visSAzU2/i5h
 zb0msar4RpSLmsjwOcNsuNBW6JHwkg/Cc6dn6Fz3LvU1L1U8FGjvYmry1p68h4gC+zI+
 4NQpRUYEEGDWM7OwGKLZ7d8HFjXBJkrBgT1U2pB/E5Xbs9NPEGIAGDDv1g9LDDfuXxNZ
 vv+PnGmjogtKpr/zvWUdoJXBMqCPEQzWqz7zm0LufdrsV/Umy/W4VoWwSLr+t0SIeP0A
 lVjg==
X-Gm-Message-State: AOJu0YzzBS8QGjxR0QdO/Wkllg5ziChbRQvbgutsBIvQHVzMA5cpaT3F
 7/B7DqePoPSCUP5MiCchVsEhN6RUXqKKYT872T8=
X-Google-Smtp-Source: AGHT+IFbJKvydXT5fSSFM4l1LmOzL9Etj4SnlQYu9aQbV1TeBjcdRhvMVc54CN11WmmdsBw2rdaFfg==
X-Received: by 2002:a05:6a00:2d9d:b0:68a:6018:a66f with SMTP id
 fb29-20020a056a002d9d00b0068a6018a66fmr1620054pfb.2.1694773077264; 
 Fri, 15 Sep 2023 03:17:57 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 g7-20020aa78187000000b0066a31111cc5sm2695732pfi.152.2023.09.15.03.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 03:17:56 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 5/7] efi_loader: set EFI HTTP Boot download buffer as
 reserved
Date: Fri, 15 Sep 2023 19:16:38 +0900
Message-Id: <20230915101640.1166332-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
References: <20230915101640.1166332-1-masahisa.kojima@linaro.org>
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

The buffer used to download the ISO image file must be
reserved to avoid the unintended access to the image.

For PE-COFF file case, this memory reservation is done
in LoadImage Boot Service.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/efi_loader.h          | 2 ++
 lib/efi_loader/efi_bootmgr.c  | 5 +++++
 lib/efi_loader/efi_dt_fixup.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 4a29ddaef4..c4207edc91 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -554,6 +554,8 @@ void efi_runtime_detach(void);
 /* efi_convert_pointer() - convert pointer to virtual address */
 efi_status_t EFIAPI efi_convert_pointer(efi_uintn_t debug_disposition,
 					void **address);
+/* add reserved memory to memory map */
+void efi_reserve_memory(u64 addr, u64 size, bool nomap);
 /* Carve out DT reserved memory ranges */
 void efi_carve_out_dt_rsv(void *fdt);
 /* Purge unused kaslr-seed */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 1a287ad89d..d26c607815 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -326,6 +326,11 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 			return EFI_INVALID_PARAMETER;
 
 		ret = load_default_file_from_blk_dev(blk, handle);
+		if (ret != EFI_SUCCESS)
+			return ret;
+
+		/* whole ramdisk must be reserved */
+		efi_reserve_memory(image_addr, image_size, true);
 	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
 		efi_handle_t mem_handle = NULL;
 		struct efi_device_path *file_path = NULL;
diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 838023c78f..edc515b9ff 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -22,7 +22,7 @@ const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
  * @nomap:	indicates that the memory range shall not be accessed by the
  *		UEFI payload
  */
-static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
+void efi_reserve_memory(u64 addr, u64 size, bool nomap)
 {
 	int type;
 	efi_uintn_t ret;
-- 
2.34.1

