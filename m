Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D4BC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E4F807B6;
	Mon, 20 Jan 2025 22:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PgjRmv35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD413807D9; Mon, 20 Jan 2025 22:54:02 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C61807B4
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a9caa3726fso14327585ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410038; x=1738014838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pzDRqHW8h8dn6xivqxI5Ad4jU5DNY9Esj46FGG9l48=;
 b=PgjRmv35k6vTv2dRbr38GOyGfkn9mHwGnrx/lQ2BHljGVM/APxBNIRcXx9eGAIcHwV
 BspHnFHcq8+zkUugcRtIlzH1TDa0RUtG2M1b60omp03/lz829oJ0kQO4W5ND5LL3v9Hh
 1+FYydZO9ZVB5dal+l/QoQC5jxhxSPL6PHdTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410038; x=1738014838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pzDRqHW8h8dn6xivqxI5Ad4jU5DNY9Esj46FGG9l48=;
 b=M+G4Wve9UOH46tP2CQUlOJaBmwDPzsX2Cb0fYVFZBlT+eL3RT1qPcJ5/7u47ppjiYH
 PvAHNGLllewP1jq4MOqeaBjkAdlR0q7rreuvr39HNQqBElCxfJFdcJoJHkQcedQczcoX
 9L7VBlArqN0IBRvCA7AAFvjbVOEdtx0x3sf5q41+A12r9ju2ctOpjLuen6SrbKOLqw4j
 brBrD06qSt3YM1ik/BtqbiLD0mI7nq54oLwCPsQk+82GOGrIYDapQHcgtz069FPykbR4
 mr8Xy33E4FqvFDlMBvVfSyVxr3b+K1xlv9bEceBL3Gi6ox4sfJCwOe6UXIshdHGbXxer
 VHEQ==
X-Gm-Message-State: AOJu0YxMxB2T2Bpyl3eGYxSBgv5mKBiqfPGo+B32s41Nqnm+skixr928
 GhFwEPc+4dPPOT+b58lk2ZJIOqPoFppMW6I9dMnpxqyqnDZU9ePRadGVQf8NwmWFZR5/8PXWmPA
 =
X-Gm-Gg: ASbGncsq4U1PyPA872Tk3tp2ewfZtuS9PDP+N/0O+CFUbaHOIBwaD0gmQJF95GRzlYF
 BP3NBZaGmfQT2cr9JAOHWKtxtOPWwHVc6+Gofxy+72yNo1nWe9tUe19RJEltleXj+e+dra52RcX
 2iOdErjbHrK1Y5miqY4jCIwzEMJto+3r779gzRPEBxRs4OnZSGX2fWBLKuS7ibZyNFSsCU+g8sU
 882tB82Cie7GBdFSxZl2j69U0illMCak4G/FkNGX8cgPvWmTm5ibostdFviWbmYy6SdB6jC3fX2
 qrAO5U2lMj6RqgRfj2S52qtTd8zQ8/Y=
X-Google-Smtp-Source: AGHT+IFCTCRby6KKPY01zazEymnCKWlcfsjAIxtAlok1joV0rNaWfqoRTEL8pbBvbxiKH3j+p4JkyQ==
X-Received: by 2002:a92:dd10:0:b0:3a9:cc7f:2bc5 with SMTP id
 e9e14a558f8ab-3ce849905d3mr175429945ab.3.1737410038648; 
 Mon, 20 Jan 2025 13:53:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:53:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/28] test: Support an init/uninit functions for test suites
Date: Mon, 20 Jan 2025 14:53:06 -0700
Message-ID: <20250120215340.617194-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

Some suites need things to be set up before they can run. Add a way to
declare an init function using the UNIT_TEST_INIT() macro. The init
function is just like any other test, but is always placed first so that
it runs before all the other test functions in the suite.

Add an uninit function as well, to clean up after the test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/test.h | 20 ++++++++++++++++++++
 test/test-main.c    |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/test/test.h b/include/test/test.h
index 877fda8d5aa..0f2b68a5dee 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -100,6 +100,8 @@ enum ut_flags {
 	UTF_ETH_BOOTDEV	= BIT(9),	/* enable Ethernet bootdevs */
 	UTF_SF_BOOTDEV	= BIT(10),	/* enable SPI flash bootdevs */
 	UFT_BLOBLIST	= BIT(11),	/* test changes gd->bloblist */
+	UTF_INIT	= BIT(12),	/* test inits a suite */
+	UTF_UNINIT	= BIT(13),	/* test uninits a suite */
 };
 
 /**
@@ -147,6 +149,24 @@ struct unit_test {
 		.func = _name,						\
 	}
 
+/* init function for unit-test suite (the 'A' makes it first) */
+#define UNIT_TEST_INIT(_name, _flags, _suite)				\
+	ll_entry_declare(struct unit_test, A ## _name, ut_ ## _suite) = {	\
+		.file = __FILE__,					\
+		.name = #_name,						\
+		.flags = (_flags) | UTF_INIT,				\
+		.func = _name,						\
+	}
+
+/* uninit function for unit-test suite (the 'aaa' makes it last) */
+#define UNIT_TEST_UNINIT(_name, _flags, _suite)				\
+	ll_entry_declare(struct unit_test, zzz ## _name, ut_ ## _suite) = { \
+		.file = __FILE__,					\
+		.name = #_name,						\
+		.flags = (_flags) | UTF_UNINIT,				\
+		.func = _name,						\
+	}
+
 /* Get the start of a list of unit tests for a particular suite */
 #define UNIT_TEST_SUITE_START(_suite) \
 	ll_entry_start(struct unit_test, ut_ ## _suite)
diff --git a/test/test-main.c b/test/test-main.c
index 8c0d820032c..ee855bfe2ed 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -620,7 +620,8 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 		const char *test_name = test->name;
 		int ret, i, old_fail_count;
 
-		if (!test_matches(prefix, test_name, select_name))
+		if (!(test->flags & (UTF_INIT | UTF_UNINIT)) &&
+		    !test_matches(prefix, test_name, select_name))
 			continue;
 
 		if (test->flags & UTF_MANUAL) {
-- 
2.43.0

