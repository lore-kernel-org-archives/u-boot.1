Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC86CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F6784886;
	Thu, 21 May 2026 21:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OoR9Eg5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3DB84852; Thu, 21 May 2026 21:14:19 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E395184825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a858881ad2so8561861e87.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779390857; x=1779995657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDrcWpmdhw8kgrYMekrGmSV9bzH8EOzn802wQH2ryPg=;
 b=OoR9Eg5mbWtasq9vyMxOewZMc+yUI2l4o0Yz3gqFEufuUbJ19OV9tdgNpDn6zguOCP
 Vk05YakzJWj8+APctjzUzVvr+Ykbnpiuawq99F2Bta5yrCwSdOgeyODGcNSg7QVPjF+z
 ws2qf346aTNAZv1IGcrO4dX/i/yd1/qdWzSQRQ4ipxppoQj6Xhkyn6pewACaU9jcWMDo
 AXGqecxb5fEcBhtT5JRCbRQxDl1DnMw8wonYcM7zAeymtWz1sDnxR2bk+sWOZRyTtIXg
 L+egm3Ut3W5ZZQ5Go1XheWQUv8TahA7OFnvD+/gthjc45xwVA/7G5ESXPpdwZF/LOHrp
 YQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779390857; x=1779995657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eDrcWpmdhw8kgrYMekrGmSV9bzH8EOzn802wQH2ryPg=;
 b=ix0GashWG91LJ3mkBIPtPmfzQ5XZmxDMKiV93t8iDfZzLR3reJpGhEss4qFpmLG9tK
 0Amvn+2pdlsn6F/OkT71zcIZ/Hd5DekjF3pCbbJKw9DrmRcIw2GZP/kHqm8LyDA4DH6t
 jie0dgv74mniKxVisTwvHjJVzp4lTg0LHr0Elc7VILWSL2aHeO5p2lmSs/BAIFg/JhIb
 WoyeccnxATqCU2MO3tuoVaVBXbHQCzJzqvJ8XQvPBp8gL7C+knO1/SNbPVdcGKr/VSUQ
 c7JYjlIIIamQj7Leg2Ej8N/PFuYRRDR2YPbY+iqRDBR/GT144inyilRT33qAx22NtjtX
 XPfA==
X-Gm-Message-State: AOJu0YxyfNdIx7fCAgruLQUSx8aRVjdWiLCdVfTy1tGUHr9KjuypOG1a
 ieXmS9XZF3xLStvNRomi9EpTjgDkrE0Zvr5blUvRlQB/f8JOhrJeG/QFHWqABpzGQBTUlA==
X-Gm-Gg: Acq92OG6dUXClFpmlNVtZD7cfkipQsXS0tYPyI5KICZdFCYgGxoiJmaLznptRG3oCng
 LhbJ2q9+57yjf6a0TzBv4BbZnZzEePs/6n7Krma+rQRzVnDQ/+YtYMPtiOjb63REEsK7aDfa/Tn
 7HRESU1MpK6URUZRd7211OwkdIvSSqS1WB3htaYMnTm/7zNcGwCLDzjsofX/BMy28EKxfFDLXIy
 JQ/BPNN5KRF0Twj36zZS3MUNcyMoV5egHCUZn3hCri0VOVs3iw0//hfCbsO+Kg8I19RdH30DSky
 LGozoPWSoJhe3gL+oXmJkSXFiq2FHpTbKpnHaoCHSusAkc78jB2ZUmZpNchaF0cI71SXOAzBzme
 WFL9mubtRNd+NEIvbsf0hGsLSdtzmK03HEUtE6u8lcn6vEdmYKrbole5cwcYZ9HMUT8/kfKUJ98
 rGEwHPR/NLRntEACrb8N5gaoBImG1EiomMUsJZtRF6IlXchN/s3tJfRHGOzcj2eIEi1+GmoxCjX
 8funo9h6YrELJ5trCQCZr7on6WqFWTvcM4=
X-Received: by 2002:a05:6512:2204:b0:5aa:b6a:9257 with SMTP id
 2adb3069b0e04-5aa32393ff6mr19069e87.44.1779390856982; 
 Thu, 21 May 2026 12:14:16 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-125-213.nat.spd-mgts.ru.
 [109.252.125.213]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d9442ee3sm38701fa.6.2026.05.21.12.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 12:14:15 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] x86: zimage: fix NULL pointer dereference in
 build_command_line
Date: Thu, 21 May 2026 22:14:01 +0300
Message-Id: <20260521191401.29310-4-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
References: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 21:28:08 +0200
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

Static analysis reported a redundant NULL check at line 68, but the
real issue is that env_command_line (from env_get("bootargs")) can
be NULL and is dereferenced unconditionally by strstr() at line 56.

If the "bootargs" environment variable is not set, env_get() returns
NULL, causing strstr(NULL, ...) to dereference a null pointer and crash.

Fix: add NULL check before strstr() call:
  if (env_command_line && !strstr(env_command_line, "console="))

The existing check at line 68 remains necessary to guard the strcat()
call and is no longer redundant.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 arch/x86/lib/zimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index a5f2231aa52..dbec5887b77 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -64,7 +64,7 @@ static void build_command_line(char *command_line, int auto_boot)
 	env_command_line =  env_get("bootargs");
 
 	/* set console= argument if we use a serial console */
-	if (!strstr(env_command_line, "console=")) {
+	if (env_command_line && !strstr(env_command_line, "console=")) {
 		if (!strcmp(env_get("stdout"), "serial")) {
 
 			/* We seem to use serial console */
-- 
2.39.2

