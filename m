Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A64EC54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 13:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7826A87D07;
	Sat, 16 Mar 2024 14:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="azObyzIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 456AE87EEF; Sat, 16 Mar 2024 14:54:38 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E19287D07
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 14:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412e784060cso23911215e9.1
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710597275; x=1711202075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kt/YjxGxxxRTEXNRaujnbBUr5TtFYZAAACdznTR67QE=;
 b=azObyzIcGScu24pJXWrdiUNQz1ExDIZx+XWynsTuepFgiTTLy+p2zRnyzLdZ4jDzdb
 aAss42SoIDM/o+ccMiOmuohziz5w52hW3sRgwzbI2n8DTbL+gawDRbOxwB6D554WxKMH
 Rwl8/k4oHIZhT57CqVdpUH//pFw/vAs8kJKHbJdnaUyKQpwJn8nlt6VjMnDSZtZlQZdq
 +A1Y+4z0iB5x0DfCb+cjg/E3swiMdSjXQ3THXQOmipp9u3HLlwHFV/rXX0b+ia1JP47j
 zp5NDWwC5hOZBFhmNKtBRibpQ+yxf2xmbvYS61YIEvnxZjcxUri6vsYH2z0Z8eSYsf0m
 w3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710597275; x=1711202075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kt/YjxGxxxRTEXNRaujnbBUr5TtFYZAAACdznTR67QE=;
 b=mqNJvlFYEV/kGHLk0PmQbK9Te9y4/u4LEHbWwCSrggkimnN3b175VpBSXGsfLZMG5o
 1uyjdPfdakftNFjAlmAD6VfZ+sKDNksh2UdvjuWwAmr6dEznyG41wlZO6w6LeDnP4qNd
 HbVlYAqg63nIgGa9fRlCNmguHDBt0LrPXQOBO2HZxN/RrjxP3pJdwqpCE1Uz0mN+lLm1
 uJLbGkDIq9+4OM+xKozLoa/IEzDmOXFMfbS+UUHCWHW+Y59OZQ24+OpiNN926UmyGGZe
 9fR5v81mibJNtgO4g/6hfp9PnxGheAAdrVN9X4U7V/3uCK+sgJBc5OZ6SGot6Tj7rHe5
 2yAA==
X-Gm-Message-State: AOJu0Ywu3FfVTIVGUeuhy5z3xFUC5/fAc5riWPD0FrwSAz5/tp0c5eNC
 XxbobPsQTQTeMxVnz7CNwUBZNGIYNOq19gb7F6Vvh6NDTUG7fLqTHckkwn7clsw=
X-Google-Smtp-Source: AGHT+IGYxko7SOhWbl0XhbZC2hlDbIu9Uyg0oBzjsgz5cMhOL4IYHGlOEO0cArEepQ4PLNvpMrDW5w==
X-Received: by 2002:a05:600c:3505:b0:414:630:26ba with SMTP id
 h5-20020a05600c350500b00414063026bamr1928214wmq.15.1710597274911; 
 Sat, 16 Mar 2024 06:54:34 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0041409fa57c4sm523963wmq.34.2024.03.16.06.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Mar 2024 06:54:33 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] ARM: dts: fix Ethernet and random MAC's on WeTek Hub/Play2
Date: Sat, 16 Mar 2024 13:54:27 +0000
Message-Id: <20240316135430.826898-1-christianshewitt@gmail.com>
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

In submitting the original patches for WeTek Hub/Play2 I appear to have
squashed an experimental change to place the u-boot.dtsi file on the common
board dtsi, but this was incorrect and results in broken Ethernet. Patch 1
creates per-board u-boot.dtsi files to fix that. However, while the NIC is
now probed correctly this results in random MAC addresses. Setting the p200
family in board configs also does not work, so patch 2 revises (overwrites)
the board init function using the same code as VIM3 which reads the factory
MAC from efuse correctly, and patch 3 sets board family to ensure boards
have a static MAC. The alternative would be to create a dedicated board
definition for wetek boards. If that would be preferred, let me know and I
can rework the changes to do that. And apologies for the mistake on the
original submission.

Christian Hewitt (3):
  ARM: dts: fix Ethernet on WeTek Hub/Play2
  ARM: board: meson: update efuse MAC reading code
  configs: amlogic: set board family to avoid random MAC on WeTek
    Hub/Play2

 arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi | 14 ++++++++
 ...tsi => meson-gxbb-wetek-play2-u-boot.dtsi} |  0
 board/amlogic/p200/p200.c                     | 35 +++++++++++--------
 configs/wetek-hub_defconfig                   |  1 +
 configs/wetek-play2_defconfig                 |  1 +
 5 files changed, 37 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
 rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-play2-u-boot.dtsi} (100%)

-- 
2.34.1

