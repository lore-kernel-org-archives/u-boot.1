Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFA6C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F78C88BEF;
	Fri, 19 Jul 2024 14:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vxqEaKME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A38988BEF; Fri, 19 Jul 2024 14:44:01 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB6B88BA9
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c79so2088923e87.1
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393038; x=1721997838; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zgTGsECpuui4joumBLRrHZBmSfd26OhIye1/OmJYNpI=;
 b=vxqEaKMEOX/xe4cT/BGtFdGztmGvvPB98qa25J2QkgskoD+UkgYYVVRScsdezdaaFr
 FunQ4kMYjJa06cFQ0YbCgHZ7fj79/IQ2WLY+l+vZl0jT3GdTzv2YYzpyyf7JfbBScC7G
 CmRTbl+n4z2hG4mBPyJS0ObjElOc7n2mFtbfCkmvip+xQgrKJ8MM5e8doJTqJgQuphOx
 3fXD/ekFg1zndlcu6q4uKVPGDDEPcGjdCm1waJOxf/HWzIXGglmtXPv77u31aQTD+kSm
 hCGi4Bk/pZE5flZxOF7fXZxwFpDHMOYvNHlVMVHqidaG2UNTXZvsb9Abdq2Wv6RSLWZC
 hG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393038; x=1721997838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgTGsECpuui4joumBLRrHZBmSfd26OhIye1/OmJYNpI=;
 b=gid/CTHBgdv+toMusU1Pk6045Z1yITgXBTqfCgRAIhm7h5IA9IWVMXvDeoRZ2dXUYH
 Pw1AUldZxNrH86Dl+Y9IfS34EbaWqVIIQFhCZEwJ/CYAtGpdCVZrIDG34VfkGHQl9bNQ
 4MSGfbjGYh/n4SOJx5EsU8N8TBRMVK8de20aYnpviYNeYWVjAsNFa8yBicxR1qvw5Rml
 xi+BJ4NJTRvO/c2Ez5tpvTh6z4p037lr4SlXHdvVbPH+j0gZQQuNBcaCvCtaNAu6Vyz+
 rhVAn2Fu+UGkBEPEGJF0IM/APS9dGuALRbG6n8+eOb+b1/MfsmNyTS46ettZXNxiIpp8
 JHrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFwBnvPMhgM0vLrACH71RLoKcSKzMqLxGj5Ue2hOnttJERhW/7RnL/+9KLWA/5tnJ5y8S0Q78czhQ1Foy4ogSktcqTQg==
X-Gm-Message-State: AOJu0YzEQsfuTovi7E6aFmJ0dgUQUEGH7sM8h7GdvoYalXfCpqhsaUEk
 uCK49UtoKkk1SSrdEqbTf1KflChwDM07pwqAa1qUAgw8FPGX8l/9yD4iWDmb6i4OJTE/IfeZgZ4
 UvHo=
X-Google-Smtp-Source: AGHT+IF37sdJ9uNetQd55gOleIrxapxxajzoODgUYicYxDVo5Pc/2fJqGt/LGZSb/aWx5M07+RZKWA==
X-Received: by 2002:a05:6512:12cd:b0:52c:d76a:867f with SMTP id
 2adb3069b0e04-52ee5202eaamr5108569e87.0.1721393038418; 
 Fri, 19 Jul 2024 05:43:58 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:50 +0200
Subject: [PATCH v5 10/11] test: lib/uuid: add unit tests for dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-10-8a83de3fe3dc@linaro.org>
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZETTwLjb7NljHuT9g0TrbGD3/tc1AKgjAkUPham0EcU=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+BIkAI8dVOQ+fpu5SOUgMEzXacZlCoLj9qi
 vuvt9LBWtaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgQAKCRAFgzErGV9k
 tk3vD/4kQCYu7QAvMMAH+XDl5gWMHy8ITCWBQOe5BBr2w3aPyJOfLS2JPLasxX8PGyIFpBcCzW6
 zX+zXcgHOOWoqqz1T6a/ljQEAQg2BMnkcB96PphDnAbong+yOERIbKL26ZyByEt1DZD/kJcTErA
 VXT0h4en61Tgk8VoWCps7ebMZK8+dej7CSf/qxX0RlVRcAUVYzVGu0+TlKK8/MCtVVuWEM5dz1e
 WbDS+CjtNfoxo+JKuTj1TzpUfff+wv14SX9LU6GCQEu604x0xKMKK4Bz90kOqQCUC6vFfPuYDq1
 c55vAZnBs9lQRCAFvdSpWH0VremD4Axy0j0hHcx/b5Mxdvg6EhEQfBs8TdwUb6KUcGqbjgpb+uT
 Sk0s5GOwgB8qexwHI992XXT63WmceOWtPliK1tz2k4P70Nyxi5pyIS6vs/P03EEiLmSQoAze9BS
 uQ+NnnxBArW+MjDOO0YyyC8rraC1+HW6vVaSSYDtD+HQ9ZPah2xnJxWlxIG1Ait01sFHOmFHk9H
 izfNB8Hn2xSta2aKfosDfbYoIkIqp137mqYyrqMMGhqaBO09IMc98DuFJgXGwLQL33c2e7q8/JG
 PmEHdYmrDgQfxiBIzZLGegaKCDIDSVaLwIUcrfIwIl1OuFGukTASP3xoRTtGcJXmMRTqqX64RhW
 hE6tzQIpdTOwqZw==
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
2.45.2

