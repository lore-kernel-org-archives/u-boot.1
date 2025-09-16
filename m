Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01E7CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 22:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFAD9832F0;
	Wed, 17 Sep 2025 00:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rom4TLqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C8C8318E; Wed, 17 Sep 2025 00:06:42 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B93832AD
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 00:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-74595f3852cso4211993a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758060398; x=1758665198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pncExbP47EG8udjKBTa+gZhHBycOEOtbCqCpZ4ZW4k=;
 b=Rom4TLqAWz3v3oIju/LSPlIX+WEcjPhwXqdLT+WDlRoZCDQ+bBNT2Ud/txjj0lrYof
 oo9SBG/eSynd2o8XxT6ka061hxPFLbOxLaj6/xpNAUEKgxWJwTHpDOLOEK9S+Bw0+jJO
 ZewuarU3hAqdA7yrH/2FLw53mSlXsWFa+sSfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758060398; x=1758665198;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pncExbP47EG8udjKBTa+gZhHBycOEOtbCqCpZ4ZW4k=;
 b=A+jJ0vixL21ZNjBmLU7o4h4etDs+nuTKi2y3eklZ6ABa65l1RzECTj6CzC369uX4Bf
 3HVMM8DqTtoADvx0uf+ign9E7G09DyuNrtzX7i/rFRQO6URpweOzUwVa8RptCyI5M31y
 mPsGLDRA8cXX8LxnKQQL4KipH9QuvEVyoSYb5xiTCIsOvN+xz2spwOdIaejs/JqShOgt
 BPLaUlNI9dJIEOKy/EzO/wyZpvR4FhwE3/7PW8SSAXDPZnuyGwWuKMebwntPXGZkIAPa
 ZS7Wm3LMZ9+pADmd5iaKuttqVClHcm/fH5hHx2Q+AT4Xo9bBenEKsSaa7qSlny7qen9a
 MYQA==
X-Gm-Message-State: AOJu0Yxc1LdYBIdD+ouSqKB1QZzvrqGz4JYuir5FdeH4D30kh7WELeVG
 UIvTzU6YE4+fg89Cd3HvGmxkNZkHMR4h0UHCtxvEP4ZJ4lqXnkpOGC175t6uDse8QCE=
X-Gm-Gg: ASbGncvvASMVR3g+SVAzmijuLuLYTW5pV3/u1Ezb7yMkywQ3t1oHfTY8HHrGG4MnRaQ
 1swAyzeV6zz51aUpBdO+k1LXWlx/MVsVYpE5ZAZno8ybxkxku0iGoFnXvRRDC9WRRosafodMK2T
 M/gVmO7RSiZk5XLeGmi2o6bCaz9sEIPjXmDDWZf4AKex2dVh/ZeVzidnH+GUM8DaGNbqMr8S3Bv
 Es6B/3mBtAOvVubSedBK3PE0lOuhkEc5/iqhQdHDRMh83N/0qIlAQvyAKvkw2T7U8xc0jJKINUc
 ysSOq5xBIFbGjIAy9HGuyHr88WG+RXshenwIKyg6Rn5+1VFp15tfEepupqqG2iBmy/Fhwdd+QOl
 k7PaEwkMF4JW0QkXDTOK7DHeihTE5tIBeWV0j0Zflm7KXvlrOM3eM09xJBf3F3kXs7Q==
X-Google-Smtp-Source: AGHT+IH6Hi+ac+kSaazYtmQPL8MuSG9yLlJ1Eh/XWgQ9gP2IWYEjO8ofOWV6WH9SC/9GM58sRS8JbQ==
X-Received: by 2002:a05:6808:2190:b0:438:33fd:3187 with SMTP id
 5614622812f47-43b8d9e6403mr8975470b6e.35.1758060397970; 
 Tue, 16 Sep 2025 15:06:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82a72a48sm3500050b6e.20.2025.09.16.15.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 15:06:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>
Cc: philip.molloy@analog.com, adsp-linux@analog.com, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
In-Reply-To: <20250903234205.26787-1-malysagreg@gmail.com>
References: <20250903234205.26787-1-malysagreg@gmail.com>
Subject: Re: [PATCH 0/2] Fix ADI driver header dependencies
Message-Id: <175806039670.649628.256014978936047674.b4-ty@konsulko.com>
Date: Tue, 16 Sep 2025 16:06:36 -0600
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

On Wed, 03 Sep 2025 19:42:00 -0400, Greg Malysa wrote:

> Between 2025.07 and 2025.10 many header dependency chains were improved,
> but this exposed implicit header usage in several of our drivers. This
> wasn't discovered before or included in the original fixes because our
> drivers are not yet used by any mainline-supported boards, so build
> tests did not find them. This series addresses the two build failures
> I've encountered while rebasing our work onto 2025.10 and continuing to
> prepare the next submission of our board files.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] net: dwc_eth_qos_adi: Add missing header
      commit: 56aa947c2ad6cbdf4e7a4281e83689ac3fbc8498
[2/2] mmc: adi_sdhci: Update headers
      commit: 2941e4c0476c69ef10e0900a8d9cac40a6dcc831
-- 
Tom


