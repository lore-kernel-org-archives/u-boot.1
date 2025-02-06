Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D6FC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C17180EC0;
	Thu,  6 Feb 2025 22:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xg7Vzp7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95CE80ECC; Thu,  6 Feb 2025 22:55:30 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A1880E94
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5439e331cceso1734142e87.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738878928; x=1739483728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OJFHiaJsf3l+V8hBplYsVIbx6Bmq3Nc8WNF5eBf5d70=;
 b=Xg7Vzp7sprpjzoButID3RB3dhQJYHuGxFvyTndVVhvb9U1IBn1kvMHmOAohyhF6Lu8
 57N7rQtG2sEZjGbt/bFVy/ueUtfIj8mJLsZgxMT9ac1VIEm3pXBtu3KIyfDn/fMJN3uP
 634fzRe+mNtBMQ5pCVyWv593ZHalO4CD0LxTfK1zE7qi1tb2dTuhoIq5pIY0M2cMB3GX
 kHEG6jR36HXVk+LJDVOkA5rgupXfEhnw5LSZ6D7SHMcJSQWDuSIr+qVo4jKv94mJBSXy
 qhXlwkK2butf6EKAn74KfKM99CPvUHWHAqua3q3BZJ3uaMbMn6KkFWaTbiIk/Cw67oAt
 7tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738878928; x=1739483728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OJFHiaJsf3l+V8hBplYsVIbx6Bmq3Nc8WNF5eBf5d70=;
 b=R3sgHiYwxvZcmmCBVcuibpE+dJR3BpQnJh7G16eCc9Vmk1fX34etpnAxcBCifWn9up
 +xU3OjT0KozWB/4iRx4xCQlhapF4ZKF09oPk+U39KpjrVwwpChacopsJTuqsQ5nkrTw6
 9EgC4Piqgf7sUrWfxd7Hv0Q+1zjnGFXVPKYzNlMbOrBPgL8xSOF0GAQGA9Bef7dOeWhS
 /kHFXO56hubpb1leO50cGI1qEqFiZFfcOlVjRdWEzxEyg7BuyX3P/WSyGaDjhZrI99a2
 vn5rm50mrgL8z6At8ZeApdhlzIUIAmIHeItW69u3A8HQp34HARsNmr8rqnt0e2MLgUvD
 yepw==
X-Gm-Message-State: AOJu0Yw7hjAcEqUG39fu1raXyCMeJuMwsM61Gskeud2z01iz95+N+tGF
 ZjVS8add1P0uaW2kSMXkaN4sVIM9u7Ut09wuONItQjG2Jgm/H6ZixXuX3fi5Nag=
X-Gm-Gg: ASbGncvsVVthxrM4vfJlN1D7c0LiWt5w0uIyEBkA4G8L6LUAqETIS/iwC+QFm91NA6g
 8N9TNuA7/J861QRnLhYuf0S6cLQUnoU2aUzc55tMvBIcFdnOHvHzYr84VXFt5TSZAq86/ctkjPP
 yR2vY+pfqFhmLUNK6rD8zEYmgVvUgQMDjRRjrDwZjVXowL7YPGqRTATN6F8hhICE5A+fsnCRZRc
 Z3Hf9gnDSm+ifJ7mBhKEvCfUQ8JBWPRlnuoukn2GDrx7Wu4wl1zAMOtTmFSrbJ+52dMgBw1rA3y
 dSIxkndPDXu2Ka3u1ALaPnI918qJqQf73H/NDg==
X-Google-Smtp-Source: AGHT+IE3y9ptKfvU9u6mOh1cvl22qYRHOqvYN0HW2t2Miy4d610k4aUfpeee3xll4y0CZJP525JD/A==
X-Received: by 2002:a05:6512:3aa:b0:542:9987:6e9f with SMTP id
 2adb3069b0e04-54414ae6525mr107508e87.53.1738878927383; 
 Thu, 06 Feb 2025 13:55:27 -0800 (PST)
Received: from astra-student.rasu.local ([178.66.158.78])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-544125f73e1sm175134e87.62.2025.02.06.13.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 13:55:26 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] common: fix: add NULL checks for malloc_cache_aligned in
Date: Fri,  7 Feb 2025 00:55:21 +0300
Message-Id: <20250206215521.354511-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
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

- Check return value of malloc_cache_aligned for presskey and sha.
- Return -ENOMEM if memory allocation fails.
- Free allocated memory in error paths."

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 common/autoboot.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/autoboot.c b/common/autoboot.c
index 898a57bc92..caf54b01cd 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -186,10 +186,15 @@ static int passwd_abort_sha256(uint64_t etime)
 	ret = hash_parse_string(algo_name, sha_env_str, sha_env);
 	if (ret) {
 		printf("Hash %s not supported!\n", algo_name);
+		free(presskey);
 		return 0;
 	}
 
 	sha = malloc_cache_aligned(SHA256_SUM_LEN);
+	if (!sha) {
+		free(presskey);  
+		return -ENOMEM;  
+	}
 	size = SHA256_SUM_LEN;
 	/*
 	 * We don't know how long the stop-string is, so we need to
-- 
2.30.2

