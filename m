Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF5AC48260
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 16:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4A387E0F;
	Fri, 16 Feb 2024 17:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="COs/rzNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B071887E22; Fri, 16 Feb 2024 17:35:45 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6B487D66
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 17:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 38D2740C7D
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708101343;
 bh=flvIYZipw+J517/kBhyGlbR3XREq19WPu4Cvxu39SJQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=COs/rzNBLNzSwrCm1rlVPXFv9t9SBv5iYvyDJkbUQx3AJnqo1fby4U1KyJm5WgAn+
 tpQflv9YQ2rYbVhdWjO41aZljJGaH6IPjEvQObdSlWPM544cd0/a8b32TyKdKrqduI
 xxAXoGrDiVINT9LSIzddPdLoPo7vtcMDAxR83FxbIoqlNHZyApIzTuEaD52zoT7Ctz
 fbW/LjpUh+sIlpHw7G2qYbfunoChzjfZAff7aLfGJbBMpEV6CbE6neMW/NIWT7hNWh
 uXVig36rApEuuSwlYG1CcH7zTPhYne+/0yv3k0pLQov6r8D/zm4FR8JFoq/K7E2RwC
 Nq6AgyhjY5Rrw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d62d3ae0cso12191495e9.2
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 08:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708101343; x=1708706143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=flvIYZipw+J517/kBhyGlbR3XREq19WPu4Cvxu39SJQ=;
 b=vf02dFEsXW2U405IG6zoaZklpMtw5tc50g941a7KpSb5kFJ7zUb2lU6/23itRB23Zs
 MGK64v+bDF/KCZrwtkMFiiAwAXC6k2k0IyPM3ScKIJxPG33hR6eZgOgKVxK9K5vJtU5X
 esDweSH0deOJKJzrhVgHIFrjFrAnp8YBTjX/WtxJNGGfWjU2y7JeBTVFY6x4DNx9yp1b
 LTlGL9tTzkAC4JCo8pkptR1nEFQ7xrDHluFGM2AVUXzpu8wWwamvRy0yB6dAnwaQZER0
 M7SEnEhpeB4iEfp/xD3lTrxcoNJg7LXJvTi7K22yEvA8Y+nmuqin/rRpUZ7fVz4WqF1b
 E/4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZSdBR2pQtzpeA4o4/rrSOxf8mNtw1i9M3hX2i/Dq008qhx9CyQxmHbUujjW8pYgllswELluOA/l9q/GADkhsxwZou3w==
X-Gm-Message-State: AOJu0Yx+lrJw8A3mazpG1GhRYIZR+h05bh+oBfoLsv13tMSwqtURzi1C
 QpUYKMB/tHSiCATZSFnjCrMYoF/ggkCRaZn+LP2AEJqdVnePuZGIVDIZZ/mZHSJYCna7M6F0viQ
 f+yX+nIWTaa3PFmJlhlB5//QHdCCXL8v+iHYxgfS1wrd3HbrditW3tn9JuDRMpj7ShSc=
X-Received: by 2002:a05:600c:1e09:b0:412:457f:70b6 with SMTP id
 ay9-20020a05600c1e0900b00412457f70b6mr1501980wmb.26.1708101342914; 
 Fri, 16 Feb 2024 08:35:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmY5OOrcZAdAB08OhAq7qVbuMTgrbxTLjKLvQggkP1REeqr3QG7zPst825chZmRNYRMzBblA==
X-Received: by 2002:a05:600c:1e09:b0:412:457f:70b6 with SMTP id
 ay9-20020a05600c1e0900b00412457f70b6mr1501967wmb.26.1708101342610; 
 Fri, 16 Feb 2024 08:35:42 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 ay33-20020a05600c1e2100b004124be777a7sm2084595wmb.7.2024.02.16.08.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 08:35:42 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Anup Patel <Anup.Patel@wdc.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] clk: sifive: append missing \n to messages
Date: Fri, 16 Feb 2024 17:35:35 +0100
Message-ID: <20240216163535.275085-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

If multiple messages are written, line-feeds improve the readability.

Fixes: c40b6df87fc0 ("clk: Add SiFive FU540 PRCI clock driver")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/clk/analogbits/wrpll-cln28hpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index a3cb109d357..537c696b727 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -81,7 +81,7 @@ static int __wrpll_calc_filter_range(unsigned long post_divr_freq)
 {
 	if (post_divr_freq < MIN_POST_DIVR_FREQ ||
 	    post_divr_freq > MAX_POST_DIVR_FREQ) {
-		WARN(1, "%s: post-divider reference freq out of range: %lu",
+		WARN(1, "%s: post-divider reference freq out of range: %lu\n",
 		     __func__, post_divr_freq);
 		return -ERANGE;
 	}
@@ -229,7 +229,7 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, u32 target_rate,
 	int range;
 
 	if (c->flags == 0) {
-		WARN(1, "%s called with uninitialized PLL config", __func__);
+		WARN(1, "%s called with uninitialized PLL config\n", __func__);
 		return -EINVAL;
 	}
 
@@ -335,7 +335,7 @@ unsigned long wrpll_calc_output_rate(const struct wrpll_cfg *c,
 	u64 n;
 
 	if (c->flags & WRPLL_FLAGS_EXT_FEEDBACK_MASK) {
-		WARN(1, "external feedback mode not yet supported");
+		WARN(1, "external feedback mode not yet supported\n");
 		return ULONG_MAX;
 	}
 
-- 
2.43.0

