Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E675CA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BC088C85;
	Mon,  2 Sep 2024 00:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ILDtiu46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94AEE88C85; Mon,  2 Sep 2024 00:27:18 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825EF88C1D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-82a29c11f05so104535239f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229635; x=1725834435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vS89y8SRVsRq+czXLlOwga9oh0nVJz4HS03W5L5yO3M=;
 b=ILDtiu46SQXzKpFBh93qK81xKE0djbiSMtf2FrYH4ftEUpi331Ei0PKDNUhCBBfQ7s
 +2pVKgldVwgWw3TXmxB1CHaZTxAQDjrGjFIS8ScE3iAZSwkUZjM0c7iFUG1Mc7j49L85
 5JGY9YyHyWT2pFsvDDGpiXtw2bS4rxofDeX3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229635; x=1725834435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vS89y8SRVsRq+czXLlOwga9oh0nVJz4HS03W5L5yO3M=;
 b=JsUHF0nNP/ozBkBnFy5I5aPBNOyGSVhI+FSj92HvYpTwW4WrDPS+hw4xx+E77w5SFc
 0eo5KmQOqrh9xvxcmhMHZ9foFtzTuxA/dPeHzfPXcv0o9x4WEuKvPigftOQ9DAREViz0
 zSApa8/KbzRkfwwezpgeaUeU1jnxdlnkKA61W52Eq/HcvyK0UfDEEjaudNzOhAF78QrJ
 mdt9VsOIfOaFLceIvnbVF+YqBCCNe8STAE+UADE31HUnsBugO0yGV4J8ODnzpjKmaV69
 7bBbhZJGpRCLKNcEqknaJx2/OEOLj/WVTbxgAA3WOlq6fVKMVNq6SqKeumtKFwilwKz9
 QlbQ==
X-Gm-Message-State: AOJu0Yz0R6R7ed0zni4oLQUw6U3ZGNykkZ+sIHCd9HpT4zfBC6vW76tY
 cUb4MYd9LTsUy+PzWOdSWo2eRdO/lUKbuaR1g6QdO8qEp/VBDkLBtzBVO9SbjIl156hkitKTGRQ
 =
X-Google-Smtp-Source: AGHT+IHXhFNxkCpjw5Y09IvgWL2YgWd33pETIxlnvpEPBqKTjdCnpGI3yGHRWNipFSdv/cOnwPuGGg==
X-Received: by 2002:a05:6602:26c7:b0:82a:1e96:bce5 with SMTP id
 ca18e2360f4ac-82a1e96bd72mr1726410139f.10.1725229634709; 
 Sun, 01 Sep 2024 15:27:14 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 23/23] test: mbr: Drop a duplicate test
Date: Sun,  1 Sep 2024 16:26:34 -0600
Message-Id: <20240901222634.460873-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

The test currently runs twice as it is declared twice. Unwind this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Rebase to -next (on top of testc series)
- Drop patch to add UT_TESTF_CONSOLE_REC to bootflow tests

Changes in v2:
- Add many new patches to resolve all the outstanding test issues

 test/cmd/mbr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 72799612381..b14137e589a 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -479,9 +479,3 @@ int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	return cmd_ut_category("mbr", "mbr_test_", tests, n_ents, argc, argv);
 }
-
-static int dm_test_cmd_mbr(struct unit_test_state *uts)
-{
-	return mbr_test_run(uts);
-}
-DM_TEST(dm_test_cmd_mbr, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.34.1

