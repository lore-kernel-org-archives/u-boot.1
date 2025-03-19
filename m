Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EC2C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D412E820E1;
	Wed, 19 Mar 2025 15:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="giF2bkFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9697C820DE; Wed, 19 Mar 2025 15:56:01 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DDC481DE3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so5872325e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396158; x=1743000958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voV0qKkzVoOEhB6Uq/4TZr5PQE48ZormDknU3gOFnOE=;
 b=giF2bkFfd06NXYFFutPz/wLN6CJv6Cr4SC/WRHaW47efG0EfEK9fwkoeU/quN5vyJB
 rkU38onhq/qht3sVgRxasXtyCtJcVzsddJ0iq8gyNbTmZqYObX8fpdZL3oqImF0WwNWm
 SYvpRDRVQCWAVxlnJxRchQlNp5nrYVgov0Ncw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396158; x=1743000958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voV0qKkzVoOEhB6Uq/4TZr5PQE48ZormDknU3gOFnOE=;
 b=UM8fV2l4O+cIMa9HtnGf4MhVSrks8bfKL8mDciBwOfNB+uJeoVjSKnGC3h/3xWwhJc
 8TbZO14Ei3My7s6pFAeL6gndFUWdAZhcow5Ccx8xZJZsQUwRHIEIoAm+sWWDFhhHFaUv
 eWyWCdqIx3r9TZtnEwgj29NhrpcJ7uthXXx7aEQ8Db9WyYjskqTWbGbae60rC2QbK3tD
 EmP/6GGHT3j0uTcbC7+HXhEKl+AGPaZEH03pa/tc3HYcRPJV7Pd+VP24NHJNsUhHuCo1
 9pbans00QF92HCdEzACdId8UMHtWNVMzmR0Zwts+GXYvaC5JEdPxOpkMrz+4kz4wQJWI
 8iKw==
X-Gm-Message-State: AOJu0YxqUEMcYhIKY6WyRxLXRKQLIaxFVtpvqZQOv9CtE0ihfS96du+6
 IFFqhh/mrSetRMPbbDqPL5Y3IiZjsf+6El5+gH0xBMYDpTKOE1a1Dc50xHE/bF04xOUk63wmSBE
 =
X-Gm-Gg: ASbGncsaCn56MYy5KeiY2SY63ewntHZ032ochogPzvsLtQ9wIbaH5PPat7V6Qnirspv
 AF96nHsTbHtG1vjPj+Q+58on8uAOfTvzX9aOpO7pZcuelzm5trk+FlfyOjzNSKPLZOstQIqlvS4
 5fB9anRTB6jTDUDssn/f//+Ccn/k+xsU9XNWGmTJZi9BaoHOEIRKOCx7mJo3Rw+1FR2KLxqOk/L
 0xxHrouX3/Qz3CbkcX7GxgtwQfFxTsfB/GD6x9Q4o01A45uwNLg9VltKVO5nCfyrUfLMRQ+ncV/
 U8/JE+FBEtId7vvnNPl0qhTBtVVYO2hS/JAJNCC0hw==
X-Google-Smtp-Source: AGHT+IFL/gZWr/aM7bNY8u6BoDiE92ifdPtX3TTVuPHO1Jcue8eazKywWec/BwdOyqAQSuGaEv9X+A==
X-Received: by 2002:a05:600c:a582:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-43d3ba0f49amr58075335e9.15.1742396158486; 
 Wed, 19 Mar 2025 07:55:58 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/52] expo: Create a rendering test for cedit
Date: Wed, 19 Mar 2025 15:54:21 +0100
Message-ID: <20250319145512.2391122-17-sjg@chromium.org>
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

Add a test to check that the cedit renders as expected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/cedit.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 4d1b99bc2ea..df191a09f89 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -5,11 +5,13 @@
  */
 
 #include <cedit.h>
+#include <dm.h>
 #include <env.h>
 #include <expo.h>
 #include <mapmem.h>
 #include <dm/ofnode.h>
 #include <test/ut.h>
+#include <test/video.h>
 #include "bootstd_common.h"
 #include <test/cedit-test.h>
 #include "../../boot/scene_internal.h"
@@ -220,3 +222,27 @@ static int cedit_cmos(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(cedit_cmos, UTF_CONSOLE);
+
+/* Check the cedit displays correctely */
+static int cedit_render(struct unit_test_state *uts)
+{
+	struct video_priv *vid_priv;
+	extern struct expo *cur_exp;
+	struct udevice *dev;
+	struct scene *scn;
+	struct expo *exp;
+
+	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
+
+	exp = cur_exp;
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	ut_asserteq(ID_SCENE1, cedit_prepare(exp, &vid_priv, &scn));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4929, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
+	expo_destroy(exp);
+	cur_exp = NULL;
+
+	return 0;
+}
+BOOTSTD_TEST(cedit_render, UTF_DM | UTF_SCAN_FDT);
-- 
2.43.0

