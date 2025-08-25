Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C13CA0FE9
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6248583197;
	Tue, 26 Aug 2025 00:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dv9xEFoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B7483192; Tue, 26 Aug 2025 00:34:36 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AEDE80819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b04f8b5so30323785e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161273; x=1756766073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4PX5T15mCEWcWMay3rk6iVex8zX2zRuQYJ65PFRv8k=;
 b=Dv9xEFoG6gzUQDucZx+lNaC2E5SL9Exjo5lVJ40vUkDy/XOV+SEdEQMVw32YSCu3Xa
 CM4at+ZTar4ak2bVdqRLapEptpsDEDJlvgaqXX0QZY9X3fIP8iOU6ESxAGos6gD/ODad
 6vYDlyVhYM31orumdE9vxxfgu+CNbXyMORAEbAzROIlaYVQhYuuRDydY/vYqAtVz3z9y
 zaEO+rrQ0N9HALKxNBACNP0D73JlKzmYfn/usVtsif/K5Fp/V/P1ClXSRaFx8O8Estfa
 FuciBLrtawapuk/MlHhIdTq8cJrcEoj8MAv/eWBxdpdrpnRfQfBfQ7Bc6fO8c8/W1woA
 WK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161273; x=1756766073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4PX5T15mCEWcWMay3rk6iVex8zX2zRuQYJ65PFRv8k=;
 b=k0QrC0FLcBz27PcoGraDVZedIDuB2/+tdMZE4a/6hux2geSYoWa/xK8Sk2GxNmGJ/1
 /xyYZmLX6KYB14qvhTpMSf/JOv7LcR97C5NicY/3uGDEo5Uf3SKC513vgJfXLIMRMT+B
 Acg4F4xWY8iHxIwm+hnE5KizSXY8u281pUJ2gXT5DSJPu8yVbA2O9O5KtvtO5YG/lRDj
 DvxA6jHB2LKKib+R+IZUrcFpUCjx+fhOMNuu89u5exHlB50fZbcNZwXK2BxEk3Da/HrN
 XjJXJAJwkS17nmTsNBLUp3rr5jNKCb4qL/J5+TMl40zhRFc5lmqn8yJvqDdkaFzCV9jI
 MCUw==
X-Gm-Message-State: AOJu0Yz58pOeQEXEwP6300VjZQxFPhU22rFe0/goSRDZhPeMQOX2U0jw
 RgNj9xdHoNOp3MzHHB0N8keQjxTE0W0qtrBQf6KcbWIwW5tg2JAVhuirBrEqWkYGER0=
X-Gm-Gg: ASbGncsYxBgMsud5GqjOCs/k1a5M6+Dgc/pSfvEV7vrs/pYFF38w3uSqakVxo4Dtbqp
 chvtdCeH402fkK5wmV3ns5/QXhJSlJR+zUNjAMKy8iByxPSPYs1mi+HLkQJ/HCaMQlTyeUZZFD2
 eKIhSp4Y8wW69GXpOjxVnrV3BRmQKwpEuF1NLcwWrkP0ob16gjASCAB8QwnXs92PciX2yYqwTDv
 yy5tSANEslav3zZO9sawW7WHVarcf4zJSIxP2BrDrk/hHyJ+os9yBHpQ/Cu8d9l6EhOAjnXc2iz
 1e0ScFhTUxBBY2EhFv7jpMUajmCTRuYr2wtiCZwV85DKXXgxgijRmeLKk9BZUbGY1ejN01dh0ek
 NQNATedf0aiTfKdf1qqgKgA7YDRwp
X-Google-Smtp-Source: AGHT+IH1yLlS1sfW0b1C64jcZ/g0ZO3ByIcBzu8N5rXjY7+C2j54njJqRmwSrFDw+7taz0pLqk8cJA==
X-Received: by 2002:a05:600c:4fcd:b0:459:db71:74d7 with SMTP id
 5b1f17b1804b1-45b517d40damr106998045e9.27.1756161273320; 
 Mon, 25 Aug 2025 15:34:33 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:33 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 07/10] doc: Rephrase to read a bit nicer
Date: Mon, 25 Aug 2025 23:32:34 +0100
Message-ID: <20250825223251.674591-8-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
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

Reads better.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 709fe82f845..dafac017f0e 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1294,8 +1294,8 @@ shows an error::
 
 One major caveat with this feature with branches (-b) is that buildman does not
 name the output directories differently when you change the configuration, so
-doing the same build again with different configuration will not trigger a
-rebuild. You can use -f to work around that.
+doing the same build with a different configuration will not trigger a rebuild.
+You can use -f to work around that.
 
 
 Other options
@@ -1357,7 +1357,7 @@ directory.
 Build summary
 -------------
 
-When buildman finishes it shows a summary, something like this::
+When Buildman finishes, it displays a summary, similar to the following:
 
     Completed: 5 total built, duration 0:00:21, rate 0.24
 
-- 
2.48.1

