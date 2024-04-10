Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E948BCD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC9888166;
	Wed, 10 Apr 2024 19:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lxpnpb7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D15D0881AF; Wed, 10 Apr 2024 19:43:20 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B84BC87F6E
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78d70890182so6789485a.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712770997; x=1713375797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aegEI9PowtKcEX9IT/qq7cW+prEYz0iBDCvY2/OQ8hk=;
 b=lxpnpb7W/ZbvPbkk0PcMpz6gLbMGom6yOegg2k6MVmoFLoyiLRKVzzKv2XKGxGE2g2
 YYDh5sqmXNx7bN4gP61nvTb73Av1/bZjzCuWW2BagMGcfqYtBKPijtaggHip7ar7r+Mv
 lJcvMGfaQuH2pSoNZZWHIjlQSqN4XofK6GwXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712770997; x=1713375797;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aegEI9PowtKcEX9IT/qq7cW+prEYz0iBDCvY2/OQ8hk=;
 b=T36jE/hb+l/RJE0BIpT7t2EWrR44fxYQDegesNX8SYhTOqe9ckmN/v9wZPQwexsgte
 fY8IEwGtrMcGtPwa1u3/Z+PBiyq7FNBVJi9yW4qZM2QyFXZ19K9t570Dx9bsUWyLBaK0
 franotxn7xEsyc/KzsWBkgOTWlsKGGDKEyzEmEiVfsyYrpgIJQmG/1alVbx3FD8opQa8
 5N8zjyFvxYuEXJwiZ7WmLACSGSySvacjD6XxorJWs4Uw48bX3cxfJxG8fw9lFUcebUYe
 dlUNuE2kqwlyPMaLG+ICSYAWdF6+KPfDC8ggw9TKVFFMZwCiA0xMhygbKWD1R0fuxeqo
 JkNA==
X-Gm-Message-State: AOJu0YysuraVBy1SEHzHXxh0QRz46qR6kQ+gGRPxco6huNPt6ZXxAvzA
 dYiQDk6zMtI2kaqWCQwuaNZwgmOgmueQ/GnZFc/zSPxlei8JKol8BKBc6HW5rJco5tKo2Ao8w8O
 vocto4Q==
X-Google-Smtp-Source: AGHT+IHcNvLOjygGqlOPzhYktIWzTlCHc/sbX05gj9JVUsZPADg6WqwfZIFNp7YEyaYq+omd3ZymQw==
X-Received: by 2002:a05:620a:461f:b0:78d:36ea:e3bf with SMTP id
 br31-20020a05620a461f00b0078d36eae3bfmr582656qkb.24.1712770997251; 
 Wed, 10 Apr 2024 10:43:17 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240318231640.1343956-1-caleb.connolly@linaro.org>
References: <20240318231640.1343956-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] cmd: sysboot: null check filename
Message-Id: <171277099608.98421.16569416955993571367.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:16 -0600
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

On Mon, 18 Mar 2024 23:16:36 +0000, Caleb Connolly wrote:

> Currently if ${bootfile} is unset and sysboot is invoked with no
> filename specified then U-Boot will crash will a null-pointer
> dereference. Add the missing check and a matching error print.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


