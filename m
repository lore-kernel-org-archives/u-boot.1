Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDFCCA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:18:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0D488A2E;
	Fri, 30 Aug 2024 12:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tRkpNmX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B19788AB9; Fri, 30 Aug 2024 12:17:32 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917B6889D1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37198a6da58so1302845f8f.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013050; x=1725617850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAWQNNp42XhJox51dg3EuFbQ+uZpOhCWpk6e9v5Bwts=;
 b=tRkpNmX+GDxA69/MXLJWvCS1Zq8NaI8zC0gSQwMIeyrWxRnCHSKwoAvWX3eFcWBwVg
 vhNW/hvMxyp6ClUaPaciJPsoJrIEPEaOWMFDkrTEwKhqo8RXg29izfcYi5Jj1b+yglq4
 jkBoi5sw4rZsMSCrQ0CN20jlJbSgmD06qjefd/4nWKencnnbk11fYbksHCe2hFiCFj6F
 8h/iIXR43N1sZQgOz0JZREnt+St8QCMEGWBIaDYk2T8wbQ68yck1vYQ5SSy4rSoSCXOw
 AaqJf7LjxYpIqDxmkTAm5fz1Uk7KM26F0x/e1P7udc9D/RNb6NaVR9lZ0vqzRpRzpVA3
 eNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013050; x=1725617850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAWQNNp42XhJox51dg3EuFbQ+uZpOhCWpk6e9v5Bwts=;
 b=ukL3uvum7dGVjEZPQRxphsuNT+qSvReCmuwe9zTMIr5EodWVPyrOqwR0p0Zcs2JrR0
 IyCTQsiyQsTh19JIryEQCbF52O5FNS/eETHfQV2tMsYEb44hNUB8gkGe3JcFyZXF5NZL
 EppeqlyGYk6ZaH0PMG/Ha/uy/L+8NheTFc/Ua6e59U/2qwaWv/BxzzoB/tVFJrqfWxMP
 qG5UCqIQ28xXKz2RYozAgcg9/1zILl69/KIYUl/1z/Y1WZ390ACSk845+aaDzKWJs79h
 /AEfgyqKcHQBLNozUWuvKR/EA0KdKp6mtQKUCsSjJjgtNajVSma30/08SZzn3yk70JxE
 lZRg==
X-Gm-Message-State: AOJu0YyWiOJJCENYpyNH982Gd879LIaz6zbrfpW46RmPUhxFEXMAxFwB
 tKOS+Bu+f+K5LyRwQPtX4rrMS482b8Uj41GXQs3D3hhwn1WmrddZ7lxcEkm9x+PK3UFeyc8wlnN
 6IqkPrw==
X-Google-Smtp-Source: AGHT+IEf+irVbfo/q5aEgUlHDiNB2aKF6pyLQMseertwVtQeVLfBM5SHDY6EVrR5NAIbiDyXASimrw==
X-Received: by 2002:adf:fd0e:0:b0:371:8c0b:4818 with SMTP id
 ffacd0b85a97d-3749b58afd6mr4477505f8f.63.1725013049729; 
 Fri, 30 Aug 2024 03:17:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/16] net: fm: call dtsec_init_phy() only when it is
 defined
Date: Fri, 30 Aug 2024 12:16:49 +0200
Message-Id: <7d3aba410bc30a42540d0a18d668bf1895337b2c.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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

dtsec_init_phy() is defined only with MII so add the proper conditional
in the caller code.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/fm/eth.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 19f3f0fef0..22025b6a27 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -26,7 +26,8 @@
 
 #include "fm.h"
 
-#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
+#if ((defined(CONFIG_MII) || defined(CONFIG_CMD_MII)) && \
+     !defined(CONFIG_BITBANGMII))
 
 #define TBIANA_SETTINGS (TBIANA_ASYMMETRIC_PAUSE | TBIANA_SYMMETRIC_PAUSE | \
 			 TBIANA_FULL_DUPLEX)
@@ -701,8 +702,11 @@ static int init_phy(struct fm_eth *fm_eth)
 		supported |= SUPPORTED_2500baseX_Full;
 #endif
 
-	if (fm_eth->type == FM_ETH_1G_E)
-		dtsec_init_phy(fm_eth);
+	if ((IS_ENABLED(CONFIG_MII) || IS_ENABLED(CONFIG_CMD_MII)) &&
+	    !IS_ENABLED(CONFIG_BITBANGMII)) {
+		if (fm_eth->type == FM_ETH_1G_E)
+			dtsec_init_phy(fm_eth);
+	}
 
 #ifdef CONFIG_PHYLIB
 #ifdef CONFIG_DM_MDIO
-- 
2.40.1

