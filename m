Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A77C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F74488BF0;
	Fri, 19 Jul 2024 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BNkQ/GYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C5088BA9; Fri, 19 Jul 2024 14:44:02 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B2A88B8B
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ea7d2a039so1480968e87.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393039; x=1721997839; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ANeWJLSnvDLVzkYEaJuKs+4UWkSeDquEqfDFghLMMHY=;
 b=BNkQ/GYq0mtfKnAjg1xE7IdOr4Q7bPn8EGymNVUaiJwbgPK++Y65fBrlkbaQPkog/6
 fTctw3aVIsDWm8b6Pc1PcTatcLs2oasBcgzWwu2P4RFi1sg00LR4jzsdNtUE83KGXnJW
 ckRaOor41f2ymv86CTlKlJ7TZ7rW0bpHlqPRCUGS2LtXLcHBcwC3+g3UC0X4AubdtwSF
 6PrrhrvMe3yOotgMNGfiLbKaqakZ15zOoWW/DCtV8usEdOgXZa/MjEA7tTTVijQ7DZqG
 S9YLZ/6TKhlUjrhcVO2oWYq4VmojySNXM3gRYZcxoHrACaxSNrqHGEjxU1SE3Sdjl8Fd
 jNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393039; x=1721997839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANeWJLSnvDLVzkYEaJuKs+4UWkSeDquEqfDFghLMMHY=;
 b=w2bUB8DBUFH6RbuaYKpoPEvvAx5n50YlrElaTCpY9R7LTvouIWLcoafCEKHQAqZ0EI
 QVXhTy12o3+gKJ6HPy4Eahylio8B/GyhTyOBnTBwp/iqcUyXKW3eAdJGyO0TSfpyKy+A
 hvQfCnAx85Gn9q5jyzP2v295iBUWWaW+0bpX2gwmTJO1gl1b9/sC/lseMZhP3gI5NogZ
 C3dmy0TjsrLj2G4iQSbW1+VvnXOH6Uy/NTBZX8klxxj5pRlgrifrlLzRE+nJzXEyVaLR
 impl9fa3t0wqWW8t67QS+mUC6eXHimIRtWq95oeWU5h9aFFnhuWBrsmPMu3tmCClrBz9
 taTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYmtCuLl59qmsuHKcpvRuKmYT2oEAaaJgGN2POnl1aXI9MUxWTrfX4obp7F7nFwsJA8UdPviwcEkD/cTB/eBifXg96mQ==
X-Gm-Message-State: AOJu0YycxgygCDE7mmhx+LWuNRtzbh4oRquc4xgtXCNR4ZFIJfhutZPc
 2O21YqQGhSsIca+n/62ma0WEFmVY4EUK1PxH56RUkwt49bf5kwgMSr+5Rf2+klE=
X-Google-Smtp-Source: AGHT+IEAsYgpGCgYS5TS4ibIN+SWNK045/yGX3jm81CzrgWPLVQGYAUxoeoXNILr5ibL5stL9fXyKw==
X-Received: by 2002:a05:6512:15a4:b0:52e:74d5:89ae with SMTP id
 2adb3069b0e04-52ee53d447emr5796360e87.39.1721393039538; 
 Fri, 19 Jul 2024 05:43:59 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:59 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:51 +0200
Subject: [PATCH v5 11/11] test: lib/uuid: add tests for UUID
 version/variant bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-11-8a83de3fe3dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=hbA6/H+9tCFtKZr+AsEDLwQ7R+IJkf/hHZEhk5YCMc4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+B2IRIraTAWksJ2+1aPhKLZ4UeYyzkBvtF7
 qW06OhCcLyJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgQAKCRAFgzErGV9k
 tuXGD/90faMRSkJe72+HEK2uM01mQsKVyNyqQ6uN1Scz1cPHFejrZxUyNCB3egGR1MvlKlvnxSG
 XmOoRQAJ9fsL29zrfUS7S7kj2NGGJqDNpO39ILkGTwuD3CsVOO4HdsH0OELdyxWyEt0L6TO7HYg
 k7S/iEogPL2EiuDoawxAxgF7R1h3Je9lAP0EinuwpVC6rIfSfdnIUGv7rdri/InY/1Xkc7k6UkP
 4HarBRL8gZElXNx92zBUKX9igsmPaTki/G5qUgiHl+/efL+auSkn/X8lkM73Dh7fXPAiU7+Wd60
 9uKmhg+ZZWMCclgCKprnaYhn/+Vq33h1E5oyqtAhFVC9gaHuZMStmLzKPWnu1n2ULBCfjNBt1xT
 9jpBzj93X31G+wa52XWpb8nfeP4sdHYFn0RB4Np39GuBodl/J0/WfBzre+r7H1ARwXSkCItQ+OA
 Cw4hHT6M5TPPP6hLJxM9N9Cg0wBzhfHcz4zvczdeq49Uu/vmKdCIp1AOsOOk/N8VR76c1kIwUrB
 maJUfEt/7NsnPiyMeS2kllDozLcKcpt+U2ZYlhM/3u8HFwz+N1yIJfV2egM/ctTKFU0kdDJDN+c
 yCkXUT8M5tMXwT9raau+zmDRDJEkXkwzVrcO0BCePZ1mNPkW5F1DF4jzd/C2fGZnjuFljWcsevy
 tyYNZZgupivLKBA==
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
2.45.2

