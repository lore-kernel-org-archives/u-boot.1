Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19C3FD9E19
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4E283AA9;
	Fri, 27 Feb 2026 00:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLZ1Mbki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2F483D1A; Thu, 26 Feb 2026 21:58:54 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229BD83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 21:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a10d311c79so1121250e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 12:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772139531; x=1772744331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s8Zs0Gh0Wn6Ugwpz24Kq8wR5rWC4YzeuifZ6QZF8pcU=;
 b=mLZ1MbkiXM9p7VfCJW+VP2Q418+JCmhoHuhJhazknoJ9XugbDs2BksTg953FTOdbbX
 KDu/jcaaa6THeFnc0J7s0+rfwFS+ftv+lqYn6PLRclOlIKQT0JcA0eeieCMDM7QG8Qso
 ILo1YdR2c8hr25ns5DlEQdAkcB4oUfxmKZzScWStOVI/ykbDUPMMIIzHnGYaaHzEsAEl
 4xQElxNrnX3vpGGLiXfmfU/Gn7sjTIsgOegXTkvvGnYvpnbGc252MHyVp4WTqdY0BBsH
 O6hAczzxMZd4/thzFNil0zWe5Nf37poOCfcv8j9KwE/3nYxwm1+1QpPAdHAtgRth+E4N
 qeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772139531; x=1772744331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8Zs0Gh0Wn6Ugwpz24Kq8wR5rWC4YzeuifZ6QZF8pcU=;
 b=AkcjFJos40IUFXEGy96zudo3PvVUvPNipUwCOlx7mfgqvDOk3Pim8xGKjVpjWYpoSp
 knJzKzoMkKoKvkh8Q5UmlVlt+8oKs9CVDQMNXA/OQn0UXKahUw9HhVs69AppEYPCj2t9
 9HjYubUHkz6T7fTnRi47eJJ1DawKJTLNKc/yTlbIuWWxtxVMDYC+Cw/tRH5J5lVrdsKk
 8QIvFRbKyeDGeRE0i9hJLe0tBkYweZ8yWBdHk4Fu6XP+Vv2PxJ6b2hqWSmpZkNrydPWh
 oxLMJ98MVl5zW+IhPcS0Gl8+D6P0TmY1FJB2KYUYgBbUSqESKP9iUwdwmYGKfMpvGCTh
 GDCA==
X-Gm-Message-State: AOJu0Yztofd7a8kQ5ZLfhZXtKsnxXMGrrkw1mLqOVk/EMjjlmom8+v/W
 F6aYufDAj5M2TBQOxg52SRN6g6g04W9LdK+tRRj/8CcUkQE/Zl95oerxWNtXW/Ki5Bs=
X-Gm-Gg: ATEYQzyAoUDkpjWGubhKVkbFSSP9QxdgzMgIUAdInm2CprAJnKX9f5XbRFasEHkKk59
 Y0kOCChrds11+gJRo71r85fowgls+dwF+nfVlO0Oiy1bgFtTDR2wSQyvQ1TwjxchCuuOPlgzpo+
 Q/3IezQfpqxhfWbtzJFmalg7iSaXaZP6zi8YoxBytQTco3NKgCo/WP7kaJkYE/qfaZaULdXxdMN
 v6HDqnaKoPwcJxxW7xw2ho8rNRcFznscYpDu4kxJUM2mLBV2W6kHSXdlL9W38kl612HbF/x+qzi
 o03yfGWT1w20cZBdBRZvwGrqWhUfMAfuVCik0SEerk5RWGQ35cjpvhMG5/l0w7b0MpDcJjWnmjk
 rihtpxyuj8vXMtFWelYT+sP5pww/08i7rksOZVlY0wg9i5pcFZ2hU/6VD8ErdsH69Cw9QB/Vf1r
 SQJmDb8sfh2qyHKu/pzBPpsr1VmEtPwKHr5fX1WF7iNPAbwTtEHzGbfcyWKS1VFLtpaG//9ouzV
 oXcvqD9sPNkwAb+TQHFKNdBHTfcUrHl1HzpyQIluLkDmsUN
X-Received: by 2002:ac2:4f13:0:b0:59f:6edb:b7ea with SMTP id
 2adb3069b0e04-5a10ffd684amr180026e87.42.1772139530874; 
 Thu, 26 Feb 2026 12:58:50 -0800 (PST)
Received: from lnb0tqzjk.rasu.local (46-138-124-225.dynamic.spd-mgts.ru.
 [46.138.124.225]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a109e01949sm1334790e87.45.2026.02.26.12.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 12:58:50 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] kconfig: fix buffer overflow in conf_get_default_confname()
Date: Thu, 26 Feb 2026 23:58:46 +0300
Message-Id: <20260226205846.57752-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Feb 2026 00:01:16 +0100
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

Use snprintf() instead of sprintf() when building the full config path
to prevent potential buffer overflow.

The function previously used sprintf() to concatenate SRCTREE environment
variable with the expanded config name into a fixed-size buffer
fullname[PATH_MAX+1]. Since getenv() can return arbitrarily long strings,
this could lead to writing beyond the buffer boundary (CWE-120).

Changes:
- Replace sprintf() with snprintf() with proper size checking
- Add validation of snprintf() return value to detect truncation
- Emit conf_warning() if the resulting path exceeds PATH_MAX
- Return the unprefixed name as fallback on error, preserving behavior

This fixes the static analyzer warning:
  confdata.c:119: buffer overflow via getenv() tainted input

Reported-by: static analyzer Svace
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 scripts/kconfig/confdata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index d587b10d7f8..756e613fa47 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -152,7 +152,11 @@ char *conf_get_default_confname(void)
 	name = expand_string(conf_defname);
 	env = getenv(SRCTREE);
 	if (env) {
-		sprintf(fullname, "%s/%s", env, name);
+		int ret = snprintf(fullname, sizeof(fullname), "%s/%s", env, name);
+		if (ret < 0 || ret >= (int)sizeof(fullname)) {
+			conf_warning("configuration path too long");
+			return name;
+		}
 		if (is_present(fullname))
 			return fullname;
 	}
-- 
2.39.2

