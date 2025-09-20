Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EECCAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 14:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3361983335;
	Sat, 20 Sep 2025 16:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eUzEonYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA58833C0; Sat, 20 Sep 2025 16:37:08 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AE98004F
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 16:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso1632648f8f.1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 07:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758379026; x=1758983826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J6Taz7P9TldCDd6HG5bUx10TxDFGs+PjAWrR9mu2oCY=;
 b=eUzEonYGOUiNH+CwHpJcuw6HfdCftT0N93bqC06X6/EjLu7CGQfIkmrFKMJ9JbJtRS
 DBDfZMuTHeoQzJrwiBDjPDDvJkmNHTS4pVKKw9AwKQc3jeDsBshzd/wKs7zYpKC0wGaE
 spQcprjm0smu9x2ckIoUfbQLCtHdu71DhIzhbwHE7GmDYIvt9YS5RdxBPGGJhfibPOoC
 VC+1nWAqFhgY3qYSC+3IZNtCeZSOsqbEDe4fKmHlEvLY9ZPxiIUahnTuBvN/rcHOOH8v
 KcJCT5U2DBW7bRHRu88il0dAIjsxWnsRNVkvBig5/q3ni9shqyv6+vr9QOLsBZ0TJyP+
 /iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758379026; x=1758983826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6Taz7P9TldCDd6HG5bUx10TxDFGs+PjAWrR9mu2oCY=;
 b=Kd8hFQf0TfjLwj6ydhTagSqdm5Hh28ZSBzr0xL35KjAUk5xe+mRyNDwuRKlJ4guc/t
 VzdgdmZf/c0GP0GOYPbu0RN+GpEpmForUQA8ouLaMoYKk2pDo/4JGLtt5X7dMBfxEjLo
 4UFu+vJaJke3efrhW9JyD2KRL3kbMLuVfisi0uUvwEgX3meXw8quEoMvLeN3N8UHWpxM
 Al6IwVGcSbnqdxPoSaWO8SWJ8iTxEIossOJT1iP/l5BSpEs5Wys9I8RzN4nDUs2A30/o
 Z02tr7RHGpphkp+lQo4wkYHnPt7MY/2i3xFiujWoJFbO8kj2KW6Oas7EA0MiavTcF4Yb
 Ej3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtUrTEh8udpYB3GTonYTkWGmkOzQx8tFffJvlCWnH7D2NMtg9Fnkas2u2dlMwWNu3KMBjgegQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzpGqaBR8redmqFEhMFnhOB6vpHsc/azBvdjExE5fq36fsKbovX
 eVG8yjTkpz9+d0KnuhBZZqJIgJnStbQIBeNCfrQLgPLJ+v765N5yBXYY
X-Gm-Gg: ASbGnct/1KEUHSMMhyznXzmsd6URufYcxon3EtLwCVFs99bER+OGmY1Bcmj1nQN17ph
 I0Srh+RYjbL8oOquLRerppfK5G8yAocu//f8TqnGzdonzktJGfJbhupkQ6W2OlKAf3DwRFNq5Yi
 xhiDiRmgDGlOTB7touAQcQfVqqNdvnB/SQpR0LSxgzuwZDMDl8v0X0FHNpxOdGIYZKjxYshTQIf
 5Wxo92JvBT/dHZNYE4I7w0k9XhxgVGg9jBWGA41YRmFFhbJFG+sMLppHmPqOpEB2GXw+CHmsP5z
 9ACYQkQkubgC1L1Fqf2HV9p9TjyfZJKMMCgBPYqkGOOKyv4yT/onwPHn+Xvnn/toKEMyKi9IrcS
 LBSbmopUNzXuj6bsJmhVAG9KQjh9oY+szbBAhLLv7sQ1FeavqlE+lPKSxjtxJozQq2U5QTnE=
X-Google-Smtp-Source: AGHT+IFqGElW5x3qpxRQlaVHjJdmti3S9oJAXJBuI4N+JkQMk0OpR+ZGMzd3tnPQEh4+rLo8wQ0T+A==
X-Received: by 2002:a05:6000:18a5:b0:3ea:c893:95a8 with SMTP id
 ffacd0b85a97d-3ee7bad112fmr6224258f8f.7.1758379025644; 
 Sat, 20 Sep 2025 07:37:05 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fc00a92sm12353716f8f.63.2025.09.20.07.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:37:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 2/5] net: mediatek: mt7988: restore PHY page on PHY setting
 exit
Date: Sat, 20 Sep 2025 16:36:47 +0200
Message-ID: <20250920143656.29770-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920143656.29770-1-ansuelsmth@gmail.com>
References: <20250920143656.29770-1-ansuelsmth@gmail.com>
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

On exiting the phy_setting function for MT7988, the PHY page is never
restored to Page 0. This can cause all kind of problem with reading the
status of the PHY at runtime.

Correctly restore PHY page on exiting the PHY setting function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mtk_eth/mt7988.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mtk_eth/mt7988.c b/drivers/net/mtk_eth/mt7988.c
index bc58462af26..74e16bf49e7 100644
--- a/drivers/net/mtk_eth/mt7988.c
+++ b/drivers/net/mtk_eth/mt7988.c
@@ -36,8 +36,10 @@ static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
 		u16 addr = MT753X_PHY_ADDR(priv->phy_base, i);
 
-		/* Enable HW auto downshift */
+		/* Set PHY to PHY page 1 */
 		mt7531_mii_write(priv, addr, 0x1f, 0x1);
+
+		/* Enable HW auto downshift */
 		val = mt7531_mii_read(priv, addr, PHY_EXT_REG_14);
 		val |= PHY_EN_DOWN_SHFIT;
 		mt7531_mii_write(priv, addr, PHY_EXT_REG_14, val);
@@ -46,6 +48,9 @@ static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
 		val = mt7531_mii_read(priv, addr, PHY_EXT_REG_17);
 		val |= PHY_LINKDOWN_POWER_SAVING_EN;
 		mt7531_mii_write(priv, addr, PHY_EXT_REG_17, val);
+
+		/* Restore PHY to PHY page 0 */
+		mt7531_mii_write(priv, addr, 0x1f, 0x0);
 	}
 }
 
-- 
2.51.0

