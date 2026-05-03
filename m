Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B33CD3424
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 20:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D7884605;
	Sun,  3 May 2026 22:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Myypq/sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7390845E9; Sun,  3 May 2026 22:50:12 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B9CD8460B
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 22:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69489b43d66so981365eaf.2
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777841409; x=1778446209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWZ7Xz4jAxM8W8VuBQJGUdGj5BDEOSDKr+YBWjcwJ2Y=;
 b=Myypq/sm8R8XuFIOEDrqQT5iU+gte2pplJRR1i/xmb3yLigJoBhVbFWUzofLPwsxDx
 OmxxVmYaGEpUVyC3MUzQjTR/GibjVCtsM1VcH6C+1KyPHZ6MYnQnw09D+YOLzfAHBhaW
 zY6RDCh9otIi2Sx9xeDZQ5CxnWxpw1Bu7LuUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777841409; x=1778446209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cWZ7Xz4jAxM8W8VuBQJGUdGj5BDEOSDKr+YBWjcwJ2Y=;
 b=rZycuaaxAvCWcHr77eDnAhFgT8aEfLyDT5CIxorW6zf5LyajiWsp5j1GyUq410Xk8F
 pCPbhr38ELJ0onCcTFb3+oxoFuBgkX7xuFDkSAUzhjpqWWwcw7z/aaMuM+9F4r3/Yzat
 F4ytsrZIYq9Rx5KOWqZZ5iNdfeX3bsZ+qI9xe19U9eZeC77KQ+DUlF0w14sEv0G6dt/n
 vsd+d7Rm7puzz+JIv0AlMBePjPc8TDRL17lpciAc1SYvDP2g8um9KeH65M24zG8SOjTP
 lo59+tAboGqVyc0O7T9GWfnXmqnPLzdDWlG/Jrt9YNYuYEYaroElfLnrlSkDJUODHelK
 3uDg==
X-Gm-Message-State: AOJu0YzsxQhchdQADRceJSOoMOBcTzr9wctVgzyo8Yd2bgFur5PCmYYV
 UXyqZLSjfMZVs8ULFjesZ0Xb1Ge4aqrfhiR25D0IM5GYGKHyGssWjrXwdI0aVe42Au4mnMjKs9H
 itacvbw==
X-Gm-Gg: AeBDievwe8t1fBvUt4F6yr2Gylw72aNPHnCd9LOUWXTMVoYAJf1KQDyAi5kSrpFfKO8
 sy6nzEwahva5TD8PcYY9eZd90w+23dcpcOxIBBxduKsBDFF0Gr2DBbWqBCc5w2Y9dqVDrEIrOxf
 5+8BgT41X1F3uGmn39GIVJATnVABLeGmmfM5nq44EiYgkXCvH9T46QiKFhewJmW8SAL//UYPIeF
 CHYDWKgN3HTjzt2mryNF99q52y0u4mVx0t6fFWjj713In1Xph39Ny4zdqBkycXYp1sJfnt3/PAT
 cy4yqa+BQwvmA5PsLwK3uXP0JBqDgVEAvhRAHN+geBDdPe4CbDUOmADlNR7aT9+Y86E0vKMF5KC
 ZxoXmIuRWkQFvjr8V55ZzF5u0gQeJi8IBmL3dbAPbjpzathSh2HZvol0rko4PgqXdoknmPrp0BH
 rCVdrY2hj3m/qkCIHfpE7JWtehNg0H
X-Received: by 2002:a05:6820:1b05:b0:696:89d2:fc92 with SMTP id
 006d021491bc7-69697dfa8eamr3527888eaf.59.1777841408731; 
 Sun, 03 May 2026 13:50:08 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696aacbb5bbsm1142940eaf.15.2026.05.03.13.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 13:50:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] ti: Quote board_init in ti_common.env
Date: Sun,  3 May 2026 14:49:20 -0600
Message-ID: <20260503204936.3151124-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503204936.3151124-1-sjg@chromium.org>
References: <20260503204936.3151124-1-sjg@chromium.org>
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

bootcmd_ti_mmc skips a per-board init hook with:

    if test -n ${board_init}; then run board_init; fi;

The default case is "no board override", i.e. board_init unset. The
expression then expands to 'test -n' with no operand and relies on a
U-Boot 'test' quirk that treats a missing operand as false to skip the
run.

Quote the variable so an unset board_init expands to 'test -n ""' and
the emptiness check is explicit.

Fixes: 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/env/ti/ti_common.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index 62b93eb25c4..e6ceaa17adc 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -24,7 +24,7 @@ get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
 bootcmd_ti_mmc=
 	run init_${boot};
-	if test -n ${board_init}; then
+	if test -n "${board_init}"; then
 		echo Running board_init ...;
 		run board_init;
 	fi;
-- 
2.43.0

