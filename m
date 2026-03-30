Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9081061B22
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D378407B;
	Tue, 31 Mar 2026 01:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r/BZMWyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A394F8352B; Tue, 31 Mar 2026 01:00:22 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421518403D
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d77b179b52so4907151a34.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911614; x=1775516414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7g4mUKcnZOQ9pkuaxzGdG49mtZGx3H7H+5zychaLNw=;
 b=r/BZMWyKezJOWjsi3qAK39Etk3w0mWDn90ET7vkzMFbFUA2Dr4DpDya7YPH2TZiit7
 NIXUjjQl2uqEJQcZZDEyGNYgUhRs+IDnE2jbLjzV44Nz0/lyO/CX+NfgfHQPAfbYRNB0
 DGoqrX1q+EzOalSde1JUwaubz2cUpMIXvioqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911614; x=1775516414;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g7g4mUKcnZOQ9pkuaxzGdG49mtZGx3H7H+5zychaLNw=;
 b=jzq31YkaVUypR4asRqyOV3Y4OKthuPbJGeiqy/bKeA7cbMBAH7s6YG4Kvb6Egg1ugu
 29EQvgLfZAo6ManceHlC2wy96RR3GsQphw/WU7lGBU13SHzo1kfdiXmNtUOnKzrPUjFW
 qTnvxsRL/wL/LpjbkyE1UGSFhaB3Ot+od2RjXw0rOvYMGp4QgYTOdG4s+YullYDwEmfk
 hl12J7wxrZGHsquAYhlsSryjknHRV+BlFu3YzkCBf5RImSm4LB9GBflc9ClSQzexfwDk
 wfT77qpEXGIEYYvaucOLDrHOWQwBJj8cleHp8q8J/4wpTvM6QC+AvpOh6a88JXKgj/Of
 u5aw==
X-Gm-Message-State: AOJu0Yyv8eBvJt3bjec8du/obTjygEbfQMYdNDpcfx3H8Fwo7p4p+rfA
 qggnWXe+MsifCT8DVcVMzAP+Tcvox9T7waLvUO7NNVv/kGHaRJ2zc8DkRwgNqrtHvOlDYLY2TTR
 8e5G3XWY=
X-Gm-Gg: ATEYQzw84Fg+RV6LaAp/qspt/hH/mH/IBAcwSWbDCHaC8PCVk5MwEnYrGCqk1G+Yvdv
 jyYGfcMQT6OiiODwE82ruzx1sCFLqcV1/BxJtX20FNQ/jQrXwdHGLv20vrexMEMQmwMfZn/c7mZ
 UgXLn0JEok/iwAgUZJDGUqyaE9LKYI+9Z/ZNTWZ/4FFzq+LBJkw4BpO9ARnE46JHwLOaR6RM3NC
 T70AQ//C05pUCrtUaDvIX1YtRbQXPK7wh0Ugf7+o6oyXV1JpK72LAOLgUMI9znnDV5wK6vt65Ip
 JnYIRsay82HwwMaEXnx3pewp7COLRCPJH3gpl5+wX4P+0SC+DhmbtIiyzL93oAH67rMzQe7Bdpl
 e7Nl8YmBrIdoMmZ3De4+ISzGhVKDDWbqvatMC1nn51tviZ2ZRFSypI/+kP2KJIlKj/dWVK09E0M
 EmrjeZGRJHmxKYPVO/v7FZj194cDHxhXQ37FkbQIqUx7hFZSBEE8ZXejqjxnACC8qSsK2QOohwH
 KQbQnD3xY+SOaARWU8p6Kgo74fsks5ZX+GWauFEI1wF3uI=
X-Received: by 2002:a05:6808:1582:b0:467:bfa:bd9b with SMTP id
 5614622812f47-46a8a458dfamr7130405b6e.21.1774911613916; 
 Mon, 30 Mar 2026 16:00:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260317012437.4162554-1-trini@konsulko.com>
References: <20260317012437.4162554-1-trini@konsulko.com>
Subject: Re: [PATCH] input: Correct dependencies for BUTTON_KEYBOARD
Message-Id: <177491161308.1028292.4696400846631007748.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:13 -0600
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

On Mon, 16 Mar 2026 19:24:37 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for BUTTON_KEYBOARD. This needs to also depend on DM_GPIO, and then
> select BUTTON as well as BUTTON_GPIO, in order to meet all its
> requirements.
> 
> 

Applied to u-boot/next, thanks!

[1/1] input: Correct dependencies for BUTTON_KEYBOARD
      commit: 292f1b974b2f2076325ca5648fca1db9eb2366ea
-- 
Tom


