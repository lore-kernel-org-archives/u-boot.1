Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA86BEF06E3
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 17:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C85958366F;
	Sun,  8 Feb 2026 18:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pz8kMG3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03BF883AA7; Sun,  8 Feb 2026 18:46:09 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72948341A
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 18:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45c962424daso811900b6e.2
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 09:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770572765; x=1771177565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEvBosFB+vyInNzJfxSl+NtFKQ9KUsCGwOTLVJw8GHg=;
 b=pz8kMG3SBf8h9uI5KPLofLltXaWsrLE6ZVInnV9s47gNS9UUYxcT8X2qPQR8EV8Gui
 wRh1iCdNUzh4WZ1l+AuOwfcfXBXDAq5TVqiz783k64naW5EprP2qOPESITU77XaOkZT7
 HMqNVqgSYzX0sQ4oGhqjd8dIuIuAzNmAdhNg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770572765; x=1771177565;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xEvBosFB+vyInNzJfxSl+NtFKQ9KUsCGwOTLVJw8GHg=;
 b=EQFUhlZ7SgLODig1EJ2OJ348+F0myg1WfKsdjkyiHVYHp8XnfB6kv/fr+HdStWsTej
 JW87iAi5X0hZuNWTJ8eXC+L0durb7vQbcgMgl628/5thJEAFFBHfjIAn2kOX7k4Ch5nm
 P3we6ZEGI+w7rAHnxmFlE7Z0Tbsdw9XjAlqaiJ4zg0iD+YzRwoZAEps7IjksbadaYyfU
 zHWtJKLD/DtWJ/MUJSHorb3ssWGocwJz5m73uaIJSSEvF9Vxoum/g6KOiwv292uVNNaa
 DSRaFA4tBil5u2snh8DOyBJmKSmnxfeGcRVCHzLjzShUig/xM6gXSajlatW4GR+O+xga
 ZKnA==
X-Gm-Message-State: AOJu0YwtalwHWznqcOs4Aw6HkkA5Opngn9QwAnyn0J0mZSgki2SqZyNd
 3tltS660F3p6/bylQNPr/9Rq+MsxtYeG/0VxqpU4MgtxB2VRVTJfSevMdVkrDfzyMh42HdeAr6g
 MFjw8kS4=
X-Gm-Gg: AZuq6aJ3yJy4X8q7/3L+PVAHKxlGf9xI3zxhGwq8J5yy7/tGjujktAdgna8ZcZuYV8i
 uYO/CUnJF/0jB95tEHy0+VzZeVgYojva/VB6OGJHsSVEMsJaSe8LQ06BUE9xJ9MZs+kBZT73OiV
 MS/NbJ67SUPE08dc+IWFP+AxjeSP0FL5VwhkiIGvW7UrNzszZmOElEbsw/FI/RZEhDHMzOmHK/t
 5CJObwAMAV7fjHmKLMvxT+jzmSQEDiEsgir4Czac+MWsuKRkTpClkEdPtYvbC9hqpR10dcyVlPM
 C1M6U9/P/D81rbrNFY3gwIUvGBPh6dxOXgqnsfr9RdRR/xGaA2edIIMem3VFqIOhqhmljSuKf8w
 Fo6muY2dY1kghaETpbhyt17SJw2nzdjXSL5AQ5wjpF3v/YPRgYZVkQopJsPUPJvcNbWC/0bIzZG
 6xViNceR/aebL8k2Yks7qQ7HhJFi+OKY2cCgl7RFpXgJkj0eu8QnLSZIOj7pA1Q8atVImVZs70F
 BRPQmzzL+8odiUayidRwBD/FVlifalzkTGCBA==
X-Received: by 2002:a05:6808:1598:b0:45e:e8ee:192 with SMTP id
 5614622812f47-462fcb8abfdmr5049208b6e.56.1770572765575; 
 Sun, 08 Feb 2026 09:46:05 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462feb5455dsm5066058b6e.17.2026.02.08.09.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 09:46:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <ab0c56f2-0f5f-4c6d-9a7b-4abb74adeb1a@linaro.org>
References: <ab0c56f2-0f5f-4c6d-9a7b-4abb74adeb1a@linaro.org>
Subject: Re: [PULL] u-boot-at91-2026.04-a
Message-Id: <177057276422.533981.12351213358388902988.b4-ty@konsulko.com>
Date: Sun, 08 Feb 2026 11:46:04 -0600
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

On Sun, 08 Feb 2026 18:04:02 +0200, Eugen Hristev wrote:

> Please pull tag u-boot-at91-2026.04-a , the first set of at91
> features and fixes for the 2026.04 cycle.
> 
> This small fixes set includes fixing 64 bit builds and some warnings for
> the at91 serial driver, and some cleanup on the nand driver.
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


