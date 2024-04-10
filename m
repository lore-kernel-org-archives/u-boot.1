Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB160CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6B6881DB;
	Wed, 10 Apr 2024 19:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UP6hsER3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5B387D8E; Wed, 10 Apr 2024 19:43:27 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D53E388199
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ea0db2727bso1901393a34.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771003; x=1713375803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAm0VwSpz+MgCmyzdAdvJyfYUfw2Mpye8LWwGQvEaco=;
 b=UP6hsER3xx/mFwc+UEjol4Co8DhQwj8/ss+jFyuSOs4D8SlvH1lHfXiokvycNwaZdf
 uRoK4J7GO0uk1B8/ZCiim2S70LU4sAhLqfGj/zyJBk4pWfFcExi+7bdF8gCGgsH6BROt
 UQgeQFcNL3zDBWu2cpffMlMHeN4j0lPa7ACNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771003; x=1713375803;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAm0VwSpz+MgCmyzdAdvJyfYUfw2Mpye8LWwGQvEaco=;
 b=kU6GSLjfoBaeieZNRgKRkuGRnb7N45N8A3QB0akuGbJ3h3FRGE9/9afHf1Bn6Jg0sM
 5e9QlLIyCsry4KTEIuBxMaIJiS2vzT/4OOtBIXPKQRDf/wZMgzhhvwSV6POMlzx/+XZX
 NegSpeNxTcmmIPqgnQqSMDLa5EUNRf4DfZmXpSZlkpNfVfqxkjOl3KtmRGu5bv7qk6Gw
 4e87KCQ4Nc29QlOzZa1kMaugb+VOmpZZB1XCCtTpmAS6Kl+LoT7ZYUnaYBjbIhbAr05y
 TWG0WhJC3nUHNHj9sVYpXtKITLcFXmAm2lVGhAbzoDBVKPDn8qea3Vx3NgxHRMAhu848
 XEXw==
X-Gm-Message-State: AOJu0YzdFWJ47IvCQMT1TwBWpk/rwyhIGs/FiFFJAOBxfLT9Hbzf2Swm
 JCGBp7xCA8J0MqRWbbjG1ceykuoKoTrXJEiwdzy121sgAapvViJITvGOKUxVqez0lfguLdqum3E
 xEjRAaQ==
X-Google-Smtp-Source: AGHT+IFGlryCBf45Da8FHbib5hP8IKgZeOXmLAIRK24E3ODQ6c3bB0uukojE1fx79jaY7OVJ73h91w==
X-Received: by 2002:a05:6830:138b:b0:6ea:30bc:a6b5 with SMTP id
 d11-20020a056830138b00b006ea30bca6b5mr2829236otq.22.1712771003511; 
 Wed, 10 Apr 2024 10:43:23 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240321201613.13607-1-heinrich.schuchardt@canonical.com>
References: <20240321201613.13607-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] rtc: goldfish_rtc_probe should be static
Message-Id: <171277100274.98421.12672318564339142601.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 21 Mar 2024 21:16:13 +0100, Heinrich Schuchardt wrote:

> There is no need to export goldfish_rtc_probe().
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


