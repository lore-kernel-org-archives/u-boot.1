Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0301099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8875084090;
	Fri, 20 Mar 2026 21:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PgrtA8J+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D41840E0; Fri, 20 Mar 2026 21:53:44 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB2D83FFF
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d77b179b52so1792616a34.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040020; x=1774644820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lOaRH/LvmRqafjhUGRpwAUO9l0ATEqvm8dTX5zQ0CTg=;
 b=PgrtA8J+oQqTngkzcdMyzeawmi0YO2HTVdT+qgigEadWooNtTgnVnLEZ9cVaHXqQfF
 9anKT0GSbMXe2cmfv1/g8KAfiV7OGpWEZolR25eKCKBlTF1daDg8ZVBMqW3EPovgxO4f
 eHD57Rn9X5TWmWvY/2op+v1b5f0Dnm8sECeBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040020; x=1774644820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lOaRH/LvmRqafjhUGRpwAUO9l0ATEqvm8dTX5zQ0CTg=;
 b=h21hLypKLLcLOvW7v9qCE8mCy7EVnyfw+2PBGhPBLXgVP7487H862BwZIod67oYeh1
 Q7bW9xwh1zF5NYhLhArImoi7TTeRVdWOkMtSUj3c1qPL3GPKQukTN9Hss59gC6WPxzbe
 rhnjfOSw6TigFTdURnIckmU7TKViJfPyCy2LWTLy864aK/9qdu7lHhOgOLdWF8NAKceD
 6dfyQgQUaQ30o7Q9WLOtGYrYmAe1NfKwifYpG9n/3rtoLhqdmeAuIwqHO9Y4VrPPUkYT
 yFjDN7chQDlNj4ZrCEI97wvgqZsv6Ad+LSc0NzwOKXCPpl7viEE9ZvL8CgAnlxMn3+Mz
 s5QQ==
X-Gm-Message-State: AOJu0Ywdxd5vYezf1igJTEfmkutTT9EB7qlWqOf2GsmoYcw1cdfpVK6j
 jxIV03FKw8DNpYF9u8PF/TuSfJl4G8KJUexa1oCOxIcwPLytsKOEbJjblgd4DzPeJtzFZgro/If
 JxIMoRWA=
X-Gm-Gg: ATEYQzww9hZHwXVhOS8YcEZ0RaqQog9yXsfVG8FAYulF0GvE/8M++nz4EIElfLXEa19
 Enx7XZNThge9huQt2jMB5KAeexJT/A8AgRKJhH8aFJj8YQXgRzlv1eD3C+jp3bFM6ZTQBDqnWDy
 tDryOhWWjkBzQ1E9s5CTx68u/rftoTOUcTYyUvVyXm6bnjhulqEXhLX+h52RpQnCE7g2fK54VlT
 mqsBxQK0gHPeVlxtyC3KfKVC8XhEFhN4JyJL/8berscm8Tr0UawlA86/BNjtfkUrJRpeNTdSHwv
 EQvDKHszNE6TyIIsM5IZn9AmYC6DyEACAj9g7R7XJMdJ9skldKNQZorI1ZDASH8EdzAI6d+QGwU
 wRfUUS+F7BuccWw0SQC2wWR3h3Cg+CPiEl4yLBpIyhe2+HiKO6al1x+BlDuxEqnLtwInC9QtnlD
 jHJAtw+pomOJ0aZhutWn5ItUDqSOLRefPRuBGE2rEDKMZcTz2NazsVlUvYjwu0ShvF7qHP5oZns
 qJpXLlrtIVaYGWoZL7ZyNybkNLpk4nlOTqCeGeOcwIn0HO55SQ=
X-Received: by 2002:a05:6830:90a:b0:7d7:e045:b489 with SMTP id
 46e09a7af769-7d7eaeb061fmr3725059a34.12.1774040020660; 
 Fri, 20 Mar 2026 13:53:40 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadc8a12sm3114660a34.16.2026.03.20.13.53.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] env: Make use of IF_ENABLED_INT in spi flash support
Date: Fri, 20 Mar 2026 14:53:39 -0600
Message-ID: <20260320205339.3788814-1-trini@konsulko.com>
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

In order to build the spi flash environment driver, but with
CONFIG_ENV_REDUNDANT disabled we must make use of IF_ENABLED_INT to
check for a value in CONFIG_ENV_OFFSET_REDUND otherwise we will fail to
build.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 env/sf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/env/sf.c b/env/sf.c
index 0e27a020643e..14c35324e641 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -396,7 +396,8 @@ static int env_sf_init_early(void)
 
 	if (IS_ENABLED(CONFIG_ENV_REDUNDANT)) {
 		read2_fail = spi_flash_read(env_flash,
-					    CONFIG_ENV_OFFSET_REDUND,
+					    IF_ENABLED_INT(CONFIG_ENV_REDUNDANT,
+							   CONFIG_ENV_OFFSET_REDUND),
 					    CONFIG_ENV_SIZE, tmp_env2);
 		ret = env_check_redund((char *)tmp_env1, read1_fail,
 				       (char *)tmp_env2, read2_fail);
-- 
2.43.0

