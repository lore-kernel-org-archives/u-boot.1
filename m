Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC3BC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE1988629;
	Mon, 10 Jun 2024 18:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480898863B; Mon, 10 Jun 2024 18:09:39 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61EA288626
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VycFY0yZszrrR;
 Mon, 10 Jun 2024 18:09:37 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VycFT5hC1z1Kw; Mon, 10 Jun 2024 18:09:33 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 18:09:14 +0200
Subject: [PATCH 2/4] dm: core: fix signedness in debug messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-misc-20240610-v1-2-6914f1725dd4@cherry.de>
References: <20240610-misc-20240610-v1-0-6914f1725dd4@cherry.de>
In-Reply-To: <20240610-misc-20240610-v1-0-6914f1725dd4@cherry.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dario Binacchi <dariobin@libero.it>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

outp always point to an unsigned type in ofnode_read_u* functions but
the format specifier is currently always using signed type.

This is an issue since the signed type can only contain half of the
unsigned type values above 0.

However, this now breaks another usecase. Indeed,
ofnode_read_s32_default is actually passing an s32 but it'll be printed
as a u32 instead. But since the function is called u32, it makes more
sense to have it print an unsigned value.

This was discovered because arm,smc-id = <0x82000010>; on RK3588S is
above the max signed value and therefore would return a negative signed
decimal value instead of its proper unsigned one.

Fixes: fa12dfa08a7b ("dm: core: support reading a single indexed u64 value")
Fixes: 4bb7075c830c ("dm: core: support reading a single indexed u32 value")
Fixes: 7e5196c409f1 ("dm: core: Add ofnode function to read a 64-bit int")
Fixes: 9e51204527dc ("dm: core: Add operations on device tree references")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/core/ofnode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 9a5eaaa4d13..9ff46460e7d 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -326,7 +326,7 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
 		return -EINVAL;
 	}
 	*outp = *cell;
-	debug("%#x (%d)\n", *outp, *outp);
+	debug("%#x (%u)\n", *outp, *outp);
 
 	return 0;
 }
@@ -357,7 +357,7 @@ int ofnode_read_u16(ofnode node, const char *propname, u16 *outp)
 		return -EINVAL;
 	}
 	*outp = be16_to_cpup(cell);
-	debug("%#x (%d)\n", *outp, *outp);
+	debug("%#x (%u)\n", *outp, *outp);
 
 	return 0;
 }
@@ -409,7 +409,7 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 	}
 
 	*outp = fdt32_to_cpu(cell[index]);
-	debug("%#x (%d)\n", *outp, *outp);
+	debug("%#x (%u)\n", *outp, *outp);
 
 	return 0;
 }
@@ -439,7 +439,7 @@ int ofnode_read_u64_index(ofnode node, const char *propname, int index,
 	}
 
 	*outp = fdt64_to_cpu(cell[index]);
-	debug("%#llx (%lld)\n", *outp, *outp);
+	debug("%#llx (%llu)\n", *outp, *outp);
 
 	return 0;
 }
@@ -479,7 +479,7 @@ int ofnode_read_u64(ofnode node, const char *propname, u64 *outp)
 		return -EINVAL;
 	}
 	*outp = fdt64_to_cpu(cell[0]);
-	debug("%#llx (%lld)\n", (unsigned long long)*outp,
+	debug("%#llx (%llu)\n", (unsigned long long)*outp,
 	      (unsigned long long)*outp);
 
 	return 0;

-- 
2.45.2

