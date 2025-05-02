Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09197C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FFBE82B48;
	Fri,  2 May 2025 16:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZMZD6Hps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA7282ACB; Fri,  2 May 2025 16:48:53 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A622E82BA2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b41281b50so70065839f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197328; x=1746802128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElpDlGC3Lo4bmxogkzi1PzOq3oii38zVugZwBgivcEo=;
 b=ZMZD6Hps/8NAqYjKiOD5FY86jb+slGtm96a1aQ1A5nqyu88YXVbwmo6QbVjKFPo4FH
 8LMxVuIo1H2gzKvYuH3z284TwLMWcrQgbb986ThFUqKZmqPKjNe2kRCjjkHfIkHEwikt
 uiP6+t+ymCULyexy5G8crGx838hEQFGQPPCy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197328; x=1746802128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElpDlGC3Lo4bmxogkzi1PzOq3oii38zVugZwBgivcEo=;
 b=e7HhSvGhGcxTuQ4pQouG5nsh9Kg0yg8V4VXZPJzMpUlH9IQafXDeJZ46WPVQKBIUsU
 OzJgBCD9MhH/P+gkYW27a24K3ozK4R83Qo9VQK0eRnAsNYwYfN8+YGKeKrSaM1uiQ9An
 SEa0kjOBJ7Sz9p7Uvr2+WYMHiahEDiTzeKaw67eFzqy6UwOzFLi1llCtwvRMzLuw5mfS
 yBrUWYEALE205JotZSWUlL2MwVwcOoMMsrARZ6/scXbiJKP0i0czy1ECnjNMo41yfqyj
 oPPANSJjKQkbuKPBF0Yuuh6FZPR4aPWlgyIbs3uLofNbKSIH76M5P+KpAtX5A3UhXgAw
 Vm5g==
X-Gm-Message-State: AOJu0YyLSB2lWLjZpkcU4R4SKXGbLOm1BI65JyCxlkg+mH5Mh4ru0tTY
 XMXDjZBg/lpcHDImGupZSeNAODPRekpp3E1YRQB/O7l7uUq93q6aPw4YmkWOhDVWuZkbrQpLWDM
 =
X-Gm-Gg: ASbGncsGHk8ANGmxk2WVdcHK/6c+auakVKNk1j8AjBaE8gum+gXX6VhbFIHyALPvr4n
 0SO6c1vegYz6KfuAwZn9Gc8ArCFBS2jfQH2okMYf0egJttKxUj65Na73Gze/aUBCOG6mXOEXAj4
 qIgcm6mLpyKSzsA31/HvB8bB+uVuivGV/c0OiTHx1kWVdHgywIHRsuqcyCC+lBPzwxcqYXBAyUM
 wMWY5P5Isyo8XRo79FH9y3J6WuK4qz7LWIjo/URZTgHcDQh7gKtivcLN4eA6igo3s+hof9iuX/k
 M9l5vtYZvjL6fGnNRYpHwD+7bnFcCLQqdFZSD6MMtJWdo2Nz1kKx1EJzincEJ1C3mSOrMgNqC6x
 XoQ==
X-Google-Smtp-Source: AGHT+IG2/pNq1WdtN92/5n5e+P+1ClACGWfO0QguGoOs2aIzhdXFTzmHrlJ1p0AwaTfhXCr/kyLtvg==
X-Received: by 2002:a05:6602:3a15:b0:85e:1879:c708 with SMTP id
 ca18e2360f4ac-8669fb07f5emr391535639f.1.1746197327921; 
 Fri, 02 May 2025 07:48:47 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 43/60] expo: Check the screen contents after rendering
Date: Fri,  2 May 2025 08:46:41 -0600
Message-ID: <20250502144718.313633-44-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

(no changes since v1)

 test/boot/expo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index a50e9f721de..6fb9f810885 100644
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
 
+	ut_asserteq(10314, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
+
 	/* make sure only the preview for the second item is shown */
 	obj = scene_obj_find(scn, ITEM1_PREVIEW, SCENEOBJT_NONE);
 	ut_asserteq(true, obj->flags & SCENEOF_HIDE);
-- 
2.43.0

