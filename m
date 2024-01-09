Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88372C47077
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 22:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3E8877FA;
	Tue,  9 Jan 2024 23:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sIy5wLTE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6FE87824; Tue,  9 Jan 2024 23:57:21 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3421876F6
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 23:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bbd6e3795eso3065323b6e.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 14:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704841038; x=1705445838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=q/wf6q936WuyN/7LHLqS09qLQsW6QwnDhjFH+bsJqrc=;
 b=sIy5wLTE6JzHGaqOWlIsBr+GF1OlVbL5ykl5tcj5a2im0j5uGMzCSl43jsAgTcWtlK
 0UQfiNNs8JFM6J+HuVNiLDlwFFmlsvLVVFKyDRne3joLLOyVbtcqGd0bQAwrpxX+38qD
 T6R376TQPdeHOXjE0mmLKocnGmYYqKAGOPzOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704841038; x=1705445838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q/wf6q936WuyN/7LHLqS09qLQsW6QwnDhjFH+bsJqrc=;
 b=Sfz9peJ57TqfOcJ+bhtQ9hHCEvUf9QTIf/DygGicTWZ9yHfOK+9FNJzxTZcnwaBrCN
 n510to3km2kGMv2MmdBgKvtN8/2bil/zMmvXWlikqY5C+VjVb+7hx8joiECpLM/USVf5
 mBqy8wYCyPWmXi5WcCy7mPKtRMBJw3Rgyic9hIDcbwowsPjK4J0/niPe3lcimK1vhfuK
 j4tyiweJGbDgYZWq+xufo8akOULANHYXSlamU4GuPWbj34t8fFJgMo9YNidwHhQ23LXy
 eqI+wvlv8pxqNLX9EOkyt82wr3f5+qXPz+bFsi5J94fhsZLl921poC7pWlI6HumBBdGa
 53rQ==
X-Gm-Message-State: AOJu0YxjkFe5kBdHT8Zi+HY7sr2bbVGcj/u0c8uCDtyOHFYyZPg5oAWM
 W70nwonbCKIVTPPjsZXhRKlY2RSbQS6Pti+lvl4vtLVvjyw=
X-Google-Smtp-Source: AGHT+IHIu6E1T/jgDBICe1MJYdRfwOHB/K3UjRI17ME7NixvYMoMsArtJhH3doJ96STFC2i5ly2QuQ==
X-Received: by 2002:a05:6808:1994:b0:3bc:1f2a:8935 with SMTP id
 bj20-20020a056808199400b003bc1f2a8935mr141440oib.60.1704841038124; 
 Tue, 09 Jan 2024 14:57:18 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 ru3-20020a05620a684300b007830d394563sm1175981qkn.0.2024.01.09.14.57.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 14:57:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] getchar(): Correct usage
Date: Tue,  9 Jan 2024 17:57:16 -0500
Message-Id: <20240109225716.3520037-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

The function getchar() returns an 'int' and not a 'char'. Coverity notes
that "Assigning the return value of getchar to char ... truncates its value."
and so for the most part we can resolve this easily by using 'int' as
intended, and often used throughout the codebase. A few places are not
so simple and would require further re-architecting of the code in order
to change this, so we leave them be.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/load.c            | 4 ++--
 common/cli_readline.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/load.c b/cmd/load.c
index 2715cf5957ee..540361b43f02 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -230,7 +230,7 @@ static ulong load_serial(long offset)
 static int read_record(char *buf, ulong len)
 {
 	char *p;
-	char c;
+	int c;
 
 	--len;	/* always leave room for terminating '\0' byte */
 
@@ -827,7 +827,7 @@ static void handle_send_packet(int n)
 /* k_recv receives a OS Open image file over kermit line */
 static int k_recv(void)
 {
-	char new_char;
+	int new_char;
 	char k_state, k_state_saved;
 	int sum;
 	int done;
diff --git a/common/cli_readline.c b/common/cli_readline.c
index 85453beed762..2507be229526 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -540,7 +540,7 @@ static int cread_line_simple(const char *const prompt, char *p)
 	int n = 0;		/* buffer index */
 	int plen = 0;		/* prompt length */
 	int col;		/* output column cnt */
-	char c;
+	int c;
 
 	/* print prompt */
 	if (prompt) {
-- 
2.34.1

