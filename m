Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F05DCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5326F849A9;
	Tue,  9 Jun 2026 21:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="anB6XA6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1948496E; Tue,  9 Jun 2026 21:17:57 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E730F84994
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-69e402b625fso3972252eaf.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781032673; x=1781637473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S0El+GIEebXRE0YecNEMWUr0mZ3iF1anD4jZmIZ3jxw=;
 b=anB6XA6oSaomKdOgP883kpP/Mw2jd3fG7Wu4V9uftLXeJZtjQ+dK2DrusmPqC1gFtt
 Yul4cnefUxGmZZNZ0OHRZxfbnTj527osNawqJrxUm4RofAjw+qkThP7oPUKcqzzs4S6c
 h2U+MDsurbxZWMrNbmHCggj+fNhTmTdbWPp5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032673; x=1781637473;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S0El+GIEebXRE0YecNEMWUr0mZ3iF1anD4jZmIZ3jxw=;
 b=lqZdOOQa3VRqmcqaRdd+39XIutMdQZc1drv/5T+fLxZNiLNgbbYhLqGjDOqTwbgKvf
 g0VNXnQQajWfveJ54mAjTC7cV/5TUagQTSwSoxckIgTtUIcxvtM7uadMaILDzJOed6P9
 1vMsEYYRqQmn5IXf09izNie9xnZHUzEz+pLz+RutVd+YMzwmYLg24uJXILKV/VtJqDvB
 zovEwoNzLZZbC3AnCyV4fG3+9lRkAddChyC+r8515awVj/6gx33C1C2ZOmuXCD/LeWx5
 kMGswyb+qsd6LUV2S0hm88JribSHFEU1xj6berTc6ZzuRgoGNvBx9PIZuR7QtwjIWuNA
 IKkg==
X-Gm-Message-State: AOJu0YwqyMPwiWYbz3yeAhHon9Mr5byBkf0ELbtYOspYPS7x1m/4txVX
 5KncHm4kXMPmjf5BYoKxfFb71OjEKkBp3PH3Qno9CqnHP+GjwnUN0CphgsX+Ssp2rtgSqtALXWv
 UXPANFcE=
X-Gm-Gg: Acq92OFgA0kiyxzSO71HvIykhkCzImJTNBpeXDa8GWabNOz2JEMERGZbLkZHmq37aZt
 FbV64+z+Tks2BcIzCDv7kq3LvfE4XeYfSeDh6dwIRPXLxRmmzXGbcpxRF6f9DN/PtVN6JU8dY0m
 jaBJ4Aj54yJDttIEvDJpDfMp22dlJ+FHy9b4XV9HSfGumyVNmYYaPmocWvyDQE9nJaZsopSLE3k
 Er+Lm78arvnWFEjDCvaQO159NFTety+htKrK74ZsdDYO3MQuWC0IXMSCevCbGBsExvn/+Kzyf7z
 X4NQ+3Mef43qMkF0raH2hUrBqMY8xDS3MXOtlYkVTy46rgzg+SUxU9bZfauR+O3iH+H0UU4T9u9
 fWynVXmnEwCM+gJZputY9flW+V8lvgSYbbk/nF+dOxO4Png5DghLp8W4HdIZDU1AeeonpaOz6Ea
 +OnxK6Er4S390avR/BqqcZpgrhabXullFBYB+huSiGBMnlnruGXyV3Fm6oi9ESTPTv3o/xsGLlC
 cYdFc2tUeXaPnFgtfdIp+SMpmuftQTbIJf5t9kM1JGkZT2IXdL78txe7toq6q1GmPIRTGo=
X-Received: by 2002:a05:6820:1614:b0:69d:ef3c:7e34 with SMTP id
 006d021491bc7-69e685f4849mr12197609eaf.0.1781032673655; 
 Tue, 09 Jun 2026 12:17:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46405105sm11198449eaf.10.2026.06.09.12.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:17:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260609191311.3800039-1-trini@konsulko.com>
References: <20260609191311.3800039-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Sage: Pin to labgrid 25.0.1
Message-Id: <178103267313.3800924.12968829180546060266.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 13:17:53 -0600
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

On Tue, 09 Jun 2026 13:13:11 -0600, Tom Rini wrote:

> With the recent release of labgrid 26.0, we need to pin to 25.0.1 for
> the Sage lab until everything can be upgraded.
> 
> 

Applied to u-boot/master, thanks!

[1/1] CI: Sage: Pin to labgrid 25.0.1
      commit: 1ab49f6a91ea88889c4283348f18680d6f87131f
-- 
Tom


