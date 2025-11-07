Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E98CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 18:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6957683DF3;
	Fri,  7 Nov 2025 19:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qIJioClW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED96183E0E; Fri,  7 Nov 2025 19:39:17 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52B583D8B
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 19:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6e815310aso650439a34.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 10:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762540754; x=1763145554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnNMMLpYVwi0Zj8DN23sSSmUU9/SMTtT90rU9c7oSww=;
 b=qIJioClWsY23aOhNUw9BizPbFhtfjE/XnFN2JwGnVjhe3cX+SHrfse23Woz2Wj3EyX
 FYddJXSXF1p2RefOMVGwwqjBwxryiU7AOkHlbCzi1Rvp78GYchiANCLmfCzpzFT1zuc9
 cKOTmMZL7jPAOaqYzjSSGsQx1lHnJjwuaFzV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762540754; x=1763145554;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rnNMMLpYVwi0Zj8DN23sSSmUU9/SMTtT90rU9c7oSww=;
 b=TazHW1CJP+G8ECAOA/IUYXPBs86AMb35TJeXJus3rdJtODz8JTSNBifxRSD+ML9lL/
 +aEmf5UGMC/yrDm6lW5nXwybxJYkKd0P5qnaGg/l/3QkkJb0ha5IIfH8aiMj6HJczqiJ
 SK8KvPhQi551ZXxxYW44kso5NSvwtfWN2Ur6WW2rZ/67aO6rkvYySVIreOsZqbgXsLNo
 6HsvCPD5ZO2pP10CncpZtV7vmePE+jeBCNq2jSM4RqBqgSXuoxAY181ANSNTswXbFJ4r
 czxoKcDBiheWjw8B08WBhzPEH51z4zAO1a69frj3r/B5pZ0KG40OVODPKnzABGEFngBb
 TaqQ==
X-Gm-Message-State: AOJu0YwvrHo+2I73Rpviw5SW/zjsVglQcAVY083xi2qKjrkAeftEcG7a
 nZSu7uFAGC6blTGhxFqFP8EubGHu+8+hvXosKl6bmrazvyzHGNYTgmqDFuWWtE47MRo=
X-Gm-Gg: ASbGnctJDe+VowPX9SlHF2V4BsGfYdMBfCakULz0WjhWXKWjsX6iwNOq9SJ9v76SLdR
 +/FPKduSpbTPv8V0TrTmgbhwwWnIK/WIbc8UffEuyfPW8MIojxnTCMNLDpp2LOsajtzd7mYqBXc
 66DsTnmyT6BctVtX9Dti/mXleh1xadLAF6Y5kLNKD8VA2ucSLQusRs17hsCWMeH2ZogF20CtsJy
 Br2tyRbcFipGHj85YQ6BuIIiurMybIvAAoW8FkAtG3vs/N0WxojllHylOrhsesjONl2I1e6XPY9
 GcFXs7zQzYMwkPBebaktVp8PKZRmiJc6mLsyCfosxL4g8b2KPWn9aQ6rdoOKNUpPwmczuOxhsTi
 kZu4vbvfVrXq2xy400J5aPooUkQ4p9SPA2Tcshl0bsFPzHrlZgGLZyRxVMqyGAjjR6aBB92Gz3S
 UPfoLQeuWnRUR3WwBSjE7uHZ7LOuugu7XBDHEZbg==
X-Google-Smtp-Source: AGHT+IEGG+pvamwwsll659bFp4EZUz/th0Lha1WjG4SQPvvyvrK0vot0YtOfhiIajHo5KtAddsstqQ==
X-Received: by 2002:a05:6808:13c4:b0:450:150f:f5a9 with SMTP id
 5614622812f47-4502a511943mr97055b6e.57.1762540754469; 
 Fri, 07 Nov 2025 10:39:14 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450027e19e6sm2587642b6e.21.2025.11.07.10.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 10:39:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <aQ2ZUlW5i4t7lMr-@nxa18884-linux>
References: <aQ2ZUlW5i4t7lMr-@nxa18884-linux>
Subject: Re: [GIT PULL] please pull mmc-master-2025-11-07
Message-Id: <176254075379.1989038.16666090585266386982.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 12:39:13 -0600
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

On Fri, 07 Nov 2025 15:02:03 +0800, Peng Fan wrote:

> Please pull mmc-master-2025-11-07
> 
> --------------------------------------------------
> - Disabling FMP on Exynos850 to make eMMC functional
>   when U-Boot is executed during USB boot
> - Drop extra included errno.h
> --------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


