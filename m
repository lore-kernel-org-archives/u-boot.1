Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CDDCA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F195F88C75;
	Fri, 30 Aug 2024 14:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tUPa8t+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D44788BBC; Fri, 30 Aug 2024 14:34:49 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D53C88BFB
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42bac9469e8so14864215e9.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021287; x=1725626087; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T720AHi0i4hNwKP9CGAlVcXZIAOAU+9zGvK3MyjWnBM=;
 b=tUPa8t+OImzjM3/2s23OjQ1XNQQv5gXRsNuyVTPaSFxzgOTGn3deCZhAhc44JDc8S3
 r4uyl26pghFRntPOwnTq3ufZ5yoigR3Mj7/LMT+ZDA5YTE3/ILgEAS3w4TyOOGWrThpH
 lj5p0aa4U7gUefMyKgNei1tAbshqfmW1Pf30KLD/wJkVGj6DZSPPxzaFBKIL8cPzIvVL
 lILn5YlrmLYLngwXd214OMPRLmNYD7a70yiLIHjX2AwV/htwb2qG0S1InkA6+evcdeyw
 4fFX1l3Knte1AkaSWKkg2kfXymxrWlG3A66FTlkHgvm9m7oxzHpsFb2ZFIvRKhQSjH9V
 2G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021287; x=1725626087;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T720AHi0i4hNwKP9CGAlVcXZIAOAU+9zGvK3MyjWnBM=;
 b=VZNk+yP4GBG5S6e62eUEFD2L6MhN92sl0+1S7dYRjNF1wfxoCJZ6lHzp0yMWuWNqBZ
 UfS4TeOCAV8nqiYzgn/ptbbvWB+vNlV9Uj1A9neXyojXD+y7Ynxg45J8YvgBq57cqIxZ
 PBvWZg7g12nvW8QAlz59R1rxsRaE9mxj8XnJQdq9Y7rTzhc/HPSOkCaAAYegO5GtavM7
 YeHTSrKLQXXKpVYXoqA9hAAQaVWy5zhcCZQ9iQCqV3Kbl4FEOMl/7uEy7sIkG7Ob+eRi
 4QPW3K8NxCAQ1gsXhTOmp7yKpthVa5QBtErrZTIy/JL7MNfTA0VhQGZCUuUt9UuMpHin
 yMuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVQJyEUyifV0iCQpLaO+906hbmn7CuNQOzhQTaZGbIQP0rGyJ7inVb8snLAiMDrM5db5V+mQY=@lists.denx.de
X-Gm-Message-State: AOJu0YxdS6cb0wQ7NzNLLIOO+A31o7TQnNmqMh7R4NpwHS9IDS8wgO7o
 uWTYSEn1pGjB+Hu7GUmU/fNKfJvlol7ZKSCL7ax1yVAdmPGUxDpM1njzfZyoOGc=
X-Google-Smtp-Source: AGHT+IFKO1YTo4DIL/hHbR9dTQuF8pl0y1ZmBARCkGDN9W//2H7E5AYURO4zGedcxZZByLUlj4eeGw==
X-Received: by 2002:a05:600c:3596:b0:42b:8a35:1ade with SMTP id
 5b1f17b1804b1-42bb02d94f0mr50289425e9.27.1725021286994; 
 Fri, 30 Aug 2024 05:34:46 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:41 +0100
Subject: [PATCH v8 11/11] test: lib/uuid: add tests for UUID
 version/variant bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-11-79b31b199bee@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=N9V0m2aNtjrngrrxhmdCcdsnP8l6Sxth44kFjZd/FOA=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxaMn3NkReWtygfjw2EKX7TErNPR4UvfQdu9
 g980KT7KB6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WgAKCRAFgzErGV9k
 thBQEACMLUIhBxGMbW8dBkMXmC7x3CLnX/Me6xo9ckTcaVAXaThgU4iXOdJabQRQZNoJHeF7xTK
 Sp/S/LbzaE+81ghlGDS54T9kj7ESCwDEen1U5GVOnzTurMJ7G2hKolRBdrim+UddYvitwtYP5d2
 yKCe51NHawyycLn/iPYamXSXPb3OYYnG9KGIxsnyYTwkrUbMfF3JCWNMyfldV2EoWUvksFv6Gtl
 IqT7fqKiCXuI+u8F7X+q+nUU7BeJTKvIzE6UMPQAfSxi1+wvW8rzmi/gUXOJemDkNjPywy5U62H
 0WyyXk+ARegKwpiYmyF8jGBrD8515UvethRqPb7L1qILUu7QX1kfOMcZq0kbhlclXKMYNb0QTMn
 uaO0tUNRGfxgYFMQXaYxkFj/csQ46WrZVDl7lu3sYgso41hD22GE+wgzn0m2xIWCgyme5jVS7MH
 axiaHaaOpNzEQOOSVzFAscRDE/uFeDO+xcE5Ka31fXrQNXwURWZUvXmALw+nze5heZKbqBxGaIA
 OvAngOjkCOxrXQM+gJr6VIAgtKIOMa77f95/GrfXB8envfjrWcKHP1PjXhrloIbtTqcQFhKQT9g
 MZHb2bCwXrXFEyd3I4Ppgt82oouUOlYyiBvA8bx81ZpMLdapnjhPvLd2XADM1xdkXsIRoXHUkLE
 CJnAdzDbeNwY86w==
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

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 test/lib/uuid.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 4a1a16b4f315..bf5d5afdb521 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -42,8 +42,49 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
 	return 0;
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
+		/* version 4 */
+		ut_assert((uuid[6] & 0xf0) == 0x40);
+		/* variant 1 */
+		ut_assert((uuid[8] & UUID_VARIANT_MASK) == (UUID_VARIANT << UUID_VARIANT_SHIFT));
+
+		/* Test v5, use the v4 UUID as the namespace */
+		gen_v5_guid((struct uuid *)uuid,
+			    &guid, "test", 4, NULL);
+
+		printf("v5 GUID: %pUl\n", (efi_guid_t *)uuid);
+
+		/* This is a GUID so bits 6 and 7 are swapped (little endian). Version 5 */
+		ut_assert((guid.b[7] & 0xf0) == 0x50);
+		/* variant 1 */
+		ut_assert((guid.b[8] & UUID_VARIANT_MASK) == (UUID_VARIANT << UUID_VARIANT_SHIFT));
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

