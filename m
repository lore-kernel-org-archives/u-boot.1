Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E892C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F6988A61;
	Wed, 31 Jul 2024 16:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SAoWAbnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C62C88A54; Wed, 31 Jul 2024 16:49:17 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D231F88A38
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39b06af1974so7875655ab.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437353; x=1723042153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=SAoWAbnv/ifts+bX6LP7uQyTtCDpvzwepErtCMNhUqvzCsaWLJMbEM/lmyqrVzTLMH
 iBwazAnn3bQFn2PMK/Qe1eb4G4ep8FOLDysD1xAi54MEnTqNZ3G0aHQfoOWpX+raKZPB
 a/vPeeo2QW0M/AuB0pnAprNuv2oy3FFJjlPG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437353; x=1723042153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=nGZahNu4FjVgirSU9q0Kyeu7mRO42rxJiPJLUJk04psspkRDVqRJDflbg9m/Kc/Bfh
 kMlYsQOp3fGVmuAI9jUgAJ1Zi3ci45WwuSyl8HqjmmeD8dTGDd8KLDAdEqeL15X2jj8v
 ZgQYD8xgR5Uq+lCYo3fMD8czUVmpvd3nMw9QOsAheqMz0DeHeYGr6sqnD85Ey9+f7UJI
 bIFPMKQPSxw92Z2FVg4UOcOMcvfhcTvarZWfEOSgpQYTPFfGmCvV4SKOoNQNCyqueRre
 vh5qkHQRAT8eoKNjUV6jQo+mYFJpKLOz2ziD+x9T2wrmEjWlK4KpfCI7ua6fa2bbkQo4
 k2qQ==
X-Gm-Message-State: AOJu0YwDF7cxA2H1ts7cWkcxePvL9tXvIHyhhvcNGOeNHmFgFM3ZmJSF
 Cw73ry1H3d4HbX2HLNWQuo6ZcBIDb6diJuLOSL66tefI20oc5snl3RZjOxYxyxUFHqcT0rQLeUA
 =
X-Google-Smtp-Source: AGHT+IFKcJKwf77xFv3OPiql3k8E7I0tOocxXCJNXAS0NU7P+cfZ4jZtdpQMXQDFB1htLVLw4fzVFw==
X-Received: by 2002:a05:6e02:152a:b0:39a:13e3:9176 with SMTP id
 e9e14a558f8ab-39aec2e4618mr191702385ab.15.1722437353460; 
 Wed, 31 Jul 2024 07:49:13 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v7 2/8] binman: Collect the version number for mkeficapsule
Date: Wed, 31 Jul 2024 08:49:01 -0600
Message-Id: <20240731144908.795290-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144908.795290-1-sjg@chromium.org>
References: <20240731144908.795290-1-sjg@chromium.org>
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

