Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88B2F53D81
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068528419C;
	Mon, 16 Mar 2026 19:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="KRPlzYeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0853A8418A; Mon, 16 Mar 2026 19:15:26 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70BE784180
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40438e0cba6so3079257fac.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684922; x=1774289722;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Esu6ERmzbygtJcyO4fiGkRDsuHWu6bKS1fEOHWmufZQ=;
 b=KRPlzYeCmunOxeBuYjkapN7g6jJEgogdcNjibZiK5Deotjm7EBte2qwWF1k2kV/4m3
 gdMYO+OGEH//o+G/P7aKtQcRTcEp1C9AiCaMtih3BQsnITy+Z+btj0dniUva76pwZkjC
 +d3EsJm81mzucvLN9uuT+3dzxc2e1zbTfP2sTHf8G//IqcFpnC9w/4b7x+21OSiCq+OL
 UOmOHurJhfNrUwFyXhIoRmEsjDeRh+KaZCaleev8/+LuPGWqI/asitmhORm6XMqB9+UP
 nG1d/ZSDah8lOmU5oltZNckAOweSKX5H49ruLOkxrPWsT7wW9Uq0xpGW0jiKSL3uMprc
 AfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684922; x=1774289722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Esu6ERmzbygtJcyO4fiGkRDsuHWu6bKS1fEOHWmufZQ=;
 b=NaWHAfwvebEkp0GoAkUGMMhX6CKCpFurEzWZqF5zKzotOp8pdXgO2+X/1B9ljzx4xR
 iSeX3/+efUbOXoySmbeVT7LHomRLjP+FWTCG8bMYIKCtHaINR5SKL/66RW4rRX3I3e4y
 Ic2JF2gM8G99B1TO2t8dHlOY/7aqYVGduZJpaW/fnHSpKIfklLpJWMunVhh3LxP1d8KA
 jqLUm10qbAE/NCxmYJaetfnvQnuq/xcryHR2/GIhhn9vskO/kLluR1NVCUBEVIhre7+T
 ag3Cn+SsPLsDy0yy/w9+2s6E0XxbkIrhcUTkuXhsguu/qoWEUbjXcyvi4S7nXki0MIl2
 FkBg==
X-Gm-Message-State: AOJu0Yy8B8ANaqwEiuJfprEig2+v/5pLqM5IW11+BoaVf9LwFHZgypKj
 C2ogZF2QKOYHb5QWiWagTQf4HQgQSbA1Lpoyls/pf/94LCBOZEPvk4RheUvbY0NdeUtRUCRZGlp
 YTXWs0gs=
X-Gm-Gg: ATEYQzytr4ZJzD67vvsTvPuLt8jyM9xNAB/jcgiCFAh5LPmPsGRTFaSHFUAdhdM1F4x
 St8Y67PjE0dIuzevDnQJI4L36OS94EBkQTxNrCmRoLVDQ1XAwnB5XhPLDnbn0/i2aqcnPK8Rh8r
 7qoNmKZWPDZTeGAMENjFnaXFXAMs8W0h8zucnUxdSDiKNGZRrjtOTrp8hEQU2dnvmjip458dxxY
 T0lt7869z8orCznOo3YSbaQlxy65Xhgttkvp+9OmFIurybSeVbfArGsqE0ztR2INGcjwc7Mf4xl
 +rNF7TONXfZuzIn/p/m15kpMV3ULtz4atJPij1fQKwahURyHY8qQHNDTSg2Ua0QaUD9i7EqeV0s
 9Wk5FBRhqPo0xMS0DjulzI4kfDlBCvR0DSSn1OmCJkIIq04ba55jNq35PCZtNncFWx8Q0l+4S6+
 jiUDJ4+QdIvy8aYNR15crPyQ==
X-Received: by 2002:a05:6870:3b8e:b0:417:22c9:a311 with SMTP id
 586e51a60fabf-417b902ecbcmr8568439fac.6.1773684921498; 
 Mon, 16 Mar 2026 11:15:21 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e1fb6efsm18378343fac.3.2026.03.16.11.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:20 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 02/12]
 include: add byteorder macro guards and SHA384 hash wrapper
Date: Mon, 16 Mar 2026 11:14:31 -0700
Message-ID: <20260316181447.2986278-3-david@wolfssl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316181447.2986278-1-david@wolfssl.com>
References: <20260316181447.2986278-1-david@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:09 +0100
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

Add #ifndef guards around cpu_to_beXX / beXX_to_cpu macro definitions
in include/linux/byteorder/generic.h. wolfTPM, wolfCrypt, and U-Boot
all define these macros; the guards prevent redefinition warnings when
wolfTPM headers are included alongside U-Boot headers.

Add #include <linux/types.h> to include/hash.h so that basic types
(u8, u32, etc.) are available to all includers.

Add a wc_Sha384Hash() wrapper declaration in include/hash.h, gated
by WOLFTPM2_NO_WOLFCRYPT. When wolfTPM is built without wolfCrypt,
this wrapper provides SHA-384 hashing via U-Boot's hash subsystem,
which is needed for Infineon TPM firmware update manifest validation.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 include/hash.h                    | 18 ++++++++++++++++++
 include/linux/byteorder/generic.h | 31 +++++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 6 deletions(-)

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
diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index bee0ff60336..def601eed2b 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -89,12 +89,6 @@
 #define le32_to_cpu __le32_to_cpu
 #define cpu_to_le16 __cpu_to_le16
 #define le16_to_cpu __le16_to_cpu
-#define cpu_to_be64 __cpu_to_be64
-#define be64_to_cpu __be64_to_cpu
-#define cpu_to_be32 __cpu_to_be32
-#define be32_to_cpu __be32_to_cpu
-#define cpu_to_be16 __cpu_to_be16
-#define be16_to_cpu __be16_to_cpu
 #define cpu_to_le64p __cpu_to_le64p
 #define le64_to_cpup __le64_to_cpup
 #define cpu_to_le32p __cpu_to_le32p
@@ -120,6 +114,31 @@
 #define cpu_to_be16s __cpu_to_be16s
 #define be16_to_cpus __be16_to_cpus
 
+/*
+ * Check if byte-order functions are already defined by the system:
+ * wolfTPM, wolfCrypt, and U-boot all define these functions, so
+ * we need to check if they are already defined before defining
+ * them again.
+ */
+#ifndef cpu_to_be16
+#define cpu_to_be16 __cpu_to_be16
+#endif
+#ifndef cpu_to_be32
+#define cpu_to_be32 __cpu_to_be32
+#endif
+#ifndef cpu_to_be64
+#define cpu_to_be64 __cpu_to_be64
+#endif
+#ifndef be16_to_cpu
+#define be16_to_cpu __be16_to_cpu
+#endif
+#ifndef be32_to_cpu
+#define be32_to_cpu __be32_to_cpu
+#endif
+#ifndef be64_to_cpu
+#define be64_to_cpu __be64_to_cpu
+#endif
+
 /*
  * They have to be macros in order to do the constant folding
  * correctly - if the argument passed into a inline function
-- 
2.43.0

