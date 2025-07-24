Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0872AC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 10:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 209F78360D;
	Thu, 24 Jul 2025 12:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gp9RTiKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F868360D; Thu, 24 Jul 2025 12:48:16 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A483835BF
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 12:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso5029605e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 03:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354093; x=1753958893; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Txc1m9Z6SnLcoak/p94RDsibsGJUvxgM37JiYAK3RuM=;
 b=Gp9RTiKEuiF7Z/Gp1Y1uEEzZb66W06g+WgQFYZJDVHfpJzwqMPR5QOcsDxrOJjGjvu
 iXEXxezN0V/ET691IiyESHo5CYwlSqaDVVNscomNylcRyMGgu29vc4MQJEHyF9ivmhBs
 +3217ueA4eN+wyc5IfXhD8AuTz8SL6Ldml4tgPxG6ntmSd6udmLbZCeil04Z8jZpJAWb
 5FsVJo+NvAk4uxVHMzq1iE7wxu5QcyqTqFqczD4Ve+scUgQvTnqqMTCNdUjXwkaI2yh/
 vJ49a43Th37kQzjYa4rCBOFnFru3N/bsMGrxP+qh980kQPvpv5MeVtU+zvqT5CG7639X
 dPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354093; x=1753958893;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Txc1m9Z6SnLcoak/p94RDsibsGJUvxgM37JiYAK3RuM=;
 b=Gj1A6cuwMXfPwKV2ROsSo4QwBeKcF5i1x9NXKHs7qBd+uZc0hlQcziQ8xpitqOiVVQ
 EciCgc9a0MB+ZC+I/tamiq8KitB8K3cpk3jS2FIVUwmFYvJhdeuVo/EEKAJFgZBEg1Vs
 Er6PeIZrlqiwNkTgWCV577JxKD6Kmes9Pz1vD03ERtX3BtMHx760l+BmI6KejYdMOyNW
 s5uPvrv/T0/7KNwozF0g9lE+lc9z9ubU5YFh8+toB0DTx7lAtvzs7ACYYNxUJX0E+u99
 x4+0hTEbmH7QJOb6NkjxR3z1r6RG5dLeb17BtvQdHJqvLndeUayXqzJvmsg/JbSqFPCr
 ZVmg==
X-Gm-Message-State: AOJu0Yx/Cmp5b/cyHpJyZqqUQE4COeBxRGAIYGsF6MBJHOxHkKMLfFOF
 6393GtVU6uYUv7EEHpZ9H68RvlfkEbDUgfrXzG38K8MslkWzDIfX8Urv2hgAs+jzP+w=
X-Gm-Gg: ASbGncsAsqU5NJchK/EO1Wsmt2N1+ESFHdcv12+sQ/a276JD8C3kgyQHEvbfkc42IMf
 mnMuHAVsrF2Kfdm5PladRE4ETqntwJ1aC65ZC8bd1rnyRHXWqprN0SsU4WaNKRkn6UX5UWqIkRs
 xRBMZ8dSV0OLREW6bQAgJ2sv4bxD+E84IyHvhkPdG4X0KENR5VosvdGPJgxDwyM0dc3yHWqBn+1
 cxhXXAzF7NhpP3SI7+BAi6dNnZimQZeiiCgi8IwYAru3Eq0B2wS7/N+/Ab8kxctMEXTIvk/bZbr
 TxEYkzUR8l16eKyeS8eXLCQmxys1ylTnRp+AdGHPMEeRGmT9j9Vh2QUq0d6zPYIF0dQ+ffVaJr/
 t5xJSaIsz+hNO4TS4Q9nqRwNpc/w+M4366FWoz17pdNfhzqWyKPQ=
X-Google-Smtp-Source: AGHT+IFAcAnXjYV2z6LcH8v1JlEqhApo/kyVS6iZUBh2IhwIdB2Koe+6qrF+EtF16ALs5xsxm1i0aA==
X-Received: by 2002:a05:600c:1c25:b0:456:1e5a:885e with SMTP id
 5b1f17b1804b1-45868c79025mr63701655e9.3.1753354093371; 
 Thu, 24 Jul 2025 03:48:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054c37csm16234305e9.8.2025.07.24.03.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:48:12 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 24 Jul 2025 11:48:12 +0100
Subject: [PATCH] clk: renesas: Do not test unsigned variable to be less than 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-rcar-cpg-lib-v1-1-46d64ffbf5aa@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGsPgmgC/x2NQQqDQAwAvyI5N7Cu2oV+pfSQjakG2q0kUgri3
 117HIZhNnAxFYdbs4HJV10/pUJ7aYBnKpOgjpUhhjiEFHs0JkNeJnxpxrHtOKRrF4ckUJNMLpi
 NCs9n9CZfxU6xmDz19//cH/t+AK8bKC93AAAA
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
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

In rcar_clk_set_rate64_div_table the unsigned variable 'value' is used
to receive the return value from rcar_clk_get_table_val which returns an
int and then attempts to test for being less than 0, which can never be
true. Instead declare value as an int so the code can behave as
expected. Also remove initial values from 'value' and 'div' as they are
not needed.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/renesas/rcar-cpg-lib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rcar-cpg-lib.c b/drivers/clk/renesas/rcar-cpg-lib.c
index ea33bfd3239..60ab2cb379e 100644
--- a/drivers/clk/renesas/rcar-cpg-lib.c
+++ b/drivers/clk/renesas/rcar-cpg-lib.c
@@ -92,7 +92,8 @@ int rcar_clk_set_rate64_div_table(unsigned int parent, u64 parent_rate, ulong ra
 				  void __iomem *reg, const u32 mask,
 				  const struct clk_div_table *table, char *name)
 {
-	u32 value = 0, div = 0;
+	u32 div;
+	int value;
 
 	div = DIV_ROUND_CLOSEST(parent_rate, rate);
 	value = rcar_clk_get_table_val(table, div);
@@ -101,7 +102,7 @@ int rcar_clk_set_rate64_div_table(unsigned int parent, u64 parent_rate, ulong ra
 
 	clrsetbits_le32(reg, mask, field_prep(mask, value));
 
-	debug("%s[%i] %s clk: parent=%i div=%u rate=%lu => val=%u\n",
+	debug("%s[%i] %s clk: parent=%i div=%u rate=%lu => val=%d\n",
 	      __func__, __LINE__, name, parent, div, rate, value);
 
 	return 0;

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250724-rcar-cpg-lib-d13c0763257e

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

