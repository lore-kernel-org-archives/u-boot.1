Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D6ECE7A8E
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9A983F4E;
	Fri, 14 Nov 2025 10:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PwpXhJck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BF883FE9; Fri, 14 Nov 2025 10:33:01 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D1B083FE9
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A884C3FCA1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763112774;
 bh=g+FD8SJqcaOcVFDceLjBei8eZKFOXdMHQmM6Ahqns/I=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PwpXhJck0zzZswbwAixKMMXBg5if9woLentfmlR2rHUcaUGPbBqqP2Za5irt/TnEC
 BjMa0dSROz7OamKh+Go81K8tUoOnwFfq808bZF35B/4la2c4UFdztJNKN8vQDFzbQf
 0a3tpccY9gLAX/2sS2cUWyFQzsA10hwc1ngBaubank5TZk2nA0CxGT43wJi9phL3oQ
 OuN4/uDFpiOrcLoIE4yccls1pf1V4+HFa1Vh0TBERFt+15r6M+0cHQeucWe09r4vjn
 TDOhbtw5c9ktQUjYwaVY+i/wtfLFm46dQ4SrauwDGtQDjJZYmD86sG4ad8Io181Imb
 ererGrrMdL2d8J6FU976oMS5cnvVNOWRXg6ydRDO/54ws6cM5ZfPTgSFpfEW7nseXb
 nX6k+lt1/NC+WVq66qS3vf2KmMSaEmNUF3k1jL9uksdmK2MJgcb8Vp1vhNzY4yf3Md
 u5Ym/1qecLo+A0khf3ooVr1POyYIU2rJ2QOwIwQV2VyCXG0pGFaqhha6GBIsB9akay
 5Q6bz5yAzDJpxS9tcaXRCuP5pwzMWUb4tZZyHWNwFQ0e+zMkCDb6SlTes3DXew4iKS
 lX591POuIG2nVH82DxaKGnt8WDLCCBbZ4BpZMAy/xPMcjNhAPBfPeiZTG+koQqtCFc
 1nG550LICFbQRtaZA0Cc7iT4=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47778daa4d2so14347865e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 01:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763112773; x=1763717573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g+FD8SJqcaOcVFDceLjBei8eZKFOXdMHQmM6Ahqns/I=;
 b=kke9Vtc2bdcPXRVxdODj5XBmQp+t3DfnED05hkLNUL8eZ+EZ60Yv82WIHgXjsf7SLT
 i6PUbzrp8dgKdoaCm+41pJTsjqhfFf1O0uAmCl2u0lK8wMFJCHUor7r/UB5c1VOlHHuf
 pyKlXZQ/F9eQ7CmXB3qt9XaHru8MfmBru6E9xyno/8C/L2xBjlE8fthyORCwxKGQafcK
 uehnlzPvxhjI8HNCoUPh6RNACZOFi5+qVOHT/ct7XY41I0jB42rby2NfvfmzDhsRchwK
 1ra0puOLEC0zcgS2pv4DM0MDpnW8x8iTjMU1+XDRecfCDSg9dwnC1IUVYM9DgrCurxS2
 4OEw==
X-Gm-Message-State: AOJu0YwhaJSDBdWg7u3kD1AJPxrd9/uYiw8Qu9+w31udwOWmff5hQt7j
 p6PMk8E62gD6wo+QyHV/mDRFRGRLcoXDEzEcWvsAliBrPXRdaCiLSVdJEoORoTpjwSvMkysoWle
 gThVNF0eDu7a/A3VA7IhQkoCOsS23YDFS/f2Dy8xtbnz52em/sUXNPHs4JIAi8HNrasprwYXg9Y
 PP75rBwQ==
X-Gm-Gg: ASbGncuakMXHCi/qGQqR6KZSDqYIPD3Mr/MW/i21fp0nR6XhGl30ScGbw0vThRo40jt
 CHF3hm3MRKhEOIGGs91on/xrEFVqdRtmNTyp11Z4vyNV8/3TDVYDRJmxKXEMVaIZhqc0SGCLYSq
 m2kcNFbfBYsu9SIjZs67dEmFVUtnhm5U8yJ9yU0ZDvRFrX6gXngxb/31e9QwrGHTefzK/wZimho
 ZrA044QOY2SKM2kg636Kg4VXw3RwvRrBzhK0pBIvkZSXyN9/DtWM3axqsF+OHi8Eh7jmT0/jvkH
 lK3AIK8/YzfM/GmcS0N0r7Ap1aeHK5AKKgHyy7BAdMfqXfk1L6u4Z2M4W/eL/f7Du50BVLlUe94
 idxEcSytbp9CmuxswOm8+5EqqlSxeSWIEjyJbHdJld3Ccw9Dw9Ml7HLkAgixrdCMshA==
X-Received: by 2002:a05:600c:4753:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-4778fe60658mr22338395e9.17.1763112773522; 
 Fri, 14 Nov 2025 01:32:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO0ZGwr4sY5l52sl4NZlCsRqV/MRR3W+rGBZ3j+/AFif7XCDo2zqAoDmsLaYY0fgj1ZbYOPA==
X-Received: by 2002:a05:600c:4753:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-4778fe60658mr22338145e9.17.1763112773159; 
 Fri, 14 Nov 2025 01:32:53 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c857311sm85462825e9.8.2025.11.14.01.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:32:52 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/7] efi_selftest: simplify efi_selftest_rtc
Date: Fri, 14 Nov 2025 10:32:42 +0100
Message-ID: <20251114093246.56422-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
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

Use global st_runtime.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_rtc.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_rtc.c b/lib/efi_selftest/efi_selftest_rtc.c
index e9e47e96c4b..54d4e786a8f 100644
--- a/lib/efi_selftest/efi_selftest_rtc.c
+++ b/lib/efi_selftest/efi_selftest_rtc.c
@@ -12,22 +12,6 @@
 #define EFI_ST_NO_RTC "Could not read real time clock\n"
 #define EFI_ST_NO_RTC_SET "Could not set real time clock\n"
 
-static struct efi_runtime_services *runtime;
-
-/*
- * Setup unit test.
- *
- * @handle:	handle of the loaded image
- * @systable:	system table
- * Return:	EFI_ST_SUCCESS for success
- */
-static int setup(const efi_handle_t handle,
-		 const struct efi_system_table *systable)
-{
-	runtime = systable->runtime;
-	return EFI_ST_SUCCESS;
-}
-
 /*
  * Execute unit test.
  *
@@ -53,7 +37,7 @@ static int execute(void)
 #endif
 
 	/* Display current time */
-	ret = runtime->get_time(&tm_old, NULL);
+	ret = st_runtime->get_time(&tm_old, NULL);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error(EFI_ST_NO_RTC);
 		return EFI_ST_FAILURE;
@@ -63,12 +47,12 @@ static int execute(void)
 		      tm_old.year, tm_old.month, tm_old.day,
 		      tm_old.hour, tm_old.minute, tm_old.second);
 #ifdef CONFIG_EFI_SET_TIME
-	ret = runtime->set_time(&tm_new);
+	ret = st_runtime->set_time(&tm_new);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error(EFI_ST_NO_RTC_SET);
 		return EFI_ST_FAILURE;
 	}
-	ret = runtime->get_time(&tm, NULL);
+	ret = st_runtime->get_time(&tm, NULL);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error(EFI_ST_NO_RTC);
 		return EFI_ST_FAILURE;
@@ -84,7 +68,7 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 	/* Set time back to old value */
-	ret = runtime->set_time(&tm_old);
+	ret = st_runtime->set_time(&tm_old);
 	if (ret != EFI_SUCCESS) {
 		efi_st_error(EFI_ST_NO_RTC_SET);
 		return EFI_ST_FAILURE;
@@ -97,6 +81,5 @@ static int execute(void)
 EFI_UNIT_TEST(rtc) = {
 	.name = "real time clock",
 	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
-	.setup = setup,
 	.execute = execute,
 };
-- 
2.51.0

