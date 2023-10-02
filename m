Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FDCE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9F287108;
	Mon,  2 Oct 2023 03:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KTYCOFpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D693486CBB; Mon,  2 Oct 2023 03:14:05 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C0DA870DC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-35255c1a448so13499665ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209236; x=1696814036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNUsB1VFtYnW6oZL98cmCHCbLxHL/yPaHclozoK1HsA=;
 b=KTYCOFpgSS7aw5b/5w13E4YVQhrCA641+CYzKEiGsIzcU1OjtS93yInO4Qx0hUYbJS
 04w/WZduciFxNkRrh2Wap/yW80bjp4zV/msKEEMZZmBXq5DMd5GhCmMiS3yV3dbAfv1g
 RlVmxChiQmGQen9OjzA1fqEdg0GkzX6p0yoTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209236; x=1696814036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNUsB1VFtYnW6oZL98cmCHCbLxHL/yPaHclozoK1HsA=;
 b=MhS7WXA2+2uNHeRBKIqCxwav60iHwQMCPAO0dI01Wmi/ifATRFhh4PCUlrGVXwnlb3
 M285Nf1NdRdA3jFbgh12QSHnm5BzMd9KGtKUl0M0oTY0tz4WUjNpjQ50YR4jODBuXUVO
 Su+F5Gpx6rQV83TNQ2Zp2MnROUfBw3G6YOZtoyaCV8sTK/joxvgoRwq7So9ZAkFjPmrq
 2TfIUswfNSDkkvoyXywK8CYs/OlwnGSNR81LeCDwredCXoCXvKKSo2Ve4nbxJzAHKdCd
 OlmbZQn0y5hs9hoG8mMH7IO/Q4o8QDhNceBghqNWKF3ZWotCGIdzMlej2nszXcg5XBG+
 cAUw==
X-Gm-Message-State: AOJu0YxQgqcF18NVuqCmNgD7IagMrngEBPrLCK6bwK5QD+7LIj8XBS9y
 YHi5G5GxsdR1AWTqTjHJ95FZHK1OCgZPfMx3+YY=
X-Google-Smtp-Source: AGHT+IHtSNb9nC+EeoP2MsI0xaLO690SFLMkCXWsFcsdQTjFP5LRzWHtRPnCiF6q5lhetIr137HdbA==
X-Received: by 2002:a05:6e02:1c27:b0:34f:7665:c43c with SMTP id
 m7-20020a056e021c2700b0034f7665c43cmr13009342ilh.23.1696209236046; 
 Sun, 01 Oct 2023 18:13:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:13:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/36] cli: Drop some #ifdefs in cli_readline
Date: Sun,  1 Oct 2023 19:13:07 -0600
Message-ID: <20231002011349.461284-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Add a few static inlines to avoid the need for #ifdefs in
cli_readline_into_buffer()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index f3ba76a62ec8..61f9ba99068a 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -423,6 +423,18 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 	return 0;
 }
 
+#else /* !CONFIG_CMDLINE_EDITING */
+
+static inline void hist_init(void)
+{
+}
+
+static int cread_line(const char *const prompt, char *buf, unsigned int *len,
+		      int timeout)
+{
+	return 0;
+}
+
 #endif /* CONFIG_CMDLINE_EDITING */
 
 /****************************************************************************/
@@ -552,8 +564,7 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 			     int timeout)
 {
 	char *p = buffer;
-#ifdef CONFIG_CMDLINE_EDITING
-	unsigned int len = CONFIG_SYS_CBSIZE;
+	uint len = CONFIG_SYS_CBSIZE;
 	int rc;
 	static int initted;
 
@@ -563,7 +574,7 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 	 * Revert to non-history version if still
 	 * running from flash.
 	 */
-	if (gd->flags & GD_FLG_RELOC) {
+	if (IS_ENABLED(CONFIG_CMDLINE_EDITING) && (gd->flags & GD_FLG_RELOC)) {
 		if (!initted) {
 			hist_init();
 			initted = 1;
@@ -576,9 +587,6 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 		return rc < 0 ? rc : len;
 
 	} else {
-#endif	/* CONFIG_CMDLINE_EDITING */
 		return cread_line_simple(prompt, p);
-#ifdef CONFIG_CMDLINE_EDITING
 	}
-#endif
 }
-- 
2.42.0.582.g8ccd20d70d-goog

