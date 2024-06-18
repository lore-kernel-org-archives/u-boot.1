Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5205FC41513
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F1F88271;
	Tue, 18 Jun 2024 14:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JoVpNHq7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F40FE882EF; Tue, 18 Jun 2024 14:00:43 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 168E2881CE
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 14:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6ef793f4b8so551622566b.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718712041; x=1719316841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8XVU8xDiM+zSWKkbRuXcNjxBRBSQxUGLUdeZZF71yek=;
 b=JoVpNHq7Gt74OKJQ/a/2hFWpbAOk/Y5I4g5NwHkadmejL9SWaSZFFZUC9iLh0GNAIs
 1AW77k+DMUGd1fU78ErxH/EXHkh+i6WePfHoeT+zLPM7YBwz4ykLZhJ/DinMxeT/gthw
 NWAkbTKsYxnC3DWNveozRJUEHLomBuHcWON7j1iaor4plDQoPRijdCmxvUIEGddYNeRy
 T0Uct4AfW6WveVx52pAnWUOJhnUEslBnhSFt54piqBGgD8yBCo+8TEFGRX3Wrh+qiz2l
 Sfus7MhW38E7qHH9C9VjhTCXGppf4I49F6f+Y6QomdklnUu7dRGAm2kTLjC35Gp2P0BE
 kfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718712041; x=1719316841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XVU8xDiM+zSWKkbRuXcNjxBRBSQxUGLUdeZZF71yek=;
 b=vAhk2OV1R99ZHuwR4xfkYmUADuZsLfxRkHoDdeLcFbKFmgSE/VFe4TsiZXOE2DJLXY
 76RzKEWDrucEKix72vATvdcL7LbEOM5tNJk/0DMk/FUpFVvjFvxnvmyu1fN8HSL4Ksgz
 Xws8O4rWW64oOdqJy0Q5pdEXw44aiDBZS4sj9Vg6sCyHI7BZg60e2f3Ozndt7ug0vQW/
 DOXX244VpfikxgWBadNFEcPPiLM+oi7m9sWAPrSeCQf38U0WrzFCScg0+ubUlgMn6qLd
 1y4a0vtDmfz+xyatdOZPgoxO1DhJLputxfQOCX2wHrheGx9SM0xp5G3gZ//r+2Ewn5wB
 Mn8g==
X-Gm-Message-State: AOJu0YwcHZ4LoyfZYPJLD7Cmyr8u7DrKIECcjcQxxOFxk16H18PxyOxV
 QRHUCDrlwyIJ9N10BiSvtwctAXaLXQWDb6VxOY8nPNjVbi9zDz+V
X-Google-Smtp-Source: AGHT+IH1Be8fOfRAjP6fes1snVrBEa06hjxIV8BFG2/TnrLisVyXNSq/elMQIMkyYYwkkI9HLo3h5Q==
X-Received: by 2002:a17:907:7714:b0:a6f:1fd6:61b6 with SMTP id
 a640c23a62f3a-a6f60d42feemr699653666b.35.1718712041457; 
 Tue, 18 Jun 2024 05:00:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa674bsm614825666b.210.2024.06.18.05.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 05:00:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Adjust Tegra boot order
Date: Tue, 18 Jun 2024 15:00:29 +0300
Message-ID: <20240618120030.41502-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This ensures that the device can boot from a USB device prior to MMC. Useful
cases are when installing a new OS from USB while MMC still has a working OS
configuration or if the OS configuration is broken in late boot stages
(kernel boots but the system does not start).

Svyatoslav Ryhel (1):
  include: configs: tegra-common-post: make usb first boot target

 include/configs/tegra-common-post.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

