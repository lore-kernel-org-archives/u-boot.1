Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2D0C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA2781F59;
	Tue,  1 Apr 2025 19:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YMWeASb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5057D81FAA; Tue,  1 Apr 2025 19:30:36 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A71820DE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22409077c06so156655745ad.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528631; x=1744133431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjbI8EEIUoQ362UBCM++dOL1m1Y9BxmUuC6WjlvwnSc=;
 b=YMWeASb8ctwY7w6JfzkN8/DeM987toOpB9psX8kudkrwkoLAdwnaATo3fRqLdGxN5w
 5qfZbpF47dysuF078lmVYFGrUhAcCf0mjtH8NyuGr73L5U7Ueoc5I5bhRGVCbwh0D86p
 CLHBgqDwV8/GOuOl9AkulZ6clYC1hTmlFEsLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528631; x=1744133431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjbI8EEIUoQ362UBCM++dOL1m1Y9BxmUuC6WjlvwnSc=;
 b=NccnexAkE0g0br6fYHaqI/ZTiVsW45k9pVgarIm5hyZIW5sSglIcRTlU2DqaGNHET8
 1HJHCyEltN9caUgxBVnVwfoxT2AE7p/qiIh/rr/ASHvx84rdTmtL8Eyg0Fd38/jRhGe6
 TmDh1RiuiLScyrhlsRPF7TaP26ZatI28xl9VAdeai20O/Fgc36bbkXlhtSdmVubNM8Sr
 IZvXh+l/laJYX6/cnvykNGOpoH1meQ52S+AmkJN/rj/KRPzL4U/mLe4Ud73sSEtYd2XD
 NUrQ15hKrfKx/RFHq90s8F/1yW7CxtVW/Jx5ohnWlJEo9VVttUJq3grUaz/J7wv2Eqzq
 rIzw==
X-Gm-Message-State: AOJu0YywIShpEv4LRCbVnIVa385Hc9hD/esioqMLkALandyW2gyxt83x
 0/cPeEG35dnvXJauKfY8TjnUW6FvsGQo69rnGhpd+Zr3UYjUvPza9W1bG+nHxUD0B+5KCNxDH2j
 DbA==
X-Gm-Gg: ASbGnctRCNBrWZfMe9xOREd9gk+j5dQafrqJHOi83RrpUtBO+XoVMqrf6h3wlR/GcTC
 NCvmJ1ZGHkPNreXSNHE5O4UQrAj02XJXsCh42twYR/wmayuJ9MeKSbKRveFVF+63tY+Sy3K0kVz
 9cvhc+Ea2tnLV7luDymm9eQ29nyv9AMe2KXUitr7k/9pnJrv7BFFpIbhm8WedShKEfblrezveh7
 GPJEupb12K4nwXtrE2maBwAAGtvYMIFVQ2WYK4Bph4r9RT2CzKGIuo+Pd9GQUTMyqc7PyFFW0sp
 rkOl0cGvGaTMr2BOdNsdOgkPw57IGHMqYPI5hu60PJk=
X-Google-Smtp-Source: AGHT+IFwweCrXp/7VyLDMXK8DNzYOeeZpqyAd0Trk98NcePP1PgWn+qBAObMAC2vCRoYunu101F/wQ==
X-Received: by 2002:a17:902:ea03:b0:223:536d:f67b with SMTP id
 d9443c01a7336-2292f9f607fmr255698155ad.38.1743528631534; 
 Tue, 01 Apr 2025 10:30:31 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/13] video: truetype: Fill in the measured line
Date: Wed,  2 Apr 2025 06:29:37 +1300
Message-ID: <20250401172948.1236000-7-sjg@chromium.org>
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

Create a measured line for the (single) line of text.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/console_truetype.c | 36 +++++++++++++++++++++++---------
 test/dm/video.c                  | 13 +++++++++++-
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 7b9033818d3..39d77ad9818 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -737,11 +737,13 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 			    struct alist *lines)
 {
 	struct console_tt_metrics *met;
+	struct vidconsole_mline mline;
+	const char *s;
 	stbtt_fontinfo *font;
 	int lsb, advance;
-	const char *s;
 	int width;
-	int last;
+	int start;
+	int lastch;
 	int ret;
 
 	ret = get_metrics(dev, name, size, &met);
@@ -754,25 +756,39 @@ static int truetype_measure(struct udevice *dev, const char *name, uint size,
 
 	font = &met->font;
 	width = 0;
-	for (last = 0, s = text; *s; s++) {
+	bbox->y1 = 0;
+	start = 0;
+	for (lastch = 0, s = text; *s; s++) {
+		int neww;
 		int ch = *s;
 
-		/* Used kerning to fine-tune the position of this character */
-		if (last)
-			width += stbtt_GetCodepointKernAdvance(font, last, ch);
-
 		/* First get some basic metrics about this character */
 		stbtt_GetCodepointHMetrics(font, ch, &advance, &lsb);
+		neww = width + advance;
 
-		width += advance;
-		last = ch;
+		/* Use kerning to fine-tune the position of this character */
+		if (lastch)
+			neww += stbtt_GetCodepointKernAdvance(font, lastch, ch);
+		lastch = ch;
+
+		width = neww;
 	}
 
+	/* add the line */
+	mline.bbox.x0 = 0;
+	mline.bbox.y0 = bbox->y1;
+	mline.bbox.x1 = tt_ceil((double)width * met->scale);
+	bbox->y1 += met->font_size;
+	mline.bbox.y1 = bbox->y1;
+	mline.start = start;
+	mline.len = (s - text) - start;
+	if (lines && !alist_add(lines, mline))
+		return log_msg_ret("ttM", -ENOMEM);
+
 	bbox->valid = true;
 	bbox->x0 = 0;
 	bbox->y0 = 0;
 	bbox->x1 = tt_ceil((double)width * met->scale);
-	bbox->y1 = met->font_size;
 
 	return 0;
 }
diff --git a/test/dm/video.c b/test/dm/video.c
index cfc831b6931..d3fd74a9a9a 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -785,6 +785,7 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 		"attempting more than you can do and for making a certainty of "
 		"what you try. But this principle, like others in life and "
 		"war, has its exceptions.";
+	const struct vidconsole_mline *line;
 	struct vidconsole_bbox bbox;
 	struct video_priv *priv;
 	struct udevice *dev, *con;
@@ -798,13 +799,23 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	/* this is using the Nimbus font with size of 18 pixels */
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_position_cursor(con, 0, 0);
+	alist_init_struct(&lines, struct vidconsole_mline);
 	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox,
 				       &lines));
 	ut_asserteq(0, bbox.x0);
 	ut_asserteq(0, bbox.y0);
 	ut_asserteq(0x47a, bbox.x1);
 	ut_asserteq(0x12, bbox.y1);
-	ut_asserteq(0, lines.count);
+	ut_asserteq(1, lines.count);
+
+	line = alist_get(&lines, 0, struct vidconsole_mline);
+	ut_assertnonnull(line);
+	ut_asserteq(0, line->bbox.x0);
+	ut_asserteq(0, line->bbox.y0);
+	ut_asserteq(0x47a, line->bbox.x1);
+	ut_asserteq(0x12, line->bbox.y1);
+	ut_asserteq(0, line->start);
+	ut_asserteq(strlen(test_string), line->len);
 
 	return 0;
 }
-- 
2.43.0

