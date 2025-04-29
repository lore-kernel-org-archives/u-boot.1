Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19E3C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B47F8210D;
	Tue, 29 Apr 2025 14:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gsLwbCg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4337C82132; Tue, 29 Apr 2025 14:02:53 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 247EB80BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 14:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so52780295e9.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745928170; x=1746532970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uVSYirWYl0h864O6R531dLP82l+Z+VwxuG/T2JUSIfc=;
 b=gsLwbCg1eZfkgAmO0FXX5tEdbUbGk+XBrnyksuQhhBsLlyusf4ZIA4W0t1regtzWhS
 K2iarGWyC6N0+UNFaq4upU04UCbuL29S28C42+l9tBvf9oXTivE7E/VY/8Mb7fm1b0XN
 /l/Hv9sau+i0F3guYl92pvKD+kMz8q7Bn8ZmB0WnFhtDE38XWctdlxed1bUtf3LEbNkO
 BY+8FrPUXE/0qXnpmBxcIDjfPNz1LSDmkk93jMLJt4vhDctW3j2y9Mu4vdbnJ+PmLXT3
 YU69tgQDPxgt+DHUFTL061rWrydhY2dJerMzQsL+bcvhEa9S8Xa3fN3I5PPXvRxJDJA+
 f+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745928170; x=1746532970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uVSYirWYl0h864O6R531dLP82l+Z+VwxuG/T2JUSIfc=;
 b=oF383n4H471GzQLNvdJPDFrHwt2LOVDq7VxVFFgFj76sN7eNx9DBD+esylWkMDRBSj
 SApn25QxRYPGzY18qPvJRy1mNc9ZmpKr3LKJDRPzYI+FJblJlitaaHfBkwQL6dPpF09I
 xOTDxHgh9L1cmQ5mqVQzMxJePvo5svx+hDx/zHqwjdlPUKKmKjetECkIDaHA13gEWZ6/
 clTW/As9JPIaqZmdUfq0yuKPVHsF2PCfpElUIJK0SXGENUsIFeWyinFOILSpSFOUwU9E
 S4Pp38JM/iRer/57wESWBQ3rJSTFR/XKSpZ6MAZXPv8F68fuDbW1HWtP/pnAovsuHljb
 QR+w==
X-Gm-Message-State: AOJu0Yw9xlZTkyldVkTzh/C5jyEamLT3esFSubl1BcBFWYFZe8yzA+hu
 LUfxFMLKdEin67jf/7ad4N2fLELPWihlPYtH0+Wtzkv6hmjrTcGHe10ZGctRoF0pwx9Xi8pHzBk
 Udbs=
X-Gm-Gg: ASbGncuZax5DhfQ5UH/RgfxUjlpYa02waL75sImQygJnlFW5Hh3AudGPSbCDQMvKkSU
 OdNE5OEK0PQGdjGk0tjRYevhYm4/VI7RvwURrUmtq3Ya+WFjuPg+HvgeZ35f422C/ElKB4AkNA1
 j2RacZyV6ipA4zLxmXos/RH71D95TpMthu1TmMtynn/mjMnvXwyCm11l25fHo3KnHFIxiNHBT+t
 dEDQ/FpWS+4rx8TJ4Z/4rMpOpiEMJXr5sbS8+NdFGw4tERP0EHaA2kKn5T0/jiQ+o2Sgtyq4GvX
 Cs0nvok8pHPMdXPCyBz+lyxGPkMpsCvDC09eXbB7pv+m3uKXyw==
X-Google-Smtp-Source: AGHT+IHbpDfB8nkoOZbbEg2Na8ZRWp/OPs3NBhX0eW8b/5cF7nm+PUOEv6Ybi/+UJY6CYjlnA5xeqw==
X-Received: by 2002:a5d:5f4f:0:b0:39f:e3b:406b with SMTP id
 ffacd0b85a97d-3a08a348410mr2232563f8f.5.1745928170103; 
 Tue, 29 Apr 2025 05:02:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29ba29sm188497915e9.7.2025.04.29.05.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:02:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] cmd: spawn: reject 0 as an invalid job ID
Date: Tue, 29 Apr 2025 14:02:18 +0200
Message-ID: <20250429120232.3874362-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Job IDs are positive integers greater than 1. 0 is not a valid job ID,
therefore fix the comparison in do_wait().

Fixes Coverity defects:

*** CID 550296:  Control flow issues  (NO_EFFECT)
/cmd/spawn.c: 172 in do_wait()
166                     for (i = 0; i < CONFIG_CMD_SPAWN_NUM_JOBS; i++)
167                             if (job[i])
168                                     ret = wait_job(i);
169             } else {
170                     for (i = 1; i < argc; i++) {
171                             id = dectoul(argv[i], NULL);
>>>     CID 550296:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true.
"id < 0UL".
172                             if (id < 0 || id >
CONFIG_CMD_SPAWN_NUM_JOBS)
173                                     return CMD_RET_USAGE;
174                             idx = (int)id - 1;
175                             ret = wait_job(idx);
176                     }
177             }

*** CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
/cmd/spawn.c: 174 in do_wait()
168                                     ret = wait_job(i);
169             } else {
170                     for (i = 1; i < argc; i++) {
171                             id = dectoul(argv[i], NULL);
172                             if (id < 0 || id >
CONFIG_CMD_SPAWN_NUM_JOBS)
173                                     return CMD_RET_USAGE;
>>>     CID 550297:  Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "idx", where "(int)id - 1" is known to be equal to -1,
overflows the type of "idx", which is type "unsigned int".
174                             idx = (int)id - 1;
175                             ret = wait_job(idx);
176                     }
177             }

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
CC: Tom Rini <trini@konsulko.com>
---

 cmd/spawn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/spawn.c b/cmd/spawn.c
index eddbcb792b3..37737b8627c 100644
--- a/cmd/spawn.c
+++ b/cmd/spawn.c
@@ -169,7 +169,7 @@ static int do_wait(struct cmd_tbl *cmdtp, int flag, int argc,
 	} else {
 		for (i = 1; i < argc; i++) {
 			id = dectoul(argv[i], NULL);
-			if (id < 0 || id > CONFIG_CMD_SPAWN_NUM_JOBS)
+			if (id < 1 || id > CONFIG_CMD_SPAWN_NUM_JOBS)
 				return CMD_RET_USAGE;
 			idx = (int)id - 1;
 			ret = wait_job(idx);
-- 
2.43.0

base-commit: b249e08ec9b71f9d0b4eb48e3e63f63e8366b7e6
branch: spawn-wait-fix
