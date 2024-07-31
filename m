Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD74C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AD688A94;
	Wed, 31 Jul 2024 16:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f0BF0qsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3460388A9D; Wed, 31 Jul 2024 16:44:27 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCDDC88A92
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39ae7b28dadso3119715ab.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437061; x=1723041861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heeNVSuPfmKGlf8ZfBiv+awmb/TEadwE07nfjXnqUpI=;
 b=f0BF0qspHDs5jz+LmoWtIZJmQrda9tF+2Th80yN4GngMgqwihzAQiMnYUWl09b8+lg
 PCpIvJ0FpC1ReFBtqMeacnKKyZrI2Bd9CLrAKeVlqPBWXXooGBqvbxEoy1jnuyK2DgTW
 1nkfu+sKe/1+1pA+20qUxrDT42mX062ICc9Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437061; x=1723041861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=heeNVSuPfmKGlf8ZfBiv+awmb/TEadwE07nfjXnqUpI=;
 b=sQKem1YjEWsGiLuumDjkLIK4zfqSDKzDdJj8PCv1FHTGXb4e9quzAXf6rol9xcvLBF
 sDaRMeRBYYvZVG+qn0XAQQW5lihAbw/c6fvskWNtBc+wjsZuYDWdVKbpQxLrJwAUY2k3
 GA5PEhOz0q9WAysLv+Di0m0edK4zEy9TnjiLPs4NdRsk8oTGcoizQt+Us8qFJSks0AP1
 lVkTBe1Ycpa3c2wzzYpcJAqvQb9h2Ei+RSz3FevxzDM8HM80uJueKnKz8oC7JNvWk0r0
 t9NiFlHeXYACK1/wOOhjotFGwFwoHbyN/Ijt5qfsmGGpuv1uxFO7vPi81K53/5MO9IqA
 qUrQ==
X-Gm-Message-State: AOJu0YwmVCaBh6Grs/aSJtVNPWMHv5U9ousiT6KhjxoflPZyTqPuSRL3
 /fgNOgGv47tm5YWsqmVuVQLeiHZXBJttLjTxn60s1xOj4Hhh0ZrzOSvRSmOaI46LM5b01AsMUTs
 =
X-Google-Smtp-Source: AGHT+IGX0NxEtflZ+dMCIn+IgaCgEIpCpaJKYYKRDUHQCzVhKSFrR/eC9MIPISKgMq9DnOJyrphSYw==
X-Received: by 2002:a05:6e02:1fce:b0:380:db2c:4d53 with SMTP id
 e9e14a558f8ab-39b06adb9a6mr38511445ab.3.1722437061481; 
 Wed, 31 Jul 2024 07:44:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7e4f9sm55575845ab.2.2024.07.31.07.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:44:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 4/5] sandbox: Increase cyclic CPU-time limit
Date: Wed, 31 Jul 2024 08:44:11 -0600
Message-Id: <20240731144412.790317-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144412.790317-1-sjg@chromium.org>
References: <20240731144412.790317-1-sjg@chromium.org>
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

Now that sandbox is using cyclic for video, it trips the 1us time
limit. Updating the sandbox display often takes 20ms or more.

Increase the limit to 100ms to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 87b0ec3ea8f..83c81edac20 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -636,6 +636,7 @@ config SPL_CYCLIC
 
 config CYCLIC_MAX_CPU_TIME_US
 	int "Sets the max allowed time for a cyclic function in us"
+	default 100000 if SANDBOX  # sandbox video is quite slow
 	default 5000
 	help
 	  The max allowed time for a cyclic function in us. If a functions
-- 
2.34.1

