Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F10ECFD37C
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 12:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2788929A;
	Fri, 11 Oct 2024 14:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SKHM0d/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32EB888B6D; Fri, 11 Oct 2024 14:32:22 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A138929A
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4311e470fdaso5614295e9.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728649938; x=1729254738;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AM4pDuZ4YyQV3jonPV/Zs4djs0ZZNjzL4AeW3fXTHhE=;
 b=SKHM0d/fLDd4qtEmHutjMvYfUA6d5I5sjV3s/eyHZQlJGVWa/SqLE0ygd5i+CLfL9K
 y6U/tsKxB0X/RGpVyz84khthrZRUPwoCCw5oJYNgSPR16JnGyI8HqDf/depTHEKbYtIj
 ILFML6i15TulEQbbUGO6tIpGoNnEB83aedSXQep6QTu6E2eZJ1H1ul27veutvckg4zLL
 1+YlsJjqxvtd8/IF4UfTJNx649nP2rb7NbkdhUtNtfNjKSeXbD6bgkGLdxbXL7So8Fbm
 hte3uoaFLunMJVX7khI+6S4QgXutJ8GZYN23/15e/NncOVvZ4n4GrG7Kj2PnLHZ6XLJn
 RnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728649938; x=1729254738;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AM4pDuZ4YyQV3jonPV/Zs4djs0ZZNjzL4AeW3fXTHhE=;
 b=HsVxldnG7BJds0MWCtL/CtLJes0WG45baxfbcRz8WJP+nlBRn01kGfeLmI1zp6XjwF
 ORUiAKTmpprJYAGKKtgvKcs5Luvcs4ngLxV1EtYxZlPGWNvU4xsvSrY0deYcrWxlXrR5
 Ea13O+BAjLlMbZoRBhPTRYxEGe/R+ZXdOHHjFS0k9IXv0C0V4kfSBh1bhnAZuwGP2sXH
 dY7kz1WpwLvl6Jgap3cU2o7ONA/51kXMIFaLFvyl6Dnq+U+jI42Hx0GByFW+iTuiAyL/
 mSdsfNEW6f7l5ePw5Hkwll7kv3B1vw4PoBYXrc7MzKgc9ZJXtLmvxHYFX8KFHYuPrDwE
 8f/w==
X-Gm-Message-State: AOJu0YzTqovSmTX8q/h8GLqN3iKK93E5kcfr1PPM8AeRpAAVFoMoieCk
 zqDSmY8XhyChoGkm1Q7+YcGe+q1YFR18eX3l4WopZDJoNShgxB54FN1oEMiT9T0=
X-Google-Smtp-Source: AGHT+IHqtYgwfESpPTpV6Ecz7gwXe4fQBalFKT6Bm8BJyAc+Kfk2nmrrXIFDeaM6QCYKIADXtZjiCQ==
X-Received: by 2002:a05:600c:3551:b0:42c:bd27:4be4 with SMTP id
 5b1f17b1804b1-4311decaa3dmr19486185e9.8.1728649937808; 
 Fri, 11 Oct 2024 05:32:17 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182d7934sm41256095e9.3.2024.10.11.05.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 05:32:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Joshua Watt <jpewhacker@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20241002144845.1439316-1-jerome.forissier@linaro.org>
References: <20241002144845.1439316-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] Make AVB_VERIFY depend on FASTBOOT
Message-Id: <172864993666.10555.11542214223967407652.b4-ty@baylibre.com>
Date: Fri, 11 Oct 2024 14:32:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Wed, 02 Oct 2024 16:48:45 +0200, Jerome Forissier wrote:
> AVB_BUF_ADDR, which is under "if AVB_VERIFY", defaults to
> FASTBOOT_BUF_ADDR. Therefore AVB_VERIFY should depend on FASTBOOT.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] Make AVB_VERIFY depend on FASTBOOT
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ce1023de730ffa37beae46a5276061a74a041a09

--
Mattijs
