Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402D7C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94512871C0;
	Wed,  8 Nov 2023 17:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SBzTYVNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985718749D; Wed,  8 Nov 2023 17:49:07 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BFC874A3
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d76904928so43392896d6.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462142; x=1700066942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAPTkJa4tN6E8ZgahKgZs1nUvVGwc9xebnkrI6bMXfI=;
 b=SBzTYVNr7myGNDGe0rWxwjaT4IBrVIVTIlOLxZchHXGgZzS1beXC3lqGjtVSlBz1IY
 pXQfSmARQ8pRpnTDJQEX+KWxllbDJH0eTu3Q7Eg1soIldmYKLcZOZZ9ft6rer4gMSTuE
 3PaetN0EttImpdulLSSEXL1tKUdA3AeljZFfA/zF6+84I/cUafuKI/q3DbNnitnmCcB6
 rlc6s1iZZIeOlh0YoBdglZiXu3PhnxN/YfwJ0QdwrOrO8Dgar8GUdYP/0QcOPvNv+jgT
 kKSGRB1LfrSw3ZvupVYAp/+vtlvOQU0toxgsHtjS8KlIi4jBQ5c2uPT6c/c3syDTdlYU
 J7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462142; x=1700066942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAPTkJa4tN6E8ZgahKgZs1nUvVGwc9xebnkrI6bMXfI=;
 b=hOufA7fO/ovgcijnaJWM2hmvhfnbHZRuSR51dewCnryB16eyfRj+KrXWQmNzPq40An
 SCLQz6D776Mz0kO3sbD+EZ2o4R14BZH2ks34nCJqXIh59XKXP1e/ZeovTxr7WKqLU14n
 cyBdu+ATnjOYkWz7RZJKiFwpeYKRldwzc/Sfv3UTGQNsz1kAxD2oJdQ8nm7YblFlkq2e
 s1vRGAlyVzzOhAJcIe04tdqsrff27w+GqGLt26d0dh11pTwhNMr2sUeUw81fGEfNnaaZ
 LsNQVz4PDgFxPJcyDKv3QRrI69K+PnMeEdzVj3ZH/IiozcK4/CkpeVjNegNtjEOJNVcn
 3SNQ==
X-Gm-Message-State: AOJu0Ywgkpc1aVWCYzzFs+6HTsIRj/NN/6UYClONWlyWXDIwqLR7Qjjj
 otHaVIOBw90N4s6xC4GwTG8=
X-Google-Smtp-Source: AGHT+IEIdwHsHwHD2l7DwjxCO6N9qylmSPPk84tfsek2nU5PhY+OfkXz/w15UO3ZRLw9zIGC3/WpNQ==
X-Received: by 2002:a05:6214:29e5:b0:66d:6266:40d3 with SMTP id
 jv5-20020a05621429e500b0066d626640d3mr2430828qvb.27.1699462142565; 
 Wed, 08 Nov 2023 08:49:02 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 m21-20020ae9f215000000b00767177a5bebsm1207491qkg.56.2023.11.08.08.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:02 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v7 01/26] spl: blk_fs: Fix uninitialized return value when we
 can't get a blk_desc
Date: Wed,  8 Nov 2023 11:48:33 -0500
Message-Id: <20231108164858.3497420-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

Initialize ret to avoid returning garbage if blk_get_devnum_by_uclass_id
fails.

Fixes: 8ce6a2e1757 ("spl: blk: Support loading images from fs")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

Changes in v6:
- New

 common/spl/spl_blk_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 63825d620d1..144c8a65b5d 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -50,7 +50,7 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 	struct blk_desc *blk_desc;
 	loff_t actlen, filesize;
 	struct blk_dev dev;
-	int ret;
+	int ret = -ENODEV;
 
 	blk_desc = blk_get_devnum_by_uclass_id(uclass_id, devnum);
 	if (!blk_desc) {
-- 
2.37.1

