Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29A4C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A19686473;
	Wed, 23 Aug 2023 19:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7YZd+5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C26864DF; Wed, 23 Aug 2023 19:26:59 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BBBD8645E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1bb3df62b34so830120fac.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692811616; x=1693416416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bv80oMGtj4XFyEYXtHxi3B2AXfPHGAm4NvHihMH6/lA=;
 b=j7YZd+5/up+bphNIGkJb161PMZ7K7EmK92fACwO/bgwGd8owma/Wrf4Fzt8PfrI4mC
 YKMVdGh7lm1NfBaT+PI9jDSDjx36zUmsq61gmnZVV0EUnAUpRbdd2Dm/EhhgSDYt/Fny
 vrPV7/+sgiNgjEW3Vluo9o99mDg9FavSOQ55l7cYjm5kj6hs+/WzN4EMYgnhq0DzKBGc
 4nlQjYvMQwv/MadaO7xgGlKGoS7AUrsuyNqTcdRFWoaN4B+KwUgeTh+EVXcA9dPnPgAy
 vV7y+4103rzbLP4YMVWGn6XbPCSdyq8UQstboIP6w7x9zlapOBCLXWlINwB/vcPkIapA
 2Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692811616; x=1693416416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bv80oMGtj4XFyEYXtHxi3B2AXfPHGAm4NvHihMH6/lA=;
 b=RgrC1GN3cAKJ1q1eXbDfaYDkEm53aNJWn77oP4u1hxNWkaVPsAmwvoq7qrwVEOY/lK
 EhGyulAEb0Szb6H9gxn3kJEjSNPv7G/cXif8ZWvE22X+KHsGfo9ptlEmHbcnKvuo1EFN
 XLSntTUvldp+VviDh9PKUlop249diqsVZ/TnL/Iz7ecQMLFM4Ineo5Qoctn5k7op/O+p
 njvcpbLUwmZoYbUTGdqDtJeal8T53lca3kxEe5avq8qzOiAuaTYPBKifWKWWf0xY7Ib4
 KHOctxNPLFmrlJoYaMEz7PWxWPeBPDOWSgP1S38kAOdrHyZPEHJiTZopsdqVmzNne+9J
 rjqA==
X-Gm-Message-State: AOJu0YxDQCHRW23psA8rV1YRch1IlJTCn/vBJtDyMgrlM7EfwbbjGfzy
 ze4r1NiJOLYgW6VfCE3RQwzVuNwihs0=
X-Google-Smtp-Source: AGHT+IF4TcJVMe3o4tAWZ9fykrPxwcsvF68Qh6Slc1VvzbfAJ85/44/hlFWg46o3UZmO4qm1RaJJIQ==
X-Received: by 2002:a05:6870:ecab:b0:1c8:bbd0:2fd5 with SMTP id
 eo43-20020a056870ecab00b001c8bbd02fd5mr16114828oab.4.1692811615857; 
 Wed, 23 Aug 2023 10:26:55 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ae60:b44a:59b3:894f])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a056870734700b001c0e840ebcfsm7158926oal.35.2023.08.23.10.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:26:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 5/5] thermal: imx_tmu: Increase the polling interval
Date: Wed, 23 Aug 2023 14:26:37 -0300
Message-Id: <20230823172637.303101-5-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823172637.303101-1-festevam@gmail.com>
References: <20230823172637.303101-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Polling every second to check whether the CPU has cooled down is
too frequent.

Allow more time for the CPU to cool down by increasing the polling
interval to 5 seconds by defaut.

This value is used in the absence of the 'polling-delay' devicetree
property.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/thermal/imx_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index f79b583811..15e01b6166 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -37,7 +37,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define TER_ADC_PD		0x40000000
 #define TER_ALPF		0x3
 
-#define IMX_TMU_POLLING_DELAY_MS	1000
+#define IMX_TMU_POLLING_DELAY_MS	5000
 /*
  * i.MX TMU Registers
  */
-- 
2.34.1

