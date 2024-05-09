Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875F3C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E173188025;
	Thu,  9 May 2024 16:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cdBkH1Qh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0FB87FD7; Thu,  9 May 2024 16:38:10 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AEA488131
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-792b934de39so74738985a.3
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 07:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715265487; x=1715870287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpNiCIK4o8aZdGjenooW2bnwj6FEFbdFc9kzbo4v9/E=;
 b=cdBkH1QhZ9WAAiruomDDrGCxsumNafZuu9wXecMAqjpgG4769Fc1QQ6JElG+G1PEyD
 Rpc9SfPhC/EHeeuX9PdBj03iqziMjGZSh3RT7MvHTrOs35O1LktLTPENYOYtEPN5egEI
 myTCUGBmTCpV8F4QPBr7WAl6IXlo9ywgAn7QEcXOuIyXGMJfSC+NyGRm32OMuMSgjxBc
 N/3Hjm4uoa8FDQpE4uA3DHl01Tp+ngWC3iUUrt7K+Bz8U0HiEk/oabZ2+EuyTBa30sch
 ckq1nHYrn+HxS917MwAO5uA+TmKlEuzPK46sjMwYYgfbNExqGfsiqak5/Z7Sg8W9zrF7
 tawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715265487; x=1715870287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpNiCIK4o8aZdGjenooW2bnwj6FEFbdFc9kzbo4v9/E=;
 b=Z7N/py7OcRRHUUizPAiVA2wpFRc/sXWWmDYlFjShKanLhYs6/1Wl7156DJOtCEPRkN
 +J6OmhmyWRlOThWMszQPaIf9tz1q4KZm9Hof+mlkVGjC5XegZ71lkrWFBVO7BXrnD69M
 ld+zNAY7zr18PrH5SSinyA/65icDNSYbJvUz65jQyZg4Df7fqTdzrMArVFXg7uurHxWy
 MjnQr2gDtwnBj5x2z67OUbAh75A09tIR+jDbdGxi7Y8UCGK5eIQQ7ypdkpNyxcf4XO7H
 lpFYlQrcUpRQH9dXZ5suhHsBJ30nDgAmtNsWVG/125xqjxms+PRAN5ZEVz6R3i9xSLtc
 ZUHg==
X-Gm-Message-State: AOJu0Yy7Vgb2N02XXvYuobVwz/lPuywcHw+QyL7t9X5TNr+k+pBVcd9z
 qbbeRbsaFB9u4d9HiOOQnZdtZcXMoHgFVUcapZSg5kTYDFqsjeaScO+aKQbVSvh/N+KjWdFr15y
 P
X-Google-Smtp-Source: AGHT+IFjOfgtgSHGLvQsdQgLQ/HCO1H8O+3FRX6LsecezZHOQEsv8DfPzacEICNnd609li2YKwBD2w==
X-Received: by 2002:a05:620a:8cc:b0:792:c2b5:ca6 with SMTP id
 af79cd13be357-792c2b50dc1mr101034385a.5.1715265486944; 
 Thu, 09 May 2024 07:38:06 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf275b07sm74563685a.24.2024.05.09.07.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:38:06 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/4] efi_loader: remove redundant hash includes
Date: Thu,  9 May 2024 07:37:39 -0700
Message-Id: <20240509143743.1496210-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509143743.1496210-1-raymond.mao@linaro.org>
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
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

Remove the redundant includes of u-boot/sha1.h, u-boot/sha256.h
and u-boot/sha512.h

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/efi_loader/efi_signature.c | 1 -
 lib/efi_loader/efi_tcg2.c      | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index f338e732759..184eac8cddb 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -17,7 +17,6 @@
 #include <linux/oid_registry.h>
 #include <u-boot/hash-checksum.h>
 #include <u-boot/rsa.h>
-#include <u-boot/sha256.h>
 
 const efi_guid_t efi_guid_sha256 = EFI_CERT_SHA256_GUID;
 const efi_guid_t efi_guid_cert_rsa2048 = EFI_CERT_RSA2048_GUID;
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index b07e0099c27..ac056dcfc55 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -19,9 +19,6 @@
 #include <tpm-v2.h>
 #include <tpm_api.h>
 #include <u-boot/hash-checksum.h>
-#include <u-boot/sha1.h>
-#include <u-boot/sha256.h>
-#include <u-boot/sha512.h>
 #include <linux/unaligned/be_byteshift.h>
 #include <linux/unaligned/le_byteshift.h>
 #include <linux/unaligned/generic.h>
-- 
2.25.1

