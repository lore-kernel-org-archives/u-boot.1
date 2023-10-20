Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB5CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 12:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B2E68748D;
	Fri, 20 Oct 2023 14:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mDg7cDye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F10874A4; Fri, 20 Oct 2023 14:42:09 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 807C68715C
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57b83ff7654so27147eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697805726; x=1698410526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1EimPiFhctOCLnmNn2LVB6IFLwoeYK5ejbbPDMmIsOI=;
 b=mDg7cDyegpgA5RKbSeY51/Dxr6c1XAIz9GnrCaDqUbcktR7rEI3oPXDEr0Wlexf+i4
 OCClyY29VFGLkN23UVDBkOzhvB0ztOlwaSK0AngKXerXm42OCD0OGQufBHAjMx1K+Z8x
 fyazFtuhM05K+TQ1lUNiRoH+DtVgfbtdZtFL4d5rNcG9QeDNPuSF6WLgDoegqZkGW00H
 FA0banab+HJdhdB0ziK+hPTJgOWbDM87iktU89Jk/oazcR9QwL3tFR0jIUHWV3AVijl1
 ZvGRZ8EXrUTSZD7PeKlGqYiuz9ENAGJ0t4Rs53USWuI8J/lwb+AfeQ702xkwSy7hwU4a
 9neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697805726; x=1698410526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1EimPiFhctOCLnmNn2LVB6IFLwoeYK5ejbbPDMmIsOI=;
 b=N2ylHcYdWB20GNAwZloZ7v+6l5QP2DGZ7BAAxkAXfKokCubLJS4qfPy0LOkUcwKaIB
 p+tWCuTWR5yXbin50DOpdYbqsNLUeQsu5YHXki62g7hvNV1lVuO0+u716PrzBh67AJ4Z
 zoz8LU5u2wnkndX4NjxirDwsOXy8b+M3FBKioo+4XJbkLi41zgCw1aXUx4CeJ5Qho0aZ
 mJWRpD9m+SSKQcC994H1v4kV4j3d7rjFwQQiv9tQXWH4GizLg+e6gcwgItVGcYMvV+QF
 4jfqYHu185n71Cp5uf8Veh1/WhJCGTUc5jaQQ5BKrwAzynPeiONNm3qiWNe7kjv4nDw+
 8ffw==
X-Gm-Message-State: AOJu0Yyc6DhC4wv6mfk3H81J5VnyNQpDcIkCgM/QvnABfj3kM/edwAkH
 C+1yirzI3a+IFwrAgI48s90=
X-Google-Smtp-Source: AGHT+IEw8QEqhjMEpT5KZ3c8xkJMlc+n/8+wKWGIlsDehgL0KkbnEv6QjKHRzZWDJJD2wor3FQVsPw==
X-Received: by 2002:a05:6358:786:b0:168:a3a9:80cb with SMTP id
 n6-20020a056358078600b00168a3a980cbmr1737370rwj.3.1697805725783; 
 Fri, 20 Oct 2023 05:42:05 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3e7c:d792:385f:d139])
 by smtp.gmail.com with ESMTPSA id
 m188-20020a6258c5000000b006bdd1ce6915sm1494635pfb.193.2023.10.20.05.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:42:05 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: joe.hershberger@ni.com
Cc: rfried.dev@gmail.com, LW@karo-electronics.de, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] net: eth-uclass: Improve error message when MAC is not
 found
Date: Fri, 20 Oct 2023 09:41:51 -0300
Message-Id: <20231020124151.1968187-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

While bringinp up a new board without the MAC fuses programmed,
the following error message was observed:

Error: ethernet@30bf0000 address not set.

Improve the error message to make it clearer the reason of
the failure.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Reword the error message. (Lothar)

 net/eth-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 4311f3fe6e89..1f0985ec52ca 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -594,7 +594,7 @@ static int eth_post_probe(struct udevice *dev)
 		eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
 					      pdata->enetaddr);
 #else
-		printf("\nError: %s address not set.\n",
+		printf("\nError: %s No valid MAC address found.\n",
 		       dev->name);
 		return -EINVAL;
 #endif
-- 
2.34.1

