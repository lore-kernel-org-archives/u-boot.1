Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC27C3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 13:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6A682075;
	Thu,  3 Apr 2025 15:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LEyW8Dud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FD682054; Thu,  3 Apr 2025 15:30:06 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43D582075
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 15:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fe83c8cbdbso275964b6e.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743687000; x=1744291800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W5Zbrr7HU0FNIyWgL3tqjC2fissXpGFZ8O0Sxk2OyMs=;
 b=LEyW8DudGhzGs1ghyxAUSFOzHKZg/FTCXWmtvIBC0eRqEVpqvJQ0uc7nOuR2tM0lmz
 D+LGPdfeoV3m9UCTHxGDEXftDNA3BtvEb365/w3E+eyhPyLppfzTBcofx/gxo0Eo1QWB
 TZH7zliR26DCqVlzLqjnF3IlPzXlr90lN7jXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743687000; x=1744291800;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5Zbrr7HU0FNIyWgL3tqjC2fissXpGFZ8O0Sxk2OyMs=;
 b=dc7KQ+Lrp+zsu6L9ARcwG6BWdwjpzCQr9GfS2a642U8B70YmZAIvW5HwW3OjWUbYav
 jzb77Pr2HdVSMh73SgU0sZFNipgg2SABe279XHuSKTJdSuqPtPX8370hrBWAKf0XCrTw
 w96RtUSeV68GSe7oJugAYENLAYB6RB+7ePQVANlhVNYtBXbkpjHo64zpaIX7sepO0YwT
 EWChaTBjD6b+ZfMUb5FJ7gysM1IWk0CmE//5wzARpQRlkDpKkWMxMwnMOihPWvrH591B
 BWIcY812+RPPVqP7zDviy62JEfEcgAStrzDiLvzK8nCjGYEns6qPXZapmZ097cizWmBt
 cHBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzG8m0GoFAXeqcGca/vMKmefcLq5M4FhW4ks+UG9HGFWnJj217qw5bxHRAmImJFgq53lIXkOs=@lists.denx.de
X-Gm-Message-State: AOJu0YwJFJkzH/4sfJZ2gD8oS9YBTr9gpLyM98kudbDu3qWkdgn0QhU7
 YQjTWaj4oze5JUV/Kp6PxyFrS1t5owwnmyoS8UOyB8TuuAG3tv8jWEzZX37svZfZwmF58sqrfBk
 D
X-Gm-Gg: ASbGncudhSnbmnBl1LKLtD3iTm2GyM0PYPnvrX9J1Pw8ofATRqajRCYof9Uhdbbkeuj
 yOUPT60KtmF8Yh7SVxJ+TjEpGFBf+cNOLm07oaBvaxXO5Bnx+Mr8ZF2pe6DTOen+SwqGlePNOWM
 FWUeMnYLFeF0X97sFu3C7f+TH4LSmXjH6GOyqh6lwTq3qiUGGwqH/Zel/bfLU3gFgK57YIU+4V+
 S3rdhuLVsXSVsW5tao2BZpyGgZ0uEbsmDAWDGaNcJuHb49FGGenIR3xS8P03wIL4tesShXnTQ1m
 Ok2aJZbGl7MI4CaZkOaG7eEKCWt5t7Ax31pnI3AGTdvDw174GgB0Xo1roO9RVO83Go/TvX5YCUx
 NWClw
X-Google-Smtp-Source: AGHT+IH9GpR0YX3cl+yHU8mQf1NIXLH72HFsL4A76CkjE+mArh3pez9afvlQYYaHSg9ae/vk8Mjndg==
X-Received: by 2002:a05:6808:2188:b0:3f8:498c:9ef7 with SMTP id
 5614622812f47-4003ea0ab9cmr1354667b6e.24.1743687000682; 
 Thu, 03 Apr 2025 06:30:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc8454682fsm251260fac.5.2025.04.03.06.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 06:29:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20250316150002.1913162-1-pbrobinson@gmail.com>
References: <20250316150002.1913162-1-pbrobinson@gmail.com>
Subject: Re: [PATCH v2] arm64: Add MIDR entries for Cortex-A55, A73 and A75
Message-Id: <174368699941.1441234.5157865710811066608.b4-ty@konsulko.com>
Date: Thu, 03 Apr 2025 07:29:59 -0600
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

On Sun, 16 Mar 2025 14:59:52 +0000, Peter Robinson wrote:

> Add MIDR entries for Cortex-A55, Cortex-A73 and
> Cortex-A75 cores and update the is_coretex_a entries.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm64: Add MIDR entries for Cortex-A55, A73 and A75
      commit: f59fb9846c5a1d129f78b2945a094477388fd346
-- 
Tom


