Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D107DCD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324DA88CAF;
	Tue,  3 Sep 2024 10:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mnzhrdo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A54888CEF; Tue,  3 Sep 2024 10:38:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59FE088CFA
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so42872155e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352736; x=1725957536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8i3lBROvhfrY82vIccP41xA0yhZbBOfEI92vYpX/wGs=;
 b=Mnzhrdo8CGT/KX99r609s9u6f7tIey1r17JO5FSQE+hzjr9bX0EfgCYfWU/1I+1NGk
 354k72FhQ+PHIGVf7Yy69MqSTd7LK9aMFhiu4qVjRCua/BNL/JHOp3+rGPWKuBOl8ytb
 NehThA00SuU69hztltkPb+2skiOuzKCWwP4SxGEHbBQ25kalsGAGV/+XUhbm96xmPxMZ
 c7Fl9Iel5xEO1keZUyXQhT6xJJhe9kg2OeyfGJ4sZLwitXpbcGmQiALnDSA6AxKaNgyN
 qwKZrBSGkBnt4qmWyNMKdQZSuFePKEK24BJ+TqtpM3rWmRM8Yl+xKmCylszToJ/NTUcz
 4kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352736; x=1725957536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8i3lBROvhfrY82vIccP41xA0yhZbBOfEI92vYpX/wGs=;
 b=g/GS/of/iry4FQUqzJQwQPbOW6RqQABA7eLf3pFCxLkQsGd3Z8wjTiv2Lz687jlJ9K
 t9dN+jceLZjZ2WAD+BiR+NzceAw+7MRApXkdSTX/p8O6LUl5EGD9o7b4DtwbvkADLjiv
 O2vGER9ttgIhxEJ2dlQJ5zdWIqJX6GCWRHecQoUzL8VBp/KE8hOfgtMl1t8nXyJRiues
 1W5Flx5xs+V8CqyYzmMnoanF0tJoE1zNvfblYsDvnuSiMsUGIck86vaEB/pzETPsRd2B
 ccpZmLcWRn4UzsHkXN7qVs3Dovvd9Wa0dqPfN/Vqbcf087J62CTbTCnDbyO6Xd2z5Mub
 RW4Q==
X-Gm-Message-State: AOJu0Yx8vg5Lxj6bZLReB9QiSC6iX0xmNuZpFKevueF8UpKhswTCNYZS
 VAQlpbCzZdqtgZDiLZSUpPlZwFT6AOqrBXdbmbmFl4DkSxifaXswdBeVsbPMrg5udG51Tbq6mHN
 x8RQMmA==
X-Google-Smtp-Source: AGHT+IGVk0DNukJ3ro45/H/9/TYhaxWDkXUg6UJsdQK36OgBiI9O0qDl7+nruIgo4rPxy2L08a6SaA==
X-Received: by 2002:a05:600c:4707:b0:428:f41:d467 with SMTP id
 5b1f17b1804b1-42bbb205ad3mr74959235e9.10.1725352736532; 
 Tue, 03 Sep 2024 01:38:56 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 08/16] net: phy: ncsi: depend on NET
Date: Tue,  3 Sep 2024 10:38:05 +0200
Message-Id: <7f3f18e266b64e4dc5ae77e4e342193fb58d31df.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

PHY_NCSI enables drivers/net/phy/ncsi.c which calls net_loop() and
net_set_timeout_handler(). That's the legacy NET stack (as opposed to
NET_LWIP). Therefore add the dependency to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/net/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 73064b2af68..a9efc509814 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -368,6 +368,7 @@ config PHY_FIXED
 
 config PHY_NCSI
 	bool "NC-SI based PHY"
+	depends on NET
 
 endif #PHYLIB
 
-- 
2.40.1

