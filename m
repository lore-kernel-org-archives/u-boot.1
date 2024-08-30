Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC143CA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 852ED88A5B;
	Fri, 30 Aug 2024 12:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yoLgV9by";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AD3C889E2; Fri, 30 Aug 2024 12:17:35 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1D5A88A5B
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42bbd0a40faso3156985e9.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013052; x=1725617852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PXek1QiSaTXGzLPU5w83EgSlCJRe9KxUW7m9xRW8TU=;
 b=yoLgV9by+fz7o8S0gwpkDkhNzOcoSxflbvyc5jRpq1TJCwt77ai1V6fKJLZPbgMBN7
 M4FWpH7C0K/orUuVBe0WhKsXXKTDiqDhYg0zK0Sfr4VT/yTLiTrH/KlQmgTLkZDoH3y/
 ooAjMo1QYqN/dHnQQLyrOLBY/+ZxZ2GRrlzt0mNzPO0JNxi68oWj16BzvgulgKCV3sfW
 3VOajXsjm0utr3lUEJ8Lib9t2LYuLyXZGPlVYddVAnlE8hg1R0Jb44hDjLO29W3EJPch
 dDMlT1ZohOsERdIzjx2+VfIvRwmdjWaSevbXV/AmuaVmfVhHTDEiaV3EVPkM3YezNz6c
 9Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013052; x=1725617852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PXek1QiSaTXGzLPU5w83EgSlCJRe9KxUW7m9xRW8TU=;
 b=lTGMictGhgnL8tBWG5dgmV1IyaKhqd58EDgbA/2Wnpsz8VKDcxLoTmVaiqhBNgEirl
 5C9hl88x3LcfHh/x60Ogte8tQIvb6fiUKPGgUXh34NjG6U1ejNZhfcSrxhakllY9TbBd
 ZD78+1uAjPClmFw1GykqiPz/BC6GEPX70VkJt+uWy3M1ezT1Q8Xd+Va6vrdT8sietzm7
 vIPVcyv1Z39zqUyNNZKkZdVh9b09PS034azoCbEga67/nIHKJcRXiLXzRxWgHip3JBUh
 VhjkLFRf0PaW+WGKUpM0vHm3YlEAOFlVXx2Nv3d9N1YXrvxP4UpdDxdh0dmq49Wn8rZZ
 u+Ow==
X-Gm-Message-State: AOJu0YybH540ZtC071EFsg8h1GzJNpSuk6pHnq8JpJbxwOidA/2xcyC7
 wsTlKV5lvaolhBvXzH84m6Ssq7jkGdE64v0cyHIIx+3NxLPPMXXQethsIx9q/e1WAS8HG18IAGD
 j/0eNUQ==
X-Google-Smtp-Source: AGHT+IEM3BVBxtsg7gngQIfDyOF3ItSzjIqU1MOAsaEezjjqbMkmK6H4Yinf7ea5R3lpaIvmknft7w==
X-Received: by 2002:a05:600c:3b8e:b0:42b:a9d7:93 with SMTP id
 5b1f17b1804b1-42bb032c82cmr48383755e9.28.1725013052109; 
 Fri, 30 Aug 2024 03:17:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH v2 08/16] net: phy: ncsi: depend on NET
Date: Fri, 30 Aug 2024 12:16:51 +0200
Message-Id: <280b503a9ddb304e0161bde467639f936f8efe94.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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
index 73064b2af6..a9efc50981 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -368,6 +368,7 @@ config PHY_FIXED
 
 config PHY_NCSI
 	bool "NC-SI based PHY"
+	depends on NET
 
 endif #PHYLIB
 
-- 
2.40.1

