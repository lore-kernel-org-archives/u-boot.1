Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CD2F364AD
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7529084223;
	Thu,  9 Apr 2026 20:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G9U3uj0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2846C841C2; Thu,  9 Apr 2026 20:18:48 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DB28416F
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 20:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4042fe53946so577157fac.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775758723; x=1776363523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K+UaL4oyrDmFcr0jDkT5kD/FkY6gDPXSe0AwE4ioTbI=;
 b=G9U3uj0mgdP5RCO3GjiHBLmTuPsVk45Xiq4f30Ryj38fDFv2epTXM3C25l9qsu9hox
 Jpes4/zZloq6vJcRPXLwC/sbXsSShoJ295dbWZS2clCMyhGYe5ncesyatPFHgT15DveI
 aDaH7ZdDTiGkdClgMUMCixBMKlcG0S6a534gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775758723; x=1776363523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K+UaL4oyrDmFcr0jDkT5kD/FkY6gDPXSe0AwE4ioTbI=;
 b=achQRa0MIVAzgi9OPKOWDVgpYyTDeMgtpxL1hMTMRnn957WUSwlhmR9SqxkZYsWfi0
 g4hc7Pwb9nCA9FLILyo/Z1ph3BvNoqkY1htVKB8Tkh8hMXurIteTyIXFNXTMVWJVJzHU
 jroubaQ7e5ufWO1hmioKvABBcxAqtLHrbTQRyZPbb6ftfZkiebWIe63fHs3sHK3p1QLA
 X1SZoSDveN5L2648QyOFbBq/+MhW9XjsPjd6R9/00nF4iGtNwOYocnuUElCS3vymastj
 9o7IhJ5PiBhJAcBULfDMtkzrIHo81yCjGnqgRiFqzK1Oeaz6vgpzyvyk3KEQB6iN1d6p
 rw7w==
X-Gm-Message-State: AOJu0YxHkI0sGV4eqm8gNbC/9xnmyuSd6I1wgeKQqn3KE0smCAhFuKhE
 JPnAejRnx7IGLcJy0K2wEmgQN2BdsBGPGxtN8OBUf8/J6nR+hoWKYbnIfKxsTANxRTNwAtombEX
 0RrsprtY=
X-Gm-Gg: AeBDievWveaZ6ocTwvlQMNgjfRv+Db4AIwjA0pJQCu2z56aRPGSK7WyhyVu8S3mWsQg
 QCkFXL6bvU/2LBOO00V3tLWhyfYOyZUHZ2FF8Xd3irQvDlbgSmrNKwbyO0A63R6n0v3CTpcidqK
 SZsDtpZCxBL4tJ0Rb4vCgLFO5NL0zYuu7X9fQHFhp6dJ9G88KN9SlW9mrpZIOm406GY0TGr8zY1
 8uobfZASgE7WboNslU73kL6/m5liqmYjLnQbZy+x1wetilL4t0OjHSgUS0YyFB0Evim6cKrDEL6
 Y9F/OueSDUp+yzYT0SnjxfQb4aVi69pWCyL5sthMfo4le6j0pxWzcrnlRLKNODfVzVRNbt6M8oJ
 vSXf4bsTwYclkCGisIhbSf5oBOV2D9MENcEn72K/guB/jjWt9SSkREfyID0ebu1548AmTBGzQdn
 bx1oOJTDemCD/G/YJR1kHqXus8qJ4YL8eGjg9n9fdTgzwmWBUETw5hJrwAPP9Pt5HuBsHVdE9MH
 kJ1x1is11dNN8OHwWQZp6lRBIzzwcCAEOUWik5ml0N8ND4uYWJlYQ==
X-Received: by 2002:a05:6808:1a20:b0:46c:e542:cc35 with SMTP id
 5614622812f47-4789f00c7fbmr161249b6e.37.1775758723399; 
 Thu, 09 Apr 2026 11:18:43 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a2f565d1sm76328b6e.10.2026.04.09.11.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 11:18:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Peng Fan <peng.fan@oss.nxp.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2026.07-rc1
Date: Thu,  9 Apr 2026 12:18:40 -0600
Message-ID: <177575860044.1153156.2866801666031959087.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <add3Gk_2psBrgUv8@nxa18884-linux.ap.freescale.net>
References: <add3Gk_2psBrgUv8@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 9 Apr 2026 17:53:30 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-for-2026.07-rc1 for master
> 
> ------------------------------------------------------------
> Add env variables to assist boot for various LS boards
> Add gpio scmi driver
> Fix setting the function for scmi pinctrl
> Use standard device tree pin muxing format for scmi pinctrl
> Fix protocol version fetch for non-CCF platforms in scmi clk
> ------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom

