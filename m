Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B1BC27C52
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3553488476;
	Wed,  5 Jun 2024 21:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SOEl5ThH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9B288280; Wed,  5 Jun 2024 21:03:55 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CECC78831D
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 21:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42108856c33so7709335e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717614233; x=1718219033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+mEXw7F2lJQQgW+4oCLpZWuN1JwwLw7u8qEl078/N1E=;
 b=SOEl5ThHlJ91ZLGQsrATVw/Dw0DCqoQ8ZoeetLFobCKLv4yMP2sfQXTdxAA0dY1PrM
 gamS4qz4pEzTuiQ8fuHpH2HQzI08dSC8f4qkTlttbBfa97mw72PZgSiOV50pnCyJXTmQ
 6aNBLTHr4wXB6JOq85tNTRhOHobtOYbXBls/qzkqrCeXjwYM0wk0VzksIhb0zP8dXOpH
 9jbYlebjQVc7toTxP8N87a76Bjvwhv9q4oJWuhpplV08mO8f6R58uK7h9C7TuX/DCCtW
 PSQRaHgfn4LRVIvanoZ765cwwLWdWJs+ZjqcwpUX8yGu5Q7BvM0RppyeU2ajwAjUuZHM
 fjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614233; x=1718219033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mEXw7F2lJQQgW+4oCLpZWuN1JwwLw7u8qEl078/N1E=;
 b=pDt7GuluI0p0JLPvfx3yApvwr9ne9iHJsn0ESr+Ur9NUz/PHGirf9MN24tkJl0TOSx
 WDkPr+84tggfF6wGDIu6xbn2ZYdFRWEQGqe6Jy5LCOiBPs3ft5bdowxzhvzXxnmMR/6u
 FZQKfHnP6/N2bjv38MbqiAKT23mn+Yxxu2A8/0km7tocH3rrBqGaQztrYKEcaCmGAK8T
 cikQ7r0XTzpc+o+hsgm9BdKObJ/n7K0SCwS/QunNiUPs0TjKkiOfUlvOO7eBOhrE4DF9
 YeVLF20Lf1WabCdjOqTeL6X6v73lIv9geCuqtw3qA8q1yyWvObdN/WBimX38PrN9Llay
 pyVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCo2IK2iMew5CToCU2Qs+FugbZVPxtqq5hkFuikckXNedexDX4IR1mbZE18D0571+buEaqKZvPvcX2x6XjBHzi8m+Fiw==
X-Gm-Message-State: AOJu0Yx6XHxIJsgsaWf+xKtU20iimkxv+eRDT8m9XTpV902vFaxxUhug
 4VfsS7sJ6zjh8DF9K7gBWwBvo946UTrXjN1A4YqZ8PsVhWe+341f
X-Google-Smtp-Source: AGHT+IEU8FmgZ1EHipp0TMtL5/sOkdd0dU2OBeWlE4AKF8zco2f06WqMv3FTZzFBqlmP+JKYuBQTCw==
X-Received: by 2002:a05:600c:4f51:b0:421:556f:5fb8 with SMTP id
 5b1f17b1804b1-4215ac83330mr4881685e9.0.1717614233276; 
 Wed, 05 Jun 2024 12:03:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4214a4abdd5sm44772195e9.0.2024.06.05.12.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 12:03:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Francois Berder <fberder@outlook.fr>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Michal Simek <michal.simek@amd.com>, John Crispin <john@phrozen.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mason Huo <mason.huo@starfivetech.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Sergei Antonov <saproj@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 09/11] clk: mediatek: mt7981: support alternative compatible
 for fixed-plls
Date: Wed,  5 Jun 2024 21:02:16 +0200
Message-ID: <20240605190220.17616-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605190220.17616-1-ansuelsmth@gmail.com>
References: <20240605190220.17616-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

Support alternative compatible for fixed-plls clocks used upstream with
the compatible mediatek,mt7981-apmixedsys.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 7fcb81419cd..13dc3df0e9e 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -543,6 +543,7 @@ static const struct mtk_clk_tree mt7981_infracfg_clk_tree = {
 
 static const struct udevice_id mt7981_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7981-fixed-plls" },
+	{ .compatible = "mediatek,mt7981-apmixedsys" },
 	{}
 };
 
-- 
2.43.0

