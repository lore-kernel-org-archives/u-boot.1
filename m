Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9AAC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98218871D7;
	Sat,  4 Nov 2023 21:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jZcAWBwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4879487083; Sat,  4 Nov 2023 21:38:09 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37ED86FC3
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cb615c6fbso19153801cf.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130278; x=1699735078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJOkqdLukBGP095E97cm6V9ohjayF3kGeG9ZqA/YVOw=;
 b=jZcAWBwKKeB7UxrKdJq2FwjpkIramZl7sDfVTb8tv/WD0lNi1JF7S6ZO8m9ybo0xmN
 9GzPGf947JkpXoYD+2b/so68UviTwDJsNAEM1aFQ2E98px1d0fZBhOg+sXk6BpCcQc0M
 gAG1C+/obz0cn0MLzpqrdW+yB8WV+BKs+azvhDwLObZR23gtooE8NVTGDXSiLVl/x9sc
 qvmnm9fIe2wFjNPEZx98DI6MmIFudg4j7HbO8p3Y3koCXqyVvIOULF2dCyzZ19v3vDiR
 dWxkB6PessL9Oc9y2SYIyNdHo0mY7za1WXXq71qPvVT3PapSL4Kv7RQu6QgmqaEfxgAl
 Yokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130278; x=1699735078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJOkqdLukBGP095E97cm6V9ohjayF3kGeG9ZqA/YVOw=;
 b=OBM8Yc7QqJ28E36843P81RZ1y9SJIVL0CatNagHkMuDQsFqh2J0u7440zQMOf3v9K7
 mH0ymE0gYcFcUpCMWKf1zM2W87RQ5GKpolZY5P6psdwskXWs3wnGuaLXHh5NWzUFl81n
 Av+B4FOCCDbBnfxInDR8Z3tzR8hIl2i/6o7kIrjvvO6Y4YLSEm8QeUTxJW2gl7kXqlW3
 X52kDo7+YLK2rkXcSHiEERV7uXoCSqAQfELje3XE5iJJiIf/JCPE8vBmB6jRP7nrUCgG
 teE8llq2zKl4bQDAt606YyKXNbJzqvZMuRb+LivZ9oq7TAgBSQBEgChshc0IdakoYKxw
 khVg==
X-Gm-Message-State: AOJu0Ywy85Mmplq5srNwCpuWKE1WsgYi6TGzBnqo3Rpqi5WXPz241VSg
 fTIMihFcDwLDq/r9rDcGMbfmJXYOnZd2Pg==
X-Google-Smtp-Source: AGHT+IENT9mRXQviFEBfPPGDUQFtLHXr0cuShPzPa79xjQH3FDBQH5Q+XEer/3CTUzIU+UVHVsR5Xg==
X-Received: by 2002:a05:622a:138b:b0:41b:7738:a8cf with SMTP id
 o11-20020a05622a138b00b0041b7738a8cfmr31378896qtk.17.1699130278488; 
 Sat, 04 Nov 2023 13:37:58 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 o24-20020ac86d18000000b0041cc2852f62sm1899608qtt.5.2023.11.04.13.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:37:58 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Heiko Schocher <hs@denx.de>
Subject: [PATCH v2 02/15] nand: Don't dereference NULL manufacturer_desc
Date: Sat,  4 Nov 2023 16:37:40 -0400
Message-Id: <20231104203753.1579217-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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

When no manufacturer is matched, manufacturer_desc is NULL. Avoid
dereferencing it in that case.

Fixes: 4e67c571252 ("mtd,ubi,ubifs: sync with linux v3.15")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
---

(no changes since v1)

 drivers/mtd/nand/raw/nand_base.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 6b4adcf6bdc..44b6cb63a01 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4462,17 +4462,14 @@ ident_done:
 	else if (chip->jedec_version)
 		pr_info("%s %s\n", manufacturer_desc->name,
 			chip->jedec_params.model);
-	else
+	else if (manufacturer_desc)
 		pr_info("%s %s\n", manufacturer_desc->name, type->name);
 #else
 	if (chip->jedec_version)
 		pr_info("%s %s\n", manufacturer_desc->name,
 			chip->jedec_params.model);
-	else
+	else if (manufacturer_desc)
 		pr_info("%s %s\n", manufacturer_desc->name, type->name);
-
-	pr_info("%s %s\n", manufacturer_desc->name,
-		type->name);
 #endif
 
 	pr_info("%d MiB, %s, erase size: %d KiB, page size: %d, OOB size: %d\n",
-- 
2.37.1

