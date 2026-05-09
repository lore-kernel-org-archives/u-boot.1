Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DABCD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7697084E0F;
	Sat,  9 May 2026 02:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="HtVlSYbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E6A84E10; Sat,  9 May 2026 02:04:41 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F8984E0F
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-12dfee30612so2765172c88.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285077; x=1778889877;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oYLp3f1IsPX2hpfA/74waJEp3AA/OTaPMkuXAV8i2k=;
 b=HtVlSYbhgbm7SK3/BNax0MJ5j9DWTOMQuBQpV52Y482RwTMuIQwnGcfX1hmcDidHe8
 HZ8NSuw1WEGb68o+NPmUb6GCfcA85cWjHmd/u/jOivvjz6Kye2bH8cuPrCjaMv+vihgR
 fZjwaSyFX3pWJnojPL0ub6aF+LbzYYtyCIyfLzVT/7X8N2C1g+HKGc95vwRhyoFbPnQH
 FxczxFvoggVObnx53vpMAkz5rL9W4erxyD/Yvgfd+J5qRhbl93Nu4AFy5BfTr8RWObN/
 q2sdaiYUSft5t+Nhi7HRHxF85GSDEiRvAcRNniVRAeLixMxFixLNjfwTwBzH5m7vnuBF
 1+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285077; x=1778889877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7oYLp3f1IsPX2hpfA/74waJEp3AA/OTaPMkuXAV8i2k=;
 b=ZYVdDrBZrAn1sm0sIGkv5vTt34K1P2fSY7PwQyUGM3pO8VMCXCSYtX9U34Sz1HkO6w
 KqE9SaKQxk65SzcVRujZU9+Hv9mzLKX8c3+UE5Ex+NCGrDXsyuAQ4Esb+hF1NKiKboK+
 vS+qdciD8kmcGbUkX+ZsRDzV3vNkSTsm8WkXDi6YNXgDGIWdFxISficsEK+AVtjKKKAC
 gV9w/zwszs8murhQsgFm9tBJP0pUOn1NEyKW/+11tCsyj9L2G3+u1MoYOi1HqHwhpobK
 QGzBhlpIpF7XQRyGzyg29J7Jg6i4VtrPKPqxvr8aFgkbgHCh4kUE923w/wmkltSmsqz9
 mPfQ==
X-Gm-Message-State: AOJu0YxudiI6hmJrd4L7nhsnqJkIAPWrlvQDiaRBopG/+MQORW03AcbR
 aq88sSZZmDkR600nxy3u7ucOpD0FoYcA3z3GjeNCk3qVPNTfJ/DBr6kQbXmrI/fG9rgPEhpGQEq
 Yv1Y/
X-Gm-Gg: AeBDievkg/QsocJaCglDumcf9EAQ+D6MMtrqZMzSBeev4YXr7uGdufhvEHXDKRAlO7h
 iLONx1w6/ZTOO26y/+DrPc9byh0yT8w1M/xglPLZ5VyDTqoO5BckOo0pp0dQxCB5HrmH/EcfvrV
 YzbgQvHLBUjtX7ON9ETiuVNV2zMHMOR05elpG535pGbOoaclRNDtrPuD0mJ8tcscs5kdk8ttyhn
 ioRU/Wf45Vely6aKuOu6kSCnOUPzw3ClNOmzamYTiHLuP84Wvi/fqg6V2ne1bdW2AcN9bmez6eN
 SvSlduv8uUSlelTZBNVCJJ8cqvWJ0oVqCscAIznGmhVVsEfEbl9xsVnZCYfCO/jJKNm5YA7p+tW
 pMHo3ntUIwZYJBjTif9XP3kP1sLBC7faB/YXvj1CcK84pQ+WYToMpqq+dzzEVgFQ8+PFXzY4eSQ
 6wPagMJMg4BXE518CVwXVFGMTYaQHcrwKa/q+r+D1WMK7UJhcQ/JON+4TkbvhNaaUXDMKl/cbAk
 8bRncvlnmBOGUdjI8vYVSys7UWXNExoHyIr0ZUyxBs=
X-Received: by 2002:a05:7022:43:b0:12d:ce34:3f92 with SMTP id
 a92af1059eb24-13271c9c8c3mr2961062c88.31.1778285077112; 
 Fri, 08 May 2026 17:04:37 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:36 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 02/12] include/hash: add SHA384 hash wrapper declaration
 for wolfTPM
Date: Fri,  8 May 2026 17:04:09 -0700
Message-ID: <4da58a8d6167bec497935d67000d07b84de19146.1778277334.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778277334.git.aidan@wolfssl.com>
References: <cover.1778277334.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:11 +0200
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

From: Aidan <aidan@wolfssl.com>

Add #include <linux/types.h> to include/hash.h so that basic types
(u8, u32, etc.) are available to all includers.

Add a wc_Sha384Hash() wrapper declaration in include/hash.h, gated
by WOLFTPM2_NO_WOLFCRYPT. When wolfTPM is built without wolfCrypt,
this wrapper provides SHA-384 hashing via U-Boot's hash subsystem,
which is needed for Infineon TPM firmware update manifest validation.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 include/hash.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/hash.h b/include/hash.h
index 8b3f79ec473..26043c43a9c 100644
--- a/include/hash.h
+++ b/include/hash.h
@@ -6,6 +6,8 @@
 #ifndef _HASH_H
 #define _HASH_H
 
+#include <linux/types.h>
+
 #ifdef USE_HOSTCC
 #include <linux/kconfig.h>
 #endif
@@ -163,4 +165,20 @@ int hash_progressive_lookup_algo(const char *algo_name,
  */
 int hash_parse_string(const char *algo_name, const char *str, uint8_t *result);
 
+#ifdef WOLFTPM2_NO_WOLFCRYPT
+/**
+ * wc_Sha384Hash() - Calculate SHA384 hash
+ * @data:	Data to hash
+ * @len:	Length of data
+ * @hash:	Output buffer for hash
+ *
+ * This is a wrapper function to provide wolfCrypt-compatible SHA384 hashing
+ * when wolfCrypt is not available.
+ *
+ * Return: 0 on success, -1 on error
+ */
+int wc_Sha384Hash(const unsigned char *data, unsigned int len,
+		  unsigned char *hash);
+#endif /* WOLFTPM2_NO_WOLFCRYPT */
+
 #endif
-- 
2.47.3

