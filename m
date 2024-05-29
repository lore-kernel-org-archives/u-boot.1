Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9D1C27C43
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB24388657;
	Wed, 29 May 2024 16:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZYquy6Qh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 535D988619; Wed, 29 May 2024 16:49:10 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D3598860B
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f462so2477754a12.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716994148; x=1717598948; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CNfufS4BdB1Uy7nUc8cXgrmVcwQ6WnWEs/A/AegjVh4=;
 b=ZYquy6QhQJlRTIcR8JRdoNSfppKsEyi+eGBR13lBc+KlDtNnuocxLwQuhNZ4tT6CMl
 vgQyaI0rc33lzf1nVNENcLhyOfWhBIVZ0z2BBh2Gbp2vihlMfLyZXP0zfnf5d/ycS6Mx
 z2L2a4HEU7nc5WgmbWjQWvoGBcaNnKwqMtcnNEuoHSYlIExMiB0GTlQ9DfQVe4Bgj6ja
 5hVLDGNXE7lg79JTGTbUSf8aIX9j8Ttt/8Ug0Nn9sWPvWnDSm8a4JyE//hduAonLN5G2
 I075YZebviXD6ajKXGHxedmpSGVozAOOhQecKtxgeE+Jfg47KM4rYI/YnQSNmjBQyzWN
 Azew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994148; x=1717598948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNfufS4BdB1Uy7nUc8cXgrmVcwQ6WnWEs/A/AegjVh4=;
 b=WYA7st98wiqPAciaLnTmxPA9emzHGpR56P8atGedlRd8OVqR9iuOScv/kr/XkQ0zp0
 pmzP4bu2Xgm9VXrviRa/xtqu97kB9atYyqzSNCquCul3OeMpK5QpkWkHbbL4HbtG2TaC
 gVbSet0D9Sk4ZBkBsLglBTPS/a15hRlvQF2gmcbsqHYpxkZjliNF8TY3/+zs9+GVDksK
 lUkV9E5g7FQpJX049wn1EhbHm06LCty6NkVo5H79qL5B92NA5ejrtGA+EaxwKKCBlo5R
 2bE8FHnWrZWmGjZiVGsd1epnWeXjm3XFvObbILx7O4y//e86cqf54T2HjAXsqBuXlhqS
 MuQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwkxjQfHalXnC381iiN/7iMX2n8mzyyYG0aP7OhQfWhm9lptoSUIEug36AUrXiKhPYkSedeNWnQLENYSqMomKcHsEyQg==
X-Gm-Message-State: AOJu0YwegUh5iV1nM652/0XdsWOzShfHXKE/Jaembj5Osp5QpG4Hel0N
 rmb7xVBC2f7+OxCYqWn90oKTsA0u67p5UTAVZiQkHVaImELCE92YRf+u5jgbQX4=
X-Google-Smtp-Source: AGHT+IEwvG+61wPcgrq31uoXlOj5QruEx1Be+px7+7J+mrU3anvSex/q+8A3b4OUMTHH5s9jGX/+vg==
X-Received: by 2002:a50:8a9c:0:b0:579:fb7e:210d with SMTP id
 4fb4d7f45d1cf-579fb7e2991mr3181562a12.1.1716994147807; 
 Wed, 29 May 2024 07:49:07 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578638009b1sm6922029a12.17.2024.05.29.07.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:49:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 29 May 2024 16:48:56 +0200
Subject: [PATCH v2 7/7] test: lib/uuid: add unit tests for dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-b4-dynamic-uuid-v2-7-c26f31057bbe@linaro.org>
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3313;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=higGEcp3P/+9pD9qAWm97NBYRZ+vVffi7vKUe5vsaIU=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmV0BaPROmRqn6St2d+faa3GKt7E2vy+AolHq8m
 gZzNm9JqaWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZldAWgAKCRAFgzErGV9k
 tuIFD/9eUKZQCwfWKeit5eWx8YW1EOfNAbJahem9H809oBBK75My994g2nbRhBzQIswevWxU7xq
 SqRRblsrBOkNUNRVitHcIcCPsLO8FoChVVL+2CSHf2oeTi7o0LVdaDA7TvzNGZK+t5KMtNlZCQw
 H8Im8mNRMWK+Gp5adF5CCyYKlnes9o0oX35jM7+3GFebio7pMNLarnj0UARIot5iwyRO1XVFtvN
 Px9UuxB/U7fDfeRIArAUhdG+O+/gYype1mZUh5WqQ0R4v+NY/0HX2p29NtGf2mNxlYJZ3zrQrcY
 8ntTgbZdNCSgu2jAlY0kj5XyuNEU6I4xyrFe35uQyoUPw2MKVLoFB0yWszqjSYFv/gMufdLACp9
 1eoUmJZsPI9PitesJT8k3oqNTTMOJFr0sMR/Y7CLpucjIGKqV6qbZVBEPYij6qP3Z9Fq7IZxzLJ
 SGz+uyoP8IK+8NCOWBF32zqoTgsvps2a+V5x3qRgj0YWHHkO4fAtX+SrwZ5xNhYpY6A41nSUhM9
 8bVmSbs4pWGqk5bIqQTBFRC7crBMJzMiZmIK8u8LkaAThQAjyLICUDIjy7Z8Y+1UCbGl9/01j8i
 miABUl90/f70RcpBcFo9uQCFxRBhx0afOIrjdRSLXgKZv9Sm+T9n0hLW8m5nsYhtl8yB6uTKYBR
 DdX42T+BZ0/6zWw==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 test/lib/uuid.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 0914f2c47e77..843678ec7f00 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -7,15 +7,20 @@
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
+#include <charset.h>
 #include <uuid.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
 
 /* test UUID */
 #define TEST_SVC_UUID	"ed32d533-4209-99e6-2d72-cdd998a79cc0"
+/* Sandbox namespace UUID */
+#define SANDBOX_NAMESPACE_UUID	"09d7cf52-0720-4710-91d1-08469b7fe9c8"
+/* Qcom namespace UUID */
+#define QCOM_NAMESPACE_UUID	"2a5aa852-b856-4d97-baa9-5c5f4421551f"
 
 #define UUID_SIZE 16
 
 /* The UUID binary data (little-endian format) */
@@ -37,4 +42,89 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
 	return 0;
 }
 
 LIB_TEST(lib_test_uuid_to_le, 0);
+
+#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
+struct dynamic_uuid_test_data {
+	const char *namespace;
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
+	ut_assertok(uuid_str_to_bin(data->namespace, (unsigned char *)&namespace,
+				    UUID_STR_FORMAT_GUID));
+
+	for (j = 0; data->images[j]; j++) {
+		const char *expected_uuid = data->expected_uuids[j];
+		const u16 *image = data->images[j];
+		struct uuid uuid;
+		char uuid_str[37];
+
+		gen_uuid_v5(&namespace, &uuid,
+			    data->compatible, strlen(data->compatible),
+			    image, u16_strsize(image) - sizeof(uint16_t),
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
+
+	ut_unsilence_console(uts);
+	static const struct dynamic_uuid_test_data test_data[] = {
+		{
+			.compatible = "sandbox",
+			.namespace = SANDBOX_NAMESPACE_UUID,
+			.images = {
+				u"SANDBOX-UBOOT",
+				u"SANDBOX-UBOOT-ENV",
+				u"SANDBOX-FIT",
+				NULL,
+			},
+			.expected_uuids = {
+				"fd5db83c-12f3-a46b-80a9-e3007c7ff56e",
+				"935fe837-fac8-4394-c008-737d8852c60d",
+				"ffd97379-0956-fa94-c003-8bfcf5cc097b",
+				NULL,
+			}
+		},
+		{
+			.compatible = "qcom,qrb4210-rb2",
+			.namespace = QCOM_NAMESPACE_UUID,
+			.images = {
+				u"QUALCOMM-UBOOT",
+				NULL,
+			},
+			.expected_uuids = {
+				"8ee418dc-7e00-e156-80a7-274fbbc05ba8",
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
+#endif /* CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS) */
+

-- 
2.45.0

