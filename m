Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDD1C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA04688B99;
	Fri,  9 Aug 2024 01:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SQ1lp092";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7455A88B86; Fri,  9 Aug 2024 01:59:43 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA8088A2F
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52f0277daa5so2090817e87.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161581; x=1723766381; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T2jxdT5TJqlzYD4qhi6mySWaYqGibrqoaMU+j+BJxIE=;
 b=SQ1lp092VvcsqYDp7/hrEZGRoMd+qhDcOMl0qSPZ7+n1QJAsssOdu/UC7jZGaIXQYU
 pZHAXC9v7PjbvrruytXaY8pUXiQBuks/wakaNeJLkoqTFt+BVLYQMu79/iuge5NK3VUi
 /UXsIMlQt40HpGEUxNqQmVtZqC7z9jgkEiXK3sqdZyDr9kmXFrhPYTUW8DabnLTa9Y7G
 ZLhopGm2dCRezivkNdfI7bJBoiAq9Dnwk0h5W6baMLLtMwl2BPV23Kz0jrXryj9MXD8D
 FMjGAzLqojhcE5ORE5ankZX/YO7dzMFC/81LeJ0UqOA9CZ9Gs5DHPzc6UUltjSAtHHi7
 YAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161581; x=1723766381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2jxdT5TJqlzYD4qhi6mySWaYqGibrqoaMU+j+BJxIE=;
 b=GR/MrIN51b+YN9fepE6I3JX9+i+b9G2inNZZRmI6GgRK9snyjkJTaF2D1D2ZzJIHeI
 xObQP7h9yW46OTqV3oQ/+32VqVYAn+fr0BYE2KoAQYg4rqPQX5FGwmYS5YxFB2N3bIqC
 d1GLsmEo1p1N6W5lzJOoYHiehld8zIJ8ZEhtgbWPY/h3UBTVqCOrDzAmvB7ub2+to6j3
 RGIKFoT283oRb6PmUXqMnXnChWCj27azQ52TMpXlJJMUIEdjAfqORHfpZMu3eAGxPnRl
 zUgfREMjN2pRFZbJDSnnQXf21oCveKD7Ny0xDFa+BC4uTH7990oCQ52+58W7mJwVYIbN
 ++Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYZnmlNKiFp3lRNYSaIZlSJXE4ynyizA1L6IHq1HW/x1arO5RmcqH23h5FOjiDFnm1LmVzD8IWP1676lFVGAfTrtPAqw==
X-Gm-Message-State: AOJu0Yzcp1a1h3/KYJivr7M4IKkDTqltWXTQV50RNUtQh6XbXw48ATsZ
 3IzRklU56eMKdoRWLKRzq/gXsAB+NvhecWaxDbJDLPGpp2KEweHXDMBipCkxHKQ=
X-Google-Smtp-Source: AGHT+IFXfRBdIz45zYw4mQNmxxBIGXnGaaul4VHmxNFjG/RYfONs73o/fbfbZBzOH/feoMgbcbiH5Q==
X-Received: by 2002:a05:6512:124f:b0:52e:7f09:aaae with SMTP id
 2adb3069b0e04-530e583c51fmr2280017e87.27.1723161580691; 
 Thu, 08 Aug 2024 16:59:40 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:26 +0200
Subject: [PATCH 03/11] mach-snapdragon: use 1MiB for get_page_table_size()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-3-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=665;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TJ5EUTi1DoAU1mw1jeKa69a8U2IgtUNZwwNOXmXlMYc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvn81P/rvlkfDkwmqdoVfkmk/SkkfML8o+pN
 eFkbhUgfsmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb5wAKCRAFgzErGV9k
 tr06D/9wXi4/gN0PbseL/qKRK4rjzl4rxntpgzA23udmB16pmCFJxXApA43+A04MtgDRgmuXj3M
 aUNBG/fEBOWTLH12AVqR7KrEh8ah/kU8x6NYTSa3lXd025vy5OvMTsLd6PJK+GZB4MhcVLj+dwp
 Nxvhi5LQWqWnlJ0ruUDDxNZvJn3Yq35+12gR/xpNtlem6IJLkKJF4Mr5fXX7UiOjpXnzcjxzxtA
 CS2ERKzqZ9F7RwX9QJbHNoruPcfk0ju7LVPfcqU/9DFfWyqXLuPMMBZe1EOtgjeFOxvMnNY06te
 ujPBZZCABY+0tn0n8JVvvI0fXALcBhWeIG1S0CTc28CKkSgQE7wysXfUEsw4g6wR3+DVM97xcrV
 e1sEjMnS6DFfb5kqBqllvDLT4aB7NfSv9A93XNsIYrpO8GhHyDLtuQEqG3IqQhMtPq73CJsMoBs
 F9NJI9K/ccf6SFP6j1GQgVh0r7VNxDZb5GiofvQ2/2sf0+YT5v46mftw6l5h1kY1gWcSYdEUPRw
 pTEiKzyf0SuCqVw3kKaX70FjMgTrPDaos8iHj2nrxGJQar2+ZvOFPCbRvuMq71eF7mcKOADGvAm
 d/LYhHTlcUTwB2wb8zPd1/WmH9HB7rdPwK9O+0to7P8kZasoaLByg2hQKA67k0chDVktMB/YteF
 sogJBPLQK82LBSQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

From: Neil Armstrong <neil.armstrong@linaro.org>

With 14+ entries in the memory map, we need quite a bit more space for
the page tables.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 8947cf913dff..0e8234a62b28 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -416,9 +416,9 @@ static void build_mem_map(void)
 }
 
 u64 get_page_table_size(void)
 {
-	return SZ_64K;
+	return SZ_1M;
 }
 
 static int fdt_cmp_res(const void *v1, const void *v2)
 {

-- 
2.46.0

