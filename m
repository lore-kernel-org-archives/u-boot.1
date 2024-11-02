Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBEDE67819
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F29CB89117;
	Sun,  3 Nov 2024 00:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IXCCmViH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B082C892CF; Sun,  3 Nov 2024 00:25:24 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A896D88C86
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4609beb631aso23578951cf.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730589921; x=1731194721; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oT7cVJM2+aC6FV1zlY/XVgR0vL4f4Q0ku8tfZ4GTO94=;
 b=IXCCmViHhRiIBUfV0xFd83jXuLa79UYTKWf6IqT4hQCl2HDW/yrSPyVVX/JXGM/Ifu
 ECRRJzpz+dUJeBI7Co1RV68j5i9+cGWv7x3eXvbVAqgVyXT/n6VUY07uJoliV34olDwC
 lmVSB3YClAydTJAlhzeDebSCGep7SSazewtl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730589921; x=1731194721;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oT7cVJM2+aC6FV1zlY/XVgR0vL4f4Q0ku8tfZ4GTO94=;
 b=rPWmMY8HOg0LT4Ipxxr2dgN3hpbHxKCgaamHUYQTcMPrpoSHdz8UFXpQQ0HCR5KI8m
 ijym8PuSUUqn880tOHN7A28Xbff6JwePkFkDZ+hWVQrEpxEP8/Q+t93EFlrogdkJZY8B
 w2gfvXObxuINVbft4ldV40utWkP9mAnuz/zSI7xEK51nl8mrvKcbuXGIVtdPoGCYYWXC
 ojiXgf5f5/A3sXtmSvRDZntj9lyYVS7MEegyFpiYKAhkYOP1Gg1/ARIKCQuctIGgTkP7
 VH997Fe4041vSnICqserlv05jr/6x/uOxc1a5DmDrQV4/WIHDZflsN6jJgp8NYKELbVR
 QeYw==
X-Gm-Message-State: AOJu0YzVHAQ3wgcYXpER6sAu0xjCdqQYGW8oedZz5JCcQAYSrz59hC+3
 xTWgJq5Z6CEMxAUrMtxgpQ52JbbA7zFxVgU4yWKJUE2583RACFN0ruQVOUaonF4=
X-Google-Smtp-Source: AGHT+IFAj0wD27rhuTnSbfP1G2zrLWnZwiKMel4VjiqJNm2iMKib9rmnc7nF+UZC4dyAHzhon81j5g==
X-Received: by 2002:ac8:5dc9:0:b0:460:f34c:12b6 with SMTP id
 d75a77b69052e-462b8754809mr94178861cf.44.1730589921312; 
 Sat, 02 Nov 2024 16:25:21 -0700 (PDT)
Received: from [127.0.1.1] ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad19b4f5sm32412141cf.83.2024.11.02.16.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 16:25:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Padmarao Begari <padmarao.begari@amd.com>
Cc: git@amd.com, michal.simek@amd.com, love.kumar@amd.com
In-Reply-To: <20241029114709.3983243-1-padmarao.begari@amd.com>
References: <20241029114709.3983243-1-padmarao.begari@amd.com>
Subject: Re: [PATCH] test/py: spi: prevent overwriting relocation memory
Message-Id: <173058991932.1044919.13801993345623662950.b4-ty@konsulko.com>
Date: Sat, 02 Nov 2024 17:25:19 -0600
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

On Tue, 29 Oct 2024 17:17:09 +0530, Padmarao Begari wrote:

> Update spi negative test case to prevent SF command
> from overwriting relocation memory area.
> 
> 

Applied to local tree/v2-tidy-test-dir, thanks!

-- 
Tom


