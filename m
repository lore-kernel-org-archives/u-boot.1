Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC80C282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4C7819D9;
	Thu,  6 Mar 2025 01:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y1XDBNe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 177E080BAA; Thu,  6 Mar 2025 01:28:23 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9AD8192A
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85ae1c53da7so10567239f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220843; x=1741825643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCsKlW3FZHzWuNMzw0pSlqFonlPLEu8xbNUUc2E3f7c=;
 b=Y1XDBNe+wvB/EuaPZRtmvdVVjV+I0DtyI3Vtgs5y153ygTBChr7sX3dEzlwkezXLdd
 69U6ZkabqrD7pRtrChDsJCxONsht1fanbg7XSWkcm6Zg1xX0/gSXL8a2eiwxxDsQoC5R
 afi4rQbzS4RtxKRtXp1kQzGkFlSauPuca67ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220843; x=1741825643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aCsKlW3FZHzWuNMzw0pSlqFonlPLEu8xbNUUc2E3f7c=;
 b=cA7ogTL4H9T6NMdwQan6B1aROTyjQvF8vL7XlsX768pZP/HWV2M3rEOVKtOVJuU61N
 5GZM6xhJj/Il6hirz3KGb1BNXiXQgA1Z7GIhq2zLWnPDvi/rC++lSWT+n4GAs2+PMCiC
 F0qD65Zd3yKWg3pmDrDDjSgDEsexLosrdps3pafdAfNl4EA67f1t5+g95T+6VLIelcC3
 7Sf0fVN8Y3rvIM/blsNkwDu7lGZv+Z5TuR5sgbio4gWPOjZoLWsSOwe71o+bhsg0FqBi
 ItJRka0Wc7UugtHWt7LTdkLzBHL/C28cLi7912JDN754vwgIkGB56FlD5we/Zh/VrQ5m
 76PA==
X-Gm-Message-State: AOJu0YyklHYKmcqevu8UIAP11Ys2menaEhQUmWMnMLbEH5Yy5FpwpyBy
 cKAJkZwP5nNGp2mUlP8m9SXZnJGhlolUD9UTp8S4kJyI+EJ1qD6XfvKWZubDCL9sd3muaT9vloo
 =
X-Gm-Gg: ASbGncuklNbqgUD0o4zZbMkjaxGLaM6ozJo3FDEzyBNt8ebMXnSKPy06NQAtdjautnH
 dVy7CzjC/00MgAmJrzadKUhDTOWa5wZdQNtfBqvCTlVmStvGAY7FdZnRtuBSubKXCQCOZJqga29
 ljkMxyov8JgETgkKpJmgPJEhHdDgqdl1Lj3fb4wFc8rkMacDmEOm2erj2HRtnUbeOlHy6GoaVy+
 aS4GxfFJsxR3a7Kw1UwAwayEWRcBr6g196s/puLIFca2SXoI0EmjkA255c7D02/7lNOu3AhKjzc
 GNJRnsNEDMcTfF9YeFfvPDj3P5HWpXq9LttobpRn7BnMv5w8jXdQXZA6gGyi6suWzSIirzhjT9t
 +a5j6Zg==
X-Google-Smtp-Source: AGHT+IHMxpzm289WVoywWJ5t6z66uR3lRXynkZ4oQ62KVsG03r7nrkdQNqmeprSujiZx8xLgW/+V/g==
X-Received: by 2002:a05:6602:2770:b0:855:6965:6660 with SMTP id
 ca18e2360f4ac-85affbb307bmr603776539f.13.1741220843343; 
 Wed, 05 Mar 2025 16:27:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 21/29] net: Keep the bootstage functions together
Date: Wed,  5 Mar 2025 17:25:15 -0700
Message-ID: <20250306002533.2380866-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

Move the bootstage_mark() function just before net_loop(), so that the
IPv6 code is not in the way.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 79525f73a51..deebd5b710f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -413,8 +413,6 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		return CMD_RET_USAGE;
 	}
 
-	bootstage_mark(BOOTSTAGE_ID_NET_START);
-
 	if (IS_ENABLED(CONFIG_IPV6) && !use_ip6) {
 		char *s, *e;
 		size_t len;
@@ -428,6 +426,8 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
+	bootstage_mark(BOOTSTAGE_ID_NET_START);
+
 	size = net_loop(proto);
 	if (size < 0) {
 		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
-- 
2.43.0

