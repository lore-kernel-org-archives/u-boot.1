Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C20C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1954B88585;
	Fri, 21 Jun 2024 01:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VxKCMjnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10108854A; Fri, 21 Jun 2024 01:06:44 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85F087D1A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7eb7c8f114eso51676539f.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924801; x=1719529601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=VxKCMjnAFfn66yIqx0nhnuewDlqMNGvJZZWd8gNYay0Xs1WD7LsNbnjY/KjUK2+CRu
 l8PkHK4+AmMJZReeO+vnoULpnwgoZ8jCViOpzf4aEZYqCeegUXFKKUeZqa2j94jmumib
 eztD6xdEtJDFYTvngdZ1KyF6NSBgT6oF07dZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924801; x=1719529601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=EvJdezoEjq+SVZHNH9sUMfv6orByC3hVKxQNUiKRWhtBs9VEwiWl0pSYYv/fpfymlz
 Tw7ZpJJddIBvXR+AA/G16UGMN9eiBg1+6tM5mwbbiMlNXXQJPUl6XYfzXfvryTaV3lzG
 0ZXw6jjfQSCgC32jh5EfN6qW/YB1kLn92sVM37K6Ccz+33M309kERqN/HOLjqcMk/V+A
 7KaAWs70QmcXUzUqAvvd1+cTmVLjHGWI392KqXFr4w46asqvqeKhpH2CLnQjtg0kAbsA
 ZcU2VU1ASyyG51pTVC0qygFuunq0w3X9C8yz8qOdEnWzEsERCkco9EgimcEGstD0JzyQ
 0Flg==
X-Gm-Message-State: AOJu0YxxYf3aOeONshmYst3Xozdlp7flb7aqoH27sjiKnmghl97o/wKf
 vcRpecNV+hXJ24rknUwVL9XQfMGep3HfqTv3AiVkv4akeSxxc5O5JdVveBoxk9dqqpeahk0jZKR
 wjA==
X-Google-Smtp-Source: AGHT+IHXkvEwocd6n6CuYgvz3DvEkjPDOSJDYPXnxWmskQfi6IZlLgiNwY149xWFmudxULeh/nIPVw==
X-Received: by 2002:a05:6602:14d2:b0:7eb:9864:410b with SMTP id
 ca18e2360f4ac-7f13ee202bbmr779322939f.5.1718924801459; 
 Thu, 20 Jun 2024 16:06:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 04/18] binman: Collect the version number for mkeficapsule
Date: Thu, 20 Jun 2024 17:06:11 -0600
Message-Id: <20240620230625.1797397-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

