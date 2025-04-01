Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AF8C36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92A182075;
	Tue,  1 Apr 2025 19:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nBrl/NOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0AF582063; Tue,  1 Apr 2025 19:30:22 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D68181F7E
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3031354f134so7630445a91.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528618; x=1744133418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eo4wVcM82b19SiFcLdhxvTzyaBIaSUfH82UO9y1wcW0=;
 b=nBrl/NOf0vPrOwmqJ9O4GGhdoNZWJsLWbm65zJBU8VjTsLvblCnYlr4IxGQh7tGxzB
 SWX/K0Va0FUz8dtlNaP1NDjezchWDG4KYvaYu90X9KJANONvIjlBTM0CHHvmdXlJEY4M
 psmc7aYvMJY5SO7bvLPmDbWSOo/1U2XEwW6+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528618; x=1744133418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eo4wVcM82b19SiFcLdhxvTzyaBIaSUfH82UO9y1wcW0=;
 b=FtSfBtHd8dpdMXzQXKpGN449raFm+FjVOfgUy61+LpVboGllj6Swdo+TL9x59OoC/b
 nQ8+4qKvhFSZjGdszx13iV9kJ+PdzNMiZVS1shjkcBFb4MZnJKhQH4Y2jjH4T7UE6R10
 MOGkKEGSKz4GOD52Mv6DvPTg4TY0VypwEqjeuK+u2QohIibBV6UFBlAatbiutG3gB6Ee
 D2ebYwByvZA9lz+vPoHTKDAgHy5KpDKT2Q32moK6UzVaPIFgna5/SYeYOsgrKchHtDCq
 7+jPJZoPSdIi+lT8PQhVKkm7d92Kuzt+x7ZijEp6jum15MU28PmICoWFdXYoizuyUS+U
 NfMw==
X-Gm-Message-State: AOJu0YycrrtOLOLAp56SdM24w0GvWT1lTA0y3be3Jnwn3JEn4PLF3x0m
 O463uogPEa855uzdtzPOuARr+O8YZVUZan3TeYd3x7monaIcj+30390tT2lZxxG8QXY2cDA0ztJ
 cRw==
X-Gm-Gg: ASbGncsC3PT0QUhkSgpqK461a2gComKGPQZ3qcQAQVvAlG1kOgpVKiLTJVOjCOgeQAx
 mCafmSQn+qR7F5Xk/4/+D5sUJeLXgXc3eCcwRKs30nXs992iPGHsMyfMMefVhOkq5kGZdAuyxMM
 pZI4hlzwfe1JypKhXJLQKclNkCJ5LH/JjqAXUwU5259QH5sNG8yrzc9VuD7fKvcstYI2oNTb5VG
 qK0FkgApvONbZdUxgKX6nkRVAYO1KWkrr4HeSi8u2Xxnr31JBPwx9oJGvyQPwvzNc6vRX3++EBG
 tfNww0g+V5vzpDGkgEVnkCD6Ezm7rvombC2B68PYlga0Iu8age3gKg==
X-Google-Smtp-Source: AGHT+IF+4/GR3ELd5h8Pj5Q33j738SgR710NOLv8/hb7aBJTRsEzwyaKL/yOi5ScbILuyrFj2mfoNA==
X-Received: by 2002:a17:90b:1648:b0:2ff:62b7:dcc0 with SMTP id
 98e67ed59e1d1-305320af245mr19315866a91.15.1743528618040; 
 Tue, 01 Apr 2025 10:30:18 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/13] sandbox: Select white-on-black
Date: Wed,  2 Apr 2025 06:29:34 +1300
Message-ID: <20250401172948.1236000-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
References: <20250401172948.1236000-1-sjg@chromium.org>
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

Use white on black for the expo menu as it is easier on the eyes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/test.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 6cd87b74a64..ed573ef1570 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -130,6 +130,7 @@
 			font-size = <30>;
 			menu-inset = <3>;
 			menuitem-gap-y = <1>;
+			white-on-black;
 		};
 
 		cedit-theme {
-- 
2.43.0

