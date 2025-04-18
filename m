Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF55C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 17:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33123831D4;
	Fri, 18 Apr 2025 19:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mMHs4WPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9D1831EA; Fri, 18 Apr 2025 19:12:17 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D32B83190
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 19:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2c2dc6c30c2so557121fac.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744996333; x=1745601133; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXbwg0ccMnYbClcHBxoLHO/2hHjl4HWcwqtd/zAt3Ks=;
 b=mMHs4WPPRIWFJN/F8zVQ6kEp1SKMhdau/GOg6tEXRgE1mzc3cjA8hxTwx64E8CimED
 GAegBMsor5ySYoIpStwvUfk1cP5rsmqp99rZdTzvMxiQHMV2vJo+6fcaioNz3tPulcl/
 J6oCM30DHwLaIllzPJP05vdFhA2i9Gc74GfOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996333; x=1745601133;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXbwg0ccMnYbClcHBxoLHO/2hHjl4HWcwqtd/zAt3Ks=;
 b=oRJ7gfL0skJGlU5o3qqF3JfCo0PGj6BXGOtx/Ikw7CaJP+lIdQ0uWBgjcHOhEFgB9w
 YELHa/vJwx2ElwOXJ1Xv4CKnq7HPlRj4Ub4WOmBZPy2xxGxAhqtgb/c9A6PSZWajpiaH
 A3+zmYbOYsTGd1EcU6xK9gHH6E+J1/3a0ZLH680rlt1334AClRmoGksYiypApr00pVSz
 r6m/Hy8owsUY3jGksGwtnQuLjUgIyw18lBemZ9BRlfSGYYXoXwTfMXrXm2GNGvZMo6/A
 xZixo8pfCu8d/ugZ3XIFSwWgGGDuRTFJBMw7uyYy3wlo9kgB2JPQKuV2S8jLpy/i/uwk
 U0Fg==
X-Gm-Message-State: AOJu0Yz33s3JVote0wf7ijqz2h8/gxYUIIFemNWDqmUkIwGsnEqsGqXq
 SpPqx53Gxgtz+PbNANbVfd7dKeXuxgwF/BK0PEIjvuyij2f4dd4hHOUX4lsoN6A=
X-Gm-Gg: ASbGnctThC22QWnnh0PvK8R6f/wk+c82O4ObzVnnHEWRf1Pm4TrQCQjMEqJ/EhhxeFY
 f6ffLi+1SOFRL/2y0WS6W8ayekdq8i4VzFzdw9Dwetex1FmthwPl4TnS0SXlmX/5oiIk4ZftzC8
 GR9tDliFBbPPudg2J7FVJ2DsNPwIHGykCDDWl98jy/lGi3ycpHx318z7qXFag2Z9YPp24QZH2bH
 SMgPH/OHvIAjHeWIHgffgBoEhWg39hutvJNenI3AleyhbMtG9agXYuW11LK3FQDgQWNVZMr7ZR2
 ygZClCCilO3bjEt1tgbnf6JBf++RWVTQsHCfgkLHRxps9wzgJv9y3MOIWiF2rlB7qYh5ow2/4+C
 j
X-Google-Smtp-Source: AGHT+IGUyFVbOFjRN08gDGNEhWXc2NbNJvkcD+1isLBHexpFLX0zCen1kE1pD89xMsRPO9o43cg4DA==
X-Received: by 2002:a05:6871:d043:b0:2d5:cb3:6b1c with SMTP id
 586e51a60fabf-2d526a5c6ecmr1910124fac.14.1744996333323; 
 Fri, 18 Apr 2025 10:12:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7300478c4ecsm403979a34.3.2025.04.18.10.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 10:12:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: miquel.raynal@bootlin.com, jh80.chung@samsung.com, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, thomas.petazzoni@bootlin.com, 
 ian.ray@gehealthcare.com, dario.binacchi@amarulasolutions.com, 
 aford173@gmail.com, seanga2@gmail.com, nm@ti.com, francesco@dolcini.it
In-Reply-To: <20250417115311.1905411-1-w.egorov@phytec.de>
References: <20250417115311.1905411-1-w.egorov@phytec.de>
Subject: Re: [PATCH] Revert "power-domain: Add refcounting"
Message-Id: <174499633159.3148707.16976292298695242467.b4-ty@konsulko.com>
Date: Fri, 18 Apr 2025 11:12:11 -0600
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

On Thu, 17 Apr 2025 13:53:11 +0200, Wadim Egorov wrote:

> Unfortunately this change breaks boot on K3 platform.
> U-Boot will hang after:
> 
>   U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
>   SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> 
> This reverts commit 197376fbf300e92afa0a1583815d9c9eb52d613a as
> suggested in [1].
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "power-domain: Add refcounting"
      commit: 71f497a6d3908574a1b1c3813c2a1385910f76bd
-- 
Tom


