Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A387ED12685
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 11:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD4C8900E;
	Tue,  5 Nov 2024 12:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vhRZJfnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1134890C5; Tue,  5 Nov 2024 12:09:17 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2ED88FCC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 12:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso43601045e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 03:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730804955; x=1731409755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rcSlsoUbKAu04euI6y+VB0cX7Ne+6MGxcY6IFERKxNE=;
 b=vhRZJfnuoeZo52W198Tgj7rYD+AoYMCoXHg6Vjm8+ZC3ReEPN/1II10MEviQBStmn8
 zU9Xno5ijxfeQOkKIw4pq6wRF8aVl0iBgJm6fHBWleFi2sQLze4H1A06hiR2rqER4qzx
 cn9zGKxlo25QaSfyJyaHuBO4wMaiLVdTxLpdhAh5+l1vTq9tJCoSl9cC3rXeucqGFBjv
 xWNM4peZtuD344v6Ni0v02XRCwvehzc2eQk7D6+txn0qKWbzCOhTJw2mstly1caj2dAg
 f7PSurJUYXflWWitZDMprAbCM30O7yL9XoZZrFfV1z2de4uSI+JlhXwDJTb41HYHJmru
 CwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730804955; x=1731409755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rcSlsoUbKAu04euI6y+VB0cX7Ne+6MGxcY6IFERKxNE=;
 b=t3x8zuCGS3/SpFn+/lUI7pM+bq1M7tn75WmYoUQkuvVOraht//SeJ+orw7c1ehdWcG
 8usiL8Gvx7yfd3dOV7zNuSNnNsyFW0Akd5mVOyl6xejkxo6MUuXyq2wmvGByDX7jUntZ
 SVCI6/UC/N5blh4MffEwUtKcaBuANvbUHRLwC8pfF3FdkxbYiZgWAJO+hGl7aWOodUoY
 iLEC67rJNE+CFJy/5Lke8pthcakhcxThmIF5s25+ea2oYPeLy3zsPB9HYqicyhH4fEHH
 +E2EGNYK+Nt9siB6w3aps8PnZzHSXDHbOvuxbuF1kdBY+tdrwVGvV34zUcOO2VdHkGgi
 lwLQ==
X-Gm-Message-State: AOJu0YzNEprRYih/+9oadRqMQe42CAYAkIb9/09ISfOD7dx+Ld7kNQPm
 cLy2IJgF45Gy8yOez77GpUqGfhAeRMzixFkPBezOm5VcguVt3uYcozX/fGlYem+tZM8cXEbOwhp
 dc2fCzS3l
X-Google-Smtp-Source: AGHT+IFevRa7TUP7HH9qJ8SCktcT+mUxlMKKn6QAh4dmtwdgMc4t3Bf88rPoIrqKc4aN07XCZGoKsA==
X-Received: by 2002:a05:600c:3593:b0:430:54a4:5ad7 with SMTP id
 5b1f17b1804b1-4319ac76449mr327759005e9.1.1730804955097; 
 Tue, 05 Nov 2024 03:09:15 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf447sm182018855e9.13.2024.11.05.03.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:09:14 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] nwt: wget: drop Content-Length processing
Date: Tue,  5 Nov 2024 12:08:49 +0100
Message-Id: <20241105110849.41348-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

We don't do anything with Content-Length except a debug print, and the
strict_strtoul() call is incorrect (it always returns -EINVAL and leaves
content_length to zero due to the presence of trailing characters after
the decimal valuoe of Content-Length). So let's just drop this piece of
code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/wget.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 635f82efbb3..361817ace65 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -26,7 +26,6 @@ static const char bootfile1[] = "GET ";
 static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
 static const char http_eom[] = "\r\n\r\n";
 static const char http_ok[] = "200";
-static const char content_len[] = "Content-Length";
 static const char linefeed[] = "\r\n";
 static struct in_addr web_server_ip;
 static int our_port;
@@ -46,7 +45,6 @@ struct pkt_qd {
 #define PKTQ_SZ (PKTBUFSRX / 4)
 static struct pkt_qd pkt_q[PKTQ_SZ];
 static int pkt_q_idx;
-static unsigned long content_length;
 static unsigned int packets;
 
 static unsigned int initial_data_seq_num;
@@ -251,17 +249,6 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 				   "wget: Connected Pkt %p hlen %x\n",
 				   pkt, hlen);
 
-			pos = strstr((char *)pkt, content_len);
-			if (!pos) {
-				content_length = -1;
-			} else {
-				pos += sizeof(content_len) + 2;
-				strict_strtoul(pos, 10, &content_length);
-				debug_cond(DEBUG_WGET,
-					   "wget: Connected Len %lu\n",
-					   content_length);
-			}
-
 			net_boot_file_size = 0;
 
 			if (len > hlen) {
-- 
2.40.1

