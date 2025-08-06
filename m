Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B99C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 15:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08971842F7;
	Wed,  6 Aug 2025 17:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SfF6Njo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC19D8433F; Wed,  6 Aug 2025 17:47:51 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9ABE842EE
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b786421e36so3911988f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754495269; x=1755100069; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W0hH9fETBZ4uSYSb31Qa/UnFljw5BFBAjRDfQNVBwrs=;
 b=SfF6Njo9VQ7+8v08pmbTD6AqdR/nuVDCxcQ3lYfIh1BWNc+dASxsbBhTE4U9augxNG
 m4j0ESRt4ks4vHPCL9/d6HtDYpMWE4G4EK4Xccem2k8ALOaDsPj0KR6foWBdfxCnQgmA
 Vydoc3pRNPX7wLyd9XGx0ibuPJCm/8xwg5mASVNTq6xRaaMWpy/q3UW2JVUWushAekGd
 bFP5DQuBvpjT37b5+5kSw+uKcn1YLPNMf29loS0262QN/sHDAdJdVBCTpC6XVGb8TEQj
 4C3ttUNPbcTrWO/uTBAlSl2PlWc10H2dOTiaRYUdKq/2RdjcGEO9Db+Y2j1MTkS1Wnd1
 ofUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495269; x=1755100069;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W0hH9fETBZ4uSYSb31Qa/UnFljw5BFBAjRDfQNVBwrs=;
 b=L8rHf2lD5/k71j+3F5XGKhvGkYR+547cr2b0zU1rbHCu17ABZIPNWNeAb4NdA9C4gB
 iQL8KDZde19XaUnu8deE4KLzjIMYjl9ylls9akerw4Tu935OPB4l/rbNC1r/WwhK9fO+
 TxeXVA4snlNEGKL3PJ0TOp5qOxWyWTJtAKKdPwNw0lf7oqmaOsL7GU9VBBpzv+8x7K8V
 f4+ucbwHMldlJKxwR7QWlMAQnP1dfRPtRmd+ONG4OB0M6n0VRhT8A/Bu87E9XQX2fmTv
 JHwNSueNgwHd7JB4k5QLykdMFTO3LMGpMCrDrocns49X2iBA+OoT09aO9hD5vIm9/5Jv
 fRjg==
X-Gm-Message-State: AOJu0Yy/uRZEgC6OPNQyAVsO5LBEB6xpFo9EAlanmKMN6LhfY3t9sNKo
 wN9Pyl7az/8wLTcc8USAIkkZxcyev5TZzEEfBy1m5XIBbDiupmj49jKIvmAADltre+JJUx8gL77
 T90Mc
X-Gm-Gg: ASbGncstos/8tXNchuCq8bvcA73Vv8NptbgB06Vz7KlTfvDTEOum6yLviP0a7KQwK+f
 uK8mzOU3/YovMQO+ahNDQhnDF1wT4tXAVXFOiP+uyg18E/m0vB6OGutqyssSW/wwirnOpaD41ex
 voASi0Nr22LZrrSs0UkXjHdo4rz3a9jrvHdtoS7VZ320M/6xDTwnRBSAuEaYvfcz9vX6p21LFgx
 mFTChr+XvhoPZ55bZCL1CzWqnwGy7F9wgsuEyoW8t7ATlqHFf3uflBRIFfYx3zCHKPeqbv/jPW3
 nyj1boO4j6y7LSYxl7tfF6ovfCRI9sqRwmo6+ctA8SCYg7pBozvk8zTb09Iz9+i1mXAFfgkjWWZ
 x1hgjoS4VIbd1uxndZ7WO+Fe5J2Ak5cIwjHaZSj8LsKQpIjGMBpFebfg1NJXTEg==
X-Google-Smtp-Source: AGHT+IH2eu+ctO0bUjai9kineP2hLox7AuXIxzdgjxvSJyaaugULquDFoTpxwoaHCUsZT0HrDvZK8g==
X-Received: by 2002:a05:6000:1ac8:b0:3b8:d893:5230 with SMTP id
 ffacd0b85a97d-3b8f421058amr3008134f8f.47.1754495269132; 
 Wed, 06 Aug 2025 08:47:49 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e054036bsm13807866f8f.31.2025.08.06.08.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:47:48 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 16:47:46 +0100
Subject: [PATCH] phy: keystone-usb: Do not negate return code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-keystone-usb-phy-v1-1-eb7d42dd6b6f@linaro.org>
X-B4-Tracking: v=1; b=H4sIACF5k2gC/x2N0QqDMAwAf0XyvEC1KN1+ZewhdXENY1USHRPx3
 1d9PI7jNjBWYYNbtYHyV0zGXKC+VNAnyi9GeRaGxjWtC67DN682j5lxsYhTWjF4H+LgqQ7XFko
 WyRijUu7TEX7IZtZDTMqD/M7X/bHvf+Kcn9N7AAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In keystone_usb_init the return code from psc_enable_module should be
returned as is rather than being negated.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/keystone-usb-phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/keystone-usb-phy.c b/drivers/phy/keystone-usb-phy.c
index cfc15203d63..460efbe768d 100644
--- a/drivers/phy/keystone-usb-phy.c
+++ b/drivers/phy/keystone-usb-phy.c
@@ -41,7 +41,7 @@ static int keystone_usb_init(struct phy *phy)
 	rc = psc_enable_module(keystone->psc_domain);
 	if (rc) {
 		debug("Cannot enable USB module");
-		return -rc;
+		return rc;
 	}
 	mdelay(10);
 

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-keystone-usb-phy-8338bf3a1895

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

