Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E81CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 22:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765EE83968;
	Tue,  4 Nov 2025 23:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="quWomlj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 065CF83971; Tue,  4 Nov 2025 23:27:19 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12AA483957
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 23:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 77E4C3F92A; 
 Tue,  4 Nov 2025 22:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762295236;
 bh=AdB2L+FgkchgPrTt7s21099MvwAS1TC6TmggjW4Qd0Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=quWomlj0BCSCzBknLewgXVDeZIa/vT32uRniibiqIVGOL/VDn9u0mSf/uSLsAdPVR
 yhIhdCp5/gp0+3Ck0PPKtD+R8Uqz9IlpPXhcmt9G1w6vDOsOiBctZ5B40+qk1IhcR5
 78AZkIr+mPkzQSkHeam+Yr+k08V0qwAO7F2LnSFzQ4so6H9Yc0prbk7Wh2ksHsFoDR
 BfvTnBOj8Jc8cptLIp/9wTZxzrPsIj23Z/bWg8fHKivGXoqu6q7IZOZv8GjUhqUEAa
 TfhI94eq0yzMs0DY1bx8Xa+tWEFKBrz4UPXaggxGqe9u1FNQ35ux1V3GDT0d0IpQSb
 UB5Tp01kjvymigkrjNQSPgkGyEp6je8+RsWxoFBxb2Kl6Jb1O8Vqma46w9osRthYBE
 qpLJ3nrapvGd77/Zh1K4FYRnvg+MPTKLyOcyLQIWEcnfaxkvLG47mQIElAoMQj2+No
 7xSq+D6cuTLcFg6HXWutCfr4U08mLjQHTI+DxnowN7ja0POJ80u4kwVsGTrEqeBry3
 AB3hxP+gKhBvAcc81WRXF8F1EF8OUrCqaoDu8y9zGaw9ApYCass38U0TTdsKJeMUDT
 FK2kAKTThdwNZcGW6sLY1gMF1qhegBlxnDH3S6icYbqrIiZoew8TWnLLbhgdAf3VZu
 TXTlF07M81Lv2gI/D5FPBzV4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_client: efi_store_memory_map() must return int
Date: Tue,  4 Nov 2025 23:27:12 +0100
Message-ID: <20251104222712.47366-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The type efi_status_t is not compatible with the return type int.

Let efi_store_memory_map() return -EFAULT instead of a truncated EFI error
code.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_client/efi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_client/efi.c b/lib/efi_client/efi.c
index bcb34d67465..a3a40b5549d 100644
--- a/lib/efi_client/efi.c
+++ b/lib/efi_client/efi.c
@@ -155,7 +155,7 @@ int efi_store_memory_map(struct efi_priv *priv)
 		putc(' ');
 		printhex2(ret);
 		puts(" No memory map\n");
-		return ret;
+		return -EFAULT;
 	}
 	/*
 	 * Since doing a malloc() may change the memory map and also we want to
@@ -168,7 +168,7 @@ int efi_store_memory_map(struct efi_priv *priv)
 	if (!priv->memmap_desc) {
 		printhex2(ret);
 		puts(" No memory for memory descriptor\n");
-		return ret;
+		return -EFAULT;
 	}
 
 	ret = boot->get_memory_map(&priv->memmap_size, priv->memmap_desc,
@@ -177,7 +177,7 @@ int efi_store_memory_map(struct efi_priv *priv)
 	if (ret) {
 		printhex2(ret);
 		puts(" Can't get memory map\n");
-		return ret;
+		return -EFAULT;
 	}
 
 	return 0;
-- 
2.51.0

