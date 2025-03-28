Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D296C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6DEF82072;
	Fri, 28 Mar 2025 14:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K945IfGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1F28203F; Fri, 28 Mar 2025 14:07:54 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182B081E1F
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85b41281b50so61086839f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167270; x=1743772070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgoY3nQ7oMbTxRggdSngwTiQCWVzkVxE+Xo+8X3KC9c=;
 b=K945IfGTQM3hw7dKah1Xyjr9iFqL5/QEcJZiCVU11F60y1wRnd+oJyiHEtEMAQ9e/x
 e+7HT+pT8xxhJhJmnWLjTYtJHHhdFNRLQNf0HYnV+cIKYph0dmmhsPqFEn8zfGZ/QlbJ
 L+4HPrblOBiwCE5yEhVAbSBkKH2vS4iRSJGlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167270; x=1743772070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgoY3nQ7oMbTxRggdSngwTiQCWVzkVxE+Xo+8X3KC9c=;
 b=vrSD5bCvZlqveordbSWJy7SPoHlS34SRSIIRI+XheUjmTj4ItUHM+q1v1L0GvEfOHi
 2Kdq++R4t9xF+CIh9w63JiAMyFDQWOKerlCl7i6De96fqj+roD14A7CRQQgktDk+XVcH
 qSFYhin48MgvMPUWfySEBWmBlVgJbxPA7rcVxES/Kils4ikQH0eV7CAOXSeOb0hGEsxk
 KBFmVRN4Vj2DHPkd3yzCAmARGP/Kjd7JeL7XnZqHcTCmi4G5aU/KUx8+CAoUd1w235j6
 519MGK2hRHM3BQnrqFnNpu/r6VL8X4EXPJSeQTb+aH8UmYupxtEErF4+IkBjU0k1DQB8
 deNg==
X-Gm-Message-State: AOJu0Yzf4/ARgpGkdwE9n6XdHAxBb+STK1v13gqkqLuX9LrluxvcCQf4
 eqZbTv0UGimcmylvRa2WV1bI+9mt9aU+5SWBLmkYonvdpVHLiBo1Qs90u4wXdB3ehBG7OIO+G40
 =
X-Gm-Gg: ASbGncszfN2TJokS87QR+zEG1Xv5q8bkCKWw9j3aqpH+6ku+buAktrvrk/a68c9d4uu
 tRSZLy47z7tBLO2tnSnPolZMmDtCAtyup8jJSd87vUQfUsWP7PkBmpHJOTzjRbDvNzMwRfjuTLd
 nC3kD7gjx0iSTXNVRhhRtVwOD+9Z0yS1CB91eysbavoXmNnt5Ftik+cO3VOeJHt3kHn/8Q7sbQU
 817/YMSG/fqKbFzhCXItLSNA4b4IKgwUFaNudeG7bz0DASnuqq+eO/jTTsYYJW9mzY7K3Cvcf1X
 cCcXMoOuHilrXk0SGvQCtESuxlH0IasabYt9dXYc7UW0ObliONzObtkNYBEzi13ZF/y5RSz17AC
 wH9qF7A==
X-Google-Smtp-Source: AGHT+IHkSqFBRteu5gIPr9tWMf2M6886Yt7l8W7kdBDcaU20wFBX7aEUQLxO0XbT9ckV7U+Hl3uSXA==
X-Received: by 2002:a05:6602:3719:b0:85b:3791:b2ed with SMTP id
 ca18e2360f4ac-85e820a0c8emr888732939f.8.1743167270050; 
 Fri, 28 Mar 2025 06:07:50 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/56] expo: Create a rendering test for cedit
Date: Fri, 28 Mar 2025 07:06:04 -0600
Message-ID: <20250328130713.2612648-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

