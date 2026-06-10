Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E9CCD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5D2849A4;
	Thu, 11 Jun 2026 04:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a2tFQtSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C3B848DC; Wed, 10 Jun 2026 15:54:52 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1FB48489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vk092kumar@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2bf114b0cf9so62515765ad.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781099689; x=1781704489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OwoVON3weBJVfx8tn/xoI3wb3wDAH1YqphiLJh2NAo=;
 b=a2tFQtSqFJy5Na8BGZoIZ2nHe6X91vAjTCUH5+At++ahZlc75YiJ06DQa6E34MKUoY
 rWf/4Qvl7nnPOdypXnLQLullguCf/tpnngaxALR6y6d4xnSN2GhdPTOVlTHlCnTTHQBb
 1yvjfy1vARtX0l7iYPthAZiqH2VxC1Bte4/07dST+9fcr6XXrSQ17q2LshxFBxzMTm3f
 k1ce6mA+ajkCio3EWjWepLb28paEzNLSv0XbnDbDL4u/QqGIwFzA5GDxVnNnqd0+Nlxz
 kkbtThceZZr1EHBlsYI/iQSOuoskQj5ncbVZZcd24oZIEBD6mMyLUACc55w6lMnE6PA1
 dKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781099689; x=1781704489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2OwoVON3weBJVfx8tn/xoI3wb3wDAH1YqphiLJh2NAo=;
 b=AQpUdQG4zP8R8qtsa7Qa2oujtWN/xauIHVK12gOR/4oJK2J63VN5xywgGtU4NTfqg7
 vS76FHWuq+DgLY11SaV4yhSUhAXFPUzbkLtWYhUlf6lHijB7bSP9jw1qOLXkScDVflD7
 mRlIE6dFKsi8vqezTz9f0f4DTt5UMY9AqHkZhd4EMLfVlrtICi/SvyBikwtcqi9RbuMh
 kE9UqWI74s+Uwmlzao8KbAnwQKx0EtnFEvW1oz799mvWMTJ4zIV0AAmms6w0zRR7N88c
 qKW9U8yYUeSzXXwZALncr9MzubyD5wIEPgtd9BB9hLUdxTq0S0InFxY+SCVLn5HOI0ta
 EX2g==
X-Gm-Message-State: AOJu0YwcNriWBqep4K76xAabX0Iib7CHkdRzxfg56e3l5Z50ynWKnlTJ
 JPh3GmIj77kYirRAm4Lma5qCZf2vr+7KAb7ecDVpawhJ3AJ/jIbDJvY8kkvj549V
X-Gm-Gg: Acq92OF2T30KTXVB5/8EQjx0Em05frxoPeMG9shm0pHNlQ5vePfAzbP92AeZlS2gwm1
 8Sp2ykzXwE6tGUB2YARrWHQpG5neKWQieBLCYOy3Ll7KDv9f8BtpP8VyLSg/hj+9rZX/bkcbEeM
 7WHCF9BK9nH2Ac4h3cI9HSdG2pHEFeYmLD6ergqxh0umNtZQaIg6vPfSBe4oT2BldsBUwoJzFRN
 BXUgRSERjrLm2AYh/gI/ekYLJTElNY6QTgZsR1yNCw+gqBcdq6czywZJikYt+TQ8sJWHOMNdvdv
 2wZIuszWDC7psO9x37ZFZRD13m2DcrTP4vXkD+RwrJnm8LK8hj8n9go2PHPqXq8fCLWzzsOEgWG
 ZbcQi9eoKscNIbodgEa+CDleuYJwQqEKKbzg4JRQ5odFZ4sjW0PqS4bFBVJHpqcUji1wfKG7x00
 EybOK7xghr8UOpGWoUTieoE1yClXYNMB305XQvxnz9TjTOQXaKn+MN8UTxJRJRLzb0z57+kXOYc
 bMC6oPMvggDewNS48PwWw2uu1tdWUOLRtvq
X-Received: by 2002:a17:903:1205:b0:2c0:e5ee:f55e with SMTP id
 d9443c01a7336-2c1e80f9b57mr295811585ad.7.1781099689000; 
 Wed, 10 Jun 2026 06:54:49 -0700 (PDT)
Received: from vk092-VivoBook-ASUSLaptop-X421EAYB-K413EA..
 ([2402:a00:163:2ce9:3030:82e1:fd09:4ad])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f9f358sm244845165ad.30.2026.06.10.06.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:54:48 -0700 (PDT)
From: Vivek Ray <vk092kumar@gmail.com>
To: u-boot@lists.denx.de
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 u-boot-qcom@groups.io, Vivek Ray <vk092kumar@gmail.com>
Subject: [PATCH v2] arm: mach-snapdragon: increase compat buffer size and warn
 on root compatible string truncation
Date: Wed, 10 Jun 2026 19:24:40 +0530
Message-Id: <20260610135440.1589268-1-vk092kumar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610093726.1231041-1-vk092kumar@gmail.com>
References: <20260610093726.1231041-1-vk092kumar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

The configure_env() function copies root compatible strings into a
32-byte buffer prior to parsing. If a compatible string exceeds this
limit, strlcpy() silently truncates it, producing a malformed fdtfile
path and a silent boot failure with no indication of the root cause.

Bump buf[] to 128 bytes and dt_path[] to 256 bytes to accommodate longer
compatible strings. Also, add explicit truncation checks after both
strlcpy() calls and emit a log_warning() with the offending compatible
string to make such failures easier to diagnose.

Signed-off-by: Vivek Ray <vk092kumar@gmail.com>

---

Changes in V2:
- Bump buf[] from 32 to 128 bytes and dt_path[] from 64 to 256 (Casey Connolly)
- Fix line size check, use > not >= (Casey Connolly)

---
 arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 829a0109ac7..d9390d9b5d3 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -390,13 +390,14 @@ static void configure_env(void)
 {
 	const char *first_compat, *last_compat;
 	char *tmp;
-	char buf[32] = { 0 };
+	char buf[128] = { 0 };
+	int len = 0;
 	/*
 	 * Most DTB filenames follow the scheme: qcom/<soc>-[vendor]-<board>.dtb
 	 * The vendor is skipped when it's a Qualcomm reference board, or the
 	 * db845c.
 	 */
-	char dt_path[64] = { 0 };
+	char dt_path[256] = { 0 };
 	int compat_count, ret;
 	ofnode root;
 
@@ -417,7 +418,11 @@ static void configure_env(void)
 		return;
 	}
 
-	strlcpy(buf, first_compat, sizeof(buf) - 1);
+	/* A safety check to avoid silent failure due to name truncation */
+	len = strlcpy(buf, first_compat, sizeof(buf) - 1);
+	if (len > sizeof(buf) - 1)
+		log_warning("compatible '%s' got truncated, fdtfile name too long\n",
+			    first_compat);
 	tmp = buf;
 
 	/* The Qualcomm reference boards (RBx, HDK, etc)  */
@@ -468,7 +473,12 @@ static void configure_env(void)
 
 		/* Copy the last compat (e.g. "qcom,sdm845") into buf */
 		memset(buf, 0, sizeof(buf));
-		strlcpy(buf, last_compat, sizeof(buf) - 1);
+
+		/* check for name truncation */
+		len = strlcpy(buf, last_compat, sizeof(buf) - 1);
+		if (len > sizeof(buf) - 1)
+			log_warning("compatible '%s' got truncated, fdtfile name too long\n",
+				    last_compat);
 		tmp = buf;
 
 		/* strsep() is destructive, it replaces the comma with a \0 */
-- 
2.34.1

