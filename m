Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37B3E7D0D2
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD9086A24;
	Fri, 22 Sep 2023 09:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W6rG8e/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9537686925; Fri, 22 Sep 2023 09:12:19 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 833FE869F6
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57354433a7dso917802eaf.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695366735; x=1695971535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwwmmRncDyhEDtzmHsqB9lGW4uFafsxOwt3w7F08tA0=;
 b=W6rG8e/SIt1X1G3qFhVJk3UBXscu5WGoUz+7BUPUUK0twqneqGN7QVsyz+FleEJq4b
 R+P0athFnVVZsuLhIg0GTPjQm9dLPTpdEdw9H/5MIIXpEcbl40qBnAiY6OSnkBFSO8tX
 7AkBSljjlgribwo07WCn+pvebgPctyxep3KNtjH5U2kREQShMfDvEsANvDXAKo+fGNwM
 oIpzkmzCTDw5pfBxjPKqSP4o42DiRvxoFRpGPF6IDdrkzljbOGkbi1TJQ5yx+KqSlOGm
 4R4hwv8ycaKjWlByc41fuBhcUhharQxhgGtrMaBNVYRbyB38mh28/Z2DBRwZsmB5bJLj
 ogHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366735; x=1695971535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwwmmRncDyhEDtzmHsqB9lGW4uFafsxOwt3w7F08tA0=;
 b=cY5gdHJR56uXoMQzvCRF6WYXn5Qt4Pz1y7xAVMfsmGBI1BM0t/tNqzlUn6ePQhdcYd
 4g2nZ0tkQzCqIiecQZnPhI/tlEq0r7I9CLhHXJLjHdcxwHAKyo7u/L/4aVo5aKs7CY9N
 Id4e74RbLfL0kYZGYYZSuHNGdJ7OIHaS+iA3mj6+F+z154opqhD1WfKyqQOcuzOj17Bt
 E6CiIWELGvvPoS2WZmZyyMGLeNmgr3jy1OWh0tt8bkOVclDhRurk1xS/ukE0U+bc39Et
 F6Cgpzd12KtZMJGG9I+cu80QalNF5issoGYk0HDWg3trVwFIIGNYdFPjGP+169ufBOm+
 QoXw==
X-Gm-Message-State: AOJu0Yx0Ty6GadT5UI0IeEDv/iO/IobIdKrqkPcwgNmvv6M8h0ktUFJH
 QViZdPrXLAIoILPr8o0Z+VPWU9kOWocxLqY/FPM=
X-Google-Smtp-Source: AGHT+IG5g1Xl4DLDulQ/m7gZk7+SyXN9DMSY7RG1jcymvFdmzyWyMwSlgKjKTQOtftch8h7HMH97/w==
X-Received: by 2002:a05:6870:b4a5:b0:1db:f7f8:ab56 with SMTP id
 y37-20020a056870b4a500b001dbf7f8ab56mr8335522oap.53.1695366735619; 
 Fri, 22 Sep 2023 00:12:15 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 t63-20020a638142000000b0055c178a8df1sm2435858pgd.94.2023.09.22.00.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:12:14 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v4 5/8] efi_loader: set EFI HTTP Boot download buffer as
 reserved
Date: Fri, 22 Sep 2023 16:11:16 +0900
Message-Id: <20230922071119.1439482-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
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
index 605be5041e..4991056946 100644
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

