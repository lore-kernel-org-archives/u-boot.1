Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2114DC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02FC8209F;
	Tue,  1 Apr 2025 19:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y2PgcqQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D835C82006; Tue,  1 Apr 2025 19:30:31 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6353582006
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301c4850194so8146364a91.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528627; x=1744133427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ok5BsbyCnVdM0R2qe67a/kntfUsxct3Lrr/6qy44l78=;
 b=Y2PgcqQG50bsYL268qo1DWN7ax03I4CyavUAo9IeF26bsRQ93zmJmpSqw8MRlHtWWY
 KWIyFEiC3BHlmtxcUXfEuV18CMhXQm48XqZiw79Ll3keL1XmVSr3MXIrSqE824UF1NpV
 2/lZCvtIZjvTWMohsD2+s5DNds3okAPlQp1E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528627; x=1744133427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ok5BsbyCnVdM0R2qe67a/kntfUsxct3Lrr/6qy44l78=;
 b=lBdUhRbPpoAPm+t6nBIR6LHkR7H4NZsMVhT/45A3i4VZzgC5nWBh/mSONpBIgdVI2q
 FiP7d4IuNEPsgW9JhtHsoctbcDPk3x5eOBlqP9TVu3wpV32tMuCP3USQbbUU1IhlhBkO
 jM8NAOQScbEHKejx09ZaIuOgMo+dibE6wCBdMU5XutR+SRjInUyARW9Fry1r5RskcV6e
 QIK9IBzO3C8UESwmEO8Ix+RGiUY0c3riIiJfX4wEEYmC2N8u/ERtIwMHfny9y9fK8Lxg
 DSSJavo8kdI7Za7lAFi/TdZfY+FDP0/PKBAHSMrNMhIt0SigUfwC6R+bHorMRHvhAPVp
 R/kw==
X-Gm-Message-State: AOJu0YwA1dx3EPjPIpEOVuJT2JuPxIt2wMY5DR5c5YOpOboHDzf/wLn6
 U12/sfyuFkD56HE4gkqlqBY6uOcxerjHg26ze8VsGw9BtP2CntSJDNfQ3nRA9ANt92tmIlo05vs
 vDw==
X-Gm-Gg: ASbGncvzZbwh3maIz5zAIif2/wUcaHK+EDUVD+1/TATTXVjWwqM7imjqPoGVUghAk0W
 AbPQQCsGcTeuoz60X8FKeftx9Q05umy7H5GGOY21BjAMTYH08T+vTxFOagoqdSHJVQFCzmomNlE
 WLcWIn8Edi+8iiDKAFy9EKCEcuzvPT66x2yQ03XA7nW1mILkwKlzKvo0eS6ozV64lJxHRvLoR+A
 q/M9M8km4v+OBy2Q02qbiYlSnHSXfPiuQwPnvZvkc1P/DVkc+vKeaxO2hpJtKq56/iLtfdayIan
 SBKwuAs/MtdYK8+kzGq2wOdV8NtwS+i7JRXOVcoWSgw=
X-Google-Smtp-Source: AGHT+IFGSC2mrVvx2THw9Tb/xQQjpEl+JH6OqbGt10Bv2HO5Y4FW2sE80z7qDKaa59hEJIZmPWLjhg==
X-Received: by 2002:a17:90b:1d4e:b0:301:1bce:c26f with SMTP id
 98e67ed59e1d1-30531f79348mr20387248a91.3.1743528627243; 
 Tue, 01 Apr 2025 10:30:27 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/13] video: Begin support for measuring multiple lines of
 text
Date: Wed,  2 Apr 2025 06:29:36 +1300
Message-ID: <20250401172948.1236000-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
References: <20250401172948.1236000-1-sjg@chromium.org>
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

Update the vidconsole API so that measure() can measure multiple lines
of text. This will make it easier to implement multi-line fields in
expo.

Tidy up the function comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c                      |  2 +-
 drivers/video/console_truetype.c  |  3 +-
 drivers/video/vidconsole-uclass.c |  7 +++--
 include/video_console.h           | 50 +++++++++++++++++++++++--------
 test/dm/video.c                   |  5 +++-
 5 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 15e7a8b3387..d3ae5816bef 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -298,7 +298,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 		}
 
 		ret = vidconsole_measure(scn->expo->cons, txt->font_name,
-					 txt->font_size, str, &bbox);
+					 txt->font_size, str, &bbox, NULL);
 		if (ret)
 			return log_msg_ret("mea", ret);
 		if (widthp)
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 980baee83cf..7b9033818d3 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -733,7 +733,8 @@ static int truetype_select_font(struct udevice *dev, const char *name,
 }
 
 static int truetype_measure(struct udevice *dev, const char *name, uint size,
-			    const char *text, struct vidconsole_bbox *bbox)
+			    const char *text, struct vidconsole_bbox *bbox,
+			    struct alist *lines)
 {
 	struct console_tt_metrics *met;
 	stbtt_fontinfo *font;
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index a1dfd35b7b8..4ca41dc331e 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -608,14 +608,17 @@ int vidconsole_select_font(struct udevice *dev, const char *name, uint size)
 }
 
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox)
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines)
 {
 	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
 	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
 	int ret;
 
 	if (ops->measure) {
-		ret = ops->measure(dev, name, size, text, bbox);
+		if (lines)
+			alist_empty(lines);
+		ret = ops->measure(dev, name, size, text, bbox, lines);
 		if (ret != -ENOSYS)
 			return ret;
 	}
diff --git a/include/video_console.h b/include/video_console.h
index 13197fa4518..ee9ce3c0e37 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -6,6 +6,7 @@
 #ifndef __video_console_h
 #define __video_console_h
 
+#include <alist.h>
 #include <video.h>
 
 struct abuf;
@@ -119,6 +120,19 @@ struct vidconsole_bbox {
 	int y1;
 };
 
+/**
+ * vidconsole_mline - Holds information about a line of measured text
+ *
+ * @bbox: Bounding box of the line, assuming it starts at 0,0
+ * @start: String index of the first character in the line
+ * @len: Number of characters in the line
+ */
+struct vidconsole_mline {
+	struct vidconsole_bbox bbox;
+	int start;
+	int len;
+};
+
 /**
  * struct vidconsole_ops - Video console operations
  *
@@ -228,18 +242,23 @@ struct vidconsole_ops {
 	int (*select_font)(struct udevice *dev, const char *name, uint size);
 
 	/**
-	 * measure() - Measure the bounds of some text
+	 * measure() - Measure the bounding box of some text
 	 *
-	 * @dev:	Device to adjust
+	 * @dev:	Console device to use
 	 * @name:	Font name to use (NULL to use default)
 	 * @size:	Font size to use (0 to use default)
 	 * @text:	Text to measure
 	 * @bbox:	Returns bounding box of text, assuming it is positioned
 	 *		at 0,0
+	 * @lines:	If non-NULL, this must be an alist of
+	 *		struct vidconsole_mline inited by caller. A separate
+	 *		record is added for each line of text
+	 *
 	 * Returns: 0 on success, -ENOENT if no such font
 	 */
 	int (*measure)(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox);
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines);
 
 	/**
 	 * nominal() - Measure the expected width of a line of text
@@ -320,19 +339,24 @@ int vidconsole_get_font(struct udevice *dev, int seq,
  */
 int vidconsole_select_font(struct udevice *dev, const char *name, uint size);
 
-/*
- * vidconsole_measure() - Measuring the bounding box of some text
+/**
+ * vidconsole_measure() - Measure the bounding box of some text
  *
- * @dev: Console device to use
- * @name: Font name, NULL for default
- * @size: Font size, ignored if @name is NULL
- * @text: Text to measure
- * @bbox: Returns nounding box of text
- * Returns: 0 if OK, -ve on error
+ * @dev:	Device to adjust
+ * @name:	Font name to use (NULL to use default)
+ * @size:	Font size to use (0 to use default)
+ * @text:	Text to measure
+ * @bbox:	Returns bounding box of text, assuming it is positioned
+ *		at 0,0
+ * @lines:	If non-NULL, this must be an alist of
+ *		struct vidconsole_mline inited by caller. The list is emptied
+ *		and then a separate record is added for each line of text
+ *
+ * Returns: 0 on success, -ENOENT if no such font
  */
 int vidconsole_measure(struct udevice *dev, const char *name, uint size,
-		       const char *text, struct vidconsole_bbox *bbox);
-
+		       const char *text, struct vidconsole_bbox *bbox,
+		       struct alist *lines);
 /**
  * vidconsole_nominal() - Measure the expected width of a line of text
  *
diff --git a/test/dm/video.c b/test/dm/video.c
index 6ce1a756e25..cfc831b6931 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -788,6 +788,7 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	struct vidconsole_bbox bbox;
 	struct video_priv *priv;
 	struct udevice *dev, *con;
+	struct alist lines;
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO, 0, &dev));
 	priv = dev_get_uclass_priv(dev);
@@ -797,11 +798,13 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	/* this is using the Nimbus font with size of 18 pixels */
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_position_cursor(con, 0, 0);
-	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox));
+	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox,
+				       &lines));
 	ut_asserteq(0, bbox.x0);
 	ut_asserteq(0, bbox.y0);
 	ut_asserteq(0x47a, bbox.x1);
 	ut_asserteq(0x12, bbox.y1);
+	ut_asserteq(0, lines.count);
 
 	return 0;
 }
-- 
2.43.0

