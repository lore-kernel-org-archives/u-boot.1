Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF160CA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96FB688C51;
	Fri, 30 Aug 2024 14:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CJFRPAK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB9988C3F; Fri, 30 Aug 2024 14:34:49 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7321688BBC
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so16088395e9.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021286; x=1725626086; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XQKUnmyBwBLvsTbpwbjgaHTP7ZZ59+35Ps2sQ2R6uIk=;
 b=CJFRPAK2qB/bP1/kt4ue2PukcaANK7rD2WOC/IoCKSrFZVh1RFuzGxajuT2NUAMfmB
 SlnH3pwJlntia/+MhaDVRUJVp61603fSlQqEYPQ9A/lqacNIb3wvTF/KXMkk1M70XvVH
 xXY7gjsVKEyEkNdpdDNzBSY8hF8y61gpf6ZLwan0JsfGFg97hTlRWDyq63bQ9KcwMZ0U
 4mbE++5nRMAnQLM+q1qd1CTDPwfbM21tl+klgCfGqhSEdAW4QO6S9CapMmUNAvV03ce/
 q7b1W7ZwLvJJUsX4xOKJwr+Sz/7d7vl2EBmRWMiQQxOCnRQzrw/NObSEhUmWEUz2FOM7
 xwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021286; x=1725626086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQKUnmyBwBLvsTbpwbjgaHTP7ZZ59+35Ps2sQ2R6uIk=;
 b=NyXCLmEb9/f8ZTsNw0YCen0Sw6zJv+30ebSEjYP3Ca8ygG24155+uJWAWTdi0ouRau
 msTY6LSggMHrlYvv5XFlL/8nw/qN1KVFdPclWSlmkb+weTbUkTANRw/X77yWKC5wL0iH
 ksphN93TmpOLoUm5xgEabmZarwIZavimxNUnQwKMdMq1SPxkYZd2lvKoiVmR0F+FhGyN
 InXjimRfuy7QK0BnxstALBqsBDs8WrAgxCFFSI8jrDfY88GELlGL763POj1ej7cuvxlI
 AWBJdTZOfn/ip/F3HW9JxcDbmyntQSfj1q0G6iP/hhe7Qmcqz2zkFlt/NaV5dzPzHxRo
 quBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU3q3X0a/IJyKd+ZDxIppNz1QSDAr1hiWlVXJbfLWKdl1OxTx3NfteRKxPYks+rUyDBd8zUy0=@lists.denx.de
X-Gm-Message-State: AOJu0YxQWliYH9B/nAP3PDvdqeqeC2bfkyyNKcOlZQMHx/iCikWIbC3H
 bitwQJD0Ae4+X6ui8q51K3TFTIQ/Ycn6gT0q6/0UQOKVnQ7GXucJ1x47cr7Bqh6TPZLIYUaExy8
 S
X-Google-Smtp-Source: AGHT+IGSqRKeXcoTiP+8Byy8Qcvd/vkW61KBbeC65le4mIXZ5j8T3O6FbhY/OUBHfHAviaBz0MtlkQ==
X-Received: by 2002:adf:9b89:0:b0:371:9366:6d8d with SMTP id
 ffacd0b85a97d-3749b5495abmr4289097f8f.19.1725021285832; 
 Fri, 30 Aug 2024 05:34:45 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:40 +0100
Subject: [PATCH v8 10/11] test: lib/uuid: add unit tests for dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-10-79b31b199bee@linaro.org>
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
In-Reply-To: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nQtu1CuT1dJvWShrMxbtGhtMhEP33bTMHgB54rEEcWk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxafPDuPmk4Oj7igpnA5gfslpNag0Z6cSHaL
 Uf2DKBcNnSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WgAKCRAFgzErGV9k
 tq4cD/9jjEkp0JBL9sJJf6YBmUnLwgxTfY58rMUrEjGn5K6f2+9PPMClO2jNbnxy+pNw6ZSU2f1
 4M0Td9JmKjsFmFlss9G1N4nY+6C3YGlkpONOM8k/T28xeqNJNXWGcagCXLsO199vGj9DwHhaZ9l
 4P1XPz0sxZyE+zIVpze7P1jeD0UOYSSOGgOCD2aYDp0io648tyTxdWfcbDhfL5O4KNVpavfhMe1
 4TDOLH9oV+fo0eGDgCWtTrw1nwWwqUqso38i2wGlhlrLYVYsLgVs3BgZBf1veG3xO+Y/Up15xjW
 +uXPB6yTbL7PzHbQAH6UH5RVmsnM3JZnPDHrnUrg81oZiLmeaTDFRwcv676jS4m15oBrydINDbv
 UTdKR+uW+2Y5THa6utxaIi+PIxFb0CtFhEvPJI1dOLdBq/06O0tFSdwVWutrhJgUhZqP9r0Rf7p
 eGqi8wXqq6xloLGlQqc/uCQvp06QirMoF3EST8eT3vBBM79MgWuSyq0/0/NNflNoQwuFKOXbGPi
 AcYxKVR5sBaeEy+FuWG/7Oi3uM80tm9Ng8gPXgd5E+Z3f2R4r0gY09c0tMZr8ib6PEpFG8SLZKJ
 r9+Dg5IeF7Jt0esNLp8nZcDp0GW14spYIFFuyct6KsTYbHbI61rqS40TFCk3/1JQzaCq+v8h61X
 057b98wHlqaQigg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add some basic unit tests to validate that the UUID generation behaves
as expected. This matches the implementation in efi_loader for sandbox
and a Qualcomm board and should catch any regressions.

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 test/lib/uuid.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 3d62e18bcfee..4a1a16b4f315 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -7,15 +7,20 @@
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
+#include <charset.h>
 #include <u-boot/uuid.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
 
+#include <efi.h>
+
 /* test UUID */
 #define TEST_SVC_UUID	"ed32d533-4209-99e6-2d72-cdd998a79cc0"
+/* U-Boot default fw image namespace */
+#define DEFAULT_FW_IMAGE_NAMESPACE "8c9f137e-91dc-427b-b2d6-b420faebaf2a"
 
 #define UUID_SIZE 16
 
 /* The UUID binary data (little-endian format) */
@@ -36,4 +41,81 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
 
 	return 0;
 }
 LIB_TEST(lib_test_uuid_to_le, 0);
+
+struct dynamic_uuid_test_data {
+	const char *compatible;
+	const u16 *images[4];
+	const char *expected_uuids[4];
+};
+
+static int lib_test_dynamic_uuid_case(struct unit_test_state *uts,
+				      const struct dynamic_uuid_test_data *data)
+{
+	struct uuid namespace;
+	int j;
+
+	ut_assertok(uuid_str_to_bin(DEFAULT_FW_IMAGE_NAMESPACE, (unsigned char *)&namespace,
+				    UUID_STR_FORMAT_GUID));
+
+	for (j = 0; data->images[j]; j++) {
+		const char *expected_uuid = data->expected_uuids[j];
+		const u16 *image = data->images[j];
+		efi_guid_t uuid;
+		char uuid_str[37];
+
+		gen_v5_guid(&namespace, &uuid,
+			    data->compatible, strlen(data->compatible),
+			    image, u16_strlen(image) * sizeof(uint16_t),
+			    NULL);
+		uuid_bin_to_str((unsigned char *)&uuid, uuid_str, UUID_STR_FORMAT_GUID);
+
+		ut_asserteq_str(expected_uuid, uuid_str);
+	}
+
+	return 0;
+}
+
+static int lib_test_dynamic_uuid(struct unit_test_state *uts)
+{
+	int ret, i;
+	const struct dynamic_uuid_test_data test_data[] = {
+		{
+			.compatible = "sandbox",
+			.images = {
+				u"SANDBOX-UBOOT",
+				u"SANDBOX-UBOOT-ENV",
+				u"SANDBOX-FIT",
+				NULL,
+			},
+			.expected_uuids = {
+				"985f2937-7c2e-5e9a-8a5e-8e063312964b",
+				"9e339473-c2eb-530a-a69b-0cd6bbbed40e",
+				"46610520-469e-59dc-a8dd-c11832b877ea",
+				NULL,
+			}
+		},
+		{
+			.compatible = "qcom,qrb4210-rb2",
+			.images = {
+				u"QUALCOMM-UBOOT",
+				NULL,
+			},
+			.expected_uuids = {
+				"d5021fac-8dd0-5ed7-90c2-763c304aaf86",
+				NULL,
+			}
+		},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(test_data); i++) {
+		ret = lib_test_dynamic_uuid_case(uts, &test_data[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+LIB_TEST(lib_test_dynamic_uuid, 0);
+

-- 
2.46.0

