Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7133ACE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D4A86C00;
	Tue, 19 Sep 2023 20:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sva2clPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D234386BC8; Tue, 19 Sep 2023 20:09:40 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C669786BD9
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34deefc2016so20253445ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146977; x=1695751777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdmqZcksjF2qzRE7RHG8XazaaChTsIcLIOMb0kRZlf0=;
 b=Sva2clPoVGyFOLXoQk1lItamLnOxGRgT0BQ18DWqWBoelD8rD7RuEfyNnaJ6xrQsyM
 +3olZba0g7KszZC5Z7BhrtCrxDYm6FeOZLenjNNNowUyJoW+joLDTwrMxWdeo874CRxL
 WxHnJ6TqCJp/3nfZBQiohIRHJhbfFOoAV1xIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146977; x=1695751777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdmqZcksjF2qzRE7RHG8XazaaChTsIcLIOMb0kRZlf0=;
 b=hNEbZue+Ra7obM4BU8UNadpgm3Tbmo0SoktzIOtqWN5YqZi7VihXFRgHUKXaIbG6fr
 hkDXm//sHh8LdjZBUbrzMhEdSPtj8djBNW4VGgXj0Q1Lz+F/oyZJtKP9kxGrj3NrQhRo
 1+FMe8s2huHz+yxkr3lad6nbOikNa7SOSH64E5/N+RAjrrnq4YSGU7UVTCFmbcSKrH3X
 8unIlms5agMI/4E2mrwZqZrXDtqjg0ioYOFNjs3k7AQBvp1DkWRhZn9XHERSEs8s1V4Z
 RMiFdAargHwF/NxYYlZAgHV1zdhIZ5YRlQf2rQUf/BQa0l66L6dXxyIqtOsqM0N0QRgw
 OjDg==
X-Gm-Message-State: AOJu0YyeOtQ+iF9roMgx6y5DhCuzbyxzwm/i9dGbASNd9sV1Yu7zweEQ
 XG5MVLtVY+P5EsKnxpWqu97Zt7Q1MDM4OvC8mN4=
X-Google-Smtp-Source: AGHT+IFBvWJ9hw5HLsVlfNWhQfhucfdX/D6hPuLzMYqyfVYGyJmgTiZFBcPuLNP4QeUZMtMhYS5lBA==
X-Received: by 2002:a05:6e02:dc2:b0:34f:ef7:53d0 with SMTP id
 l2-20020a056e020dc200b0034f0ef753d0mr507852ilj.26.1695146977253; 
 Tue, 19 Sep 2023 11:09:37 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 12/36] cli: Allow command completion to be disabled
Date: Tue, 19 Sep 2023 12:08:42 -0600
Message-ID: <20230919180918.2904313-13-sjg@chromium.org>
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

When inputting text outside the command line we don't want to use tab
for command completion. Add an option to control this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli_readline.c | 3 ++-
 include/cli.h         | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index fa8f525d3a4..23913a857a9 100644
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
index 252bdb70ab0..ad3cb4499fe 100644
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
2.42.0.459.ge4e396fd5e-goog

