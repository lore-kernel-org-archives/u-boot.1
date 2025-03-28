Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB3EC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCDB81FE8;
	Fri, 28 Mar 2025 14:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cKlqK2aP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F2882169; Fri, 28 Mar 2025 14:08:36 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4067682163
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85b4170f1f5so60467139f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167311; x=1743772111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElpDlGC3Lo4bmxogkzi1PzOq3oii38zVugZwBgivcEo=;
 b=cKlqK2aPLQ1hOKoVAP8AC9lYvtLGupx/hA+1zuKPVs6NCGoYw/o+xbe7kyZwEn55p3
 O34Mt8wRMrOaCpmFgmDJv41heyUYbgtOtaKc70PbtsGC2fwosghrUC4FI5UrnXgfGXJl
 A3G5B4gl8/v0579Yg0RE8kDh7GVHGLGdlYe/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167311; x=1743772111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElpDlGC3Lo4bmxogkzi1PzOq3oii38zVugZwBgivcEo=;
 b=WGX3hqqEny20dSE+JRITpBpbKRkZL/G9Njxjk6ozZU+Xy7PQq1sblXYl48sDw7GMzb
 uwXIIle0QL3ky0AWlOQlkXU3XgrXTQblWt3CC298r+pL3pFRqKsymEhs+qdAjU3dqdMq
 MK+N7rYpQxQLP6TZMWRD1a720bAoIM7RC55vq7MKdDIcg6DVfdSlH+Mx2GP01cJvOapk
 6YdcFl3CW+jrRxxBE7KdULkJpwxI9E3smGRwMAM0nG1Dkpfz9JL693yAeaAKdLe7+U0l
 thP0PKJ/iYIsI4nsrbwaHrg6eMylepFikh4u8hwEoWteoy8NE9yT+jSzuoyP0STw0NoH
 T0mA==
X-Gm-Message-State: AOJu0YwQ5YPq9JePPDJ5Nam6e4xEkg/DcweIYzwjWrTnWMAJqPpv2PqZ
 m4LEm0bky+mUQKoomLiq3R2J9M81RriRbBeKd9dPfyyK8RguQXAGaoJ5pOY1UDW+5y7NV5xiGO8
 =
X-Gm-Gg: ASbGncvhuqoGfuwP+fao7l6yR4k2oi3myWm/cNRJ952mf3aIxyB2+iqZh66aUklvbgR
 flgf1BFJj2Qd1nQG2BNwIouMB1z/kiUJDr07InuRRN2mGtB0i/7Ze3OOiuYbyfgof2ZH7B1a/20
 ow8scTGoJo0LpuVMJogcdfMZoqOknTch2oi021bmxC5YKOPSa1dDEoxHTwZTNNARGMgh5fh5XMn
 h9Xh4opyxF04B13cHdrYPT02zFAhaOnP5Tpdm3+xY026rjcG67/CiJK7I88sQlGIZZMkl6AfbL0
 IF8TQ/PdsXd/QQVdtHC7+aqaHQ1xTOLqVt2/OMTNAKBeFLBYJAL7Bm/yv2SvOPGEzD+K/NJzjWM
 +2lavBA==
X-Google-Smtp-Source: AGHT+IG1POYWU9zv7mL2x+POhfAWFaYYSLtRB9YlWF2j91GostjJ7+uAg+L28yn6vr/OTRoi46Wejg==
X-Received: by 2002:a05:6602:4c88:b0:85e:180d:7c97 with SMTP id
 ca18e2360f4ac-85e81eace6bmr935539339f.0.1743167311304; 
 Fri, 28 Mar 2025 06:08:31 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 39/56] expo: Check the screen contents after rendering
Date: Fri, 28 Mar 2025 07:06:26 -0600
Message-ID: <20250328130713.2612648-40-sjg@chromium.org>
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

