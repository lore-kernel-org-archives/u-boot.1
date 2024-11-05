Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB590D1CA15
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 04:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66D188F77;
	Tue,  5 Nov 2024 05:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oNPMFf0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7424B88F77; Tue,  5 Nov 2024 05:20:53 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B3C88ECC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 05:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DD97740278; 
 Tue,  5 Nov 2024 04:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730780450;
 bh=dOb7T3VaSJkE9G45Waopw9Y83FWlGWEzUdOGE7298pQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=oNPMFf0MOoULaeFqyFrYTMAkTtAIE8RvilSPDXHG1EnTplkwU7Y3qGA5aNmH9zm/Z
 aEpILTXKJxU46F3dQ2gQzB0nm586AjfatsbxUEKsefXaNqNM6PKprPdL30LSiiBmYs
 zCla6nlGESWYnIJCrL4zugMunkuhw/USxcEWK6Ldu+C5cqExEVB8V1aRoe9kYDHGm2
 aPLsK2BYHlaUeMA+ofGibLhlpOymeOKNY8tpnjDaJy1bADGihVy7pk3B6KkqQIcUZp
 jvPp1CuNk4dJFYK+ZzZjdudqGg+op6HEpm8VOG6W9kUDfDTz2G9+MG8lI7nc/C3810
 9Dkr4KSb3Exew==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>, Raymond Mao <raymond.mao@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: simplify efi_tcg2_hash_log_extend_event()
Date: Tue,  5 Nov 2024 05:20:45 +0100
Message-ID: <20241105042045.36435-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The value of variable nt is never used. Just use NULL when calling
efi_check_pe().

The API function is not expected to write to the console. Such output might
have unwanted side effects on the screen layout of an EFI application.

Leave error handling to the caller.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_tcg2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 866a529857e..572c6b5bf63 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -607,12 +607,9 @@ efi_tcg2_hash_log_extend_event(struct efi_tcg2_protocol *this, u64 flags,
 	 * Format"
 	 */
 	if (flags & PE_COFF_IMAGE) {
-		IMAGE_NT_HEADERS32 *nt;
-
 		ret = efi_check_pe((void *)(uintptr_t)data_to_hash,
-				   data_to_hash_len, (void **)&nt);
+				   data_to_hash_len, NULL);
 		if (ret != EFI_SUCCESS) {
-			log_err("Not a valid PE-COFF file\n");
 			ret = EFI_UNSUPPORTED;
 			goto out;
 		}
-- 
2.45.2

