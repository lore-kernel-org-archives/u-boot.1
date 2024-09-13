Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B378BFC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C15E788DE1;
	Sat, 14 Sep 2024 03:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R8PnVcM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5652288706; Fri, 13 Sep 2024 18:10:55 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37476887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c524b4f8b9so9732786d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243852; x=1726848652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aho6+D0tM132Fz7Zd8Pp5XQFzY4C8cNq8zlpszdH+jA=;
 b=R8PnVcM3qh9ibp/fRd59Po1TIxli8JA2H9U9sOEbTJpG+Yg8J/1Z8LdBSYtPKzMYIz
 1UZdmh/90NXDhHpVFGKVjSRldGIAbs2CL3tc+ZqbQpnaSnYKtAf/+1L6jvWt2OvL6uMg
 En8uTrZedHjEOQL0vaYxALBPtwtbyfJsMiCPf9qduTQ1pAa8h1ycqjeLFHvTk2okxPjI
 6FzcyAqZrEITNY8QRPgVIX8ZCwq8M63K4HH1m52JxynBouwkWIU+eVxwFjvrbflxtxVY
 uuoxfQmecF6wuecqcsXOK4oXcvL3M0YK34eSMyJjk5koRTdfoHauggYqnBX7saZL0EzJ
 HFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243852; x=1726848652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aho6+D0tM132Fz7Zd8Pp5XQFzY4C8cNq8zlpszdH+jA=;
 b=EQecmAmpSIwdc58+oJcsgtqVJHfajpiJAmgrMB6mzdCs/9nZdDc2LiVIlDJ8t2CYnG
 axq5EpIWfD4/2tDBOylP7soqIljOLQEtXFub+YL/TvsFrzNkCJ8GwCN7zenjjzW/cpRb
 DIQWjIhoIQ+iH2XeFXcM5f/tnVZ6/DLmytgFXQnfpTxPXs/3t8iDHvQ1VvbZLIHZzuiH
 hH6t7DuHUTBjAWWZ0rZ2Dd0orghz8MsAvHEE0TWvMnXWEE+MAxglFnQp+wCNVkkQBPqS
 IR/hzUSwzXMt+0FcbHS6XFAnCsTEG33jKL5ypknbgLuKPoUe8Vp0q//Sxsn818y5VVXk
 DYyg==
X-Gm-Message-State: AOJu0YwCXLIrFicw4zBaxbOOpigzI/0EP6QHXz7AAos1fyBnuadqd97+
 mXncP8t5XHZ9SA6WUDfIqEq/G444lOWjqUaIy0aaFjqPIF/lwKaaqH/9D7ia5HE445Xe6nzhb+z
 L
X-Google-Smtp-Source: AGHT+IGevIkSQsAjll5oMHmE4CHwdnFxdlImRc8fG0nxr2MUeXT31THU/BxrOgPZuhY1/NaaexN/Gw==
X-Received: by 2002:a0c:f411:0:b0:6c3:5c75:d2bc with SMTP id
 6a1803df08f44-6c57e0d6734mr50361526d6.47.1726243851860; 
 Fri, 13 Sep 2024 09:10:51 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:10:51 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <seanga2@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Marek Vasut <marex@denx.de>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 14/27] pkcs7: move common functions to PKCS7 helper
Date: Fri, 13 Sep 2024 09:03:31 -0700
Message-Id: <20240913160408.2199558-15-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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

Move pkcs7_get_content_data as a helper function that can be
shared by legacy crypto lib and MbedTLS implementation.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v4
- Initial patch.
Changes in v5
- Remove authorship.
Changes in v6
- None.
Changes in v7
- None.

 lib/crypto/Makefile       |  1 +
 lib/crypto/pkcs7_helper.c | 37 +++++++++++++++++++++++++++++++++++++
 lib/crypto/pkcs7_parser.c | 28 ----------------------------
 3 files changed, 38 insertions(+), 28 deletions(-)
 create mode 100644 lib/crypto/pkcs7_helper.c

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 946cc3a7b59..16059088f26 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -53,6 +53,7 @@ $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
 obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
 pkcs7_message-y := \
 	pkcs7.asn1.o \
+	pkcs7_helper.o \
 	pkcs7_parser.o
 obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
diff --git a/lib/crypto/pkcs7_helper.c b/lib/crypto/pkcs7_helper.c
new file mode 100644
index 00000000000..bb3b9d1354f
--- /dev/null
+++ b/lib/crypto/pkcs7_helper.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PKCS7 helper functions
+ *
+ * Copyright (c) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <crypto/pkcs7_parser.h>
+
+/**
+ * pkcs7_get_content_data - Get access to the PKCS#7 content
+ * @pkcs7: The preparsed PKCS#7 message to access
+ * @_data: Place to return a pointer to the data
+ * @_data_len: Place to return the data length
+ * @_headerlen: Size of ASN.1 header not included in _data
+ *
+ * Get access to the data content of the PKCS#7 message.  The size of the
+ * header of the ASN.1 object that contains it is also provided and can be used
+ * to adjust *_data and *_data_len to get the entire object.
+ *
+ * Returns -ENODATA if the data object was missing from the message.
+ */
+int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
+			   const void **_data, size_t *_data_len,
+			   size_t *_headerlen)
+{
+	if (!pkcs7->data)
+		return -ENODATA;
+
+	*_data = pkcs7->data;
+	*_data_len = pkcs7->data_len;
+	if (_headerlen)
+		*_headerlen = pkcs7->data_hdrlen;
+	return 0;
+}
diff --git a/lib/crypto/pkcs7_parser.c b/lib/crypto/pkcs7_parser.c
index d5efa828d6a..c849dc0d92d 100644
--- a/lib/crypto/pkcs7_parser.c
+++ b/lib/crypto/pkcs7_parser.c
@@ -182,34 +182,6 @@ out_no_ctx:
 }
 EXPORT_SYMBOL_GPL(pkcs7_parse_message);
 
-/**
- * pkcs7_get_content_data - Get access to the PKCS#7 content
- * @pkcs7: The preparsed PKCS#7 message to access
- * @_data: Place to return a pointer to the data
- * @_data_len: Place to return the data length
- * @_headerlen: Size of ASN.1 header not included in _data
- *
- * Get access to the data content of the PKCS#7 message.  The size of the
- * header of the ASN.1 object that contains it is also provided and can be used
- * to adjust *_data and *_data_len to get the entire object.
- *
- * Returns -ENODATA if the data object was missing from the message.
- */
-int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
-			   const void **_data, size_t *_data_len,
-			   size_t *_headerlen)
-{
-	if (!pkcs7->data)
-		return -ENODATA;
-
-	*_data = pkcs7->data;
-	*_data_len = pkcs7->data_len;
-	if (_headerlen)
-		*_headerlen = pkcs7->data_hdrlen;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pkcs7_get_content_data);
-
 /*
  * Note an OID when we find one for later processing when we know how
  * to interpret it.
-- 
2.25.1

