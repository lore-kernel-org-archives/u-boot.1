Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4598BCCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 16:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B818283C0E;
	Thu,  6 Nov 2025 17:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DYDN+bIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7635F83C08; Thu,  6 Nov 2025 17:59:49 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E36C83B9B
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c2816c0495so707503a34.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 08:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762448386; x=1763053186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FPOXy54L0g+kMJHN6r2KlwP9D9KXMYuPNV9N87TbLU=;
 b=DYDN+bIQCV6Ruj1UuCPZ9/ZmAbVj6SybmIMhLNjbdArCAr0DmywlFEsG6qoEb5lAAU
 t8ocEccKz39YQ2O8zuQ37XUBz9cSNCTPEiipZngy0Q/mFkx1YxYwropjM7pbNZqsZP0n
 lq2BhI5/siaz2De2QsXk4IREBQGhc0vtfEcyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448386; x=1763053186;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0FPOXy54L0g+kMJHN6r2KlwP9D9KXMYuPNV9N87TbLU=;
 b=K+lbBOUIDRiIOVnW5LrrwA6koP93rrFS1NrZFA7bRjX0queey8XLvtD2BBtq/Zj2ta
 gK/dMXS3dnVir4lOkL/dA+695t4h1IxlphD1F8ISds4jqucAOj6iqsCThJfFkzYy1Ls+
 S41/zWdzydnthGGDIysct/gBxOpHhScETtnetBEHx1bM0F579mWh88ewE/7O7qqlvIyU
 ixrUqOuRdscgeDj2Nf3XBWW3NiCI3YMl6OseXg4Iu50sjTNja/IQUDYt9kDiAn9uY6zU
 EN1vqvKT0uK5YGzRdc0W5UsxpACzfiFAFURyPkAnUzQ/PLmR7zIbAAzs9YpYTZw8l9H0
 3kMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdFk1Zzi//o5OoYmhJSFR7+0/TjEQ5C5CDqEqd7L3YCBBz8RtDoJoz1EeLwdHYU7ObodzMiLs=@lists.denx.de
X-Gm-Message-State: AOJu0YzOhLWyldB1mMpC4acdm1LBoLAjs08dgDmh808rAV1cn+bCi2dL
 GvV2z85CmaN4NLog3leSd8Jv8EIP/6PA0rUbn4ip3E66FMv7+lAx8gxgTMT/6EJPahw=
X-Gm-Gg: ASbGncs44ARPEyMIvklnX3SuDgMU590Jqd2k9YrfZauKDxCBUj2XupIGcMxEUpKzBmD
 WWfDfVd6QNjlpmftPwvrFoHSv/dGy5bbMFuKs/vwHVOV4Q5XlJHX2tZronMMUwAWk2WTSR+1pzn
 Fg3HcepqySspRn9+JGXJNlxwZOX6pxfZXciGnoJUxh1ukTj0CQBv7nT5BeqLvIt9rhSJDh4MY5i
 d7q9bE2VO0+nuR1XmmHORzddBEJg78UeoQQUPEKeRx9momKCjnIa5ltnX30CTz4iQ5wsGoKqXWi
 guqbS/QHNqxICgLXTCd3PRhf+z8nvPZTek35YJCP5vmZgllymJ5qTaYzptAmipQrirWJOKCsL6S
 0e1wO5NGYrar7Mzq9QkPJtq+IGbObjiV5PL0T9kJLjhk73mCxifv8+Z0iWZC0BPDYixmAYObFj4
 7/L58rrCbqmLINbpgnLIL8STH15Tj3/RHOcfFmSw==
X-Google-Smtp-Source: AGHT+IGX0aiIhRrU4Ypx8QGwB7+Rjzo6IUkU9r+nRZtqfaZH5R5OBE/7mJntccqd7GNXVkFqdAy8Ag==
X-Received: by 2002:a05:6830:4410:b0:7c6:76b9:db24 with SMTP id
 46e09a7af769-7c6efc875e7mr214570a34.4.1762448386168; 
 Thu, 06 Nov 2025 08:59:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f11323absm24819a34.23.2025.11.06.08.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:59:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Ye Li <ye.li@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Dang Huynh <danct12@riseup.net>, u-boot@lists.denx.de
In-Reply-To: <20251101203429.1603832-1-jonas@kwiboo.se>
References: <20251101203429.1603832-1-jonas@kwiboo.se>
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
Message-Id: <176244838511.3056677.6474090475924239807.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 10:59:45 -0600
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

On Sat, 01 Nov 2025 20:34:26 +0000, Jonas Karlman wrote:

> Rockchip boards may depend on a working MMC regulator in SPL to
> successfully load FIT payload from MMC. Typically, these boards only
> include the vmmc-supply regulator and not its vin-supply in SPL control
> FDT.
> 
> The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
> Fixed regulators") breaks loading FIT from MMC in SPL on some of these
> boards due to now requiring the vin-supply to be included in the SPL
> control FDT.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "power: regulator: Add vin-supply for GPIO and Fixed regulators"
      commit: 32ead3c1bada6501a3d34ac7c0a7088cd6bcfbd2
-- 
Tom


