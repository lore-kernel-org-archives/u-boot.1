Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED67CE7A8E
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260A684014;
	Fri, 14 Nov 2025 10:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p9mTpywm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3005F8403D; Fri, 14 Nov 2025 10:33:06 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B9E83FF4
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D55493FE33
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763112775;
 bh=iQ1+wznVlwvMb2xsXdJ95ek9eAhdyR872XpPylYdz6o=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=p9mTpywm1B24nxSKyoXOz3KeJILpgrR1FaFh2Z1OLm7U0DRWs9ujfdca4RvZ+nj7S
 AVQOsAMIV+J9L/41EFi/gJXSnOd0xWC9dEMBIvQJs2c+nieanPUyc1DWBFb1Q2bSb6
 mrngwkPG1Eg7nMlvbrH6AXej5j6X2P8cHN5daMbpn+HwqbuN8C8IVSebsMyzD9V+yu
 2NgbITLSkSv/b33RuPKONXjNyO2vPDRSgfYuNrLcrdfGRsS/Q7s66fc9GjRx1+zc5D
 we5uoGAzRYNLQXAIEfC4ZqnQfqPVjDvl2etLw+hvTaz4/TZhjWcA3XkymeHtA+C5PC
 JWcMwWvzu108DYBJ7paDU7p8TERA4sHA+hcqO8K7NKWol4+D9EsIghlnqBMcm430ck
 7tZr+iU6gQVHT4QUSID2ZYlQWt/qvyqVrvHmS28Jodkm/6Cl/skrv587RsA4gi16a8
 22hTBpzIKu/d+uWVCyZpT+3X/kuwG29QeevDg2xmHckJHWW9tAeqdE4w54fsTFZaFk
 oR0YynMGjAoMnsyiRrUTRosZOTLD8Uwg8yhao/ei/5AUzPe7GvffHjC7tn3v4vHGyV
 ysd+hNsnzCvvwuUopobJwevSboJGKbclqiabtK0a0cPycfkB65byh8b+bTE8CDDhXe
 zwmhyMf8kIrTwslq4WESOsuw=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775fcf67d8so13099995e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 01:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763112774; x=1763717574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQ1+wznVlwvMb2xsXdJ95ek9eAhdyR872XpPylYdz6o=;
 b=tVyVDQWugOn3leIyVMPVK9fQJxeSp1ooIcenMK/H+1wwxdoy4kuQonMASmpXRUr2mw
 iPsw6W75U29YSFQAFBcdQo4bxV7o3DAuNfCYMBbEwMCexmLFkY3RzNzzRrIivXMG9fme
 tD/ixMiQvAY7JU3DwIDueG2hOwT6rSUraWKxSIBNStrjxaFFfr7GRFpbum+VAKYmuMuZ
 puQ7R5Y04sXu/BDMzVdKCmpILNYf5pGRAmy0a8iW9xzttjAJUnGf597ynRDMAlvzWjLs
 IWTBkeoKzcISpKtAiu5zP7n9b6QJAYaNeiGsdsc3nguCLej4w6bFjmJm8OWJYNtrlk57
 XpzA==
X-Gm-Message-State: AOJu0Yx9dAH6oQ3vRaX+mNa7N3Lk3GTG0MMnqf+J7ZeTX7fkZYeO+/2o
 9F9ocNI32Dj2OR8klyJpx9LkuN33lGT5VNItJMWNAeHFljYoKR41lySxMFjLdPgTLJFsBQzoNVb
 505yU/7bU0E1kqkpK/1FKRw6KgzyilxE+jmSZp/oozXZYSQAZCAOtdRvgwuPh+AW0/1rwSdk=
X-Gm-Gg: ASbGnctKzIH90LdBJLujZQMNSPGtiNshqVEbdbvQPyTYkB0pmi1zEBlfrUa9dpmwlpo
 6Sr18l/2kML5v5XRxvfxiYfD92Oiffg716vJ++SOU8cCv7JakyPPAHOMA8uSeuq25XQxLsG7NMD
 mYaIHo3+1vmRg0BGkHolBqesg8+5AxCh3KRknj3XbAbInokeP+eCRjg5ma91v0C036Es73z+8kK
 nxONUL9wnhojxzWv3rdDcxCbWikQDNMC08k4HnQUp6/GGcsBaxcVg+7W0UtVPBYjxE7iqCkzi0M
 vnBXBXwfqtm2s2nws28PCsYnXi7glo1LCUOCqXLTXTsKaF1wvma4x4dy+WABUsxCTofCt5JGaoT
 X32z6CwOvBpbfdEXZvw5DAI0XoRfcsMMFwHppX+89s3JNfvI8motubZXdRz6a57PbyA==
X-Received: by 2002:a05:600c:4fcd:b0:471:1717:40f with SMTP id
 5b1f17b1804b1-4778fe79106mr22839955e9.22.1763112774376; 
 Fri, 14 Nov 2025 01:32:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNSeKsDfowNWnSvTQ+9/kRY4hk0RjdTQSSKr7aJg7Jv2leOM6NR7QlhB763H7QZeZexOlZpA==
X-Received: by 2002:a05:600c:4fcd:b0:471:1717:40f with SMTP id
 5b1f17b1804b1-4778fe79106mr22839725e9.22.1763112773958; 
 Fri, 14 Nov 2025 01:32:53 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c857311sm85462825e9.8.2025.11.14.01.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:32:53 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/7] efi_selftest: simplify
 efi_selftest_set_virtual_address_map
Date: Fri, 14 Nov 2025 10:32:43 +0100
Message-ID: <20251114093246.56422-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
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

Use global st_boottime and st_runtime.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .../efi_selftest_set_virtual_address_map.c    | 38 ++++++++-----------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_set_virtual_address_map.c b/lib/efi_selftest/efi_selftest_set_virtual_address_map.c
index d28ed83eb37..8bcf89274ce 100644
--- a/lib/efi_selftest/efi_selftest_set_virtual_address_map.c
+++ b/lib/efi_selftest/efi_selftest_set_virtual_address_map.c
@@ -10,8 +10,6 @@
 
 #include <efi_selftest.h>
 
-static const struct efi_boot_services *boottime;
-static const struct efi_runtime_services *runtime;
 static struct efi_event *event;
 static struct efi_mem_desc *memory_map;
 static efi_uintn_t map_size;
@@ -39,7 +37,7 @@ static void EFIAPI notify(struct efi_event *event, void *context)
 	++notify_call_count;
 
 	addr = (void *)(uintptr_t)page1;
-	ret = runtime->convert_pointer(0, &addr);
+	ret = st_runtime->convert_pointer(0, &addr);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("ConvertPointer failed\n");
 		convert_pointer_failed = true;
@@ -52,7 +50,7 @@ static void EFIAPI notify(struct efi_event *event, void *context)
 	}
 
 	addr = (void *)(uintptr_t)page2;
-	ret = runtime->convert_pointer(0, &addr);
+	ret = st_runtime->convert_pointer(0, &addr);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("ConvertPointer failed\n");
 		convert_pointer_failed = true;
@@ -82,19 +80,15 @@ static int setup(const efi_handle_t handle,
 	efi_status_t ret;
 	struct efi_mem_desc *end, *pos1, *pos2;
 
-	boottime = systable->boottime;
-	runtime = systable->runtime;
-
-	ret = boottime->create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE,
-				     TPL_CALLBACK, notify, NULL,
-				     &event);
+	ret = st_boottime->create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE,
+					TPL_CALLBACK, notify, NULL, &event);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("could not create event\n");
 		return EFI_ST_FAILURE;
 	}
 
-	ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
-				       &desc_version);
+	ret = st_boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
+					  &desc_version);
 	if (ret != EFI_BUFFER_TOO_SMALL) {
 		efi_st_error(
 			"GetMemoryMap did not return EFI_BUFFER_TOO_SMALL\n");
@@ -102,26 +96,26 @@ static int setup(const efi_handle_t handle,
 	}
 	/* Allocate extra space for newly allocated memory */
 	map_size += 3 * sizeof(struct efi_mem_desc);
-	ret = boottime->allocate_pool(EFI_BOOT_SERVICES_DATA, map_size,
-				      (void **)&memory_map);
+	ret = st_boottime->allocate_pool(EFI_BOOT_SERVICES_DATA, map_size,
+					 (void **)&memory_map);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("AllocatePool failed\n");
 		return EFI_ST_FAILURE;
 	}
-	ret = boottime->get_memory_map(&map_size, memory_map, &map_key,
-				       &desc_size, &desc_version);
+	ret = st_boottime->get_memory_map(&map_size, memory_map, &map_key,
+					  &desc_size, &desc_version);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("GetMemoryMap failed\n");
 		return EFI_ST_FAILURE;
 	}
-	ret = boottime->allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-				       EFI_BOOT_SERVICES_DATA, 2, &page1);
+	ret = st_boottime->allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+					  EFI_BOOT_SERVICES_DATA, 2, &page1);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("AllocatePages failed\n");
 		return EFI_ST_FAILURE;
 	}
-	ret = boottime->allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-				       EFI_BOOT_SERVICES_DATA, 3, &page2);
+	ret = st_boottime->allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+					  EFI_BOOT_SERVICES_DATA, 3, &page2);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("AllocatePages failed\n");
 		return EFI_ST_FAILURE;
@@ -182,8 +176,8 @@ static int execute(void)
 {
 	efi_status_t ret;
 
-	ret = runtime->set_virtual_address_map(map_size, desc_size,
-					       desc_version, memory_map);
+	ret = st_runtime->set_virtual_address_map(map_size, desc_size,
+						  desc_version, memory_map);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error("SetVirtualAddressMap failed\n");
 		return EFI_ST_FAILURE;
-- 
2.51.0

