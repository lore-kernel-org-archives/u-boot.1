Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54012C54743
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E062488AAA;
	Wed, 28 Aug 2024 01:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PRjqbFg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B40B188A7B; Wed, 28 Aug 2024 01:22:52 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970AB88AA8
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e05f25fb96eso6061331276.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724800969; x=1725405769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fF4FUmvZ8QGEW1Am/dh6s0FCMT6bLn8tnnfkitiow84=;
 b=PRjqbFg05lJ0dSiFpBdNZNpk4+DoaqPj2X6K/6iBi+iS8RC8fPyzbbG+F5Lvunv8Oh
 YmFXfC3PqOjahj9OuCdMnFthHd9hZStM1PWlqRT+gC0o+kXreR6fJazyfhkbyKgX3ByT
 6m3fwlZ8v6V/iLSF3olS0vBQp54CY6vusxJ7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800969; x=1725405769;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fF4FUmvZ8QGEW1Am/dh6s0FCMT6bLn8tnnfkitiow84=;
 b=F+uSmT2yxFcvGMQ+imzouaAh9JBeKvLhEO+z35YPG9yKdPc9lolAEutSBD/P2YEEIX
 8dQciio9lR6s7LN/NwEWmkU7I5CLJl/HswlTDo5U2yWAX1EUZ6fqvCqtD2rhZXZBMOtz
 DC3o4jGPUceRseYIop4kYfkVkZH6J9C0KQwstJHelU2MYXU6iP6KeQ2NKYAm3Cmsgm62
 yhExwtArYfw8LVz9zlrMAw13ZkQ0I8ia5JcQ7y9achPQE8RxyTjby30Q5cHRx8CkFkAo
 m/ecRRCaE55iAqlGUS4MOEN87hGjob3L3/1ZihjkTyJPlh0wAtz7P03mnbBZGlbY0oST
 Toug==
X-Gm-Message-State: AOJu0Yx2jXSH6pqwVaUL3gx1yIMic+7T3I6XVaYJ8ezoqBVjzWi9HUwi
 NNJoIklmm322kQPO5AlNp8m1A6TKXjZ/WjXMLA9Z16BRmLDdZ5UFsWm4ohsjt64=
X-Google-Smtp-Source: AGHT+IGPkuM7dDJjodyl0qhmN28k1u/ySHvuw9hm6TtN3RtRkd/kuYbdP/gySfZV9xny3q1S+fWNoA==
X-Received: by 2002:a05:6902:70d:b0:e13:d834:604f with SMTP id
 3f1490d57ef6-e17a8c4536cmr16723539276.50.1724800969278; 
 Tue, 27 Aug 2024 16:22:49 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d494d5sm60486716d6.32.2024.08.27.16.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:22:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240802092820.917450-3-admin@hifiphile.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
 <20240802092820.917450-3-admin@hifiphile.com>
Subject: Re: [PATCH] cmd: bind: Use device sequence instead for driver
 bind/unbind
Message-Id: <172480096794.2972894.11938596044150243804.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 17:22:47 -0600
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

On Fri, 02 Aug 2024 11:28:13 +0200, Zixun LI wrote:

> Currently uclass index is used for bind/unbind which ignores alias
> sequence numbering. Use device sequence number instead as it's
> the number explicitly set in the DT.
> 
> Also update documentation to use sequence number.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


