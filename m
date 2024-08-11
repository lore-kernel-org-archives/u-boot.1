Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A2DC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6830788BC4;
	Sun, 11 Aug 2024 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GWgsxVDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C36888AD7; Sun, 11 Aug 2024 16:52:53 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD2388A8B
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39b3c36d247so14452915ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387969; x=1723992769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahAvCaLmjp2sdMvw31TMHsvRc8Q9a30fpGnHuGXBB3A=;
 b=GWgsxVDScj/IM2UWiOke+rGKmSi83dtEOllnw083d4ZwpO0Cj4yP8+zYsfdHwzXWc8
 02p7+XIfAi2pO22cE6jTAC6pg2ww74cF1WtaWox+nH/z4gslSwPx+hsXUiDx/ib3SGfR
 r2w/+4W5HlainlFn/cB0MSMdaq0IfkQy7qYBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387969; x=1723992769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahAvCaLmjp2sdMvw31TMHsvRc8Q9a30fpGnHuGXBB3A=;
 b=KLmE6obpM4wsJo4Kdw5bwHBoR5YxOJ8hY11PuUjAoWQGdYXa/trKMu4TqeNQ5l4nuL
 3Ellr7/FWT5pA7KTl0B/g/4jtXMsFWOlYqw/FHYE0tYLrcD2dC6l6aUjloE/tQlYWuJ4
 bO5PRiEyWwJQNKmruEjSSInCKO3RyPeDbz0VnuOCKTcMjrScZScWqxXSecpC76UFfmkL
 kLw/7PtM2uWdMDaFXVe3k7ElmzxE/aZl3YH1miQfExir+MnBKxowzq7pnlpuTyySIRmJ
 fdxUWsrOyx7gsQ+rhurn/5J+xOStl5miXEnVQHc14XNyJ/AmOvJ0F6OQ4JUD/5XCePGg
 DDpQ==
X-Gm-Message-State: AOJu0YxF+pmHkP/sa5ntW5Zzk7sZ5ZNYMaWc+7Jt3h82Nl1X1CIbbwIE
 ztk2NoLCAMikXHfCxR6qHWNm/uAo22YAkDK9o/SXTolr3vQUTOCKpsPM709uOnAhbkagMntupPc
 =
X-Google-Smtp-Source: AGHT+IHPalbMQCQlP4hJbpmJN4RCJwrVdIHJ6ElmA0l4woBuGmxTTrSZ0vmw6C9Xp5y7MWoYJaa6Ww==
X-Received: by 2002:a05:6e02:1a6a:b0:383:8ec6:6d17 with SMTP id
 e9e14a558f8ab-39b74840d5bmr92023775ab.0.1723387969666; 
 Sun, 11 Aug 2024 07:52:49 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 24/40] test: mbr: Drop a duplicate test
Date: Sun, 11 Aug 2024 08:51:53 -0600
Message-Id: <20240811145209.4191404-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

(no changes since v1)

 test/cmd/mbr.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index ec19cf3793c..2beaf9a75c5 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -484,10 +484,3 @@ int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	return cmd_ut_category("mbr", "mbr_test_", tests, n_ents, argc, argv);
 }
-
-static int dm_test_cmd_mbr(struct unit_test_state *uts)
-{
-	return mbr_test_run(uts);
-}
-
-DM_TEST(dm_test_cmd_mbr, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
-- 
2.34.1

