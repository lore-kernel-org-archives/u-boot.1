Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D64BE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C3C8713E;
	Mon,  2 Oct 2023 03:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DFLQnpO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39081870E1; Mon,  2 Oct 2023 03:14:06 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C7286D7C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3514cddf90bso34759105ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209238; x=1696814038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMVdeegsnUZ6JGehDNwEnXsInc74azYED2IxH6gafJg=;
 b=DFLQnpO1aFFzTQ6hwao+zfAz6xBNNhFNK/6tFyJWj7hG06PkQb13L7MymPp31QF3Gy
 WeLhZWErL1URQwLmKwNXTvGXw7Goa5g0iclEzZEddIHJaf81fBe/fiwvAFhrh5zESwk9
 nxZt+Th99LdUZ7eh8P6wtoh49jHjDryvoCq+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209238; x=1696814038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMVdeegsnUZ6JGehDNwEnXsInc74azYED2IxH6gafJg=;
 b=qAGxONEkZ1h/fsar6qi1/YsMk+SMjyI2IsY4XKgl8rBkRds3hNijC9CzvrrL3apaj3
 BvLi+Isy390+8gYY399CpNMb0jVx7IP1Db6VHw7BNIU+FRoJ2x2bu3wdNspzmymrSqy6
 fj4ftz/W+DVIjK5wbknX+kdoRT2+FbcblW/U34yWsRzzTIwhLvfXB9N8h0ioU7JMgnEo
 Y96s5k1hhFCHoXso7eht6+gqjfNqX1uZ0tXSl/4KWpmA3+fWyf6m8CveI1rk8K2Ni8Ln
 tTnCzzm0jHOEukaW7VHlbUg32YcqVXupQ33Jyd16kM9v2KxpAQdAP0V48/N3zZCvRauM
 fM1g==
X-Gm-Message-State: AOJu0YwzxcE/SWGNtaSQJrEFc3SSimWAtj5kE9PJfnLWIVU+PwP89z56
 fsUSUw/OV5Hz9dTyxeeuEOkifVsMcH/iGJdB8+A=
X-Google-Smtp-Source: AGHT+IGqmbKQtlUZ7cTaKgnFGtUje3lbyo5Fbf2IWGSnfw+o8yhv23aAxVUEDABn/gW8kDge0d4Ohg==
X-Received: by 2002:a92:ca0f:0:b0:349:927a:5d85 with SMTP id
 j15-20020a92ca0f000000b00349927a5d85mr15054977ils.22.1696209238127; 
 Sun, 01 Oct 2023 18:13:58 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:13:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/36] cli: Use unsigned int instead of unsigned long
Date: Sun,  1 Oct 2023 19:13:10 -0600
Message-ID: <20231002011349.461284-7-sjg@chromium.org>
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

The index values are not very large so it makes no sense to use a long
integer. Change these to uint instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 687e239bfa77..f863404110c3 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -171,7 +171,7 @@ static char *hist_next(void)
 void cread_print_hist_list(void)
 {
 	int i;
-	unsigned long n;
+	uint n;
 
 	n = hist_num - hist_max;
 
@@ -211,10 +211,10 @@ void cread_print_hist_list(void)
 	}					\
 }
 
-static void cread_add_char(char ichar, int insert, unsigned long *num,
-	       unsigned long *eol_num, char *buf, unsigned long len)
+static void cread_add_char(char ichar, int insert, uint *num,
+			   uint *eol_num, char *buf, uint len)
 {
-	unsigned long wlen;
+	uint wlen;
 
 	/* room ??? */
 	if (insert || *num == *eol_num) {
@@ -245,8 +245,7 @@ static void cread_add_char(char ichar, int insert, unsigned long *num,
 }
 
 static void cread_add_str(char *str, int strsize, int insert,
-			  unsigned long *num, unsigned long *eol_num,
-			  char *buf, unsigned long len)
+			  uint *num, uint *eol_num, char *buf, uint len)
 {
 	while (strsize--) {
 		cread_add_char(*str, insert, num, eol_num, buf, len);
@@ -258,9 +257,9 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		int timeout)
 {
 	struct cli_ch_state s_cch, *cch = &s_cch;
-	unsigned long num = 0;
-	unsigned long eol_num = 0;
-	unsigned long wlen;
+	uint num = 0;
+	uint eol_num = 0;
+	uint wlen;
 	char ichar;
 	int insert = 1;
 	int init_len = strlen(buf);
-- 
2.42.0.582.g8ccd20d70d-goog

