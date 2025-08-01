Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D13C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 11:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C8983A48;
	Fri,  1 Aug 2025 13:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S9ocA58t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0281E83A7D; Fri,  1 Aug 2025 13:59:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E555A83A47
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 13:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so11937455e9.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754049581; x=1754654381; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x86om6SlYg8xti+03S2SLtaJcTDs1dORAsnwrJpTQDk=;
 b=S9ocA58tz+V0DRq0SPmb3xy35wZFN3z9PSFbnbiBQz8YvBENVtOIjG85oHlViB+oJm
 jZTl1xglXzNpCzeCe1WF7kpMG0PpU7xDRdepjrIrDa0tbxQCFtENrIbhPMCZMJ0JTwB8
 CRCmIuTdVb0BWd2Q1I23ktBlhW0KQBrBLJjcTpjjuCPuUDXRclIuEf7DwIow7zlqpFFv
 gcZg61feCXn3gUxfB8hePiD03rhNUPQ+0vC+PC7kveMg8GqHndAhR7qfRroDtSP9AEXV
 pWfbWM5lk3e3Rz6RxFoL477CvSyal40M0voe+M6FeQMSF9M0H6tOXpIu2xsYKzC9gcoj
 HCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754049581; x=1754654381;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x86om6SlYg8xti+03S2SLtaJcTDs1dORAsnwrJpTQDk=;
 b=AIEG6JIN31gBFhLy58SGKERtFox9iEF/r+iK6G6pne176zoniR1YJf+IGJ178boiso
 NbKinZ40YjH2SK+1k7aLn44EpDGmubVBLc8sLEfOxL2C61Ff4QqjcS8TX1vBdaEhnYs9
 /ugLbuFX0KiEtpZ1SHcRkeHbXVXZ9O6MhCsOwg8RXdVKIVbPyMyxJWMOFkIigZsGpmYd
 IGHRB+4rqzywrIaaCKWp4Agay/tCV7fp4iALE2Mn/hqjtC4+ootcO999yhDibqh9+Cu0
 S710ywnEWquWRi2TlSQwI1kNG2YKlh2cdQHVyMIh8X+L72K1KbYxfUMroVXW9mFE9HUe
 Wfqw==
X-Gm-Message-State: AOJu0Yxs05u7HFwaMMiBsIO0EyU13sSEcsJdMiifOCdOm/2UINZHdcY+
 e6bdIqoITSyK7n/0/uLyaBDV84RGgTz2QVjktNrFogPAZuesfJ+Sb82ljR7/PWqikcA=
X-Gm-Gg: ASbGncuSv3yk+vIN5cc7qQ101dJzEVGfjTmoRy0waLnuDT8cIswb4nY5+ACbw6hKRhC
 bhpbUaxTqxCOwrHBe2g8h24cFLzR/1VaJ4+2Gxi7L/enXp310mOOWnoPlF8k5rzF8uJ+FiKLDRs
 VF9w/DMMucdqRI1J18Aaazy/MLIPNecZvtqEfe0jvCngHXzRM4Brg9J3ZOO6pWRNPAFL1PZzow4
 P+zJqS/1VHt3u+aKqc/pXE1dUgi67PeX9nkb6X4yuOI5fnWEVc+KdiU3YQy/RAB/MyO8agcnL4d
 GRotWliBA1/wcmAi3Xq+KIp6Q56JocK5ZNuSLggRvEaPjkqBn5RHbTmXBWLbBZ2nAOiXQHG5u0K
 rgilaJoY7MbLmFqyOFrkdqdzHoWMBiut3SB+2+0JoqmwYXPshcsvRIxtoMhkbwg==
X-Google-Smtp-Source: AGHT+IEl0GxlKWtNe5qFtSBa5fD7AQLGonQz5kHlDgF1B08+RFFIyXa/JbB0uySobqbC+Ne5L4udIA==
X-Received: by 2002:a05:600c:470e:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-458aa318403mr23672065e9.7.1754049581391; 
 Fri, 01 Aug 2025 04:59:41 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c467994sm5629653f8f.50.2025.08.01.04.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 04:59:40 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 01 Aug 2025 12:59:40 +0100
Subject: [PATCH] net: cortina_ni: Fix typo accessing wrong phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-net_cortina_ni-v1-1-2e492a59fe09@linaro.org>
X-B4-Tracking: v=1; b=H4sIACusjGgC/x2NQQqDQAwAvyI5dyHaVWq/UorENWoOjSVZSkH8e
 9ceh2GYHZxN2OFe7WD8EZdNC9SXCtJKunCQqTA02LR4wzoo5yFtlkVpUAnxyl3bx4gYeyjRSM5
 hNNK0ntmLPLOd4m08y/d/ejyP4wemnoa4eQAAAA==
To: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
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

In ca_phy_probe when checking for an external phy it uses a field from
the internal phy due to what is assumed to be a copy/paste typo. Make
the obvious fix to use the field from the external phy.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/cortina_ni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cortina_ni.c b/drivers/net/cortina_ni.c
index 79026882800..21b7089176c 100644
--- a/drivers/net/cortina_ni.c
+++ b/drivers/net/cortina_ni.c
@@ -499,7 +499,7 @@ static int ca_phy_probe(struct udevice *dev)
 				 dev, priv->phy_interface);
 	if (ext_phydev) {
 		ext_phydev->supported &= PHY_GBIT_FEATURES;
-		ext_phydev->advertising = int_phydev->supported;
+		ext_phydev->advertising = ext_phydev->supported;
 		phy_config(ext_phydev);
 	} else {
 		printf("CA NI %s: There is no external phy device\n", __func__);

---
base-commit: f5e968a28e7cdc2c4365f5a382e02f074ee03fac
change-id: 20250801-net_cortina_ni-43e659440049

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

