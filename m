Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B6DE6B277
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 13:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F3C892C6;
	Fri,  1 Nov 2024 14:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kg+qdJ2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59676892C6; Fri,  1 Nov 2024 14:03:29 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56546892EA
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 14:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so31114771fa.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730466207; x=1731071007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3icd2yFLZWb6+pGkFbHqJAz4eaoyUuqQNyBd11eupY=;
 b=kg+qdJ2tQAUzv63aA+tqbmJjhRcHl5jorhR4GutsjtWY7tO879CzxROCAsiSQh5H65
 55peAuKIUjq8OfeMLWO/18JtKh5ED1Dh2rVuJ37hYn7EDCYgA8fJjiUYsYz8NtqKOhDo
 PujYNsM5YTi5GxFY4oLCHv/WGuuPoyDCf7TwIV/cy2UsN4ogXHF5PI8rIgLMNZRo6t/u
 cNHYct8LNNGWvwt7xT+WV9xbp1o7WUIz9mvGOcPII+/UR/WCrABgLN3lesAKKggf/h/C
 V+FYFObH8tqc9307Mj1gDvqxZHjCiNkNRMxjxsARoLIFM3xCicCiCUi5YOdL7a+v988p
 jtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730466207; x=1731071007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3icd2yFLZWb6+pGkFbHqJAz4eaoyUuqQNyBd11eupY=;
 b=uGoSypRiNXUB1Riw92wbKdq+avuopI34kUHgCvjYAGefdtB1GPLVBT8wt8A406+bUj
 IdOi8FclwZi3ALbRSHmo7EzBKjfQiotoLBc9GlcNxsUHTH3iy+SAOdzrM2hTvnvoQiBa
 lt8gMt2s1cfs0r+2WukHBk3UABOkMVEztzx/V3vUDrscX7X/LsFGiulR9FcmiKEC1Mhs
 GH0ANTr7/Sy6MSDmfH0pj2Ki7bcs2B/mEpwlnU+e0uTt06m3BnTtp/3laakTuhNaYDRS
 DHK48uFO+J1x0OBYSCYlZ+pETZ/F5KPT7xZxkEa4qal4y4gHEV0E68zFE0c8TzpM4Qx1
 kIJA==
X-Gm-Message-State: AOJu0YzDmq+5VVDBMc6ew0eYwJCQh78SCR54q6BzAKDTkt9KP6LXNFGx
 v8gceJmlFF0ciAycNbbY4fUF0V0w8d8rplUF8i0Knx0HUWClXcNcFUNMRCCq09kAcA5reRJezDm
 kurI=
X-Google-Smtp-Source: AGHT+IH4m2+Yvyk1UuhhKD7Vn11aaRjvPqzMjPXiV38TeSDs2n4IMqbJzBQjoKGxA86nenXlN/qedA==
X-Received: by 2002:a2e:bd09:0:b0:2fa:d604:e522 with SMTP id
 38308e7fff4ca-2fedb669b19mr31690021fa.0.1730466206390; 
 Fri, 01 Nov 2024 06:03:26 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:7dcf:21b3:7ed8:3010])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d685287sm62986385e9.35.2024.11.01.06.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 06:03:25 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] test: bootm: bootm_process_cmdline_env takes flags
Date: Fri,  1 Nov 2024 13:02:53 +0000
Message-Id: <20241101130254.473017-2-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101130254.473017-1-andrew.goodbody@linaro.org>
References: <20241101130254.473017-1-andrew.goodbody@linaro.org>
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

The function bootm_process_cmdline_env takes flags as its third
parameter, not a bool. Correct the usage by replacing 'true'
with BOOTM_CL_ALL so that the intent is clear.
A similar change was made throughtout this file in the previous
commit to the one mentioned below as being fixed.

Fixes: 4448fe8e4e7c ("bootm: Allow updating the bootargs in a buffer")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 test/bootm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/bootm.c b/test/bootm.c
index 26c15552bf..5f57ecb337 100644
--- a/test/bootm.c
+++ b/test/bootm.c
@@ -27,11 +27,11 @@ static int bootm_test_nop(struct unit_test_state *uts)
 	char buf[BUF_SIZE];
 
 	*buf = '\0';
-	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, true));
+	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
 	ut_asserteq_str("", buf);
 
 	strcpy(buf, "test");
-	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, true));
+	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
 	ut_asserteq_str("test", buf);
 
 	return 0;
@@ -45,21 +45,21 @@ static int bootm_test_nospace(struct unit_test_state *uts)
 
 	/* Zero buffer size */
 	*buf = '\0';
-	ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, 0, true));
+	ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, 0, BOOTM_CL_ALL));
 
 	/* Buffer string not terminated */
 	memset(buf, 'a', BUF_SIZE);
-	ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, BUF_SIZE, true));
+	ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
 
 	/* Not enough space to copy string */
 	memset(buf, '\0', BUF_SIZE);
 	memset(buf, 'a', BUF_SIZE / 2);
-	ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, BUF_SIZE, true));
+	ut_asserteq(-ENOSPC, bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
 
 	/* Just enough space */
 	memset(buf, '\0', BUF_SIZE);
 	memset(buf, 'a', BUF_SIZE / 2 - 1);
-	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, true));
+	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
 
 	return 0;
 }
-- 
2.39.5

