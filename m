Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AEAC77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3246D82E50;
	Tue, 24 Jun 2025 01:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rVhf7oEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7310F82E35; Tue, 24 Jun 2025 01:49:48 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 245C182E35
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45365b1a897so24211735e9.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722583; x=1751327383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54dbkhfr03NNUm+Z4wPCwuIqpB1oEr1xZRTYoH0Prto=;
 b=rVhf7oEO6Qt2qimfmnUG5vwINhq3Fnp1ghN9Y+k9qcQNGxNpuXySlRmluzEE+vWZpR
 CxFfHRgrqa5oHKhhFAynU5DJ2cxh3fjCkMlDXTMZnYZ+jVIF4jfQmvfQbuV23Xm0WLns
 wXE/uRKbIMwLOUkLOZn8MAujeNfdhRUWDz5t27dVn8Czs/hSPD6gFsSvev6UCrS6GOJW
 3ZWZGYR71I5nstfzazfwOdzMEBNFPhfYX+EpJD0Z2gH0/OiB95ZxviHgkDuD2IWTMX/2
 rpV91bxmeB/rzUZCmfNrPVMj3gkmWYPo/Pyr0OXevm8gEO65pcJMtqcg3U48kFjOHRpe
 G4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722583; x=1751327383;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54dbkhfr03NNUm+Z4wPCwuIqpB1oEr1xZRTYoH0Prto=;
 b=RCLXaLkwh3K8G3BjU9RWB+3mXOK2jgH5cXg/qyoQKJaCq8LdzLahgsK2omHoQQy4yB
 3VUjzw4PpZC69CAgd0iftsKNhF3BFX8VUfLUWAvVkbJUeejxxdP0lzPucwub83p8OvQC
 h5r1a3UUeD0ju5bAiPtTv6FyZavN8yhXehdytVdgwujqWyh7rBZ3TWyHrzCgBRPdsFb9
 uhpfdMHreAEQ+oEyU2D9yOmm0EO+rkgskXZh0kj6ZAaa1woNzo+5I5yi77aldYZb2P8n
 sB/kTxNcohEM+wK6+vxpAaQgXDacOvfrpU0xTtW8kXKcfZfrwectriTlV+XpNqCGnYn6
 9FCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9s5mVoimsSwk0dl59kEOrzPkfbza92nlPEfMYEy4Ztl1Yvcu5V9l54IZ4TTlwcsSz2owNxHI=@lists.denx.de
X-Gm-Message-State: AOJu0YwsRVD79Cqxe3gkgDM/pUFgH/nWRx98ThQrn7b25z9fTJ0BwfQb
 j4iwzUikdOPlyGxoECKXU1B84Eh4+pcRUXhlKAvXFYJJdEecMzXM2KpyOGezeKJ1JjI9OJSgYjt
 qoWSE
X-Gm-Gg: ASbGncvKLPy5uVNEjWQLyCRdWfgpeG5oQUirgLtKW2Q+UKCqWy5ocmbiWLTD7uTelkv
 b2zIj2tfSvfS3E+0Iznfdg6eii0jT1LjLVCK84aFBJclJm7XxShAGs/qltsb49kDU+vZIvPrRN3
 upgGX2iE1xK+rtfDTwOwK3Gt9osnG4ktG7FTCfxsEDh/HdOa4X8EV9pzxx49lV99WaWkysmKUcq
 kOzvcMBePCRUhsoQaArUbft2bM2SQw+EuA83glfItmn8DYs56E0Kcs6XvOU+WKSXi9QmKOp1dwS
 Rum/2WLcDMwgORMbQKPKZexRsji7UPsBXRszsjG/qk4W93mOwv2irRIb3UQ2DJWEnEg9x4xrSb4
 pBtfIrg7cN4DdC6As1qFqiA==
X-Google-Smtp-Source: AGHT+IFgH781XTpXxTwhY6mXOCBwPw8ihB/0CVVB0mfB3nfwUDQUk+MtHh4fnow6sFiVS2CuAQsDNQ==
X-Received: by 2002:a05:600c:35cc:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-453656c29c4mr131666285e9.23.1750722583506; 
 Mon, 23 Jun 2025 16:49:43 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:42 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250604113452.1075503-2-casey.connolly@linaro.org>
References: <20250604113452.1075503-2-casey.connolly@linaro.org>
Subject: Re: [PATCH] board: qualcomm: add a MAINTAINERS file
Message-Id: <175072258226.128390.17291362848337687629.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Wed, 04 Jun 2025 13:34:45 +0200, Casey Connolly wrote:
> Add a MAINTAINERS file for assigning maintainership of a particular
> Qualcomm platform or board (if board specific files exist). It is
> intended to supplement the treewide ARM SNAPDRAGON maintainers with
> folks who have a more specific interest.
> 
> Add an initial entry for the QCS6490 platform which powers the RB3 Gen 2 board.
> 
> [...]

Applied, thanks!

[1/1] board: qualcomm: add a MAINTAINERS file
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8f8f1fd077b0

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

