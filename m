Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77218C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C8CC87D10;
	Wed,  1 Nov 2023 17:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fIgaKIbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9695876DD; Wed,  1 Nov 2023 17:28:49 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C66D887D2F
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-418201cb9e9so49634341cf.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856118; x=1699460918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldF8IsVle5ixliQX4juG+iNJF1k4SBdw2iB4+Vr8Eik=;
 b=fIgaKIbRAD38FUs9S5TNiMqh9zrC+nxx7m3v4tzeHrmMAIcW3M0rNcu8HwDrEwK9W8
 1KyyIpOVxy8CL93arNNQe6a/HdYe2/1u663FldOupHe2jS+KJCFHqxsKMPMpqhAj85OD
 8seEt8FHrX1YFi6fA2d3gVihM6mUM3DMNLcf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856118; x=1699460918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldF8IsVle5ixliQX4juG+iNJF1k4SBdw2iB4+Vr8Eik=;
 b=MY2VWcUbcmKTlLG6fVU8p/LSCDpxO00hALrsXcB4iHYvhBQQcx0cG410p2tpUSk1Og
 y9JyLNPXfbGx2gf92heYEzn/ZTRujcIYIA5wbpgB/XTh8Jw5AyBHTzMaeXZ7RBsVDhAY
 vSRXdlJMldHMw4BpRkvX0Ks/jriCSRahgJvKJSiYbVqUs61j5KL1i3cBNsNOx56fa1mM
 04TVxob8ltIJw40WgH5EQpLxfj/TipdUOPtZRBh4s/5AU+Lrv61BuACke1BtQ9qVVxD+
 5XDM7PXfEji+eBDWUe23W60St9Ad/8iM3VXLcIV6lN9wzGEVipLZoiZeNIXHMGpyVZRZ
 6jfw==
X-Gm-Message-State: AOJu0YyL4mEVmpI4UijC2C6DTWaIWD/a2EDzfEhWplvciuKxfFPsEebX
 1aPsc2P69whfB+VlCkyKozk/APEdN9dIPuCBPqsSRQ==
X-Google-Smtp-Source: AGHT+IFbvsL2JYY5Gtvhnu0q4KYsDonk0jF2fiLxcrmFDl+VMU2BES0pQ3iTJyAicroY5aMNHf7S5g==
X-Received: by 2002:a05:6214:c44:b0:672:5d11:7489 with SMTP id
 r4-20020a0562140c4400b006725d117489mr10076760qvj.48.1698856118056; 
 Wed, 01 Nov 2023 09:28:38 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.37
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 15/20] include/linux/mii.h: Add <linux/types.h>
Date: Wed,  1 Nov 2023 12:28:19 -0400
Message-Id: <20231101162824.3755579-15-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

As this file uses u8/u16 we need to bring in <linux/types.h> here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/linux/mii.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mii.h b/include/linux/mii.h
index 49e29ac314a5..70689bc53d76 100644
--- a/include/linux/mii.h
+++ b/include/linux/mii.h
@@ -9,6 +9,8 @@
 #ifndef __LINUX_MII_H__
 #define __LINUX_MII_H__
 
+#include <linux/types.h>
+
 /* Generic MII registers. */
 #define MII_BMCR		0x00	/* Basic mode control register */
 #define MII_BMSR		0x01	/* Basic mode status register  */
-- 
2.34.1

