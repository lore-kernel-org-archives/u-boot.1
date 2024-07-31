Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AF6C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E75588A75;
	Wed, 31 Jul 2024 16:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dRzocHLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B8D988AB1; Wed, 31 Jul 2024 16:49:19 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5288388A38
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3738690172eso26948545ab.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437356; x=1723042156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IFXAshjgWanbHZ1KyiTTp/2oPPsg2VEp2sumfErJFE=;
 b=dRzocHLuxHYzpwW8h3xoCDBjT3gPgXiXwlCb2NvYsoaR7BdFRVQvPHrUdrj6DjSt0K
 PgfN1CEyrCiHcdu1mqC4fzJC9ogk1m6MXbDzptpD6RVmbO6PpJtfo3GoUR0qsGBIzMoz
 zmjpQitkS8ds9U5+9TAgduymApS7ZHiamPaSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437356; x=1723042156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IFXAshjgWanbHZ1KyiTTp/2oPPsg2VEp2sumfErJFE=;
 b=q75cz/+BP4aLGYmA+oRTn5KVAUBr7KKOnj6PjoBfmH/XsVZpCK+m94+tM3avMkzIai
 aHXngOcE36GA9SYhPj2FZ8KL0UuONG/4oeYh7GrxNAETuIB3JUNdEi5KM+op8dRuba0z
 RjM2CB5mzvaGxtGxGyY7MQ/GsrfbhzeNZamWlKvjoe9ydfh5ItbuqnVaMI40XfEWA7Ry
 Tcs2MM2F9ka/UrNhBfzYELLtvhO198I6w/X0e3I+ZdetoUoosSZNNDj7xSw4VTaTZs+R
 Y3DFUJGocP8z1XTDk8BdgpV/udeLItFAKIxfM3fElfOg/2JL1TGXQwQXqk5IM5yRcsua
 kA6g==
X-Gm-Message-State: AOJu0Yw6/W2IamaYZQZDxx43fhkvRml3wjEiKBc1KebHq6wZlnqwNGTR
 QDRaKj44KhqDshRyLM1/JqgTXzjXnX5kFf+wP2Sg2SKAS5zyFTzGZ7LGP47UHjRLK+M4SetE4AM
 =
X-Google-Smtp-Source: AGHT+IHSqgHEjibjeXISe9WuqGuo6TdCRsB6tiURa6SU0VWrcLlNSus9W7+BpxK7DI6kL28VMCOHXg==
X-Received: by 2002:a05:6e02:198a:b0:398:fec9:2f17 with SMTP id
 e9e14a558f8ab-39aec3feee5mr175302895ab.22.1722437355917; 
 Wed, 31 Jul 2024 07:49:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v7 5/8] binman: Keep the efi_capsule input file
Date: Wed, 31 Jul 2024 08:49:04 -0600
Message-Id: <20240731144908.795290-6-sjg@chromium.org>
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

There is no need to remove input files. It makes it harder to diagnose
failures. Keep the payload file.

There is no test for this condition, but one could be added.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

(no changes since v4)

Changes in v4:
- Drop Fixes tag

 tools/binman/etype/efi_capsule.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 1c4d1bb0e2a..5941545d0b2 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -148,7 +148,6 @@ class Entry_efi_capsule(Entry_section):
                                                  self.fw_version,
                                                  self.oem_flags)
         if ret is not None:
-            os.remove(payload)
             return tools.read_file(capsule_fname)
         else:
             # Bintool is missing; just use the input data as the output
-- 
2.34.1

