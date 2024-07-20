Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E19C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B93EC88C78;
	Sat, 20 Jul 2024 12:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fj+BI+m2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6858488C61; Sat, 20 Jul 2024 12:50:15 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EABA688C4A
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-427cede1e86so17703015e9.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472612; x=1722077412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBWL6Y4zNr0gtfBm8AHfUCtwzhJ5+/iqoEoBimB/Of4=;
 b=fj+BI+m2T5hHMva5s6mggPU7QhEbO7VvTwZMQlyDYG8zMKrHz48BQ7Q6qro+qKipvp
 XIYTzu7PKYot00mm8R1aWY3/yTnc2tfPpqdGuVOWbbeLGnQOHqMuQN92eeB+HmiBn+AS
 iCn++UH5V3GKWQytf0LxWqAK0I2yUB8SzeKEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472612; x=1722077412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBWL6Y4zNr0gtfBm8AHfUCtwzhJ5+/iqoEoBimB/Of4=;
 b=Ttq4jkuvxDNua2kixJkOl6Tdttp6CrCKFALdjaUQmjnBzZGdFuzvg1rAiV9NqnUdF6
 5Se6/kKkQZPr3HZExlRBl+Hjw/L/cmn1cM6lQTvn4K9jE+ryg3PK4B45BxG+13mMrZpY
 E4KG1t8HMUhJrtIjc/XTfIblOxeAw6AqNOj0UCGyfpzOBEeVmWbF0hJ7QOK3aub+a/4j
 JhyoArtmQzd9hn/8tOJK166foglEB1sXiYCsGReXxZH08NfNVw1fcMa25Y2rGBufvfA0
 8MRrSt3OFn61WPqDfr3aHfqJZlavf3vsL4pJe1aRXGwi9czp5tjAUvp7Xl2u5LwUOCVO
 G0ug==
X-Gm-Message-State: AOJu0YxEXzh9pDq7dv448oAqSciOprgdXKIN66TcQdkpPCxYte5ZdaZ1
 DEetaCSL56Evo5QzV7lkF6Dh0frHF+NiD/dIbpEEmKT7x15gMiyUELVKOXeNinFpB1JepryesYE
 =
X-Google-Smtp-Source: AGHT+IH3/k4kvkvhTaaB4pY9Da0Db+BQ7+imNCnj3wuyoYFXnsTZJb3Hh1WUdzTIm84guPLKwNQyeg==
X-Received: by 2002:adf:f343:0:b0:368:504d:c3a4 with SMTP id
 ffacd0b85a97d-369bae34e0fmr841233f8f.17.1721472612306; 
 Sat, 20 Jul 2024 03:50:12 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/20] binman: Remove dependency on pylibfdt for entry-docs
Date: Sat, 20 Jul 2024 11:49:43 +0100
Message-Id: <20240720104950.2730773-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

Allow the entry-docs command to operate even if pylibfdt is not present
in the systemn.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/image.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/binman/image.py b/tools/binman/image.py
index e77b5d0d97c..97443d3c0a7 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -21,6 +21,9 @@ from dtoc import fdt_util
 from u_boot_pylib import tools
 from u_boot_pylib import tout
 
+# This is imported if needed
+state = None
+
 class Image(section.Entry_section):
     """A Image, representing an output from binman
 
@@ -75,6 +78,10 @@ class Image(section.Entry_section):
     def __init__(self, name, node, copy_to_orig=True, test=False,
                  ignore_missing=False, use_expanded=False, missing_etype=False,
                  generate=True):
+        # Put this here to allow entry-docs and help to work without libfdt
+        global state
+        from binman import state
+
         super().__init__(None, 'section', node, test=test)
         self.copy_to_orig = copy_to_orig
         self.name = name
-- 
2.34.1

