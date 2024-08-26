Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EA1C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491068839A;
	Mon, 26 Aug 2024 18:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qq4hwOKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A8B688279; Mon, 26 Aug 2024 18:39:23 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04496889C5
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-450059a25b9so38111461cf.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724690360; x=1725295160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9/5ejxe9imCKHZv9UyyDs31QOwdGVlChj3LsXP5osSQ=;
 b=qq4hwOKlIsIA7ioB5XMc0vbXW9zLE7+XO3VYEHW811cfKHut5T8msCm+z8Xa4ZG/9U
 O1C+uiyYPhNaKF5rkWD4WIw5BRQTGPqELbXf6a9+cQRMpycKnAmmKFQauShmN8pcds7v
 KcU9OKsv+GPuuArjBlyw/YwafuidBhKpZgXIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724690360; x=1725295160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/5ejxe9imCKHZv9UyyDs31QOwdGVlChj3LsXP5osSQ=;
 b=gp5j2QAAcvR99AubIx8R6XcopGgy5NNQcIdMus62PQ8cgOV0hwefAQiLaNd+HL/F6F
 Mp8WirbnRoYJfqe6MY1mVL2VB4gwn4GmEuWTzzk6htSUnMMRpkt02iT6pIaDGJyy/Z70
 BoqsBHEV6AU1CZsv56vJKC/OwTKLfk8GtqBQUbh+7hrwjI7l9Gqtqa5aa2oZz2jChCbe
 7BuAj28XTaVLT97+RE7DzR/n1mt30Iu1dLK9id0jPkOHjCc8jgNAQE68iPjZzADq2YC6
 /Kx9Cw1DTz6EvHrVKfU8PbLR+xex0rnsGM2/ihcnXJUduuXpFmH3Ega46jg8hDik0fzL
 W7wA==
X-Gm-Message-State: AOJu0YxDb0irpDWDO/zgr2yNDaE/MqLFVgYeZ3xHwW02DjIe5SrmNENw
 S4IzJ2KG8g9aKK4VaCAildKerIo4CbZaVGyPZEFkJmA5krgR40a2KlsTFYqwatfV32yYV3Sjj0M
 d
X-Google-Smtp-Source: AGHT+IGmV8x5KuhZ5R51N6j7JMjtW0dylc9yA/3VJZgcY0mTM5L8x1FPYXDzgsGfbYiXeX/k3VGr1g==
X-Received: by 2002:a05:622a:28f:b0:454:f3fb:2bff with SMTP id
 d75a77b69052e-4565ffd9defmr4014981cf.15.1724690359735; 
 Mon, 26 Aug 2024 09:39:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c5646sm44308001cf.94.2024.08.26.09.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 09:39:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] doc/develop/sending_patches.rst: Clarify when to use which
 branch
Date: Mon, 26 Aug 2024 10:39:17 -0600
Message-Id: <20240826163917.2786791-1-trini@konsulko.com>
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

The previous wording on the paragraph about what branch to use when
submitting patches did not reflect how / when the next branch is
currently used. Reword this to note that master should be used for bug
and regression fixes, always, and that next should be used once it
opens, with -rc2.

Reported-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/sending_patches.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 3f25b1d0466f..82efb717b179 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -74,11 +74,13 @@ General Patch Submission Rules
 
 * Send your patches as plain text messages: no HTML, no MIME, no links, no
   compression, no attachments. Just plain text. The best way the generate
-  patches is by using the ``git format-patch`` command. Please use the
-  ``master`` branch of the mainline U-Boot git repository
-  (``https://source.denx.de/u-boot/u-boot.git``) as reference, unless (usually
-  late in a release cycle) there has been an announcement to use the ``next``
-  branch of this repository instead.
+  patches is by using the ``git format-patch`` command. For a patch that is
+  fixing a bug or regression of some sort, please use the ``master`` branch of
+  the mainline U-Boot git repository
+  (``https://source.denx.de/u-boot/u-boot.git``) as reference. For new
+  features, if the ``next`` branch has been opened (which happens with the
+  release of ``-rc2``) that branch should be used, otherwise ``master`` is
+  acceptable.
 
 * Make sure that your mailer does not mangle the patch by automatic changes
   like wrapping of longer lines etc.
-- 
2.34.1

