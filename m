Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462F0CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E2186BDE;
	Tue, 19 Sep 2023 20:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aN+kWzQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF9686BD7; Tue, 19 Sep 2023 20:09:35 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F4A86AE6
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7950fac19f2so225414939f.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146972; x=1695751772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wjo/duw4z5NcylYePNRToShHWWD0c9l8TUS5k1qnDCE=;
 b=aN+kWzQhhE9VNlKfWqSq55N4+zq8vzaXinTPYJtNBAH9esBHKoIwJ38Tkhu5BnSZRG
 9e/zRZGQjVqnsT4YgonnCdVBpplkm90zKyGHG3nX4tRf61oTWmPrp63SPfjBFIarJQIP
 vLHQLRaKjaYbhUWG/oN/bA9GSeNaOtvqegHeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146972; x=1695751772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wjo/duw4z5NcylYePNRToShHWWD0c9l8TUS5k1qnDCE=;
 b=e8e35Fp3H2p/u+H6FZplr1FSI99saPju/Q3PoU1n0xIzx3detgbekKU7aHUOWEYboe
 ne6Oso3QzNo/VjCEVvH7QYqDA5iAvx/M+ia5GSNOjoQvJaPh00kw2ebSQ/Qys3T2M7U3
 gMV826ZEodCGbYBU9kQ/02Alxt5VkKLxzmUJ3DbojUTPFkmBoRoLY/jJ49btdN2Pcudw
 n7yDQr++FOFOjz79RK+9o7Od03hO4QpTWNI00FelF5E4z5BhRs/Y8X0KFRg5FmsypO6B
 mf7L5kv4gIp5Tmg5hSfvLt1u5yeXnlNzbYg1k7sOFaNCZUt7YW7saMzEvf2HWJpd1mrv
 2qIQ==
X-Gm-Message-State: AOJu0YyBnaILFuuGiPZr0H0bpluEFuuiI4rg1BC+7GNBWvVIAXdBGA0o
 5nPmlCwGeNVHQ1ZKD/RBgY4M4ijr5XlYvm+7+q0=
X-Google-Smtp-Source: AGHT+IEvedTJNHNuVvh125aIaQCcSd0HpgyqORRpiY+VVbEPmnr/x1YPHM04pfkp8eYIrDruI64Gfg==
X-Received: by 2002:a05:6e02:12a4:b0:34f:d7d1:f1bd with SMTP id
 f4-20020a056e0212a400b0034fd7d1f1bdmr565674ilr.13.1695146972500; 
 Tue, 19 Sep 2023 11:09:32 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/36] cli: Use unsigned int instead of unsigned long
Date: Tue, 19 Sep 2023 12:08:36 -0600
Message-ID: <20230919180918.2904313-7-sjg@chromium.org>
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

The index values are not very large so it makes no sense to use a long
integer. Change these to uint instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli_readline.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 687e239bfa7..f863404110c 100644
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
2.42.0.459.ge4e396fd5e-goog

