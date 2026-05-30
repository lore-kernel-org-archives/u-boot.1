Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491B7CD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37875846A5;
	Sat, 30 May 2026 20:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qi+NpXle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663E88405A; Sat, 30 May 2026 20:36:59 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507448405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6b5c374e5so43617a34.0
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166216; x=1780771016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YjfdClR63sVRYJ5sHhK6XaJQsAVMWgMkInbeOYTvm6E=;
 b=Qi+NpXle8dpeEPv7IGGnSXaeekX4xT1hZZ7QU7o/QSKLLKsvvgU7Nlqd4dvLTof/N/
 9Zu33E2O8VIwq0FC68S6UK2gW/EfK66/ncEO5EfzUITZ1LQEiEBnPGr3qIrGMdMAgiI6
 Wr09g5wRsIujmzOorWl0s1wj/rU36PngCaikw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166216; x=1780771016;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YjfdClR63sVRYJ5sHhK6XaJQsAVMWgMkInbeOYTvm6E=;
 b=rilzxl8ydRnhn4yuQEGSDxgmWXCDaRCEO6Hba1Rfx/1A6ocmO6GYGjGKTwq0ypFu6K
 Z8tB6F0Bqi0TWrspEmf46DhnqX0m93JX3XIzuxGX+pfanBPDsBdtjk33wZVHZolty86k
 YnPtlLdcHhmcOpM0g29OKjjjfnq3140ZssEKZYKbA1gm7zIk2h3tw2g+1grqz+0K2euj
 MBCbyVXE1c/nGZs+pWkEC5x7S8NIyR4VYVnXDGyIW2G95NzXN8dt/jCr1IlLOIgEidNu
 qAQzFt5AQexeVT9nBCDOrEy3NEBaz14w4TSoLZ3IObCtII1xZrG/KrkZhOoYaVVe/ZQ0
 dqpA==
X-Gm-Message-State: AOJu0YwVancbQ7Qi26y9asp64zz5wZd15WcX6vk5cO08oA4Ri6rSx4lV
 aQdDGv6tnGwkJ271HNypSGTUhhC7xiOGvZWdnMoP74GfrFQ6i8kHwnFQ9o7aihShZJ4=
X-Gm-Gg: Acq92OE+H/3aSRHgwKrGpnfwKk8zMRSm8/yDe4X/D84EuGee5sINiJWDk4YInT/Xv4r
 KPF+KicQM/FMalrN0F+EuAIQPAEhcLqdk5tFBhmM48UHOKahIDDCNVsVdEdL3cA5oVy4wfbDcYJ
 N/EsUn1bvZRAsUjGz3UtIcm1Ei3hFgmeRvku/sIhdBE6zG3FVfc8GbG6qBot/urCDX8hT2MHnxZ
 vint0m6PIftDmVAmZnJgh3cXwiKdg1EHUgsf+0FDUCe7YFKqHhPwblHziNjofEvDJYAdrvr6I8s
 a9ptO914Lb+AGf4CeIIbjLE3ChlE1KnUKdfapy4muMhkGV9Kmqtu7dTq9rYTyIYUM9U2XRFpDeQ
 2+xWEYf0gW3qZ+kp3lyvdudFxQ/KESAPY09qpYDn6/ntJCK6g/+eVHzGXmhitG7klCLfWJt7JA/
 0E6rf3BuOHMsI4/H36RZweLHFWJhi2x0yqFJeEW0JdNQYeJJOyvo1nd2rhtC2uEM9pLr2aJ+ZoK
 wTM3Pa5T2oykiAFQ+FsXgGXeBLC5pKn8teDa9TVggFqFk9Pfpd6RP4=
X-Received: by 2002:a05:6830:1514:b0:7d9:ade1:e19b with SMTP id
 46e09a7af769-7e695214781mr2701862a34.14.1780166216127; 
 Sat, 30 May 2026 11:36:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:36:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
In-Reply-To: <20260312-fix_splash_error_message-v1-1-50fb62f972bc@ti.com>
References: <20260312-fix_splash_error_message-v1-1-50fb62f972bc@ti.com>
Subject: Re: [PATCH] common: splash_source: fix cryptic error messages
Message-Id: <178016621538.1038765.843361899788235413.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:36:55 -0600
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

On Thu, 12 Mar 2026 10:30:12 +0530, Anshul Dalal wrote:

> Some error messages emitted while loading the splash image are too
> cryptic and don't provide any insights into the failure being a splash
> related issue, such as 'Error (-2): cannot determine file size' etc.
> 
> This patch fixes the error codes by adding the function name to the
> error print.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] common: splash_source: fix cryptic error messages
      commit: 3c32572a27df779578e2d6f9a07dd17fe31dc2e2
-- 
Tom


