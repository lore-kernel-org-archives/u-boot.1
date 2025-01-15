Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FE2C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B9F280DF5;
	Wed, 15 Jan 2025 14:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E+BGspNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA93E80C99; Wed, 15 Jan 2025 14:32:33 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F502807E1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a9cdcec53fso48774235ab.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947949; x=1737552749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGKyEZr/2Y8x4YzqLPYl2RBGLRzYe8NFikVQJhE0NHg=;
 b=E+BGspNonGnFQit4Qm2WdKXvUqA/CW1/rzcck5yufancrb1CKYZYT3jl1DD4uSNfeL
 6oHu6pRqj0/qvXdyO6Qvhr/2eSI6jwopDO16FjbVQbRZ9opdUMaHZMPB2gs69VDz14jp
 xMoaY3xUDdm3mznVOTVRqSua5n4+kOpxmxNfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947949; x=1737552749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGKyEZr/2Y8x4YzqLPYl2RBGLRzYe8NFikVQJhE0NHg=;
 b=keNnus6QmA/R2TukTz94xYmzY3lPc1Gnc4kGcNVXxgmy+u7Z9jUkIY2vmowRynLTGT
 SnwR5JeSRGB/xqe0GzgIFBfcrJvX3Bj4cSfmgAlshfb1IWDq8Va9R8hV0ETdYkeKG7o3
 zFJtHrn1YWTUrMFOBVKO2H/W+mekDAqvQjKOhc4n/oGPp8lC94ezl8n5ktrMXOrxzFzq
 uBJstHSl5f6GBHznLyRk27aCAo4jqDdre2tzkxFW7oHVM0OwxjOb5rw88XUi8n+tgKxM
 5po4iG8EqAvS3zsDa+UQXjBUBDIuNxPQ9nRXjtVM79QSP4mPpoJczU2klP7m1mVk4nPw
 EPYA==
X-Gm-Message-State: AOJu0Yz/xhQjM3+DRBQ/G54Sj/1llhcDIJdrW04eXsmTS6IZ45Bw4gY2
 nFawUN7V2cmPETfds5tRqRU2/wE4EqUvMvTCUB/zhvQJeAj0XWMJVy9uSmrlW23Ng6ztEmb7usg
 =
X-Gm-Gg: ASbGncvdjt1ni1OrbQGaB3xfqlTlOg8ZIkr7WT3R2+sqYz8UA1yiqcax55zuMq1D8Ek
 A7uh2Gh0pjWeXNnmfTw0fjvtm5T9YJfSbKQApJApUckZgBP/yk8SPfgZB+wiH4XYLKwQ/W9DUyX
 M8XDDWfznS2VFkPX5E0L9xq9zTVG/0SdyX7rvHdjzdG9lrC2wWJ1OBgB0pVQX3XXjw78BDh+fFf
 rePo7dJD7ReOdiJcfn1kq+ssWgwJDyTIOITqHkA3UZVWxqn3UhK+PsQR5UpNzn55aSloSExXwhA
 FsRad4ywXlE1w7Wr9g==
X-Google-Smtp-Source: AGHT+IGoWoNHtPlP7RzfNwG6xcN/MbpX8s3NvvOD9YeKnMss7sjzInfip89C5E5LUQG2FfOYpsPhLg==
X-Received: by 2002:a05:6e02:1a86:b0:3a7:1a65:2fbd with SMTP id
 e9e14a558f8ab-3ce3a8bb194mr224356845ab.17.1736947949593; 
 Wed, 15 Jan 2025 05:32:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 41/43] test: Sort the test suites
Date: Wed, 15 Jan 2025 06:31:11 -0700
Message-Id: <20250115133114.590375-42-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Put the suites in order by name, for easier code-maintenance. This also
helps find test results for a particular swuit in the 'ut all' output.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index f33918ddd00..3afab422e4a 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -90,7 +90,10 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 	NULL, \
 	}
 
+SUITE_DECL(addrmap);
 SUITE_DECL(bdinfo);
+SUITE_DECL(bloblist);
+SUITE_DECL(bootm);
 SUITE_DECL(bootstd);
 SUITE_DECL(cmd);
 SUITE_DECL(common);
@@ -99,25 +102,25 @@ SUITE_DECL(env);
 SUITE_DECL(exit);
 SUITE_DECL(fdt);
 SUITE_DECL(font);
-SUITE_DECL(optee);
-SUITE_DECL(overlay);
+SUITE_DECL(hush);
 SUITE_DECL(lib);
+SUITE_DECL(loadm);
 SUITE_DECL(log);
 SUITE_DECL(mbr);
-SUITE_DECL(mem);
-SUITE_DECL(setexpr);
 SUITE_DECL(measurement);
-SUITE_DECL(bloblist);
-SUITE_DECL(bootm);
-SUITE_DECL(addrmap);
-SUITE_DECL(hush);
-SUITE_DECL(loadm);
+SUITE_DECL(mem);
+SUITE_DECL(optee);
+SUITE_DECL(overlay);
 SUITE_DECL(pci_mps);
 SUITE_DECL(seama);
+SUITE_DECL(setexpr);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
+	SUITE(addrmap),
 	SUITE(bdinfo),
+	SUITE(bloblist),
+	SUITE(bootm),
 #ifdef CONFIG_UT_BOOTSTD
 	SUITE_CMD(bootstd, do_ut_bootstd),
 #endif
@@ -128,25 +131,22 @@ static struct suite suites[] = {
 	SUITE(exit),
 	SUITE(fdt),
 	SUITE(font),
+	SUITE(hush),
+	SUITE(lib),
+	SUITE(loadm),
+	SUITE(log),
+	SUITE(mbr),
+	SUITE(measurement),
+	SUITE(mem),
 #ifdef CONFIG_UT_OPTEE
 	SUITE_CMD(optee, do_ut_optee),
 #endif
 #ifdef CONFIG_UT_OVERLAY
 	SUITE_CMD(overlay, do_ut_overlay),
 #endif
-	SUITE(lib),
-	SUITE(log),
-	SUITE(mbr),
-	SUITE(mem),
-	SUITE(setexpr),
-	SUITE(measurement),
-	SUITE(bloblist),
-	SUITE(bootm),
-	SUITE(addrmap),
-	SUITE(hush),
-	SUITE(loadm),
 	SUITE(pci_mps),
 	SUITE(seama),
+	SUITE(setexpr),
 	SUITE(upl),
 };
 
-- 
2.34.1

