Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6327C5B549
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 03:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4719822D7;
	Thu,  5 Jun 2025 05:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o8/9rXRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8AD80050; Thu,  5 Jun 2025 05:09:20 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25188004F
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 05:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40791b696a2so184234b6e.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749092956; x=1749697756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eGoiQNYaNYrOBI6RzIRYBdjQFx2Wt/TKtbXxZpYotU=;
 b=o8/9rXRktMg35js1/7rMGK1EUE/Fd0fgF2EqE6brOeOK9w709bxV5TFe5ccGa/T88K
 iX5AIlR0/0P8SBnwjay+286EyDuEhRpmOYGCoeNAsn5PplyoK2BClw0d5ppJf9gr0wqx
 IKCy+VLD0RUNOHOdM0aktjwZeHty6jmMULVCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749092956; x=1749697756;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eGoiQNYaNYrOBI6RzIRYBdjQFx2Wt/TKtbXxZpYotU=;
 b=L+JRzkkM860q3TuhrZB0ZEsw91wNR0W60OaVYH8nW1vdaNwvjrnrrnBpi5GUYwqmu8
 WoZJvH2UuWJ3ySr73J4iDl7w3HsEY4NugZyiH/tdQUuh2TPrA6UNGPZsGWP37cgMxG66
 spxoMPyJDzClHyXwLZqlCSs7P1WDa/ljxHuqo+sQX0KRKx4Wa517Ao6oOPA9pZPiue1r
 GW7fnhK2XlnY6AOcROCUkWOMEphQirAq/q/JsiZ7ef5d+aPKkc1wdhj8WXyoanr7gIZh
 f9U6F7UHrBWlxf7v9LcXxN8hXpo8TMe7ZWbNu1HfYS6J0ZHfV0vGztPAtuWbhItmkNXm
 lEgg==
X-Gm-Message-State: AOJu0Yw/WE/dYMJkvoDlDGh54bwXjB6NBH9MTPErqKzYFh1X5JYpcJyz
 uUHEEXhLIVqYGZVEt9KmNY+J+au++Hr9tgTSx9lJaL5q412zSCUlFt0Rl37YnDpX9DEk959d1kG
 YnnZOQ3g=
X-Gm-Gg: ASbGncskLzbDsQtH0PSDKml8RqdvU7KIR0fYz+zVSBvbX02LoDQ/0FRRZB9AYzkZcyu
 GDYzxeEfcl6mHvJJxrdi8/LM9PBpp8uDlNh/BC5nYsEYTWWCg4/VVtf5M5twOjQT/Jh77SCLRys
 mdGLUJbi5gfXZO/h1QPU/iQ9ceTV+FRSm+Ok3CbcoFiGD0+n3vSFVzjmsjvkOOYQUWsxekk6Bx5
 kE7h+vJ9F7WqH5MlfjLdwmllTZZWVutVfuSH0+MrBhx65nMbTY/kQeBblxseNh369cpvYARSdAQ
 5nTq6/Y1mPkvyVhtet70gnLqTUJ51zD3sUgKQSh7nZ0azzKc+Wnjvxu+ruaWaobZSwsufVlFbbc
 B0MgpPoKV8WR1bKziuXCtuw==
X-Google-Smtp-Source: AGHT+IFbDnce4T5KEFCmlZSG+c1qB7pbQbFJbK1ex75B484/Ik2Btt5reQPWawYaTL1PygxQV90BSw==
X-Received: by 2002:a05:6808:3718:b0:407:ab7a:66d1 with SMTP id
 5614622812f47-408f0fb7fbcmr3051862b6e.28.1749092956464; 
 Wed, 04 Jun 2025 20:09:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c70b2esm2518069eaf.13.2025.06.04.20.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 20:09:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250522123305.23302-1-anshuld@ti.com>
References: <20250522123305.23302-1-anshuld@ti.com>
Subject: Re: [PATCH v1] mach-k3: am62ax: enable caches for the SPL stage
Message-Id: <174909295539.1989110.16772543331305441244.b4-ty@konsulko.com>
Date: Wed, 04 Jun 2025 21:09:15 -0600
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

On Thu, 22 May 2025 18:03:04 +0530, Anshul Dalal wrote:

> board_init_f for the am62a is missing the call to spl_enable_cache which
> exists for all other am62 platforms (check am625_init.c &
> am62p5_init.c).
> 
> This allows the usage of caches while loading and parsing the u-boot.img
> FIT resulting in ~2x speedup in the A53 SPL stage.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mach-k3: am62ax: enable caches for the SPL stage
      commit: 27cd65ca1bf16c21818c233c6d658f3e747f5e85
-- 
Tom


