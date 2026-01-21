Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B0C44506
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 19:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A5583015;
	Wed, 21 Jan 2026 20:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="otpRwLqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5367B83A3B; Wed, 21 Jan 2026 20:19:04 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1977480077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 20:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45c838069e5so122676b6e.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769023141; x=1769627941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRWo+DHCkBHCaCoPtc6XxdekuGBvGu1GaB4nkaWAvPE=;
 b=otpRwLqIQnvc7VT1WvlUk9j7dnVdEoh+HycpQjPf2r/ZJ9Ef/1dJi5luAM1+pORJ/Q
 spSc0iGs5yc9hk306xwaL9y9dzea98F1mRNOAS1nvVzwhGQTySq6qSGYKFjjbr2IBDdP
 90H+ZZ4ySd2gf0rt42mW/As4tcmfPnPOy3yRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769023141; x=1769627941;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JRWo+DHCkBHCaCoPtc6XxdekuGBvGu1GaB4nkaWAvPE=;
 b=OyLHYganI3Psdy6sBKC+PPQDCH8Ax0H5bpxotjRZJK4c44ponbEkDfVds9yrsHLwiD
 lXiBZ/wSDyGHtaCNGhDqWJCkac9tg/Dl9lIhqMfi+f40bX5Ds53PK3BcYWRyg5q5eSjy
 g4gwu4mwYDHpvj6DiQ++slnk1K94I7utjhw6ebSBLO9LLE33Sl07sZBwKzoJf5srq89X
 wYcwT1oFRG/CkZiMpErzB3YvIfjyC2x7O6EpI9HbsgcuCCWXvcFZTiKnX/flqTzbVNsG
 K867HYaZtWQhE4UqmIk92vDyMyfa5IUyR8MAZQV40raSSmwXdweJLZrlYlh2KryKdRTR
 UG3g==
X-Gm-Message-State: AOJu0YzXwVRq3aaKoGoTTPDM1Y11TefI92g3mJizLFBFnL67Wm59WrbU
 H/naKONISdgvPtO0/iadYaSKgJAcc6o+s/yUhry9ng9+6tR4gVFR4HUbrsrRqfXmiT2XNQQx5ex
 eiqbMrlI=
X-Gm-Gg: AZuq6aIhKB01n8igypZvg0wzyz0G1HLiwtVAqwjtpZfKJBa5cAcGs1xUGwzj+xerdBk
 Plq98tvAuHafc+cLlgTnwiqGg1FVIYr/WBMQ1Qk9fbmW0JZoZswzsDpUE8faanDf66BbawuknjZ
 fq3euKkCKUkhpVjuOQTF/F2pwfWXVMvzRy4+waI3xTYeA08D74QvTqKqNImtZs/S3fAse/V6rOz
 fwQzr9SPATpaany1ozwigLL3qVxXjWJOCSJ6Wq0vDuf3pMYIMK8/R0YezfCzW2ZxL+GfDFy4q4K
 mt5aRY3KbKezsvH0VvKfVrn+O+FMv2KBg8h1Z04KdySv2cUJEVFdjBtuSFH2Nc73mTU3D9OgXlP
 xKRot2gkV49JYZT8W/bbweRFkEVMuwedHr+HX9wWq4hwb6PSsRtkRKTCDo3/5tfmuuVE1ZfHrG3
 cFzi/qKhfTyxKfj+3L6sx6AU/FT5JDZhzAA/IHabgSfkNOOaepTcyCB9aFSKPbLHJdlyqG2d2RK
 b+RoLVnJN/71sB7uEAtQh1N6oPvVVUqMOJuDUcUfsZV38D8
X-Received: by 2002:a05:6808:1b23:b0:44f:e7bd:274c with SMTP id
 5614622812f47-45c9c10dd48mr7445158b6e.51.1769023140722; 
 Wed, 21 Jan 2026 11:19:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9defa8a8sm9181560b6e.6.2026.01.21.11.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 11:19:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: ggiordano@phytec.com, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20260113053531.1204984-1-w.egorov@phytec.de>
References: <20260113053531.1204984-1-w.egorov@phytec.de>
Subject: Re: [PATCH 1/3] configs: phycore_am6xx_a53_defconfig: Enable CMD_DDR4
Message-Id: <176902314005.643148.17081252097976732715.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 13:19:00 -0600
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

On Tue, 13 Jan 2026 06:35:29 +0100, Wadim Egorov wrote:

> Enable command for verifying DDRSS inline ECC features.
> 
> 

Applied to u-boot/master, thanks!

[1/3] configs: phycore_am6xx_a53_defconfig: Enable CMD_DDR4
      commit: 3396e7d4aae81717a455a6427f4a218b2c99e408
[2/3] configs: phycore_am62x_r5_ethboot_defconfig: Drop NET_RANDOM_ETHADDR
      commit: 464b64af6fa182769d42466c3427083815063727
[3/3] configs: phycore_am62ax_r5_ethboot_defconfig: Drop NET_RANDOM_ETHADDR
      commit: c620865280291279890da1aa9a9e0bd3c1c212cc
-- 
Tom


