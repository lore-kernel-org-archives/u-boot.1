Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9153C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 11:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96766811C1;
	Wed,  5 Mar 2025 12:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WenTII6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8033810DC; Wed,  5 Mar 2025 12:12:32 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B0980FB9
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 12:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30bd11bfec6so16409141fa.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 03:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741173150; x=1741777950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+C1RzWj7Noh3oKWNRCtYq5SrvGy2OA+IBxXP4mWWZ4o=;
 b=WenTII6cP2YD5/BxwflZ6fD8VsSho9Z2BQL0x1C6Fc3D/OXr4FuRZMzH2QvyshfZzc
 wtJVxOQaXrR1seUt3Xm9LBpRrhc0uBFBLsIsFgUnYZvm21U75ARj0YUjjq99q/t8J6Q8
 hmT9MRAa+7/Rl0jl3+iTUqRzqbQQ8Prg8jBGRifrHaMFuGCWVzZlCtclRFPJ+5vQpKsj
 2/rRFEAAnK2pBJ8nYZABF6SyIbIwi5vY2rSiu6AWu39GHs2DQWjerldQVnIDe5II6fGe
 5K8JLR0J/Tyf/pXsiQbpphuypAb5RP8fV+RBCWQ7suP1cCEU3rFgpMdfzbV4gd+yl+Wv
 vMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741173150; x=1741777950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+C1RzWj7Noh3oKWNRCtYq5SrvGy2OA+IBxXP4mWWZ4o=;
 b=MiIBvbhE+16SIQ75/1sDeCIHpR3ZcG1jwqQ13WCCQl+fxSBis0f4sdoB+Vrd9I/G0I
 ZK9pGWweg4wazJNCe22J84MbZNQ+6MUVTBD773Rxw/dauhXUjCwiMolAVBnhxRNYZJKz
 RKDN7bm6KGiJyBJ7UIAvghEPIvwU/EBhqF1l9DaE09kyX9+J+jwdh9tMJOjaB+p1T0TU
 UVRt1xz1DDc19WOvkgfwivKAGHHEnL9oBJE+L6l1gjdLVi9DldLw7cZZJ+27XEaXiCgS
 L3kfu7NCmv0Czp7fPWo8vR3ImoOV3DP5dCyXBZfoAte2QXhJUR/1gY4avwmtFlCfNE8u
 lWpA==
X-Gm-Message-State: AOJu0Yzp6L+a8zsicjcCDLHMIdOfhe8/6EdfzjW5sfbpZmEGFXh3tMQ6
 /wEAdZmvgAGv/Zegnk+9xhddpk1qH4UfiTtFpXa6kOuWmrBh0bc+
X-Gm-Gg: ASbGncvrb9XFCpLjbnolGxvK795X42M0vr8og27ylPA+nJNqaz/pLGVeuZKhWxiZL6k
 NqQ1yj62O6aqo2kx/sX6iegr6xbSR6RoXL9aaVglEgTErpIzahwdEFoMgsBxEz5zqCP7Jr2fGgo
 hlT9U4/gbUq63/67+5vYiErpGZR/JxHwl0Rlu/7v3yF3Vwq6itGWh95un13n6ewWdXydm4NoeAb
 TdP7Ii1KwRgPljC9BCBcpRoZRMIPkZMXQ9lpftQs1AHBoEzpUzCcjH3pQFyq6iltONfEgTD+UDw
 Q2ecrzbeDnwG7/MCxV6LCdhLEiDfTD6Y4Yv7
X-Google-Smtp-Source: AGHT+IFNjRGQVuaF2VcSv+9Ztg5jax+ABiJXoeuSTWnZ0RN79M07QXUk4EndTQIyfCKX7PiPmI6YNA==
X-Received: by 2002:a2e:b888:0:b0:30b:cd68:b6c4 with SMTP id
 38308e7fff4ca-30bd7a4f493mr11416131fa.13.1741173149874; 
 Wed, 05 Mar 2025 03:12:29 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30babec1731sm12490791fa.62.2025.03.05.03.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 03:12:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] ARM: tegra20: mark second DC with bootph-all
Date: Wed,  5 Mar 2025 13:12:13 +0200
Message-ID: <20250305111213.163428-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305111213.163428-1-clamor95@gmail.com>
References: <20250305111213.163428-1-clamor95@gmail.com>
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

For the Tegra 2, similar to other Tegra SoC generations, 'bootph-all'
must be applied to both display controllers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra20-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/tegra20-u-boot.dtsi b/arch/arm/dts/tegra20-u-boot.dtsi
index fa582bcb9fd..b74aa5bb0d4 100644
--- a/arch/arm/dts/tegra20-u-boot.dtsi
+++ b/arch/arm/dts/tegra20-u-boot.dtsi
@@ -9,5 +9,9 @@
 		dc@54200000 {
 			bootph-all;
 		};
+
+		dc@54240000 {
+			bootph-all;
+		};
 	};
 };
-- 
2.43.0

