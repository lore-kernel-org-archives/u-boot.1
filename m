Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B073EC44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6F384AEB;
	Tue,  7 Jul 2026 17:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6aIghPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C82C184AEB; Tue,  7 Jul 2026 17:32:54 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7593849F6
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-488b3fd8d0dso1387189b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783438371; x=1784043171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3tlyri5XX/IM8zdqUd3gr0oGC0JyoWfPt0tuM11A9GY=;
 b=c6aIghPAhim7pACj+ISS9WU7DEgsFhtHGnW4cmOJENp99oXkAU1DB3XlYbb9JUympH
 p51wxKUyozEv+5rs/iaOrniQIUfTW9K7/jbIosS0Y9XlN5vQBsC1WDdoQLE4FSadvA1y
 tS1GqKtfPJZ/YmRRU4w6j+mMdbpjpdekA4u/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438371; x=1784043171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3tlyri5XX/IM8zdqUd3gr0oGC0JyoWfPt0tuM11A9GY=;
 b=R9blDYXfCHEjJpJJBovpP5LUC8/bc6zZng7Gy0J22Fi1Cf7RWiUHv64T5m8CbG0nue
 SvImt7i0p5CNT55IGZ/CNNVcza41nxmpeygu2GDTK+s/hKuie9s9m5szuV4tM8PUMQTB
 pM5yQRebGGzACcaJeEvgBYcsuUOpoHlQ029mvNKXuiMsmEq+pDmT7Z6UbIB3EXR41IRn
 2enfS+r3EI7Ef1p0+k5mgDCEP1uygClHqEJvHPY3FL6hiLeHvw2w5rxR0kBBj2oNRK7d
 qgCMCLVYKbOJb2nIFugt3WvRCEQpFUbU5fTK2NSLROD/zlHq8u6/rd/QhcsR4impc3OU
 XRMg==
X-Gm-Message-State: AOJu0YyCdlnQnNH70attsjxf0/PzE6mFkHIcD3/nMhcjoUXURDQaiMl5
 CMalBEBp19+Xck7tw6NlQ6T4yssLQTm4MAUIc5+5XhzQYAvSB0wRw4s5TlOOrk2Ajy4pCdypdFA
 /Se2zEg==
X-Gm-Gg: AfdE7ckU1NgrUBd2tbNxvXqUgGV6ECbEqwos/U8wRfVqftaaHRzArcApPyNJWCEGoHa
 qH6PSuvyXX5f0uUAq0rRH6DOtQcZOG1d/iOVtGB46zNpQEuJOsXy3omRehr7tVghHieBamOPxlO
 PCTbo5KRCNeofSmtpwziitt9jXcMmBLaWjVInahm2iJi10k0Wz/6pX+z1hi22HOHwqSrRfcR9Ga
 X/9eVQXZNepAFbZDFLWfP0FgZtR4fT5sPCdnxA40Usnw64eWnWkkKFwcndYxb1ZNdDpl+EEiig3
 vmrubPt2pESAU2YosTSqLer4P+/HJ5SS5xZu2IrLRyrAOFFef2qSzLfJ0RHJpknZ6io2Gbm/y6R
 G5EaLgNQTknLUph4znfkYwgzYwS0FQQ89KZf1jGst0Xz8LBjwfqk9deXipBYbN9dfWgOpCWCId4
 nof/b94Do=
X-Received: by 2002:a05:6808:1511:b0:495:eb32:46cf with SMTP id
 5614622812f47-49fdddc779fmr3806650b6e.26.1783438371466; 
 Tue, 07 Jul 2026 08:32:51 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm12052218b6e.14.2026.07.07.08.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:32:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>
Subject: [PATCH v3 09/15] tools: rkcommon: Add RV1106 support
Date: Tue,  7 Jul 2026 09:31:07 -0600
Message-ID: <20260707153135.2048115-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707153135.2048115-1-sjg@chromium.org>
References: <20260707153135.2048115-1-sjg@chromium.org>
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

Add rv1106 to the list of supported SoCs. Like the RV1103B, it uses
the version-2 image header, for which the 4-byte header tag is unused.

The RV1103 is a package variant of the RV1106 and uses the same boot
image format, so this entry covers both

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/rkcommon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 6f25a1cda31..06df57ec72d 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -154,6 +154,7 @@ static struct spl_info spl_infos[] = {
 	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rv1103b", "110E", 0x40000 - 0x1000, false, RK_HEADER_V2 },
+	{ "rv1106", "110C", 0x40000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
 	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
 };
-- 
2.43.0

