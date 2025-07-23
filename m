Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E302C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 14:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D897B8353F;
	Wed, 23 Jul 2025 16:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lZP/KzfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BF88317B; Wed, 23 Jul 2025 16:13:52 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015B1834E1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso4954106f8f.0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753280030; x=1753884830; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z7S5yUPfnrmaqWcxg7A3X1x8cZr3XNTzq8T26q0cFlg=;
 b=lZP/KzfEwws8KIqwOeBMI4lNJxwrEqhGJicHWJBF81W3bA9MG3qQgP/HDHkFQAwDtG
 vjYxVImV0iMGm7zUcOnaU4nVGA4eZHNVnxZHhw4KJHUn1cbxo4R8eU1Lx0YyVxdSJd9H
 jKpB4NLfs2s57XXEwlo4ckpfq3CmZrDyDUdo9FxDlPwF9r1PNVauAEmXEZ3cLEdXJ9fh
 Eujf6KgTfXo5kiZnErGVRw67YLOZTBMDY5K9+jTqmbr5tPxQFppZNVz09CAS8W3puMh8
 7SqDE9gcRfe4sNnzx7XB20s3waiYSdTY3QzMBsliZKS7Ie3g25rATh2Zf22c4F0tSMjR
 0CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753280030; x=1753884830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7S5yUPfnrmaqWcxg7A3X1x8cZr3XNTzq8T26q0cFlg=;
 b=ZsSSMmZrgS8N9IP38US/L+yBA2AfJwJpVpcp6H6WN+Yefhg5Wu0mdil7PgHxlObV8e
 9IfLKXiXnYAnM8dC3zf/cHLy5GmHKEOxuUSyAqVul5gAtPSs8MedA8VwFpgRXDcXY0GA
 C3OvQSpKgGMV2o7ZayzQKsgI6GOUUdEpPx2pSHCTx8D8zG5rGCXMGKgR5mxCvtnsYe8L
 q+Qph5mTA/V8ldfD3eNN2BiZBaDjiOyVFSqVJVqL/KBCij2XCo3OWONpEAlHySrL/CdX
 5rz7AzZEWyL1UBLvvI48Gtf4qJ0nN4TbCz4Ly2JmLZSYRlidCY0S173CAYAUTxJVJlXv
 mWyQ==
X-Gm-Message-State: AOJu0YwjwQxIgoNrm3UUwSsgZVcFz37vku9NxvgPIc9PMU9AI1eknmJu
 YGYfq7EBxKWUpgov7tkWztqO0ACUAIxlsSThKYCdeHNDY7YBmyHiyXCOTivzSQ7a0xQ=
X-Gm-Gg: ASbGncuMbIyC673/1mh7Y4YkS9gw7lEJ5sGQGB+jKj6pCUpr+NSn1KP0/vtjF9lQspS
 b2aUnVKlDCCqD/J+o/IwarqJWlUxhH7AmTLdthWKJ+zByjoYEDNHsEYslTbBPiw2wQx2sFBA2b7
 8rBb5l7SfMvV+KFMm6Z9DUfjn3T11EHKrmPhIFMw27WhbzleahyV7eag8jY5pcnNdpCXAMwqjUU
 yZsp77Jbm5Sa8xgqbQ6EHkOensrangiu+QnZbsf5GsJNIw/OuGojurRdN+VP3kxWMLmZjP2JBLm
 VqX7cHgzVdC3m1CDb3QiSMFKJZEJOexnfHkXctGaTlm4TcbI/htxz9Pe0ejV2AGAQVdEmjCnDwX
 Vp+nC3kps5pzAkhgGN6bpcCeFXEFJFwKK056uyD82IF2IH5o/f9w=
X-Google-Smtp-Source: AGHT+IE/F/XjNHkwj//tKDsnNNTxFvBrUzTG2jz1Jh3hN8k43DGRnoE+0QkS3rupPzIPtwbpO9gCyQ==
X-Received: by 2002:a5d:5d12:0:b0:3a6:d95c:5db with SMTP id
 ffacd0b85a97d-3b768eb0575mr3138851f8f.26.1753280030330; 
 Wed, 23 Jul 2025 07:13:50 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b75baa7072sm9416857f8f.2.2025.07.23.07.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:13:49 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 15:13:48 +0100
Subject: [PATCH 1/2] clk: at91: Fix testing of unsigned variable to be negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-at91_clk-v1-1-3b28da9bf12d@linaro.org>
References: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
In-Reply-To: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The variable 'index' is declared as unsigned but used to receive the
return value of a function returning 'int'. This value is then tested
for being less than zero to detect an error condition but as index is
unsigned this can never be true. Change the variable 'index' to be an
int so that the error condition can be detected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/at91/clk-main.c   | 3 ++-
 drivers/clk/at91/clk-master.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index a5186f885f0..0542b066788 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -315,7 +315,8 @@ static int clk_sam9x5_main_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct clk_main *main = to_clk_main(clk);
 	void __iomem *reg = main->reg;
-	unsigned int tmp, index;
+	unsigned int tmp;
+	int index;
 
 	index = at91_clk_mux_val_to_index(main->clk_mux_table,
 			main->num_parents, AT91_CLK_ID_TO_DID(parent->id));
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index d28775d64d3..a7234ad61f5 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -335,8 +335,8 @@ struct clk *at91_clk_sama7g5_register_master(void __iomem *base,
 {
 	struct clk_master *master;
 	struct clk *clk;
-	u32 val, index;
-	int ret;
+	u32 val;
+	int ret, index;
 
 	if (!base || !name || !num_parents || !parent_names ||
 	    !mux_table || !clk_mux_table || id > MASTER_MAX_ID)

-- 
2.39.5

