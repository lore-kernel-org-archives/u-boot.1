Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0882C02195
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A26280243;
	Mon,  3 Feb 2025 16:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RbUEITxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C063F80079; Mon,  3 Feb 2025 16:10:42 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A1A801BE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 087FF3F85A
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738595440;
 bh=/KrVYyAVAMo29H32mQcF6Tjg59xoHh8mtcVtfjBv7a8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RbUEITxAdTsQuHispoKAyX6hPKvA7KdqDw3UF0ODPslyvq8szLa8jvVRSd5lkOGMw
 huDgNG/tuK8AI0dEyYXZuibmiJg5TBhkQeBbFd5Wa2Z2igO8KSaI5DYQBlw5CU6Lec
 OLQ/4JjkmaavrbDzUPQ8kCiq6JDxh3fz+UCfIB8PDeFJF2oUOkxTodDbNMfBxdF7yt
 FqRPt9/Hkx/1hdeeEd2rAcJ9s0uYe6r2RWD9OXRcjxSClPKyEj/YupVhyAZ7kaBCmX
 ZNAMp03I0oPAzhon43OpX/rL5iSwX2US5OUMFRybfhvANL7FZ/Os7iZMkITJeHQ4zn
 cRMy0RFb0eZZw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso32597035e9.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 07:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738595439; x=1739200239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KrVYyAVAMo29H32mQcF6Tjg59xoHh8mtcVtfjBv7a8=;
 b=oHmSJVE+9Yfw6pZbqJeKlmue9RoGJtfCjdKRKZabhITPVabxXkVeWogFPX8Q+/FHbK
 50z8PiW4CipROKFy4CuBqGHjwjetTOV1WQJdVj74I6nK2Hl1CaKssH4km2xl21weuy4+
 2fDD+zPY1H+ZZ1HEp+l/abqZo37oPgLtDJDVfTNw4PT85sRRpxhezQvzfnMw3GGtXcSI
 5IFeBegANNcpS9dxHaH0dHSh44dgf1gxGgfNy/G78UxLDgS6JJyO6ONf5X0fRSewItTu
 +35ceMBvSEQHzVax2t4QIAK1RovhhfG1WSj7Maab4wZVG0Xcb8VojO3+6YyXXrcsQ1I4
 8C0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjViVEyJynYCTVVEwXtmmwb/mHKDwd+4Z/y+sZmJIiVe4T7X7mGreDfUcmOKS0yiSu/etgVo0=@lists.denx.de
X-Gm-Message-State: AOJu0YySFuTMUU56ga+rzJzg92OYcFfNHQvC8i/1ZbpTGhuaD67ILjfb
 b64iFjrNF9WxHCfn8A7PgDtWMWRkzfeM31VFCLr/PiFttmRBsvSDtHy5Z19CCccOHOgaT2IPBWc
 h9lXk6Qu8f/qYNLKGKAT7lciQaLfFoxqphgMpuaG3RAQUzANGm26iLYGWtAT1mDbWzXQ=
X-Gm-Gg: ASbGncuBuhxmRaeSgkmeKOssAAJjW1MOYbh79tsZ7HQucngJzi0AtDYcpKktcwaep33
 lS31d3cQUI6OpG+zPzjHnhNfsgBuoCs4aSJq6jqWbz+RJI2ydtbYRnKfQpvzgTBnnbC3eN83XnA
 XVubbauQ1homRgnhf0zDbHBY7RZqQwBlqhP26+0laHKag1KJxaPi5UT8f8YY0rEa6HcMxgO99iV
 Xmr99xAgZ5RLXZCSdTQVICoXh7NzX7wR5fiDm2xWhTJm2pSl9RIl0vv9AGVQKn433yBsivubKz9
 O5KenECulXRrYSk9iHtRkrJgC+6+OraBSC14/fE=
X-Received: by 2002:a05:600c:1d06:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-438e561ceaemr145515275e9.18.1738595439592; 
 Mon, 03 Feb 2025 07:10:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpkh9g/DEFhQoowofZA/jxa5Uo3jxyFdddYOF6C/4pFgswvAnvpX3pnpuWvTdivsw0gGASpA==
X-Received: by 2002:a05:600c:1d06:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-438e561ceaemr145514935e9.18.1738595439235; 
 Mon, 03 Feb 2025 07:10:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:4aa6:8ee1:4638:a26c:daf2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102f7dsm13235419f8f.30.2025.02.03.07.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 07:10:38 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Massimiliano Minella <massimiliano.minella@se.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/4] test: clean up setexpr_test_str()
Date: Mon,  3 Feb 2025 16:10:26 +0100
Message-ID: <20250203151029.60265-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
References: <20250203151029.60265-1-heinrich.schuchardt@canonical.com>
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

Assign variable buf in the sub-test where it is used.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	new patch
---
 test/cmd/setexpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 7f318a42ead..cc2003faab5 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -309,10 +309,10 @@ static int setexpr_test_str(struct unit_test_state *uts)
 	 */
 	ut_assertok(env_set("fred", "x"));
 	start_mem = ut_check_free();
-	strcpy(buf, "hello");
 	ut_asserteq(1, run_command("setexpr.s fred 0", 0));
 	ut_assertok(ut_check_delta(start_mem));
 
+	strcpy(buf, "hello");
 	ut_assertok(env_set("fred", "12345"));
 	start_mem = ut_check_free();
 	ut_assertok(run_command("setexpr.s fred *0", 0));
-- 
2.47.1

