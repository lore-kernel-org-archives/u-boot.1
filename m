Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD40FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FA9844C4;
	Sat, 25 Apr 2026 20:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sZqc6tDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 724D5844D2; Sat, 25 Apr 2026 20:34:29 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B97784445
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-94ac8cbf3feso5476342241.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777142066; x=1777746866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZnrEa7v8lk39zICfms8F7NPh8Mc5FgqoBWHcIsqPCo=;
 b=sZqc6tDD8jROqSWBN8LUsRBFM22jszT7mNYdjvROdcawXH30864J+3yrpJgc/dsRPq
 YYRok8eE8nNoT6S/SCHUazTwbiK2OeOvbfnm7iRyX9FdrghweRI1JOGrwRB2AKni5Bkz
 rNNDXA1wdT49D3xUfrCgiMcZH57C1H6KHDwck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777142066; x=1777746866;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xZnrEa7v8lk39zICfms8F7NPh8Mc5FgqoBWHcIsqPCo=;
 b=Ago7+z16bddhJqRsLrQnxR4+nZIiVjpT/g+DP6gacnFdWZb+2eC1xCeQ4kIZfYq2ZV
 17RPpnKRu2zqT3uOwIHkc3gQt9/po9vnYCG6WRBHmLtafwu+PVBruHC/btiWaVNy2d++
 uD51WBT/ULDJGSE3N3JD/OeqmtrVv6a5JqiZqlwx+Y+T6EDjfnBA7+BN+39vh7MaRrYR
 ETAInb40swU2XVJ3R+u251S4PVFhM+YxiYzBUk62HjMqvaCQjQzy9Y4+Vrfupj2A8eMB
 NXWS7k6E448EUW3gLRmuJ5Z9KTQWAPVZ1LO3aPDoHrPKXEFdmB7v6kldPZ1ZwiWGGb08
 S0xA==
X-Gm-Message-State: AOJu0YwNU7g8XjQk1JoNwB3p6Es6A1/RoKUv58TEfvz5364xUU3B8af0
 oi3OjSYhwZYqJEKnVLTv+yYWq48FAuLegcs6tseGcKvHXZ9waheev0PVs5v6ltKeq/loUMEuJWR
 xq2pRy9kzyA==
X-Gm-Gg: AeBDievKdJW5AyBApyRneKhAts7Qv+deovvsfOf2Nd9Xw8EqWUl+DtezXMm4u2ildHx
 o9qQ71VCdMd+CpD+Lc9Olm9pAVBijTUMNl/AYUkcTPM7tlNK7VzHQUTIfyHC2Q3W5Ahn54DJp6l
 pluVCNpOp2JGdLxdrAaAZl+AbHkgkiAE25ekWrHZV/RLs0QbdkaKb/QQgLHNc6HpI0vcvancZbx
 Y3MPyGyr6YO+r0tNsTzCdBzo2bAPmfvrX5vw7Old8XO2CAsJMvklFi5Vtg1ElySLBc0piHw/Wgg
 /ET49rWqb0kJBd8hFEFp0j2glXiBF7f7VTBR5afCv9Idi7E7wp3hgj25qIJUm6l0kyJiZjEEz+q
 qHvZVcpvI8wGoyDQaZM6sZGqcDMDec8dDRwc0Z3Kva80ctZrS8D6RmhKaj6tUjETCQJaChcveQt
 XN74WQJSAAj3P/5wKgdu6TBF9SSCA+VFmcK3eRodvx9slqCFa73wuO1OgKxawY70iusFK7Ou5eE
 +sufl4jgesIEYwd2zwm6JlCFBEJ5xntvKkQ+tEj9HI/S8cOwvcl6VPQph+sBK3xDO8d8+E=
X-Received: by 2002:a05:6808:c151:b0:467:de73:8649 with SMTP id
 5614622812f47-4799c9188c8mr12680630b6e.7.1776898140157; 
 Wed, 22 Apr 2026 15:49:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-479f3cf40d1sm3874175b6e.12.2026.04.22.15.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 15:48:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Andrew Davis <afd@ti.com>, 
 Jason Kridner <jkridner@beagleboard.org>, thomas.petazzoni@bootlin.com, 
 Marian Cingel <cingel.marian@gmail.com>
In-Reply-To: <20260414153612.754646-1-kory.maincent@bootlin.com>
References: <20260414153612.754646-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH v2] board: ti: cape_detect: Add overlay name lookup
 table for extension boards
Message-Id: <177689813934.1956774.5143761338721326023.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 16:48:59 -0600
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

On Tue, 14 Apr 2026 17:36:11 +0200, Kory Maincent wrote:

> Some extension boards have EEPROM part numbers that do not directly match
> their devicetree overlay filenames. Introduce a static name_mapping table
> and a set_cape_overlay() helper that translates the part number and version
> strings read from the EEPROM into the correct overlay filename.
> 
> When no entry matches, fall back to the existing behavior of constructing
> the overlay name as "<part_number>-<version>.dtbo" directly from the
> EEPROM content.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: cape_detect: Add overlay name lookup table for extension boards
      commit: 3abc7c1d46de4211b2d11051033566c9ad2c2740
-- 
Tom


