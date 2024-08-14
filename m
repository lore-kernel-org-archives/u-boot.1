Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE2AC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 18:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64AE588A0A;
	Wed, 14 Aug 2024 20:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NZomyvGb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D06889EB; Wed, 14 Aug 2024 20:29:04 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DB7E889FC
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 20:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-201e2fe323aso117825ad.2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723660136; x=1724264936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+22PX4kdUf0sqSlD+VJKx2IZbZMrLX3TUb7Tpf78fbI=;
 b=NZomyvGbjR0f984uRa79IJh+INt2v4CBmFcGqe7DyYw17FC1pIRbFP1NGUza04sCJs
 jj2AMb2sbVoTIDF5AEJMY1dPH76WAAcQVhBRaGmiTXOYRQMwipl4JtHm9VPwj7cHHoMC
 Kw/nvCV0rnccANDet063K9/uTfkpWCtE5wECA0TdX+7bdSZpEuR/BY6pnp0nDJDmrFGf
 lXaCyYapTzFBKvp2tdajLImtViipUFmVZTQjlQ+j/zWE9T/MHSOmYr0KwtkF5uuWbEAi
 qK1rMgWdXKdf/vblPtpRX93q1X5pNoa2Rins0FqGzFiCFxxs+9c8W1qyhBb0iO0QpYLD
 pQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723660136; x=1724264936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+22PX4kdUf0sqSlD+VJKx2IZbZMrLX3TUb7Tpf78fbI=;
 b=b0Jqu1ponOUTkvcrQGt/4Ab76hwOKASmOc2LCLAkPrF1HoMTX5hpUsRO7Z+dU9/LC7
 CuKhFiQ9cN2h2IX6C3MsF1K/x/wPQU+lfF9JmZJMUlWHyVYgK1GXUYJTgOq2PEQBFx7i
 kf9dhc2NQeYsiohR/JTgAU+/1bJSwlP8nxuzfEg6qH4GaEMLyDCI0wCg1agPJID/aCxp
 HnrKpaoMBY0K3lweZSRtQPNkG/WfXGPOeRA1Tluqm3bNMj09KB8Rvy+/1N4DhiUVL/Z8
 zsKTLB9HMg6txZhZJAtNxeGDEUVQs1JJ8VhGaBbxZcV+bUNhpYEcNuNWqMbnLTFICuFC
 kZHQ==
X-Gm-Message-State: AOJu0YwySZPO0lFqCCWwpkzDnRpfMcGr5VpTzSTbLsiRdHoRA2EIv+BE
 AIUyjuy2zng/svQ2Lud9UDvnhV4ZdvzrcNUFr/R4SD8gFKQdOsl3WaRNaw==
X-Google-Smtp-Source: AGHT+IFgjSptRqsPEUO58Ua+0DzMHGx/Qg4qIaWUrLXndoNH3bauXtUv/47/G4RYbqkccSNg4Dxxaw==
X-Received: by 2002:a17:902:c40b:b0:1fd:a428:a021 with SMTP id
 d9443c01a7336-201d654df6dmr26551495ad.11.1723660135868; 
 Wed, 14 Aug 2024 11:28:55 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:31ab:46dd:f2b3:633])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd13149csm32563535ad.47.2024.08.14.11.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 11:28:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/3] tqma6_mba6: Remove unused defines
Date: Wed, 14 Aug 2024 15:28:44 -0300
Message-Id: <20240814182845.762118-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814182845.762118-1-festevam@gmail.com>
References: <20240814182845.762118-1-festevam@gmail.com>
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

The PAD_CTRL definitions are not used anywhere.

Remove them to make the code cleaner.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/tq/tqma6/tqma6_mba6.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 877539e359e..7267d812e7d 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -34,25 +34,6 @@
 #define UART_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
 	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
 
-#define USDHC_CLK_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
-	PAD_CTL_DSE_40ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
-
-#define USDHC_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
-	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
-
-#define GPIO_OUT_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_LOW | \
-	PAD_CTL_DSE_40ohm   | PAD_CTL_HYS)
-
-#define GPIO_IN_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_LOW | \
-	PAD_CTL_DSE_40ohm   | PAD_CTL_HYS)
-
-#define SPI_PAD_CTRL (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
-	PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
-
-#define I2C_PAD_CTRL	(PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
-	PAD_CTL_DSE_80ohm | PAD_CTL_HYS |			\
-	PAD_CTL_ODE | PAD_CTL_SRE_FAST)
-
 #if defined(CONFIG_TQMA6Q)
 
 #define IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0790
-- 
2.34.1

