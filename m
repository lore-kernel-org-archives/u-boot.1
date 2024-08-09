Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2331C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9147688B8D;
	Fri,  9 Aug 2024 02:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U5ORbzdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B144C88A10; Fri,  9 Aug 2024 02:56:45 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B84B688BE1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso2134943e87.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723165003; x=1723769803; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j2GebyOcvCO1ksLKJy5XNmT4lbOVnsTw7urdHAUt4G0=;
 b=U5ORbzdT55OO1UZwYYTUXmb01NrzO9IcWJ2lSOQ/1MrWFN/XliCRL0DNXVZzbmniYn
 wlGqjHmnx4Xh8XXKwOfkXPA3hASIH3PA148TMAE/jWTrwrvnPlQIzNmAGV6MiaU52aO7
 GtsAwX0/8LAcukFmwCuMLINPvDmEetPof+W1OvsiyPwCekt5+qbV8+QWDsUnYX+j8FDy
 7pxehpcYeaEKbMJMXSMgV1zHjHGE2n9OGwUDvu49JBuYzH+dvv8o9oyU3VDaTnCzdest
 BVRW0coLpIk8szTq02Mg9ukEhnqLsRX/4i+4j1yf3nmqZf9qpNIpCbKNoJf7EK8szKxu
 +FHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723165003; x=1723769803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2GebyOcvCO1ksLKJy5XNmT4lbOVnsTw7urdHAUt4G0=;
 b=VNCuFMIuHiYwYgdkcOC8SHfTYxLIu+vTDvRd+NyZD8PqR5jFJgN5s2Rc8XJqt8MtMg
 /C/ttOErmBMx9bWbTdE2D82ppIH864C8at79d6xIn2lxWuYRfN35fgxg2v0F7d0bFPA1
 rNBOzHbWnHNwCDrz3qwyF1C8tI9SDG3BTWSGKZRTkytv7h4Pjkdq51VeEqKu4nUO1E4J
 3WQoRJuFSzeOpxj9TbtkNhd/nCobigGqeaxBdGIWQyYogKmnnyZCy9VDc+FmKvHfmOBH
 ToVNBFeK4BVXv0CHJdGUk363mhGIJLV0+V4aGGad6YlmDLIr5qq5xS7VCEl7faif8K3P
 KKMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0C16vm44J9afITXBdZLI4Crow1mrqPVdhv0eGm2g/PHE1mnyhLE40lWQE72DERaTJWvLtSo9KFVXe3hWOgsWk6YJoug==
X-Gm-Message-State: AOJu0Yx4Nyz34lk/XoSJTKbaoELSgRrhYKCdyWPRzK9gyqkGXVx448qQ
 fWOgwSc9limjxgCMUVkEmqC5+wnVbUH1a3JRPAHYgBS93XoVL+6SwrCbm2x03DY=
X-Google-Smtp-Source: AGHT+IFmVsI2wxMUC0ZaQnPl3BRLQFvdCHEdLNQeZILIwcHLbeyRdMFbQE6cz8y3wM/ANBS9p5YZKA==
X-Received: by 2002:a05:6512:33c9:b0:52c:f521:9423 with SMTP id
 2adb3069b0e04-530ee988af4mr10479e87.26.1723165002802; 
 Thu, 08 Aug 2024 17:56:42 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:30 +0200
Subject: [PATCH v7 11/11] test: lib/uuid: add tests for UUID
 version/variant bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-11-8c44ab1f06a5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=zEV+3wrhvP1/3lJW2JTyvRsvixrRcHr3HfOI+/KZ+nk=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk9L/R1P5YdKEwTIO8tiNwZcg+k7e44giQe1
 6JJysLxk5WJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPQAKCRAFgzErGV9k
 tuKmD/9LApo2b2N+FbvRDYR0u3PI7dT3yMpDssfjQR9ZUMDyNOXxKE+wTkrLdkYal2//3jXJamD
 GCyUENY6cvbucaysGWSOTxuDBrOF+vO2umAIP3foNKBU8KJgWv/rstA6i+sGOFTeUzBEOKKurgR
 wn6Qf4w0VPgOTxB657tCwSgIkt2YDlJB5QTeWRQ3xXgvl3e9XBDcDAGEhbdL3NVMhbQypCCmip1
 3zz0sHnYfaUYRtc+8nnJZoa2KR4j2VQftMO95+QBpvFUMUUrT13Z+j2t5Q3sGOe18CNduXVTP/p
 YjiNg3O0cU7t3NHDgRK0JWuzVQEQtGFI1mD4GYhVoZjM/UKieUE0WD6BTz+NgiaZlCNM3hH+Orn
 QPRDerpmp9A8ki+oBJlpR95mEdPs8VbUpKvp2zuWIbtyzwxOZZJXNvxT+ortCcIuzEOl2p/MSE5
 wTjMmu8TrKeGXMArCUfq1Rm5rE8w79TmZShO6u6/FwBWx5EEFEWTFBwrV2ITwpNJswO60s4Lwic
 efHZ4SMb+ZrzJKUmuZc4dom3cfDPyleELJepa9Ubzo+pPJkn1RxEmPWniJsKHRrLEK7pUTrYtZb
 +zIRpgz6WKTFOXv41OknzSr9SHsC75300j1cv3YI4hLlpvzr3ExCswPz7dX/No3WJPbt4YRvtiq
 b14PQFdhcFcS5hA==
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

Add a test to check the version/variant bits of v4 and v5 UUIDs.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 test/lib/uuid.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 2c6cfd42ddc3..bbaf821f007d 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -43,8 +43,46 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
 }
 
 LIB_TEST(lib_test_uuid_to_le, 0);
 
+#if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
+/* Test UUID attribute bits (version, variant) */
+static int lib_test_uuid_bits(struct unit_test_state *uts)
+{
+	unsigned char uuid[16];
+	efi_guid_t guid;
+	int i;
+
+	/*
+	 * Reduce the chance of a randomly generated UUID disguising
+	 * a regression by testing multiple times.
+	 */
+	for (i = 0; i < 5; i++) {
+		/* Test UUID v4 */
+		gen_rand_uuid((unsigned char *)&uuid);
+
+		printf("v4 UUID: %pUb\n", (efi_guid_t *)uuid);
+
+		ut_assert((uuid[6] & 0xf0) == 0x40); /* version 4 */
+		ut_assert((uuid[8] & UUID_VARIANT_MASK) == (UUID_VARIANT << UUID_VARIANT_SHIFT)); /* variant 1 */
+
+		/* Test v5, use the v4 UUID as the namespace */
+		gen_v5_guid((struct uuid *)uuid,
+			&guid, "test", 4, NULL);
+
+		printf("v5 GUID: %pUl\n", (efi_guid_t *)uuid);
+
+		/* This is a GUID so bits 6 and 7 are swapped (little endian) */
+		ut_assert((guid.b[7] & 0xf0) == 0x50); /* version 5 */
+		ut_assert((guid.b[8] & UUID_VARIANT_MASK) == (UUID_VARIANT << UUID_VARIANT_SHIFT)); /* variant 1 */
+	}
+
+	return 0;
+}
+
+LIB_TEST(lib_test_uuid_bits, 0);
+#endif
+
 struct dynamic_uuid_test_data {
 	const char *compatible;
 	const u16 *images[4];
 	const char *expected_uuids[4];

-- 
2.46.0

