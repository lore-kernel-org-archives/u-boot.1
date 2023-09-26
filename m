Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E005CE7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2B086E46;
	Tue, 26 Sep 2023 16:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P9sfygvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C44086DE9; Tue, 26 Sep 2023 16:15:53 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C873A86DF0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fa2125e19so254219739f.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737745; x=1696342545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQa9pnbD3nCd36s3/jUF5qJpCKnMoZ9NJQsmh8d5MU8=;
 b=P9sfygvueNvrapdfL9UZ+o7A7aTVnIkuzfhpy/xdhPdjhotSw7rbaHDu8NET3cKYt6
 gX89vONLdIxEtbksEwolElkkrAMgXL7vcb9fTNKZDarPjLahTqS4dbTyHFdP3RPqFEnQ
 xNJzYXtUbJHn2Kxlxjw8u7cnNM/FKaVsZJDuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737745; x=1696342545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQa9pnbD3nCd36s3/jUF5qJpCKnMoZ9NJQsmh8d5MU8=;
 b=Enpg2ShiOhC6km1yiOAFymGvdy2don5eoSEQ2Gme5iSA/q41slNrDbrhF6d6rgy2jv
 4ddnhhVUv8gIsJTz8+e+rOv/4oiwEiujgISg5K4TmtfEw/bWYmEW0fJ7Aj/11WX63rgP
 IdQqc3WC4Gh5GiAcE7omhDZ4mSUPTpxtGR2bpfcJA70YNLCt1v8Xv1ge2QVBtnsaAbbY
 263+zCPfOLGFh/2iU8pW8nKv87Y1zvB5vak/ua2PCVdtbMz/akE0OOlyFbm1BwKKQzD1
 KWScP0CZTaDtumzxy0gUwY3XUJBYP/yK4TZ2QwyfkOtJRse9oT9t/kVjlm/jUmlTfe+l
 ChGw==
X-Gm-Message-State: AOJu0Yy1cDtAdV5rnQJlsY8j3aWJipuT/rCRFfWJVbJcUD8xQjStaXKO
 tmhJN96u5MaDkeE0NWyu5Ads29Bei2jbO2H+wjo=
X-Google-Smtp-Source: AGHT+IFgIMDnZpA+peTfKnpfPozMelLKWbFIqE+VN87FZatNAOKpwtwWxD+VJ8B3OUcU+c0MxHJBcA==
X-Received: by 2002:a5e:a914:0:b0:79a:bbd2:8f5a with SMTP id
 c20-20020a5ea914000000b0079abbd28f5amr10729744iod.12.1695737745367; 
 Tue, 26 Sep 2023 07:15:45 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 22/44] spl: Move bloblist writing until the image is known
Date: Tue, 26 Sep 2023 08:14:36 -0600
Message-ID: <20230926141514.2101787-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

The bloblist should not be finalised until the image is fully set up.
This allows any final handoff information to be included in the bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index f3cbd6cef8a7..f7608f14e365 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -728,18 +728,6 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	spl_perform_fixups(&spl_image);
-	if (CONFIG_IS_ENABLED(HANDOFF)) {
-		ret = write_spl_handoff();
-		if (ret)
-			printf(SPL_TPL_PROMPT
-			       "SPL hand-off write failed (err=%d)\n", ret);
-	}
-	if (CONFIG_IS_ENABLED(BLOBLIST)) {
-		ret = bloblist_finish();
-		if (ret)
-			printf("Warning: Failed to finish bloblist (ret=%d)\n",
-			       ret);
-	}
 
 	os = spl_image.os;
 	if (os == IH_OS_U_BOOT) {
@@ -786,6 +774,18 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 				       dev->name, rc);
 		}
 	}
+	if (CONFIG_IS_ENABLED(HANDOFF)) {
+		ret = write_spl_handoff();
+		if (ret)
+			printf(SPL_TPL_PROMPT
+			       "SPL hand-off write failed (err=%d)\n", ret);
+	}
+	if (CONFIG_IS_ENABLED(BLOBLIST)) {
+		ret = bloblist_finish();
+		if (ret)
+			printf("Warning: Failed to finish bloblist (ret=%d)\n",
+			       ret);
+	}
 
 	spl_board_prepare_for_boot();
 	jump_to_image_no_args(&spl_image);
-- 
2.42.0.515.g380fc7ccd1-goog

