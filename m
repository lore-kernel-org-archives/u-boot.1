Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A03C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D8F888963;
	Sat, 20 Jul 2024 19:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xs/8kadu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FD988955; Sat, 20 Jul 2024 19:10:29 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59D08883D
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-708e75d8d7cso1701641a34.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495425; x=1722100225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjU6tZRkzdm3V++NVK5ifF0H25nqiPVa1mrdkRs8h74=;
 b=Xs/8kaducKFxte09A5X4tKOnwzqkiikhjqsSmsotIgDGmGKOV72T5I+2aWzTMY9ZB/
 URTq2+s8HfftyPaCCW2BGxIm7wOi5/B7BIuGLXqrjkkogFfKBYAcvvvoNfEoFw32HBUr
 EMF7SEh46chEYYO4ZQ+k36VmWNJQZKusqkt94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495425; x=1722100225;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjU6tZRkzdm3V++NVK5ifF0H25nqiPVa1mrdkRs8h74=;
 b=iZzujTjBBIyyRnyu2RR9RJAWLaZtdJSaOzOLmIXFstgWEfwyOtLyBOETgwUHn9xSJz
 4w2qD7kIB67W+5tIQ8/b9NgJ6WoUqoKTeB6O5H3Wi4tec3ie+m7jf12DXCQ4483h2Hzb
 Ej239j8qZNGbYIhh6S2Iym3gih2YZrC/p5muj4FTzZWd0XTV8rTYazQwSLRr30G4bulJ
 pj734l+YhGupjJ7lvD/gnXAyL+6H7MvsiXnN6T/rlpnsahA1IDgazaejhYUnyp5iZ72Q
 18GcZQtVDinbNN2rLLE+EW3sBPNAol721hxqn/sL0VWdVSAfm4l1DxEZpyi2TVhQxUWr
 jMWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4BWLLMRFSNEX29kOlDvm/LtZ5WpTI2j1jHWmWRiDPIUhFgSnqgQ5n9MaXmms01VKV2QQtQLS1s+8vCxG6PWgfzGXvvQ==
X-Gm-Message-State: AOJu0YwgkDT9lFVvDJ7/Jr83c4Axah1zOzNExPfIwOhCxTyHD3hGfach
 j791MZgCsewDJiCZ2kl+nFoWeBpzIf0tD/DXkN8S220IVeoe5FgHheK3l27bRuNMWsst376ZQLz
 Zqpc=
X-Google-Smtp-Source: AGHT+IENS+3UiAZCyKUSGP0Na8CL0F1he/ZREsqRn8Y4jEiW4Ccalyw01/zsXsnNVBGaXyxbj3f2fQ==
X-Received: by 2002:a05:6830:650d:b0:704:4658:5d1 with SMTP id
 46e09a7af769-709008bdeb9mr2536063a34.12.1721495425503; 
 Sat, 20 Jul 2024 10:10:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20240719212326.42901-1-heinrich.schuchardt@canonical.com>
References: <20240719212326.42901-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] doc: define html_context in conf.py
Message-Id: <172149542410.3268377.14284744403781720948.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:24 -0600
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

On Fri, 19 Jul 2024 23:23:26 +0200, Heinrich Schuchardt wrote:

> The dictionary html_context is not passed into conf.py but must be created
> there. See
> https://dev.readthedocs.io/en/latest/design/theme-context.html#customizing-the-context
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


