Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E737FD58D6C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67556895A0;
	Mon, 25 Nov 2024 18:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FBWH5Ruh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8603A89A53; Mon, 25 Nov 2024 18:17:03 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF83895A0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 627083F8D9
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732555020;
 bh=Ltp7msWrbuqAm3Eu1yne+XL3geVlNA4ONB9l5L/+NC8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FBWH5RuhHJePCKeoXLk90435RVYtjrUQLPZVX1SFFdI9tjjtyZR2xBwQskF04wV3g
 mG1M9s6gph7Tb53EQBo1e36v8lzBqocztqwn5KFg7MBAuDmecdCxMk1iDmcnrJ5v40
 x1vCcrHHYXHLzXAzat1bEfLcgEA0/cc2efuRZchxyu7p+qX37ukuqCCsvuoXqS+2OS
 nWwWIYucRdcWb+H78E+K3MAiptFaO0E8wR02gr1DIzXiG5FoNZrfhMKCfC96n4j/6T
 f8iVCRk1S/Np+M/y75MrhrtwCm7agzGMsFeg+rK4q/xEhW4X9DgO3SYytuY5qTKj5i
 AClV40481LwSQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314a22ed8bso34010015e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732555020; x=1733159820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ltp7msWrbuqAm3Eu1yne+XL3geVlNA4ONB9l5L/+NC8=;
 b=fAxcJXXS0Zh9dDbvNpb6C7/G45n/GyVpfcyL2Iba18qimizkUbwX4/HncQ9U8lp291
 eMFpBuNJ7jpsrjoLZjI3k28sS6OmfA6sT6voyRlY4w3KcCybLiBxzHuDn/huUQ091jFG
 sFrjw/UP13QuXH87YznkXuqOxUMo8cw8Z0U7JzuD8mjr9KDUIVekdXwHyobQ0c6Dc/H3
 M9jdZOQwSPq3A2Fq7eFFS4jZNg174+TQti0sYGr5/XrAJXrTKQPp1iaPp0lNaMFt5yrv
 nZWaNU53PZ6neslYUH4XFe1EAdaqu7vRPqipg6HD/8HrgbmB8IY6WgzeHnFiQegCuler
 RKYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtoDTqx/UTZAlxJiy0A2YS4Rb/x17+Wo5ZFNZI8kLGR9XeDGoL04wmQYXNs+SZd08QR/BKtt0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz185orug2AIriaN6uom4FQn1qzFqu4BYhyF/u5aO0uVnNPLHhx
 5i0TE6thUSm1KYTRme1JRx7zsW3CPRNNIBFKa2HzaaiPRPgxLwtmvjx02ufoax11HQk+1kiYV8/
 dDdBoROQrY2CdO4pnTiOWpS0FDa0UFCr5KdZqzdb26O+5CNdyT05qLan6MYQLlFTc4z0=
X-Gm-Gg: ASbGnct543QipuSNirKfj2+/F+iId2noG4uZ43mPN0ixzgHbofv0eW2FeNHU5fl4CHr
 FbaNCoO5ir2I1YI++C2WM60DnHxrkQ5z4mugmVdMqE8cmu6PJ2W8z83f+FsllWyC7ip14zt6KeF
 YvaBRR2Pwwzm/bO445PshOVhFV6BSS+3ktv3s2CxX0UHp5r8K6Bs90y/m9VGqHDM8PnXYDETEl9
 4dSV7PR32zBVdHiBni352aYxsQ0qvG63v2DI9ssR6o1aJV768tZsLf3hGdXeXwz7IWWk8ACi0Ey
 XvX2tMTk
X-Received: by 2002:a05:6000:2ae:b0:382:5206:8b84 with SMTP id
 ffacd0b85a97d-38260b5b839mr13093612f8f.14.1732555019963; 
 Mon, 25 Nov 2024 09:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkSB7UgjIwAdw3aEkIayPYE0x5/UK5O0unOrW++3ia0ebcM3FturWYPzNBjDyZHZ9b4sihMw==
X-Received: by 2002:a05:6000:2ae:b0:382:5206:8b84 with SMTP id
 ffacd0b85a97d-38260b5b839mr13093580f8f.14.1732555019673; 
 Mon, 25 Nov 2024 09:16:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:c8c8:ead3:f691:15b7:cddc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc38afsm10877938f8f.67.2024.11.25.09.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:16:59 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: zero terminate string with headers in
 wget_fill_info()
Date: Mon, 25 Nov 2024 18:16:45 +0100
Message-ID: <20241125171645.126487-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Commit 2dd076a9c1b4 ("net: wget: integrate struct wget_info into legacy
wget code") introduced function wget_fill_info() which retrieves the
headers from the HTTP server response. As we want to parse the string in
later patches we need to ensure that it is NUL terminated.

We must further check that wget_info->headers in not NULL.
Otherwise a crash occurs.

Fixes: 2dd076a9c1b4 ("net: wget: integrate struct wget_info into legacy wget code")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/wget.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 3bc2522cde5..b290ca1843e 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -208,8 +208,13 @@ static void wget_fill_info(const uchar *pkt, int hlen)
 	const char *second_space;
 	char *pos, *end;
 
-	if (wget_info->headers && hlen < MAX_HTTP_HEADERS_SIZE)
-		strncpy(wget_info->headers, pkt, hlen);
+	if (wget_info->headers) {
+		if (wget_info->headers && hlen < MAX_HTTP_HEADERS_SIZE - 1)
+			strncpy(wget_info->headers, pkt, hlen);
+		else
+			hlen = 0;
+		wget_info->headers[hlen] = 0;
+	}
 
 	//Get status code
 	first_space = strchr(pkt, ' ');
-- 
2.45.2

