Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620C0C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF2788473;
	Sun, 23 Jun 2024 19:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="El1of7+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E632882B7; Sun, 23 Jun 2024 19:53:24 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A7918780E
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so149941939f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165201; x=1719770001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=El1of7+1GsWg1jjtPx1inwgRm4pNY3unnqpAyWoBcFRFo4fdBB+zTkNvutXoDwqzw5
 6Zqmo2eR8jmglqPXHp4mPLXddzAwnC7zlIMiPc9qYGK8IkeMlxg1ogA9/PnZ8dIoHfQH
 QaWDr/E8YMn7qaxj3PjzfB9xYSgyWqhcB/c50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165201; x=1719770001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=slkLhsFSdhIup0Km2SrodWm8soriECL4paHIuVO78Ofq+0Vl8je5qTiS++Pxr11ThS
 7qiykv93SJJ8FdFUbT/aDfAFmvMUNeAS7JBgPU0bZxvOKgEoJPERK/Bt/Br2FhdbYYtB
 bx4fgYURGiwdAelFiUJ1rwDb2zMOMVf4kzpVHmSXuyN/VZDO14sUia2DQTfOU677q50p
 KPT/np1zLO+sDRb4H7vM9aZ77zjqwOovoRNBI1Q45PfPoTSq9VXsM/oJg4EsGjxqCsGo
 EIo572HWtROhoTVEPIuY0TbYEfRHKvUBewNll50f7qqbuCOAAsQ4aCZa5sC89SQy+vF8
 TzOg==
X-Gm-Message-State: AOJu0YwZ6VC7oAKyTLrRBeOEf0+vdV7GcmM2B4RL+N1v4eYDK7HeorB5
 YLLFKMtMd2hXJbJufV6HpG3mIH1cgP/U7CreRpXn/WtQfVsm0pSyviFrVXgrx/CWVekLWKMy8qG
 MJg==
X-Google-Smtp-Source: AGHT+IHmNU7TSc8hWIiRJShrZNSHNFtuPHqUOuVhhPAzhgUpw4qQeXgQHn8l6saHsbRrpKwYCsyDNw==
X-Received: by 2002:a05:6e02:20cf:b0:376:3fc4:1180 with SMTP id
 e9e14a558f8ab-3763fc4128dmr34816075ab.17.1719165200990; 
 Sun, 23 Jun 2024 10:53:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v4 02/16] binman: Collect the version number for mkeficapsule
Date: Sun, 23 Jun 2024 11:52:48 -0600
Message-Id: <20240623175302.1463973-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

Now that this tool has a version number, collect it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/btool/mkeficapsule.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index ef1da638df1..f7e5a886849 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -33,7 +33,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
     commandline, or through a config file.
     """
     def __init__(self, name):
-        super().__init__(name, 'mkeficapsule tool for generating capsules')
+        super().__init__(name, 'mkeficapsule tool for generating capsules',
+                         r'mkeficapsule version (.*)')
 
     def generate_capsule(self, image_index, image_guid, hardware_instance,
                          payload, output_fname, priv_key, pub_key,
-- 
2.34.1

