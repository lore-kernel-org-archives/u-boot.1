Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188A5CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603FB868D8;
	Sat, 23 Sep 2023 21:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="luSqhOji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51888869EB; Sat, 23 Sep 2023 21:44:41 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6828694A
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34fdd6d2dabso12171235ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498277; x=1696103077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7aXT9NMvoxmwI8swO2vf2D5+Bg91nXRiw0cdso4z+o=;
 b=luSqhOji4L3bSkDR8O0tllfL/Rd11sXw3ZG8TFmiLR2JGts2+g2eZsIvLmhRasZunq
 xKoW2VPm+4eInjY92DK8PUygSbR9plXrLcZZwqu2WPpbMO+BPkQrGbfIdM19LgbpkgCd
 jm8qSwQ97ezDdd4znmBZA+eGI9UNzuRc5WCu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498277; x=1696103077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7aXT9NMvoxmwI8swO2vf2D5+Bg91nXRiw0cdso4z+o=;
 b=p9BUbaixtrCzGhGuwNCU9sjDDRmDHoXA+sLvyIYB6pHnvyJsYpw8Xfn6sdDHANnLmj
 731Cne33On5qY0W2gC3JBoTgxH2vDzWmAdEJ7IuKLunFw+lFMVJFYxNPR+gsokMdHW5I
 l/xQSVYkiZuFew3xf/PblfAfUCHGsYPiILbeMl5Rm3bPK9jOHB6SFGdFvX7fhO8xX/QN
 3/Uzecc3IeUW4exderQUibpSnGPWwg0TrnPTYFvSzqizk+MXyVmeNWTP13jpNdC883hP
 rKol9jykHIM7iPjJxnj5ZrgFke96yFcVcucLzCjY1Il6QbgwRCZwqYmB9sYJOaUH81+R
 aznw==
X-Gm-Message-State: AOJu0Yy6y1L994hjHCVfImFc4JkNTSd86fHM/L1rpFhgPiqTe85naAm/
 Qs2qtpJg+1MMSP2ELgSVZlyDVcIZEKuWYrR0Z7c=
X-Google-Smtp-Source: AGHT+IEd+qhQTty/h41uh5AowkPmVftDBS4WQwBYMocHoSGSIYA36ujt4cq/gLuoE8Gf/px+l/mwOQ==
X-Received: by 2002:a05:6e02:11a2:b0:350:e9c6:e765 with SMTP id
 2-20020a056e0211a200b00350e9c6e765mr2759739ilj.11.1695498277210; 
 Sat, 23 Sep 2023 12:44:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/27] moveconfig: Correct some regular-expression strings
Date: Sat, 23 Sep 2023 13:43:57 -0600
Message-ID: <20230923194424.1739224-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Use the 'r' prefix for these strings to avoid pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 36202fe5134c..0b0ce64e81fe 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -1153,10 +1153,10 @@ def prefix_config(cfg):
     return op + cfg
 
 
-RE_MK_CONFIGS = re.compile('CONFIG_(\$\(SPL_(?:TPL_)?\))?([A-Za-z0-9_]*)')
-RE_IFDEF = re.compile('(ifdef|ifndef)')
-RE_C_CONFIGS = re.compile('CONFIG_([A-Za-z0-9_]*)')
-RE_CONFIG_IS = re.compile('CONFIG_IS_ENABLED\(([A-Za-z0-9_]*)\)')
+RE_MK_CONFIGS = re.compile(r'CONFIG_(\$\(SPL_(?:TPL_)?\))?([A-Za-z0-9_]*)')
+RE_IFDEF = re.compile(r'(ifdef|ifndef)')
+RE_C_CONFIGS = re.compile(r'CONFIG_([A-Za-z0-9_]*)')
+RE_CONFIG_IS = re.compile(r'CONFIG_IS_ENABLED\(([A-Za-z0-9_]*)\)')
 
 class ConfigUse:
     def __init__(self, cfg, is_spl, fname, rest):
-- 
2.42.0.515.g380fc7ccd1-goog

