Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD471C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033258305C;
	Tue,  8 Jul 2025 13:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GNmy3STM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083B4830B4; Tue,  8 Jul 2025 13:14:52 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C3B83043
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B2273F633
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 11:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751973289;
 bh=KUOZ2MgUOJBGSO7S72g0ovbpFLh5lwgWQ9LjVqfl8v4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GNmy3STMk7cjyqtRpDPVx/QwVFvmDVQm5sYBN1intymBDBbKGfrktB+FSNUn953Ms
 w5SKDfjy/KjLtg/TM5lsP4aqpyL7EgbWyXMg5/uCeGXu5nxR2XYS/j3F3PVUkJmriR
 Q5FSi8AcCrP8Tj1cOwYT2JVzW6Wxe0vPDQlnhj0tET+PmtdrO96tEV/796TKej7KpR
 I+NUEg51DO55IwcBZIrR61ic2284c+RIwSgE1fv9AwK5FNp8d2WohjAHAx4zI5PJDy
 yM/4dEQgxBhKvZwYliBpm3txZZKSsSbvBDNNydiiuAWFESDUccNAkkW2aYWYJrzjLG
 vxTsrNEJ5tCrg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso30247795e9.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751973289; x=1752578089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KUOZ2MgUOJBGSO7S72g0ovbpFLh5lwgWQ9LjVqfl8v4=;
 b=HnFu98cmrO8daX5Qn01bW4GOACfI87nwYY2rmA+6ii/xiQLLXyM+AP3rhkvJ75FdGI
 zwZmZ/bciuUrCNLOVIsCcbK2QfL7Q9uYFJc+Jc35jJK08Vk9KNmPoSAB/ys3RWY26eBy
 uwZTOQ5HMMxbNigbXA50QWwiclDNxmj5S/OessY2Ph100OSMH8VrCLgzpw24CIwjhdfW
 0Oxx4J/FtvkB+QgCn4YAondcnheGe3u82FSsQDXoKAAwHrJKtCL9O/evW5qSOmPTgm4f
 c64hZWV4KR+jn/lur+3gXON7oPnSnpTlrJCuBUzPaWFSdJesErHv1NfPKt6E91E09yfK
 z+1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ZSO+fZJdITRceDrIIju01Q946MgZr6I+zFxrmDW0WVXXradaLKGrkOjGEbuc3mKSoxU9anY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9n79iAknLZG+hh0CI0ypRSO5kfb+0hYam5KYFUQZMlc+6coQv
 lN2ahvbgkJZOaNi4UQrXWulV4ld7dYvT+KjOWmLU/u0yp4ot2pX13IQX428ZAGwL6f3Uc4pOhKU
 ck8kTFF06iL7Q9XargZSbnm8CAqOXuEcQREF+BoH5jBSsm1XSdWgFMeV6MGTNPhfJNjgGMIg=
X-Gm-Gg: ASbGncsyuf81+1ToH7juwgbar3gC6v60LiVPlhAvYqDAQGKzhGMQJQWxaVdsrTUCzRU
 gPxJ0aXhvUejFsxfXaCROtCL+UWMoBkzWV7+O4gz9BdnNSNHJoWnkJGsJgd+hDUibXhX4nHFcA9
 g1BzqrJBKliNZkC7nlSga7L6x+BHEfrG31r+GhaoiaqGePgIepec4DKYEvd5gKQS2r+5s1TPfV9
 ZLclzAHwh2bA7eQKLzdo9Q4b43/nGX5JULHMcouP9TMpOrGVkt1I1P1g708u95YUxm0ej0tDBWC
 hH1RNPtQSyAbHUo3/IezTP7ZvezNZv/jnL/SQMFi5E24pYEB3e3H+zIn0QrpUuX00pIggNZQbKg
 3o5bBSOblSMVqn9V7nQLKvf3R
X-Received: by 2002:a05:600c:8b64:b0:43c:fdbe:4398 with SMTP id
 5b1f17b1804b1-454b4e6e641mr127626015e9.6.1751973289073; 
 Tue, 08 Jul 2025 04:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMEIVKaFmNODlUexUHY7R81RwGfMlnuhHxV1DtSyd2jRKo2OdlbTLDGLhTC3qltiY7EozQQQ==
X-Received: by 2002:a05:600c:8b64:b0:43c:fdbe:4398 with SMTP id
 5b1f17b1804b1-454b4e6e641mr127625785e9.6.1751973288689; 
 Tue, 08 Jul 2025 04:14:48 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b470e928aesm12484706f8f.44.2025.07.08.04.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:14:47 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: correct EFI_DEBUG_TABLE_ENTRY_SIZE
Date: Tue,  8 Jul 2025 13:14:35 +0200
Message-ID: <20250708111435.40515-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

With the current code we allocate to little memory when adding entries to
the EFI_DEBUG_INFO_TABLE and we fail to correctly move entries when an
entry is removed.

EFI_DEBUG_TABLE_ENTRY_SIZE must be the size of an entry in the
EFI_DEBUG_INFO_TABLE, not the size of a pointer.

Fixes: 146546138af5 ("efi: add EFI_DEBUG_IMAGE_INFO for debug")
Addresses-Coverity-ID: CID 569498: Code maintainability issues (SIZEOF_MISMATCH)
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_debug_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
index 186bdbce750..490b0bb7088 100644
--- a/lib/efi_loader/efi_debug_support.c
+++ b/lib/efi_loader/efi_debug_support.c
@@ -22,7 +22,7 @@ struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
  */
 static u32 efi_m_max_table_entries;
 
-#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(union efi_debug_image_info *))
+#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(union efi_debug_image_info))
 
 /**
  * efi_initialize_system_table_pointer() - Initialize system table pointer
-- 
2.48.1

