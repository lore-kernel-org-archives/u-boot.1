Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2230C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD64087903;
	Thu,  8 Aug 2024 18:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y8qAMRxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9264874AC; Thu,  8 Aug 2024 18:22:07 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBFE874AC
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7ab63a388bso49761366b.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134125; x=1723738925; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJdu383bEZmoEf0jaSYoXbeYDyVA149Dgz3Uuc+tKw8=;
 b=y8qAMRxVO5l5Vj0N0L/oK5td47Yqj8IRQi8lqOgKg1qFpVhjG6tilpXhgoMjqBkzs4
 1nzMBAv/AGRuGEOewND+6Zbd/o1cvUrKJ71YFDCLE1GoItirpkPH1OzYxPw9rQww2uQc
 QTzhZMcr4DbGY8XKmkH8eXkCaEkb9rAzy7XrKNcH5R3l03GpeP52qyJtLbPiFPLKRlso
 O3G9M4q7pmiK9hIigUgWaxWjTHKQdtV/ZhIdTib7u8hnahxEkSjUXCtA3IjqYeJEbF8Q
 FlZB32iYOmOPCKrSZVfyQ/0fw80vkJ54VSrTJcOk2ftoktZG3UG0PkTHj2xjzPjCcxSW
 n6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134125; x=1723738925;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJdu383bEZmoEf0jaSYoXbeYDyVA149Dgz3Uuc+tKw8=;
 b=CK8qSXb1hHvfnhmQ82rJifZ/WQf//GwzdbQaXCkXiis33ayJHjjT3dMuh0tgd6RHSQ
 GyTwTsQR7fW3pnKJNsIao9FJQR78a+MfgWfBqtLB32VFickXQfNIZ1l6TqJCiSoE/XfH
 Y3Dme/PDSSZFIsjMnzH8stAt7lg+KbTwZEsJwHBvmLtGyLpUGEsNP1+J5JS2CexM+bf7
 x8CnbBh+OcCH4QJPYvflFnNEt91vzDNa+zCeD3AsWG+xobR/ZVuxsv4JaU/uu9vFFP+A
 4E7ZxakpB1zHMpfLtAPHwg+s6gBt8LgLAmWHEsG2wEry/iP6kJg/LzriTdcVb69QQPdq
 xOYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ7V7czwFGmAdq3Vll472eXnJom9+zGkkOCxvBwII57FTMv7/4SZxd8eVz6Eay9cyxvRBQFq3sv37ymAFT86f7MK1m3A==
X-Gm-Message-State: AOJu0Yz92eu69uOD9OnYncqZWSXSUigP9feOBWVYDeQFm8oX3XAKgK5Z
 OeVq3Pw5bLiV7h4IgwD0Gmoi/Isef6u0Xzv46suNo2fSQL7ZkMI3xdUuLFgFQew=
X-Google-Smtp-Source: AGHT+IGX9sPjrxm/IsR43ShDtpgW+tmoJrVbWr/DpNCIOyHhGRnWlTIglY1GF4eksWMPL2Mx1UZHPQ==
X-Received: by 2002:a05:6402:3908:b0:5a3:619:949f with SMTP id
 4fb4d7f45d1cf-5bbb249af79mr2450291a12.32.1723134125292; 
 Thu, 08 Aug 2024 09:22:05 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:22:04 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:57 +0200
Subject: [PATCH v6 10/11] test: lib/uuid: add unit tests for dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-10-9332e7237119@linaro.org>
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
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
 bh=F5O31Nk7Cky+OrDFFf3eaBrzcyso+9+tOqyXI5DtTgE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCfaCZThIAo3wrP1imjo0idje9cr3O5oNkg0
 dbmS+ppdBCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwnwAKCRAFgzErGV9k
 tpFnD/45O2xeNE7BiBR4CG7q3uEs+0LTZVVWc+yakokCrTEoP+Xs2czpQvK71tus5ERfMYBUbmy
 W8FsyCdIRUD/Qrx/2WhOs1zBJmXYQZ30OkYrxncTF9Mk6x9gQor8KBzkOR2zk9qrDOy2y3CKqjt
 qmXqIVtu/w1j8aNkMkQrXZR4SuEXR0Vmskv2PWtWhVXJPi/ML6StVCN+U7X2Z/idH0MrCIlSknU
 eIPt6/MrvrUHuh9RXvSt9gXB7BJCSZVsXzSsy8kyahviyztLlaNLTMJO8VTfOfuwJ47lSb0otM4
 lnbTGJCzf2HLLmWi9tIe6989zTrMygHV4/R4KPM/+RCwJ4SGz04zizYB6lf1viqAdsZe2k3Yw5I
 5ITL0vsek/KE9Q+2IYnBZ3CZS+jaujRO93GA+hvxGxbm17bFY8EhdI6CpMEck9TbvwZunzK0yZg
 /Jimo+INIlJhAJ8wdVGwIh2qXCaEmnORe6IGL3iO4jrG+6keYdIX2z83Tdv6TuQ6U5qMFXTR06M
 h6/+VDWoQWSfmz2oTx+2KqBFc+l15KbRqVcgFm7HpTDqx+7vLuGLaLuiFuI/lP1uduYtn0vNvMZ
 eVTHflP1sYKgUBGX1VPtetYAw8zLNhVMdgcTKxEJq26YdVdaIDeiQ0Uk7OKMeDviK8xmmI+YFEf
 draFM4jyPjrZPDA==
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
index 9629d378c329..2c6cfd42ddc3 100644
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
@@ -37,4 +42,81 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
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

