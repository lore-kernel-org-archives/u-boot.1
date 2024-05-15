Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6956AC25B79
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C478F88266;
	Wed, 15 May 2024 14:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SJPBY8VL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D0F8826D; Wed, 15 May 2024 14:33:15 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2458088250
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34db6a29a1eso5372414f8f.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715776392; x=1716381192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XjdVTV/76FcCAKo/nqu5PCdfs4U07Vo+hgb69Fpqfw=;
 b=SJPBY8VLDKev+GRJKMO8zl32ebRMMr0eoX3Y0S6QTqAj75jY8lwUbORab/QEMrUpsc
 QeXyuMW2M2K/MkhHfAIWhI+ZuDmTnJ23542wP7HLdHxlCFJ3B+TOx4Ks1jiRQYc+Xjo4
 lHWXRGdlgUrrD4HKufCdwVU3EBMFE3nMWUo2nwp78s5xYBANUN79E2r77l5DRyC2P5fR
 g8jOW4jfkgv06za2Cr4NRRTqO/GCytx84uNtnftUHGgUadyx/XoAaMhdtM9agccqb86S
 fOhnnQ15T47jwdQC3t58yPOTp+q14M3jJh9n5ktm04cH4aDsRk9fRP7pRnILvtvRSQnK
 KpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776392; x=1716381192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XjdVTV/76FcCAKo/nqu5PCdfs4U07Vo+hgb69Fpqfw=;
 b=FbEbYqBZDV/BD6gUcotJGjjV4v30x0OUo7B126jgK/kbHpdJmujPVMDGOo3KgddWwo
 Dx9lH0kU8/cpXQFyueQqZXo+1KRne3A84Zj9Bi1zFhlLl/WHtECmXxE3/91TMIsQSF4x
 inB4QFZOLVsZv9oZ5maKFy7g1jXgWJo2420jdrFyzbcmn8bRc89+i9IrP21DRKyE+QPi
 U6FvjJG2+OBDmAjbEhQ0o6OUk3zIz6mJ0DsIXj2Cgu10MwDtjCrDBPcQQDabtQEVmOII
 WdZP6zaVQlsI+GtylFUFpQQWF+uRlzYiR22q7qZ83yg1qohPpeVqR49xPh1RcK5eRS7e
 o9/w==
X-Gm-Message-State: AOJu0YxgUesaNMjNf7DjaiWQEzkbpu29pLj9AZ9YG6PJArkNMSbg0rE8
 fbaC06bU1qzTU5gnhcKVIatFgHo3CkMeVIrszph2DesFWAP7M4pzP/gb+Vcu5Mr3T2nz32Ex0Je
 B
X-Google-Smtp-Source: AGHT+IGyDmt2bSl5aUDXhLslsgBSXWV39+DfY6j0AwvvhcdPB7Tjpo0npw8FRbPa/mUdGRBL5c+ASQ==
X-Received: by 2002:a5d:4745:0:b0:34d:98eb:4cb with SMTP id
 ffacd0b85a97d-3504a73da3dmr10815843f8f.33.1715776392055; 
 Wed, 15 May 2024 05:33:12 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad042sm16406896f8f.80.2024.05.15.05.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 05:33:11 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Phil Sutter <phil@nwl.cc>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Tony Dinh <mibodhi@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 2/4] efi_loader: remove redundant hash includes
Date: Wed, 15 May 2024 05:31:57 -0700
Message-Id: <20240515123213.1701691-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515123213.1701691-1-raymond.mao@linaro.org>
References: <20240515123213.1701691-1-raymond.mao@linaro.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- None.

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

