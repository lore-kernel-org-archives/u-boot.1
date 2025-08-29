Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4503FCA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2320E83608;
	Fri, 29 Aug 2025 10:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VVTwP38X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE02835EA; Fri, 29 Aug 2025 10:16:55 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105E283447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a20c51c40so14724655e9.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455413; x=1757060213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hgx3fP1f/JV0f4cHZNFr8JY8EzFhQrvXznVsWgXO8jI=;
 b=VVTwP38Xgx2X62zM0nPun0treAuYA+xpikSTdGKBDIzGv3J0FelH1DRwNeamS6zgQj
 U4RWzF4jbEc5YHe+46pRo8PNSFi/pIYVG4FuNDXO5h3a3XtKWuVY/x5R7RHO2UffMps1
 r04Ohn9td2LsVMIzWRlsv+ft9q+e/KrKpcqnJ/GnZAOfmQfKShjhEAZ+c8+vOan2i+HA
 HIjJL0/lxah2GF/pihmcFJOzZOTxXegT6MFsXUhY2A7S/cm+1EkQtFbdoFyuuWIh8Xjk
 BA5p/yNlQtQJ2CmhxOUBTJdRQZxdb4+uV9wwKKfkEH/VZ2VqZYd8DSs8ZjaGArtxP2Z4
 qUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455413; x=1757060213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hgx3fP1f/JV0f4cHZNFr8JY8EzFhQrvXznVsWgXO8jI=;
 b=lhEFWaQ41E3zWrXSftYcEJXaPARB4wokDORPRLmyjP4/elG1+LfiIawgkOhJrxBSTY
 0N9P1vFoorV1SnEU1B8mCCasdiZA/ZpYRb9xkW4Z1g0ryz2CQFLYDndByxOC1JU1reTG
 Qs6x3nXy6DZ4G61Xl/Kg4Jy5KYDXOy5f7jkwJmU7+BkQWiegcUkdKUjLkhi6MG/HSae+
 aXLMrOC+KQujIkrV+7MLVJ8YR8Vk9ndUYTy0qDg0uG41zOHk1aM3QzlYLfrBXsOMsxFA
 IFjUFpJwqqy3eMQzSQhqPyvA4EHaPccCid1DyuGT8HEQzi815Ew8JmvHu3VZSCdUVxMU
 0JPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAFtp//8E1GMYDtcyLdbSwxK5JRJIi6si007QZ2qpG6pJJtJD7hCB5l7TpwdxN+Q1anToWem0=@lists.denx.de
X-Gm-Message-State: AOJu0YzCsdTupH1Oq36eB97WqUbs3ts3MGc5kw8OJxwvqCu55c3oWjmn
 nfSnDcLEy4WwXTehbemsZ6ghHAQpENPl60J2eRDQc6hGWpkjNhtQUyWKrLcoVRYwWBk=
X-Gm-Gg: ASbGnctNmi3EHSIiIOFcJVy6OeCSBYGIjxdulb5XWI30IUuCvPXttLmC6ELsJ42s0IU
 qAfNk28IebW0JZmSyo3YhI2ndTeV3ByXNEUj1aluWe8Oy84GVaWsn4p7UM68fuAyX4K861M/KVA
 STRFQEYyi1iz+34fBrr2+i8O9IzKDo7wcaG4VbjeYw87+ZXDvV/5phaXNMVmJpXu06d98JKs9le
 dS5egnedQgiaSVrAb+krD568ybYq4gLeEL42am00JwHC1oLfS/0PXq4BA8c8TmndgPuFPCqqa0T
 LUBvisLO4D9BK40i4WIY42/a9efoOnJwYf3Z3iRX5ABDNnK6/QIffGpu1KoH/vf6Ireobh1TZLI
 JLZDpudE61VayL+2qMvyE69b1fXcqgfQNRbrYP5vhr7N79zXD5RmNfrN7HrdFNmRrrIV0CM5pET
 /Od+SmEQ3pp1J7J+SOKUOPTeikBHcK7AQh3h2R5H2XaBre6vPtqEqJHooqDFTF8RwWnhmXTh46E
 IFXEb9Y9ulcgkcrvx0eE9vHyOklYy7+K/k=
X-Google-Smtp-Source: AGHT+IHoZVFm4rjp79FKdu5COmP2loLFzmwbBftlSshIICgFV3MzLIk2gkot3o1qFCqi28thsHMEQA==
X-Received: by 2002:a05:600c:45d4:b0:458:f70d:ebdd with SMTP id
 5b1f17b1804b1-45b5179eb97mr315806965e9.16.1756455413489; 
 Fri, 29 Aug 2025 01:16:53 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm2449008f8f.12.2025.08.29.01.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:16:53 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, u-boot@lists.denx.de
Subject: [PATCH 6/8] tools: fit_check_sign: Mark usage() as static
Date: Fri, 29 Aug 2025 11:16:20 +0300
Message-ID: <20250829081628.2327372-6-ilias.apalodimas@linaro.org>
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
 tools/fit_check_sign.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/fit_check_sign.c b/tools/fit_check_sign.c
index 32d0fdb88295..ab3266aff204 100644
--- a/tools/fit_check_sign.c
+++ b/tools/fit_check_sign.c
@@ -23,7 +23,7 @@
 #include <image.h>
 #include <u-boot/crc.h>
 
-void usage(char *cmdname)
+static void usage(char *cmdname)
 {
 	fprintf(stderr, "Usage: %s -f fit file -k key file -c config name\n"
 			 "          -f ==> set fit file which should be checked'\n"
-- 
2.50.1

