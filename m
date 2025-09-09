Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D60CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 22:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26B983252;
	Wed, 10 Sep 2025 00:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZFFjsgXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D9583252; Wed, 10 Sep 2025 00:57:44 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B3F82B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 00:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-88432a1ed9aso1091939f.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757458661; x=1758063461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVEGpiNVOqXSGUmePlTg+wy/2KG/8tyCVCcTKk/INeQ=;
 b=ZFFjsgXlohMKFeQRh93AxgmR4fzJiqM9GANffF8CPPU6uGPC8qLw932b8oQh/5HFEP
 mlPGdG5IvFjwzIB9wRbngTEaQQMzRp9XKdkzb1SstMSIs4vJ079gOxALZJHNVjlSbT34
 bhxIUlAfPhjg8FdkDiGvWj6OmFdGO0EGKNtyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757458661; x=1758063461;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVEGpiNVOqXSGUmePlTg+wy/2KG/8tyCVCcTKk/INeQ=;
 b=lY0gIE4dE5KmXmrA5FKjeJqQ06mm+E/OCbSYOKYwFi090fW9sPhrQ0s1AOXCWSuVqT
 VnAMVIx6X3baVsshiaSCk7DrzRTCkCXEHD6HAD8BtiF3yZ8B0lhY+V+pkR9Nl1VanRVr
 NYQ4lsD0ecsIjl1mZCAvQdMX6ZDDnGFjrX0XFFE1NsELOzVO2UfFXrXzBedZTVSokDao
 tpz2gWtfxvykSAiWBp3Gjrj3ZyWRvYxzDH9mNDnh3AtVaOREPCmUBxp+XcevDb6woXAD
 HWGS26qImWB7DidbIe0zXO+3AtSMEhcWuAO65dW4mprTRR5CMDF5o9VruQ48OfCfZa94
 fSKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUra89hfYk3FF37h9bNTIneteF38Asd9YNnqusGaXPHXgg7CYsekpywon94kLN77LjFtF3RJpw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo2NB1kFwzu+7zXqtl5iM7WXZL3b/kkklflUh2TzKxAdwUku++
 QCzWuIVU0lZvdZTQxQOnK5rxZrzbg6ZXUUDZMi5nRrXmYseiAvJIxdvWzO17EZOUMzo=
X-Gm-Gg: ASbGnctXhtnHHDCjUBGtYjE3WbLVbwtZCy14S995Ensq1WFr6YhLbL03k1jlbiJvkPS
 bvXg5mJCb5JvZS1AMcP8tfHjGFkjWHmdLp6vd/l3bHQUrhYul/AKf9n4A3dMvZD7IK25B026fOQ
 xBVHIJS4TdVCZK8RaglJnijlFnMgXHA7bnkFzip+hh+eUvVGuAuS9q3ftSCeOwN92VUXfagrobr
 sr7BS4jtfYLqXMvUEHU/8cP/NRU1jxxZ4KnLdiD92ISsHmB6mi9FoCE3VT1WZO+RN3tGrfN9Jjq
 Um3qCdn9eIHv0hgKkqK2kz3NsslIdsvhzD5+GLI1tcjPL6SvxreDlEo75sW8MLlSs9dLlcrr+00
 G/T5sCCIxcsCVe4fx84M2CPst2PMZJK6YCId0+z8NRmRX8749iLsQcWO+4GhoEWHxEw==
X-Google-Smtp-Source: AGHT+IGL3aUoKVwO41lQfYUbq26ABbnMXnky12PLC16pY7scynIWkGxTnBBW1jc01dtp8CAv+zDhZA==
X-Received: by 2002:a05:6602:1505:b0:881:8a24:5598 with SMTP id
 ca18e2360f4ac-8877797b029mr2137521839f.1.1757458660926; 
 Tue, 09 Sep 2025 15:57:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88c31dee466sm195844039f.7.2025.09.09.15.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 15:57:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Daniel Golle <daniel@makrotopia.org>, Maks Mishin <maks.mishinfz@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>, 
 =?utf-8?q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
References: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/8] tools: fdtgrep: Mark util_version() as static
Message-Id: <175745865900.1836956.17213981524531035967.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 16:57:39 -0600
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

On Fri, 29 Aug 2025 11:16:15 +0300, Ilias Apalodimas wrote:

> The function is only used locally. Enabling -Wmissing-prototypes
> triggers a warning. Mark it as static.
> 
> 

Applied to u-boot/next, thanks!

[1/8] tools: fdtgrep: Mark util_version() as static
      commit: 3c34fd46b6efd0501662ba3f0aeff2aeac9a584d
[2/8] tools: fdtgrep: Mark util_usage() as static
      commit: 9fe4e088f3d2ba15323ae4bff7f6b592152e326c
[3/8] tools: mkimage: Mark copy_datafile() as static
      commit: 867d762bc515850b00245cbcf21cf2b2d39a2a5d
[4/8] tools: rkcommon: Mark rkcommon_is_header_v2() as static
      commit: 3ae031135da1f21ec22e20fac5d7ba9776487166
[5/8] tool: fit_info: Mark usage() as static
      commit: 5ab15814e8f051968a4da8c96339ff0c80c5f811
[6/8] tools: fit_check_sign: Mark usage() as static
      commit: 39f7af39bb2e7e03ea4621e57a976d41dcaaf0a6
[7/8] tools: imx8mimage: Mark build_image() as static
      commit: f006837eada06cdf41b9935eb6c73618e4ae0bf0
[8/8] tools: imx8image: Mark imx8mimage_check_params() as static
      commit: 1e73651a71d1cf2a718b9a8250a794d626b9eecb
-- 
Tom


