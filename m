Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B04C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0A6988BFC;
	Fri,  2 Aug 2024 18:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="puUsc8nI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBEA088BF3; Fri,  2 Aug 2024 18:28:32 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A51A388BCE
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso61977665e9.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616110; x=1723220910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdlA2YFu75qIRcOboRUVZHumardm4s8P2fupehOThlg=;
 b=puUsc8nIY5AodFSi9srhQGTR+q+35Ye6tuxD104YHag/JoLsFWsNabbynm+xxKYGyz
 8XjGeH8kmkkxi68JdxjtiCj2rzQRND5BVOGS6uTVvIwm6Fx4AXAshX0d52dO4kBnN6CU
 VrIztwisfwlJ3ad/rDY2x7GsWFK876ANLiAijuwCEGcTz8eJDhWPlmykZleeipPwOwZO
 J9bC9djw3jnpid2asZSqtDU27xm/uweyjSFSwOC+tkt2JVYA/2jsOf4alRcHitlQn5WI
 Swe61zCpmL6zRCvEnUVg0spIlIMAzhjkLrJcKqONmNGiUIoiATJWbKUNW1/L50p6MLDc
 +Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616110; x=1723220910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdlA2YFu75qIRcOboRUVZHumardm4s8P2fupehOThlg=;
 b=RhdcaWPr/Uqhh2pvsbmRuu/3XI9gc0SH8X1Id+arycP1YkE7jDDGrhyiL+bj2dbZbS
 LAkJl10my8iSzusObXqTfPl3d29F5O/zsh40u5O8YjosPBfIYGoeCyhXCeBtiLVOLNFV
 VVKkzYJ8zw82q31UW1Lg4v8St63eup2nP5iGc1G2uE1+9kPMTKtkhAAfmT3GBi8+xkMV
 i0CgCo27/0o3EcEvTJFKpJabghdI7JQoA8M2oHNZ/VCqsJR9b4DOk7MZW+xR9DGNKaxc
 DHsDha/stfr3HEayhZNMgonnq3up4NTfmMG9ZR8IMYpOxxYgpeNPEe2k5wCpcvZQ1KyL
 ADrQ==
X-Gm-Message-State: AOJu0YwDcJZtr3dIfIPWMD3rBJ67FSNw/phxQ4hYU6YO9YHEB7dy8mpE
 HfbLeoNa5+3iqHUYURpIeo3R6kbs1YjDbhbLJFMOKkSVOLL08jDA6cldagLb9AaVXQFc3cpON9Z
 H9MyuTT3V
X-Google-Smtp-Source: AGHT+IHnh3j6S87PH4nDh3CJx7SIc989c0xpx/kUrGZz++2+zc6Qrzb0qUwCSf/nGSiZ4iESVkHHrQ==
X-Received: by 2002:a05:600c:3c84:b0:426:6ee7:d594 with SMTP id
 5b1f17b1804b1-428e6af2443mr33922375e9.7.1722616109865; 
 Fri, 02 Aug 2024 09:28:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 14/20] net-lwip: lwIP wget supports user defined port in
 the uri, so allow it.
Date: Fri,  2 Aug 2024 18:26:41 +0200
Message-Id: <50ebd3025064d752ff4d73e995d8f70b240ccb13.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

From: Jonathan Humphreys <j-humphreys@ti.com>

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/wget.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 65a69fab6e8..bd1aab499d2 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -264,12 +264,6 @@ bool wget_validate_uri(char *uri)
 		ret = false;
 		goto out;
 	}
-	s = strchr(authority, ':');
-	if (s) {
-		log_err("user defined port is not supported\n");
-		ret = false;
-		goto out;
-	}
 
 out:
 	free(str_copy);
-- 
2.40.1

