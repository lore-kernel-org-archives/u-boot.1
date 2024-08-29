Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15424C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E30788CB5;
	Thu, 29 Aug 2024 16:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L16Z9A1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86A1D88C7B; Thu, 29 Aug 2024 16:58:28 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3DA88C44
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39e6a1e0079so3035285ab.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943505; x=1725548305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85NKdbRzECFFiLrs7Zk1lTb+EsF7zKuVVuVy4v3EsqM=;
 b=L16Z9A1upZeX15QtXD0+kA2JSPVZnSgCNZQhED704Tks91HvPNsJlruv82gEc2ZQgJ
 8RMoeiAElXdwJZTiHYxZZnF+nqu+9MWkDUu3sJ8edwWW+jnQJQBcSYS+plj13BjJvC4z
 l9lWuYLWxsNtkyBp6Dkvuf71KhkE0mcpmh3yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943505; x=1725548305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85NKdbRzECFFiLrs7Zk1lTb+EsF7zKuVVuVy4v3EsqM=;
 b=ZRvPpV6NjOcZDR1nj/Z2/IRAEMbMbG75lgU2YyMS5ZOUSA68Dnx5wTi37LqKSrJaQI
 9B4/Me1zEUKS1JTfI9QbtxEfXSTYATZnYmlQZ3rZZ3ov21tO+zm7JWWKud6l72HugnFl
 Vr8iVEzbA40oDtUMtsT/jbrI8p//NxN1WUPR/K7Wt9IbVZqnS5ssPEr5SVrtS4fH3epp
 ihRe1802CYrCP68uL3NVdDuQleiGT1vbs3w0Rmd8aRUf7x8iv/R+qsHZuUEPmig4+rLA
 VNM5qHeWYKUCand5KVq5heuGDsgsgKE5ma/ArGmWJGHB1PEiKjZERgSbcCNSmmsm0dOm
 5dQQ==
X-Gm-Message-State: AOJu0Yz9sXVdKmu8abSPurAK5IqAtIfWVAksKehuZV7m53uVmi9S5B7C
 QMYxR16Qb/3oJCNpcviXP2F8Xtze4Pe6MTpCYnzITHezIC6DiIrDQX7rjUfZLHVdji6Eu/ZMbOY
 =
X-Google-Smtp-Source: AGHT+IHMmkQuc98S9X+gW3Mp5SBxICtAJ2H6Tl2oGvo3SBIO7HfbcL3IoycadEz7oRsIASe2R80azg==
X-Received: by 2002:a92:cd82:0:b0:396:d1c5:e5f with SMTP id
 e9e14a558f8ab-39f377cb444mr39013515ab.6.1724943505188; 
 Thu, 29 Aug 2024 07:58:25 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/19] spl: Support a relocated stack in any XPL phase
Date: Thu, 29 Aug 2024 08:57:54 -0600
Message-Id: <20240829145802.1827952-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

The current check looks only at SPL, but TPL or VPL might have a
different setting. Update the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 8b868a298f2..5c687cfc73b 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -896,7 +896,7 @@ __weak void spl_relocate_stack_check(void)
  */
 ulong spl_relocate_stack_gd(void)
 {
-#ifdef CONFIG_SPL_STACK_R
+#if CONFIG_IS_ENABLED(STACK_R)
 	gd_t *new_gd;
 	ulong ptr = CONFIG_SPL_STACK_R_ADDR;
 
-- 
2.34.1

