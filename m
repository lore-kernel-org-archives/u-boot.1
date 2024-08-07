Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE400C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23BE088A8C;
	Wed,  7 Aug 2024 16:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Np5rb02H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704DD889EF; Wed,  7 Aug 2024 16:08:23 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E198588BB5
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so233205866b.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723039699; x=1723644499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vW/9RFtF6l7pYrnRaUq4KZeVkYPPmUti1cDF7Hb+ftk=;
 b=Np5rb02Hr2Xk/ECLE3S9JKvrgq2WlNT08r2fhjUk6CsiAwubj1nProrHQekGSnYNSy
 84M59wS9kBkyM7wJ6h0zAIHboWzTm0JwxQmHzMktYTvnSi0w2M2S4Kqi3TJWnNn/QiE5
 nX/j8rp/BWPG9P/5K62ZcD99rzYlnSW3aef5hergg+C0NDAbNpg0orYQfisT5GHF7pmB
 vDEjFuqmwhQDu4l8oi5Z0iI9kg4krPJ4JTrKC+WAkHK3zb++AB0Iecyj2L4PwnBU9C7f
 lrwBl+MH+FVe8QPu11Q7A435YtUjAJIv98iG7UdENgi85C529OXybouA+NRipUCR2kgZ
 fJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723039699; x=1723644499;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vW/9RFtF6l7pYrnRaUq4KZeVkYPPmUti1cDF7Hb+ftk=;
 b=jroeFAodmLPUeZqb/ebSBkx5l2r5XglFPkvNe5doOdRejS0AgH93fmy8kMZy4G8xJf
 NJSs+tkIapwuU9qN0T6g11rJeHPYgY0xK9gGIyrDd8QxE1WUux9O9r9tfcDnzq1+atkT
 Q8WoSC10U7q7ab942WGAVjZCSrPwXWiOe/en3AT9IYD8h/VNXWi57KiLj3Y1Vw/sh2CV
 F0NY6cYqkt7BgR2aowVvxX3GkR99m7NHFku3dzLJaaIXO/j6ZH2hCLZ2DUyE7UFMGUib
 YSj+5Tj12F2xgbeGkoX/1PxDUgF7A59vYugQuZBaua4IfurG/JufRJisw0jrsLSwfc/r
 lN7g==
X-Gm-Message-State: AOJu0Yx9/LFxqlFwIE0PMRRD13KDCIEl0bkPVN8V2XlvoXS1+QmQMl+8
 +ZRfQSmlL61uvKoAgcTCc4C7P6YeGtgTi5gUaQywFcRHjKjApjST739gmg==
X-Google-Smtp-Source: AGHT+IHkcDq/Ly6A264iLaxMBwpTLc/BIh8bAfmmGGSon3yIHvsSDqeZOEltua71whGTh+5GFExPyg==
X-Received: by 2002:a17:907:c1e:b0:a7a:9f0f:ab14 with SMTP id
 a640c23a62f3a-a7dc4fa16demr1407520266b.33.1723039698719; 
 Wed, 07 Aug 2024 07:08:18 -0700 (PDT)
Received: from mafrox3.fritz.box
 (p200300c8071991002a9d74ab3dca2577.dip0.t-ipconnect.de.
 [2003:c8:719:9100:2a9d:74ab:3dca:2577])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0ca0bsm641278566b.74.2024.08.07.07.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:08:18 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 1/3] i2c: imx_lpi2c: Fix a typo in bus_i2c_receive
Date: Wed,  7 Aug 2024 16:07:59 +0200
Message-Id: <20240807140801.1718483-1-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
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

From: Fedor Ross <fedor.ross@ifm.com>

Fix a typo in a debug message. It should be 'for' not 'fot' .

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---

Changes in v3:
- none

Changes in v2:
- Add additional '---' below SoB line to separate Cc list. This way it
  does not get included in the commit message when the patch is applied.

 drivers/i2c/imx_lpi2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index a1be841b119..3c43f61d819 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -130,7 +130,7 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
 
 	result = bus_i2c_wait_for_tx_ready(regs);
 	if (result) {
-		debug("i2c: receive wait fot tx ready: %d\n", result);
+		debug("i2c: receive wait for tx ready: %d\n", result);
 		return result;
 	}
 
-- 
2.34.1

