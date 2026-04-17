Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFDFF436B4
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36E684312;
	Fri, 17 Apr 2026 17:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AF7RST3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AED7842C7; Fri, 17 Apr 2026 17:52:37 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D66839D9
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4233e152457so678095fac.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441154; x=1777045954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c4U2iu0U4iU3OrWt6FrciFgeB5R/V8+jPvjHwq6/p20=;
 b=AF7RST3gPTBwCh5q3JFdmknRPUhBxZXHPk5bzZRxQA9qFCVuUc9aTYMYebvqYPHS7U
 5b5fCn4UFq2KYadVrDuFO5FugTdIPXQcgYaRHUPypbq+MDfu95ZK8XRF5MgsuRO5pAPl
 KTHxf3znKLAuhM6vU3Bv1v9c9Eyti9AtpXT+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441154; x=1777045954;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c4U2iu0U4iU3OrWt6FrciFgeB5R/V8+jPvjHwq6/p20=;
 b=eMTzpJAWv/tpmMmD0ZJlWLnDLcTOQnBecl8dYb7sGOCQnYHFluzbls78D6SLaaUBQQ
 +eLyfoJGHSDBG7Hpg3vvT6nHyy7yx0jJX+Cwfyst2NIQzTdWIsDxy/aWWTMfpjDp5LYT
 l876oISYFdwGJhTObZPFOwAK/XAHiZRJXK61OJn4Ipggps0pzFgPjGUhVKoO9B95DORD
 7nPsZChmtQkzNSQDfG1oLt7e8v9r+evqzVDJnRBMrsSrkVF9gUaVm/le+urRIcOhV4WA
 mDQi037F46VE9TalpCmbv62QKV4Abfge6W7e16OE46ucHYwlJKTYq3nJYbGp8/SB4Sm0
 QNag==
X-Gm-Message-State: AOJu0Yxg2onO19VQ4xaXpy4zON1pmNi9xKLqar/Itqla6qRsILw+FMGX
 H7op2yH+w/g8Vv0W7/T1APawQhVw02McRo6IQqYW8n61yI5ntOaL4uk/N9ovnSEn8L8l18WOCNX
 e0sgywrgaYw==
X-Gm-Gg: AeBDieslWXq72+VoroeucQ38KPjG9QgKz8xIG5oPq6kMbeKnzO8fcB+jzmIospYu0SN
 toYnCcQYPw2059XxKnhD3dj82DMiXyYgINQuCw95GwVdE92yF3FiOZuZ3zMMRy7sCeZdVCiAKp2
 XO1mSxkW3xi9oZ7H5KLjyjj+xHnWkPmLJgXaP1VJCevuprIdjDId0FxgfMaoTMi529kT3moGHRw
 js/RPt95C61TYJZ5s+roae5Un/Hmuiu/Q6pmg8ooVgCG7zx6lznMT48KlfQ/CStHl89bx0tQtp8
 ERHnKr6CTRTaAsq+h9kEpdHvE2IOrGgXDn1miWXtjzucOAvJo4RoR5xKxMcJpuocKrPsTNRWAm2
 hcEM29Z5S5ZHszkCLin8nNpFl0MGd6AryJ9OE2yikjZz3dYTtTQghWZ1GhlSNHo3+l4FApHfwuB
 nCqhdikBKv+nmmCXjUfZAzZME4EG9mOgmTn87IljB8PKcWMf046VsfYlBs14Rggzd9S4vu7dvgW
 TFIHhlQ2eeCYwesx2Cu45ZZJMcXOlbvxPZsmZZlue9/TOh+FZz2By7+uPnd
X-Received: by 2002:a05:6870:ebc9:b0:417:43d7:bb9f with SMTP id
 586e51a60fabf-42aded94ab1mr1870472fac.34.1776441153758; 
 Fri, 17 Apr 2026 08:52:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195259.2363546-1-trini@konsulko.com>
References: <20260323195259.2363546-1-trini@konsulko.com>
Subject: Re: [PATCH] spi: Correct dependencies for SPI_FLASH_SST
Message-Id: <177644115302.690930.7080005340490011312.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:33 -0600
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

On Mon, 23 Mar 2026 13:52:59 -0600, Tom Rini wrote:

> The SPI_FLASH_SST functionality is a subset of SPI_FLASH_LOCK today, so
> express this dependency in Kconfig.
> 
> 

Applied to u-boot/master, thanks!

[1/1] spi: Correct dependencies for SPI_FLASH_SST
      commit: 301d2d32738a59c3fa9416bee303576146cd7060
-- 
Tom


