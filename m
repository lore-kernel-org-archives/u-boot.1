Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B41CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9850D845E3;
	Wed, 13 May 2026 02:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="vqIitQoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022E0838BB; Wed, 13 May 2026 02:26:33 +0200 (CEST)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF53C800AE
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2ecf9e398f4so2703730eec.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778631989; x=1779236789;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8ZUIf2YpD+pnZT3Z7kRc+eUVkCi+iAIDd1CrCuOfNo=;
 b=vqIitQooUHbHpNEyRFPGR8rPqL0eqCyRiMT2OtNEB5gsaAAbHmWKo0o6ngcNB68EcI
 uBbgxkMQ48HMDXohgsky1cvKcuqB6/hqjpQClERDgwX9YO8nhw+5iDpi/IqLVszUa6zo
 sXFUCnRXnYxPXECSeAuxdrc2OpLZdftk6DlvKRr+PEielfw47GahoDmT+QD8LyLOH4VW
 I+fRB5S4aXZ4LBkMseYoo0ZrjGHJ2dwv2p2rgN29ExKtT7CUGU/7lwNlar9pSlVr8Sz8
 EtrYmRs5bUXVmSlJhUon9ZlCfWco2DJnWbIMZDeFp0cZ180QW1Rw/+IVAZaXcJ2TFLwK
 LvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778631989; x=1779236789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L8ZUIf2YpD+pnZT3Z7kRc+eUVkCi+iAIDd1CrCuOfNo=;
 b=VGVz+stith8rxrAymRvKBPiof/Tsm9T+9pAI2+U3P4chw7bxA3FrAKrnns/DPVwM+6
 JvzoAo+dqB+lCxHmjRLwqlPDBnzkMXVmURCp+jJV8koxyEPfLD5ggPGayoRn4vTSS2HZ
 2U+4w1Je56ggAJroph20LPKv0nG+WgB1RMCGFfotACjw3D2flwMwXxGQMx4OyS14Lt5b
 TkETYoZmhKIyVDCzX4OFX3PwlhWlMghala1Nv+BCV527BgOkWhMPrVAvdlS4boMDmqib
 WcgdkYxNkdgYsmMkvCP8MZrrcUGYkhlwSAmmu2U7hYUDkNcpm1ptWIr6YjP6cw1nOSo6
 w3VA==
X-Gm-Message-State: AOJu0YzbK0k87ghPwEpHOA3cD7OHxnh56pAmObN0HW058dWB4AHnjIc7
 Pbe+tGDc3oVQzhAsDWK5rjAjo9NbOKfXYFMBNeJA6fRIvt8mPJJFYdKKs0TxocvUwTxHPJ3GU5c
 xFYOhoWM=
X-Gm-Gg: Acq92OHAiYrAir/WVq6VKVapdv5sYpd9MThyBrb7M0RPGb5M4wH/plqgJSoLUwDZDb9
 zlWCiNE/f6/4/i+7lfak6hN2MDGoaZf/CefLETQ/NhOJU9tls40c9tihAtfPn21r4Nw/SkbPcwX
 SMR6sMMcEqohSvSL9GUrtbo7X5YGsnM7JdV8+vPwQ/PLp84RrJUjkY7B3P6ybOkL6Uwy1RVIlc+
 gS+zvnxlbScKNCSNidEdQ1fwdox1FiPPbiJQC4wWMYqNEeiUrxVg8eBYuvatstx1O3u1HjQJBUH
 qIcgEVzB6FYWqs4gLxxLqGVA6xnHv9do4dNsF1pX4hurYmQjqfErlDBa20FussGr93EWn97pkwG
 t2jAaaheY5u1CeH3lEzD4WPhHs/xEV3sHBL3ZLDNJHuT96SfG16uxJGuoWltdRA+aF9WxAjLAAy
 cho7eDuSvw7ahFztmEhgeEH4KU1Dt9ccBzxJ4WFe31JrURckR3Fa0FcJSZzfn/1C1DoqWVXxgce
 k/Ox/Y4hD7in4niAu87seoXA6KfykW2
X-Received: by 2002:a05:7301:418a:b0:2d8:df01:d9f7 with SMTP id
 5a478bee46e88-30154598358mr278369eec.15.1778631989082; 
 Tue, 12 May 2026 17:26:29 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:28 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>
Subject: [PATCH v4 02/14] include/hash: add SHA384 hash wrapper declaration
 for wolfTPM
Date: Tue, 12 May 2026 17:26:06 -0700
Message-ID: <20260513002625.76915-2-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:49 +0200
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
2.49.0

