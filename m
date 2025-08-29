Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83062CA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 469DF83542;
	Fri, 29 Aug 2025 10:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xDuTjOc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D08C8354B; Fri, 29 Aug 2025 10:16:48 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA0883447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3d118d8fa91so20216f8f.1
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455406; x=1757060206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeLSnspAFa1ScJRthrnPVILKdP8RRtiV0gcw8ufAZrk=;
 b=xDuTjOc3HCGWZ8fMxBWCUCcgHOyW5z1aT/nqzmOACJy9uXMgnqKtJWWTwOiTdylgsI
 lZfSOKV0BBuGszW9gc19PlrrIJ7QbBZVem5CsNiRc5gSSy9o58LuvgvCgNRP6oNums8N
 zJgH+cJrUx3WrZ5anFNvEclzf9phSuA7LhKj5MArKFoJ2b9CpVwHv4ahHAd8XWszvQlM
 lqATqha4uOCyvFOiIPFE8Yjpebl1DfLHwgxSglVDB84wRkjIObbFxYnrK3ppQEQ1wExA
 +zTFeveH1p7ZyYs8TAzxBVOX2PhTj/QcmDyQxxDlGZAmyq1W10p6BDGwlD2r+N5UYts4
 VRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455406; x=1757060206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeLSnspAFa1ScJRthrnPVILKdP8RRtiV0gcw8ufAZrk=;
 b=hPzYkky8owtzfvE1mA9IXi50sKkjSlvTb/iiIL/sVUABbDcQdiohf/nOzwe30wokPE
 si9GCtGlWHwUCNtPThFLYHlbELjItwYXvUwm1npZT8WFUJe+ghrBw1a5Gh7DxSh7JB6B
 hH0RG8g/XEnSpaMCC3kM7a4FDZajvH40WpmKKwDU5wNIEPo3VPZ9FgngHRAjo/WWxMF2
 WSix+73ieukrpWzFdJgvv3xg4dzz9EkKT63bwrDTAR+0o9bi+GDw2Nxy1r4iR/uRvauM
 m379HMAexPRjaJoK9GjzP6X7dLSemPrawfgDYWix8nYUDQeh34Yl2jVS6d/GUc8N6gkK
 dJTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJL69Va/u1EqyJWJPzd9hI/5hQZ59Ut5FA9itMCZlZXgb2aSnmxX+9iBSDa9u8M2zujdDkFBk=@lists.denx.de
X-Gm-Message-State: AOJu0YzY51x1IR0Mojt9PEi1qTxpIvLE87+dO7HLGEpmTwixipdlPdhs
 avLA9QYr55f94Xx/oA0H+Piy7q7eUZ7ZzrCsHiUqrLujDsBK909ueqTTcVF/GYi8BLI=
X-Gm-Gg: ASbGncuS0L7F1YaKPHAWLtObo3l9SiOR59gDhCRaAO5RtBxogp/UHcCrhSmTmAcjBoO
 M/TlvxL0W8fIe7jF6TAGcKLpxHfQGay2bUBEZwYx/eG/22it9Bwd6MmBzwWk6aDLM0NhWfb2DdE
 Skiz35bb8B1WRenRxXDHGG/1HLAbc0N0ReKbHx1eko9lXiAo4Q8kWABK4dpVd+Q6Kd2AiAnJNtv
 imZHk/exxr12p07Ahvs4r1HEs9iD1O/k4i2NSmDVYRM45zFdfnCKahWcShZclnWvOAZ5tJ9O0S8
 N6H7ya9rBfVibDA+2xpATLSFPMreJrTMfT6ka45i3QTDkPmi4FChUyQaxy8DnxgkZun6rPZd8NR
 3kiuBU2vLXZESVre5yMmTGUgIr8YUuRbYxjQCRhRIEYZP/NMxn5KPgJl8efWX/FMIwUtiCUp1Zu
 25sndGIxr4HNiC8O/eSzmK6EyYWEqIFE3AkjBX9ZGFu7b/r92jFj7cep6KDV/LbKNahv5CNyEwn
 Mu49aC6F8hhmvbDz54PQBI5cc/mQpcCqudqD2KsAQIiKA==
X-Google-Smtp-Source: AGHT+IGxtR0HkwuP9o4/JOY/QjqiQWeTwC0UjtGSBm2/aeU0V7tHU5ec/SYSwiSaBfWxGBpgAIjC1A==
X-Received: by 2002:a05:6000:250d:b0:3c8:c89d:6b71 with SMTP id
 ffacd0b85a97d-3cbb15cb2b8mr8670106f8f.22.1756455406070; 
 Fri, 29 Aug 2025 01:16:46 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm2449008f8f.12.2025.08.29.01.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:16:45 -0700 (PDT)
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
Subject: [PATCH 3/8] tools: mkimage: Mark copy_datafile() as static
Date: Fri, 29 Aug 2025 11:16:17 +0300
Message-ID: <20250829081628.2327372-3-ilias.apalodimas@linaro.org>
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
 tools/mkimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkimage.c b/tools/mkimage.c
index 361711c53b2b..847453970ab5 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -445,7 +445,7 @@ static void verify_image(const struct image_type_params *tparams)
 	(void)close(ifd);
 }
 
-void copy_datafile(int ifd, char *file)
+static void copy_datafile(int ifd, char *file)
 {
 	if (!file)
 		return;
-- 
2.50.1

