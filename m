Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74096C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FC788C0C;
	Sat, 10 Aug 2024 22:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="immu0/Sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DFAA88709; Sat, 10 Aug 2024 22:52:42 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D6D88913
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f921c418eso81149939f.0
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323153; x=1723927953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xz7woLQAOj8OmfkakZYlMUOcPAGLvs/ICcNb81YaAW8=;
 b=immu0/Sz6rFQBXqQUf89dmnW6STd4BZkYlT4Kg78EdXcCAbYMZHI23pt9ijtcfWxIU
 Fva+G2VjAoM152DLxdzKc/0aasBX1Na6fiMKA37WkLViqWUBtjzbr7vWWf2H1rlgn1zi
 itUHDjrS53/n9dgi1Lb1RzIM5iVn3/TIJzjXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323153; x=1723927953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xz7woLQAOj8OmfkakZYlMUOcPAGLvs/ICcNb81YaAW8=;
 b=qWzC4aKV7/g+Vc5TbmkkFOWVom/1MzRFuzApk0v77JxnuB0KgLNtwI4BdRPCjA9sb9
 hcLJLlAQpncS3+hJ1tUOfYmGrg9GWDxj7N5tNpze5hz99FtIOXqOG+bFhC2b0LdAifTZ
 JgcBIZDFu6sLHEBnNLOU80g6mLi2Ykz1BkMIXOg7MEw4VRccWebVNI5jjZotEXuTrNg3
 3zicAPeLRPVCFiRzk50a7oRrLIDyjY6twBCzVSdBMW1ZnpTYUC3aDLIVCOl1b2ij7Ulh
 SwgIlrwdNLfRDc2Xezsci2KHf2Qztu2dLorCQlbwN5sp43x8otf+sjdjgDWb+kPZnGYl
 KhrQ==
X-Gm-Message-State: AOJu0YzcC76ArD3e5+VSB0uyAD1TMhO7d1uwvDcogO+k2n/v3a5WEGBH
 HgfLp1+/i19LEO8WgdN3hHje3nY+Bf1vhXs0G8msF8uJnZ3aq4vzTxqcCQH/yZ2ir0oEY1nIcac
 =
X-Google-Smtp-Source: AGHT+IGpm6HBvS1toL0kK07ySJnklxKe2GXrkj0l0VTOrF5ulIygdsNCTBfiMQ4aC+/QH6wlJ7AItA==
X-Received: by 2002:a05:6602:2d83:b0:805:2048:a492 with SMTP id
 ca18e2360f4ac-822546c3f8dmr965344039f.6.1723323152840; 
 Sat, 10 Aug 2024 13:52:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 14/21] test: cmd: Use UTF_CONSOLE in tests
Date: Sat, 10 Aug 2024 14:51:58 -0600
Message-Id: <20240810205205.3403177-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/pinmux.c | 3 ++-
 test/cmd/wget.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/cmd/pinmux.c b/test/cmd/pinmux.c
index 0b4e001fa1e..7ee92690756 100644
--- a/test/cmd/pinmux.c
+++ b/test/cmd/pinmux.c
@@ -36,4 +36,5 @@ static int dm_test_cmd_pinmux_status_pinname(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_cmd_pinmux_status_pinname, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_cmd_pinmux_status_pinname, UTF_SCAN_PDATA | UTF_SCAN_FDT |
+	UTF_CONSOLE);
diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index dd67aa445b8..121a426afdb 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -201,4 +201,4 @@ static int net_test_wget(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(net_test_wget, 0);
+LIB_TEST(net_test_wget, UTF_CONSOLE);
-- 
2.34.1

