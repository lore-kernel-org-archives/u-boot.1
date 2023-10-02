Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D245E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFD187251;
	Mon,  2 Oct 2023 03:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eh1Et1+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C461186D5E; Mon,  2 Oct 2023 03:17:55 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4548887233
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso561332239f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209373; x=1696814173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G636tRYiSlUg8KjM9n50D9zqNh5Wwt3oWbHuGv2i76A=;
 b=eh1Et1+VgJCf117fbdv27Mk34w9BSxdz5QwYsT0Dt5snUyqxuFeS2n1dn6W5VuDwUw
 qapjvYRwLw1veRF7tMRdiZd+wAM7J9UaM382JeNHVTKAzwACteUJWAJADpiMzUhF3cnL
 m27JAULHkLdhrxuyNCWPmAM2ZChgetKTHJpws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209373; x=1696814173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G636tRYiSlUg8KjM9n50D9zqNh5Wwt3oWbHuGv2i76A=;
 b=SEIYmMmTNHr15U3OB7xX/FUmLEBNPX/FsKb6Y/N9FS6AWVo79NgPLqXQUetLbEiHdg
 35Brw1jk0dxnq+va/pjshHaYtW8l+V7RHlgo7pzLaeuBSl1z+IgVMDx4Bqw9ZR9uJdz2
 vpSw2sxIjlw8BUvqeXz11iJgV2ld7wSDLnmH2weW/yNehtERokbMgKcUpeaz/TKXW/pN
 HcCRFsnAN5EP/hrQD6+RAgzd2BHvLJyWO8LIgUby+bekVxtqBb8Mm2ac0Vtnn+7dPfyU
 ZI4Nme4bo6e0Ffx0iu8BjhSyIYyKfGMERvNCYWupwUeDrGWKNd4PFqWp1l2iWwXXiIm0
 iu2A==
X-Gm-Message-State: AOJu0Yznk/6+c+aMrjlzMD7drLrV2The1hrgy678sdDmYuMCh0JTUuwe
 dVYovMLIvRJIohRb28mQMQ+6bl+AWxhIL36ujC4=
X-Google-Smtp-Source: AGHT+IFNFj0y08iPJkYxdP7tbz1Vt4mtzpbNvMe9r7aa8QnfYRrf8SUPxG1N1v+Gl1nyDzSG7sRplA==
X-Received: by 2002:a5e:8c18:0:b0:786:ca40:cc88 with SMTP id
 n24-20020a5e8c18000000b00786ca40cc88mr12074054ioj.11.1696209373380; 
 Sun, 01 Oct 2023 18:16:13 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 10/34] test: event: Only run test_event_probe() on sandbox
Date: Sun,  1 Oct 2023 19:15:20 -0600
Message-ID: <20231002011553.463514-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

This needs test devices which are only present on sandbox. Add a check
for this and skip just this test if running on a real board.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/common/event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/common/event.c b/test/common/event.c
index c0912a3437bb..b462694fc3b6 100644
--- a/test/common/event.c
+++ b/test/common/event.c
@@ -92,6 +92,9 @@ static int test_event_probe(struct unit_test_state *uts)
 	struct test_state state;
 	struct udevice *dev;
 
+	if (!IS_ENABLED(SANDBOX))
+		return -EAGAIN;
+
 	state.val = 0;
 	ut_assertok(event_register("pre", EVT_DM_PRE_PROBE, h_probe, &state));
 	ut_assertok(event_register("post", EVT_DM_POST_PROBE, h_probe, &state));
-- 
2.42.0.582.g8ccd20d70d-goog

