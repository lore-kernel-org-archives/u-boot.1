Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29C7C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C47D82D05;
	Wed, 16 Apr 2025 09:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z4w+vM1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD87819FC; Wed, 16 Apr 2025 09:49:01 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92BE081E18
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso32576135e9.3
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744789739; x=1745394539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/YpWBwHbzNYNByi7oTR8JbpRYXKvO2rRetSjQ52j0Q=;
 b=z4w+vM1EcJJe0iqE62XkkHxPJwcWru9bqTU0npK+rbHhwdz0qTPtBksLy7H1xbvbbA
 kwYz5sGjw/vV1U2A9PlxWWXnNlkx19vYR37l1jqvdA1sUxWEi0UpuEL6MAQw2SKkk58M
 WlYzb/P9jEgiir2Zoi1k/VXQsLV6GfiPRDPFeaogmQPvMEcHyXPir984i0h+i7Qfm8gA
 dq6KfPmrQGfEnlF3jsm6jIj6rTFRkFuGJpiB+tEkQmrYTVvsdB4zmnAY0f0O79YpdkdK
 EWtrlA/IMPnARqAmwikgdll/pDlTBJhkaj4l2MCbqRhyEZTGZVj6nv831wr/VNFg0d/k
 11eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744789739; x=1745394539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/YpWBwHbzNYNByi7oTR8JbpRYXKvO2rRetSjQ52j0Q=;
 b=Ii85HSVrpPCvyTkF2Zx5qrNWFB9458KG8PzU3uXmdJ5aExPbVDh/TuozfTdGLA1LcC
 zeqMlrOgzLlb9ahFOVJ4zLK17W/ZqN5Sn3OoaKsJpremwaJPFxjzalYOXQCtSdcwbNn/
 wfPPBJ1U5AAI9t0lDNYVJr950FAu6DQZhtC466IRhY+CVp4AzY9plwqMONFyWZAwlV8j
 XPRwo4ZQP+rGRJUDeZbdVoQOu2D9azCnxQUC1gI5HWHwZ/YTj4IXCcaQ7fgyuAtVlGwK
 g2eINcPxk/y0smti8n1auqMyVZzRR1sGujueBzd5ZmXDcV+Xp0wyxaXGfCYfav0LZ2RO
 HWwg==
X-Gm-Message-State: AOJu0Yza3+YIbub/T2OkdgpBV5htBnWPzLu7FiT33b1r+oLNFmiuBSau
 lSEnRJ8Gic2yWCI170m0ST5Pe19NEVTjIde+75ZarM8rKGOpZKUaro1qBhdYutSGx0yh5nDY6Gk
 OIfU=
X-Gm-Gg: ASbGnctyF4v8eclJjzSYk/aQ4T5NQ+1iwiZPB0l26dxTD0WrMESzv8zBIdP1ztcfouA
 Bx6oMMSmC69yfKdl341AGB+fhSVN/PcvhEUcRpGpIZG46P/FlkLeSqJClXKQS+1oVBM2m7tW1br
 TOZAuqtYTuHo0Q6gZKXEcaAoVrAA1+cV6NKtHKP7VUbQC+Fd9zQo6nC5Ur7I9n5L6B+4jY4/N2Y
 PTIaV2UP5o1v+Sy0aihLE6MjqsjwuPwLWYxNb/GwnB1TJ12iNXfWB6JP4ojOq2I8s0xujRrzOFK
 CgyHPUUGTpQJH7VQ7wUKog9SDQWv3OSh9YcpaKDa/SzixihO4pQqxRwdxXk=
X-Google-Smtp-Source: AGHT+IFvhYsrOe6LbaBehhxp2GFChvCsPWuhs4r6nwEvUW5vybCQ7Qw7VwsjHXSwk1xc29afu+svYA==
X-Received: by 2002:a05:600c:1da5:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-4405d624d60mr8811695e9.10.1744789738716; 
 Wed, 16 Apr 2025 00:48:58 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44043529fdbsm26929035e9.1.2025.04.16.00.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 00:48:58 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 1/2] lib/uuid.c: use unique name for PARTITION_SYSTEM_GUID
Date: Wed, 16 Apr 2025 09:48:20 +0200
Message-ID: <20250416074839.1267396-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416074839.1267396-1-jerome.forissier@linaro.org>
References: <20250416074839.1267396-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The name defined for PARTITION_SYSTEM_GUID in list_guid[] depends on
configuration options. It is "system" if CONFIG_PARTITION_TYPE_GUID is
enabled or "System Partition" if CONFIG_CMD_EFIDEBUG or CONFIG_EFI are
enabled. In addition, the unit test in test/common/print.c is incorrect
because it expects only "system" (or a hex GUID).

Make things more consistent by using a clear and unique name: "EFI
System Partition" whatever the configuration, and update the unit test
accordingly.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v3:
- Use a single entry in list_guid for PARTITION_SYSTEM_GUID

Changes in v2:
- Remove useless braces in if expression
- Change partition name and make it the same for all configs. Update the
  commit subject.

 lib/uuid.c          | 9 ++++-----
 test/common/print.c | 8 ++++----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index 75658778044..6abbcf27b1f 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -67,8 +67,11 @@ static const struct {
 	efi_guid_t guid;
 } list_guid[] = {
 #ifndef USE_HOSTCC
+#if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) || \
+	defined(CONFIG_EFI)
+	{"EFI System Partition", PARTITION_SYSTEM_GUID},
+#endif
 #ifdef CONFIG_PARTITION_TYPE_GUID
-	{"system",	PARTITION_SYSTEM_GUID},
 	{"mbr",		LEGACY_MBR_PARTITION_GUID},
 	{"msft",	PARTITION_MSFT_RESERVED_GUID},
 	{"data",	PARTITION_BASIC_DATA_GUID},
@@ -182,10 +185,6 @@ static const struct {
 	{
 		"TCG2",
 		EFI_TCG2_PROTOCOL_GUID,
-		},
-	{
-		"System Partition",
-		PARTITION_SYSTEM_GUID
 	},
 	{
 		"Firmware Management",
diff --git a/test/common/print.c b/test/common/print.c
index e3711b10809..c48efc2783f 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -45,11 +45,11 @@ static int print_guid(struct unit_test_state *uts)
 	sprintf(str, "%pUL", guid);
 	ut_asserteq_str("04030201-0605-0807-090A-0B0C0D0E0F10", str);
 	sprintf(str, "%pUs", guid_esp);
-	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */
-		ut_asserteq_str("system", str);
-	} else {
+	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) ||
+	    IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI))
+		ut_asserteq_str("EFI System Partition", str);
+	else
 		ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
-	}
 	ret = snprintf(str, 4, "%pUL", guid);
 	ut_asserteq(0, str[3]);
 	ut_asserteq(36, ret);
-- 
2.43.0

