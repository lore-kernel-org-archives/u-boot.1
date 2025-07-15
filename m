Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BDCC83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 17:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA188307F;
	Tue, 15 Jul 2025 19:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PlIYdlMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5DD8309E; Tue, 15 Jul 2025 19:20:26 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9362E8307F
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 19:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73e6320e767so193988a34.2
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752600023; x=1753204823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCx7jyloADwVkTK/IrgCQXMmqy31BE4J8IB/VEK5Mhc=;
 b=PlIYdlMAMz6d9jq73hFniri0b435LhtXPus0m8Lj6vdsiuWJw35FL+dQZTaMkXG2BM
 Q2dZQcP/vH2umeQXQCQiW3r/k7ARIIwsaM3nuqjIidAJ96LBXLk2x/Fj0nlJvXaA0k0A
 JMqLknONjNE0yLnlaniY9qE5h5jtTe4r7d/Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600023; x=1753204823;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCx7jyloADwVkTK/IrgCQXMmqy31BE4J8IB/VEK5Mhc=;
 b=FdHPJbtMRnD+4DABPLDHWiLtMFFuomQU9jiJ6EKFGkZ2TY1Ibh/+XhfQk6jY7ahpLw
 B1CGLV2m097EBiv1faEIRzdrURafgF8iVEAN1ljxVpQDOBYHqARdq0GTskIbAGAsxaUF
 6WRNaQzl+Ta4N6ahqIzmcv926rUlae77gigJjyT8N/kYS+v50MspT5RPID+ZRXEGmTqg
 HpjmfdSiIXYTb9sCqWVF5avFWz2f5r/dJp+LZpjP9eGtHnHxTy9I2dQHw+cN0u72LRbW
 ZmO2yUyt2MrvBJFoUCS+hcTARaRN0CnTg/bszbr0EikE9DjcsIdlfYDAr6Wlue4QOxPc
 FZsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIJsgcs6muxJLAplkXej+GbOGYCjws4P1hq2l0oDQ6L/NjQRYJDjuqTtSSRclPluDzJNxhfTI=@lists.denx.de
X-Gm-Message-State: AOJu0YzhXjy2x9hwiQXZADgXwhDrCeBUUCUMxuWHfvVIgJMgCHdpgyJh
 ooZTOeTdq+C+nVFL2vyYAsbN1PIL/lBJH9NHMWzeP2/OgTIySYG7KiCp4MR+W5CiJI0YPMg4FUl
 bljyamxc=
X-Gm-Gg: ASbGncubvFsOM/aqOh3eOZjjC2pQ3+/cZr9EQ9oUwLn+WgEY9QrBpoJUcVLdLxBaCSy
 A2go92lTP3dWnQbPnhUy+06CmBBRFgT+MaMXUKf98+S85r5s2xUzriuJLK8DJytj+CZnakWEN0i
 8sR0VqpEmpsT/jwd4WOX+UhYB8WKAKiirerm0w3hSJN+NbdVP/Q5p219lu8zUX24l3+yuV3R4iC
 ctekxsUkMtyX14TudXIZVIm7j9Ja5i7DMPpFIr5iAhhHlr5nOpQrB9J7SN5M/8DvjxecMODOIVJ
 rcxNJKo3IFsGaAqReroHFPmxtnNQBAl15WMHK108xD+koHEE+hZJ3o1DRvGzadKkQac6eFgZaYH
 5okWGYKScEUArUvIOrB0cOgwyO1/CgqCnfDQ9xfGLw1VcpiqbpqDHXus=
X-Google-Smtp-Source: AGHT+IHbWezEF71HyPAl+LlhtKpaOQaNMVoR4HlJjU1lZ8XlGWsGWkaH+x5YYO90TiKLGygri7EWhA==
X-Received: by 2002:a05:6830:3901:b0:73c:976b:6c93 with SMTP id
 46e09a7af769-73e64acc272mr289014a34.21.1752600023367; 
 Tue, 15 Jul 2025 10:20:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6142b0961fbsm988894eaf.35.2025.07.15.10.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 10:20:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Qu Wenruo <wqu@suse.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
In-Reply-To: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
References: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
Subject: Re: [PATCH] fs: btrfs: Do not free multi when guaranteed to be
 NULL
Message-Id: <175260002232.441891.16749455238616845799.b4-ty@konsulko.com>
Date: Tue, 15 Jul 2025 11:20:22 -0600
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

On Tue, 08 Jul 2025 12:34:49 +0100, Andrew Goodbody wrote:

> multi is guaranteed to be NULL in the first two error exit paths so the
> attempt to free it is not needed. Remove those calls.
> 
> This issue found by Smatch.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fs: btrfs: Do not free multi when guaranteed to be NULL
      commit: 9204cae0937c0e26fcff1ee08e51ef37f59844fe
-- 
Tom


