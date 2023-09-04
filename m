Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E493C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA1786961;
	Mon,  4 Sep 2023 16:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KyaKr5yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 806AB8699B; Mon,  4 Sep 2023 16:41:54 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA2686977
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-792979d4cb5so74752939f.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838510; x=1694443310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PIAPesaOpNXNSlhGKNr5zIddHZer1idxhMa83EFFazs=;
 b=KyaKr5ypTzcpj7dJzvpBtWnfHPOkd2BB1XcatKsqJ1y7j5k6jzAa+/jv72vIjVjonk
 n03WSKCEneSbqp5FbwA4szucO20M9mCJ7gQF61Jv9MjLcDvl0F+8fmL40OLxee56KR2l
 2jy+QUEQfYNaaMwRwUCqeJXKbCrQxK5WkrD0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838510; x=1694443310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PIAPesaOpNXNSlhGKNr5zIddHZer1idxhMa83EFFazs=;
 b=g/tDJHV1pAmGPYOp3gqt9rAbL50W/nbIRCQEDGQ+dq68YbS+JPT0p2/2T31SwyuXlj
 oxtEUce9Vuew5QnDPVM6Asq8yGh+ThfSD7aUYr5+IePuneiQ1svXHsECcuVErlj7OAIe
 TQ0qFWpXjQSS5wuHrL0R4WQnWmK1IzCbJ8jdNYw1HHXc/cvN6waiF5oUwfZ5giUQJ1bh
 orNWnr5JWd6rTy88jjhr18DKJchfafK+gGGP05K05s4rZ0ynSoAGI26otg/1offUO+Bg
 MqpPocvKRTradd3Yy8cqhVjuqkuMUFVdnOSNDLaudDD20JrrpgW6m9ZqtOy4uuyvcKRf
 +MbA==
X-Gm-Message-State: AOJu0YzCVdI5s1V8ETM7BhFm6xUXoHOF4sGxIEgVKYhImJZkFHyKAN//
 rgynVrcw0kjeqGZrPwuYDlE+rWxxzig8hDa8wkw=
X-Google-Smtp-Source: AGHT+IE1ae5QCxEsVd8zJ38Qfj7wGR5arUBvsuA93jGL3g+xxJK9jHv1kXH/GPqkOpRoY0YfGTzQ2Q==
X-Received: by 2002:a05:6e02:1141:b0:34c:cb32:f799 with SMTP id
 o1-20020a056e02114100b0034ccb32f799mr9568966ill.22.1693838510187; 
 Mon, 04 Sep 2023 07:41:50 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 11/20] boot: Rename Android-boot text
Date: Mon,  4 Sep 2023 08:41:14 -0600
Message-ID: <20230904144131.2699824-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

Phrases like 'Enable support for' are pointless since this is an option
which enables things. Drop that part so it is easier to follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 70cbcc38fdd4..f603a64a23de 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -3,7 +3,7 @@ menu "Boot options"
 menu "Boot images"
 
 config ANDROID_BOOT_IMAGE
-	bool "Enable support for Android Boot Images"
+	bool "Android Boot Images"
 	default y if FASTBOOT
 	help
 	  This enables support for booting images which use the Android
-- 
2.42.0.283.g2d96d420d3-goog

