Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5540CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 16:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A6284664;
	Thu, 11 Jun 2026 18:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CZ7DMqz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C7F84701; Thu, 11 Jun 2026 18:01:50 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B5584664
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e71b2d527dso12298a34.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781193707; x=1781798507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUfhaKepLETkgWMgOktVBhyVttWkgaGMB1Dz8aXuRDQ=;
 b=CZ7DMqz3tYXC0ORZehYBjwPUZkHdvN87srK79C17HUdhN8D7zsYIo4w206pDiHHuFy
 8weYkrQGo2k860DTN76FNcd1RR/5vhlyl5lrWN5VzUyhkTCpCH9uhIcAe2u7J93sVP6u
 ZfdwPuLUId1d9H0RCCuvN5Fc2VjnXh6FdfI7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193707; x=1781798507;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YUfhaKepLETkgWMgOktVBhyVttWkgaGMB1Dz8aXuRDQ=;
 b=f+GfquGYGkPop4ITWK1dygGmjgZuBoG0hlkUOrQL0VvEehswjwX3ZrNUQgjbtriEsD
 9KYuYHVcW25s+MZD+bTSSDQRYF5Qg0a0ztQ1eCzk5VTIRGp2D0xDsZvfRcvAJ4RzewYk
 3EpVHFIctmz7b+j7b6q5wq0+NVz5QkK3dsdlH4lqu2NNpeff/cKuJNg9VcEVIfmzePYn
 zXd2iWXkSoerlEdvcyVyCRxsf6bZw89zpEI6mMlTcQIx1GLW5092bvT1xW5OHrwDWBp2
 uB0MFu98/pcolD41951TQ+QfCy/aBdKTsJKDUmeV3LEMuv3H4vdDQz1K3te69G8Di2o4
 Bobg==
X-Gm-Message-State: AOJu0Yy9OkMaRHb+DEESdM5mg8adqKYb1ST7rj1YnqmsGgXg37Q9GymQ
 QA1wWXvdOHgMkBrnFgbzXUsUPZ28b25S8qloJS5qVBr42izKzfNTAsSnvHTbimvLOCI=
X-Gm-Gg: Acq92OHkCokEG7GWO+59Wy1t5gJZQ+E2EOuH/sgadkqruOwVnPbg+/fyOo5Ffz1HE5H
 NoPPp2DTXLCXvdQo5Wvk7KzoopzmS1VbcWvKu5Ak5qr2X7ZYNEs+JurxTCnzb3c4fBz717F3pwV
 3hv5v3JkYxNaPDXAMPPucQuQBKzQc5xZPh3aO8mTZWUYaJEoj9u9sfczj+DNP2UW4UwrAmeXgG/
 Rz9iyg8SG6P6oBCVvwEADIcsnKcMTKPG/YXSVkOE7ASxNzc71EBoP6grdQWn2RHRJb+0xasu3GU
 uR0s2u+wWOekDl0OT2HrRKjVfTtUk1A9aC9K2ej7NCBeXgzPYihDCdzcUKdwaPSp+9u/0Q6Vz+I
 xnOiEgL9bfVs7Ez/sZLNr3jT056QLEX977qy1vspXntXBddbCVJCNiUtssKI6O9PkRYaUebW58f
 IOrS2zGbqeM2SBl06hF1l6TbpTAQ26UEXEHr81m3Kfq953vTsHQeHgvotElPEgwe+7hxWbL6qOV
 WQ+zUhUHpZ+IEk09nIzhrA3YqbXlKjtQOWb8OpZ6KqEHKOz9ZxpgF2glw==
X-Received: by 2002:a05:6830:3c86:b0:7e6:d54e:8fe3 with SMTP id
 46e09a7af769-7e7733b7133mr2929170a34.9.1781193706626; 
 Thu, 11 Jun 2026 09:01:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774cefa1dsm1662723a34.24.2026.06.11.09.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:01:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260602213013.558064-1-rv@rasmusvillemoes.dk>
References: <20260602213013.558064-1-rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 0/3] allow control DTB to double as "FIT image"
Message-Id: <178119370551.503339.1412715765059616867.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 10:01:45 -0600
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

On Tue, 02 Jun 2026 23:30:10 +0200, Rasmus Villemoes wrote:

> The commit message for patch 1 explains what it is I'd like to be able
> to do, but here's some more background:
> 
> For a long time, we've embedded the boot script in the U-Boot binary
> by building a bootscript.itb, and using a .dtsi like
> 
>   / {
>           config {
>                  bootscript = /incbin/("/path/to/bootscript.itb");
>           };
>   };
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
      commit: 7779540f093d8d09ee29e127c8b6a7cc455db27c
[2/3] doc: develop: add section on embedding scripts inside control DTB
      commit: a6369b8bb299aff8d5641fd11d2fcd0214103a18
[3/3] test: hook up test of allowing control DTB to act as FIT image
      commit: c8a636af67c640e1427e1085c8bada672e48f805
-- 
Tom


