Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C161C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0023B88C87;
	Fri,  2 Aug 2024 21:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FRi5UVQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1759A88C36; Fri,  2 Aug 2024 21:56:46 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A0E88C61
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so45619895e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628602; x=1723233402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/vbJZaP2TKbli1OL1pcynVDm6MuoU9nhG+PGw1cuFxI=;
 b=FRi5UVQZA59Im62Gm6XmKLVYMlqW+3siesNzAV6fsGuS0hFKMitC7mwkdC5F3txX31
 LUIUyrQ0uRcvXp99eZnqDVUe3h9OkeovGTXH1H9jpx0mVD/bCkejfsT/5qgxNpDEYW2D
 smvsOmD/6yVQTVKrzfoflv/dIayZiG9w0S9CFiyb0TCfPehyEyFqzNIq0qmgU+4i7aAZ
 bPrhZS74z8odCSassUPjjslS/qW5rLVVOysuNsBSu07uOgLNM+tIZ6+xk0pX2rUunTvi
 36uPBQqHIRrTsw789YvhCU/3L99ezr3UM9HpB/WjtIvcOY7fd9DrRgrAkhO8dKGuiAoJ
 ADdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628602; x=1723233402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vbJZaP2TKbli1OL1pcynVDm6MuoU9nhG+PGw1cuFxI=;
 b=fo59R9LEDno8g66emsw9GZ+D6eCYWKEKfwqLH8j//sDV2NQFn5NBWaMp8R/bdpOsp8
 aHsB+YZBG5yEbtF5uhuEGRI+VF0lGLUfb7gtvW5pD1xg7tNn+vs3nb/siI8h3hy9Yt/K
 qyodmR/apbSHP0JRt+Bt6HmL46lmIg3H8g/u4qRiv3gHN7qSto/8ovJ5ux+ezolwHC0C
 jnC28dDNJXM1LH4WR/Ad7QTrZbG/S75tgBKPEhattxEY5tenuRp3w2VcRYAt8t4jru2+
 ojGeweZ1fIAUatyEP+WbPcnUvSPXT30+JZoyNAzufdOAh432IZC5rd2F/3Kj85fwul7j
 fQMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyG+wnWcByC78GQzIyZkl3pljn+zPeve1f/XWFPEJ0vcmBOdeWC1aaytJrTd7qxlf73ZjQbwbybOOwWduRGZuF8rPiYA==
X-Gm-Message-State: AOJu0YwzbVBkmRw/sgtCO1fZuIagw0TwEAbfzCxtBtNv/seINzK3260n
 3b2L64To9gI2azbcL9rvdaMHI8SUJ42EslLSjrFMEum8v+LeCHpJ
X-Google-Smtp-Source: AGHT+IFdIyEn/D/B70htiCZ0ReGqwdl8lfV3hLCRxLYHqjRNcLcd0jQupYJyRn6upK76wJlprXU+MA==
X-Received: by 2002:a05:600c:3c82:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-428e6b7bc5emr27744875e9.30.1722628601674; 
 Fri, 02 Aug 2024 12:56:41 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 08/14] clk: mediatek: mt7981: fix wrong parent list for
 INFRA_PWM1_SEL mux
Date: Fri,  2 Aug 2024 15:53:09 +0200
Message-ID: <20240802135326.25303-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Fix wrong parent list for INFRA_PWM1_SEL mux. The list is incorrect and
the parents are just 2. This also match the upstream linux
implementation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 0ec5c943081..8b2e667c049 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -373,7 +373,7 @@ static const int infra_spi0_parents[] = { CK_INFRA_I2C, CK_INFRA_ISPI0 };
 
 static const int infra_spi1_parents[] = { CK_INFRA_I2C, CK_INFRA_ISPI1 };
 
-static const int infra_pwm1_parents[] = { -1, -1, -1, CK_INFRA_PWM };
+static const int infra_pwm1_parents[] = {-1, CK_INFRA_PWM };
 
 static const int infra_pwm_bsel_parents[] = { -1, -1, -1, CK_INFRA_PWM };
 
-- 
2.45.2

