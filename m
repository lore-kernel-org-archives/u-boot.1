Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A74E77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 608C2803B9;
	Thu, 26 Dec 2024 10:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IEqEoA0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055AD80362; Thu, 26 Dec 2024 10:21:10 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76C1980352
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2165448243fso85224715ad.1
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 01:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735204866; x=1735809666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9F6kZDg1ZKob/wWDs+iQYcRuzb5PERl6NHUfsvuNu7Y=;
 b=IEqEoA0g3j3rvtAWzuK6clsFfMl56d+LZbWUnHVf3GnpByJ9P9ITigqioiGZktSYT+
 Wqaosw67kOYrIK0zdyvTTszkqgckXkqjkLnKLAjqk0wZvVsy8lV8AY+wUmS5EMPPAm6E
 aUXba3GK71WMHX8eZJlqHiwKWCnJapO/xytdQYhgtDSyt8TtGNmzQUSGpV1lZsL4NRyk
 tlfF/+M9dUQF1/aU4bXiJrAByLNY2YHWAXdORYziKN5eN1kWpFJdKd8wfcOFIr0bHRRy
 R5gJGcBpJU/uQ2A80vdS5Tw40jQEJ7izm6v+3/r9M4sIDghgLo/J3ajvHPBM74L/JMvo
 jEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735204866; x=1735809666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9F6kZDg1ZKob/wWDs+iQYcRuzb5PERl6NHUfsvuNu7Y=;
 b=Cne5aIKPnBBsPP0hyERUpRpUnguvakX+0zlDdAmpuF3MLaF3AqnLdiPIno13Lkb/kC
 C31HOu3gahZiQJzbPpiORi4km5OVakUeNvcuOe5FfIDxNFAVDcBIuDzQdp5f8GnDaxFz
 MOj3rsXhYQndJnnpCnH7Z0i7uEUWrNvbVgdLpkxGHYs1mRY3jSkl+hC5cxHzLSaNXPE3
 YpEIRLxlX/VQXD/f+ozkZqsqMDAveesVabFLPWSscODYDQLNOdGNwcl5Tc0z6B1HIA1O
 Oara3TD5bHvBkubf9kTu42y/pVYgpr7ryMuRCb1M+Kv50mSen1IgbXEHahvyVf03l8lM
 dTwQ==
X-Gm-Message-State: AOJu0Yx3oIKUZBMc0K9OcIdalfB4IZGgb+ZJgYyLa4iu3wB5dtQH/QeC
 cT2IAV0t8XatS4oWd9zeA0bvsJ0QVkvbnL5ZEa0OxBHQc5GpJtgT
X-Gm-Gg: ASbGncsYSUTv/Jj2vQG4No6APJDonXKSoch3cKErvmnpmnzNGaPGuXZWDAAZ+BKDddc
 ZgXzCC2sXpfpdlvdmXTBUUXZR8NnnF2XPVYLrCkSIDIDtt7COTohl30TY9JwFa8Xg5xEEedMOaS
 jTTR+gk2d6BYA21i/n1rFDLmOkKT0obg4RaHtTXRGJfR9VF/3a5sZmJcT9u5bqQxxbv38Cmfz3B
 ei3ubYFGZ4e8ag6xKJzGq7SQr7wyBb/RfX/FVvYZyCvjCtbFXmh/3fMa/g=
X-Google-Smtp-Source: AGHT+IG42S9vvwNBJrsSOHDm7lJDf/BN2bY5taTkuODZLTaRjTdlrjmjA1SHpZOE1elLXg5II9VqRQ==
X-Received: by 2002:a17:903:990:b0:215:b45a:6a5e with SMTP id
 d9443c01a7336-219e6e9fdcdmr309663035ad.18.1735204865802; 
 Thu, 26 Dec 2024 01:21:05 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:5fa2:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d948fsm116347985ad.150.2024.12.26.01.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 01:21:05 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4/7] arm64: dts: rockchip: sort props in pmu_io_domains node
 for NanoPi R3S
Date: Thu, 26 Dec 2024 17:20:40 +0800
Message-ID: <20241226092043.419511-5-cnsztl@gmail.com>
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

The status prop is typically the last prop.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20241022193537.1117919-4-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 17e150fdd983c7e59b9240e34a166285f3c3fb39 ]

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
index 66a00cddda..243574f8da 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
@@ -476,7 +476,6 @@
 };
 
 &pmu_io_domains {
-	status = "okay";
 	pmuio1-supply = <&vcc3v3_pmu>;
 	pmuio2-supply = <&vcc3v3_pmu>;
 	vccio1-supply = <&vccio_acodec>;
@@ -486,6 +485,7 @@
 	vccio5-supply = <&vcc_1v8>;
 	vccio6-supply = <&vcc_3v3>;
 	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
 };
 
 &sdhci {
-- 
2.47.0

