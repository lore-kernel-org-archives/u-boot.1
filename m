Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7706DC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD99683559;
	Wed,  9 Jul 2025 16:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cCsZG+KX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B94835A5; Wed,  9 Jul 2025 16:22:08 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A14683559
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-610cbca60cdso3811336eaf.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070925; x=1752675725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GBp1JUsmwkXo/irLmcpTmzaq87SsekCCZlRzsKtOAKY=;
 b=cCsZG+KXTVA6a+gyNUmUlu1evtbnPyN87xEBuoXiURBTzDNIUY0XlZ/YcVJF7tPHRG
 fkoGU0WVSHyl6CuyHNIIGjy0dk/R1juHs0EgX6T23C9rZLxGkz1lSU4j7G5lOCHgIgpG
 xbxs44GzD/vGacPoQ43zn78asGz3g3TMM80pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070925; x=1752675725;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBp1JUsmwkXo/irLmcpTmzaq87SsekCCZlRzsKtOAKY=;
 b=eepvQo+Cs5NbZgAzdpPilI2ELhU8pq0Cr3pwafwTDbkMoQEIwkpSlu+YKlaM5BNQgq
 JDSr6QDSmDsm9GNqbVZhrZ7rVlOmjS61qJJS8ZHsSyDnGYgd5bRRASJ2qOBKLbXCGkZa
 efrKzHLaUwCuoDUEPvwo8X/ztEnFGW3cDXajrgPC/wuRA7nQjZZ1aYQOtYLuq4CnDhkV
 F8pZXOMXjLQXtladv9BjppZ0x7O1dMWqvDqEcxqLIgEm8PNTrb1IgiqPHqCIKv4Xvk3+
 Giwfpst1OBjAokSbYb+6wZMAvUQJQjJi+58KF/hcajerUNzZc1JkHqgP3ofe55E/5Bgg
 4L4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDJ7mdhgpKt73vZu11Ve39neCxPGYnbEe/ip///fxzfaK/zDtihoUqWVSmd5+zDonW+gcom/c=@lists.denx.de
X-Gm-Message-State: AOJu0YxdrbavH28t3vUfXTDY0KQCdQK4+bkaL5JHwLXQCitao/AJoG10
 vZdYLoCyqqEM2q1Ozthqc16cYdGWXQAD4vVa6mAq3Y2CW3KTK6hZ7zWzEqud9xqLoyQ7amCPO0t
 PIpJ2Z5E=
X-Gm-Gg: ASbGnctsfX0n2zQqVIYbAgIwrl8MRNG6nCJwgJiQp2ohNGjnOhq7ggMkPmTlSipHBD3
 GAS/yKrGHSnExPQhklxJaJBAtJTb/qxjHfZuW4gSZIM/7e3xQHjzEqYl43vzqYHLWydjhq59oS0
 GiMYVrglE/fShulFxEJvNlhVAAgek2Kp8pM7X4YjO3yH8bOC+S0+urHPYciSEDF2BZmVzFwRkbo
 tqMVxbyhzj+pfHxl9ZfSu2RCU2jwKb28YkoEzMo2OhFhIS5pAVlTsVm6Dd6QNULoP4NacXINucf
 tUdHtcIjDvUIWZSKIGKcuiLgRuqYuNdm/Om0geAI8fzXZG8YQo9SvxVL0nwsNuyjqfd2tgMHjzr
 8M0l6QbrtpuVK9IiD7q8=
X-Google-Smtp-Source: AGHT+IG9ZB2cjrB5cz9wumYN/IYw8ktyYOEZhn3561J7by8tWHLrGOOh+ut80IQTxaLhe/oEleiH2g==
X-Received: by 2002:a05:6808:10c9:b0:3fc:7e1:a455 with SMTP id
 5614622812f47-412ba280279mr2178765b6e.2.1752070925087; 
 Wed, 09 Jul 2025 07:22:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:22:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250629132122.24389-1-ansuelsmth@gmail.com>
References: <20250629132122.24389-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] env: Fix possible out-of-bound access in
 env_do_env_set
Message-Id: <175207092418.1813324.12453392080896998105.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:22:04 -0600
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

On Sun, 29 Jun 2025 15:21:18 +0200, Christian Marangi wrote:

> It was discovered that env_do_env_set() currently suffer from a long
> time of a possible out-of-bound access for the argv array handling.
> 
> The BUG is present in the function env_do_env_set() line:
> 
> name = argv[1];
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] env: Fix possible out-of-bound access in env_do_env_set
      commit: 0ffd456516b5f0c126c9705d6b2368a45ee2353f
-- 
Tom


