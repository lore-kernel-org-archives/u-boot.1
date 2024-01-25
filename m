Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C081BC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 08:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12A3887134;
	Thu, 25 Jan 2024 09:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ugAUNTDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D8D870E3; Thu, 25 Jan 2024 09:38:30 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2864486FB2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 09:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8A08140031; 
 Thu, 25 Jan 2024 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706171906;
 bh=wHtbBZnsKVcNP3kz6L/Y60lpQATe6DoHY+Wnx5pwpsg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ugAUNTDMbgxxQjSu3Lmvrt9/vLjsxFY3klEe7xy675o2rBao3YftvkjkbmRm4PyWo
 OMxgVzAufuWbo0c9vYlgjADxcw1aoQZfUzS44numodsxEkBtGc0Wop9YwdTrrhb/AG
 f37bX2oTxiYD/qCYsCjJbn1tmDcall5jDyLRpJZZRVC5KRmepLEtoRndNWKkRchTUt
 gfTllODSTbtmYdzCbv2MgI/bScwJEjNgXtZSXHzOI8iTQein7/sy7pJFF5IEehjN+2
 wpzLHZ71RqqNr4zduvX6V0LKg+iGsZuQAd63QFJE7nEbiz9mcMmAbtq7oVckl5XSrs
 j0kLIC2JB0RsQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/3] riscv: page align EFI binary section
Date: Thu, 25 Jan 2024 09:38:14 +0100
Message-ID: <20240125083815.12623-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125083815.12623-1-heinrich.schuchardt@canonical.com>
References: <20240125083815.12623-1-heinrich.schuchardt@canonical.com>
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

Change the alignment of the relocation code in EFI binaries to match page
boundaries.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	split patches
---
 arch/riscv/lib/crt0_riscv_efi.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv_efi.S
index 793eefdd883..ffe18fa387b 100644
--- a/arch/riscv/lib/crt0_riscv_efi.S
+++ b/arch/riscv/lib/crt0_riscv_efi.S
@@ -155,7 +155,7 @@ section_table:
 	.short	0		/* NumberOfLineNumbers  (0 for executables) */
 	.long	0xe0500020	/* Characteristics (section flags) */
 
-	.align	9
+	.align		12
 _start:
 	addi		sp, sp, -(SIZE_LONG * 3)
 	SAVE_LONG(a0, 0)
-- 
2.43.0

