Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AB0C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 07:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B650D8896C;
	Fri,  5 Jul 2024 09:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VBu+pG7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AACC88961; Fri,  5 Jul 2024 09:20:02 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792E288579
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 09:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso138754266b.3
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720164000; x=1720768800;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjPyDwYxW8ixxUOfF5BImnGofyLtSOc9yNE6LGakbDc=;
 b=VBu+pG7Kl/IGfK+wzSmUSfvyP/3mawzOszZlFyE2bZdzJLIAWZEJa7LTXHFujyrxj6
 w+9TEqxajum/S6/s1J9wUcd5i8UWkd8Pp+DLSvhfnjnAYdFnE7FBSgDzvuRwziiIqBfG
 yNMYqV6dHDY97EbH6+8+GjDFFHbMcCUnGZyYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720164000; x=1720768800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjPyDwYxW8ixxUOfF5BImnGofyLtSOc9yNE6LGakbDc=;
 b=R1OgJkv/Ey+MhdXSX9G8oBsxW9DO0PYN2Se+A2m2nYl/+w3lxOUGtWFwJFIzDQFdBF
 t6EbrINCUQ4HsLGb422GRNAQVNjQzPdtcsuOBd8z/RqwhF8ZxvfMiCflEmbNlXoC5XrB
 pTE9XxVtDXn2K50A0HKlv6GRGdME14pEvYJEODZKCvP9ymARYkOU2IBvjrsl3NnDWx67
 ir0cC4gtad2Tx0LVZD6kLGtaBRzBm4jX0kvkgfieHbjZkrbAfe4ZgjcIHHLDX9+aYArF
 apxh4ACDnqs1cwcS7EvUfXOSRe4cqp9Xq5fBn8tkZl4TwQ04vI6HLno/A1rQYYkbYLfn
 BQrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQPnMN8hjvPpNxtF1BbBMVWm2UssxCpJQDXycNQhJ+webTto0ZlijOR0ybASdCyIb7GfPprn0tmMPTUkEE8ULYOmW7yg==
X-Gm-Message-State: AOJu0Yzoi9pPRAE0xi9b78wJCOo/+POxy+HaFKUjO3z26mTo+EHGiCYO
 C1vgIyvz+AIpkt6hS8iwpSHcqVHDvhLkdKfOEVB1obxcw9rRbuLmWa/jtP18y+6pSwrdKiAn4/M
 e7FY=
X-Google-Smtp-Source: AGHT+IEKnGotFE8YBK/coudrIYA31OumKzh9HBgj0IBT9mBgwgcxWORjT5qgobhV3rdK9xNQwOsXvA==
X-Received: by 2002:a17:906:4751:b0:a74:5b82:7f28 with SMTP id
 a640c23a62f3a-a77ba4787a5mr251579166b.23.1720163999821; 
 Fri, 05 Jul 2024 00:19:59 -0700 (PDT)
Received: from panicking.. ([2001:b07:6474:ebbf:a3e:4288:e106:2eef])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b84d5sm655158066b.223.2024.07.05.00.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 00:19:59 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 1/2] clk: clk-mux: Make public the clk_fetch_parent_index
Date: Fri,  5 Jul 2024 09:19:51 +0200
Message-ID: <20240705071952.12245-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705071952.12245-1-michael@amarulasolutions.com>
References: <20240705071952.12245-1-michael@amarulasolutions.com>
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
V1->V2:
	Nothing changed
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

