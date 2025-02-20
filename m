Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C89C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8C6280077;
	Thu, 20 Feb 2025 22:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FBan9mDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2AA80F53; Thu, 20 Feb 2025 22:22:46 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F038D8006D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-221050f3f00so30306895ad.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740086562; x=1740691362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=FjjpC4UrhyCc0EcmkO8HJPZOrXGD5SjarRuaenPAb7I=;
 b=FBan9mDsOZ71yzGUJN0TcvGTz3oJmBiE16dY0p0whaRDdKHLul67bRb70c3bNDK73/
 Xobc0iA43fBWrabf/18S0TGahx3gxzhTK4UIGjOzVXW03q3umgs/Kwk476ECE5ztUPJK
 eXu2B/Gs1kVC5mIlykVDTAOxp/+uKHv/bYoIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740086562; x=1740691362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FjjpC4UrhyCc0EcmkO8HJPZOrXGD5SjarRuaenPAb7I=;
 b=vyyypGOU+5VBYG9sfa2M1WEH9f3B634JQGJ/0vl/QhtnqTUR6rFuSiGBoUEs+GJ6BS
 ezLwILS5MnHyhmzxNUNinK4gZNLWiCQwEEPeVs4XO2yBXYQ2irmmGp/Xexh8YVz/qF6j
 Xbc1Z/W3EoCI62J7IhyZprNGVKHUikK3x45hnMXd70jMBkedXf1BTxiYJ7YdXT47chNJ
 XnqtPNf7dbkSorcCKfe57a4U/lXLA8rpTNjFWtJKGNrsRgyGqiQ2p2fe4R2z2KDHbzv9
 iO8WyPAUzSOwd8UWmofLLTqkoqbNFwc0Qxf1E2uWdoM75EKh2XASzuYq3JVXQ4q2mFB5
 Sn5Q==
X-Gm-Message-State: AOJu0Yx+greEblkdSnCB5lKwY/gXUVj6EpjDOc8wlKYR8fe1DjihObOE
 WDTNUdTjv3y5cjPfFMvSLMIWbZkd9XkINwDA23PNWnNHzEQ/fSdxVuOyP/TkKQqK/SyrJlK65Xl
 w/f4=
X-Gm-Gg: ASbGncvg09w9PVyBxErNWDnaojpMza93dDftW+NXnSTGG/cbA+zRLF2ZK4sFCt00SaU
 NpFILsFMEgQ4xQumjUxluV1S/otPLVT61ak8bzxqcqvUFaA+br4hx2Dj8speTDguY/q4Fj9jcG3
 yyN/a57MqFw2nSRMkL/UUrM73nj8XaI9DOk2rtdkH198bLA1ytjsKRh5kGZVYhL7HkokqYdQKcB
 4xO18NYOZwD6e+yMxRsYL5RtxYT54S7aO31qgxusbpbJ+QZ62M//4JIhdVfyGVdWDNDXqWM7uSW
 CEbt6MKvAEEw4zSZ
X-Google-Smtp-Source: AGHT+IGMaCxOO/TvKiUfov4tijbBuxuKiCIEnG2+I1JHuE/MhvfDHA1ciqLwddtW2T74+hqUwu4eKw==
X-Received: by 2002:a05:6a21:497:b0:1ee:a914:1d57 with SMTP id
 adf61e73a8af0-1eef3c56800mr1286464637.3.1740086562423; 
 Thu, 20 Feb 2025 13:22:42 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add3f326b31sm10721099a12.64.2025.02.20.13.22.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 13:22:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Update to pylint 3.3.4
Date: Thu, 20 Feb 2025 15:22:39 -0600
Message-ID: <20250220212239.2954325-1-trini@konsulko.com>
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

With all of the reported warnings now fixed, update to current pylint
version.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 1f2766eae160..d5cfa59a8a61 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -173,7 +173,7 @@ stages:
             -r tools/buildman/requirements.txt \
             -r tools/patman/requirements.txt \
             -r tools/u_boot_pylib/requirements.txt \
-            asteval pylint==2.12.2 pyopenssl
+            asteval pylint==3.3.4 pyopenssl
           export PATH=${PATH}:~/.local/bin
           echo "[MASTER]" >> .pylintrc
           echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e339c25f5e17..64f92f8b5b9d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -210,7 +210,7 @@ Run pylint:
     - . /tmp/venv/bin/activate
     - pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
-        -r tools/u_boot_pylib/requirements.txt asteval pylint==2.12.2 pyopenssl
+        -r tools/u_boot_pylib/requirements.txt asteval pylint==3.3.4 pyopenssl
     - export PATH=${PATH}:~/.local/bin
     - echo "[MASTER]" >> .pylintrc
     - echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
-- 
2.43.0

