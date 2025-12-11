Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F4BD41D69
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330F483655;
	Thu, 11 Dec 2025 17:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hYf5HQEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 914B883A28; Thu, 11 Dec 2025 17:54:00 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0FE83642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c765f41346so173144a34.3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765472032; x=1766076832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+V3JTuzAI2t+lWSdWkKP0jyA8Ulz+ZeZQW1cmycs4w=;
 b=hYf5HQEZ7Ud8/5EVpl695ZfXKOTy8vmnDYocZGYRJGj9MuJJbqdVBOpX/dCo8gouEe
 kWip9+LCZkhH8eANo4z+5pVtbeujIgVcCopTCgx7CI3GB/R6nmmcyijFr+hkf2EBjwL1
 lbnril/yVuc81B+j3/N8bA3XdLk4doAB0RsVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765472032; x=1766076832;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+V3JTuzAI2t+lWSdWkKP0jyA8Ulz+ZeZQW1cmycs4w=;
 b=oYU+tAG5fFIr4UvIciudcpsOeF/ew5w7GD+weF9J45/ewYv6+ofwaNVIjD6rtu2pxg
 CKdXgaOOxMYkv7vYMYNsdi+XLS+rWX1iykxHGFvxZ1K2h4nDVZd3u2CbYd1BbwxR4f+X
 KfHFlnB8oZniAvNQu92K4sXHo2aARyR3gOxzC1yiRL96oFPsG3sESLCnkufx0CF7I2L4
 zHHAyoN4B0uoMvgUZjfRgNAS1mc+OoVz+XKOWw5rGWjcl3pT7dVNEpWF1l8rYuqnCCzT
 3s35hH4oCf6c1IwA+KCYAy8AZl0IK9zSvAWc7OX8dw6xwo+PDir7elo4l+GaJTUnP2Hq
 aKMA==
X-Gm-Message-State: AOJu0Ywzv2LUHR5HDTPP8cJhlfeeihmVbmlQg8J2sSXd8vWlsEiQV6B7
 RV5co9khforFnP2sKQH6x1hjsIoTXyNZh+UIaAGDRBTJPZa0/zl+l7Psesn0QwI8F428Q0oZKQw
 Ch+/+MeY=
X-Gm-Gg: AY/fxX4uWY/y+nTRhkKerJA80kBZgBITrRwx9k0UFSt9uMQOV/lM1CGPTaTgqXZAsNX
 M7sMJaKOJLsfZJHopkoG6REqukh7i5cyCaVzZ9sC9Q/H75qDrLSaI4iXDEwfK0h3/SpibSG9ZrS
 SyLmdq7eRVG9cX2ovrV6t0O7W8u+ROCPae/yuoEhou8vAy6SmFZERvxkyIDRod+6ReLR+e4oVB0
 NAS0Csur+sf1Hysx53clC9xZDY9eEuWOkDiy+QHSkjPSZa1YGmgId4tKtuya5BD7M3EHbhymWdA
 /amTtxIybtKvpQqdoVY+2Ep8ZuDnFwxf/7dT1diWh1gR8B+bAq1iJoct2ZXXzuoilsutbRbI3Wv
 4xP8nNxeuAfd9S9T1hSNsVexOkQbtZRs2+pq2+IZgZMEEO7Yl4Ev28BER1hG94McsyOQzIXHnwW
 BghaKEiYBSkww47cOpPo0nqehmXpWwpZUE1Wl8AtLQrJry8IFG
X-Google-Smtp-Source: AGHT+IE901T7Vgm1vcSrgEo7YgI+L5O+0OR48Ien7EJHniCnhITy3aChoxXJsTzP0rt1Pb3gGeGcLw==
X-Received: by 2002:a05:6830:484f:b0:7c7:1c77:f107 with SMTP id
 46e09a7af769-7cacec4baddmr3437922a34.34.1765472032398; 
 Thu, 11 Dec 2025 08:53:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb34577dsm1739686a34.30.2025.12.11.08.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:53:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <aTq-PI6p3NPbdUMQ@nxa18884-linux.ap.freescale.net>
References: <aTq-PI6p3NPbdUMQ@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-next-2025-12-11 for next
Message-Id: <176547203185.772226.1322057397807231749.b4-ty@konsulko.com>
Date: Thu, 11 Dec 2025 10:53:51 -0600
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

On Thu, 11 Dec 2025 20:51:08 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-next-2025-12-11
> 
> -----------------------------------------------------------------
> Stop disabling device tree relocation for ls1012afrdm and ls1043a
> Address error handling in ls1088a board setup
> Remove offline cores from cooling device maps
> -----------------------------------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


