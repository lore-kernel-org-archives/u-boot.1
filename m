Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55883C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FF3886FD;
	Tue,  2 Jul 2024 15:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dpTGmj2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BE088748; Tue,  2 Jul 2024 15:31:01 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16FD488732
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a754746f3easo63521866b.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927057; x=1720531857; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zgTGsECpuui4joumBLRrHZBmSfd26OhIye1/OmJYNpI=;
 b=dpTGmj2I0ZZpK9Ng5b+zwKRFv9n3mFTeGb8IZHVvvcWGcu+Z4+i4gtM6Ef/+du0zFP
 BZ03u6nMq94wenGHBBsCB2MNkqA+y7xKnKYqEOu/l8amUCNkoRQ3swf4Jbyalf70V6LU
 68+CBbxwAlDBv40ymFsrDNtVVTSlFV0JI1dtFjVR1vaCEzKQ1JySX0E0FUNmtIfu/5g/
 rmmwcArCyxGDE8UctmJ3YC6WeIYWnPD9jdMKVA1HMfwdUMG8aqCBX3ekQsQacz7+PeRY
 U4daQZFYYx1Co704iLiQxFGjovWbq1ww0CnlAkaF+CTKybTjZA5vYIQTRB9JTt+B0Euv
 wyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927057; x=1720531857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zgTGsECpuui4joumBLRrHZBmSfd26OhIye1/OmJYNpI=;
 b=WNmipc7rqCEWVqUWXOdeE5ycF1MlqbYAIJRLIY22bZXVgztnwO4wsu8MrtBDTUg3F0
 BAp2v0qY0Hu+OnidqkGo82G12yjk29OXaCX+yfmiU9XbDDqV0f2DRmTvnPb8KdQ+cDAj
 mpKT4hLZNAL3Qfx87EiYY9UIkh5kwmfIw3NJFNE7F0PBE3SCEYtfQ8s7k1IiR1bzqLlY
 IC8rEIjU0JGS8Qhiz6nAIT9K/F2ey8oahxpimdKDRP+S+7Z/rowxSWH01q2aYKOu/3kG
 nA/cIyg83pIbea1mQwmKoAUcf0vahhJgABlwvYQpEG2C1GBv3EJ1tpWYT5A0ZxQZcXd5
 WT/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP5gefEVWcdqtIGHw/w+tR4SCVYscVWMBDoBD2QKMgulsTbHE/3i8MnehLcLdx4kINnQEgfgTkCyV8i5UsFbMOEhlPdA==
X-Gm-Message-State: AOJu0YzX9G5cJ2/T7F/Kj7z8Hm6v2iBohp7QbL42o2HVEt6dE3wKVX+E
 tog7K8qaAJPmNMx8HC6u2G0gYdQS4aQHP6K8A79ekK9Y2Ty7CeVLDocLTyWL9DM=
X-Google-Smtp-Source: AGHT+IFMKJLslm86m5uaIqVHhI9o5xYoDA63f4srhc00oXIGex2n6ro/tnwEwaiMOhEv0b5APlY4Jg==
X-Received: by 2002:a17:906:a292:b0:a70:c02f:8a7e with SMTP id
 a640c23a62f3a-a751451385dmr660757766b.54.1719927057572; 
 Tue, 02 Jul 2024 06:30:57 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:50 +0200
Subject: [PATCH v4 10/10] test: lib/uuid: add unit tests for dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-10-a00c82d1f504@linaro.org>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAEDtTMOQihyajtp2Xee3UYIPlphcmDAbZJoC
 0OPy/5UZy6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAwAKCRAFgzErGV9k
 tu8rD/9defrNDiL0y/GlXRy+oW35vJEsLFvpnMO1UHMJ/o3MspF0+KU5mAAVPPM5VCgO6eBbm06
 FDC7UPV//BJpEvMOVfRy/SRz9jlMDnZGugH94/nX8RELl0lTb2DpnRpEFl9Rr//2hPkJg5uc4fh
 GUUI4LGjKBRPlNMEj3jOjjePelQxDR9I/kbHfShCqUNhfKMZz2tfWwWYAFzn9+59t7f2cHXLpk3
 WrWEFXPIRT1L6wXrW28fXq8c49Iu1rXjblf7bLkTDtSeID1F4TKvgYTK6PbRKITNOnXUGL9CeXm
 U9kQ0fohz8I8/RVwO6jV/FVqcFNJwzfYoNT9l4mEVX/vLEK4J1ZBckvtpbLLScBUD4ygsZ7697E
 vs1l+n/auFHrwZwo8Nj0vyaEw1SQ1MtKYF3mhwReA1o0krLAj5vMlwxmLGTkSpiQYF8thkm6RDZ
 RBzrih5x4061sPyGSFezYvlGEDmZXunN+BKB4gQWLiuuRxtW2gFkTbUUYdxPSgJqv90shEjADvK
 boW2sJJHhOlRtfpBoKLKfXt78hTaD8VG2HatLEbteZO2OsTPGD/u5GEoFLOc0KD0o15Ijorlf4m
 iQ5KfY24yVKxCcaGiOUV61nq5wt0BciK+r4+PbIxH1MRezl9t9jqFI4c7qAYfM2WUyRzidZfYAe
 ArCm90XLrAYW6TQ==
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

