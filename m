Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833BC369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3574382155;
	Fri, 25 Apr 2025 15:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpc/toD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F3C82385; Fri, 25 Apr 2025 15:52:36 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9119182132
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so2190578a91.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745589153; x=1746193953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCHVMo+q7/wEJWHt8obV8qNydmXkxKOYfVB0fIJr9wc=;
 b=kpc/toD55/H8WMQE9HiGvbHe0SPSDz48wwXlA4oKk1/t/5P/JWJk10W1UCTa0II1UK
 H6n9cQlxjFnuloaZD/QSKgpGQkjmB/VhzlFREb4eD0h/XYGwvX4UVYOA9108zRlh3bGI
 TpUMIG6wYg+pUXoZj9VKZAzrcMCUMoX5mIowAFJNjxG66Ik5Svw2gcv/uDEZIrMI8R4K
 yLMjqX1ZQZQXf3uxy864o0D7n8+Ox3fS4I6ng77RehZxsTDs2d1VqfBHCViWA2It4XRL
 DWYE3Zie8vkMgkLj09Dcu5NZmnoKuEUJm3sSAt6/DM5hp4YdohvAo3rtTmdceRVUUKvE
 zX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745589153; x=1746193953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCHVMo+q7/wEJWHt8obV8qNydmXkxKOYfVB0fIJr9wc=;
 b=bQiI7UNpUFJpWTyvabwPuLCtvh1bNXwR84gh4EzaR6V/HUFkWjWJWqU92HfGsPoAq1
 oCfucvAf4UFNoAJSFkvsdvWrDgEfsBK64hVGMmem2RLkuP4jgqfVF9wVs6Q9Lq692KSW
 CsN+9xKtFJs4TBgzcoQHVD99/WdskJk2QvFDV/YBN9q45fwZI8Re16LvUJ71JHYYj3/O
 6+/+h5OiVvU3h5z6I9OO6MwxsAtSyjUwHj1KvHWRQidgGbRz5dT/6tezZL9pEqnHsxKB
 TKmHk+K0W8CA75aN87FFrOxXMr7oji5WQvHr1gzxVBn/xzjhqjYprZ/M5qxedIH7EZ/U
 p2ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAF9uKgxajXbnHSnCCipF1gtpj6yo4JrWniNKSgRPexkWLzX+b2GfIqqwC0ALVzBusgHZ60Ic=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlo1ltiub1tObPuEfEK8EkiG0pxFc0SCNueysNUgU08u4Mtmm5
 V+wYsbxODe83IeF+fBlFjV8CQ41y4o20FbcjA4F4teYN0zX2l0vY0t2GuQ==
X-Gm-Gg: ASbGncviv497kYEMNmlDAat+qLrP9VY8jihmnatk261nDiLfr+6NIYpIdAoaSb/EAPI
 wgsLjbHjDBA36Nh9KOUjqNyd0MnWkWxhkm8eMPXokVbczq4BNS1ocIcEB/ClvCYVFaFfJNwffqA
 twnWhRZ1z4Z52NXyjdsD7M/uXaPqz5rB2Gr3MajrGcsThnH6nsGjg1zly5dFOjFX0XAF2laxAJc
 NmXQLqa8SZ8x4qbrEqRGetfBqddhreszK5jCX0itp8A3jfQdiDz2+5RKsF7SmPzxQUq9MzCT6MG
 1Dk1PO89j27dA/gLXZeUJgNydujzrV0bdKT/05qqki2DsCgjYiFMqak=
X-Google-Smtp-Source: AGHT+IECehRftbceMmLGYcJwbgd8KAgydX7BButDtbYqyjrhyQnpozARFV32gW4NX9m36cGvK+qJIA==
X-Received: by 2002:a17:90b:2c84:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-309f7e609bdmr3682985a91.27.1745589152947; 
 Fri, 25 Apr 2025 06:52:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6fb9:f343:690b:2e7d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f77371d1sm1619864a91.2.2025.04.25.06.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 06:52:32 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/4] Revert "arm64: dts: imx8mn: Include 32kHz oscillator
 clock in SPL DTs"
Date: Fri, 25 Apr 2025 10:52:19 -0300
Message-Id: <20250425135220.1929510-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425135220.1929510-1-festevam@gmail.com>
References: <20250425135220.1929510-1-festevam@gmail.com>
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

From: Marek Vasut <marex@denx.de>

The 32 kHz oscillator was included in DT as a temporary workaround
for the v2025.01 release. With a more appropriate fix in place for
v2025.04, the workaround can be reverted.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mn-u-boot.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index bb0e5b4e31c..8a9ef54c91d 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -72,11 +72,6 @@
 	bootph-all;
 };
 
-&osc_32k {
-	bootph-pre-ram;
-	bootph-all;
-};
-
 #ifdef CONFIG_FSL_CAAM
 &sec_jr0 {
 	bootph-pre-ram;
-- 
2.34.1

