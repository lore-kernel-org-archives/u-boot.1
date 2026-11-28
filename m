Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A7606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JkVEohcB;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=miI+eL0i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70CE4810A3;
	Sat, 28 Nov 2026 13:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H939WypJtK6Y; Sat, 28 Nov 2026 13:12:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4E9181113
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871541;
	b=k/1tgrv1Dcg/NuosklfD/hS4bm3RUdcEkVpasBZ2vv4cWG5fzAeMxC1cZyXPvYFPH8ws
	 6Fpf/HZ9H3jspg/0rbcRfMB6d5/rlLo3X5DeINvGEh97i9zHU+6VkG1hO7WMIZWZMOhoC
	 8t1I5Gbv7yYcGb+uYDXYBZiJeCILkhDyCe2Qw1B4WAeFnnlD7vJtGxJxjm7+zIxcnfpeS
	 9zeCiUoXOSZ9oEZQjeYmb+/Z/8WB26yGa7SiXvCjvLY7CXPqF5YG9Zi1Ty5F4FDDBOP6W
	 fZSUX2SutNuik7JRsL+ZH29RmXo7Mx/7I9b389DLBdQr1G4iLZQ8S/DLHiwhmJw8NKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=firUyxtO9KLRMcFx16aO8Scj7YJsAy+Cv+h0WgfxJdo=;
	b=hlAZF13sboaNI4DFhX5Ri7xqOF6qAWmRIBod+dEY9cXbpLO7rBp+DAcTVqH/FJj8QC0L
	 epwRObNnj0mlV89ijS+QmLwGl12EsdHwD3/lnlKAKUWgs38Q/+vgm4BEru6gcRQskP1IJ
	 mjZ/Lwk1LtXwPnUBRiOdDeIMfU2UG+45HPnpYYutKt8iWzYkCnf1bl4WCFkCiJoYGhkco
	 fBY2+eo6HA4Wkqm7S5z9snxklhliAGczBzujLxH8VsaJY7JC4j0HOCcHiAiI3ZUnWzw3R
	 FAbycE8l0l8vrvgVfMtpVCrAw9hLyeWQZbSf2ID3QpsD4gZ2qK5gM8dZnwyiQapuG4w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871541;
	bh=firUyxtO9KLRMcFx16aO8Scj7YJsAy+Cv+h0WgfxJdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JkVEohcBJrQj45JUuGB1Ih9gvTRMGhNzASY63QgRYD8CJ9UyFpM0NEpPdZ4EtBmN3
	 xfnvtwTe13R6AGbK/qeL9R/Q8T0yiwr5uVCAnXE8b064onDLy0L/Dvgk/y8i7EJiU/
	 pcjE0q+hBNNKGM5WOI9+MAQ6aX/k3tdmATMQBY7Cf3BvrZyERqDDYwO5tQlOL/f7bE
	 P/XrqTfvFkCmVFMLVUf1jz/rxWsttPuDdgG39zdplyem/sjf8EUVT6+xmQX8a2fnRw
	 Slmu88swiKx+5WzrF8isEJy9obGxEDxTguI9JGxW6kymsfa8QHBXwwXOskroewUSZ3
	 iO2Lqs3Lc/vIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4E9181113;
	Sat, 28 Nov 2026 13:12:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DF303C0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 129BB40659
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bOdJGzGSqg7y for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35DC640645
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=miI+eL0i
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35DC640645
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:02 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so61418095e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871521; x=1796476321;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=firUyxtO9KLRMcFx16aO8Scj7YJsAy+Cv+h0WgfxJdo=;
 b=miI+eL0iWoMigp80Hr97ZgPtz1yVledS1tYhJZ4/bjEY7SOM0JqQNt5bDeWAdgaDJZ
 JZLE3br1SKPoXxcE7YMm2AE6Vsst52O7SpjRU0mH8sgaQ6Ro5ht0AhAf/zfD0szRFCaJ
 9WVRGmGYYY8LwgmmV2aKDk/r+TYju0u9V23r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871521; x=1796476321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=firUyxtO9KLRMcFx16aO8Scj7YJsAy+Cv+h0WgfxJdo=;
 b=bbQ3wdiawpNEx7JgWNwgat5aoQJdC1w7uytsnsFv7fpkzGpM92SIvIdjRwVckRFRCK
 I7hCOcyKjppoigM97sHyZhSwDzI0/YuDTNlL/+GtdbXNs4YVnS1KIjg7gQUgMFY2Woy9
 ZXVOJQN2Y9vYdBmi+tWyY65F0Krw1XBpzA8rKM+yt2yyWR3OX57ZKhQdd2r3ZBQOdW8O
 t+mV0BTbr5IZWAYrYpNZXTXOc2hv4en8+yKTqRrxAu2xnVw6LprI+XQ08OgtZxc7GcYD
 f7nEA+cEphnViXBfjozCoGVCLc83lOXh20WinzxOyEhlAWJJF8mIcsVqIn9ZmCQo2gcr
 pNaw==
X-Forwarded-Encrypted: i=1;
 AL+hErHYtxq5PXr1HPaWPOay9qpHm/Qf7Zp4q6mFgzFQdx8oltt41LzPVQSRxy3sDiOiOjvRvGtAq/c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/UCidCjoaES69nLgFrGq/8Rw/RRKQ16bdh17QLahwlw/iUw4aW
 /nT67WRYTSQ0Lbu6VGo9zxDGFFpM0M2nejOAl+D4Y1rx7FtaZjnJofVdNSOUnAWPOE0=
X-Gm-Gg: AZFdTZeDq0AisdlUrCqviL7PR9H9+wLzcBPAhEdIwQgAcV5EKpAkGQMQyGqV3McYT0z
 b82g5TCoooBWopNl2KDD3ALh54z2i/tNKjhJsC4zf2UoRezQWGTGISs8g5taWIhmjUL25igeq+v
 mnaw1yBZv3yATp8CJua9TU5WO0Hqpp/xwGputGNX79PC4XDrGR1sORK8hlsocM0jMpQ8wD2uQT1
 PjPqHaDCVWpO17eOoc0lLOOChwldV//Rz1w6af2X6qLiNF6PnF8wfUvEEDGrgiywSB20VXK6+XW
 ZEzNBw+1LlNnwqeDyy+QD5fkFBholdtNsfj9JcV5uu9vOq3lRqVtqkIJyy+B22OZjRRELApZEsu
 ILnkcZyXGVsvTQQLl9q68SgqZBvdtt1HT7saAW7VWfdB+wx9WQQS7LHk9ZkP9b5tHu0ednitgVK
 Bz6fav9GewXSXaO+HoTy9+Js3D8E75dan0gMeCZQ1yi5cm5gUYqbaEA7AGG4OGWvjCCWzRpIdKy
 A+vO7OHydLn8DQijB659oV30W2If326nszjtf/R6RaZeVsDysQgmtP1ZJtJO+fMvsyglbQAgR2F
 pZpFQg5jyUSiwOMdVLohthTdK1o20UyCDC0Qgb8qCBTrYQGpdW2xNvNoB8gHUvrcX7XNB+xLK1C
 /WjUoFlnH4Qob4ILnJajxE++/UpDyYVTQAx9nri9rY20RtxN20Txy2mbBt8GQYNo9e8r9mCG3GM
 CjdCtGaSy4qqs14S0SzJZzDgv74g==
X-Received: by 2002:a05:600c:5307:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4bb888283d8mr556767105e9.17.1795871521123; 
 Sat, 28 Nov 2026 05:12:01 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:00 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 19/29] splash: make splash_video_logo_load() available to
 boards
Date: Sat, 28 Nov 2026 14:10:36 +0100
Message-ID: <20261128131125.2141352-20-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boards providing their own splash_screen_prepare() to load the splash
image from a board specific location have no way to fall back to the
built-in logo when that image is missing.

Export splash_video_logo_load(), which copies the built-in logo to
the "splashimage" address, so that they can use it as fallback.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Tom Rini <trini@konsulko.com>

---

(no changes since v2)

Changes in v2:
- Add Reviewed-by tag

 common/splash.c  | 4 +---
 include/splash.h | 9 +++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/common/splash.c b/common/splash.c
index 8a65ae597771..5502b4f5452f 100644
--- a/common/splash.c
+++ b/common/splash.c
@@ -70,7 +70,7 @@ static struct splash_location default_splash_locations[] = {
 
 #include <bmp_logo_data.h>
 
-static int splash_video_logo_load(void)
+int splash_video_logo_load(void)
 {
 	char *splashimage;
 	ulong bmp_load_addr;
@@ -90,8 +90,6 @@ static int splash_video_logo_load(void)
 
 	return 0;
 }
-#else
-static inline int splash_video_logo_load(void) { return -ENOSYS; }
 #endif
 
 __weak int splash_screen_prepare(void)
diff --git a/include/splash.h b/include/splash.h
index 7671bd7e9c44..0a3ea0346030 100644
--- a/include/splash.h
+++ b/include/splash.h
@@ -61,6 +61,15 @@ static inline int splash_source_load(struct splash_location *locations,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_VIDEO_LOGO)
+int splash_video_logo_load(void);
+#else
+static inline int splash_video_logo_load(void)
+{
+	return -ENOSYS;
+}
+#endif
+
 int splash_screen_prepare(void);
 void splash_get_pos(int *x, int *y);
 int splash_display(void);
-- 
2.43.0

