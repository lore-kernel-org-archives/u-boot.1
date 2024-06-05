Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53EAC27C55
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F28F882B6;
	Wed,  5 Jun 2024 05:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fUmkQCyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E4E88297; Wed,  5 Jun 2024 05:26:14 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B1A882F9
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-36dd56cf5f5so25836975ab.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717557969; x=1718162769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ba9eEJQQbA1+o5v9WVHQQ2UaKvF3rgoxOAHtYJQwKjc=;
 b=fUmkQCyE3cMNnzZ+tVZB/JOxaMH/+OgBarwGBLHDTkVqZwdGok03S0D7pDzaiWracq
 Uc8ruSoDCAfKgY/gInmoiy8UwkKEeauigUrYILqA7nC17DxaYYsvNfhC8eYIiQt/zSPT
 PwweFD7en4cguY4OhFZn5IMZghqCnz8pndqnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717557969; x=1718162769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ba9eEJQQbA1+o5v9WVHQQ2UaKvF3rgoxOAHtYJQwKjc=;
 b=TDm+FBUBXjVKY/OjEAJpTdjjs5csudMMsuZfq0t/FUiMfoq4tAgiB1sfCAFsm2CfFN
 OP35vEVKTsAVTL8C0i9uULBd3RpYBU3+lkeyDD/zVDEBcm2Qg5wTO3+HcQ5luWQN5Rzt
 8fPI4WpT/TX9+Nwjx1YgNBcwIbPguRRQv9DCCzaegU/2qInQpBCGAE8O4J49g9ppzicP
 cusHWYwqkbyyrsYJunfkb1E4/ZlZwGOZ8SejuTly5IKsDusL6+fkQsud6pEdmxoHwUC2
 19WXBIPOTX3rXbCtWK9AN+4lPt3Af/R8bHb+G41Z5p2cct90DDKWxyJbnR2lbTicS8q3
 jOeA==
X-Gm-Message-State: AOJu0YynYPx4qIOFxp8yC+A2CWKNaFMJcJo8Bor0uBupvzH+n4iUHu0k
 j4w93X7yuIKnxfemw0KnjA1sf4kbzLfKlBdDPyLf5ogfXhWmVVUFDBuK8EmWO4RvEQU3T2p0m6O
 QDg==
X-Google-Smtp-Source: AGHT+IHVhKokOZX2kK6pQa2A/1cM3oslijNO3ei36McEdW0pGqBtumDgyKphlfMuQwhMDlnKL8M0Pg==
X-Received: by 2002:a05:6e02:922:b0:374:9822:bc68 with SMTP id
 e9e14a558f8ab-374b1ef2d2bmr11180675ab.11.1717557969604; 
 Tue, 04 Jun 2024 20:26:09 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Allen Martin <amartin@nvidia.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 1/9] nvidia: nyan-big: Disable debug UART
Date: Tue,  4 Jun 2024 21:25:13 -0600
Message-Id: <20240605032521.1142768-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
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

This cannot be enabled early in boot since some other init is needed.
At this point it is unclear exactly what init is needed, so disable
the debug UART to avoid a hang.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/nyan-big_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
index 1483d17d975..4dec710cf8d 100644
--- a/configs/nyan-big_defconfig
+++ b/configs/nyan-big_defconfig
@@ -17,7 +17,6 @@ CONFIG_TEGRA124=y
 CONFIG_TARGET_NYAN_BIG=y
 CONFIG_TEGRA_GPU=y
 CONFIG_SYS_LOAD_ADDR=0x82408000
-CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_BOOTSTAGE=y
-- 
2.34.1

