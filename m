Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F2C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0047981016;
	Thu, 10 Sep 2026 14:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2IU5GjPSRQ5l; Thu, 10 Sep 2026 14:04:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4E1DF81007
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049081;
	b=iY9Ko0/t2atzIQsi803qCDOs9l4N+Aa7LjglEr4CGkX89kiCBpkUa3FiwXMN8nU7oI19
	 XYwuXPF2eA7vEpA7UwP82homBDHgaV01RXThHqjEM6zgzOODYXL6n6N++oBZ60qWSigS/
	 kclf778xV+9s6DMFZEhWL99KORJsLMlNSL4AewFUvI55RzHpvW5+SpQ4n5JiwjtrYa2HH
	 c+Cu4O5lzsSSIgHFlfI1yI44LHHVHMMUKUizx2HISlwbdQWc1OVXYDWcU2/tzCvmvQQAV
	 1AHU90e7Ij5GRN/Lorp7/UVd89e/O3dC1Jf4y/OIHp6q9yzHp3LtJKjJCmwF2cv+vFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XFEWh+b6o54yndpoClMPgSbCJsVRfdLX8+HyvHs5lv0=;
	b=MnLAFlkT/8t4217UWc8DgHMj7bmFsC2lFmLVo87orrCAj/Q9xSqMoDVRixX2W2CPjh7Z
	 fHH80qbQvM3LOTfLVONnNtK/WS/wD9Rxr9bR4idMa88lW3qa16yc2MgYcKYRhvsWeo2YP
	 HFJL5vwqsaHnwzK2lzDFV91ZLnFuRK5x8uQOvJys0IROsffo2RBCO2BnMVYNxfNvxyLap
	 nzz2pnUyheXVKRsa+2hDXoMoZ87kORUQTCMcxubbUpRzJq8xj1EWtyj4c5aYZwlLUInxv
	 WoHS7A+QiIO0XBVp3HnL9SOGzRY61oS/8z4YE8jVFVyw9+Tvs6Gjx32AKTZ1g6Qpsww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049081;
	bh=XFEWh+b6o54yndpoClMPgSbCJsVRfdLX8+HyvHs5lv0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ReSYLKx/SYGitrTNVDdrMmPFeazBWzp2x3gKhAgjf8uXq39ia8epsvMgVop1J/xgf
	 cxjO+FegI7kE0c/PPGO2o+rZfoVMT9Z6Q5kLyGLXMx/hhvukBTk2IpYoDQYktMlP+P
	 Y6cDQfHmlJkyjK76qXnpBI5OOSdMk8BhrShjgRUR6VYBXS1kdFzM0GPI75avS72Nxw
	 IdFBrSjmF4kfmRSfIglHYnGHfUChGAzduzfQHI8LAmvAtCbSlvPr5RgLJzBhwc2bMN
	 1xJ2NDAvKRNQYLryFxk3xC7VMjtafkdLAXV/7uyIS7Hch9q3P3PAmK5Y9nOiCvzV1x
	 IXBJL6hJjrhlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E1DF81007;
	Thu, 10 Sep 2026 14:04:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2F28E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98880401F0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KB235sxwLHh1 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DD18E400E9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789049079;
 b=LTiLIixFLlY5UE87VG+H4rybhChrBxMyx0wt50qbnQsp9VNerkxq7f61ZTv30NzlacRp
 uXApb1tGrzhYLo/g62uKYsMsP6pl5rVgr/XXYiiM30lz4xSrUr1OxN4SUIy1dNN8jeU2t
 cMob3zwIGb8/iy09e4Q/FIwyWvYYG3XiLnnQmxjKHbRTe4wXZUNpI3P145ngHUjzTN/E7
 pZDke9pRXKSWK3SKi7Ismdw1rUFcuIJIrgyBgtikh8fx6+EWYIlH45JYzxEaZGYCQGrbE
 vnO5NBYICRm1VAZx1IxcZO29bHACeE9I+k6392zKHXIKjQJhzes+3wh5QJIAZipBy5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049079;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=XFEWh+b6o54yndpoClMPgSbCJsVRfdLX8+HyvHs5lv0=;
 b=gEAZn6XT08BWY5CMosSSvnKlyPLv5lJhudxsZDz7+MuOvwW3KOp1BMFdsB8CqPcBe4cr
 LYUMlik72Kgqry7yBCJrtBI7Hx6Xdt8Ft38YGPUgPgvHvF4hmzoson7pYdHXxXLkpjb/0
 Q7l7Df8+TsEkLD5IMQpkHaedoaknkMi4DNpyNHDKuBJAENlisKnws5a6FWUQ8OpTndXt2
 W5GuJUSIEacTj5CziKbWnFLnWXVKSp5ILzXyMZoUDuYy94ioUFe1x7Zp2YF54cCnY2nAN
 rJeIFK0Xwcjf75t9JcFXUJrQw5GIgqq+hD/IWZGT8KKTufYh7YymS2w3xL2x3Slj5Ug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gPIERG0H; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gPIERG0H
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD18E400E9
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:04:36 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4956869750eso64361725e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789049075; x=1789653875;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XFEWh+b6o54yndpoClMPgSbCJsVRfdLX8+HyvHs5lv0=;
 b=gPIERG0Hag592CR67NROpQ61NJr6KEEZ8m15SScQ+5Hy13khpuuji4MCm3qFzHNuY1
 wvO3CLhSzoqwqCfsJD9SfyyteIlfionItpK66rWaVeBTlbivcHH4ZPIp63Z7VHCuqeBR
 eEEURrofHTZi2B49h71yH/zMATaqc3yYgEtdXYKFmEyK+lM+2M/Ly/QTJjUH+1KeawL1
 GBXQ+57gq0MWw20pm5ndgOezcYKy1pCu5M75mf1Wu7qCsZ0nkNugdRTDqw1WIioUBmKp
 SRyZglHuMinQ841G8iAircNPTe9a3wV4SjgpC+CZRJMcwG2JfmPntMFbfKLIscjn12ey
 rXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049075; x=1789653875;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XFEWh+b6o54yndpoClMPgSbCJsVRfdLX8+HyvHs5lv0=;
 b=qzWYQHGO1y6u5+9eFfJk8DQZ+HVH1DSAmo7CI+SVIHV3pfxjL6EfHKzASnEgqNZOMO
 HxanUMd0m+quL8PRLZ9Yhot8DItG4Q7OsGg2bVpUrTrlpvpzRQ+PKTNWr99dW5AxdBUs
 Uz2tImz7N+b9gfdojhg5mlBwoY9clFd5//fxNI46Ft9LZMPu+Edxc3vc7rRc0gG187Ct
 yYOWll4ztxRNJvwPmqfXv2JmMGnXO9wLgPXY6FOeZt7gzaUTp4wHL5Cm0zxyQbRO4Ka5
 DZR1/otrHSTBjG2ORY2UOHEeziiUXhdeVoy9E/pGp6aq1urhbgHUAd5BWhEe6GUUTPl6
 d/Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWPT7kBs5vKNl6h5FzxhWhVoP94NnKpuJNh5X99fMMsxc8dAf1cTratcvyBP8jnl/7704fFIU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nT7sMuxzSN9SfM6zaUnzV6R4vrIlYr8qKJZK0Hfw10Z9yi4Uo4
 y1RHaQ8lid6ySPU2iFJRXKOse4ehzwfxXIXAu40w/+qnD1uS7w5iPYqFl7n3isljM/w6Wbyk8xE
 JqW9xRHA=
X-Gm-Gg: AYBFou1jLmDhDCeXLjaGKjLI1cH1wc3MFftS/+HPQqcAmwQkCIFeF+xcRcRxIK9+7wi
 DMgaSCdIoUptVM9DzXyTnoZKU1dcY4M+k9nwHKZAdUa7/bl/xuMsy08VDJ/uGQKlYlqum20mzNi
 t7uVH3HUJI5z5xgOMHglHzOg6DM8IpllLfPMD01olguVwytWJPzugnTYQAB1GPcOfmB0s2rt7KZ
 eZWSaOba/REtSRqtpzv/DYS+Jdk0gM02FYxNvxIwIOTfRBC4t1qpTaSMYaZZv6arRm53Iwhi4pY
 psmtzflHg201SLgy9Iwb/eJoNUDVWREbg4e0n6eCQGXV6z9KwoasNpMyKmF1hCwvQs4DYVedP9n
 djymPJUU/u4inNFabxLYMu7cb4MHV6H6LV/gnILhojxnJs9hLDUl1HwbSkp1TYy0Lq3K9VqwfT7
 WuoqjdB85MBUfKLc4wLRQai2k9ipRsWn+S8tEak1oLS8F513eni1T0mJfe0iQJ
X-Received: by 2002:a05:600c:628b:b0:49d:2856:fcf6 with SMTP id
 5b1f17b1804b1-49d2856fe91mr48067335e9.15.1789049074679; 
 Thu, 10 Sep 2026 07:04:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20db6e76sm147660745e9.3.2026.09.10.07.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:04:34 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/3] configs: sei510/sei610: drop Android support
Date: Thu, 10 Sep 2026 16:04:21 +0200
Message-Id: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOW4omoC/yXMQQrCMBBG4auUWRuInVaIVxEpsfmrI5jIjBah9
 O5Gu/wW7y1kUIHRsVlIMYtJyRX7XUPjLeYrnKRqan178MEHp3iUGYNBhpiTFkmu60LgyBNzz1T
 Dp2KSz396Om+29+WO8fU70bp+ARUQmGl2AAAA
X-Change-ID: 20260909-remove_sei_android-44993a3f3353
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Remove Android support from SEI510 and SEI610 while retaining generic
board support. Both boards switch to meson64.h, leaving the shared
meson64_android.h header unused, so remove it too.

Fastboot remains enabled, but "oem format" is removed along with the
Android partition layout.

Build-tested sei510, sei610 and the four Khadas VIM3/VIM3L Android
defconfigs. Both SEI defconfigs are unchanged by savedefconfig.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Guillaume La Roque (3):
      configs: sei510: drop Android support
      configs: sei610: drop Android support
      configs: remove unused meson64_android.h

 MAINTAINERS                       |   1 -
 board/amlogic/sei510/MAINTAINERS  |   1 -
 board/amlogic/sei610/MAINTAINERS  |   1 -
 configs/sei510_defconfig          |  10 --
 configs/sei610_defconfig          |  10 --
 include/configs/meson64_android.h | 279 --------------------------------------
 include/configs/sei510.h          |  30 ----
 include/configs/sei610.h          |  30 ----
 8 files changed, 362 deletions(-)
---
base-commit: d4152edb50356338af994d1c0483f65b717b4c15
change-id: 20260909-remove_sei_android-44993a3f3353

Best regards,
--  
Guillaume La Roque <glaroque@baylibre.com>

