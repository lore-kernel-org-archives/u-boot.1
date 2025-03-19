Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4EFC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982A681CE7;
	Wed, 19 Mar 2025 12:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c+E42bXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C0EE81CAF; Wed, 19 Mar 2025 12:59:36 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9850481BC0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so28297695e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742385573; x=1742990373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHX1p3aCRXxT5WScXjhp7nHAhgY/lZhfe6JQVX91crs=;
 b=c+E42bXiC4EM0PbDG9CFt93rrVL2nLrNpYN5HZ6LhjFzo1GHVXTRdZ8DQSlPzuZzrQ
 i67wFgAnNQ7Hhn1Rty+IiHwFWr+uB/Nty3Bt+4UCeD0jXZSTlJ5G4+x82YkUYri8H06x
 9VWHWAvPPCjBP3yKLsEr4PghNPaiOkwRsPFII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385573; x=1742990373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHX1p3aCRXxT5WScXjhp7nHAhgY/lZhfe6JQVX91crs=;
 b=L/Qbvra9kNm005XB6nDgKhp1kRupr7/47hAD2k0lehLEgtmSG0oDMdeNOPbaltQUpi
 inilabrWDShToyZNOVkPbducpzRtBpNpxxUe2EDaIHF6j1TDyGCOiAg4FOqiUHIDcUuI
 PPnB3Pn/DnhkwUg4gJug7VoGXCpVqs3p4rFQwwP28cwyu7/8RqfZ64De7FBnZHkqBbYy
 QSA0dFz/iHa2+HQIcKMTUrZoxOa+seUQORRqv0bjzCuDjNEvPAqj+bCLgdq+/Xzqj0yT
 nvMwDysUkRXMsetPhSx67xItxluQtpLWciFmkXUEClFCSDwRVFpNqWMWwYVgjmIMg8Aw
 Xx0g==
X-Gm-Message-State: AOJu0YyneFEmTY04qiOFmg6KVNALPvOkvAc1DxXHGCeXPbuqQgR8BU1R
 mt/77HZkeAo00ynO2lMrD+ou2il8uRGceVy7NqJf1oq6bvQ9AvZTwnMscuLxmSvMEEYJ+87NEzw
 3kg==
X-Gm-Gg: ASbGncuVMQ+ky9e8SnkMthXvivy0jXqfyMDxVJFIRWO0u7Z5zk9HYdUdwfCtnNCypQc
 +9Ls2HhxzuOU4wzy8lRS6DccfZJZU3oQZLhDVg/vsTdaIZVbxbb7FIrjyhMMBox8dtfqOoH+kn5
 H2eQdcOv8SIp4IS/O6lXOJgtYIyuWxI7EugJvka9qLVs58cM4R+ZXNwgj1uF92W2dRMFbz/MLR6
 2pu1zsp44N5tT3JRz1y5HAlbmGlOHVB0Nzp4ZpRhFkjB9SxPRzO7nfjPXuM/Opp09nStWQ7LPQx
 Do+4Tf0t5uSMzSriDNq+f9E6C2bMtY57Gx7CRs0OEge1DdYZi17z
X-Google-Smtp-Source: AGHT+IGtU+0upbNEvHYeFx94M+vCujcccfLCQnzzlJmasyJNQOCAvsbktHqM1epgO0eBx2mTCvFUJw==
X-Received: by 2002:a5d:59a7:0:b0:399:6af3:7a77 with SMTP id
 ffacd0b85a97d-399739bf15emr2256865f8f.19.1742385573461; 
 Wed, 19 Mar 2025 04:59:33 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm20606906f8f.82.2025.03.19.04.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:59:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] test: Add a test for strim()
Date: Wed, 19 Mar 2025 12:59:05 +0100
Message-ID: <20250319115911.2204045-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319115911.2204045-1-sjg@chromium.org>
References: <20250319115911.2204045-1-sjg@chromium.org>
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

This function trims whitespace from the start and end of a string. Add a
test for it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/lib/string.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/test/lib/string.c b/test/lib/string.c
index 8d22f3fd68f..af84dd0715e 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -221,3 +221,34 @@ static int lib_memdup(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_memdup, 0);
+
+static int lib_strim(struct unit_test_state *uts)
+{
+	char buf[BUFLEN];
+
+	strcpy(buf, "abc");
+	ut_asserteq_str("abc", strim(buf));
+
+	/* leading space */
+	strcpy(buf, " abc");
+	ut_asserteq_str("abc", strim(buf));
+
+	/* multiple leading spaces */
+	strcpy(buf, "  abc");
+	ut_asserteq_str("abc", strim(buf));
+
+	/* multiple internal spaces */
+	strcpy(buf, "  a   bc");
+	ut_asserteq_str("a   bc", strim(buf));
+
+	/* with trailing space */
+	strcpy(buf, "  a   bc ");
+	ut_asserteq_str("a   bc", strim(buf));
+
+	/* with multiple trailing spaces */
+	strcpy(buf, "  a   bc   ");
+	ut_asserteq_str("a   bc", strim(buf));
+
+	return 0;
+}
+LIB_TEST(lib_strim, 0);
-- 
2.43.0

