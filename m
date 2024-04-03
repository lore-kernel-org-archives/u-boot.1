Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB69CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD30B88398;
	Wed,  3 Apr 2024 17:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Kdihtt5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E0888398; Wed,  3 Apr 2024 17:34:18 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF616881B7
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F26313F204
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712158456;
 bh=mo3VFDcKNdDYlcZGV1PA1sltfb2Uqb5WZgMJ2xY1Nq8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Kdihtt5rKpQPqK32VSEvFmhBtPPs0dahxDNdTn6jenuGYPIt/9c0E1Bdphl15/jDs
 PrJawSfFTtfXeWjAnEKikWiNnffirAa1AKJ78e0EK4NBxsi5mR1vLIdWCpbVuPl1OJ
 5LEvUOAUI11kyNOTCrW1A6wEwIZ4uuOtqFYfPsvdjx1RMXZ8K3MqP3EQl03I/bRUWH
 wWtYFXKu6DELT9wCmaQJinPCH0FeVVC79DxZ1bgDa0hD/pG33Uf45aSLv4iYRurfW6
 HBK7BExDYE4L96g1xy8zApnszkMZ9DmDxI6w/FyX0fVihoPW1plMiDO7rNQp/XaE8X
 qyyFtk9BcV5Pw==
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d478badf3cso53910191fa.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 08:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712158455; x=1712763255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mo3VFDcKNdDYlcZGV1PA1sltfb2Uqb5WZgMJ2xY1Nq8=;
 b=tklRl5Lt6U75ilq4vzl5pLsKEZmEs1npv2Rdr+4BalD0nFdO1gi1if2PMmhpVlWKgc
 lfhprOtkkTq1+YEO8Vv8X3MRYRtvk9UUAkudQ4Oj23f+zfYVeWHju0zcr0QIci3jp4t1
 tFjo2OSB5vgqSplYVcmUIVNqwY/l8mB0dFcdcCkYTo/YiOZtSRbtwbZVrzhcgtSDNiEq
 j9qLQC/lyD7zpQQhg2Ddg/LqKksohdAsjGjNrXUxQB+VHkk9uxcBZK3g/OE/vvWuL99p
 b65S1INVgvvOwnT4g+3EkmAsVcVp2nG0/+04aAzB6Rrd6DJrp5mifJAZCHltnGMjKqfZ
 EBGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ceyP6mys6e0aEXutWiLx3XNOK2/wmrIFt0cF3k1Sybap1qd81JqMDpuIEiA/H4jfdmEb7i8EJflNtE3i3kyHj2FhJQ==
X-Gm-Message-State: AOJu0Yx2n6s6/cjJn9k1j3qDUuZ9U5qTd5wHpN4dNThoICYGaDWhCO8S
 jM7i9TS5jTNdXE8Cxqnaow2wHqyI/TpplOUFTLO9ikowAA7DUAwGhwgNLLCwTRGWLbwtYwaQ5Ek
 a3A7NWwRTsj2pVN4U2WkkrSbkn282JZS7Us0bl3WRWs981G2qB486JMzdi1GWgbvVkh4=
X-Received: by 2002:a2e:a264:0:b0:2d4:2b05:a671 with SMTP id
 k4-20020a2ea264000000b002d42b05a671mr8901616ljm.32.1712158455210; 
 Wed, 03 Apr 2024 08:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES65ItbQSDMmtKobJ/fi72L4FFIXNDInhKeN8NiYZ6UgSAkcMN8DKn10XlJOvJ/utjHgZoNw==
X-Received: by 2002:a2e:a264:0:b0:2d4:2b05:a671 with SMTP id
 k4-20020a2ea264000000b002d42b05a671mr8901604ljm.32.1712158454812; 
 Wed, 03 Apr 2024 08:34:14 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 cs2-20020a056000088200b003418016b04csm17585710wrb.76.2024.04.03.08.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:34:14 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] efi_loader: all variable attributes are 32bit
Date: Wed,  3 Apr 2024 17:33:33 +0200
Message-ID: <20240403153335.96971-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
References: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
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

GetVariable() and SetVariable() use an uint32_t value for attributes.
The UEFI specification defines the related constants as 32bit.

Add the missing EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS constant.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi.h                   | 15 ++++++++-------
 lib/efi_loader/efi_var_common.c |  2 +-
 lib/efi_loader/efi_variable.c   |  4 ++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index f0e5faa7549..62cfb993d2e 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -492,13 +492,14 @@ extern char _binary_u_boot_bin_start[], _binary_u_boot_bin_end[];
 /*
  * Variable Attributes
  */
-#define EFI_VARIABLE_NON_VOLATILE       0x0000000000000001
-#define EFI_VARIABLE_BOOTSERVICE_ACCESS 0x0000000000000002
-#define EFI_VARIABLE_RUNTIME_ACCESS     0x0000000000000004
-#define EFI_VARIABLE_HARDWARE_ERROR_RECORD 0x0000000000000008
-#define EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS 0x0000000000000010
-#define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS 0x0000000000000020
-#define EFI_VARIABLE_APPEND_WRITE	0x0000000000000040
+#define EFI_VARIABLE_NON_VOLATILE				0x00000001
+#define EFI_VARIABLE_BOOTSERVICE_ACCESS				0x00000002
+#define EFI_VARIABLE_RUNTIME_ACCESS				0x00000004
+#define EFI_VARIABLE_HARDWARE_ERROR_RECORD			0x00000008
+#define EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS			0x00000010
+#define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS	0x00000020
+#define EFI_VARIABLE_APPEND_WRITE				0x00000040
+#define EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS		0x00000080
 
 #define EFI_VARIABLE_MASK	(EFI_VARIABLE_NON_VOLATILE | \
 				EFI_VARIABLE_BOOTSERVICE_ACCESS | \
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index d528747f3fb..16b2c3d4882 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -99,7 +99,7 @@ efi_status_t EFIAPI efi_set_variable(u16 *variable_name,
 		  data_size, data);
 
 	/* Make sure that the EFI_VARIABLE_READ_ONLY flag is not set */
-	if (attributes & ~(u32)EFI_VARIABLE_MASK)
+	if (attributes & ~EFI_VARIABLE_MASK)
 		ret = EFI_INVALID_PARAMETER;
 	else
 		ret = efi_set_variable_int(variable_name, vendor, attributes,
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 40f7a0fb10d..efe17d98f5a 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -259,7 +259,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	/* check if a variable exists */
 	var = efi_var_mem_find(vendor, variable_name, NULL);
 	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
-	attributes &= ~(u32)EFI_VARIABLE_APPEND_WRITE;
+	attributes &= ~EFI_VARIABLE_APPEND_WRITE;
 	delete = !append && (!data_size || !attributes);
 
 	/* check attributes */
@@ -384,7 +384,7 @@ efi_status_t efi_query_variable_info_int(u32 attributes,
 	    EFI_VARIABLE_RUNTIME_ACCESS)
 		return EFI_INVALID_PARAMETER;
 
-	if (attributes & ~(u32)EFI_VARIABLE_MASK)
+	if (attributes & ~EFI_VARIABLE_MASK)
 		return EFI_INVALID_PARAMETER;
 
 	*maximum_variable_storage_size = EFI_VAR_BUF_SIZE -
-- 
2.43.0

