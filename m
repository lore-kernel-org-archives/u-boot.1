Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F3DC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 16:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7888433B;
	Wed,  6 Aug 2025 18:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gKMZ2zuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5DA842C7; Wed,  6 Aug 2025 18:43:31 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C8D842C7
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 18:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so770445e9.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754498607; x=1755103407; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZASLZ/2husjIZcBM1xd/EbxKWxZ4UzD//v+T+ATsn0k=;
 b=gKMZ2zuSZHKqKnx676v/xlennDz9A7trg4WxAPt2RYcK8lp/ORdX2vluhiYYJi+xNP
 u6G5SDJr7286g+ciiuTMO4Ywh7O/BhY6SoC0XVxKWj7eO4fA9Xfh4zyypECVupi7KSxm
 Vo/dnJQsdZgIMQglm1NFa9Ms6BuqLavKzOLX5O28aBjRElkuh5DouKjMysV7GhNzUPVv
 kKAPQmsXeal1EgnQvLkMUaEhZS/84cz0m6WdgZ6rnMjzDSuH+TPRMThaTLTIuojKmuWI
 Lm0bkbCmrSzetTjYadzXBqGu3zjo72HTSGMRuNufW9b3T9vc/gvjJq0iLYrRzJcLjNql
 vezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754498607; x=1755103407;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZASLZ/2husjIZcBM1xd/EbxKWxZ4UzD//v+T+ATsn0k=;
 b=pVFmnlUnOJ6HY4skghII2p7aGfYX9uR1i6j3rrgDoKC07d0tyKvrU3VtWqz1sUks34
 fQRJxMukWvZEPfLQqXyQhptE7crfN0KizVYmXtV/UO2ooggS8gA6A6DhpWoMGzdzhfx2
 6VGjRlI13l6rEEsAd7mSCJHMQnVv22fqLcaETpi9GO3sSAYhTmbpP6dBPqwe6PdF4GDf
 6NGF1R55CKMRis7TJ5RU9f+J1NqP+8S25wtQJZy06Fammp1e2prQB8F3j+az/ab3BO2o
 hb3sFBonvFHmTkFaOY8kEWB6bYkqsCMId2W2Sg5pDmNjPnbDY8h4XwyLlrotVYwqKRFy
 00Xw==
X-Gm-Message-State: AOJu0Yz9Z9XgSA5ckCLyvbvyldNl5we6a/1841/ASmwP5NbEMYr7igP2
 vNnyH4lCaQ8J22AJu18MJN1hHTKnEHQ4S6n9FunSvx3U6hsSVOkiZWwaogo87ttHdbweN7uTMhj
 +OJqr
X-Gm-Gg: ASbGncvCmK+IF1+x9bRX77gSUtn2/t3BogzNmlNstr0vX7f9VF3vP/n7FniYtdRFfd9
 Bt7vx+cFU8eMzJjxJxygv/CXzWJtj5zHvlLR85w1zFeC5U26YPudiY+7qZz8YNnvsF7ZAvGZhxI
 AtSyiVnE06kiIi7o5B+Los7kAq4M0HK2YMz4PkfjRawslCSqj0mELMTNOUvTT8HpmQzaPYRrWuE
 xVpEWaDvJ6uNmAbFM+LjMWeqQdy6tnpCQ+ccbrkRmiEBdLYHqzkqTrRmuWuL2jndb3nZ0aPbHLQ
 XA6Zophgf82GthCLqW8uftjB1eBbd3LbB1P4LoNiAWJvWiQ6JULtJIxOOLcY+j08nW44DQyVk7L
 YiQfzytsQ0dtb7rv5EYPCYSM6srwbhP7USxo8d2k1sDHRVW/q+0Zcv6oP2Gg5LA==
X-Google-Smtp-Source: AGHT+IFyyEAp8okuFvjjeyf2xKfz15UgvOG/mRCtOuqk4sZayGcFbp5O7RDxipae177mu+T2jhXVlQ==
X-Received: by 2002:a05:600c:6305:b0:458:b7d1:99f9 with SMTP id
 5b1f17b1804b1-459e709aae6mr32322985e9.11.1754498607555; 
 Wed, 06 Aug 2025 09:43:27 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5868fd7sm61287685e9.18.2025.08.06.09.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 09:43:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 17:43:24 +0100
Subject: [PATCH 1/2] phy: marvell: Fix off by 1 limit checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-phy_marvell_comphy-v1-1-ad9f4e789d5b@linaro.org>
References: <20250806-phy_marvell_comphy-v1-0-ad9f4e789d5b@linaro.org>
In-Reply-To: <20250806-phy_marvell_comphy-v1-0-ad9f4e789d5b@linaro.org>
To: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
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

The limit checks in get_speed_string and get_type_string are off by 1 as
they do not account for the maximum index into an array that can be used
is 1 less than the number of elements in that array. Adjust the limit
checks to allow for this.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/marvell/comphy_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/comphy_core.c b/drivers/phy/marvell/comphy_core.c
index a666a4e794e..a4121423873 100644
--- a/drivers/phy/marvell/comphy_core.c
+++ b/drivers/phy/marvell/comphy_core.c
@@ -28,7 +28,7 @@ static const char *get_speed_string(u32 speed)
 		"10.3125 Gbps"
 	};
 
-	if (speed < 0 || speed > COMPHY_SPEED_MAX)
+	if (speed < 0 || speed >= COMPHY_SPEED_MAX)
 		return "invalid";
 
 	return speed_strings[speed];
@@ -44,7 +44,7 @@ static const char *get_type_string(u32 type)
 		"IGNORE"
 	};
 
-	if (type < 0 || type > COMPHY_TYPE_MAX)
+	if (type < 0 || type >= COMPHY_TYPE_MAX)
 		return "invalid";
 
 	return type_strings[type];

-- 
2.39.5

