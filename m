Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCA7CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF38388E4A;
	Thu,  3 Oct 2024 17:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nnU3gXBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF2688FB7; Thu,  3 Oct 2024 17:48:09 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51E7888FB3
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37cd831ab06so718826f8f.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970486; x=1728575286; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZC92AK9QFMeBTvjPvqAL1mrcoaCnTtYTGzMIvPRRJuM=;
 b=nnU3gXBVtKyF4QVBz9muQUScnP4UOYqscfQU3JvoFSIzzRZJDz4//xAjoRUKhAuvyv
 dOGFKS27FOpZdhEFTy/rB1g4j0ze1E2Rs9DRNdgSmhqrxmpLmLr5qBPNSUYYHIwcntIQ
 4uSd6j2o3K2HCmRAP5PXqeElT0jaQ67GWLLm29cznqtNn5pAZglkXCG9nX+Pf3Uk9vmA
 FfthCIHGTWtis+SSgJQqh9A2RrOsV222vZAoLAzvMKKykXJ+KfXNK7o7+ZGc2iP5vOS3
 LgFS8LubgTSN8i0zfBnbfyLhE/EeDqsosB0FKf3lU+V4jPaS6quhSvPfE6otQjCc8Us/
 CIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970486; x=1728575286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZC92AK9QFMeBTvjPvqAL1mrcoaCnTtYTGzMIvPRRJuM=;
 b=wTbAsA4qGimZvTLDRUuXojosPEA8tTwF/RHiSzgjg+uPrZdqMRurw8xOa/cPE4spv2
 y5eprjEMLFQz8XjRk2VEVdT7rmyi7Wy0JobJCcLnf3dDOfaPvo8dx/xBqXfwEAO55/Q+
 l/vH1S+4235ZbK8McReu3NKiMr+RK1nPOuXtZfOEhIzcFLhAnzF6t2az6umk3T0CIbkV
 GWN7QLRPf2J/Rvk4jy8XX7pFHshyz9CRrGRjbrpHRDrwFB3We87HcJEr4PGXpJ2dir67
 HcAeJOts7oRVRsmUjaJjK1cA4o6/6xVGOGbv1PpZoJdmJNwZ9Kjq6oY6IqI6LlukPm5v
 f/tA==
X-Gm-Message-State: AOJu0YzmQhqyIKlLNW3YZm6Za76FmW/LzelH3EgLqibInz5Tzx3c+sRH
 +OkJhAOM9VHjPGuEDjLnWxuwW/XSX2DO/hVjq+M0Oktt+avGe+FQHa0bQwcXfILJbh/qnScLK1x
 vUVjV0T3+
X-Google-Smtp-Source: AGHT+IEbrpW4IcuK6Jt9xBiKgoci7u1uo8x1clTZ6NqUdYXVaYhwLRGk2qmfaGMxGsh17QkKQD9ONQ==
X-Received: by 2002:a05:6000:e11:b0:37c:ced1:dd06 with SMTP id
 ffacd0b85a97d-37cfb9f9ccbmr3984532f8f.41.1727970486523; 
 Thu, 03 Oct 2024 08:48:06 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082d22f3sm1531036f8f.103.2024.10.03.08.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:48:06 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Paul Kocialkowski <contact@paulk.fr>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Greg Malysa <greg.malysa@timesys.com>
Subject: [PATCH v11 29/29] [TESTING] Kconfig: enable NET_LWIP by default
Date: Thu,  3 Oct 2024 17:47:52 +0200
Message-Id: <98207226ad5531b97db1b3a8d798fa9f94877ce9.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

Enable NET_LWIP by default for testing purposes.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 9e3a55798f9..0ee281b4574 100644
--- a/Kconfig
+++ b/Kconfig
@@ -756,7 +756,7 @@ menu Networking
 
 choice
 	prompt "Networking stack"
-	default NET
+	default NET_LWIP
 
 config NO_NET
 	bool "No networking support"
-- 
2.40.1

