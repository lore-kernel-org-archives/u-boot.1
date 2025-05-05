Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED1BC3ABBF
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF958212F;
	Tue,  6 May 2025 01:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JcSEBIGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BFAA82102; Tue,  6 May 2025 01:35:30 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A40820E8
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2d54b936ad9so2302354fac.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488127; x=1747092927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofxeOZ11fDdJhuiPTomVaPujzzEJrfOUodUkmpcHzuE=;
 b=JcSEBIGtxmaGGC/XZEyOS4iRILdhGUzxpehhI1N6on6cIyx9Z0n6q1L/w+D/FbPl+K
 bPvuIF0OnQjxXP3ORNs57HPxOv/sXnMY3idBi/LKBQ4wavkHLP74HzexFB/nRmls2+Qd
 Zt9t0uRszO2quSKAC/2eieI/va0XKEt2v/ij0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488127; x=1747092927;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofxeOZ11fDdJhuiPTomVaPujzzEJrfOUodUkmpcHzuE=;
 b=ws1Zj2CXdhCpYBzUn+mxGMC2MfKJc/vkYMGvXLFBPAZ3OiDETn23Az94CgRX1WGxO/
 ZghGX3ua4xYi7UmrPl0HPvdf4wr+kduDTp1bYoKlvyXioDs02Uqu/0aP70ntfmNJ9fRB
 ElU27plblR0VnN9msggi5PIMPUCAswpLMuQN/J0GvIm7cM2dI40OkWuged91WSeA7ER9
 puGmD7nJ2fJBqio6K4BSEh8RUmpt4gVNy6BgQYLOFhWcYus+Hi69ki7IxHZIVSPojcQp
 TaofPDyrBNlqVdFkPwFtF7pkJjcomd4WFrgRZ9oOSbS36qDyABVOjNa2B6xfMJ5HfrhQ
 S24Q==
X-Gm-Message-State: AOJu0YzZ8CP+hvGJ2S5VPSWx7DhsqR/ihtt5CXZPKAPuA6TAZt68ghn0
 OwRJ/erKzC2ZSxtRf/MJgAyyotqpVBWcLlPQwDJbRe5EjKlpQRUQAT/bi2nk5cgSKytQlTIzxFb
 G
X-Gm-Gg: ASbGncsaRPlzj/ShZmmslBXacDPak9OuJTlaI8EE6qNMfO87oUrRthgqBKAmN81d76D
 8I6QzJDiBi6AKoI9vSh6B1TMUY5677pTvc59pUmaNCBSGk72towjs40svok7xPIepJhY6EAVQBp
 ThYrpnMSG+kdkD1p62hBc9yZScrwPQXH8WQ6j/p3c14u1Z+adtJ8rWsc5H4H3/qmGExkEq+RASa
 nOILV/fqhj47eRZYkF7/YNRxakNLyPyZJ8nQEr5A7EqrrLQbNCJMZ/fnGlq9RC68bM6xyQ5HFOP
 36WkpyatrSMCf3H/hdlQcqTOwRoBFYzjupv1O9rxW0f/kZeBv6W1M0e7fz2YiWrjauP8CVh4Gye
 g
X-Google-Smtp-Source: AGHT+IGpaHAEnOUZx9je0jc6lk8+A/ZDuKPMJT3464581NR+AUByRDJKM0YtT6rqQNiKd8UFKcAT1g==
X-Received: by 2002:a05:6870:f694:b0:2cc:4516:afc6 with SMTP id
 586e51a60fabf-2db3d1625e1mr524332fac.36.1746488126913; 
 Mon, 05 May 2025 16:35:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, ZHANG Yuntian <yt@radxa.com>
In-Reply-To: <20250427230725.46236-1-benwolsieffer@gmail.com>
References: <20250427230725.46236-1-benwolsieffer@gmail.com>
Subject: Re: [PATCH] Add HOST_ARCH detection for armv5tel and armv6l
Message-Id: <174648812551.69658.5745869503839699461.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:25 -0600
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

On Sun, 27 Apr 2025 19:07:25 -0400, Ben Wolsieffer wrote:

> Since 7506c15, HOST_ARCH is now used by the EFI loader even when
> CONFIG_SANDBOX is disabled. When cross-compiling, the Makefile defines
> HOST_ARCH based on the cross-compiler prefix, but this definition fails
> to cover some common compiler prefixes. When cross-compiling U-Boot in
> nixpkgs, we use CROSS_COMPILE=armv6l-unknown-linux-gnueabihf-, which
> results in HOST_ARCH being undefined and causes a build failure.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Add HOST_ARCH detection for armv5tel and armv6l
      commit: 03f5101ff50d1b449c65a4483c725b4ae0446c62
-- 
Tom


