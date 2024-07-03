Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6356AC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 23:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285B9882DB;
	Thu,  4 Jul 2024 01:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sv7472ve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E497188889; Thu,  4 Jul 2024 01:22:21 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC29E88176
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 01:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-702294d6265so31596a34.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720048938; x=1720653738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFjRO54rIL5vMFcj4cc6wSXZQYDzkNNA7UtmNe8bKSQ=;
 b=Sv7472veAKMMQQiftc0+IFbv1tdnNyf8BftYEmg+ULYk6uxmUbiY+w+Uqaw1Rthx1J
 WVUSv3c23bf66m0xt7YZrhAEE2VObv5eAdt2gnRngciuGmpXpDvyfYjdUhhwIkwaT4dw
 1SaYNpbH30T8ovRi5lACOK4YZP2vd8l5fSDcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720048938; x=1720653738;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFjRO54rIL5vMFcj4cc6wSXZQYDzkNNA7UtmNe8bKSQ=;
 b=L/MLIvjjptTdk6YcYqrEPtOuQiVMKo1satvGIm6wnkhd4JrKsY0zC2a+BXf60T1kBi
 uFLuRphcb8aVoYgyd/9Y55IR9g2EmNinc3QK5Ue7ASzABlM33W1BnI/imxqz1JLOhSEj
 P9NJKnh3l4qCWGSRTRvT8jbVj0JiJlPmt9RWneob6pYxUg33Y5yw9oBqz75sc/+km1vd
 7kEyonhVlO+sw2prFcOCcnygiHPMJynYceiSIH3eWr1XunRDKWbqkdAl9dCF1c3LJbOR
 l88I60P6NMN/oRk2RFUSUP1/NEEPkqtkmSuGtOr56fL6BDeeQtA/07FXY+9aWJO8Tx1e
 uvTg==
X-Gm-Message-State: AOJu0YwwcNzB/HUqIoxFQhWnacW69loN39Gogny1BJQwLGNCCv+0UXr9
 9N0eoCxQ5NkgO0kTfTFrzTJrQ1Zlsxww4peB9KvehMkkORlh51lq/FwRiiZ5PsQ=
X-Google-Smtp-Source: AGHT+IHpUwazyeuZcfX4BptaM23yyd9iOjApBq8lKcURSvf1QNXuH68kVoKul420h+oYWWm45GE9Bg==
X-Received: by 2002:a05:6830:1681:b0:701:f21d:da69 with SMTP id
 46e09a7af769-7034a75b91dmr96664a34.19.1720048938633; 
 Wed, 03 Jul 2024 16:22:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7b20212sm2145030a34.61.2024.07.03.16.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 16:22:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Huan Wang <alison.wang@nxp.com>, 
 Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240619212759.3456158-1-trini@konsulko.com>
References: <20240619212759.3456158-1-trini@konsulko.com>
Subject: Re: [PATCH 1/7] m68k: Implement a default flush_dcache_all
Message-Id: <172004893716.1443950.9778601060535926794.b4-ty@konsulko.com>
Date: Wed, 03 Jul 2024 17:22:17 -0600
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

On Wed, 19 Jun 2024 15:27:53 -0600, Tom Rini wrote:

> Implement a weak default version of flush_dcache_all which is based on
> the ARM default, which is to flush the entire range via
> flush_dcache_range(...).
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


