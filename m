Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B143C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB51288C15;
	Thu,  8 Aug 2024 18:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h5I/NyoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0000988C26; Thu,  8 Aug 2024 18:22:31 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0231588BA6
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bb85e90ad5so1020588a12.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134149; x=1723738949; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ztwhd2ZuT+o4pxs8M/oCKxJB82w+kU6FY0AHck/2yUU=;
 b=h5I/NyoNj3YeF/sx8s89uXHd8iMrwAqB/BfFWmStkGWrs44amNSpizIDOV/rPGIPtf
 OdmFHBZAJglXd0RGp3KJ4yzArUuX1rKrleJr8x+EFR8mBqEx3eFOplzaZAc9VutygPKq
 eHLWTScjgTOyFzYgfCvOc0om8VVfkEnCxl+8J0pRQ2KS4YiN0Zy15mm4+nbGIrmxpqie
 J/dnV+tp4z+rg3COTIkakCmue2sxjpiqn3V4+TReKkccsqRz4I81EjZxYN66dqYBQbHx
 m2ugEzEYJgh4yDjz3SLqHeIwd3J1PwpX74MWDsEeruk80nrt/x96BCXb2v6BfCDvNwUw
 zkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134149; x=1723738949;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztwhd2ZuT+o4pxs8M/oCKxJB82w+kU6FY0AHck/2yUU=;
 b=eCp5cxK4WzFm0wdbIi9ol6opvoqoGeN0YzoLu6Q75pwHf4tRiMtuhbFaox0u5sjyr+
 Zahl0RyxaGEL0eBgelQV6jlRBQKHN3kMBQxT50T7rSqccnvRRInRlZ9vDs4C5KBLA5e7
 pbfZ0A5ZrTKo3LeNV+8SxHC30jwCR5ozzxX0lWeMT9BrPZvgbtt6pUqb+2LPufJoERdN
 ZuPz7426SNsHTn11qVmdeSgZhEziLMs5Ytbs8/hEXBi8YStkyOf3o/qvkr9Ek8nBh3eL
 F3v707jv+goNhQEeguovd/m84nIL3zDDFdW5R5OpZfYBsMe+EzFDRtx+uqSTDBLkIY8K
 LAVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjk0SiipjR3PJ00zNI9fc/eXAZKBh3OzJiceoDjfr9sduAhJQccawI9NPWc3/gr8EXarcUw2WVxvURScB4Van8YHWTNw==
X-Gm-Message-State: AOJu0Yz+mZPQEskuu9uFAzfYlumeFvhDbd7PYFJ22MzW9Cfva0SWDteL
 bY67unSqXOw7ck5Gp601MWp+VGvNeBN+JVBMhMSl9wvLGyKMP4kTYQ5n6POuGjw=
X-Google-Smtp-Source: AGHT+IFNTQ3CEoSwk8/pbzpI+a92V6ZyH4kuKYM23XYw1X2hUcZtkT/gAGPRvAjkzhFELtARN6HRtA==
X-Received: by 2002:a05:6402:5110:b0:5bb:9ae0:4a40 with SMTP id
 4fb4d7f45d1cf-5bbb218dfa2mr1765979a12.3.1723134126427; 
 Thu, 08 Aug 2024 09:22:06 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:22:05 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:58 +0200
Subject: [PATCH v6 11/11] test: lib/uuid: add tests for UUID
 version/variant bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-11-9332e7237119@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=G4EtFnGoqlTV6gpf/ePg33yHy7zDVAcPqPA5aHctUos=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCg/H8cc0A4r+lvlr/l70Z2HlRyjMuMvFCYq
 0Iqy7Gl6QCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwoAAKCRAFgzErGV9k
 tsI1EACRhE25ZxWEAK613GDGiRmV2EygKsgmrTyLyc8XnIarAiw+WLzkZfDbaau0jPb6izMoXI1
 owr9Jn+yNQb1c5Yj7kNqr7e8lSxQXz8a5h6/BJA7/UiqvqegwdrZAW2NxN46zkNNbJm7GpUCpG/
 kdosFQE/wv9SzHelSy3CSUmeJJMKsc5566Hwe04RWgupa/OYAUXUtUs/EAg10mxqge4RotlWV8f
 WQKfoDjWtBy9kizFniVrV1vN/9BEFt0ktpRscJN7ezSM6NjmDAO407uzcft+LtqIiDEDVAzTgGJ
 8OIQyqrcm0chCvUskTuUrZ2Yb5oqs/I92qlp/aabrHOScAaoGCrsMIaeJ+1nQ7UGYOi2fYQv0jp
 I97pvvYBraybQuS88HQDQokpd85TTl/S4SnD87UfjQFAFqWMooYylCFJBV6MxZSWScwUUqaa0br
 0rQpAkcM/AxLHCF7H2DE6a2AAizqfhhO6yTZby5yfPA5CdiI+YUodgZmbdRFF82TlzHT3yZYZSs
 CB1QdxLgMZF3joVJClTCWGu2ZAokAVtTRnHhoTL3xOht7nysLJGq1IgaObkaYLPiSsOa5J+8YEr
 I6vX8OkaRTVfZ8Jbprd2pQsmOwWPmogD3qXdtO+SK7UzzOc23I67NJTtjPONwwBv92vtXDENEEG
 FEdeyOr1WXSKLuA==
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
 test/lib/uuid.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/test/lib/uuid.c b/test/lib/uuid.c
index 2c6cfd42ddc3..63d36e120623 100644
--- a/test/lib/uuid.c
+++ b/test/lib/uuid.c
@@ -43,8 +43,44 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
 }
 
 LIB_TEST(lib_test_uuid_to_le, 0);
 
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
+
 struct dynamic_uuid_test_data {
 	const char *compatible;
 	const u16 *images[4];
 	const char *expected_uuids[4];

-- 
2.46.0

