Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E77CC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47CE384B77;
	Fri, 10 Jul 2026 20:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpfVcz97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B9D84B55; Fri, 10 Jul 2026 16:33:21 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6B484B06
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso973363f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783693999; x=1784298799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u8XXXXCeUj8wbSAQiJzSxWM77SX5Mvj8OcCAv89Bkqo=;
 b=kpfVcz97R80N0jiu9C9Q1TyJavNuWOA6LjlRzVTpRrsIYHpjBzkjVKzhbK9+I7CXWp
 8iZQ0tPNwbABp9Bb0e+54gNl1jSrqfrJe2knVUEhYx86IcdGklBNk9mULCwSU8Fx5yub
 omaWfCHWf/HnkdSYoJSnVjLmJOD5bM4mDnB+tczrZJ8bMNqEjuPP/WPKPxHnM4lc9uQ/
 AwzcuI6QMBKhquQnDgneWsRRx90SghR2yb/2hnKZlv7ALE+wSkBbQucdBKXgwwNBWl6Q
 Wqajk4w7jnFDOUAszXl+WI35aC9pBKQqKCOPPcqZ7IrTYwR7d1775yiDno8iwlhNCUTI
 o4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783693999; x=1784298799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u8XXXXCeUj8wbSAQiJzSxWM77SX5Mvj8OcCAv89Bkqo=;
 b=JhFQxym5pfNBcak0/2k8jitb88tr0Fggzx7U9uX3Dkj3JzhElFoRYipDHZUx9Q52ha
 p287SB8Fkx0Nrk9+FzSWybwt1UCMNd3SmGJDdAEAcEGu0Gp3G4fU8GE9wDWB07LxdO36
 dlyUyy9QkyNtOmln7or+G/DbmrzfwcfroBeW1c2cNyHKOGmJD21UalvkyQ2Xti/XOWsV
 mpZORhS5jkwteZGWYASxA0tt8QsPbGgmD8zdbKO+FQZOQuwvMUQPpejORhJf6toV77ZF
 9o9gpxanHcbXFlKr/bY3l0NOXNVXrejn2H6VQyUcZC6ZVw09vgyt3y3ZMmjWxzETUawk
 3pUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiuNy6Jnc6NLt9nHg85zDP56puGGJIBMgQDK+Am7n0JwFwlfqDZKgfov0M4rojGUB1W2OgiDg=@lists.denx.de
X-Gm-Message-State: AOJu0YwBYvK908WDx3246dVD+3emi2pUvNQlmM8Kzsd4yJomdO4mfu9Q
 s+q1tmE5vyNiPVUThHfJioU6QylZ9wHMzjQ8PMTZ86ao9HuE/Mt05PJV
X-Gm-Gg: AfdE7cmPOU+noOXKZk3SVAbL+lXAG0FxbAIkN0QTsAk7iR8i6LtmQkj5AOerkWHbERR
 /1iuIOAut2n/AjfFOyBBuEi/j6kR3MXmeRZiB+qWGfehaPLruhS+CeG1S96dOpEJ1iH97nzjmyJ
 hkq4Gv6hwqtKJtKoJvpY/rFJIU3rDNgTG+htiINBf/mU5knwSses2iFhjsQu388Lk/UN/CxTdEs
 dOPzpYOmK++7EzbDy7110HdbzAMfsfh5aqJJoUTwBlcqmdNN58L6OcztMOb4UW7xXa5SiNju/MX
 JK4JJH6yiD/uPmdPi5FptFihwehEvOMBzneNeTMUmn4iJAC7MsWV8oiOmRsf+kBbbxKXn/wvsEV
 rwvXyAWsIHMByT7vFOJbKACiNNjssGt4/J284L6aNvXzHeYMdUW3UG2aEO4XIZ4atcHVbvXe1Y9
 BGFJ/2
X-Received: by 2002:a05:6000:1ac5:b0:45e:f302:95b with SMTP id
 ffacd0b85a97d-47df078ba55mr12361938f8f.37.1783693998707; 
 Fri, 10 Jul 2026 07:33:18 -0700 (PDT)
Received: from vitor-nb ([2001:8a0:c4c6:f00:3cb5:ed02:715f:532b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm60549688f8f.13.2026.07.10.07.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:33:18 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 4/7] toradex: tdx-cfg-block: Add verdin imx8mp 64gb emmc
 pid4s
Date: Fri, 10 Jul 2026 15:33:02 +0100
Message-ID: <20260710143258.285091-13-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143258.285091-9-ivitro@gmail.com>
References: <20260710143258.285091-9-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:20 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Add the new Verdin iMX8M Plus 64GB eMMC PID4s to config block handling:

- 0236 Verdin iMX8M Plus Quad 4GB WB IT
- 0237 Verdin iMX8M Plus Quad 4GB IT
- 0238 Verdin iMX8M Plus Quad 8GB WB IT

Update the board-specific variant selection to use the Wi-Fi variant for
the new WB SKUs.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c        | 3 +++
 board/toradex/common/tdx-cfg-block.h        | 3 +++
 board/toradex/verdin-imx8mp/verdin-imx8mp.c | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 21baa810f2f4..8b4698e92e1f 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -195,6 +195,9 @@ const struct toradex_som toradex_modules[] = {
 	{ APALIS_IMX8QM_4GB_WIFI_BT_IT_64G,      "Apalis iMX8QM 4GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)          },
 	{ APALIS_IMX8QM_4GB_IT_64G,              "Apalis iMX8QM 4GB IT",                 TARGET_IS_ENABLED(APALIS_IMX8)          },
 	{ APALIS_IMX8QM_8GB_WIFI_BT_IT_64G,      "Apalis iMX8QM 8GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)          },
+	{ VERDIN_IMX8MPQ_4GB_WIFI_BT_IT_64G,     "Verdin iMX8M Plus Quad 4GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
+	{ VERDIN_IMX8MPQ_4GB_IT_64G,             "Verdin iMX8M Plus Quad 4GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
+	{ VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G,     "Verdin iMX8M Plus Quad 8GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MP)        },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index e6e726f381cf..4bf4f2e68437 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -158,6 +158,9 @@ enum {
 	APALIS_IMX8QM_4GB_WIFI_BT_IT_64G = 233,
 	APALIS_IMX8QM_4GB_IT_64G,
 	APALIS_IMX8QM_8GB_WIFI_BT_IT_64G, /* 235 */
+	VERDIN_IMX8MPQ_4GB_WIFI_BT_IT_64G,
+	VERDIN_IMX8MPQ_4GB_IT_64G,
+	VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G,
 };
 
 enum {
diff --git a/board/toradex/verdin-imx8mp/verdin-imx8mp.c b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
index 69c3408fbba0..1209da593f85 100644
--- a/board/toradex/verdin-imx8mp/verdin-imx8mp.c
+++ b/board/toradex/verdin-imx8mp/verdin-imx8mp.c
@@ -79,7 +79,9 @@ static void select_dt_from_module_version(void)
 		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_WIFI_BT_IT) ||
 			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_2GB_WIFI_BT_IT) ||
 			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_8GB_WIFI_BT) ||
-			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_8GB_WIFI_BT_IT);
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_8GB_WIFI_BT_IT) ||
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_4GB_WIFI_BT_IT_64G) ||
+			  (tdx_hw_tag.prodid == VERDIN_IMX8MPQ_8GB_WIFI_BT_IT_64G);
 	}
 
 	if (is_wifi)
-- 
2.54.0

