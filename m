Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83410CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4099E849BF;
	Wed, 10 Jun 2026 00:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GMPcxVNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B768B849A4; Wed, 10 Jun 2026 00:28:24 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B4984987
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-48677c167b7so2887554b6e.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044101; x=1781648901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FE1e5VNGtinMP1Yvo8v1MuUGiljDK8lGjjoqlIqAWc=;
 b=GMPcxVNM6m9MlGlFKG6BDIg5SnMOXDkNMVZ4BziHOvPrihkk8uSXEry4WQNnhsIKYW
 i531vxO1ceNP4YGXFsBdPCwPip3D9M2QcP3+xy7ZGqMH2gJtgmlC4v2LOFe1Jdbr6Vth
 Atj82KXaXkn4HBx9/Y89DmBrvMqJa3w7wNt08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044101; x=1781648901;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9FE1e5VNGtinMP1Yvo8v1MuUGiljDK8lGjjoqlIqAWc=;
 b=Sgwsqnpy8CSmxyf92qHQ33Vj2qAkDoaWQ9uUyOmbeqeBYRX1STZWWrmXeCVQ3XoNDK
 qPzk4zz7Dp0hYUK2sq8H7l1WGK568ZWCPzuYjDs8iByKvD/bd0fLXKnTxiYoYDahQ5KT
 41JSD3Vv1h40eRLXrPP2eGw/KRPOimzuofeODWAEbcnZP3Mw1zypC0/z9CkKLdAwRwbV
 VGf1v+9EOs/LbWGTLFG/gfRn6hUNEIwdu2I558iTgAoS4CpdBGOFvzo1OT0h3k3RkS2w
 W6kHPzLYhujLzSkAwdlOx/DVipM2hi3IA2xtbdkyg+To9mkexvvyxEB3PWoniZu3X/Ic
 s7Lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ps/9xTHkAhMRzN2qxrjk4XlARMOVE1vgS0IbY/Xn8ZhU+IhZipnrNOBlV/sDuDLjhmvTfKvM=@lists.denx.de
X-Gm-Message-State: AOJu0YyViiAysc2vlUJ69hC5cYYVpAsFA6gBZBOhpOpUziTMMjyY/bf9
 LQyjrYVwIYl2rCVNVJCqLUcHoIcAkEYJF2Mph5jzeFm/sZMYeA2Co9PHmesJYBvOGV9MQFsBj66
 SSs+VcDs=
X-Gm-Gg: Acq92OF7SgVQ6ZVRoB8+XyDU3ZMPUmN+0VjHHefgDSO14HkvHNeF/73NdIZz+iXYzM7
 ZX4F5HaudXTiUXCporyD/ihMC75iMExMR+ylrtNzSUIzzCOZyLhzsOIDpqn19AUNlhWVW1mRhnD
 WbmN5ka7nSaSkpvjT5DUloWC0NEmAD1ayAAT8Q/oPE+7FSvbRMydPjAMGOLtxqUW0MqXtuih2b8
 4KzVvQyRgdFxUx0CPj0SuxL2yX9S7DdeYtcLG35ecU497rJifS2xqt+BF8luOdokd6d3K1TXAG8
 G1fNIGzZjUmotBRvTdCMru8pnCPF8UEPcwHkR6yf40nGGWLAKHULMk12UFSoX8DP8RaZeIafrB0
 YU74di5Lhgsn1bL2eahQO9OGv8MmI/NtuoVHTgnPui4HOsGvEP0oZrKZ9WI/YCgL6KMz6euk+Y9
 9eEOGuLoncv6FI+jFW28PBY8IL7tfxYmnSTpGo2Yh/Jm3JSouqun6Zt432qW8/39r6uT9u7nbFn
 hP3fQAJSrCETf/kIIi+ZAJQ3AbHf6qsSOcYANinLcWbkEEsvt0I3n3DSXVu
X-Received: by 2002:a05:6808:f88:b0:485:43ed:bd4d with SMTP id
 5614622812f47-4868df00235mr13540111b6e.33.1781044101481; 
 Tue, 09 Jun 2026 15:28:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, 
 treding@nvidia.com, clamor95@gmail.com, peng.fan@nxp.com
Cc: BMC-SW@aspeedtech.com, joel@jms.id.au, u-boot@lists.denx.de
In-Reply-To: <20260525043714.2374516-1-peng.fan@nxp.com>
References: <20260525043714.2374516-1-peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] crypto: aspeed: Use dev_read_addr_x()
Message-Id: <178104410033.79918.9702875555604718807.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:20 -0600
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

On Mon, 25 May 2026 12:37:13 +0800, peng.fan@nxp.com wrote:

> Use dev_read_addr_x() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> 

Applied to u-boot/next, thanks!

[1/2] crypto: aspeed: Use dev_read_addr_x()
      commit: c305b8ac862b225d659471d1c2a462717999eb5d
[2/2] crypto: tegra: Use dev_read_addr_x()
      commit: f2479b58aa7287065351af2a53909586475a2289
-- 
Tom


