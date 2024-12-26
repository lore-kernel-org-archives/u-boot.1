Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF33E7718E
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646FB803AC;
	Thu, 26 Dec 2024 10:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q0j+DY9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDECA803F0; Thu, 26 Dec 2024 10:21:14 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A9E803F0
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2164b662090so63768005ad.1
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 01:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735204871; x=1735809671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XloW8ulLLK+nAz+2xmgtHdajYel8vrbVmA/Wt/sjb+E=;
 b=Q0j+DY9ijtClB+rWK4nhhF0m4R4Q7mNxQZus6edXk4LB5vzussTuCd3+u4wwTXWHEw
 25Qxlch5M9lihSPyVh0YGz3tydFsJzKliX6F899zEkMYGHwHMhktRMNPVZOxsIJqo6+k
 1offRic6uNHSr3Gv229qAj7/xH89mLAEpp41wK4q22GidxdWqfo4ks7F1jR01ZNphpdL
 XHV6X+CLUYb6iq0HQbererq2TwLeSYGmnxFzn1V4FP5dnkOLBK7NcsJCiqZfUfNKJZUZ
 FkR4OJV//laB4FZW3pnnWC/leQbUeXDdreXjd+TQEfFBqDn1M1HqMPzcQgiKvnwEf+qN
 tX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735204871; x=1735809671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XloW8ulLLK+nAz+2xmgtHdajYel8vrbVmA/Wt/sjb+E=;
 b=F1RR1h8pSPjQ6JoAIHeyjN2KaiXRSIhzcMjCk2lhpk9xLUUAeQR5KHcIWB36adK/sy
 8KhezYlpup7QaRfbUO84ZjZ/tyQrJxCtgcojbG/MHp5ZD49FRcbUTy/87CXjtzfNvFgM
 kewI7I1HoHDOfGzWLxQ+hMwxs74Fo7Q1KddLEvr85Hu9FdNeBpHT+ptweeEVVTm99FqP
 YzNtgKytlL1moFrUFpXOGKWt9PYJN91ntWIulh68lTLd9VVrONE5VVurVoKvK5/QLPgT
 5bSt8AeqZZCYmTLUHZgM8lFWu6K1xZ/mpIBS81XxACvOqUlxo1GMSJ+YPODv921FBfrs
 LMpw==
X-Gm-Message-State: AOJu0YwyTSuviddzSQc79meLe+xc2QbmW7AIYixTscT3IbYfiWXXBXhp
 kKL5+wiMFw1iDnRC7ygloRtRWugKijp5f+6g7+xdal2A7hZ5Kqdv
X-Gm-Gg: ASbGncsGyG2xkYOAp2gIycQ7X4012vV+oef2iZqt7iAx7hyjwOjojKfYMKQgpUEDCWS
 yekAawKht3fp1gmKlb2hhwdbF7FzTZSx0QaUjZL4nmmiCr6Uc3ygbmwl6zhiYO5aUWdIAMw7Nxq
 wTpbNprAMK8oAsctLAK3G84TS7KZXGfAy6gNp4kM2vSQTJJEsy0/ZN5BNO/L5vFGsZm6p/eF/5a
 2GljrA6sBOhwfi/pKM4mXzURVFKzusdSO91d2xXeDWy3dXWq2oMX4poLO4=
X-Google-Smtp-Source: AGHT+IFYahrUpgbUrt2V+CIOHxLTIIuHdrzQ5qum6b/B5HcMRnzVJVobwgRoAIZNDlhxrpLI9mgyAQ==
X-Received: by 2002:a17:902:d48a:b0:215:b8b6:d2ea with SMTP id
 d9443c01a7336-219e6ea1cc6mr276755445ad.15.1735204870704; 
 Thu, 26 Dec 2024 01:21:10 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:5fa2:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d948fsm116347985ad.150.2024.12.26.01.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 01:21:10 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6/7] arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
Date: Thu, 26 Dec 2024 17:20:42 +0800
Message-ID: <20241226092043.419511-7-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241226092043.419511-1-cnsztl@gmail.com>
References: <20241226092043.419511-1-cnsztl@gmail.com>
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

Typically any non-removable storage (emmc) is listed before removable
storage (sd-card) options. Also U-Boot will try to override and use
mmc0=sdhci and mmc1=sdmmc0 for all rk356x boards.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20241022193537.1117919-6-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: b7cd1115456d312f8c5e60c80fdc35fd35ea6eab ]

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
index 03a2f90f62..fb1f65c868 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
@@ -22,8 +22,8 @@
 
 	aliases {
 		ethernet0 = &gmac1;
-		mmc0 = &sdmmc0;
-		mmc1 = &sdhci;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc0;
 	};
 
 	chosen: chosen {
-- 
2.47.0

