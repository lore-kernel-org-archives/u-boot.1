Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F93DC19F2E
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 15:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C02807EE;
	Wed, 26 Feb 2025 16:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kd/SuKg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9A880805; Wed, 26 Feb 2025 16:33:51 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8363E805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-471f257f763so68398101cf.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740584028; x=1741188828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1VZ4u3M0EJrKlw6ESAv2Czg/yiOVc3XCsakgDgkN2OU=;
 b=kd/SuKg9kKChMgl2gScQeMSGPYmL0sWlTdICJDdN7Rq8BVNMs4MvkBAIQL1fnRqXuy
 q9Uamdirfr/B3Ve6qjlcuhS8FLXGo3FqGNfjFCcrJvYya1+qIFMDzN831SolNG0Y7xuK
 mcjIIjT6B4apuY9smcEAeclEwlnkjOK4ihROk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740584028; x=1741188828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1VZ4u3M0EJrKlw6ESAv2Czg/yiOVc3XCsakgDgkN2OU=;
 b=xTHDU9HaX+VJLQvwgiHc2brjzmAAMPPmavFtPbNm8uA+UbLTOyfEU6l0T+knwJDAAc
 j8W1vByFtG4EPM6prgdS7zpAAUAbu0vax0Ppwlr/iTU+Fi//ORMR0Dgc40RCpr2TBbZl
 msAJ/DJ709VQAnpPPWyM/QIgcNsliln81ukKh4xXWeXTv5RpMwDUYe9OZwdZx+3qPFqY
 ULa7JNYXAxSDcBFKDgqBgTQ4n49B40MEWToNm6ziknx5enoQnLjZ5WiFrmimoaPx0CdN
 ENXDMQMP+kvySjSgI7NpdyMFsVYJb23IoOdSRumy8xOwppiC7sTBOJrhR30GLUptrgAt
 JCgA==
X-Gm-Message-State: AOJu0Yxi20uIvNx1qKRwNSmVjjTkwadzlS1JF5cXqCtofqXwkIu+R6sO
 ehVkFU1pjqDNI4lfT66hvD/7pnHdbE/LdZwcqUsOvWFG4ZRCczvnaqoDoThwBmOlxm96PvTjoFJ
 o
X-Gm-Gg: ASbGncv5W2KtnqBgNe5NBO+VYe9qUsIQwSlU6EpUrm10BUiIhHR7505jzfsfGVk3SEv
 flP4hZpSfXju9aq6wkMoQAco4f54jhhCVzKi1Y2+VUhknvu3gscJRyCG70CX7+8gJDQoj7Gx70M
 nr8XjaVXFW3fLu/H6BoqtIpAGjRF/dXkBUMx8YCKzw4ETvmDwxbL2vTv3pp+ZpP+3+J+Ly1wYEs
 yXHNv0J5aSkXCNYsHg7WEU5mkSWxDqkl0fGktMOExT0clGKTZa++A347De3fz9vp4jUl5sHT+Dh
 qi4laYuseLSa1nXH+iibHdnKZyA=
X-Google-Smtp-Source: AGHT+IGHzfqpXDuVrrCcyHttZNKkHaE8gz/ii5hkNsgVrAXN9hZbjYnlOnk86PH/QH+YGDvnHBDS4g==
X-Received: by 2002:a05:622a:4ccd:b0:472:789:4701 with SMTP id
 d75a77b69052e-472228c7c4bmr322879541cf.16.1740584028376; 
 Wed, 26 Feb 2025 07:33:48 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47377e238d9sm25814861cf.46.2025.02.26.07.33.47
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:33:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] scripts/checkpatch.pl: Upgrade IS_ENABLED_CONFIG to error for
 U-Boot
Date: Wed, 26 Feb 2025 09:33:45 -0600
Message-ID: <20250226153346.2736160-1-trini@konsulko.com>
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

A problem we have today is that some instances of IS_ENABLED(FOO) have
crept in to the code. This is in turn because with checkpatch.pl this is
only a warning and not an error, so they were overlooked. And looking
deeper, in the Linux kernel this pattern is allowed because
IS_ENABLED(DEFINED_FLAG) is allowed if discouraged and a quick skim of
the instances I saw in the current kernel follow this pattern. In U-Boot
however, this is not allowed, so bump to an error.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b8eb57f38c74..f9f8891c0c49 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7205,8 +7205,8 @@ sub process {
 
 # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
 		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^${CONFIG_}/) {
-			WARN("IS_ENABLED_CONFIG",
-			     "IS_ENABLED($1) is normally used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
+			ERROR("IS_ENABLED_CONFIG",
+			     "IS_ENABLED($1) must be used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
 		}
 
 # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
-- 
2.43.0

