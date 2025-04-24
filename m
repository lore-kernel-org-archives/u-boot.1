Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74CCC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D374B8004F;
	Thu, 24 Apr 2025 18:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jK82atH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 842EE8082A; Thu, 24 Apr 2025 17:08:32 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1FB8004F
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 17:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=carlos.lopezr4096@gmail.com
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso720751f8f.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745507310; x=1746112110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kLBYjojCue5eVhrYD2YHby7WskR4kLaFvj/dn/k8mdA=;
 b=jK82atH/Gp8EbBI/c88Mf+D+5lPQXYU7R7N/YGc7V7UaQqDd1kU5/dND3aWW019WA9
 HIB6V0Q/Y+QNfjhnGDKYPFdbxWI8Xp+kyL+7y78aDCkEtT6bq6K3L3cAPvxUO11UVtR0
 pAXk2GGEu4UC53jMasf6yX1r6md4IhTa9/cH6pzdB2eF8jNGBlCxuAgMAhJgcdvdvsSV
 h3s22i84b/Y5/3pC5N5nq33P6U6RfB86f0sUMnsHI5f7toHhv7JIW0I3yoOtL0UvnOS5
 WNfYldVVbyxaBX2UH0Q+e3Uyx3BO8C5Kk5MIpIgDy4AIdbQEbLDFtzl8pNwWP8ut48rT
 x/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745507310; x=1746112110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLBYjojCue5eVhrYD2YHby7WskR4kLaFvj/dn/k8mdA=;
 b=jH7sNm2WBdfDYk9PaZ6RCBmeW9JUYE5NPezRC0qaLWXGurJbZKMPP+FmWVNJXzDFvD
 t/LEgBFGifDYsJAsKfbTuoObdp+lm1/M4+MNYOckvOyqCd6A033D8kB0sRMOHySZymBb
 2lVO/cajoYBArun9iYVcnTvpebaBA6bgFJSQRO553+vcjSlD4mpOZHa8L+glyVDcDgtp
 JuTeT23+O3rXIkeZubzxfhrJ9+OW8TUVmZT/XzmPGp1ol0DceZwC5kXGUKHe8cmCrIBX
 x6JvKqkzFJCE8f7bCk/JH0uJ4NHR4nquew+ED1K/u0wRuiob9WmZ58XTKYrGuiL1VpOr
 36pQ==
X-Gm-Message-State: AOJu0Yw+xqbw06cL0JSdJZO5jK8YHMNXvAC9UU9Zav0Qn7rBPrv5Ttgj
 nBe3nGhMYvvCIKAny17Pm0049+qLoWRe7c85BnlOX45eqGUw9CgMmxSgNltc
X-Gm-Gg: ASbGncuD0kkZ6/w4+zdKzau5UqwgqARm46fm+hAOJT7HvhgqCM5kYoDtjYOU/6DJJQk
 LZ0RXALPlVrZC4SKl1ur8TMLDqYu+c/htz9rWZCorBFlmMMkMPdg/4M8j5MhpB8O71IutLOy9hW
 n/qcoOOKHJrBDfDLe46fH2c/X6XBd3zxqGJFASO/15+Mz0jj9DtRcSh9qJE09TU10F6HhTig7L0
 SNFtdRiD5rIZknqiXH0fYUbUHY5KUHi9i+aUxka2hfhH3CmZ8zwcsT3CqFwAlh5QMExC7OpcBOs
 GtET1yS01jH6ayK61VMcpkXjfcvLLDwG/5pI0jIYe3jf+N9MX1QO4Lxr6fjdNUj6o3T737KACNZ
 GPP1K2nNbSBbIQe1SrCyIqBCoCyahAq83iV7hcoHJxFH1WPWKPOuyJZLJ+ewe
X-Google-Smtp-Source: AGHT+IFuqS2+bGl2/rJWEA+dvP/7c4/ZJRLZmrK5yFBWXkcSdNEkg+iwOhkF4XGUeICrr8SobLF/aw==
X-Received: by 2002:a5d:584a:0:b0:39c:dfa:c3de with SMTP id
 ffacd0b85a97d-3a06cfaf232mr2549533f8f.47.1745507309600; 
 Thu, 24 Apr 2025 08:08:29 -0700 (PDT)
Received: from localhost.localdomain
 (static-250-135-226-77.ipcom.comunitel.net. [77.226.135.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d569c1bsm2352849f8f.101.2025.04.24.08.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 08:08:29 -0700 (PDT)
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>
Subject: [PATCH] mkimage: fix option parsing segfault
Date: Thu, 24 Apr 2025 17:08:19 +0200
Message-Id: <20250424150820.98516-1-carlos.lopezr4096@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Apr 2025 18:37:00 +0200
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

getopt_long() expects a NULL-terminated list of structures. The current
list in mkimage does not have a zero-filled structure at the end, which
can cause getopt_long() to walk past the end of the array when passing
an unknown option, causing a segmentation fault.

As a reproducer, the following command causes a segmentation fault
(tested in Debian 12):

    mkimage --foobar

Signed-off-by: Carlos López <carlos.lopezr4096@gmail.com>
---
 tools/mkimage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/mkimage.c b/tools/mkimage.c
index ac62ebbde9b..2954626a283 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -196,6 +196,7 @@ static const struct option longopts[] = {
 	{ "verbose", no_argument, NULL, 'v' },
 	{ "version", no_argument, NULL, 'V' },
 	{ "xip", no_argument, NULL, 'x' },
+	{ /* sentinel */ },
 };
 
 static void process_args(int argc, char **argv)
-- 
2.39.5

