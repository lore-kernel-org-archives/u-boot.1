Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A9FC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D6C832EB;
	Mon, 28 Jul 2025 10:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V6wcFq4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9948F830C8; Mon, 28 Jul 2025 09:18:55 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D39383045
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so39868485e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753687132; x=1754291932; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CfpQ53Bt+Mvgw5+IkCb7B6h2U6hwr0k4yCxz6IDxrX8=;
 b=V6wcFq4SOuC4hXFcWf8PhW3aiN+e/BrRGzWZDsARXqvzXg5c4ggWfA1g4fEKgDsSfJ
 azd6LOIS4sZR6cZgaYhFBAA65xWGyK85xxZoHenZ7lzfaIXoC/QNPOE5QO85j2IfF7PG
 RAvK9P7Qwh28ObTjjym7qVmV6aoBwQtwe6YnzDfYdxul7FSXgUSbsmqnp6I8onRCBUG+
 sHcRz2H3xnlI+fgCGoLpK6oB6bcDz8qibgqLYWux/m0uqUFKYIR2rdB5LeLqs4yHb0J3
 UBBCVK/kmDbApGFKfrJ+lZl5/27u4tbLMii1HWgVbCNKulWTwfBzMRag/iHJR0xDIiCi
 0Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753687132; x=1754291932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CfpQ53Bt+Mvgw5+IkCb7B6h2U6hwr0k4yCxz6IDxrX8=;
 b=AvCblEmf1aHQpiFLZYqCZlzJpAr2LXSJTwRcKn31lVrFf5ghT3BCHLZWB7Sqrzztsl
 MvBwUOhEqRY3gZNP06jkBGy5T7wd8SuYCODRYtqvUa06IgtFF2bydImpG/fSPCsaUWPO
 tKLmVhxyO6xhIIB+K/jRUHGPgT+THwLpBrgd5pUMlIjh3YZZUaxIMgdyUYahaMTM+Myv
 DHpUSEtDJnGfahvBsKzpB95nIAJY1JDExkDkfVp7K4RG5IE5cF6zvO5o/DzXMQ0Ftq69
 zWIaof56R01KpGKy7oCZoX7bwmlC/5UJyTalXrh3iwgvauMbKj4xlHFEpINP456xcXys
 rpFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxNU/3wQY0YWa/nfSXUAb2SXxCZC3IwCiH3W05fp2tUEmbMq9pTSkSFFsih0yvm/qRt4nWYe0=@lists.denx.de
X-Gm-Message-State: AOJu0YyiKQPFrRupHqlmFkpBYsbKztK4s8u45Kmjw60RfvUAZkCNoWvt
 2cuS1tpnq7QzBqmPik7GcMdy2Cbcdhmw4jtWRCEs0qjOnod+i7yczJ/FbDUWk916J6stQZn2IkL
 TsMwx
X-Gm-Gg: ASbGnctZw03oLe8J1q1cr87HqT8I4yPOie4rYRiZzB9oGKvq6t+jW+zjBjr26fGwhJU
 QAA65mBYmJLow7EjInkhaKZ5QtJJgxvzo/EK3tz0oQwdY0MZsW9tcXiRMfMoZqZSPHLU0IZ7lsg
 A9zfnAcNWzBOt58j2LQ0rRY/4tuIHM7XhSndsnCQhqQSBJQMkbKt4lju6GyUPfmuUSrOx43bqXo
 A8KnHJktzcT9vs31P7mdyf/hIsUstoKAgb5FeGO/nIvjzazYz15qkjiT2LrS2vmGLmkqD4lOKfO
 0xx0KC81MkAkTdbFg9vKR1z54o5j2uKD6N/UDBsAcUhNsjXbwJP6hdFFfdQIso9K6paFbZDZT13
 g6qUulV7ztTbVCeN0P6OcmmsgUVvsKS9Ns1kEc3ikuA==
X-Google-Smtp-Source: AGHT+IHOsVWF0IFo5tVsboDolTAToR3bq9LPJDue2qRNO+7Fos1z5rkvkB20+IbS+VPHdqGoAw6sFA==
X-Received: by 2002:a05:600c:530f:b0:454:ab1a:8c39 with SMTP id
 5b1f17b1804b1-4587c490fe5mr53004995e9.26.1753687132267; 
 Mon, 28 Jul 2025 00:18:52 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.235])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac5818bsm89398635e9.20.2025.07.28.00.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 00:18:51 -0700 (PDT)
Message-ID: <0951e73c-74f4-4f42-b6b8-fbc682ac3804@linaro.org>
Date: Mon, 28 Jul 2025 08:18:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Fix return value of s25_s28_mdp_ready()
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
References: <20250728011358.30034-1-Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250728011358.30034-1-Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

Hi, Takahiro,

Next time it would be good to update the subject with an increased
version, it removes any confusion.

On 7/28/25 2:13 AM, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> s25_s28_mdp_ready() returns 1 when spansion_sr_ready() returns negative
> value (error code). 
> Fix this problem by following Linux implementation.
> 
> Fixes: 1c3dd193b5b ("mtd: spi-nor-core: Add fixups for Cypress s25hl-t/s25hs-t")
> Reported-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Cheers,
ta
