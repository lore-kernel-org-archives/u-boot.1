Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D3C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421E6864C4;
	Wed, 23 Aug 2023 19:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KcdJASet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4659E86411; Wed, 23 Aug 2023 19:59:33 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E3D186413
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a8586813cfso591179b6e.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692813570; x=1693418370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKsxLYj1wrz1ECdDBW3v7U6rJzAGbQ/8t1WvKyiJ9yQ=;
 b=KcdJASet1UctlhVHOGdxjlX9Yxs54PmmlS0s9E/ZN4Xj8Gp2RWDfac+6WEItwA1ozd
 7UwRsAIy7vdf1BrBW3zqfEIDsnod6dpxbR4nNnKyp1XPtGzvj/Kfw8vzT14WlA1cg1gc
 c4RBjyxZcg3buh46UKC5w4+1jH/69v+3xLUp6XN/QWRCONqdOeSmmuh9Lk2+gy4yRGiN
 BE2xHALP8FQQJ3WcyJb/5J+QuYZ0l7xjSv4InYzPT8vvA9BTzg5t/G2ACDnSrmttUacm
 VzEccjfHo7OpDschWmVC1hyA3BqD2AhmzuiqOsPYFakkFFCct+XTrypJt7BTXFEypRdg
 LEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692813570; x=1693418370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKsxLYj1wrz1ECdDBW3v7U6rJzAGbQ/8t1WvKyiJ9yQ=;
 b=DqYg8Nrtwxoj/T7Rd8iDWOVPx3ywM26aLN4JeK4ASpvtUMHF9XmP36AsXwqeXVXFu7
 3N3yOkjXp5fbwlxgr2mmKW4lEJUBKX4F2Dic77VZ8BV97yw6XcSIoWQLG6EpJgvoIO41
 I8IlP83QFUx88NaWSo3FtPmlTa2PSgZBnL9do2U/RSclbwdsA/9+/htj8Nh9uvAn3seQ
 nTGLcjmOstggFf/DroahoOeThuk5G6j2fl5pIoHyTKbKi0dCiagYEUskge0SIvz7xhc2
 5iO8yApmdyHImczv0fNuoDO9cZ0CHLRjvWFqBYVc9GvUqAsgm8sfQixWu17a2NO4eq2Q
 qNaA==
X-Gm-Message-State: AOJu0YyvjmUQ0GPhc99dZpWSWzdAXD8XX3U5p3eHva7Tuz0DyQ63+aqA
 SL/DIowdsVAwWdQZDNpmdsY=
X-Google-Smtp-Source: AGHT+IGBseH+G3inPoTOPZoLb8dUf/n0vOQO0EISd3ZnEpswo5+8UAgsFrtVyExuA9fZ/55rl+Bvxg==
X-Received: by 2002:a05:6808:3714:b0:3a1:a62a:9ed0 with SMTP id
 cq20-20020a056808371400b003a1a62a9ed0mr11763452oib.1.1692813569866; 
 Wed, 23 Aug 2023 10:59:29 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b51c:1cae:f70f:7819])
 by smtp.gmail.com with ESMTPSA id
 17-20020aca2811000000b003a842626b62sm5625271oix.22.2023.08.23.10.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:59:29 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 5/5] thermal: imx_tmu: Increase the polling interval
Date: Wed, 23 Aug 2023 14:59:11 -0300
Message-Id: <20230823175911.319414-5-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823175911.319414-1-festevam@gmail.com>
References: <20230823175911.319414-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Polling every second to check whether the CPU has cooled down is
too frequent.

Allow more time for the CPU to cool down by increasing the polling
interval to 5 seconds by defaut.

This value is used in the absence of the 'polling-delay' devicetree
property.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- None

 drivers/thermal/imx_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index f79b583811..15e01b6166 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -37,7 +37,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define TER_ADC_PD		0x40000000
 #define TER_ALPF		0x3
 
-#define IMX_TMU_POLLING_DELAY_MS	1000
+#define IMX_TMU_POLLING_DELAY_MS	5000
 /*
  * i.MX TMU Registers
  */
-- 
2.34.1

