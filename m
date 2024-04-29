Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA16FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2EE889F7;
	Tue, 30 Apr 2024 01:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p6cKRGo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6909F889A9; Tue, 30 Apr 2024 01:04:25 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63AB7889DF
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78ef9ce897bso349482485a.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431862; x=1715036662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThObhZK+wGIE8H0kOQzaUwivnYPQHXEAoY5YhWY2HOo=;
 b=p6cKRGo1J5rC1PG0nGJuQ7Czn6vYoaBcomcXXaU4QFuOMYApj+/KrejP8uO547LcJc
 djE2rZdNRhUtfHy4lAPb0tCZuNhmGF0bfO6GyCtLpLE+SKUWpxMTcxzVeYO4RKtmrqGI
 SAJ8EAmIGisFRyh/Rf1bmQ8YvjHgbWhwAxvQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431862; x=1715036662;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThObhZK+wGIE8H0kOQzaUwivnYPQHXEAoY5YhWY2HOo=;
 b=h4QWkzo3YNCW1MbQOyzwo0mvHLpP7F6YSlXdkTcCn/LsqC46M4R2/viiylakaE9Lrr
 REF5T6IM/WUaxE09yxCokg80G+u2tootlqZRkkJky7V0JoMKLZAxckOJH58BESNi6gCl
 AgE9LXPSB3QsmmHkADb0AdSi08CcRUCd7PcGTc/vWyIAysAiVbR+9ocUegNiTCb05Syg
 KN0XPH9qRHj0Az2ul5ar17swiMplZXakOvhRTng26nI8JEKFrqK0xCUcP6Y+PCH1/3fx
 AN1xuyFKDi423Lm99ZyZLngg1rGB5zHB+S+fbNj2oOA8JXzzN0Zx+aAvsr3WNoou0ypB
 5gtw==
X-Gm-Message-State: AOJu0YylO7Z1NKa2XPk0Se89W4iC/zJY+a6/9WeFfVkVWPB/VXwny6t5
 tjLR3JaGIaneyzl5twT6j975g8GZREHUuGzhWkoe9TeB/eaCry0/f5/8N+vRXiRcwOxYzCWI80R
 IebiUxw==
X-Google-Smtp-Source: AGHT+IHfc+PYfEJhzyvy4uKW8rSzI434OacsjXZeiXNSq3W0SNPkbH6kuM9BUd3ehb1wnF3X5uyYyQ==
X-Received: by 2002:a05:620a:2150:b0:790:97b3:68a5 with SMTP id
 m16-20020a05620a215000b0079097b368a5mr1016259qkm.51.1714431861923; 
 Mon, 29 Apr 2024 16:04:21 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
Cc: upstream@lists.phytec.de
In-Reply-To: <20240419065117.2305346-1-w.egorov@phytec.de>
References: <20240419065117.2305346-1-w.egorov@phytec.de>
Subject: Re: [PATCH 0/3] *** Migrate some PHYTEC boards to OF_UPSTREAM ***
Message-Id: <171443186101.1749944.9869151603554748357.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:21 -0600
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

On Fri, 19 Apr 2024 08:51:14 +0200, Wadim Egorov wrote:

> Migrate the boards I maintain to OF_UPSTREAM.
> 
> Wadim Egorov (3):
>   phycore-am62x: Migrate to OF_UPSTREAM
>   phycore-am64x: Migrate to OF_UPSTREAM
>   phycore-rk3288: Migrate to OF_UPSTREAM
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


