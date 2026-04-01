Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C355107637F
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB914840ED;
	Wed,  1 Apr 2026 16:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gfRuBKJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F55184129; Wed,  1 Apr 2026 16:34:22 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B800D84132
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so64206705e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054060; x=1775658860; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pMnsXnuvD55VljGKPUuKjkZRHIGIxyT6zTMvwS8mH4I=;
 b=gfRuBKJcEGVl2q3OJpyDZM0Wjief0EqjcrzjG+qVGbQOQPglPCDSpsyYFKmCJoSVTN
 /1pdM+O1is2FNYgn8e73QYNMtvf2NWJ7b2cOBkbGd/1teFP+eyVBScFrMRdV5f4IE+qZ
 e8hjg86ZqriH7EyBQuIrLWvVrIyJE6S49bqDD6dFJ/raPS4pKegt+WSk2v1VcTmhN/Mi
 EtLDzwb/WuET/LBUCR2WKFwY+HTxHHhLQZ16HCOMGv+SfnilrumlHbNAWGJpE8akO1lx
 juxXQmwOLjxSYyhimDf1SUYmGWS1WHy5ms7ve/w+RmXDJj8G+KyWlsdOF3a2jA/A5mhl
 zdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054060; x=1775658860;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pMnsXnuvD55VljGKPUuKjkZRHIGIxyT6zTMvwS8mH4I=;
 b=RSeLU026PIYDXCjOJur0room3/5TK0AEoLLAib7G0iZs+Q2zoVOY7MNVkGgqJjk9Xo
 EpT4ZH1DKgXa9u1+kh3pB+QHfXlProZODTnPVQ2ua3s9QVtb/Gl/sJwE55Aj0Alxy8p9
 ttOE3CZEWUWjZLuuZR0e58ubw15ZgBMqux8EcZqlZkaFQqvyHw8WWuzdTO0FnNMOpXzK
 24HlGkn9dX1Wem00lnTohSNcT5j45uT85Agi6N2EwQOhO2pM0T1tbpSRJ1nSyEnZam/Z
 DOr0LHiLI7t1V6RERb4Hl+xJAO7yhdo9UJIrKs3dniCXeJPmsJirdundGusdTcOUzLQC
 5ELA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL2/xZz9iVEj+tpNjrd6pnwerVpgP5Ccci8Ij/M2ZH4tihg5Xokr29cLWemh6gMV3Q8l12DbE=@lists.denx.de
X-Gm-Message-State: AOJu0YwB82FdSkayXxkrhIyd8APgjRw8pBqsZPOirwd787TKTsvnllbH
 Xynu4kBbK9qTLK2Z4m5kWYoXQuaXNRYW4iLKRR/eJaeGs0dVfInXfG/zteQ08zV6GLo=
X-Gm-Gg: ATEYQzzHnNtU4yg8X4aStwcAZoA5VRmN7QbPSstUt9TB+hcZtfiOR0q7BQ5aAFZ0m7T
 fonlK+9CwYHFKc3KpARcpHRe4TyosZlutSzYY+CMUNETzIMFxd3dkBuBxR5aLOyMSBWlQjjQ2W0
 v9u/Olfmmf5529fY7GGMbwjsiHWwQ082mTjHjCpygRfECfqxJSYHS+mghTEmEHZfyNaLPgqZAsz
 X+O4DcZp+D12oflkJvMOWmSuEoPbZEWj2msNDib0jfyHL/7jgoYN+wDQHckL9hY5ewwN55OVHxV
 18+Q1VtxXuFC7XRIqqqdvAY5EI+ttVgP13WYziXoO76idEXtmAZvrY31eMMYcS4lZEk64j4k9+r
 4uxF2TAq+74UhOgObxC2NsdfZUaMoYhnZD2Ugn3ktdyz8Pjtkf7Qnt60o9SscEfNOxz1sW+lTjM
 X7WFab/zRRm4w06Ukzc0DVHd6/n2LOHxpYu50Bl8Gily+igKdZzHJ+Dz78Y6ixHagbHB9h
X-Received: by 2002:a05:600c:5303:b0:487:1826:d89b with SMTP id
 5b1f17b1804b1-48883562dafmr62498165e9.9.1775054060072; 
 Wed, 01 Apr 2026 07:34:20 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:34:19 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:07 +0200
Subject: [PATCH v2 6/7] clk: make clk_get_parent_rate return signed long
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-clk-prep-v2-6-16a78c8c62da@linaro.org>
References: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
In-Reply-To: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=FTNIXLG8hV/CteP0oaof3lhlj3wmvNeIdcnwzCFT8d4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo+XOBa9ilC+OV1PcV728Rlv1L/ITn/TcNaR+Zxlz
 /muhktRHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAinW8Z/ql/j9n9ZMfnx1wT
 p1elb7oyN3/n3EsOUmvu+0ot5lnb2ZTLyDDbP/FHS+4KDf/YBSc6Qv4nNa7MFyuRv/N7+5mQRbX
 u7+oA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This function can return negative values, update its prototype to
reflect this and avoid potential underflow issues with error conditions.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/clk-uclass.c | 2 +-
 include/clk.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index db4f056e4816..095329e25f15 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -514,9 +514,9 @@ struct clk *clk_get_parent(struct clk *clk)
 
 	return pclk;
 }
 
-ulong clk_get_parent_rate(struct clk *clk)
+long clk_get_parent_rate(struct clk *clk)
 {
 	const struct clk_ops_uboot *ops;
 	struct clk *pclk;
 
diff --git a/include/clk.h b/include/clk.h
index 3cd080b43264..0520032f692c 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -468,9 +468,9 @@ struct clk *clk_get_parent(struct clk *clk);
  *		clk_request/get_by_*().
  *
  * Return: clock rate in Hz, or -ve error code.
  */
-ulong clk_get_parent_rate(struct clk *clk);
+long clk_get_parent_rate(struct clk *clk);
 
 /**
  * clk_round_rate() - Adjust a rate to the exact rate a clock can provide
  * @clk: A clock struct that was previously successfully requested by

-- 
2.51.0

