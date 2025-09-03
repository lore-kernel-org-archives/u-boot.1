Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414E7CA1012
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 22:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D4A83616;
	Thu,  4 Sep 2025 00:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xm8bx7r6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4CA83621; Thu,  4 Sep 2025 00:53:26 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AADA7835C1
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 00:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74382041c9eso312961a34.3
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756940002; x=1757544802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCCrJTI+5OS0PefrVG9EHLYZvaBWGmHHv7JoJb4OMdw=;
 b=Xm8bx7r6oUMR/pAFcPsjjwPAJXmW2UsLV+LFik6jgbOs20jcU6R4APv0flkyvAyU62
 U6K9whFHs4DEEZik+r5jxX95QzOkBC0fFZZgS7koRIqjBo635Jd/ScQz0HKw2q5K5l1h
 N56hi2ZVHc7mpgdnnq6xHFvJsjdESWGS26W5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756940002; x=1757544802;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCCrJTI+5OS0PefrVG9EHLYZvaBWGmHHv7JoJb4OMdw=;
 b=HU6t+Cm4pQnX+z6RKJA5xCfWPCB/Qz+OC6asp0E6Nma0ngQGfkRYFcTwpk3Lq1v8st
 O9Sje8VNSD7RshE+jatf37yF/8rBLcwVE934jv52KGbP9HJaEx6rnCt3JsOzcPIpAR2z
 OEWR+hYXPsNjosIWvpNqqjQ6gL1rJm3sXkfl1ys8+N4Y611v1WzpchLrU4NnsonEraov
 xxbe5OqHTwy4MmUjhf98wisPVZiUvr9DpF4Zeo9QqRHooyUkVsNxI9Zls6NOR2/uR849
 hUFXqFHeIkiVPY4sO4tBhO/r1wdXpI0StDwi5tAxVZJmzebwPIZJaLtTsD7t/plCP9hS
 ukIg==
X-Gm-Message-State: AOJu0YyjgA2AGddFH6O6AD69xy/Md5XiAISaLRy8alGzTw5uSQKf3xeP
 qDl5L5kvx36sU2/bRAHZoRIZjW5b7n/O3GPaw73nJXojSgFYtZf29mg1iIL3jAnFO14=
X-Gm-Gg: ASbGncvDMt4LTljWtTOBJR4g5Ck2MrHw1/pUcSBZ1sFemi2cz/r7nyv+ksG+6dPZpO/
 qq+0aa+pym/yhYJDDBgFqnG3MWsVQzFun1sJ9VKWpVfiLuXQKlFhpEkZduPzGyGPCow7s1Ub4bl
 P2z10FIrlkn7OeIQjAE3xKrvpz52Rhbrg8qwtS8zxsEHatTu/49AVanbOxgheVSu5BfjDJVrVbD
 KbpW6uzBMoTDUtJkCPCxEFFThcij4BFHYYk3SV49k2zn2PguRgssyHr7TzND+ZAhHYbe+fHIk/W
 Sjbcri80jr9naptCptszY7m43FUisnqHmyYI9m9LFahJgIxUjHw4k/NLIVA0K2ZGb0dkVfhlekW
 fyq5ZDyTW03OQXSLtbGlkzoAiFWrDzRF4E/Ioo4qF8ksvnwPgkPKNmU8sitWI3WvI/A==
X-Google-Smtp-Source: AGHT+IEBgJc89DCKA4EaeDdGKywQiPyeGC8iH1kdkjI0Y/MFQgaygVSRB/oL7gl++xA94cLeliRBHQ==
X-Received: by 2002:a05:6808:180f:b0:437:df55:7fd9 with SMTP id
 5614622812f47-437f7d891a1mr6338358b6e.36.1756940002361; 
 Wed, 03 Sep 2025 15:53:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457428c2a5sm2461471a34.2.2025.09.03.15.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 15:53:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250903020045.878082-1-marek.vasut+renesas@mailbox.org>
References: <20250903020045.878082-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <175694000141.3532179.2594852899650711124.b4-ty@konsulko.com>
Date: Wed, 03 Sep 2025 16:53:21 -0600
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

On Wed, 03 Sep 2025 04:00:26 +0200, Marek Vasut wrote:

> The following changes since commit d367be2b13a388fdb0dc2720f66c30ddcec8a4fd:
> 
>   Merge tag 'u-boot-rockchip-20250831' of https://source.denx.de/u-boot/custodians/u-boot-rockchip (2025-09-01 09:50:01 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


