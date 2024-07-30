Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9C4C3DA7E
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 11:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC768882F;
	Tue, 30 Jul 2024 13:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025118881D; Tue, 30 Jul 2024 13:12:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 10A978780A
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 13:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01B6B1007;
 Tue, 30 Jul 2024 04:12:25 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC88F3F5A1;
 Tue, 30 Jul 2024 04:11:57 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 3/5] efi_memory: avoid possible null pointer dereference
Date: Tue, 30 Jul 2024 16:41:30 +0530
Message-Id: <20240730111132.1097315-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
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

Populate the previous memory descriptor node pointer only after it's
parent struct has been initialised. The compiler fixes this logic to
do the right thing, but it is better to have correct code in place.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/efi_loader/efi_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index bfadd6bd41..8d4f6e339d 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -138,7 +138,7 @@ static void efi_mem_sort(void)
 		merge_again = false;
 		list_for_each(lhandle, &efi_mem) {
 			struct efi_mem_list *lmem;
-			struct efi_mem_desc *prev = &prevmem->desc;
+			struct efi_mem_desc *prev;
 			struct efi_mem_desc *cur;
 			uint64_t pages;
 
@@ -149,6 +149,7 @@ static void efi_mem_sort(void)
 			}
 
 			cur = &lmem->desc;
+			prev = &prevmem->desc;
 
 			if ((desc_get_end(cur) == prev->physical_start) &&
 			    (prev->type == cur->type) &&
-- 
2.34.1

