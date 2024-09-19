Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D094FCF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46587891A3;
	Thu, 19 Sep 2024 16:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NhoVUnqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063F28919F; Thu, 19 Sep 2024 16:02:49 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C1889104
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5e1c65eb68aso500369eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726754565; x=1727359365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5vjOLJoj42rhuKKkT3Qsxm9Wd1S0nmqziAOZ5yv4lSo=;
 b=NhoVUnqpfoEigxO8PPc1A6fVFQ9vtimaTZI75xEQ0RLhOQLxaHpODA4ob4gMl/KUOa
 150fnZ1PUy5+JuVOyHyTRqJzcGeZhxWwTXrfSn4ul2GiS201DgeW2ocJb9mCNcZKSXgo
 k7nT6jzDk5xLTkb3oVOOyWNpRY+5XIHOiBFCCRH1BiWDmDKg4GYrvEbEHqnZA0qQWwEv
 ohHXlLSNivYRTA3SBRD7XIWZEo0EbTepqZvgZ97Dypq4j4VQMHGe/35Iqp9/qRgwJjOB
 dHvamyZ6tV+iT7J/0DwAoRg1AP1O5S1saPYgqBmRudGzbrOd2tskTqRF99EBdzy+sPEd
 EjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754565; x=1727359365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5vjOLJoj42rhuKKkT3Qsxm9Wd1S0nmqziAOZ5yv4lSo=;
 b=JiKxKpvxHfkEr6HNHY2icxLGL+4C3/VCiOr1rY5FC2eRIAMaDhTm8EJ6+IQPjyI0C9
 t/NZf41SCjEoVZnaDcYGpB+jYb4MS00njct+0yfuhT5dR+E1jxpsA3QV17VEpGjMPvuU
 wXeM/sXNQ23VPpOkmUaiEbi1dx9bz3dkjdP/ipvbcC9XSxizmnv6xkErOBuCLfM3Eeey
 vdz61f8Js1iHBROo5fe2AzRbpLDhZncI0bd3erfwI/9emYpF9mlicWKjn5zT42Vfjr8M
 3+5RxBlvVvDSKf6plLKVSvPNn8BlM38Vg11HXE2g8m+744PLZqL2Ws49svUpKUr6SiOb
 vVsQ==
X-Gm-Message-State: AOJu0YzF82i7M8tSFBo8pHZTgUdII5HEkQiJIRz3bZCS1e+o+88j5Ib9
 vQhyZeTsOzIdzjOWo8pKSwiL/QHzI/UYZNFXYQ7Ccfky8KlM3hs1KK4dTAUh
X-Google-Smtp-Source: AGHT+IELczSWASJBjopLt9Bf0/TgmEtQOZswu3BJW1HUgZUdzNSk8gPTevMo1E+AYiFJQ9cbQDvJDA==
X-Received: by 2002:a05:6820:2226:b0:5e1:bc6e:52e8 with SMTP id
 006d021491bc7-5e2012b96f4mr13299841eaf.1.1726754565159; 
 Thu, 19 Sep 2024 07:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5e3b0d6ae98sm1941649eaf.5.2024.09.19.07.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:02:44 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 quentin.schulz@cherry.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 0/4] Anbernic RGxx3 Bootloader Fixes
Date: Thu, 19 Sep 2024 09:00:18 -0500
Message-Id: <20240919140022.511067-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Chris Morgan <macromorgan@hotmail.com>

Update the Anbernic RGxx3 "device" to use upstream device-trees,
add logic to detect a different vdd_cpu regulator, and implement a
fix to allow the panel auto-detection to run when using mainline
A-TF.

Note that *Linux* still cannot use mainline A-TF because of the missing
SCMI clock and reset functionality, but this patch series at least
ensures that this board can boot once Linux is ready.

Chris Morgan (4):
  board: rockchip: Convert Anbernic RGxx3 to OF_UPSTREAM
  board: rockchip: Add vdd_cpu reg fixup for RGXX3 Series
  board: rockchip: Remove ARM SCMI Support from RGxx3
  board: rockchip: Enable PD_VO before driver access

 .../dts/rk3566-anbernic-rg353p-u-boot.dtsi    |  34 ++
 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  52 ---
 arch/arm/dts/rk3566-anbernic-rgxx3.dts        |  28 --
 arch/arm/mach-rockchip/rk3568/rk3568.c        |   6 +
 board/anbernic/rgxx3_rk3566/MAINTAINERS       |   4 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 359 +++++++++++++++---
 configs/anbernic-rgxx3-rk3566_defconfig       |  12 +-
 7 files changed, 347 insertions(+), 148 deletions(-)
 create mode 100644 arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3.dts

-- 
2.34.1

