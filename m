Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD36BFD4F03
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B2288409A;
	Tue, 10 Mar 2026 17:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bg9eopEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF132840EE; Tue, 10 Mar 2026 17:08:04 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A3A8409A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-662f2fa7e67so5012573eaf.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773158881; x=1773763681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SadQljlJLuDWBwsrI7z/LHgP9OSuha0EerxVU9MRkBY=;
 b=bg9eopEQ9OZKzyhRVXVIl5vcMx8bBkEmX14IBTmqaI2GLqlecjtx7MwobKFq/it83E
 lZY3q7cGxvRUuDUhUTRCUM0p78xCFa0bbmBPF9/cXzf6MR7FTCjivYVRlZW6l+x7N70e
 o8e47wkGL9yg8kFWNxA0yEP8i6vXKmr1l6qjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158881; x=1773763681;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SadQljlJLuDWBwsrI7z/LHgP9OSuha0EerxVU9MRkBY=;
 b=YUdNv/epct73AMPWBI7jdFqCsrrtFHxVAUs3yoPRb6pdJKVmiNeCqDVBdO6c99L4TL
 b4aW1afOOAZOGPY9yUrUkvQdvZh2wZmPC/YmYkCwyflXwdDCHPHg5CwB4lHj+V89QA5I
 hFb3PLq8lWgQ9yW+bLojhH/AUVIh5rEOPfZzEJLFamwpVUbWNJlJqE3PoEQJdTkgRjgp
 BN6DxacK336T774RBwfEDf9TOWWH6IdpNxAjDwt2CBMBBxpyBZbQ9yAKGm/qmPL1xDj4
 5R7sJCJEpk+joAF79GNCxgAEr0802Yf7ZwOL0PiAFkgwSy8vilvaGElBw76yj4+x6vq3
 Vuyg==
X-Gm-Message-State: AOJu0YxdUMzp0wRJdsp+4O39X+w7def0zK+EvVx1UkrwSuY5V1Ttd6SK
 rHg+U77g7xWSZ6K9j0uxnYy8l2ItfE6q/TVfeox+yMZ60RF1SLg4ldxkBP06x49uvg8=
X-Gm-Gg: ATEYQzwTvWU8SlzqaUFzITJBLsoAI4s6ioPLe4zBuoyP9DRmtwB3ziiYkjUMhSX3DXi
 nw/7sx3PieKrYsG3gZ1PFkc9tloId480eNREFHDly0SksJutJWyihrAtvSQ4wUo+JVfGo40tPJG
 sChqfmCX6mgr//kJjg1NJsIqOWeP7dids3tKYF07KzXjDzmbUr+26ozqcYjF/mOwbcnVAsQ2VsR
 lPPAEraznth2IH5EGy6b4LRJZQmktxuO4XeaYd+OAq5Xtg7h6D53jaOZ08Nw2Tn4GoBSVDE2rq7
 uPGJAe51aAgogkBbQ8qPCaGAyl00i8Wbkb9cD73eWSpJ2GitKuxHvoKf7VPiFZB8DX1Xg0uU/BA
 mtbXgBSF40dGBzOHIZo3WokK+C5+gbd3WxpUwPj0Kcl6Mx12jP4gDHs5i+mg1DQtcw8BqbfZ29v
 yNx9SwKltU34SVcDma4lfOU6Wb/SRyFQXkMYTVbzvIaanAnQrXFxkNKwbSreaHfP6ydzc0E7SZq
 Td0pZQBthgJFxJayqiSYHNickXnzZFTGFjAXWrvlYsX
X-Received: by 2002:a05:6820:818a:b0:672:e67a:96cf with SMTP id
 006d021491bc7-67b9bc81ea2mr9738044eaf.16.1773158880648; 
 Tue, 10 Mar 2026 09:08:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm3501313fac.8.2026.03.10.09.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:08:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: francesco.dolcini@toradex.com, ggiordano@phytec.com, anshuld@ti.com, 
 m-chawdhry@ti.com, bb@ti.com, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20260219102721.102254-1-w.egorov@phytec.de>
References: <20260219102721.102254-1-w.egorov@phytec.de>
Subject: Re: [PATCH] arch: arm: dts: k3-r5: Drop a53_0 clock overrides in
 board files
Message-Id: <177315887979.1153104.5198388483610482163.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 10:07:59 -0600
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

On Thu, 19 Feb 2026 11:27:20 +0100, Wadim Egorov wrote:

> The a53_0 clock properties are already set correctly in their
> common k3-<soc>-r5.dtsi includes. Stop overriding them in
> the r5 board device trees.
> 
> Fixes the following error message:
>   Failed to set clock rates for '/a53@0': -61
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arch: arm: dts: k3-r5: Drop a53_0 clock overrides in board files
      commit: 045fb42827cd8a24cc1024550421f867d1a954c7
-- 
Tom


