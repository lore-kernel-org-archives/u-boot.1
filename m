Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A189A109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E042483FC6;
	Thu, 26 Mar 2026 00:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WeoS7Qj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EC983FB6; Thu, 26 Mar 2026 00:06:05 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF3E83F00
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-46704fbf62dso209505b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479959; x=1775084759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+AC++QaUONjXO8kDpdBb7zFAW550N8Xq6RdF2w+440=;
 b=WeoS7Qj0JEZrGsSrbw2rZHPvMegTnEoJ6sLCV24SaQ8Wp3+5cfWA1MEeNlETP4ivrz
 6DdESr+vAPxdBZ1uKn+X97xlId5WzRTgW+fLUQjdzzBwvdq17uJo+kEbvmKyf3zw6ogx
 14LB13ztR4MWwdv63ueGydKM/9igA98X/qxQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479959; x=1775084759;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+AC++QaUONjXO8kDpdBb7zFAW550N8Xq6RdF2w+440=;
 b=UQLjpbzLwFtNlbcz9S7DQwueuFN8eRlpsioKlem87yPYGkps4ikVXiSquFJLAN3pOl
 LOUv2K7cT185P8QzxMkRahIbB2O6KOgHXDGNPp+oJUeK9GZHD3p+l8CN5mob9VFFN0AC
 9CM8uAh6BYk0EYthJpv6b4bmFQkU/vHLphrq7J1Vnmx+SProUUnr3s62qj2Nu02VeKbM
 dLQXgdQeJXQeRasSjLApoVug1qeLI5vSL4EJywJd5pyxMJhlRLTp+EQG87tTZYB1cP3V
 rTp6LQiC5BxyTI7GA+kPHlJsPrWAMXAKUWmrvfrmy0o5HnTvz8wQSnznUZunHwn6ok58
 K+Xw==
X-Gm-Message-State: AOJu0YzHAJCxNV1lxckJptv5TAfwZHZErTgicwzKHfSzEz7x51Dwo/RM
 vDS29Zw1LPTDJJLjquFzRsF/2PG1N/VlI3ThiUip+Xihp4kF0iQyhWAvNsqKxiigNc4=
X-Gm-Gg: ATEYQzx0ToLdIJvJgZqcYzAcjyhUTNZSPDcUnS4kAkO5hLXBMitAqdubvBeurFrsLuS
 ddb+Un5zKqRgKxMAxR+b/EUGeIn3em3CoEW6Pd7dmc4go/zHNeVJqdX35hkWj36Zfsd4p6551Ve
 gA4fwfPHSv3YL9TceSxkvOIb8jt/0ffUlaxFNWgjwMYvBl+yJzqGT0tTFCwHa6Jr9zRVfRMgUSB
 j3n/Mky0/4gHbKAPE7afwn0kDYEDTtJb/pGquLVwNctsbgb9LmafJjQUcx8ISld32ozGkrYJZN0
 WjKWOGc4cb4W47tFo2+iAZ3EeRQVuoUH9D274UCu6yOIuRzsnrq4WL2IchnjKWs52lPmxh6Ox44
 JzPzLIvWgk6ihUvibmah8DLPmEC3wZkp/135C33d5lqAtJ3BhqPMDtFuR7dtBBXcs/dMuveYXDB
 b2egRz48QeXFcYBSw5iu+C+ch6ARCfSXjVswlMqsQsU5Ws5UdqmZveWflajEgu7OVtjKUpvGsiD
 o3u9hE9ed1X2VKpEkR/1meewGvGSOjIM1Q9jsl0wErlfLg=
X-Received: by 2002:a05:6808:4707:b0:467:999:9a14 with SMTP id
 5614622812f47-46a5c796762mr2451823b6e.42.1774479958870; 
 Wed, 25 Mar 2026 16:05:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:05:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Dhruva Gole <d-gole@ti.com>, Aniket Limaye <a-limaye@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Moteen Shah <m-shah@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>
In-Reply-To: <20260312-move_falcon_fixups_to_common-v1-1-d7c61bb5a77e@ti.com>
References: <20260312-move_falcon_fixups_to_common-v1-1-d7c61bb5a77e@ti.com>
Subject: Re: [PATCH] mach-k3: move k3_falcon_fdt_fixup out of r5/common.c
Message-Id: <177447995733.3508238.13414906849557178803.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:05:57 -0600
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

On Thu, 12 Mar 2026 17:34:17 +0530, Anshul Dalal wrote:

> k3_falcon_fdt_fixup is used to perform fdt fixups at runtime in falcon
> mode such as adding bootargs. Currently the function is only accessible
> to the R5 SPL but could be useful for A53 SPL based falcon mode setups
> as well.
> 
> Therefore this patch moves the function from r5/common.c to common.c.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mach-k3: move k3_falcon_fdt_fixup out of r5/common.c
      commit: 1e2052f76e98ae70ab29113d271bb376ed23e8bb
-- 
Tom


