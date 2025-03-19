Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D61C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D4482148;
	Wed, 19 Mar 2025 15:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CUyAtX6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2893C8262F; Wed, 19 Mar 2025 15:56:36 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0CC825A6
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso31729755e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396193; x=1743000993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxNZ7s9k29k8a9e9nMmzVkQQsmCM+HfI6gzLbOQ3QIc=;
 b=CUyAtX6vqB4bIwWL+RA5QnzTb6oK1zJk5rtbdnVIgaLhNoE02mMfQ0qi14dobK6zsG
 vV9NmTa9qv/gp3SB+OxilRaYbE4IWYV7IsvKfgMpG8KQ9G4OHFAraYt7ywTmuCZFIZEc
 5H7EdZKwRpFRIrxg2OTHKvwPhf17G/I5Du1mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396193; x=1743000993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxNZ7s9k29k8a9e9nMmzVkQQsmCM+HfI6gzLbOQ3QIc=;
 b=GLfZdZayYkbs/NhCSZRH4QcO3HoasBur8psVOrZRzNvwDFgr+zSi4G9ZSiF+zo6/Rs
 Nm3mjr2bNSXC0dqCTRqmXYD9GyT6SoWolbL7leSGBiAbZngRcsxyfZ1ky4YN2ijpS+k3
 mUQC6iYvVmFMrfxLLrFN+wKb7HdOAz3K1SpchvQHkgIl0nN8N3GabJQkMcPh6u+SXnzE
 oSGigdH2NSr0IK1Mqy6fvp8e02tK+z3laxeQiemwoGkf4BOOwc/GAH5RW7XjAhImjZH1
 nRPy9QR0qVgckKisgdXWhaTSYF/Td1p9GroKS+cOgw1ONiVvW9XyTMFtgtIzg/NmZvp2
 tm/w==
X-Gm-Message-State: AOJu0Yz6mRQ/gxNnk7ACZIF4lFbp+r0aIOgiR1qhPbtV3ktfwUsXpskI
 x+hf9jCRySyK9GWgvXowqRY0JBiO9pM+cCwSq9LgUcw59EalXkutqU0auxJEJlgzQHoYGGOX1Pc
 =
X-Gm-Gg: ASbGncurtUEDBTM1TQdWChYq96fHW15HKb0it5VeaCLfr4+KD0c90+ctZ/nJDZarnYr
 FxpyzD0zSnAc9sKMEhJotECwlboN5QVTLZCGnMwOSvZaFPUZrs01sPIC0eQiRCTnEx7bKgtqsyg
 A+uLUeNytfS/4Q1J5xllHxVfKVqGJ1Vfuboo2x/Ee6mhT5XdWF53IW7/j8srHcaJmthuNeHB7tJ
 hvwlDZ3QgqxNpYYND0M84WUW7BfTyu+FVp+pL1ZSdiIVIO4H+mvswvbYF1Ol45ifHjpZ7WYdjsZ
 OzO3iN9QVuPldXJVihaemy4qyMmuOraDegzeKFbvHOcSkOQu5WUI
X-Google-Smtp-Source: AGHT+IGnWQGOCLvRFBob+T55YbXpUhcazI2A85ooL+dAzNqFNrLP9v2mLOLT0uLKHrM3TKE7rYdYUA==
X-Received: by 2002:a05:600c:4d98:b0:43d:54a:221c with SMTP id
 5b1f17b1804b1-43d47eb5a66mr9518575e9.18.1742396192855; 
 Wed, 19 Mar 2025 07:56:32 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 35/52] expo: Check the screen contents after rendering
Date: Wed, 19 Mar 2025 15:54:40 +0100
Message-ID: <20250319145512.2391122-36-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Make sure that the screen contents are as expected when a scene has been
rendered.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/expo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index a50e9f721de..ba60267f00c 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -11,6 +11,7 @@
 #include <video.h>
 #include <linux/input.h>
 #include <test/ut.h>
+#include <test/video.h>
 #include "bootstd_common.h"
 #include <test/cedit-test.h>
 #include "../../boot/scene_internal.h"
@@ -645,6 +646,9 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
 
+	ut_asserteq(10345, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
+
 	/* make sure only the preview for the second item is shown */
 	obj = scene_obj_find(scn, ITEM1_PREVIEW, SCENEOBJT_NONE);
 	ut_asserteq(true, obj->flags & SCENEOF_HIDE);
-- 
2.43.0

