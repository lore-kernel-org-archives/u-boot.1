Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A867BE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D7B8714F;
	Mon,  2 Oct 2023 03:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h4SYp1RU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41398870CE; Mon,  2 Oct 2023 03:17:11 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25F687213
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3513fa06bafso39326805ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209364; x=1696814164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hfv81wnUOYZOEjODEIzSWXAm1vxcGBUol+0KBIOf2M=;
 b=h4SYp1RUG7VcP4fzRwcsfBlOTbyt7FNJEkjr79V/4i2c8MldWwZ235uqnVJSK1M4Gs
 dbLdv30IsWSe4dAACiefzZ2S38e21uM95+spxMa2zIGtxZmA5nrp6xtpf0XM00/Zw+Tp
 VfVO41Pt9e2OR1lOArhOKRje+ooF15jnACh9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209364; x=1696814164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hfv81wnUOYZOEjODEIzSWXAm1vxcGBUol+0KBIOf2M=;
 b=DsdIaY7MWXDVwiHeYFpXKrJQEth+DT90qZe3C3pBGVKywYc6tilehF2/Vvqh1JlJsw
 peBcwhNM+5K6BI7YUIvsuLzPV8eR1umticqMQXsmzI3WJUn21YXzmDGzazR7dWiZkXVb
 6FGZxfLtDV2RvchNDUUcSYZWcHMDYtQFZ9Dp7tg9HbpiAwWn/jqrWLHPRfl8PpWvQARC
 jrSsYJeO5H6EQjaATgTpCCkNwnQ50ZGy8P1r+wWed8wmm/ZC71liJ2T+RUNzCIekkxvE
 AkVxxFWPndjHpCNddyq75acs5OGDT/SBw2h11mjVv3EKidTH/LmkRZTSF1tZ/nVYKt1i
 U2xA==
X-Gm-Message-State: AOJu0Yx80XrgQpaHpNBicNtXDq8iaBzBDlod1rNdG4rlIKKv67vyJVKB
 VgBPVM2LMgZHL0Phzrh3ls8rSvMZ3QgJVEw4Fxc=
X-Google-Smtp-Source: AGHT+IG3pRrbYeCXeBeu+604ipbsNLlKv6QC+SmHorlPhPkye59sUQ1T51+VfSoRfzZP+WjEK+IFxg==
X-Received: by 2002:a05:6e02:1561:b0:351:4f0c:b968 with SMTP id
 k1-20020a056e02156100b003514f0cb968mr13243018ilu.19.1696209364034; 
 Sun, 01 Oct 2023 18:16:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Michal Suchanek <msuchanek@suse.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH 01/34] test: Run tests that don't need devices
Date: Sun,  1 Oct 2023 19:15:11 -0600
Message-ID: <20231002011553.463514-2-sjg@chromium.org>
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

Tests without the UT_TESTF_SCAN_FDT flag are currently skipped unless
OF_LIVE is enabled.

Drop this condition, so that they can run on non-sandbox builds, which
often don't have OF_LIVE enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/test-main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index 778bf0a18a0f..2a3b2ba364a8 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -476,8 +476,7 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	 *   (for sandbox we handle this by copying the tree, but not for other
 	 *    boards)
 	 */
-	if ((test->flags & UT_TESTF_SCAN_FDT) &&
-	    !(test->flags & UT_TESTF_LIVE_TREE) &&
+	if (!(test->flags & UT_TESTF_LIVE_TREE) &&
 	    (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
 	     !(test->flags & UT_TESTF_OTHER_FDT)) &&
 	    (!runs || ut_test_run_on_flattree(test)) &&
-- 
2.42.0.582.g8ccd20d70d-goog

