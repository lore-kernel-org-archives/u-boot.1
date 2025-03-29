Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42E4C3600C
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 16:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D490805C8;
	Sat, 29 Mar 2025 17:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iDML4IYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447AC81E06; Sat, 29 Mar 2025 17:37:22 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDE981E5A
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 17:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3f68460865aso2014498b6e.0
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743266237; x=1743871037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tdw4NX1XXd9o6UvrntRwBB26VbQgoApAJWsvC1pLdaw=;
 b=iDML4IYItCOFmP43NBp1WvqA7bUqHfdJ1b1teM53ouZmxhWGxF3hXQJdnlK8z3nzTQ
 nOaIANBvL6O41r2Twxh6cUJH7v+2b6vd+BQW6sLrAQzNOzOLGd5C1un6tOdwv7tHCEax
 Ja/oj7D16OlelegyxLmwTJU+lTEoDRJHKkAyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743266237; x=1743871037;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tdw4NX1XXd9o6UvrntRwBB26VbQgoApAJWsvC1pLdaw=;
 b=Of8EFhthp1gPuqEP5r3ujdrZZQNxNPW4EoTvSlUKx/Y5+L2UuzVhq54Hke7W12bq6q
 aRMJYvVTdQTHsRtxt1XWMTM7o7pUnjfBYZVyKBHxnrzC1JPs45h5yu2yWYlLgsUoTRQV
 yBAM7DD3kkSzEsbhqiYDT4qUqMKMm/WtBSZ0PSYWGPV7I75OBicF/aUNKN2hs3/cC4Co
 +qP390ZnumgwjqErRvT5VLDbomFkboDdPzLyc69R3tnhcWvdryN7IzTyIjRs0mfx59x9
 chu84MYLV+4LWwReqDGYg5FPoQLjD+1PfHI/ukIajeZ1fwA8XXrF5+t4xZGIqfDmSzWq
 CY2A==
X-Gm-Message-State: AOJu0YzgsdaFXsA6TtGqyQrlIVDo5lwWX0D3dhEe/Iet+L0FDIKxEwxH
 gkZixmGbGjkD+rnIudsdAG/fA/IEiJBT2Zmc4/mxEwXbX6E8nZSTAWnX37dBL61chsR+N1cC4z/
 G
X-Gm-Gg: ASbGncurIOGTdhtEWlQbeCviNmEoWFQnWY4rUrCpCw4/RT5iIUBlnDGsNvOdckDZvO2
 irBR+0e4zqAFOlc4XnaKra8xsyxTFlN7n4Me4Q6aQeTsplKT+3mVK5kqX4NgHLhmW676wEjUu73
 ivcbG461YTLjBLRVcetPA2Mdcr766adtUfwNqPZkkDTNRY8kskckwBM6EoXcwRc+dBMDoxTO0Bl
 l02wGOQE4Z9tL8L5tvOok1GRw05Aa7hZ+wVUsZXUaaWNEJ+etb9u6jF3Nn1sqF2lsUq+gAlCG8p
 fgW6P/5DM9P5vjQOHhZy8H99CwK8e07DfhfnkguzBtYdxEvnrssqJtA9N43QqaFn7Ne3s1IgwhX
 F5sUD
X-Google-Smtp-Source: AGHT+IGtCwVtyUBKksnYHD3zk06XJkD76upYWgNrHvYD/Jg4+LwG2yENgw7hhPVD5x4NEG3t0bFKqQ==
X-Received: by 2002:a05:6808:1406:b0:3f8:e55c:16d6 with SMTP id
 5614622812f47-3ff0f5b5bb2mr2129767b6e.28.1743266236862; 
 Sat, 29 Mar 2025 09:37:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05278de3sm766988b6e.36.2025.03.29.09.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 09:37:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Liya Huang <1425075683@qq.com>, linux-sunxi@lists.linux.dev
In-Reply-To: <20250327111214.2064340-1-andre.przywara@arm.com>
References: <20250327111214.2064340-1-andre.przywara@arm.com>
Subject: Re: Pull request: u-boot-sunxi/next for next
Message-Id: <174326623538.1009520.14409042559701400584.b4-ty@konsulko.com>
Date: Sat, 29 Mar 2025 10:37:15 -0600
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

On Thu, 27 Mar 2025 11:12:14 +0000, Andre Przywara wrote:

> please pull these sunxi changes into next:
> 
> Assorted fixes, refactorings and additions that are ready, and shave
> off some load from upcoming series'.
> 
> Improves MMC performance on D1/T113 (missed clock divider), enables
> eMMC access on the H616 family (never worked, many thanks to Jernej for
> the fix!), DRAM detection fixes for the H616 (now reportedly stable).
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


