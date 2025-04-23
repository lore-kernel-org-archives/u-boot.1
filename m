Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B7DC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 21:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA9280F9C;
	Wed, 23 Apr 2025 23:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lOE4Npnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A07581E72; Wed, 23 Apr 2025 23:32:16 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99388059A
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 23:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af28bc68846so239405a12.1
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745443931; x=1746048731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSX/9sQGbKqDWDDqeHEWYA9ns/DUT3sg+GNNs1iBoWM=;
 b=lOE4NpnpXJW10R+Cpu+oV4R9oxX6Wu7o8hI0/xuQ4E8p8T93rAb90dIkwHhpAdQRx6
 Y301lOuykblaWrAjYm3fWr+uXMp2GSVjxwMJPcVKx4hQinD//BHfSya+KOTc0Mw2tcHt
 MnvW0BnFpzKQyj9SpDsyVmgVHLRBeqbwFjlNeiXrwYb+/4vi0UAtdAUn/Pq87x0noarP
 ywT4PTD+BAooj7omL3GdIJRQTN1ll2gHzJLaJjH/x92fxVDWV/3iJDDHogFPoxE7ASwD
 cMvS8p4NvcN5ZvMjOikb9G2iQ0SftQwLlC/Yf2RtGPk89oVaaTmXgi33jmgaWytYK/hI
 GfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745443931; x=1746048731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jSX/9sQGbKqDWDDqeHEWYA9ns/DUT3sg+GNNs1iBoWM=;
 b=Kw+ivdU1cz5i4HfURaG8xlsQur2A2pEDL5cYAgKKqW7f2YDv6is7gfvVMFZw34PvHA
 gj1AIQLvYAqkyRQClj2PFp86r7SsWeSSGuLeESbmLxpc7FYxac334I/fTghzR2zrRez5
 e9x+aMGTPYOOiudYgnOy9AH0j1lQLjA5znnwGDUpaGGjpng0QqYlKiZWCAvVyhZws42W
 oHQGJ/3k+SmulU7+oyYWXLUiHa1vaV3XJDBEhl9/IMoU0O9OFV0VhGhWUyn4jyfqwWjg
 0jCyczp2K0Z78jK6CG29GpTFSJRs25Fir70SSaCy6aFy2rEv1AEwBPkEvtQQ3t3DTs0n
 RkJA==
X-Gm-Message-State: AOJu0Yy1bXljSR4jhNlTvnJNZCxaZ9lNbFYJM1T8qrkVAFXhi3UAhwMw
 CGfg2GHFm+TtIAfpbEhyx3sGRjx3RRweSthPR5A16ERcHoiTjqqF6faWcg==
X-Gm-Gg: ASbGncubpC5bh/POlNaQWGAkUOYz5WTSv1pgm51U0hg7WrgJZM0trF7MvjhmpYHKmV4
 JhdhIlVNl1h5jdTAqQIa8pnM9tr94ku8vxaB/zweSVDrRGouPLCbfjiSZLWPZJ8zC2m6dFUouJw
 xYwiKu4YGRynCT2cZ6RMJRR4Y+Tawo/BcqrGrD0Vr3zRaEzfZUhvPZIdHy41xxqWpdq2V3MWAaR
 oklHog5RR4CNSt+5UJzlbdnYri7j2XolfPcZ3yfxjZhAx+4gCE871benZAymfSAL8Wt4EkQEkND
 eT29bt2AJgaXox+r/QpLYyaDj/cpJmv2lc0l
X-Google-Smtp-Source: AGHT+IFlBVG1xXytps/22khYAoV+/4wXgjkBfLyD41RsCHq9ZNgWWeuTArxxRKkQseJDk/zIUqvqGA==
X-Received: by 2002:a05:6a21:3996:b0:1f5:95a7:816e with SMTP id
 adf61e73a8af0-20444f09a4bmr142452637.23.1745443931597; 
 Wed, 23 Apr 2025 14:32:11 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73e259134ebsm49264b3a.27.2025.04.23.14.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 14:32:11 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/3] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
Date: Thu, 24 Apr 2025 05:31:43 +0800
Message-ID: <20250423213145.1959046-3-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423213145.1959046-1-paulliu@debian.org>
References: <20250423213145.1959046-1-paulliu@debian.org>
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
debug purpose. This commit adds the table to the EFI_CONFIGURATION_TABLE.

This feature is described in UEFI Spec version 2.10. Section 18.4.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_api.h             | 24 ++++++++++++++++++++++++
 lib/efi_loader/efi_boottime.c | 16 ++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index 5017d9037cd..0f4245091f1 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -238,6 +238,10 @@ enum efi_reset_type {
 	EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
 		 0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
 
+#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
+	EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
+		 0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
+
 struct efi_conformance_profiles_table {
 	u16 version;
 	u16 number_of_profiles;
@@ -564,6 +568,26 @@ struct efi_loaded_image {
 	efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
 };
 
+#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
+#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
+
+struct efi_debug_image_info_normal {
+	u32 image_info_type;
+	struct efi_loaded_image *loaded_image_protocol_instance;
+	efi_handle_t image_handle;
+};
+
+union efi_debug_image_info {
+	u32 *image_info_type;
+	struct efi_debug_image_info_normal *normal_image;
+};
+
+struct efi_debug_image_info_table_header {
+	volatile u32 update_status;
+	u32 table_size;
+	union efi_debug_image_info *efi_debug_image_info_table;
+};
+
 #define EFI_DEVICE_PATH_PROTOCOL_GUID \
 	EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
 		 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 366bc0d2b1d..e2665459e44 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -4038,6 +4038,16 @@ efi_status_t efi_initialize_system_table(void)
 	return ret;
 }
 
+struct efi_debug_image_info_table_header __efi_runtime_data
+efi_m_debug_info_table_header = {
+	0,
+	0,
+	NULL
+};
+
+const efi_guid_t efi_debug_image_info_table_guid =
+	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
+
 /**
  * efi_initialize_system_table() - Initialize system table
  *
@@ -4053,6 +4063,8 @@ efi_status_t efi_initialize_system_table_pointer(void)
 	u64 addr;
 	u64 aligned_addr;
 	u32 crc32_value;
+	efi_guid_t debug_image_info_table_guid =
+		efi_debug_image_info_table_guid;
 
 	/* Allocate configuration table array */
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
@@ -4077,5 +4089,9 @@ efi_status_t efi_initialize_system_table_pointer(void)
 			    (const unsigned char *)systab_pointer,
 			    sizeof(struct efi_system_table_pointer));
 	systab_pointer->crc32 = crc32_value;
+
+	ret = efi_install_configuration_table(&debug_image_info_table_guid,
+					      &efi_m_debug_info_table_header);
+
 	return ret;
 }
-- 
2.39.5

