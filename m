Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073F7CD493D
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6FAB86D96;
	Thu, 21 Sep 2023 03:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A3LiN2Ep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED1786D92; Thu, 21 Sep 2023 03:58:08 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF3E86D7B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79329a8f78bso20548339f.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261477; x=1695866277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd5/hilknhcayViP68Eq5w07tYwW4pWcqIR2G2BOikM=;
 b=A3LiN2Ep4jKCnOSr+EmEq58ZFwICSrsAXUrzSIN+7wSts4VOBLth5OIUKw6axNkPJm
 n9J6YdBJCoKQ2ScI1TQrcnbDq8Yw3beY0wdLx4tCR27Sug4Myqv+KYm2pBHG9e6HITal
 9KvIyRXoWhdekUwIW/bFKZhZd+2YbO7EaR+zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261477; x=1695866277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rd5/hilknhcayViP68Eq5w07tYwW4pWcqIR2G2BOikM=;
 b=nDmC/5uNyJ40qo5TJPdXrn17sbRf+8kOsVHRJJorQoIiZfs7uDMy+f7vN0iqWc3ob5
 Qe+NtQ+fsRUQBD9/oZfpsICTyvUzeqi+Z/AwtK2oUsXYYbpPWV4jK/wbs/4PrJY9AaSv
 bY0LnE3FP96a0RyA10nTtDzPuOT/blW5WTa8UNL7FXfKCy/DiHZ1OfTb4/iXpo28oySN
 JyPF3wI2wWKPm9OiS5XNGKBYdbKU8UUkQkVU7Av/8Sfcww84tkTub8ea66Weic25PMGh
 9utJSnyEGDmG2G9eLIC7KLQGUe6pfRxr3s/pQEBLdDlzN1bb1ACWbOoI3rZecoc+sJrd
 ypqA==
X-Gm-Message-State: AOJu0YyJ2mF9LZkVDehHgkkM5rfjlu5HY6vxNHmr8NX9x5FGc71YodGI
 kBkXiV+rzBq2j7/KwW751lgr+H5MqDFAJeQjjVo=
X-Google-Smtp-Source: AGHT+IGe9JUEORCd91RPxd0jaZVibp0WCi7zElEtB8uzoBBhDnO29T1XMFj/lKGz/m2mbHJZ5D4iNA==
X-Received: by 2002:a5e:d510:0:b0:795:bea:ae13 with SMTP id
 e16-20020a5ed510000000b007950beaae13mr4482740iom.20.1695261477779; 
 Wed, 20 Sep 2023 18:57:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 14/32] spl: Move bloblist writing until the image is known
Date: Wed, 20 Sep 2023 19:57:03 -0600
Message-ID: <20230921015730.1511373-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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
index 1f0412b96b32..b554ea0b1944 100644
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

