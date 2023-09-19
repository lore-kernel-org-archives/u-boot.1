Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E87CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0876686BD2;
	Tue, 19 Sep 2023 20:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mNEUPyTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C5586B7E; Tue, 19 Sep 2023 20:09:33 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3887686B85
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79d1bcf289bso129568439f.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146970; x=1695751770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JC13swIpsfE1ACzBb11TwFLF5rzd+hUuE9FqhArmjnY=;
 b=mNEUPyTLmpPb2r3qC5scmmE7YsuTnXgnLkDiztunPj6XNFoz4k36y1TPNxGIbkQDS0
 R/6M6m5Rtq2Nl1DU/ka3+ExGi00arxLfs/IKi3/UpvYZ25oC0su4wIgQVLKid5D/JxqV
 brUz60Dg5n6pgQS8rtSrMzxCmC9eedcoO5pE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146970; x=1695751770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JC13swIpsfE1ACzBb11TwFLF5rzd+hUuE9FqhArmjnY=;
 b=xUpzsWtsiBGHbSjCGj/V0rRimRb2McpV0R7T8u93t+F1jsiEvu6y+XwmdWobNVeYfP
 ldAoTumyYlZlT+smhqUOcw/RIh/Zg/dCD2CQJAFcvjrBfblSWFJQm1v4PFAI5bGivWrK
 HnWvKHNn+yBi2H+2apszuxN7X6qW8W6RdJe4PqYq+EkLSSGs69+Sw1id+VEoWb9y9q0u
 iFUH4+kqUo9tZI0pBy4t8GEgpLDNGBem6TmjIrVFqBJrd8CC0wy9dK019NREKxPC5tpt
 8suWaniahAIOeTMZWLWyDBuNrtiT0BvKKQnStDk7O2n1Mi//IkGZVTCUVU5moLYCbeS4
 NpiQ==
X-Gm-Message-State: AOJu0YzVAG+EeeytD18+tMVyJZZ+QphM4S29lbVWeO+EptOpphQ7AhvU
 GVmJx0uWXWxqCaTy1DLzqUZHnAfbYdlVHtfB9/M=
X-Google-Smtp-Source: AGHT+IEtcQryBxzZJ3o8kL3rKgO+WBY+0TWs15I4si4C71WRZe6MmhZmltF/8bjjbSZwD7mJY1yzrA==
X-Received: by 2002:a05:6e02:b4f:b0:34f:7dec:4b2e with SMTP id
 f15-20020a056e020b4f00b0034f7dec4b2emr702338ilu.14.1695146969822; 
 Tue, 19 Sep 2023 11:09:29 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/36] cli: Drop some #ifdefs in cli_readline
Date: Tue, 19 Sep 2023 12:08:33 -0600
Message-ID: <20230919180918.2904313-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

 common/cli_readline.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index f3ba76a62ec..61f9ba99068 100644
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
2.42.0.459.ge4e396fd5e-goog

