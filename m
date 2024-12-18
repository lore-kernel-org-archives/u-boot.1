Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EC5E77184
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 02:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052A780239;
	Wed, 18 Dec 2024 03:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ewkOk4S0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF6E8022E; Wed, 18 Dec 2024 03:55:49 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0619E8021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 03:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a761a622dcso45571535ab.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 18:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734490545; x=1735095345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1N5XrE2hLFjrL8ZATeQhtEaIYdZrzVQE2sHNmtDVVWg=;
 b=ewkOk4S0PTCiAxkC4+qsKQ5H8+VyjOTzf05fg31zmuiFPZ45jjVAr1KrRu2mVm+loS
 LlylnTb5C6zebqmBf+m21/is3Fih9n0V1DdU7C7rhQvsXxgw07+r8Mi1H5ihpRpttUYo
 z22uG9NIQTMWKXhaaV4q6BL2np8twsZQWXdok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734490545; x=1735095345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1N5XrE2hLFjrL8ZATeQhtEaIYdZrzVQE2sHNmtDVVWg=;
 b=n6trudoE9l15m+oJk/PBFIOaOgHWpSh+Rdvv+GRiybUyvDtBdVdTovnvVRNpN6PJFv
 GM8PDVp1bHEiFzsEu6km0RYC1Iiq0AO88BLOK8tAlw8RHihOvTH1i3rcvqSusiQlq41i
 wuANDEDB2h2wUoMAme+7wIiR9D1G/WW1VQZLp/tNG4/nDoFy6abmgf95wF9uzB+ekMyV
 dtZVBmEH41XJmAsaNoWN3yFpy0i/ODs1bKpynEZnWykNdLYJ+k1hFKuwB1ui/zIlwE/J
 /FUWVtH85HK9C5d/v3B/QTd3/HDzfPf8lrwPJ55iGP+RKFtDkOXCKM7WrAvuFLOKw8cp
 /VwQ==
X-Gm-Message-State: AOJu0YzU3Wv5B524p+hYHc/B0QM5RTEREZYRBd8cSnFC3p1uX56DIVGM
 GvuFaJfuwoPAmp/gwvVHbL3mPOX0yS8Y1TS1cIvEzfbsuRptME45UDxiWWxm/TDcX5jilgMXRuM
 =
X-Gm-Gg: ASbGncsoYOJCZXvXCh7GbDdjilkaHErI9oJJZbJX8wxN9oH88fpOOAPjeif4OvgIaCs
 NqicCwToLxygyTj3IxSt75MndBLenwMnBMcKuxP1X1yiC284cgPs07RO5a3RLV6yML883+1viR6
 9EcQHoo8tRxieYRX4YBGsNfet4jxItJU9PxPyJrgQsSf5mHHSf0RbCpyijoKuZ0thBX5oLyg2bz
 WTbmT0V1N8TrXqmQRguaszTXiF/RpEPEXpscNGgHqGU3R1n5IU5mPqt7E0CbrAxdspb/+7xkLu9
 kbkz7OyhkkEXtC7lAQ==
X-Google-Smtp-Source: AGHT+IHTgt6I/v+WIDxvx16Y+FjNNZsHel0oqRHZEaPJCVf81+gpGXSZTvXpdKOX3K7oWwF9qRmWgQ==
X-Received: by 2002:a05:6e02:4:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3bdc5102336mr13000625ab.24.1734490545148; 
 Tue, 17 Dec 2024 18:55:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b2475aed5dsm23816525ab.1.2024.12.17.18.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 18:55:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] gitlab: Resurrect the Pine64+ in the sjg lab
Date: Tue, 17 Dec 2024 19:55:38 -0700
Message-Id: <20241218025540.3025522-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This is working again, so add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1c15907fffa..5fa417e79c6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -655,11 +655,11 @@ kevin:
     ROLE: kevin
   <<: *lab_dfn
 
-# pine64 has a hardware failure 30-Nov-24
-#pine64:
-#  variables:
-#    ROLE: pine64
-#  <<: *lab_dfn
+# pine64+
+pine64:
+ variables:
+   ROLE: pine64
+ <<: *lab_dfn
 
 # c4 needs binman supported added, so signing works
 #c4:
-- 
2.34.1

