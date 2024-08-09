Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27223C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE0A8789F;
	Fri,  9 Aug 2024 02:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tVORD3BF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3677088C08; Fri,  9 Aug 2024 02:56:44 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432D488B63
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso132939966b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723165002; x=1723769802; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJdu383bEZmoEf0jaSYoXbeYDyVA149Dgz3Uuc+tKw8=;
 b=tVORD3BF06UYL4gGUJFZ99AtgZtgssE+J5zOrCQYRNTPYege8tvWOeWMdCB/w+zqVV
 tYXSap8mfCANlRUwGHgc3yFS7tBItJMsmi6jj2OoEkHejImaweU4gK18npUWQzDQyRFM
 hIfpvk9tL89jSjnenJiHTLQ2TnXAi4Zo4U9HptLrhIhc9MUpZoywsnWgeukMMqUI3Nc7
 ouff1xb3kr/SZIaxvM6QFlOwaJIAtQIJW9rdSqgjrj+xdWIRbpQkHOGlLiSV+N+LUAur
 y09MT4m7mTaoRFfEQc3HOB2FFoHxb1oRuXehRIoWAP9IBAzVkVhEbtGL7J8KfcIFaFWQ
 zD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723165002; x=1723769802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJdu383bEZmoEf0jaSYoXbeYDyVA149Dgz3Uuc+tKw8=;
 b=MxJsdxsyZNUcH+CFh1jwigNZgbrCdwMfp6xoVo1EWDybXeFldHAUyIXMevfM9bSfw8
 U090xfCOooCEUV1Fw5XtKFPhrQ9oWN/kOiQOu27V5zsz4y3jny8w9hygYlvVUimoA5yv
 Hs8SbgwC5lHaXlmQCGPI99n9IqAR03lNMc3hNnUp8cF6TMDgwiwH8L/+yBOZAhi2iQx4
 M5puEnB3brEXhyAPGl/bq2g8Yq8WwQq+PN5YElZ/OaH/UCwnxZTajZahF07BI3E01ASF
 RDNVfrySN+rI6n8We5X2ExViPvARo7ol5L2J08ZXLfQJ2MydyW1/q/a5fzq9HhEj5nM7
 KdnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbS2EhojhyT1ZROwUrdnpO9/tp2L5oZO8Ac53gUxQqIegUfHJ3if7q1RIF+yDM2rYV+hCqRtZcqYxUII1YkfFw3+ZkMw==
X-Gm-Message-State: AOJu0Yx1UAOxxEvMqPGif9aPg1yZaOkOWHMkbgTX3kgspFoJ6LveEHsC
 rWDRoPGLt7B756d5DdyB77Y2tNmbQwl9/8AQVE4ajtSeLkHgOXpMt4wyz8r0r6s=
X-Google-Smtp-Source: AGHT+IHLmeAmkIeyUN6ZdoF/sOdYYgCh0ckJQRMETJIts5JhhNhwikM2O9PmvYxpmu28j9VT/cdjBA==
X-Received: by 2002:a17:907:f1c5:b0:a77:e55a:9e91 with SMTP id
 a640c23a62f3a-a80aa595caemr912766b.19.1723165001604; 
 Thu, 08 Aug 2024 17:56:41 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:29 +0200
Subject: [PATCH v7 10/11] test: lib/uuid: add unit tests for dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-10-8c44ab1f06a5@linaro.org>
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
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
 b=kA0DAAgBBYMxKxlfZLYByyZiAGa1aT2iyiPjlbH6l9OVhma1xM5fr2BRXTmZzv/lYGRQbhX4s
 4kCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJmtWk9AAoJEAWDMSsZX2S2n8wP/1UO
 Fhf4HrOvCX+xvyabbdY86Ip3FO/yjvf2/lv8hk79xhjQPMK03oWmNZO04b0WbnyIIyRMgEUSG/g
 QTNQAsXaP8e5886WlvUU9J62gXNL9Actbo8prXg07DsTV7V1Z6fB4nDchEs52woTGdcdSR57Hdi
 meVN+uk9Xl4ukIaeJO4oMhm0b0ejlcmhQ/F87MRu4pblRpv/3o8HEIis4I9Nck9vOqKe0BHoDre
 04P/hJdxYCHv5Dd+M6JcIBhpZfbMxat7l01idO1GN7IqU17NXt/keseY2tHHie8bc0w99cNKAUi
 wwlNE4CpBIaqXqy99LOuY8yjsKxUFMUtXUAIy8TmNwBrbqLxdEiL/KXD2Go0KLdbv8Dr4PcASzM
 XwnFRfPg1KG6nBq7lRG1XjNNRy6Xi8xNNFitPmE9QYQc0mQVQppFmrcc5WN6R1jBirXofooW1Uk
 mQ0JTnYmWD/u/1PfCDq4OdbyyNB/A6kZRw+C7KkC9vU6fcp4ENixl+RA20km3qXf/6CQIFKY+xC
 +U1gF0EoEqGycNh8I6pRGoD8+f7PNNyMpuzQpcQ6lpsqoiqfQv0+G0fG0pFaGybLcF2wAfU6HwO
 BsqGgOMbUUgofgUDAU6zD3TXDiVMWN15Z30KgkVim3GXycY025lR7mdBqeZo4xQDVUpq3NGjRvR
 ACQq1
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

