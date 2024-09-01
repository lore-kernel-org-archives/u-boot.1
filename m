Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB4DCA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9B9884C3;
	Mon,  2 Sep 2024 00:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WWAJrivK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D84F88997; Mon,  2 Sep 2024 00:42:25 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 004E0879C1
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-82a29c11e53so135339239f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725230541; x=1725835341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wKvbsN6+lSwqh25gRhuPc1UnhEqk4RN1ynSiw55H+/E=;
 b=WWAJrivKGn5zYIjAZhM04MqZnG2OvRJaAnHSiq4mElxEz/2bY85hDFecjH+X9hYayk
 NKO8JYiok+e3GZ3U525M5xXbODY6Oex+ezPA5/i9nkcCj+9g/2pf/t0i0fsA4COORchj
 Y1iIsNStrY6c0xSguRW62dBspoTx6Nm09uTZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725230541; x=1725835341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKvbsN6+lSwqh25gRhuPc1UnhEqk4RN1ynSiw55H+/E=;
 b=cn3tz0WVvz8bdoQBtW51SrUqHWi+qpngCu1Gfo/6GaAzMt+CaFNx3Mc2RlhVXArA/G
 O/k2LHr1vuXJVyQcdRBS1drrz/zlwmM3GHS4iLUShqTyNFyEIpTneuESxO/ocGwZKrsW
 BWPnHZfc9GS4fJ6lmBkc+JrTbHwCWcA1l+DI9o8KuteTNGS0EuM/ogzT8CIqFThLysA/
 rxK9ztwjJgkrJOYP4Fc60b67VLB3xJJ89iRIbUXi474IanUAxBtqz/w+hgtc64FDHKyu
 AmCaBxa1k7LrnnygFH1C99FqVu5ICfWJ3bATIXMbATb0JnqlbvuVgU22/NZcg4ae0xUq
 oRTw==
X-Gm-Message-State: AOJu0YwvZ2tA+To9ZQEMCbDSjSQYSVl5w4Z8ouMUKtLmGtVH8RnbV9bF
 kOJ8WQCAUfaQXsuBHARuMynxrH85xz21yW9f2jdAz0GfI/9vUwhcjilYlgZgXfZePvA75Y6dugk
 =
X-Google-Smtp-Source: AGHT+IHNn39dxIXFocitny1MVMOFlm9pekGRq+xceZTLFuTJr9UXVS8Yt/Lo73sSlAg81ztbawz2ig==
X-Received: by 2002:a05:6602:13ce:b0:82a:2d17:4d8a with SMTP id
 ca18e2360f4ac-82a3730ad6emr591366139f.2.1725230541260; 
 Sun, 01 Sep 2024 15:42:21 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2eaa613sm1867924173.122.2024.09.01.15.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:42:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 03/24] bootstd: Add UT_TESTF_CONSOLE_REC to bootflow tests
Date: Sun,  1 Sep 2024 16:41:53 -0600
Message-Id: <20240901224214.591389-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Quite a few tests use console recording without indicating this, using
the UT_TESTF_CONSOLE_REC flag. Fix this to avoid strange failures.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 6ad63afe90a..da55d5cfe69 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -362,7 +362,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
 /* Check using the system bootdev */
-- 
2.34.1

