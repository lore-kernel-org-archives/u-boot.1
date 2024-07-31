Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A01EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 19:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C4388A74;
	Wed, 31 Jul 2024 21:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PfXMC4AB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4420D88A83; Wed, 31 Jul 2024 21:38:48 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4452088A4C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 21:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3db16b2c1d2so4376410b6e.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722454724; x=1723059524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8eN7MJoh3z579VAP7KIFxbvXr7NMJtatJ2/Cd9dWuI=;
 b=PfXMC4ABIZrLVAPYkByIe8OYGaq2/MCbnTU/ZCJUvzZcWJqm6oWuKKZxv5R3oOL5ro
 /PUs2ftn1HldBbhtaG9dsDWy94A1hTVva4UHkE4gRaIM12ZWB9vOXBkctZJ5hGErIRp9
 Oa/C5NcY7Tf3QhRo7KiSekCGw3PtKMszWwCCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722454724; x=1723059524;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8eN7MJoh3z579VAP7KIFxbvXr7NMJtatJ2/Cd9dWuI=;
 b=Io7WeXiyje/7kCPuErPxkhx5SjvK9v+t8RgxxCI4NnEuvZP7ecbLb8kmR6U3hEZsMI
 Rkp1QIOroyGxtBdu5pGg21T/rmxsvmvhW1TzhHEI8jgJ2ZuEWoREQqIwgR63zdkuZa63
 aWqGWKjZLrCxrPcvozlOZwbiX2nTM4CDCliCcuCY3A2oEcboezWKTIIjaGm7dZpU06dh
 lvcaK84PQM359NHphOdbuCg1nxbJ4SWbVrD1hMqAbZw2Lqm9lNw3GcYaCZ86ZDSZOiKw
 aWmrWjE0ph0rBvjdNv2VRzQTc1+Mno0wQ2XIjWnTmywDB8hBGowJlwlGFMPbSc51h9V4
 YxNg==
X-Gm-Message-State: AOJu0YwENywK7U2K6QvM0gdY+l8xipq1h7hNT0puusrOnzfWgYH8L4zG
 4U6BBJrG69uVcoux92dbI/vWX7X5iZEM89c8tu8p3nVnMPVyVBr1Z856MpOiXH8lY74t+Si+rDT
 vEiA=
X-Google-Smtp-Source: AGHT+IHmLUMHcPyhO1Is+iDdoCXNitqqaTCL/YR0NlXNiRiUf5lU6R0CgTyJTnOWWz+O+n3Zn0DTug==
X-Received: by 2002:a05:6808:13d1:b0:3da:e2a2:75b1 with SMTP id
 5614622812f47-3db511e54f5mr119052b6e.13.1722454724017; 
 Wed, 31 Jul 2024 12:38:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db41806da0sm817377b6e.31.2024.07.31.12.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 12:38:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240719-fix-mmc-env-boot1-v1-1-e32b2037d4d8@baylibre.com>
References: <20240719-fix-mmc-env-boot1-v1-1-e32b2037d4d8@baylibre.com>
Subject: Re: [PATCH] env: mmc: Fix env loading with CONFIG_SYS_MMC_ENV_PART
Message-Id: <172245472314.3951333.4124498817331415872.b4-ty@konsulko.com>
Date: Wed, 31 Jul 2024 13:38:43 -0600
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

On Fri, 19 Jul 2024 17:38:54 +0200, Mattijs Korpershoek wrote:

> When CONFIG_SYS_MMC_ENV_PART=2, the environment is loaded from
> the USER partition (hwpart=0) instead of from the
> BOOT1 partition (hwpart=2).
> 
> IS_ENABLED() cannot be used for non-boolean KConfig options.
> Its documentation states:
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


