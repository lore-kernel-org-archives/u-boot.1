Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9615DC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 10:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B0E8824C;
	Tue,  2 Jul 2024 12:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZVgFD76J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B3687B30; Tue,  2 Jul 2024 12:26:26 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1745A8824C
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 12:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f39bso539420a12.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1719915984; x=1720520784;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKSz/MAwZqiSx2IVYz9XZH7IHjTJaNMEgXrm4Jts/4E=;
 b=ZVgFD76JGeaAGMxlNbheC4gbLkqsm2XXcn9o2MEtaiLIZmxoZiJd2vZzHLAt+HnVQC
 5GslfpUn2eKnnKTPmY33x6e5wRf5yLjD4NiM6tporKJleDXqAI6A7VbsFJdGTBw635da
 l4bxHa734jXXW5VJF2hScNaeLNbV1VUcjDBlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719915984; x=1720520784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKSz/MAwZqiSx2IVYz9XZH7IHjTJaNMEgXrm4Jts/4E=;
 b=KGX9P+KFs2G3eZrt9NUrZ0WVCiZp9b0OQrNhe1QwR6CqyEVQYJ5Fn3IhmZHc99eGPn
 Gq1BtVthjy4xgg2fddLNv0ma9gNP/k8H1xJ7NSX2GMd+fChVyu2EEEQgW44wcAFydVB6
 YU8JFRVKwfjW9qsyRD/3xRd+vXQo5Wnyt695NmiT0kf3dHDOYu6E7/BP4o3JMyjuU1iu
 rgS9DfPxUpXc+lW4YMuGRaC6t9okHry69XRyBO1bvBroJh8NQYG5E3mBsHle9nKFCNk5
 zRuYlMUBZztYVxdWYquPPGHysfJ8pzNScnEw/eG69InZqZ4f9h7r6Wr4/uEwIwIEf6iL
 qYyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD7nN6YSYwLUlRvAFUbd9564amkGq3DAmxhhsvHFkIcG/T9A7srXSZmMfwwUQ7FNXBG/3l2I1Nh7D6oJ3ET1jNSSI62w==
X-Gm-Message-State: AOJu0YyK4Zyg2PGBRXwucVai5sCudeSYROfShcgeUPFIf38QJkWfGif5
 qIeoj9tLyXlren8LumxVLHlmAynwQUEs6sKF6zoqXFluOmf+mqrhaWTXzRv6zYU=
X-Google-Smtp-Source: AGHT+IH1BkYlwym5+BZsw3V6W111lh932a9ORFDQOCEyrDCCL6gSShh07t2Ufbz9bYI/vwL5JIQqIg==
X-Received: by 2002:a17:906:c152:b0:a6f:57f1:cebb with SMTP id
 a640c23a62f3a-a75144857acmr728893166b.50.1719915984429; 
 Tue, 02 Jul 2024 03:26:24 -0700 (PDT)
Received: from panicking.. ([2001:b07:6474:ebbf:8e6e:944f:275e:2a97])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ae84b3d8sm391253066b.121.2024.07.02.03.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 03:26:24 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/2] clk: imx: Fix wrong flags assignment clk-composite-93
Date: Tue,  2 Jul 2024 12:26:18 +0200
Message-ID: <20240702102618.466652-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702102618.466652-1-michael@amarulasolutions.com>
References: <20240702102618.466652-1-michael@amarulasolutions.com>
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

The mux flags (u8), div flags (u8), and gate flags (u8)  are not the clk
flags (unsigned long). They have different meanings

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/imx/clk-composite-93.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 6d71c0c03ff..34026c5e42f 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -103,7 +103,6 @@ struct clk *imx93_clk_composite_flags(const char *name,
 	mux->mask = CCM_MUX_MASK;
 	mux->num_parents = num_parents;
 	mux->parent_names = parent_names;
-	mux->flags = flags;
 
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
 	if (!div)
@@ -120,7 +119,6 @@ struct clk *imx93_clk_composite_flags(const char *name,
 
 	gate->reg = reg;
 	gate->bit_idx = CCM_OFF_SHIFT;
-	gate->flags = flags;
 
 	clk = clk_register_composite(NULL, name,
 				     parent_names, num_parents,
-- 
2.43.0

