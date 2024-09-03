Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D112CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FDF88D06;
	Tue,  3 Sep 2024 10:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SU8eWLyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2439888CFB; Tue,  3 Sep 2024 10:39:00 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F8C288CEB
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42bbbff40bbso33100155e9.2
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352737; x=1725957537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Y5IVVMRA6huUAqoPdum8k+WQjyk5hjB1KqdHDqrcgI=;
 b=SU8eWLyxJ2vJrWl6isECH3Fr0p8WnrfTXuvN/U5OC7++zPFz72KEqHELyzl59xQ0tM
 ZNYOZAugNld/d5u2I6F/+8kzCtev/JAOzVF+Olbn+V7XSAAPTvGMFRl2ZbredNYUY0Qp
 z2UGQ9/Plqjk2zkHkHZr6KUfsioJCTZb+I3ASLMklK6nGKKEAdogy0PHG3/RHQFprZXX
 p+diwCmKy85w8YM4hZycrsVoQSQwwEcI6raOJUndj0Gzaxi55THmpH4ulLO5PwjOAKse
 6B2uDhQjB/LTnQ/DjQz4dNKyK8aEA1EgNknCHYJSMDhMw2FPtu1VxZqKpgJeHs9UlQJ0
 TO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352737; x=1725957537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Y5IVVMRA6huUAqoPdum8k+WQjyk5hjB1KqdHDqrcgI=;
 b=lhqZQkqzgFmkJvsVPq4Ll8WdpLUe9Y5Bmanac6JGLiYFBABX8SWEGdoXT8/DQusdCg
 n01AO3g6GT4trrnWdSwFckah6Lef95kn/1rdFIFvf1LwYTF2mTmenJjykBXCHgadfcGq
 c6lqVx2GjZlsSK5vdthEieBvspuEmmc5Ddf8YdnUVhDkCxwHg/qZ4+tGG8jL6cSf23Tf
 whOuPj2r7Vm/SuCJkYB2/ochLEotgq2LVOgqrq/vZRBEPROA/ahnLfBGpVgU5XV0Vn7Z
 zicad9YOYeW29aiz6Ary/HQWQ9S+vMWDHM8Kr7abWQGvu9GIi/nTmahRA108nZkJ1saL
 1lNA==
X-Gm-Message-State: AOJu0Yw5gBVEDwxbE0V3lqEau5H50SOB/k/bAsfQ/yaqjWM23x3uPRDQ
 y0rfJ8GZYUYNa9wyevD/K+tjYNbSEFkPqdStJi+82OeYZOwDm6+lQ8dtqbxVJm/yo9JNLPptz1J
 ujv3w/2a/
X-Google-Smtp-Source: AGHT+IELThtGlwO4T3qjdLqM7qotUm7lqfiNiLLjsDKrP3X5GbGloYz/W661kv20rM2WRgcEGosD/A==
X-Received: by 2002:a05:600c:1ca0:b0:424:a2be:c161 with SMTP id
 5b1f17b1804b1-42bbb216f26mr100644745e9.20.1725352737525; 
 Tue, 03 Sep 2024 01:38:57 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:57 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Robert Marko <robert.marko@sartura.hr>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 09/16] net: ftgmac100: depend on NET
Date: Tue,  3 Sep 2024 10:38:06 +0200
Message-Id: <0846c275880af61c3bf4341ca979ed8cba509cfb.1725351676.git.jerome.forissier@linaro.org>
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

FTGMAC100 enables drivers/net/ftgmac100.c which uses
PHY_INTERFACE_MODE_NCSI, which is defined only when PHY_NCSI is enabled.
Therefore FTGMAC100 depends on PHY_NCSI. However adding such a
dependency causes a "recursive dependency detected!" message, so
add a dependency on NET instead (PHY_NCSI depends on NET).
All in all, either the stack is NET and FTGMAC100 can be enabled,
or it is NET_LWIP (or NO_NET) and it cannot.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 69ae7c07508..3382e533f42 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -461,6 +461,7 @@ config FTMAC100
 config FTGMAC100
 	bool "Ftgmac100 Ethernet Support"
 	select PHYLIB
+	depends on NET
 	help
 	  This driver supports the Faraday's FTGMAC100 Gigabit SoC
 	  Ethernet controller that can be found on Aspeed SoCs (which
-- 
2.40.1

