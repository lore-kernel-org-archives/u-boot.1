Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DB5CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06ED486BFA;
	Tue, 19 Sep 2023 20:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S+yDftYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E758F86BE8; Tue, 19 Sep 2023 20:09:39 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D722286B7E
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34fcc3ac97bso13853815ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146976; x=1695751776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tig6Rmk+SgwvwsBLaf5mPTf1t6RjXhvUaflrOOMhIxM=;
 b=S+yDftYOgFYlLlaVG0YUJg8MXUIpKWcXFkhDt9QCSjKDDnCNP7zUavsaf4CyvVw2h8
 0QZ8BLVVbTZmF/UBX/mXFeLWa6zDx4TSx2KyBgv2WUxepsQmdwoVLZmGiSqwenbNfG/W
 vsdY8ak335s9lA8qW6UCym69NkIKwhHyEq9PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146976; x=1695751776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tig6Rmk+SgwvwsBLaf5mPTf1t6RjXhvUaflrOOMhIxM=;
 b=tpl2EJ0AQnVcWSJVA6iXq4GW4tr1ODctfitUg/8rgieLindPMCh3dJM1Y07YQk1DCM
 8O6GNanE7hhQERCcAXoXlFZeTNz7C1eNo4PVYmH3qI564ZnJHiEd2M9MQb2VaQET5tEa
 Fi9dMU3fiitxK8M3ypd9B4J6hQumvXo+qoIZZUEqCjNNPt+Nr3XIkSM5J1DL+3LrilsE
 /UmwPeTtdERdpZfa8un49zMK+Xn6LJ1UlFWFAzkqrhcl6OhaxTAZeeoE1hgKces7xfQ2
 wg0s9BkOBtsft9O7+203srAJdStQ9YrC/BuEj6OkUIpQqb0m1kce2nXwJwlMuj7CcVEM
 o8iA==
X-Gm-Message-State: AOJu0YwuMuHsEizgieNnyiSABlHNs1UylXhplkVkaHVioMqMUljXAnWu
 f5UJlXlg5rcl0k+5YUntA4tSShfYs3e85MtO2kg=
X-Google-Smtp-Source: AGHT+IGDe1JgYZQkuLk5jPyRpzQ6cnEhebys8iz7QQXYjitnP0xy0Q0iHk4Zk59kL+7Z7jURA/l6KQ==
X-Received: by 2002:a05:6e02:1347:b0:34c:cf1f:2a4a with SMTP id
 k7-20020a056e02134700b0034ccf1f2a4amr436185ilr.4.1695146976528; 
 Tue, 19 Sep 2023 11:09:36 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 11/36] cli: Allow history to be disabled
Date: Tue, 19 Sep 2023 12:08:41 -0600
Message-ID: <20230919180918.2904313-12-sjg@chromium.org>
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

When inputting text outside the command line we don't want history to be
accessible. Add an option to control this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli_readline.c | 42 ++++++++++++++++++++++--------------------
 include/cli.h         |  2 ++
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index fdb84d9204f..fa8f525d3a4 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -361,32 +361,33 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 		break;
 	case CTL_CH('p'):
 	case CTL_CH('n'):
-	{
-		char *hline;
+		if (cls->history) {
+			char *hline;
 
-		if (ichar == CTL_CH('p'))
-			hline = hist_prev();
-		else
-			hline = hist_next();
+			if (ichar == CTL_CH('p'))
+				hline = hist_prev();
+			else
+				hline = hist_next();
 
-		if (!hline) {
-			getcmd_cbeep();
-			break;
-		}
+			if (!hline) {
+				getcmd_cbeep();
+				break;
+			}
 
-		/* nuke the current line */
-		/* first, go home */
-		BEGINNING_OF_LINE();
+			/* nuke the current line */
+			/* first, go home */
+			BEGINNING_OF_LINE();
 
-		/* erase to end of line */
-		ERASE_TO_EOL();
+			/* erase to end of line */
+			ERASE_TO_EOL();
 
-		/* copy new line into place and display */
-		strcpy(buf, hline);
-		cls->eol_num = strlen(buf);
-		REFRESH_TO_EOL();
+			/* copy new line into place and display */
+			strcpy(buf, hline);
+			cls->eol_num = strlen(buf);
+			REFRESH_TO_EOL();
+			break;
+		}
 		break;
-	}
 	case '\t':
 		if (IS_ENABLED(CONFIG_AUTO_COMPLETE)) {
 			int num2, col;
@@ -438,6 +439,7 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 	cls->len = *len;
 	cls->prompt = prompt;
 	cls->buf = buf;
+	cls->history = true;
 
 	if (init_len)
 		cread_add_str(buf, init_len, 1, &cls->num, &cls->eol_num, buf,
diff --git a/include/cli.h b/include/cli.h
index bbc53276435..252bdb70ab0 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -31,6 +31,7 @@ struct cli_ch_state {
  * @num: Current cursor position, where 0 is the start
  * @eol_num: Number of characters in the buffer
  * @insert: true if in 'insert' mode
+ * @history: true if history should be accessible
  * @buf: Buffer containing line
  * @prompt: Prompt for the line
  */
@@ -39,6 +40,7 @@ struct cli_line_state {
 	uint eol_num;
 	uint len;
 	bool insert;
+	bool history;
 	char *buf;
 	const char *prompt;
 };
-- 
2.42.0.459.ge4e396fd5e-goog

