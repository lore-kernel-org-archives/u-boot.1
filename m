Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660A0D5806A
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE1189A3D;
	Mon, 25 Nov 2024 12:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PyBKWuLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1569589A3D; Mon, 25 Nov 2024 12:56:46 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D55389A31
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3824a8a5c56so2901984f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732535803; x=1733140603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhTO/VY1wYc48kwVBTm9OsmBMyznhQOTSFPbuSfWmFs=;
 b=PyBKWuLeKlcaFQg4tLYOqhK2EJAwitsl5KCx14YRYIncMwO2c9+vrrcSsh34bzak2m
 Rw6Kib2GEfD9y1n1ka3IGzG7tGfDg/3RF1Wx8UBUhQHKFbxBzlJUqLz7+IGHnFtNGTMx
 InuAolfrHGMa15FsLdFOkQNJYOyB+asL5DesuVzG+t5S+fvk3rdUXqGb/9Dd5ZbckFYe
 jWrE+4r18ySIl72dZ+o/jy6lbpt0GvChBxFcvXVBjzfgKX+cGXXizUNm5VOURtyl0fFf
 BmyT/Jp/7XF8+AyTZN6FusNFoN7u16gkGacCnxNLRxXwr+J9XZtNfH/9HbJF5Z0nqpQK
 lkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732535803; x=1733140603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhTO/VY1wYc48kwVBTm9OsmBMyznhQOTSFPbuSfWmFs=;
 b=OX1IatCx99Toi3dJ5PFTPGi5BkN006g4NJldd1pYrJ4Ua+n6Lw2/4aZMmVo+3/X4Df
 kW36kl7YK4A0haeimQ1XwEbAO9uHL9C0MWiZJiLKEJqHp7fPsoZpvsszoCTU50mQ5c/0
 8GHXd6sHmJawU2WFxTeytiC21FqAtUW3xpe98UA1wX3RWvtsDUYhfQrhgnwt8nNrom0m
 vWVCKK699E7VxEcrubl8RoKEWEl6ViMZJjbPwHek5dn3BDxSTdVh5Q97t7azYLb1kWXf
 It/CPVg2Hh7M9XqM4KOWF89xcyLKNe7HTQfvmtxKll7jr10kWuO7k5gQrwVlNy29xdSl
 H/sw==
X-Gm-Message-State: AOJu0Yysd1Npely2Pudg3DMD02T+7CUxJFA+KS0uFCCfYU/B1MbAOGf2
 ZjpqooAJKFIbuuWETzEizC1PtPUUvSndZqFm+53F6GVMZ72915wAA6oc4e1enckqDeWoLbyzfNr
 JJ7IbRw==
X-Gm-Gg: ASbGnct9qkFiHWM2J07/YI/cXp2ycCF5yj89+wwFmJzHO8ex1UmwDMU40tJKkLX0WZR
 U6SK8k0YEwXraizEKLqsNnCXkJ28zrXyWtz1Z3PpUym42BoJPH0ekjd/cNmyHCzmJdr4gNY79yp
 pq5x3U97FisENUi1xMEYCDH/rJvBES+6xBn8klSs4Cvapdmz/PJlwm0kbjJiY1OiPnBl1O68+JA
 MoRPsdlHmeHEC0lNXawB5L0yY1puM7guOe/OzfBotR12IEQbsuM/bqRp+9FN1g4g3tJuw==
X-Google-Smtp-Source: AGHT+IE2O7SyPHgdLz9j/W84xFyN6AYr6JYx6ivNJkgCypv/RqHOuRLOWzOQqzpXtIBu7E59EuBE8A==
X-Received: by 2002:a05:6000:797:b0:382:5066:326f with SMTP id
 ffacd0b85a97d-38260b5b0bcmr9995841f8f.17.1732535803638; 
 Mon, 25 Nov 2024 03:56:43 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:7b40:ce24:60a6:e419])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb271ffsm10139626f8f.53.2024.11.25.03.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 03:56:43 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/4] sandbox: select CONFIG_64BIT for sandbox
Date: Mon, 25 Nov 2024 11:55:52 +0000
Message-Id: <20241125115554.1707080-3-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
References: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
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

Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
static analysis tools.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

(no changes since v3)

Changes in v3:
Updated commit title

Changes in v2:
Moved select of CONFIG_64BIT from SANDBOX64 to HOST_64BIT as
suggested by reviewer.

 arch/sandbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 1c8353d615..db29ca14bd 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -46,6 +46,7 @@ config HOST_32BIT
 
 config HOST_64BIT
 	def_bool $(cc-define,_LP64)
+	select 64BIT
 
 config HOST_HAS_SDL
 	def_bool $(success,sdl2-config --version)
-- 
2.39.5

