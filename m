Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E7ECA0EFC
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 14:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334BC82DA1;
	Sun, 24 Aug 2025 16:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ma5oGqeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B43B9828A2; Sun, 24 Aug 2025 16:06:51 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BD2828A2
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 16:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-61c5272afbfso957941a12.1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756044409; x=1756649209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rIYWYeoeK7wPvZ5mEXLFKM/0LgxB9MeoVQ0/BXGYwrY=;
 b=Ma5oGqeHqhrILgW0ijWScVt/3wxQqBhW6K+X9FcoGUMZgtl/aGFDOM9zmlinjV1Tnj
 96sKU7fHKbS7eXsEUA/rJGW5IaeSAj/ehF0mfQZdU+qnN+V/nWdJZYMlsYPMHsqR71fh
 OZaeyjHMAeVEKAryj2Qw18650D6dmMM5uoMd11F4/BrsCUe4ppoQGOA85QfRD8cNd1nE
 J3G02ptAkO3GQo1ebSAtFmHaI2gPJlR8xMtHotisi5xvdRFm6QijpAqJ1A328Vm21TsG
 yio4UZpqARGJSsyoQmmnPD6mgqShpNtlHfgar2sT2jtYbZtgfA5eex/RN123TLysDqh2
 fdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756044409; x=1756649209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rIYWYeoeK7wPvZ5mEXLFKM/0LgxB9MeoVQ0/BXGYwrY=;
 b=FgWri/lWlXvNMHlofUnStSOh7WvXEQaSlJVVtY71uFaEXX19BY2q22rC22cIqvAY/u
 TMN1kS201Y+rMksnqPmX/QJnZ2lVi7/84S40dhZLYLy44qMXkz1CN29LOHsm7ZGJEt64
 XsahXS/+jrpUBnGwt0GECFqAXz1WcNTtbJVbBuYRJKEEqQTQbIit46dsWm1MVudHOdaB
 BXStU8sqNCw9Nix2JLouKVQcp3yPf3jKqM4hV9YrtCDuTpxap4tUDJVCN/gk6PaqX8Zq
 FeRHllj6Jt7C76jmLjlwuJ+REru2O7opcV7zDWADiaXFvYqmqkEJ73WYKgvlsEpkdN93
 G9GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwMZQEIGAV5YZOBtDXAQWEY0bFFaPWkTX6s/OU+ceTW+gvrvWftActD+EsFYG2T8G0PgP353w=@lists.denx.de
X-Gm-Message-State: AOJu0YzUmxlNTyvbhZyoHoJCStrARDeTpf0RmmT6PC7Eqpczab9RRwdW
 xO3C78TKaPkzsO6Asizu/zJKt/y3tEUxNwPi5yZbDwAwuP8S6gxcQOcg+sfTsODKO/1hoxkHVHI
 rTu3f+bu5p0M33ZCFJ6jVyjaTkFGRaN4=
X-Gm-Gg: ASbGnctJW8EjD0gB6Pf8twLJMUoIV9lj4/v7R81TY5Sj+lzGNrwMCr3BA9HpF6KLsjL
 d30lepdlsNXK3JsWOTSelC+mRo4O+wBnc1bqTL+rio3ouLyXEcNsDT9EwKIoSTe7KrqBGhE2178
 bWaTmeBldMh6zrsyjI1Z1iX+Is59l8rWsxZ/TNu6uF/o2W0WZ74ctX+TiCpARriy0/FwXL6Tzg4
 Pcrzw==
X-Google-Smtp-Source: AGHT+IHq4LXoker+oZaz0y6qVLhh52OLvUMUQ3HnFtgJeWeKuiuA2eZzzbq20aUQXwKBPAbDP1Kj77zrwOjeX/LHWks=
X-Received: by 2002:a05:6402:2547:b0:61c:63a2:b373 with SMTP id
 4fb4d7f45d1cf-61c63a2b425mr508163a12.17.1756044409061; Sun, 24 Aug 2025
 07:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
 <20250822-b4-exynos-power-v1-9-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-9-9e2f2f740029@grimler.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 24 Aug 2025 19:36:33 +0530
X-Gm-Features: Ac12FXzhUWqMb-HJKFKg_Hx1IRqf5N-vy7aqANAcAm_7E0ZgrRcfsL5eFc5T8A0
Message-ID: <CANAwSgSAG4XKcsNAyy0K7-gdH57qiZf5edsN72KfgRX9cmC-OA@mail.gmail.com>
Subject: Re: [PATCH 09/11] power: pmic: max8997: drop maxim, max8997 compatible
To: Henrik Grimler <henrik@grimler.se>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Henrik,


On Sat, 23 Aug 2025 at 00:05, Henrik Grimler <henrik@grimler.se> wrote:
>
> All u-boot users now use maxim,max8997-pmic instead, as does Linux's
> DTSes, so we can now safely drop the maxim,max8997 compatible.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  drivers/power/pmic/max8997.c | 1 -
>  1 file changed, 1 deletion(-)
>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
