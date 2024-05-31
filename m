Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6876C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E386887DB;
	Fri, 31 May 2024 15:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BqYgSCTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA810887BA; Fri, 31 May 2024 15:50:56 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0EA3887D0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e6f51f9de4so29106251fa.3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717163454; x=1717768254; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7HsaSU/GVMju5xN/sg3znUxqC7KLIcXCPlkqzo9nf7Q=;
 b=BqYgSCThNvZZOPr1vudqPKPqh5C8PqLfByEf4LmOPBIruNcNwpjNH6YaZqXeFyg6E2
 HUyNj/zzDmwfxwD9npeWL1BxYQHGhkNY1sFVbCneszugMfM10M0P3QlY5b8k+EFHF9KA
 IWj8Y5Wt0S+6/ZV/8jzkCHKWXLOJcTMpvsGoedspgjy68CkSxLlSlp32bkLWLWporZ6J
 8kMfCh1nAAiHDwAkzBOWwcFp3idIcF6QO5lpTEXELL29cJdLzU/KA/3CDULsoGXSZVye
 7FjjEzllXN/1Ei39MKhJTbv4ssQWIywtvEJxtIbq+hsoytBb+8iPJMiw/mRJqHDb90Qr
 tBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163454; x=1717768254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7HsaSU/GVMju5xN/sg3znUxqC7KLIcXCPlkqzo9nf7Q=;
 b=MoZuBXBq/wScMxdD38eUq8vYAybIjiVwmq9m6PM7dyCK3Kc0Agd0l1neKltHpY1hBZ
 EaOYtSv0b5Y/i23VspYPPgh/JKAi0S1FfDAtjhLFR8ZcNLDSlCWdfoB0ZK4zZGfLpboJ
 h8gAVPUgD01vG0TxaO7iFmtRpgkHj/6+UtL0RAjOIBm6ynrHoyH7bhx/7sVgOoqwEvo1
 hjhnPNOs9IoAZKEez+Kvfz2F7qJDAXWzE0GooLqhsOR7LVRRAR4N6nuoikXwU/2ZbYUo
 ckX4OW4FdNsWpZehZLyxASyvFMXYkkg+YoRBCXTcnHABEVaNCn8TfJIp2fMVEjtNZKY0
 fKLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuM8V+a/lwYgoKAQXImp2Zf+VJx15Ob12RK6vByPmQ3ygKiMhm/UPUfJOtrSN3ghE1K+R1VCXFBrBIfYLPSe65w6ZmkQ==
X-Gm-Message-State: AOJu0YxicvK5/To9CNENkZVeruK+0ShPZCn9CIaPnKeCpGhfBEa5oFur
 VKLhUtaNtLaVafZZwtCsoeSU/XA1kaWR4Bbh3URkYyIgEuHr1lxz7DGgWMZWbPs=
X-Google-Smtp-Source: AGHT+IFMdI5PeSp1XYaCCsOFtmRXdjhKGwiiyZCWBZMcPvFNxAtYzOGc0+kXPnapmYwuau0ClC9k4Q==
X-Received: by 2002:a2e:b049:0:b0:2ea:9194:ab2d with SMTP id
 38308e7fff4ca-2ea951147afmr15601601fa.18.1717163453955; 
 Fri, 31 May 2024 06:50:53 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab84a99sm89442866b.143.2024.05.31.06.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:50:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 31 May 2024 15:50:41 +0200
Subject: [PATCH v3 7/7] test: lib/uuid: add unit tests for dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-b4-dynamic-uuid-v3-7-ca4a4865db00@linaro.org>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3273;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nUd+KMu0GfIDUzb8thPbkHD1IRE34vCpsyeDcvHSIBM=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmWdW0mg21Aq/DDFoTHnTl/kH1n9n/dH1kyh+va
 AUPmiJ3M7+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlnVtAAKCRAFgzErGV9k
 trqhEACWA0ooZxLgDiEmaHGfAkOZYRJc26wbGa8cDsYhsSj3B/ass4bKqbzh8tyjb07Qhu2bytE
 QOGLy8ea7EIW4uXNm9PPI8WpN86BUQmmYIudDlyn61dkKOJp8Ymha6w9+qqT8PVDdUstlP1Habi
 Tjsw3ZxnujJUn93SdkPC8PdmVo+Cvxp99IuqPkEawxCwP4aD9aRHDGunCxkaTiAB7rwZ1DX7/ZB
 xz6mOM3gXcVyQpkVxbHom8LKeHajgAhAFwY4Lx+MgoiqlNpErL7giz57TDdvpi0hRlXWG1V3zsK
 IJd9YNR0mGr5RywadKcARSHy7GOiXdDuUKDxrugrNmPqhKGGg2AnbwRo23AlSi5NlnyawWnP1b1
 P6gPUtlDz+NDu/8/UidpFGlvNSauCG5qTx9RsjxGkO9eq/OZSQwk9+9jUKKn5do9p4nxKje3ZKf
 TevZwf8T5VkYy406OAB+UibwSXYNeOeGJbbIh1JAEjGrp6+kftEIfwthmTjrPpbHnuMy1y49Eo0
 0JlrJrKKAxuskBgc6DjyrUzLHLpmWFNHB8ImOlBi2vc8dzqpbidk2HyAFnOBM+M46tbHd1758Hp
 9YdSX4pSsSqgRN7Ckrwrydb3b+GHLk+xWSLnv6ebI1YmCUJlTqGFdTo8IliLBugbZzIic5eX97I
 dxkE3hi0jPb+jjQ==
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
 test/lib/uuid.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 0914f2c47e77..dc485189ae68 100644
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
@@ -37,4 +42,87 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
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
+	const struct dynamic_uuid_test_data test_data[] = {
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

