Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21396D49773
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 14:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68281893A1;
	Sun,  1 Dec 2024 15:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S+tqy8UZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C94889275; Sun,  1 Dec 2024 15:43:19 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3957A89124
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-84198252db1so93094139f.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064192; x=1733668992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d32S3jB5Zf5+fd4ewuRqfnVqCd9FHjpLOQPSdrVhMFA=;
 b=S+tqy8UZ2FNTR1Zc2Mf985tpMAUVM4jEwEJF9FFvyh3dUWdWoJnkOPDiEW82YwK2qO
 ZG6HllcvyNB/OukdMufCRsOXSlxo1AoyoG9za+HuR/4XbALM9R4o0JERqE38c12LQlp9
 wIh/H6uyJwQRUQBZoeEu4FKUp0ob4OcLw28lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064192; x=1733668992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d32S3jB5Zf5+fd4ewuRqfnVqCd9FHjpLOQPSdrVhMFA=;
 b=peq76lWgndLGLQ+cYdLQABjgdCWNy7jWyLxuv69fe+gPcOTVzih1sErFX37dbLr+eI
 UpFPtxUo1qMc2xVBxuYYiTGG2kUoD7cjgio4+c3ZdlHJ6gwZ9h7R8tVPkXpbano73SbI
 JOkKRNl9/EcokDSwO9w/He7qxLWUn9hVukki16d9cnceLrduUgHsqME2c6lXVGzkNfd+
 Z5teQfKywaMV/1aN5jrWg9tLDse3DWNoGJflu8WKXai1ANkvtVW54LGu8ka9OFQJepPm
 EZ+zkaDP4/mSIfJ0uXgSNsXXUjyYSuVemdQ0tfhALv1x9uixmnejlsySd+x6ROdx/tXo
 lsIA==
X-Gm-Message-State: AOJu0YxU2SODBg3jxP61i8V6IMjXEBoCoCJmhdYGx7LJgGUNAaueQBBR
 98+4baaoejmBA3UDie2mfE1LYFoNk0Am2HVfbodv7qD85MYGOX4L9YfCb+Q6Lmto4rjwryHpsqE
 =
X-Gm-Gg: ASbGncsXCNnxKxGtI+zK/hqI8qUzMUgMQgKdH+oDIg7/7vgbId0T/cEcXAVjOY8bkZS
 ObUt1boQcAinrSWbnJbouZvbuSsNgVMiUBnkRUOga4Dr6LDyPn4sLGWnHG0nWBHwxdr9dUY9+2B
 /XQW1lUcyCJBRxk0w7C9c1cWziQvVDKlaH2zvuU32jl57PIABNPLf49RErV+sW8kIF+GEXbKt41
 kQfnlfedp4jOv7wP3RfTjJJoy3CtUfe62uo5DHWtm6K
X-Google-Smtp-Source: AGHT+IHuN+U9OA2VDNYFacLh6FOjBzxvlPxUj16upGxxlCLjIOeVmIhf4Wmh+CKwZi5ohdafgXTupQ==
X-Received: by 2002:a05:6602:1552:b0:82a:a4e7:5539 with SMTP id
 ca18e2360f4ac-844014e89famr1300757939f.2.1733064192433; 
 Sun, 01 Dec 2024 06:43:12 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:43:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 8/8] CI: Drop broken boards from sjg lab
Date: Sun,  1 Dec 2024 07:42:36 -0700
Message-ID: <20241201144240.1664398-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
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

Some of the boards have developed problems since the last passing run.

Disable these while diagnosis is ongoing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9f0b8a1a058..1a5c4f1fd89 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -576,10 +576,11 @@ pcduino3_nano:
     ROLE: pcduino3_nano
   <<: *lab_dfn
 
-samus:
-  variables:
-    ROLE: samus
-  <<: *lab_dfn
+# samus has a hardware failure 30-Nov-24
+#samus:
+#  variables:
+#    ROLE: samus
+#  <<: *lab_dfn
 
 link:
   variables:
@@ -631,25 +632,28 @@ rpi3z:
     ROLE: rpi3z
   <<: *lab_dfn
 
-bbb:
-  variables:
-    ROLE: bbb
-  <<: *lab_dfn
+# bbb has a hardware failure 30-Nov-24
+#bbb:
+#  variables:
+#    ROLE: bbb
+#  <<: *lab_dfn
 
 kevin:
   variables:
     ROLE: kevin
   <<: *lab_dfn
 
-pine64:
-  variables:
-    ROLE: pine64
-  <<: *lab_dfn
-
-c4:
-  variables:
-    ROLE: c4
-  <<: *lab_dfn
+# pine64 has a hardware failure 30-Nov-24
+#pine64:
+#  variables:
+#    ROLE: pine64
+#  <<: *lab_dfn
+
+# c4 needs binman supported added, so signing works
+#c4:
+#  variables:
+#    ROLE: c4
+#  <<: *lab_dfn
 
 rpi4:
   variables:
-- 
2.43.0

