Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06401C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1646B889BE;
	Thu, 22 Aug 2024 15:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AY2eOeHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D76F88B36; Thu, 22 Aug 2024 15:58:25 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088FB882B6
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d3b31e577so3750815ab.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335102; x=1724939902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMfLK4qvJQZyHXt3Aq4Aa7Pa8pG3wJunhXW5KOO4Zkw=;
 b=AY2eOeHn/ypzMs7tBeKVgop1rwf37GlMb2CkPukLJtE1H2LJb+CCjMJu21Jb+UOjwt
 aIMuX3VCPoZxLECgA83oIPYu9n44k/uutZHaSGJEJk7LvMgjCW/sM7oTtw5FD0kykpvI
 A0+zgd1fGbe3sye0psYnuwag08NQV9OFPaMPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335102; x=1724939902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMfLK4qvJQZyHXt3Aq4Aa7Pa8pG3wJunhXW5KOO4Zkw=;
 b=DgooT1+tjkzyA9TciyxZUf4rExM/FtBjdtgq7Xn3lalVpeGO/Pu2ny4a58eT/3jxX+
 2JdMBG9rxFsaHRRCJoV+3QGpz8p1JQyHD2WhE5NGzZHDD4U/OYwqeyKWf8ctYSfHXIGp
 nTVqHypsm6farxT9Gq4fevIrUMk4/XH4fgXw306TOdurHRr5Wb7Tf012PibrWsI/NcH7
 nm8rFeD8ZRHxInkPCb5macF9AX5DaW9WF6dp9FUulguO3IBzCGxHE3wGHSKKehs6dAls
 QaKGAv6FougA28+PtbyzlRiwUMHuEZgbMlbFxITczUD0wg18zhNL7u+bX/2uEGWD3CHW
 Fw0A==
X-Gm-Message-State: AOJu0YzQKJbvXUACBwFdI6efauPire07lQN/QXbwZJh9TeoEUNlCakEi
 7RJblX0FhcKLNA2rXv+V17aKWqBnWFHFTUpIkpVc9vbo2/+xp6gVjKnJ31/48ecmRNXtZ2lRxqg
 =
X-Google-Smtp-Source: AGHT+IEgn0FeMLe94qW1JCSY1zxCidG7dNujLs4tII+o6wEoU9tneLhkfRFEqlNRJo40/ylwp6fXeQ==
X-Received: by 2002:a92:c544:0:b0:39d:1157:74a9 with SMTP id
 e9e14a558f8ab-39d6c383359mr70986785ab.15.1724335101658; 
 Thu, 22 Aug 2024 06:58:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/19] test: bloblist: Use UTF_CONSOLE in tests
Date: Thu, 22 Aug 2024 07:57:53 -0600
Message-Id: <20240822135804.2375959-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

Set this flag rather than doing things manually in the test.

Drop the code which is now unnecessary.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/bloblist.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/test/bloblist.c b/test/bloblist.c
index 7c63682908a..fd85c7ab79e 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -270,20 +270,15 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
-	console_record_reset_enable();
-	ut_silence_console(uts);
-	console_record_reset();
 	run_command("bloblist info", 0);
 	ut_assert_nextline("base:       %lx", (ulong)map_to_sysmem(hdr));
 	ut_assert_nextline("total size: 400    1 KiB");
 	ut_assert_nextline("used size:  50     80 Bytes");
 	ut_assert_nextline("free:       3b0    944 Bytes");
-	ut_assert_console_end();
-	ut_unsilence_console(uts);
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_cmd_info, 0);
+BLOBLIST_TEST(bloblist_test_cmd_info, UTF_CONSOLE);
 
 /* Test the 'bloblist list' command */
 static int bloblist_test_cmd_list(struct unit_test_state *uts)
@@ -296,21 +291,16 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
-	console_record_reset_enable();
-	ut_silence_console(uts);
-	console_record_reset();
 	run_command("bloblist list", 0);
 	ut_assert_nextline("Address       Size   Tag Name");
 	ut_assert_nextline("%08lx  %8x  fff000 SPL hand-off",
 			   (ulong)map_to_sysmem(data), TEST_SIZE);
 	ut_assert_nextline("%08lx  %8x   202 Chrome OS vboot context",
 			   (ulong)map_to_sysmem(data2), TEST_SIZE2);
-	ut_assert_console_end();
-	ut_unsilence_console(uts);
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_cmd_list, 0);
+BLOBLIST_TEST(bloblist_test_cmd_list, UTF_CONSOLE);
 
 /* Test alignment of bloblist blobs */
 static int bloblist_test_align(struct unit_test_state *uts)
-- 
2.34.1

