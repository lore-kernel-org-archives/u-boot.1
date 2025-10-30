Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48F9CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 14:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CD883642;
	Thu, 30 Oct 2025 15:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zx+GoCm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE16A836D3; Thu, 30 Oct 2025 15:14:49 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3238334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 15:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-78118e163e5so1911086b3a.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761833686; x=1762438486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KHZrXkfhEEf1L0G+YF2m13btdDMYeXeqHG0smE3Wxqc=;
 b=Zx+GoCm1YlwnDfPs39eJLVT4z60bNupLP3EPoK3//KQaBNd4sYZ3cDwQU9lIoy5EBe
 YO5QoCysP/Z5At4jPr9Slzqw6wUFkWOngibVoiMoSnVZyrWnkM2sJAQi5L5UAG+Kk/H3
 cLPTeebp0Mafz4ZxxWaQHGy08qgrFXB/YdG54so7MvY4OheJ+TQTjhsaXkNJw0DxptEw
 rErR3YOzyqUPkvbLlHl/gen3rwl3rb058YWq9fDHxGOHcI4QZ5vFWyiB4iX6h2ugRfNs
 tVc1+hmk+KvcybAJgQOGFtoqtw6GDkhgC+YKq2fg6BB1Rcjszk4mUlR4oZTmpG1i3VB3
 bzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761833686; x=1762438486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KHZrXkfhEEf1L0G+YF2m13btdDMYeXeqHG0smE3Wxqc=;
 b=RFsZuyX/R+ZB9JJBg/2WPuCcBnFVCdVUefN5wWz7z5lNTUAIWc8ONwXwU7V75JqqGc
 w6azi0fLLEQs2mCo/MOhCigOgk7tmJREs3AeNLPHmegVuwCehQ9ibFIOy7KZXVjLeewi
 QE5acLUhRapzbCi6vzUNG8uiJcTKpXjxQin7rbXMlfJV3s22FlVT7G8VF9eRcSM0kKmu
 ZQFlrhoI2SA/4qSKqZDvLScAQyqxC1hEQ1hJXNNpij9MC1oUqzOAcxGuKhRky+1NG6Cg
 NlVf7s4+Y/jTGm++tI48SBgDH2GN63x/eZVBx7CtRcDLml4flzQiRlTdmjaMoEoVZT68
 djWQ==
X-Gm-Message-State: AOJu0Yyl6cedhWJabEI57rUfT5047S0wSmDAgM42OqnQfyVLwXHsXL17
 TR6fKaLgxCRhasTQjjB1JG6DrQpLuYc0nQyGIYYUenFU/11aC2zAEfcUr7dC2ivw
X-Gm-Gg: ASbGncvn114RsjKlif0C9alQ8QveRM+pCmHpOcXX8EuMItALfrJf5GVe5Hp559fSKzS
 83JGNP5+icWjJflAddHIcNvVju0TRX/lwGaQzdEqt1EdMm83WTb75YJRTWB1byO/SkmeEpVlDZz
 sSraw2oVVj7FPrCoNrbME40XTf17veU3AcXz03GxPu+MhqDgvc+p+jx9vOlOdis7KNN+NCAjmwJ
 BzGDvoJoIhIg7takWTGrK5ELwb5D3lhQ3NRpSt8Puc9jcX/4cdlS23yGPkKRH1Cj/hCvzU1e7vg
 NQ3bjMP96Duv/Z49dYQoitV3bfwY+62h/xwc9ODCfNAcKJlbLGMbPp4yDUheddD6SpR4X2BldOJ
 rxPtOoc7BVfhHK8hn4zuj8CRV7PGlSHq/I+MJlfCv5CiVQo4lNSe/J44Hyw8r3Gcq8zANVSzuhr
 9i0DbD8LGbDIuCdw==
X-Google-Smtp-Source: AGHT+IFWyTVwCKznh3pHqytYWCw4mgNqdou2zEywnphthEftpt0nOCMNoi42JNh6xdMiq3evLstMKw==
X-Received: by 2002:a17:902:c405:b0:293:639:6546 with SMTP id
 d9443c01a7336-294ed2a060dmr39490585ad.20.1761833686069; 
 Thu, 30 Oct 2025 07:14:46 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:155b:41c3:7f26:1bff])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498e50dd9sm188165795ad.111.2025.10.30.07.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 07:14:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx8mp_evk: Fix typo on maintainer's name
Date: Thu, 30 Oct 2025 11:14:40 -0300
Message-Id: <20251030141440.250629-1-festevam@gmail.com>
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

My last name was misspelled. Fix it.

Fixes: ae09edaeec3d2 ("imx8mp_evk: Add myself to MAINTAINERS")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 board/freescale/imx8mp_evk/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/freescale/imx8mp_evk/MAINTAINERS b/board/freescale/imx8mp_evk/MAINTAINERS
index c2c7c830b5d2..4419527b8bcd 100644
--- a/board/freescale/imx8mp_evk/MAINTAINERS
+++ b/board/freescale/imx8mp_evk/MAINTAINERS
@@ -1,5 +1,5 @@
 i.MX8MP EVK BOARD
-M:	Fabio Estevm <festevam@gmail.com>
+M:	Fabio Estevam <festevam@gmail.com>
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
 F:	board/freescale/imx8mp_evk/
-- 
2.34.1

