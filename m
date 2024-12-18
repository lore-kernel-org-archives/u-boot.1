Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF66CE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 02:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9018980303;
	Wed, 18 Dec 2024 03:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TDe4JKpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD378029E; Wed, 18 Dec 2024 03:55:54 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F253480274
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 03:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so190668339f.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 18:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734490550; x=1735095350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pn6xpJ5MXdP13bw8KyYFR2z8fU2JdFwMmRgCBcXTh2w=;
 b=TDe4JKpjb6Eo6wFC3zFwU0uY7s3idpix2V6YSK9KatGMZIiPEC9UehKPQJhrAqiVzw
 LKiuq8Nom3RmgVHeGsI6Rj/IJmqiOE852rXQ7nzgfdS86OJrYtxD7JZgeCx3bXw9FEAb
 d/l9MT1pCPETJetmkx8xa2vjKEsOtQjd3zNEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734490550; x=1735095350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pn6xpJ5MXdP13bw8KyYFR2z8fU2JdFwMmRgCBcXTh2w=;
 b=ot3iVNcMQ1t6ja0jha/SU2YEgg1dzfd6eGtK+3KbzeVUav2gJ49Ruiq8P2VB6TEXf6
 hTCbU36/S3aZbXJp8yWHh/8sQQlHsq5uplOViq4uKjHi4cUmczOuKrZuQTYtZKph0K8G
 7lecw5jVYK6uAMHB7XqdS9DaJ5Wols8uy7zNj/zDcA7+PWvGmOscC3tascCF78qBNp8F
 OJDNLVOkDXSe0vU/9MXqDNm7E/dH8ctI8U1aW4Dk2HYZe4FYRD7d9wtBGgB81CETVtOY
 HSImQP0mWJJkZ31vwNAujmHrZ+DiWvJqoWs8ZFLKuPVvsI2QyUu//QCL2LRN3gRaknMR
 GWwg==
X-Gm-Message-State: AOJu0Yy2xRRyQ4qJu4f+BSIdzrFM+23FgBLSqRp7lnI/RbewbbUNOYUD
 o01GGTBg6ETGP5Ajc1U8cxNUIzgbmt9PE4w80mLi4sZ9poY6aHfEvaGg7e9Z1v05hOUk/u0R6A4
 =
X-Gm-Gg: ASbGncsie27jkU1dXhD/jmID9hxCxqCol4Id2uoqe8h7rUxhH3ujappF3awa8wWdbDM
 ugovh3R0uwmy0+NTnTVKlTHBEkXYa4kqGOpeXN9dX1ibIcqyII5c/8CWZZvFRQ6Hmjvg1b2Hn74
 +Ra4cnjQjKwauDQxYsi2y95auvFDtJwNLBgQlk5y2ntV3cmYxKYfEKD76S/ETSIaDMulJVEM0fw
 MgBKzncVRxeUUmXwij2rFfITYVddtK2gq0ohPJnuSwyGW5+yHn3vCokr8ChslxK1SMFqZtFnll1
 aHFHMAwOFEWNuEHVfQ==
X-Google-Smtp-Source: AGHT+IFIekjb9Ql3T9UNg7SvsP9bgGwMzWcvkVvD+gs8GSWkwrUf/0IhgdTjed/ZPxcnpa3txrhohQ==
X-Received: by 2002:a05:6e02:1d8a:b0:3a7:81c6:be7e with SMTP id
 e9e14a558f8ab-3bdc1848cffmr12602785ab.13.1734490550135; 
 Tue, 17 Dec 2024 18:55:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b2475aed5dsm23816525ab.1.2024.12.17.18.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 18:55:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] gitlab: Resurrect the samus in the sjg lab
Date: Tue, 17 Dec 2024 19:55:40 -0700
Message-Id: <20241218025540.3025522-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218025540.3025522-1-sjg@chromium.org>
References: <20241218025540.3025522-1-sjg@chromium.org>
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

This ancient Chromebook that nobody cares about is working again, so
add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3d778d66fe4..61563c87ea6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -588,11 +588,10 @@ pcduino3_nano:
     ROLE: pcduino3_nano
   <<: *lab_dfn
 
-# samus has a hardware failure 30-Nov-24
-#samus:
-#  variables:
-#    ROLE: samus
-#  <<: *lab_dfn
+samus:
+  variables:
+    ROLE: samus
+  <<: *lab_dfn
 
 link:
   variables:
-- 
2.34.1

