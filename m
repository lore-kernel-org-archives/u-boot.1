Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB46DE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7FE8716E;
	Mon,  2 Oct 2023 03:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cF/1/hqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351BD87108; Mon,  2 Oct 2023 03:14:22 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E2587107
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79f8e4108c3so557276039f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209243; x=1696814043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J50oeUHgdYQNK8+xDZwr+JsHiqqUIgib6Nqsd+WbRfI=;
 b=cF/1/hqeXA5I17KeEHNuP2Ixuz+pLsKvQ7CfZV8+eSgsjdL8tD26cdJB2muvt59qoT
 BIIE03d+MPDIbeeMqMLod41fJz0KWhtWWK0UwN/gBGkZKzt+a+3jsh1/7SOoiUhotFgn
 Itt9o/C+tw3OmlOhPkF02v4zEmqZ+tXblpxNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209243; x=1696814043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J50oeUHgdYQNK8+xDZwr+JsHiqqUIgib6Nqsd+WbRfI=;
 b=tfjn2Mg8Z6nvglQeCLKF5UWVrWG1Al7aHtMwLPrg5ZFt0aPZNeijkoB1VkkklU0glv
 Ez0drV0u/QdM0AkCeLZfsYmzpFTduFf2+yRcccLgbIvr3LE08S7ejAAG+Ah8/dcU1aDB
 BT1PBx+K/NmpD1/zqJrL8B0QCO20/JAjQMx8l/2RChgrj6XRyFQVHluq2bTofK2ojjNa
 VBs9HnvmPnoKhyME0F7qClVivDUvtWADt9hBz80oSoqVRaeybS4aPTJcVNYQjPe1rToy
 W9+6dZz960Q9hVq1vJ5fGUiBdlOpYlwV92PVhO+s1Ur4bPkxiKakD7XHRltSiDV18RNM
 UfuA==
X-Gm-Message-State: AOJu0YwCYoDZ7adQ3qyJ12eAD8ijfIl91iBCXQODIu8yEuSrx+psQpTE
 QfY+adiVGLrFWR/U2RHxBU6inGtdXyyY6ugcfRA=
X-Google-Smtp-Source: AGHT+IEWvAiZwBRPvrA1dGo2Bo5ya6lbO/7QABPkabNVFN3JfIFShdvWk4wIguZ+qvmHwXpSjj7FbA==
X-Received: by 2002:a05:6602:86:b0:787:1d0a:ce81 with SMTP id
 h6-20020a056602008600b007871d0ace81mr11631832iob.13.1696209243194; 
 Sun, 01 Oct 2023 18:14:03 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/36] cli: Allow command completion to be disabled
Date: Sun,  1 Oct 2023 19:13:16 -0600
Message-ID: <20231002011349.461284-13-sjg@chromium.org>
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

When inputting text outside the command line we don't want to use tab
for command completion. Add an option to control this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 3 ++-
 include/cli.h         | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index fa8f525d3a41..23913a857a99 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -389,7 +389,7 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 		}
 		break;
 	case '\t':
-		if (IS_ENABLED(CONFIG_AUTO_COMPLETE)) {
+		if (IS_ENABLED(CONFIG_AUTO_COMPLETE) && cls->cmd_complete) {
 			int num2, col;
 
 			/* do not autocomplete when in the middle */
@@ -440,6 +440,7 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 	cls->prompt = prompt;
 	cls->buf = buf;
 	cls->history = true;
+	cls->cmd_complete = true;
 
 	if (init_len)
 		cread_add_str(buf, init_len, 1, &cls->num, &cls->eol_num, buf,
diff --git a/include/cli.h b/include/cli.h
index 252bdb70ab0d..ad3cb4499fe1 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -32,6 +32,7 @@ struct cli_ch_state {
  * @eol_num: Number of characters in the buffer
  * @insert: true if in 'insert' mode
  * @history: true if history should be accessible
+ * @cmd_complete: true if tab completion should be enabled
  * @buf: Buffer containing line
  * @prompt: Prompt for the line
  */
@@ -41,6 +42,7 @@ struct cli_line_state {
 	uint len;
 	bool insert;
 	bool history;
+	bool cmd_complete;
 	char *buf;
 	const char *prompt;
 };
-- 
2.42.0.582.g8ccd20d70d-goog

