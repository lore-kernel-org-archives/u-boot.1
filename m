Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE482CE7AA6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 01:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5B288966;
	Fri,  6 Sep 2024 03:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ecPKiWWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 993F888CC5; Fri,  6 Sep 2024 03:09:27 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92CDB886F9
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 03:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c354091616so8352516d6.0
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725584964; x=1726189764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fCeqDRxz2BlsaVvOnlRJWuOw8GIDJDPdqb7C2hlMvM=;
 b=ecPKiWWoVft0enUMXmnpwbVuFgV7iC7XLHevdcsJDnfDjNvHQbTli/SGG7kabCQ1jD
 VKr6kjmckg196NFpll8juVIuhCG9Fw2x49v3MOLVal2LFB97RGgFo0qTVaDEm2UmvwPP
 B7H4Xoe8QvJ+9U7YGscGoAWImw5wrT4lCE66U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725584964; x=1726189764;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fCeqDRxz2BlsaVvOnlRJWuOw8GIDJDPdqb7C2hlMvM=;
 b=dFNk9Qub4WDV980QucUAIXrsZu7TF70njru2201pI7D+stVEJ05/wB7mf3QwLp5yyM
 VvgzjCe8WvDi0Jdwzch9FgKjhAEIF0T81jClzrfR5ZeQcjbzKSH82/x+/xBsfOtbdy21
 ltTxlEM7Swwffh15SqjkwcKv0ytI55Beonwk1hHkyjQLxyybP608/cLJSVnKIJqfV2Z6
 Q+JwT6sytZhHXu3KeqRYIxw8dl6mr1Bcdvgf47dOKDzB3jl7JHRANDPNzexsL1KJ4euu
 woJvEiPo8Ys7ZpMmrg2ul3eTxcynCjIEqW4T1Xo4lUNsjqD2E2Wb+K2s1Sq9aRdjiwCM
 gzCQ==
X-Gm-Message-State: AOJu0YzujjSPFqypAzYAY1iuSR7U6Abx9wH3AWVoYkHBNKFDGIY02U2s
 ZMukQZtKvp1/ddqJ/1mgJ+Bvvi9XgarJlQwmHH8mNFpySMg+pfCwDijalEDlPuA=
X-Google-Smtp-Source: AGHT+IESjPVNCdZYO432WkeA5q6esFIBcx0zn7OhPv6nm1WYURTIhIcjoTYt+ipjoLRTBdzG5L5xgQ==
X-Received: by 2002:a05:6214:2d49:b0:6c3:3e01:7fad with SMTP id
 6a1803df08f44-6c5285128b9mr15430786d6.46.1725584964376; 
 Thu, 05 Sep 2024 18:09:24 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c52041803bsm12145516d6.105.2024.09.05.18.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 18:09:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, git@amd.com
In-Reply-To: <20240423053057.15863-1-venkatesh.abbarapu@amd.com>
References: <20240423053057.15863-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] mmc: Change the frequency to MMC_HS_52 when selecting
 hs400
Message-Id: <172558496312.1864439.5624811039683546824.b4-ty@konsulko.com>
Date: Thu, 05 Sep 2024 19:09:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 23 Apr 2024 11:00:57 +0530, Venkatesh Yadav Abbarapu wrote:

> Per JESD84-B51 P47, host need to change frequency to <=52MHz
> after setting HS_TIMING to 0x1, and host need to set the
> 8-bit DDR buswidth. Currently setting the frequency to 26MHz
> and trying to switch 8-bit DDR buswidth resulting timeouts.
> 
> mmc dev 1 0
> Select HS400 failed -110
> switch to partitions #0, OK
> mmc1(part 0) is current device
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


