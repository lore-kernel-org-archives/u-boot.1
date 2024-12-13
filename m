Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AC0E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B58D8021D;
	Fri, 13 Dec 2024 15:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AukDR+KO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A5F80212; Fri, 13 Dec 2024 15:53:52 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5476F8007A
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-30036310158so15345731fa.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734101629; x=1734706429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qd5de0Wg7Tm7QAHQZ7DFM008qPVi/zrnNM+GXdTvVcI=;
 b=AukDR+KOHZkGmTNKlpKjml04CpRg2QybXfv4nf3ba3HJCJGpQq/ruiK0y0Pk+KL7VI
 PlRxt9V4WwOkLWtPQ+/cqgdv5F0J+DAma8C+kaTCHYc5LZCu6wzwfHl60RHjY4EO+1rZ
 2h6bBl6o77eafztcq9iA7Tl96NhaXVbnZlWvvF95qmZ7j4IHIv4JsJBeb6gvwWgz/UPA
 gbJyk/wBx3jlkvqEZZ7JAl6+jm++4tTlKJEZI4TFUCn0/Gkky785EoQNYiOT8qzsCUjj
 fM4AnES896SaOrzM3zKKEXEVIw+gvEe8atl9Kgo1rSZXBPRW0BbSYIKpqUxKblrtbuUg
 9r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734101629; x=1734706429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qd5de0Wg7Tm7QAHQZ7DFM008qPVi/zrnNM+GXdTvVcI=;
 b=XZLwX/iJDKY6ZzrJNQehSKbkSg7n2mhgB1lVXXpiYcHMDzNBfIUP1IrTSetWQ5AeuM
 ZfqmjDz9jBonGoadepHysijqGbC1Lv7glJ6s+DcFTIQPelbyIt6BI87jr93YaVl7vQTW
 GNTc2OUbqqb8/omNpkRNKtim6WAyJilLZquE1fjaclJThB+D8ktCAko6CMYvZKi3tc4A
 PUc5QUjUIKGGWvO35puIYW7Z/8r+O9CkYqtt7BA1qRdyVybeNPck3csE/8Cg9RE2io+3
 WPSf6sxAaV4SMvVp5KUgT1rqdSSFSmBAuR9vb5cSvQv3By2kbbKjNPEDxPBBj5bs+jxq
 NAGg==
X-Gm-Message-State: AOJu0YwPLlQIH5iMmD08AJopLiubwA/krQ5shBJSLow/5QkoSlBGxZ7P
 00Jb/GAGHwGnJbP1Ihv5Gx6JgnuQwl2gn/12w1SwDdzJ9SNETH2T
X-Gm-Gg: ASbGncuEcucigwhBCAvo8iWc0XHJ4FyLbQ7XQiOT7BNKQdSiK1afpXFElb0GDx/PkjN
 c7wxEhkuMwZYvrEovzvE1zKHMn3qnIN+iqHeqTEBk1aSYXX/gEaB+U+3piHW8mE8etA2lt3T7Ua
 EvSUvCk80W1GlvARbA4/oBtQ0LfK8usOQVzgz7CQFkuKN6mTFWsZQEudO5fgVwuGqlbhRFudQQv
 JUUAF3YJYNHXFGG5e5bJDGsqKNjsUL3a1p3nL36jLkMTVUL
X-Google-Smtp-Source: AGHT+IFzYmtgc7aTeZibblj2WL93VzkPtRf93fegsnhdrAMFMiJFONFXFhQd7CYWXzA2rfWCLQjn6Q==
X-Received: by 2002:a2e:b892:0:b0:302:360e:a153 with SMTP id
 38308e7fff4ca-302545b8d96mr8908361fa.36.1734101629311; 
 Fri, 13 Dec 2024 06:53:49 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30216eb1013sm18626561fa.34.2024.12.13.06.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:53:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 2/2] driver: clk: tegra: init basic clocks on probe
Date: Fri, 13 Dec 2024 16:53:19 +0200
Message-ID: <20241213145319.10956-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213145319.10956-1-clamor95@gmail.com>
References: <20241213145319.10956-1-clamor95@gmail.com>
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

In case DM drivers probe earlier than board clock setup is done
init of basic clocks should be done in CAR driver probe as well.
Add it to avoid possible clock related problems.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/tegra-car-clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index ec89d4b2b2d..880dd4f6ece 100644
--- a/drivers/clk/tegra/tegra-car-clk.c
+++ b/drivers/clk/tegra/tegra-car-clk.c
@@ -112,6 +112,9 @@ static int tegra_car_clk_probe(struct udevice *dev)
 {
 	debug("%s(dev=%p)\n", __func__, dev);
 
+	clock_init();
+	clock_verify();
+
 	return 0;
 }
 
-- 
2.43.0

