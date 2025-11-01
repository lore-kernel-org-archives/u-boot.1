Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8091ECCF9F8
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D55B183A97;
	Sat,  1 Nov 2025 07:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="QWrFJzmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA0983AA7; Sat,  1 Nov 2025 07:49:26 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE7183A27
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA8E1109800; Sat,  1 Nov 2025 07:49:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761979763; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=eh2MkZ/FmbcUatBhmRITheSMTVYCXZT/7ddEQrgwxPE=;
 b=QWrFJzmiAmcN3px7uYWXJvntuImWgo0d0SLfh/NoJ48rAlr0/iyq3hibDCVrkVXWgJ47go
 Xeg4WoTRFTKCrGRbSYr1bvC1ND3ZmcQK7bAj3n+WauAJI8dUC05xdMt9RNgVmULsGEJ4JY
 FrqIe3n+Ve4IoNaZYmGYzuFvrlOJOyfS6FAIqH3P5gKgm3+wyo5QUo1SAQNFW9DI1fcBn6
 eXJMZfLKBmW3jcD4KucIwEFsbxrxHMUBjxHLA7wpmKNOu/10mHDSSj54haoguzwPnLTOZR
 4E0/uWgrajD0SFOFk5gi8rWQ4KEeu6Nz7mk0wzier+IdtZBg55rmrxwBwBuf3Q==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/5] lib: Import rol32 function from Linux
Date: Sat,  1 Nov 2025 07:49:03 +0100
Message-Id: <20251101064907.5037-2-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251101064907.5037-1-hs@nabladev.com>
References: <20251101064907.5037-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

sm3 crypto algorithm uses rol32 function from linux, so
import it. Linux base is commit:
ca91b9500108:("Merge tag 'v6.15-rc4-ksmbd-server-fixes' of git://git.samba.org/ksmbd")

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 include/linux/bitops.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index f826d7f3b34..29e0da48de8 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -148,6 +148,17 @@ static inline unsigned long hweight_long(unsigned long w)
 	return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
 }
 
+/**
+ * rol32 - rotate a 32-bit value left
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+
+static inline __u32 rol32(__u32 word, unsigned int shift)
+{
+	return (word << (shift & 31)) | (word >> ((-shift) & 31));
+}
+
 #include <asm/bitops.h>
 
 /* linux/include/asm-generic/bitops/non-atomic.h */
-- 
2.20.1

