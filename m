Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12FCC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C91DB82A8C;
	Fri,  2 May 2025 16:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MGzoweX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501AF82AA3; Fri,  2 May 2025 16:48:07 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A7D82153
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8644aa73dfcso75947439f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197283; x=1746802083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgoY3nQ7oMbTxRggdSngwTiQCWVzkVxE+Xo+8X3KC9c=;
 b=MGzoweX/PVozvJcDbWJSVhRhGYkZb8NRqPne6dE15pbEErcieTO58iRhhlM7vuAT8B
 ZTTst1fvFk3vv0B7qyxI4SmZHWiLAzjd63rrtSr+IqSWADGgCaQfEAZWyouNESHenSeY
 VkKBxUYptuwWF3Ri0+ffsbGFT8cPWAs9dFZfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197283; x=1746802083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgoY3nQ7oMbTxRggdSngwTiQCWVzkVxE+Xo+8X3KC9c=;
 b=Ju2sfGzTjQhXGicdNPVh346Neil3mWwvbzIDHsvyx/T4GktglH990ydDVfW32B18As
 OentbbAM19PkKjniRtv3v4mPyurBU1EKN8S+V2BDp+FGX3umVbCoNzV6jiCMdHMVRWnM
 ghxi3TlKZS6+BsvWnHRWV6HPnrXFuMgxo8huxP3oZ5UZUB8dPcAUeRBtBlWFNml6c8Rv
 KtE5clquBeG19wj42MmGbSvDcdQB4ZWwWgNfQhQB/8JMGyTakj6Txai4ZF9EmKLXM6Uy
 jRP1fNw1oqh3Z/5wofaM/1WV/WEzsnhlle4uGhhmNy5qTb0xJre1Vf5LykXLZfKDIxlr
 pjYA==
X-Gm-Message-State: AOJu0YzToWzNeoRxT3l7O5UkOGbJdIV+L71Te7ygIzQi5cwrw7OvujvR
 c5uTdAjC9jv5LPet+MgCc/AGGsye4CNiCtke7RTwXqmk1Jp44D7OJqq0vyEv26w8whDhODezodM
 =
X-Gm-Gg: ASbGnct48A8lHKol1i93XRIiuqH/6dRqQCsLz5ThRF5JHcLd6B0H51bye+V67SzW+ip
 3gqSKBjowQwp/ag1k6lzI7rttY4c46+cfwCD+pwodH1PrZ7Tw51e480xesT6TFIuGkuP/Od8+4I
 XwprWleMnepxQirp/s9+xkE5J0N/4GEAoueySnwNmOzJZjAbrby8y8dqHWjdbeu0XaYnDE8MFo0
 fbyxAG0qYGo6s8RwmQOyEgWVBapo4wV+MgVeBrR6VdSjf4NJfW4cTwKFTZTjHSUGzIaFSYZ8dNT
 1++CWomvcySByKKyFpOc9zJTpR1+5IZcpDrlt1DHlFU5/LWdYo3aDMIlOXGtvL1BzcDItoWd66e
 ofQ==
X-Google-Smtp-Source: AGHT+IFhI1yfdINgqtrLqQ392WX74T65S6h9a48qbzESeb5qSqsJgIRtIOotiD0zLO2+p72DW4h9FQ==
X-Received: by 2002:a05:6602:401b:b0:85b:3677:fa8b with SMTP id
 ca18e2360f4ac-866b424e060mr393756539f.13.1746197283394; 
 Fri, 02 May 2025 07:48:03 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/60] expo: Create a rendering test for cedit
Date: Fri,  2 May 2025 08:46:19 -0600
Message-ID: <20250502144718.313633-22-sjg@chromium.org>
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

Add a test to check that the cedit renders as expected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

