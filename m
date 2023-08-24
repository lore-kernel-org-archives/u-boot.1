Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0247BC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ACA186A60;
	Thu, 24 Aug 2023 21:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JbvbyrPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C42869A1; Thu, 24 Aug 2023 21:59:43 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9F486A76
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7927f36120cso1604539f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907178; x=1693511978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1R3zqWnGbT8o6q2UFtEnV1SGDMvXFkJW02x764+M5xM=;
 b=JbvbyrPLfoqG5um3WlO83jxF6Jq/z94gggwOyXG9E2uZJIgbqNWkAi9AIsZOLWCdBR
 KMGzP9rMAuL+tbeA1N2HIIUcqZbmn1SM+0pz73lF0XF2Zdldgynouv+ozz8T6zeMLS2F
 sBcnImZ6ZvJScr3X7CN29sSufCLmuSg/+Bi/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907178; x=1693511978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1R3zqWnGbT8o6q2UFtEnV1SGDMvXFkJW02x764+M5xM=;
 b=F5TZBNOc1RLimYrU7vG4MnZ7zxkUo4C2wFlXuFNxYrzCeFMMfyLZ3IIw1TDziYRCcH
 Tr4iGzaaiIzgwVCyzH67o9aMxATTldj8V3dlzxnMppoJnBxd4GvcqWfg6HzcwQsp4L16
 aKSe8k0vXBe9zWcfyv0eMwAVoX8GAV5ZMOQ1ZJxDDVZ/xwBvtyUvVd2SOg0HRRvX0MnL
 zU+TqLH4w1WfRbLETs/hkJOIhfkxydoYCUnwM9r0jtpz+3AO8BMswzQJymgl2a3tUb68
 AfuK4BmT+Qnnh8hviS2YLAbGWqUzXlhVkWOXyKWkLmJswg8o8dkVrscMqXy9tFVIwcWK
 9PSA==
X-Gm-Message-State: AOJu0YytaXawC0dAXWCqz5ZbaxlTUtEnAM17lxHzJqGqEWJ9mB7I0Y/9
 PLA047uhlXEV77vhESEvB4AfvzWWH5Vyv9zKjKI=
X-Google-Smtp-Source: AGHT+IHXahK97dh9BFrJRIy+1o5zpzChykv/PiWA5E99PqPlLnxC9s+u3GY+5u/lbbn9RT1J21fiuw==
X-Received: by 2002:a6b:7e01:0:b0:787:1557:3834 with SMTP id
 i1-20020a6b7e01000000b0078715573834mr6725356iom.20.1692907178228; 
 Thu, 24 Aug 2023 12:59:38 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 11/19] boot: Rename Android-boot text
Date: Thu, 24 Aug 2023 13:59:02 -0600
Message-ID: <20230824195917.1687886-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index daec68034c72..e378d9cdb4ff 100644
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
2.42.0.rc1.204.g551eb34607-goog

