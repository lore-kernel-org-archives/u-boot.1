Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7B0CA1012
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 23:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5972C8368F;
	Thu,  4 Sep 2025 01:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nicvptmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB4683655; Thu,  4 Sep 2025 01:43:32 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BDE83621
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 01:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71d71bcab6fso4834737b3.0
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 16:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756943008; x=1757547808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQDL5CdjT75gKD9yMyWCKpsW/vbUVA2PWYc/YCPlmg4=;
 b=nicvptmU8Mb1kMyqecnnTZQz3FN9gYQ/AyTg6vZyrxkNoYMPvxyFDjDzCrrYPYe5EP
 7Y/Zf/DBEU+XLvwLGmHW5nyUGtXw6r1kvIGxr9xgZw64Z38ij/8N6wh7a/wM2iu3oWlq
 ZhVUuojTnJQNFqhUR9ZypSpReE8tn9oQ7D1g3R5ycySUtu4LcrtlE0k9msLDQCwsu6mQ
 2gNBjvnXdI27E+f+r3ru6IBZwJBvgXMnQFAfjiJ5kFQ11H7nHZp5dhwZ4fiMQJ1r8ZvM
 2iFkIM1NX4myvC3SIwYkgMWs3diDWW+Rg9L+HS2e3Ub5yp+6p+FYKshLnxWLhfoyFStT
 qnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756943008; x=1757547808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQDL5CdjT75gKD9yMyWCKpsW/vbUVA2PWYc/YCPlmg4=;
 b=uh7jBNKFL1yRkfJrZ4upjxTgavDAjSpjcCXrpbSmC80LDJWdfv9DmojSRox/s90Lkz
 V75h12ovbO5MoFTn1C96kzd3TQHWzCylR6QvUXtkTJOQCgc4767UbvUXjaQgk7vvpFQI
 fVpikMR8fksorDMUppisXI0ZqkyNO2IdYeqxZiHHQbmztTsifIVbZF7ZXrXS4vH9Iano
 1AasFyj5dS+EIyME2Q+atLdAkOROg0Cqhrp4N0YWQdNO48xl2ZITqJmHlJq+u7qLbSlQ
 CjiqmDu4lnGZ+y8uKmd6Vw/2CJE8YR8iGqmVD5Ep4qgFpW162uDU4zwrOJzjU3AcKy4P
 pUgQ==
X-Gm-Message-State: AOJu0Yz66O6zsUP+WbRG3AP9Ns3aEZKSFDlzUpThfWHXt/L63r57ZNVa
 15wWesDMu6DFjsbCDkVABJ4WVYH1rzaF5BPiKmOfKgWxolHkVcv+Aqo42+Xl
X-Gm-Gg: ASbGncvzGmXmQ7ukWStu0jb0Wb5PZEUaL7j4MlnJNnLqRJVY/BQkivUAiJrQRpzkFLB
 h9mu02mI9h7URs06/tMw1hZnmZ2tLsIivQi9MznkBuI3nw2Pf1MpUPCaOFdmH4red0DKecGpdIx
 twz5NUmX++F0WVBe+qdmvBgUA7ij28pr+ap/JznrOx2jZsZ+NhDmCoDsGYWa+2g9WuK4BhqiSyv
 w5Dn8wJAPhiKm16EXKNfV6rF/7sbrvpyiNtn8p5trkwAqASqmD5QaUgTaDdGOMmGrrE7DhsTLsa
 3Fu9oTjRs/KJ1E3JZOUlLplh3fRPVE9IdY/sSA1baXGMr/zgPgzBaBUq5Dk7N8UdxZfE/cUO618
 BDAI4c3bAh6+Oka4o7sL3K2CqFLwMlJ0A9hO7tjWFDR2l6bBG
X-Google-Smtp-Source: AGHT+IGpdiEna4bCYeL/JK2ajQyvWBFNGpanzdxktBimgp/GK2K4mVNfmiN+E/7EMkEshR3Ogp54LA==
X-Received: by 2002:a05:690c:998b:b0:723:bec8:1102 with SMTP id
 00721157ae682-723bec81178mr41884797b3.14.1756943008547; 
 Wed, 03 Sep 2025 16:43:28 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-723a8503a61sm17044997b3.38.2025.09.03.16.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 16:43:28 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: philip.molloy@analog.com, adsp-linux@analog.com,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 1/2] net: dwc_eth_qos_adi: Add missing header
Date: Wed,  3 Sep 2025 19:42:01 -0400
Message-ID: <20250903234205.26787-2-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250903234205.26787-1-malysagreg@gmail.com>
References: <20250903234205.26787-1-malysagreg@gmail.com>
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

Following header dependency cleanups, an implicit dependence on env.h
was exposed in dwc_eth_qos_adi. However because this driver is not (yet)
enabled in any defconfigs, build tests did not identify the missing
header. This adds the missing #include so that the driver builds
correctly when enabled.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---


---
 drivers/net/dwc_eth_qos_adi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dwc_eth_qos_adi.c b/drivers/net/dwc_eth_qos_adi.c
index 0e6a901e303..fee50a88156 100644
--- a/drivers/net/dwc_eth_qos_adi.c
+++ b/drivers/net/dwc_eth_qos_adi.c
@@ -10,6 +10,7 @@
 
 #include <clk.h>
 #include <dm.h>
+#include <env.h>
 #include <net.h>
 #include <phy.h>
 #include <reset.h>
-- 
2.45.2

