Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3C3E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 20:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8384C803DF;
	Wed,  1 Jan 2025 21:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QBbT8EYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3220880379; Wed,  1 Jan 2025 21:41:43 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CFD800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 21:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6dd049b5428so91395716d6.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 12:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735764100; x=1736368900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFyrGnqtMAkOph6ZgJG6UmbaDgzsabOYlA1eBfv4eTg=;
 b=QBbT8EYjj9mzNYz+e0JAAdoEuRgzP96gY2/KDAsje+Xmc5dgHkVKmeHoP1ah3+m4wD
 v1vWJH05lecc4C5j/XPk3yqgWeZDYC4QjWgv4T8t80ATakCXNoqS8WI5SkP7OANJDRKg
 Nh9ZrTmJZgRAyE3+muI7J3Sm2OPUDX/UhRL4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735764100; x=1736368900;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFyrGnqtMAkOph6ZgJG6UmbaDgzsabOYlA1eBfv4eTg=;
 b=G6IDcvXLLrAOiSOdLc7NYJgqeBYbjFina3Z/4tysyu5+dWvRUgbUm7eNyxuhr2tCtk
 SDB0SYeNjgfhUKXODSuC5+o6UfurjnSQoZwrYsdfjEPxWNwRROByIckybsBjSO9S3o1X
 wG4xdjOzI2ws+eZ9YweQjDWI4+MxGQyooNZf+yY+eBZiqDKdO+Y4Z4mIItu3ZpG+8STg
 UxbPXaHY1X+aaNtuQbqOgcSCJxjUlf11LUoQ3q2Tw36AaJHdgNWkPaFm0eLYY84uOrs9
 pEkbpgS+k34q3EV/fiEvt/4fflup/W52+8mdgIJywX7sa/DH9AX1B+Ym+cQc6iO4us7H
 LvJQ==
X-Gm-Message-State: AOJu0YzRfENZeGaaf629TqtF9RRpoOZPEwMUJB3emkUYkNLw1I7ZHpqz
 urECPk0XejslQEApICfwwtct2+WQkcL+KPrZwMJJpLz1VPEAdl0vbuWmf+M4JRXVpNKJunsHCMr
 Jgdk=
X-Gm-Gg: ASbGncuvtLXNLStJPjrtf0hyi+hxG99nlBxojFgoTqtQ+Xmws9Yq95xLjHr3w6jVwOa
 WaKh8xw3sr96pcH4TAbMzFeM9Vgnfl8mxE8383Gguh4GgUv3dLQdV0RPl6koPZ9UzlSlvI0Owgr
 +t7vWzvN13Dbm5+2zeUcmrX0f4k32bPrKu4WQuySiD9qXXSWpfa1bSR/e1kbKvlQ2XYOoHftqcF
 i7hnOHB7Hur2dvbuAPZWwk34jf5J4kNaOYqG5J8Maz7v5ynPUrXl2y3
X-Google-Smtp-Source: AGHT+IHjWfoO681Yckr5PTVMf4rBYl/jHiQvL8DTTlGBQF/JBmnGw3YN2qJ1WjtjkCWEm7EyGr96GQ==
X-Received: by 2002:a05:6214:242b:b0:6d4:180e:e7a with SMTP id
 6a1803df08f44-6dd2334b781mr729826836d6.24.1735764099952; 
 Wed, 01 Jan 2025 12:41:39 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182070ecsm124054636d6.124.2025.01.01.12.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 12:41:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Markus Gothe <markus.gothe@genexis.eu>
In-Reply-To: <20241119142644.736942-1-trini@konsulko.com>
References: <20241119142644.736942-1-trini@konsulko.com>
Subject: Re: [PATCH] Bitbanging MDIO driver for DM framework.
Message-Id: <173576409881.1694690.12290336832917473387.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 14:41:38 -0600
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

On Tue, 19 Nov 2024 08:26:44 -0600, Tom Rini wrote:

> Linux DTS compatible MDIO bitbanging driver.
> Both clause 22 and clause 45 MDIO supported and validated.
> 
> Heavily based on the Linux drivers (more or less the same code base).
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


