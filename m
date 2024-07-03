Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF93C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 09:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836C7887DB;
	Wed,  3 Jul 2024 11:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fDLau7cR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CD6887CA; Wed,  3 Jul 2024 11:05:18 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5CD5887A7
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 11:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a72459d8d6aso529147966b.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1719997516; x=1720602316;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjmTckBV+07wWKN3HJ+3wUh9ZFw51lqArJvINqyjWlI=;
 b=fDLau7cRX7udzkUvU755vwEWorYOpzD115BKKsNoeVnbzOOL0Xz89sqMBIgfWoWD2w
 97hP/oBIFqebWLelmkacSXZ9MF/hbt8qfzf7iF2668FVNg656JAPsIuhea6rCWA3wfPt
 S6TSE8uJHh/E8VwVxG8YhByYeIrw6Azv7IqsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997516; x=1720602316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjmTckBV+07wWKN3HJ+3wUh9ZFw51lqArJvINqyjWlI=;
 b=JBeuVug1DX2XX/+SPD0/z9HAU9s78irOqHiEbGh60Pm5Jg7PqdsmvoSkzEzYQHIjLr
 e9jAkZ0VY8jHxFfch4XEYEJWN0DxA8L9qxMISeqIOsoaBNa3f0M324l2LoE3tHaCRT5I
 vrm5m9L+2vGJCczO1Uwivc0ezYZ8gKJemCz/L8eRvs5lertl+GxTJraix8SJj/D4M+Yx
 tL0R1/kGadidBoZztGvfMrVzvxKb9bwZd94jCYmOtLXSzh7oe2ycENsXnzKsmx60EYYJ
 nNb617oMmg69NogAzi3+SbkwQoO1HUhFNFfqp5881teZwQ1PG7Q0ygkmMZDTErqUDqo7
 iZ8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPE+B6wr6FP+9hDFDugIzk0q9ZpDagqD+e1MI3ufFIuLaXnv4GQlnE0Xkuq3QTC4ZQcbWNbPZmHcS0bUzXkll+G6KVCg==
X-Gm-Message-State: AOJu0Yz5DDEwMhh35vZ6M3KqBoGeRlHklFQQ56TnVc+8DhpaG97i6wvF
 ILrwtEwUuxg1DR8O2h7ldvrM5NGUHJpvp0+FqtpFdABWJ/PcPSM7F0hXwEr+7+Q=
X-Google-Smtp-Source: AGHT+IEBHh4Gzvplo6/nF9WJKQYKuW/bnXrA00OjFcWKBIhN0FTW3wKTPq9N15Iu5H9ucVnZsRtAiQ==
X-Received: by 2002:a17:906:5d1:b0:a72:b804:566f with SMTP id
 a640c23a62f3a-a75144a2809mr649662266b.52.1719997516143; 
 Wed, 03 Jul 2024 02:05:16 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6474:ebbf:d622:a7f3:7832:9423])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf1bb6bsm491186866b.30.2024.07.03.02.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:05:15 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 1/2] clk: clk-mux: Make public the clk_fetch_parent_index
Date: Wed,  3 Jul 2024 11:05:10 +0200
Message-ID: <20240703090512.92636-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703090512.92636-1-michael@amarulasolutions.com>
References: <20240703090512.92636-1-michael@amarulasolutions.com>
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

Make public the clk_fetch_parent_index and rename it. This allow
us to be reused in driver specialization

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/clk-mux.c        | 5 ++---
 include/linux/clk-provider.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index f410518461e..e3481be95fa 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -102,8 +102,7 @@ u8 clk_mux_get_parent(struct clk *clk)
 	return clk_mux_val_to_index(clk, mux->table, mux->flags, val);
 }
 
-static int clk_fetch_parent_index(struct clk *clk,
-				  struct clk *parent)
+int clk_mux_fetch_parent_index(struct clk *clk, struct clk *parent)
 {
 	struct clk_mux *mux = to_clk_mux(clk);
 
@@ -127,7 +126,7 @@ static int clk_mux_set_parent(struct clk *clk, struct clk *parent)
 	u32 val;
 	u32 reg;
 
-	index = clk_fetch_parent_index(clk, parent);
+	index = clk_mux_fetch_parent_index(clk, parent);
 	if (index < 0) {
 		log_err("Could not fetch index\n");
 		return index;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b8acacd49ee..59f9c241b84 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -74,6 +74,7 @@ struct clk_mux {
 #define to_clk_mux(_clk) container_of(_clk, struct clk_mux, clk)
 extern const struct clk_ops clk_mux_ops;
 u8 clk_mux_get_parent(struct clk *clk);
+int clk_mux_fetch_parent_index(struct clk *clk, struct clk *parent);
 
 /**
  * clk_mux_index_to_val() - Convert the parent index to the register value
-- 
2.43.0

