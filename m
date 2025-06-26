Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F7CC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 10:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A5782AA4;
	Thu, 26 Jun 2025 12:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U2m1vWRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6479B82C4C; Thu, 26 Jun 2025 12:49:42 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BEA982977
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 12:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so441417f8f.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750934974; x=1751539774; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vQt3s559kM73jRyBlz/WwvmHARtq5xzUHyM3gYOWMa0=;
 b=U2m1vWRiCgnMObA798gpwmWMuqijCoi0lb6ismS0AR3KemIwE3rEG23RrbiXUoThyJ
 Fgs8PczAkFc5vMWYlgLOn7hhZjJCwWVFA9aOw8z0y/xXSc0i+jYkJUk2EW0uWtY96Geq
 uk7/r86dmaSqio4+yKQSC5732XyTeWAQ+kdmJK6XYigjYYPCYm1cpAivnw8GLhNEm/w8
 M9yB5c47Xd8eEEsDIm4cZzt88sOffnVFjZ4NvIG+MuC+aMWckhNkqIHZIbbbSCaUGRBo
 YCPBv7GMdb6YcO+Nx3TAzRkiQq8ot4ELn7k+OeMG251e2Ugx7gG5DQLnOsvmAwwMyudu
 A/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750934974; x=1751539774;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQt3s559kM73jRyBlz/WwvmHARtq5xzUHyM3gYOWMa0=;
 b=U1EV7DDSM8zYLU3zrztIQnZreCcBI4AilfGCvxbUdYA5vbDZ8pv3PvT9Y+Fi+pfFEc
 eAI+mRcOBJC6W+/ZcXRskPJN3ujOtoCGG35ezrnOWPLI2VfOdeIdz/5Dmxrk84mFQQse
 IzkbgS+aBFJiG1lg+ga7lyM7BRJnzxr01CXon6qAVSFeUsjwm24uTJG+BQrd04eNE0yk
 mTuwhilMkMJsxAqPfT9nmBXYU9R+ky8Xk8siFAxDihScVM5jQUJoTv3HjhbpAgJWdtso
 7mXknsdPC8ufzxJr9s0MTa1MmNBPksQzdhlafJ/68iM33PfqBlwmYDcsNPddRWx/+TE1
 iTOQ==
X-Gm-Message-State: AOJu0Yy3AcrIakteGTf3VuWce5ZFlwKyAo/6heYjfUMgFB+G3wWG0ZHJ
 kiWks0Su+b6EW0Vvf6i8FrkheRGLwJYwIB5VkRF+AWtIYN/xHFtCHJBT/91ILcGQRbZ0k++6jZ2
 6w/Vrhb4=
X-Gm-Gg: ASbGncsU16kjk3jubQQVeBs3ij4PoHG0rGeStWKwQeDE/KuuKzWE2+puMgstXve2XaM
 aKB8aH5dcHSttL+nx5CwTuTH0oHT7v9dIKB+MELBbuMQRFmNF9pNy32yMw3OZ4XaY29rBCXXj8b
 hB8mnD26fvQn01w6ZX2xCWih6zfvnR4t++84wA6Kl8YQH1fcXsKmXQNX7bmwxbhEt6Sp1PpKAeA
 iHQ4zwmdYhm0kriwOO7Eas3ushl44aQwGHJ/ce9abcwWEZEsf8e5k1AYVnR0IGlQ89q+3GOl+t4
 RbofLpud0UfO0z+ABgHAN2txLzx6YZOrLvEWUVyS06oBrFGJabTCldbyf81q9a4SuVrXRCqTiZU
 hrHBkhRaNSxWLjw==
X-Google-Smtp-Source: AGHT+IFALVRPyywh3Ilf+pdzsXheZVr1TOl8J77F9f63mZy21TyHy6jjhP2UFKlGt36go1hknwofHg==
X-Received: by 2002:a05:6000:4a0d:b0:3a4:f70d:8673 with SMTP id
 ffacd0b85a97d-3a6ed6412e5mr6383071f8f.25.1750934973645; 
 Thu, 26 Jun 2025 03:49:33 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e810b140sm6985680f8f.80.2025.06.26.03.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 03:49:33 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 26 Jun 2025 11:49:32 +0100
Subject: [PATCH] cmd: mtd: Prevent use of uninitialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
X-B4-Tracking: v=1; b=H4sIALslXWgC/x3N0QpAQBCF4VfRXNtiN5u8iqRZBnNhaUZS8u6Wy
 7/z1blBSZgUmuwGoZOVt5iizDMYFowzGR5Tgy1sVXjrzXqM/cSXCaFEqv3kHCIkHVDJBME4LJ9
 fUQ+Sb9iFkv8v2u55Xtr2BiZyAAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

ret maybe used uninitialised in some cases so instead
initialise it first to prevent this.

This issue was found by Smatch.

Fixes: 9671243e8d10 (cmd: mtd: Use the subcmd infrastructure to declare mtd sub-commands)
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 cmd/mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index c25997cfb24..1651a4a6b3e 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -474,7 +474,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct mtd_info *mtd;
 	u32 oob_len;
 	u8 *buf;
-	int ret;
+	int ret = CMD_RET_SUCCESS;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;

---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250626-mtd_fix-bb1ae86f33aa

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

