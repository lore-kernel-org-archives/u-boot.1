Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC738CA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C29835CD;
	Fri, 29 Aug 2025 10:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gecdykxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39405835C7; Fri, 29 Aug 2025 10:16:46 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACB183447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ce47d1f1f8so1012559f8f.2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455404; x=1757060204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zLmGmG6Gfy+joK5O55F3ymW28nN6esW0rD9vsLwdnU=;
 b=gecdykxF83QsJPnz0SbkXYFqhPrAiHsQgE3gVsxDsTWrMzK9E0MP1fA4NM/RM3xa1o
 IgXDQ4T3iYnmpWb5Po9vaF9Ydm3mLYW3OFjrayG1U86T8de3zP7qA9kBJjmGDhBOe3xT
 CAM+YdO4CpuWXXmjltN07WF/DjimJ7NJy174LAgbEv7BWcowPdsKORZX95KdodQGaslk
 CV3pLIUypX/88i/4S5bc6VJYaW5/SkHV7beENuM0VW7Ynk7+JH/CqJOJigYuAz4IXV91
 Y0EG5uHOZzeTIfop9ZppqHuLqmMn8dW1jjaEgYzIC7DoZzeY/451YXM3KANlsZOWUuFz
 rcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455404; x=1757060204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zLmGmG6Gfy+joK5O55F3ymW28nN6esW0rD9vsLwdnU=;
 b=CrT1eVIiTcSkXVeqaq+FWizmkmbOX8q5FuU2iG7W0KaAWLzG3xRqBjl4ELlC1IPE/F
 5bAxEcrvrPZakOFuHAeEaSVzpRp/1+a4/Cne26MxGglw4tro8/kIrrS4i7Z2wgL+BETz
 WC5NYB2Xu471k+CVIG/GUZxXdKo8W7ZwiHVfg6p8N3w/cQEZpGyu7hjbwjnx2ZUowLrp
 zEEmCo8sGoGhGus4dafIfXaS2ZWRBnD5WEio5etDOUjF87TUTVgauPjoK3hSzPLZu6h/
 fPLsJlSJvCfRlfiH+CnW/Iqgc7TfdzJcgBrvJNwKYRjur20kDJukzcdg4BJ/bM0eqm5Q
 Rg5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV3QK17uoQIcUupNxToM3TJZ//CryQSnYwchA001vz2QdwRsKwLffuyPOXkTo8lvCzrUweCBw=@lists.denx.de
X-Gm-Message-State: AOJu0YxVsJpkX0Tl4O/OivljSZ+IafcdeCAkgyoyU5Id9mw1aLKWDwFx
 QpdVprH658bRcDg/FMpUxw/8Z4YUKuMq/J392MzlhbAo/jXFtlYPhgc1fYacfEWbBU8=
X-Gm-Gg: ASbGncujpxHd+ZbW66UHVMDdwmp/dSclIYJg5vHA7t88xxy/DkWA79G+viVSA6FU4yu
 +t+YE48x6bcNeGtZy58JHHZBWGz7K/FUaEtMT+VxHp+yeS1DNos7XFXnT96WWtVgMrEHxUPlZRf
 yjz9M6dVib065WP2/k5WRcGaIEbqwlmkchavakD8O8WF4FvNrhEwbvoTKhT2sWHYtQCxCblTcty
 xqE2eVhPO5YfTXcKkDvy8Q1Z0z767RR09NoZE2iVAB8FJzUb19eKCpQhfMwnEmUd/xbrpXa/aAb
 0rmpuwtq7pZT7DkoomLgAvIQvPxMKvxbFrTivYt7kkSiQbPJ1tlVL3n83AdEi472w5XajAuyZ/m
 X8/ejlYCpKLO53u82Eq6rS3FTYkK7Xxu+MFq7leNye4DmjExV705kY8anOELrjrixJcoMwSqBlU
 1lQY+fhug4RJ1eqeFJp+j6cnZhWqmLFVV1YYh7s5meg0xdBoG0SroPrIe9Vz0NIVweKt2R5FOhf
 eL1I/ruwu8hhRWP/c7Ncot1eZoLyz0WXNRSBZ/k5UKlow==
X-Google-Smtp-Source: AGHT+IEaBMdiXiROn+TSl0zK096klZb50TRFMyZxICmJGgjhpfTWNqpklWtMkBK0BWRcjz2HUPydlA==
X-Received: by 2002:a05:6000:2088:b0:3ce:3a38:d857 with SMTP id
 ffacd0b85a97d-3ce3a38dc00mr4157962f8f.25.1756455403616; 
 Fri, 29 Aug 2025 01:16:43 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm2449008f8f.12.2025.08.29.01.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:16:43 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, u-boot@lists.denx.de
Subject: [PATCH 2/8] tools: fdtgrep: Mark util_usage() as static
Date: Fri, 29 Aug 2025 11:16:16 +0300
Message-ID: <20250829081628.2327372-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
References: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
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

The function is only used locally. Enabling -Wmissing-prototypes
triggers a warning. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/fdtgrep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index 6372defedc2e..b4c041070f56 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -1040,7 +1040,7 @@ static const char * const usage_opts_help[] = {
 #define util_getopt_long() getopt_long(argc, argv, usage_short_opts, \
 				       usage_long_opts, NULL)
 
-void util_usage(const char *errmsg, const char *synopsis,
+static void util_usage(const char *errmsg, const char *synopsis,
 		const char *short_opts, struct option const long_opts[],
 		const char * const opts_help[])
 {
-- 
2.50.1

