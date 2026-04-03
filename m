Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB2FE8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C98D8419E;
	Fri,  3 Apr 2026 21:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="unwbK+Z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 821338413A; Fri,  3 Apr 2026 21:47:24 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E0784178
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbb89ab229so1009702a34.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245641; x=1775850441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6FdjD1GlzQqciutGNtsS8NxQZOsJzqo+TbyHq4IscbA=;
 b=unwbK+Z1bsL6ZabkKftrYIz0JCZe9mKPay7Z+n2ltHIVRm7uUGsWB93mZSuBNhM4rK
 h+dWoUS/Kq/SABU1E2unLoMPp2ebByoBBtNVUGzR14mlOvm5DFV2BeLes214KjCae0tG
 vMy4ImD/NV5bNl58S5yrILSM4iR3RRGB4ZByU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245641; x=1775850441;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6FdjD1GlzQqciutGNtsS8NxQZOsJzqo+TbyHq4IscbA=;
 b=irefC1wfhScsNasnza/p+8K6dXVo/pvlJ148wFZ1Z8TqrDaHq9SjBC2VcW+FLol6Yy
 jZrliwm0GjqLW1hg7TXABjVsKnSBVBbtUi5qrUNJtR2kA9P6IaOCQA++nkr0BWVLgsf8
 D5+w7jTr2pFKdz4TaKeyf3vnJ3+v30VaS8P0IZPTcrdSMvvWplSYOBh2smKSF0TmVAEN
 cY9JDKtcKTZsCh1VKvi73xpEDjkppGgdY7VOrGEtLCVKg5Ujxaxtr7FI/n8AJtJzb10w
 LyDgKyjUgVKO3GDNbieYORCcN4XxRZhJyNNwwBfSE10NUoP5hS8tKkPiJ4nUsWaBr89Z
 JKDQ==
X-Gm-Message-State: AOJu0YyRxHs9Zug1ePXYrjiIyXY+yP19HxOgVrwRkwQLDu8z1i7zrcvl
 Nycs3q5LTsssLED9zyoY0PqsHYiE4K4qUPQD2Y9efcmQ6rypQ0zs06nq1KC/azKKj5fjz2bAkTT
 KSsitjVQ=
X-Gm-Gg: ATEYQzwtLGgK1jdj06H45WBRBMHszO0Y2PAOSF6Lf+q55bJGgGJWxaNDM38F4azB5wf
 jf3lrKc9MghyCwSREDRCfEw5t+AL0aiAiZFLaGwcLXvteFt2O0c7TRQ6Gv+eSHqEnHIbC9X6nMP
 6ko+hcWSp4YHccupqmjwyzTg75CYBSIixisklG+MAS1vgsn10OPgr/LU2Zxk+/Wiv0aUaPICJS9
 lPu+V61GtLAyxSaOMUUfsAx3S54CwrD8eRvuypE0HAz7rHnZmXm+yjllkPP1gm/KukfNB86ok/H
 +tSKZy7ER9Lg9+mB97Vx7cUKALIzbTpF+j7l5h2U8csWsyLHJCeuI2Ocb8T+NN3Y3+fPU5MX5/h
 LcVspdEyXLQysaTmq7TeAyHUsj+puPCOtK003gAc4sTedM3shkRXy8X+qDiSnlsKo5mytXvaR1L
 Fxmdk7g3xO7mpPUpq23YUUFHWOTVh18xJxAr9laavTkDl1cCOGp1N8fUVDsU8i6twlqsmYwAnpE
 ESEuAQ43V2BUFV9f/bi/HrpQUEgjVGISs+O95K0VIpwWYU=
X-Received: by 2002:a05:6830:3890:b0:7d7:d60e:650a with SMTP id
 46e09a7af769-7dbb7576532mr2494726a34.23.1775245641189; 
 Fri, 03 Apr 2026 12:47:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205342.3789018-1-trini@konsulko.com>
References: <20260320205342.3789018-1-trini@konsulko.com>
Subject: Re: [PATCH] loads: Add LMB as a dependency
Message-Id: <177524564062.2281750.9689904027494432596.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 20 Mar 2026 14:53:42 -0600, Tom Rini wrote:

> As this command calls lmb_alloc_mem directly it must depend on LMB being
> enabled.
> 
> 

Applied to u-boot/next, thanks!

[1/1] loads: Add LMB as a dependency
      commit: 79a9978112757892d7cab13a8e65f1c22d2b3037
-- 
Tom


