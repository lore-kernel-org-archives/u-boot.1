Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A96CC87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 09:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE738398B;
	Wed,  6 Aug 2025 11:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L7OQZP1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08978399A; Wed,  6 Aug 2025 11:37:35 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6058683981
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 11:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b786421e36so3663239f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754473049; x=1755077849; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xnau7gjRKcNqd0UtmZZrVxR5/pbtLHStEN7gL2VzPws=;
 b=L7OQZP1jP6KsB8u41fXrtxXP5Dp1djsOr/UXL0t/hMAPbjtiRLTa4+fLo++FIqD0ei
 3UOM9sxm2kGRSgULSAHoFdBrl0Q6/pEvqUr6PILz3hirvCCcDxVowdPFy+IbfkzqaprD
 zHTiRuMihVSkPiFbvnsl4GN2dkLDNOsH7FNnbtnu8FLO6lpYym6KEtwfeIzw1iniloGt
 zTPD3weydQJJG/grCX8cuSmHb4DEj0Fog3W5mZIpQgXJNSZ5RKF/fUig92w4La4ayaAQ
 GKvj1HeHTMok4n50Ixl/yFieBsZuQd5tBMr7Sp4VmXRp68MG6UBWqY0ksoo3w7SC+3yC
 YK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754473049; x=1755077849;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xnau7gjRKcNqd0UtmZZrVxR5/pbtLHStEN7gL2VzPws=;
 b=suQn6GhqcuRCe6bNCgwkrWMgKeDXN9/uAmJyDbv3LH2YNGzVrCePzxA5fq5+birzyD
 jn2PV306sn5jta888q6X2LYz+0HNTHj2HP7IglaioGliZEeMUo1DKxK7av89fZidth2y
 HCqghJADDgnXulxKMBAMFtT9YnwI9+teQDOWl7T8Mgk75/IqVz2xPuswM8x/Z1y7X8dX
 jAXUebqUqLobSJn160shG4WPmZLQWrEevzb7vd64trSmghefJDM69wE6bubG+pStmoqq
 lJAfExZdHRyfuJeS+FeG23Xhv9LIKmdXIRtVaBqDvopi04k6kl9WCe/ApUzEtxsyuNVK
 KY1g==
X-Gm-Message-State: AOJu0YwoQb6lDCfJyYYosCpCY/kgttm4xgGJCYMCfL9QttsvvJwC5F+9
 FBo/dz/c28hE6AyCL7AXLC3Q7HCwMMAxkMhPBOD8bcwqp1ZXBpz+bCbPO0DkyNiqWbI=
X-Gm-Gg: ASbGncuvpdiXpGjZgHLOiJTtrarxW8xL8QlpZa9GInlPxt72TqIuV1LxKVrkr92OK+n
 NC3dSJWzIJOJSMNx08yRxucZybNk3orC7L4taA6sQJ8MVoFhizenWGVqrYSLQhQCwf4FLERNZNj
 GTqLjajuOBVaSgK3osINMHl7j18biEbSGAxZzK5kSG7/XgUhL2Y4aMA5GRlLJvQ6lPT+TY7G0wL
 7RgwZz0PudHfPwhEjWFeX4h2/skGhq4WhLUrZ6qIRB/Jnin1pkcgZ87cJaU07qIX0qFZZ/iAZXo
 wxmVa86EHuEcKX0HadTt0Fx89sykU3FZvrp2hh8O4wyWYXnG/7gEfx0JpzD6IhKiBWMQUOVQ1fn
 X2aGJh6lwvzmhVLzvqEXZKvKzNMZIw3KKPOmwmt2V6ihBADBp54M=
X-Google-Smtp-Source: AGHT+IFekwl2gpD5zw/Mlk2+3n6fw3iYz0yJjMQbFAI7HA6n/pUrWJpJTDcaQoLhhl81sL3TloMIjw==
X-Received: by 2002:a05:6000:1ac8:b0:3b8:d893:5230 with SMTP id
 ffacd0b85a97d-3b8f421058amr1796911f8f.47.1754473049340; 
 Wed, 06 Aug 2025 02:37:29 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458be70c5f7sm162055445e9.26.2025.08.06.02.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 02:37:28 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 10:37:26 +0100
Subject: [PATCH] net: phy: vitesse: Fix incorrect test for timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-net_vitesse-v1-1-47f5a923d586@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFUik2gC/x2N0QqDMBAEf0XuuYEomBZ/pUi56FrvwVTughTEf
 2/Sx5ll2JMMKjAampMUh5h8UoH21tC0cnrDyVyYOt/1/uGDS8ivQzLM4GIbQrjH2S/cUykiV6m
 cprU2G1uG1mFXLPL93zzH6/oBoioalnYAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

In vsc8514_config there is a while loop for detecting a config failure
using a timeout counter with a post-decrement. In the case of a timeout
this will result in the loop exiting with timeout == -1 so use that as
the test below the loop to detect that the timeout occurred.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/phy/vitesse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 4867d1931b4..821d3878236 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -239,7 +239,7 @@ static int vsc8514_config(struct phy_device *phydev)
 	while ((val & MIIM_VSC8514_18G_CMDSTAT) && timeout--)
 		val = phy_read(phydev, MDIO_DEVAD_NONE, MIIM_VSC8514_GENERAL18);
 
-	if (0 == timeout) {
+	if (timeout == -1) {
 		printf("PHY 8514 config failed\n");
 		return -1;
 	}

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-net_vitesse-b16667bd0fa5

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

