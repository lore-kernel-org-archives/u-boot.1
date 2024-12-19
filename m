Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6599EE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370B0803D1;
	Thu, 19 Dec 2024 19:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KoYOuGJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7A180351; Thu, 19 Dec 2024 19:29:42 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2BAE8035E
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-8442ec2adc7so36035939f.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632977; x=1735237777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKMRC+5hXVXk1eqUAuIDgrHfbsS/Aw47NS+Be8M+Tg0=;
 b=KoYOuGJXZCQJZ7Pbpyo5qgZDz9pzZTb1QbsLg5R4b3vxQ4EK1OxR4l0X6aDtczrDal
 BwVahXo7XE7WdRNxvTM84+NH8kIyOhI5+ogBDl+MVQjCBsTLJnkeAHwqGXlaYM6GqFCq
 22j9AfcagFIX/kDuNm2nba89RyXJa8NWKmFRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632977; x=1735237777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKMRC+5hXVXk1eqUAuIDgrHfbsS/Aw47NS+Be8M+Tg0=;
 b=UO61ebePwIUqyx6edp34ejFnwk9N8Xiwz5M+BNR1R+voyECJV3atEj9Cvk40JMy7nr
 J0b8LdXVhI65D/VU6ZZSkVkL5FcmQ/10zC/k5dwOCRg9V3a9WJsxv/PHorhH4GWYeM/M
 O/0GHz3D72BiWsBUhpPgSVrPSaRoaBVaK3hCmHpU/6U+3gNnzXX2JT4t+RN+HY13OCaa
 sUv5OD6T2xyx3RNlR8i+l1pt0YoMRfPPsSjDjDpasf54rrl1rx3tuC0iFHJuiROvdHTV
 83DC+Pox05+pEXxnJszSkC+8ZnSTlP8yjZLF3bywLqkW9s5C3xZLlwVfQJGYwqX2veba
 YL4A==
X-Gm-Message-State: AOJu0Yz2rk9Zk1MbqXhDdzhgm4eRqdsRsWAw2a0EuPKqYxR/645mOFTG
 KZGz9H9LQiBGhPjxvzCjF/AjGYwW0+72OFVVJ2ZcFkA1NgItWCXN+LfvByrMD9rQVlI4HdeF4iU
 =
X-Gm-Gg: ASbGncvZKjUk5qrxcS6kxkFiXJ18G3URmLo31XWast1z8yvVaK+7uFpSIwf9R6CI0SV
 oZNczQod+NPq35lwMp8QJ2HsjrEdhoe5yPmvRrtOTc13DgzDA2nEjxfL/zsR79r9v5w5JSFoVdr
 TljsVeouAqQ0XDG5I4J8MvGK7zmKfa78OjV9YlmNoQU2HIV2B0N55BAO4dh35LM6UszVwME0bUw
 kJLZWykdayjLt+Wdq+9Nhy//n/Y0QtSee0uN+f5QAzWvuqMas1T2h2tZfDFgSn2tpsnHiD26+zF
 ycg0AewkoR+59yJ9cg==
X-Google-Smtp-Source: AGHT+IFNxIw6wTwViizBGIIfmkp7S8ZVZwF0kjRhOshcxYr63Hij5BPwGW2F9X8HEpGAjhLoqILSnA==
X-Received: by 2002:a05:6e02:b24:b0:3a7:8270:3e69 with SMTP id
 e9e14a558f8ab-3c2d514ff6cmr887525ab.15.1734632977549; 
 Thu, 19 Dec 2024 10:29:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 11/19] spl: Support a relocated stack in any XPL phase
Date: Thu, 19 Dec 2024 11:28:59 -0700
Message-Id: <20241219182907.2609704-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

The current check looks only at SPL, but TPL or VPL might have a
different setting. Update the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 91ee07f7079..702920bd2f7 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -896,7 +896,7 @@ __weak void spl_relocate_stack_check(void)
  */
 ulong spl_relocate_stack_gd(void)
 {
-#ifdef CONFIG_SPL_STACK_R
+#if CONFIG_IS_ENABLED(STACK_R)
 	gd_t *new_gd;
 	ulong ptr = CONFIG_SPL_STACK_R_ADDR;
 
-- 
2.34.1

