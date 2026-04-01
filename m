Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BE61076382
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7221C84010;
	Wed,  1 Apr 2026 16:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qc9f97Rd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648F5840CC; Wed,  1 Apr 2026 16:34:16 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C708407E
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4887eca00c4so13389845e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054054; x=1775658854; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NHMCT0l4Jf8/yJh3+wXTuLS4ZMIPSdrQseiOyewPPU0=;
 b=qc9f97Rdf7qyO1oXZLMk+0cGf2MhmiOZLH2vWlYB7Qi1HBsjDb3YJ8zNuMzGpAi20g
 n2Vphw+JhhWZnvsW5GjZX84RTI1EIHqNyRO1nikuAC53C3IAmkUS+amui1vK39w5XRsJ
 vc01EB5yJvRu8QicrlramSdHYB40MaT44yGQBY/pOa8vY5ofhDB8ugbFMLXlFGSZpBoM
 VNNykW5Ydo7FNaTWb8zeMT/7H2GDLEG8HIdXD9iRy2IWmZ4olF0egBsw/9w0CSGdaWg4
 ZhGTGOp7sEEz5XnvmkZr/qGygw36S6OuV5A+/m8vNYvTTzmLtx12GaeeMjRtCnBSxVLN
 88MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054054; x=1775658854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NHMCT0l4Jf8/yJh3+wXTuLS4ZMIPSdrQseiOyewPPU0=;
 b=PQsHihUpeiqXjwr7AjIx7QT3f2LG+pc5RrbPm57boPMcshRTtISVx74J7FH1PmmpW4
 FgyImEM0VQCAX48T1NltQenzfxy8Vq32tmCKQvdtCHbQl40zVoAjCTjIjYAIyrFG5aPw
 rvbUQMI6Wm5xVNd+hlDo4W40k6Oj4ZsQPy8cjd38a7eXK8m+bMOqkULq5T3WhcXTlMoV
 O+lauhPEXLRb/RHA2omRpLi2zY0E9QiZJvVD8Yvws0ulCGP5adD1Y1aKJqn7fULTjZWk
 PfJu1crQO5SYxnyxGI4AyeUOoUiOQRO2Sx6km7s+SazRJrSE4vzjzZGQVvs05S01UxSq
 PP9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAfTpqWRpYyqE5LA+hL0yS620rJ4VJNI+WN1DyJ0foUvs1w65ciZ1Kh6AGwZqkofI8apYOS28=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/ajg41EFe5SXlU8dtocrqlw5WH+kIfguk/XEEvtpq/be8IGtv
 UoCsos4gwdSonrDR2L3plOrkj8EIBYhIPuKC/n4/dVgTqZhv50ospG5/5o4hXGXWkeU=
X-Gm-Gg: ATEYQzxjTWQdmkOnpgfZ8h/fzQl8hR0GUw7QOD3qSUo+lU+LEhj8nWYw6rn0QEAszfN
 bR7ng5C5laEIlDwHaqdnYDBH0pEb2KHpyU8104lCeykx3V0+8jmBrPV60oo9xj0cuMzrE7YTv2H
 +ZBvZOek+1F/zUNxgu6dfIWp9aSrmTt0i7BKo9h0hRmNVRiSk1qiM8800CVHxudgzDq42nQPKpO
 kOYDF+cvZq9aKY8zoMo4oeNqJHNnK0f203yO0RGiN5rdZMrsOwnRrqJYKm6dktnPvxg1adffXkm
 iRufru/F/W4/Wt17K/1qb5KZ1/VTZVy8nT3FGwrhFPO79vczdybFxP0w12AiqJyoc1Pd6F5+zyo
 dFVo5/iItb8NiGmR54KJMP66jV6oHrAfgDBg5mJ/nCY5jWaYqeftMrvfa8qo431cUN0rZdV/Pco
 K7BwyUdzJ2jMCVl746et08lmQzVt+HkT+Ly9NvjDHQTurFnVhuTG9er260EvcihNZeJZBU
X-Received: by 2002:a05:600c:3515:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-4888359cee3mr68156245e9.16.1775054053837; 
 Wed, 01 Apr 2026 07:34:13 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:34:13 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:02 +0200
Subject: [PATCH v2 1/7] clk: restrict clk/imx to MACH_IMX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-clk-prep-v2-1-16a78c8c62da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=740;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=P+s1PrmAiVVmjoxgBNQcFmgXXPk98ex7zsSP+SOdMU0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo/cGLcZuDwp29CgdTg3y/hA171a0RXbNz9bZfjkb
 VHJOyHrjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRI16MDH0/XJfzLhXX/PnP
 pvsT97301P2C+0+uuSnPx96sLnWzMJzhf9Ecrr+97//KFYotbWfdX81frua+6YIE99mzCfn5xYE
 fWwE=
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

Only build IMX clocks when MACH_IMX is enabled, otherwise IMX clock
drivers get compiled for all platforms with CLK_CCF enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c28..f96d57a3223a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -15,9 +15,9 @@ obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 obj-y += adi/
 obj-y += airoha/
 obj-y += analogbits/
-obj-y += imx/
+obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/
 obj-$(CONFIG_CLK_JH7110) += starfive/
 obj-y += tegra/
 obj-y += ti/
 obj-$(CONFIG_CLK_THEAD) += thead/

-- 
2.51.0

