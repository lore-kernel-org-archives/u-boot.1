Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8C1E7718E
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9CF803F5;
	Thu, 26 Dec 2024 10:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G11GdiHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D221803F1; Thu, 26 Dec 2024 10:21:12 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B98580352
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21619108a6bso65022135ad.3
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 01:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735204868; x=1735809668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbaC7QcW1OKBSLK+eY6biCp2rt9/WSz48fj6wNdODXM=;
 b=G11GdiHh83IbH0oaZWCXRP3fLaQ18OCTtiq4XHig8ibZB4KDVhUKWAqBkc3YpLCRGu
 thCShTWhIvyVYZFY2Q4yZfc3qyCeRnmCINbUb9wd3iMNRLAEKs0aciimwUUqZfdWAyIe
 1568YGs8bQXZGzI7KfpZKVmjxb/hDAxoaldBl2I4xEW5C2avjZTqA98bvIaJ5CKRPXD4
 foIGj+m2aWaV0sOc6VYrDUruJ/AOMxr48d49VoqA1pORfzAQOw6uiOU7hUmGXcX+VpOC
 vCEQcwGMnsG3wnWo2o6RkRmavtDLXzJMys3RQgqZHbFJOZlWcJNJwlm4gbUZTGWElw6x
 uWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735204868; x=1735809668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbaC7QcW1OKBSLK+eY6biCp2rt9/WSz48fj6wNdODXM=;
 b=MZp6U8D1a0DE3UOIGKBxqpnmgWrYbgcJVUDRLlIYaNkfFOW4dGiXOPkzNpnZIBLa/k
 dqBBtAidpjPsRWv6DNN4E5Wh6tFLDtPhdDYo56ROA9FM6xHyKY7H6bX2gqmhN22kHmwp
 picY/ZIvcRYsqCT41IzehGq3GYiSo60rKYDjnRVo6GUqRgfbXcSUHGtFqM2v7fDj5wtq
 hwkvgJWTPax0jYSW8IFENdZm6HaY0w46PdkzEZ+z5ZKHk1LuFWjvYqSy7/hNJHVdZ6Fi
 ZSrgfvvq9UpfjdZ2kj6NFTsRFdNY/2IghEoaq4GcrhVw/QJB8DG0l4a96H/uom5/dS9c
 4IgQ==
X-Gm-Message-State: AOJu0YwDn7QxQKLVoVLAc3u7DFPow6NrAoy8XIDn36itAxyYq0cD2KHn
 BKP2/b4vfdmJdlL/lH8n+bXAl2sMe/K1FwRWzQQFJ1N/nwSGwsG/
X-Gm-Gg: ASbGncta60LSPp9CtenrnNjipXbrQzoGw+rs/tM8gNj3ssRPYZ3BOIlgtb6QmaloDeW
 WPd1I/bRCkabhuFw3rH1l7gv+xWMnuJk/wLiPAi0cULJiZlXBsJBWgUvOM3J7FlydMNSTlwmAtw
 epyXvt4ON9RrtcBgUIAa7Z5mZEV3X4w1XgnrCCPiZf5ZeGRKDba2A+MxLmhgGm9aGXD4nmFL/8b
 mSrMAoSztrLmzSd0bFoq1sDaAKJiWwNzbBqe+jm05mcHMVu3UQu0TJkuDg=
X-Google-Smtp-Source: AGHT+IFYCUnU3psHY8Ccpq+KbKo5nRmj8VigJBP9ipF6Ss90boHG+4JRxGYV8fxigHBkV91cL3wqvg==
X-Received: by 2002:a17:903:230c:b0:216:1543:195d with SMTP id
 d9443c01a7336-219e6eb3a5dmr296837795ad.25.1735204868349; 
 Thu, 26 Dec 2024 01:21:08 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:5fa2:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d948fsm116347985ad.150.2024.12.26.01.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 01:21:07 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5/7] arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi
 R3S
Date: Thu, 26 Dec 2024 17:20:41 +0800
Message-ID: <20241226092043.419511-6-cnsztl@gmail.com>
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

It is required to boot from eMMC without additional patch in u-boot.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20241022193537.1117919-5-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 1b5365034410f1ca21adadadd492b99bdf4f2c55 ]

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
index 243574f8da..03a2f90f62 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
@@ -491,6 +491,7 @@
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
-- 
2.47.0

