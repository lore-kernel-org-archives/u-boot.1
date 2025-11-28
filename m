Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2AFCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB1283A36;
	Fri, 28 Nov 2025 17:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BMLUr42h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3E783A9F; Fri, 28 Nov 2025 17:25:41 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A2783A7A
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-44fff8c46bbso514087b6e.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764347137; x=1764951937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BGSC8GPMva0ajzyFjYANbBzS+ZxxVm1EKlHS+8A0nr0=;
 b=BMLUr42h40p3tTPuUIgohFob1up19Km8dzEWaJxPndA9WTTRplYBPxzRrYw7RuVv59
 I3mv4I1ccS568TBg8zb0TxeEKs+H71472K5B7/8G0xAvUXZUN/tZA3eoYYQXMluznvqn
 J1FSu8YRu1HuhxDCmOP5NwKH3GOQ8LXOvm5b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764347137; x=1764951937;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BGSC8GPMva0ajzyFjYANbBzS+ZxxVm1EKlHS+8A0nr0=;
 b=idXtNMF5ukzfLn5rKsiZje8El4UAxKci8a7LOPXgY/TOpngqDWtTOyn9IVc0Qfud59
 ibYciUpSM29Sw56LsGbPE6jWrKJLOxe2leN8K21zFQ8mSGzHJRQoCHJilg/8j3/KZn3f
 OjRupO8NoZAz5LBif31cJ9XLh4tRir8zmzMoGAI7u9PsTSNyNP6kTdqI8NVZ62scLPDE
 hxjkNrDah7tQGUgQ+YNBnTyzcMYMdD0hNsOmlrrUIZ2Z+Tfkl4tTeUOMPfYbV4n3Jp2+
 +TXHtVUewaEecTyYbE65602aypuUI0Jr7ia4DaD4YHANipMcgSWWatpK9g0luTdrDu+q
 SOmA==
X-Gm-Message-State: AOJu0Yz1+ew7OvcyyLoRRKtpdp/RHFwN9Ob6bFnraGbpzytBuuC4z6Uh
 gQQM3ILCxXtNSyXouepZ4yz/GfhIgW6qrA06OV8tP/TpOptdjoB9p7uVzOOqDpyOoTS1yRUWB5h
 VTJ8fHqk=
X-Gm-Gg: ASbGnctTwLrK4WzMbWuUXxAT73C2AkEK/woPzfqh8mIvp1IXxcySqcR4dahcN+Mo63p
 25uttS9FzgiCE6AyckLywS0oG/0f0XuUtOltQEWWxGb9XPNYwFWHKijbHiSzx6chjrd9ljq3BFx
 LbsvJc1Vyq4Nz8UXBTopPoM6oA/mk7vadf/T2H7g8aQ0qc8lTXrkV7y0DtHaHXFPJvGDk6jzI1x
 o6SQ340Oobk0MYnAW6sm58mv6KmuuXXlKpsBSQc3KGCg6kUy9b6LO+p0Hvy4vD1wYB1oL5TZ/iE
 /+oAIxVEHc4BIn19TwRiEEiZrOhtezVJB6ppO7Y4FMonqgXctItY98GT17kz+imJy7tRmjMVDPb
 e8i1kubWMRIzUKsQRWaeWc8El+Vko74Sl455Zhb7PNvcFlLt+pjbmOAf0yEOyORUAjIESdBDJgT
 aCvGBls23TgTP4g+z/j7USK7eNlWKjnSJQ3bgA2SUXN2HaVOT0
X-Google-Smtp-Source: AGHT+IFyzyzWfNvtJluXaSdegj63VtG3U0tzcGrsKrzHuwOzufChJkDq8VbsIhEx8fDmz/Kddf/ikw==
X-Received: by 2002:a05:6808:1310:b0:450:7169:80e5 with SMTP id
 5614622812f47-45112aa801cmr10543074b6e.27.1764347137585; 
 Fri, 28 Nov 2025 08:25:37 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dc9ff3f3sm1973682fac.2.2025.11.28.08.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:25:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251118184618.599462-1-trini@konsulko.com>
References: <20251118184618.599462-1-trini@konsulko.com>
Subject: Re: [PATCH v2] labgrid: sage: Add new lab
Message-Id: <176434713697.219281.8109620372952570248.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 10:25:36 -0600
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

On Tue, 18 Nov 2025 12:46:18 -0600, Tom Rini wrote:

> This adds support for the "sage" lab, that is utilizing stock labgrid to
> control a Raspberry Pi 3, a Raspberry Pi 4, a Pine64 Plus and a SolidRun
> Hummingboard 2. The board environment files enable additional tests by
> pointing to content which is any of:
> - Copy/pasted from the documentation for a test.
> - Obvious in its source (e.g. Linux Kernel or GRUB).
> - Random content (1MiBtest.bin was created with dd from /dev/urandom).
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] labgrid: sage: Add new lab
      commit: 6c5be1a225361926f04fd630c136eeea8fa1a9a5
-- 
Tom


