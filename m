Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5857109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 237AE840A9;
	Wed, 25 Mar 2026 20:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dvQfKTn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2ED8407E; Wed, 25 Mar 2026 20:00:38 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2860483F60
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4be94eeacso108022a34.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465235; x=1775070035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ORD6FhlvitWHmrUlMPLBQs5wUuJdPuHX3706vNrrAR0=;
 b=dvQfKTn3OVo8ZU/9O/oSx4pMCzRLnMwjOxTmcoW4OLJhrDyWk6l9Wm96SHACIp3wGk
 wFCZEtMNmMVmW25kYGOJf8GqVropGHU8+RmINCS53+v3QUJesVa+FVWgJRvjxhWJTnFm
 rMI/eVJQf1KOhTWH0AN0RHqnuSxi1YSgTewNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465235; x=1775070035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORD6FhlvitWHmrUlMPLBQs5wUuJdPuHX3706vNrrAR0=;
 b=gUDiTgEGojrgZtXabqEFUp3kXmPAkJqPF0adXdvwo5rvMESuwFbRGO5loh3jcEz9CX
 sw6+8Te6UrTEpZlqkQ+N7yRLubD8PDO7jmXVpzEkt1yyOf2NItdIJs9pjIypCdW/aspN
 Ha7k0/GXucLPC1FFv3c2Pj46dN7obP+jEQvI2av/svgTO445TEKi6ZVfAtCdeiN5KWwW
 FABSoafDdC+G0J8bIYlOOCS+dHEE85Hxij6WUodFtNEHipOx/FhvZOZ9uQoOs4B4+Xy3
 DhKwZqoEmxeWXwvdJ/inLT2TkjgfB1iZI0Rj1HEJoAZb/m8vcpSD8ZB+NlAyftq8ILpe
 Jd7g==
X-Gm-Message-State: AOJu0YyTfmiti9klszRcMdLB+NeE256l0ieGgd6A32LeQWjTWcTcXu5F
 CjgO7vI7C0P/sCxvFD3ETgTZLo4VKSBvs4Ufr3pPnL5Y96G0BqkqvDpWOJ1vmQ9cYM/RJ9XsmcH
 8OpLXnTU=
X-Gm-Gg: ATEYQzyADLpHjI7Prvf0Jaj16lOep19lUQaE5ZUrzbvdIBaWUEJVu5kb7ZXIVNJss+R
 sdTo9jw53wUgfi2gjBYeQeobDMiJ1VarhU5HCRQ4qEZ/cKEVxg3j8MpRMOi+m1UP0uEaO5gJOEZ
 PBDBwg1HogdxeoVkuXZFbp9u7qI9lYM8D+LEHnz/Xf9U6TUq6wUxyx+fLxzx6xs9WCTHd8Uq9Fc
 HaEesRtMyR4+ljtUjuDZrjzwtcZZOhbg1WuGYo0qubSaPk9wLNmz/GDAtWFSDbosQHVaCCjL3/B
 +SXCRrnJCSXmQeIgdz6rda9HAFqxzo9+SJQOfTdoMGHwAGlsuuyXCsWNpn/skZ7QdEyKGbcWJPL
 mR/tPGTwk88OcodIPX+Ozmij69Gi6SBhOopxCBzlKVU+vU6CVY8SMyP5D8r4i5vKGJsYc1Vzul3
 Qf4WiQTOtSCGxFnaDd9lPGKTUYKJSlcw0RuK4fhmwlw9UaqsoRyFvEdQCoq+67d1DqByIyCs63g
 +/2Er3nMyMnhNLhedIFm7F/nB6Tiq6Zo1HyHFzHJ4QHJ2CkeXg=
X-Received: by 2002:a05:6830:6a13:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7d9d677eb0amr2701149a34.17.1774465234729; 
 Wed, 25 Mar 2026 12:00:34 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e7233209sm364298a34.19.2026.03.25.12.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] hikey960: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:33 -0600
Message-ID: <20260325190033.3428670-1-trini@konsulko.com>
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 board/hisilicon/hikey960/hikey960.c | 5 -----
 configs/hikey960_defconfig          | 1 -
 2 files changed, 6 deletions(-)

diff --git a/board/hisilicon/hikey960/hikey960.c b/board/hisilicon/hikey960/hikey960.c
index 5029f4edb2af..fb56762fff68 100644
--- a/board/hisilicon/hikey960/hikey960.c
+++ b/board/hisilicon/hikey960/hikey960.c
@@ -60,11 +60,6 @@ static struct mm_region hikey_mem_map[] = {
 
 struct mm_region *mem_map = hikey_mem_map;
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int misc_init_r(void)
 {
 	return 0;
diff --git a/configs/hikey960_defconfig b/configs/hikey960_defconfig
index 440f257072d6..1cf1ef12bb51 100644
--- a/configs/hikey960_defconfig
+++ b/configs/hikey960_defconfig
@@ -19,7 +19,6 @@ CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=283
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="U-Boot => "
 CONFIG_CMD_MD5SUM=y
-- 
2.43.0

