Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EA1CF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E6D88E6F;
	Mon, 14 Oct 2024 04:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L8Np+czZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA51588F0C; Sun, 13 Oct 2024 16:32:53 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B8C88F6C
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c93109d09aso732639a12.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829966; x=1729434766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3awujzt+Q6jinYELEv7u2xUCSiyeA++C9/33Tb7AqE=;
 b=L8Np+czZK/Cwe+BgjFmE6Yj79cCgpiLyv85GJZmkpOJ3ee7o+22hj4CLV6aRoJXuMz
 cP8LlIFKxSEyIgNN6zknwmH4Icgllr30Diqy8iIIbUUq43WieFXM4e38iuP9NlHBTy9L
 rXyJk2n2nj9xmEfzLhljq071KdDP8z1oNi+OK1Pu23Yn3e5ppA33weMJpxE81payX2Kr
 6lWSosjLlRRL37AbFzs6fOO7Vot/QAb48pJYwkWtSce/vopBE3uzUJK67yI5TkCHMNWB
 gC3mLeGmDqWghZhDf8srLoYfJNgggFjL2OhWaUr1qSCowor0hb3dOA9Wt2b88ZNqatb4
 VTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829966; x=1729434766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3awujzt+Q6jinYELEv7u2xUCSiyeA++C9/33Tb7AqE=;
 b=vZS5JexLR9Z93lfMNMrwn7awS4Ww4iaX1uUO+MhYMbaiHmp1+F7amFpRexFyHsrLHE
 y9tAmxn5tx3hBeOQPV8GKZUoHKSFGLkje0+Mb2CorGk4qiNX54pF3024warIpYnLXUq8
 ZGJWxCDabufwJw1yhIzOqBpeKX8+xml3dh8XHu4UGNqgP/v6o7o1DGxyjfoTCkQdQDOy
 T07xZe2htZwd0N4ux85IPqvx87BFESf/P/RJAWn8QVAXCYecEsPSVONvu4szlnK9z/3Y
 y4VF35Iqje0X3g4o+FGlhyrpNKrxqOtBWll+T7fsj4Fv7Mcz+bZ0jcvTa2yjRHGbtk+f
 90Tw==
X-Gm-Message-State: AOJu0Yzep8O7UYrQ8f3wz/sYqycXQHu0Vk6tdBhp2lx9OSuRT258EahE
 ti9qQ2m0uR+QZs2e3rG6eCK8zU6v82R4S3Wl7ncxPPJBqz1WxqMABjPb5Q==
X-Google-Smtp-Source: AGHT+IGwFsJzdqlF7qUPj0WQikyfPppqViALik4eOHOyyNIoREeb3+eEKfINYEa9Ag/2lDsu9Luzgw==
X-Received: by 2002:a17:906:6a1f:b0:a8a:93ce:d252 with SMTP id
 a640c23a62f3a-a99b945dd48mr355857666b.6.1728829965918; 
 Sun, 13 Oct 2024 07:32:45 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:45 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH 08/10] misc: atsha204a: update kconfig description
Date: Sun, 13 Oct 2024 14:32:30 +0000
Message-Id: <20241013143232.2090645-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241013143232.2090645-1-l.rubusch@gmail.com>
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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

The atsha204a crypto chip is not only on the Turris Omnia board. Extend
the description of the atsha204a kconfig to cover also other boards. As
an example the Enclustra Mercury+ AA1 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 90fa8c9eae..6009d55f40 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -73,7 +73,7 @@ config ATSHA204A
 	help
 	   Enable support for I2C connected Atmel's ATSHA204A
 	   CryptoAuthentication module found for example on the Turris Omnia
-	   board and Enclustra SoC FPGA boards.
+	   board.
 
 config GATEWORKS_SC
 	bool "Gateworks System Controller Support"
-- 
2.25.1

