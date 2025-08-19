Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D37ECA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E726782F14;
	Tue, 19 Aug 2025 21:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jVQzOHVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3817C82E34; Tue, 19 Aug 2025 21:43:12 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A3C8211F
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-74381fa6b15so3289810a34.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755632589; x=1756237389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U25R7q7XPxosGzquCNtnlz9aRjpj8Iz2FjhsXnGfF6Y=;
 b=jVQzOHVZr6nWE0TMKb+BDEB3NqQl15J44kYjCltmHaLr/hi/RDVPhcrIPIp5rl8lHX
 VCyVWekRcwz75chBul7S2dIc3RxlwFENbiDOrPMKiA2Im5+KRd7s8t88eRF132CwDxMP
 p7b7X0GvrKplyuyS3cOVGHB4QVWcGWN4vlkhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632589; x=1756237389;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U25R7q7XPxosGzquCNtnlz9aRjpj8Iz2FjhsXnGfF6Y=;
 b=D2OjBDQ1jiTgbsF1ao3bgGI7xFuXLoCYQenzK2PQlEnGOA4rfHV4WDXbBjOqwWgjZk
 ipYycDvxRJFGO8mtzMsF+ebGV8+BdyGyI09aU3XRyu09yp5Qb6rxUvRNpdEs0d3g/GE2
 THV3jZahcLFDQSWVhLrSACWB+OhjJgLT3v6rEWl1729Arg3RRqRng13DffuSyf/yRUTs
 C3k9xsD2FHBvSbeJ7rcsBvXbxvCpeClHcuX78QeQ7JPX6EySQkwejzNJ6wXUA1gljdvE
 jFbvMOG8LdxkrMKi+3w2j6Hh5AUWKUSX50k94siyR0lQjkK6muwhVYljdOUKFQdIR8+i
 wnZg==
X-Gm-Message-State: AOJu0YzAtDnpY/nmUbiXn6xY0zpEoLTr2F80vE/NCA0iMKjBvRftfcjP
 fUoS81o8Ssr6zme1yFArn04eiSfwPXCQuLhCBOx14cNCgDuX1c+9tyZUj6B2DsCmhQIyQqDFHDU
 sNsPl7dA=
X-Gm-Gg: ASbGnctQd9UuTvQqAwDlGgZTYIwaQQrIWphWsDQz6UpHRUQvLxRN4GccPXRIi+9CQQa
 pBs7ExGR/Aemo7KWscT80wV/TzCwiZ+/XojUzIuGjB7pMNBrXbbLAt4H2sT9Rhm9KAl006WhyM4
 jrbG8o2KYuK76evII0y0vQuCF2aX43063CKj28hHDa9MA4ftMREVXOZOLC789t8NDCyGwXO76P9
 blp+862DKNIE9dUyWjJrm1A4mrHGByWMrrNtbL4ykGg5Xf2IWr/o1NoZ3eISh/hTQOcnMeHPEx1
 6k9KXNLQuva/dRXc6USnRTzsyx70D3GAStUS7SAXgmo9YgZJ1EPA4MCRV2pmszJSRX41r0ph3jh
 QGGEkYArPHFc9DYoFGhx3q4MY1ntVrTy0iPiYvfT33PFswD4L5NABsN4=
X-Google-Smtp-Source: AGHT+IFSCe2pDHWrX1UoKsheLYurzVTIF7e3I7s/91/6/Ilw50ouR6Fq41ZlKSYYWU4seClG22xjiw==
X-Received: by 2002:a05:6830:7312:b0:72b:8fd3:e2dc with SMTP id
 46e09a7af769-744ebbf4d41mr292766a34.21.1755632588885; 
 Tue, 19 Aug 2025 12:43:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204e5easm2525109a34.38.2025.08.19.12.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:43:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812060326.1193684-1-ilias.apalodimas@linaro.org>
References: <20250812060326.1193684-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tools: fit_info: Make usage() static
Message-Id: <175563258795.3359676.8826677652048969789.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 13:43:07 -0600
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

On Tue, 12 Aug 2025 09:03:25 +0300, Ilias Apalodimas wrote:

> The function is only used locally so declare it as static.
> 
> 

Applied to u-boot/next, thanks!

[1/1] tools: fit_info: Make usage() static
      commit: 6139d5f2521593edc64421976d7830e44121745b
-- 
Tom


