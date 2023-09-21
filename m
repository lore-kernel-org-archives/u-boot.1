Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15018E7108E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F53E86B7E;
	Thu, 21 Sep 2023 17:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="U8AdE1sj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EEB186B7E; Thu, 21 Sep 2023 17:37:50 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717478667B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-503397ee920so1910215e87.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1695310668; x=1695915468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3bNIp2821XHfS5VFGkn6zLT+wqMp382oAqpTq7oro8A=;
 b=U8AdE1sjNsDmvkRoU2Aa55G0hffrbVVqREeADteev7bykH5B15rwlVjvwUlop5yX8n
 /la/vx8d3v8q+H8pd9tdYz0FwWkRn8UMIqaWMqd/xTn2GSQeSC5smYOnSnrYU/h2MnkG
 yWIx1XEEgr2goM5gNpl20DuoCchPKsK9V+H9seVBpEG77RK31bD66p3EbHrOs9mXD6q+
 wxYQv2uXDsQFnhJANtTwL0y93y6O8u0FNUkmWav/jd8+GqM3HKlSuQmFRrf4+ENcynl8
 EZq0aviX1pqYna5AUr1oyOToHkrxMrkFdnBW9H2hPKV40OpUg6nrlehyY4NAuS4lthGR
 QtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695310668; x=1695915468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3bNIp2821XHfS5VFGkn6zLT+wqMp382oAqpTq7oro8A=;
 b=IUC2NuLF5cuF+kTcCL/V5CcNPo4L+rI+ZtTcodofOGiBLVe7UKkEQUBmcYvGAXkep0
 llXWKLRtb8CfGMgoJzH+4fSCxBLO7qCBDaiv/CMrwyteY8DOU/zyensMyLuJetJ3B09g
 lhEC8ydgIiB02VvDiyKU0fDO+5e8vKUfjo2GddGWbNT+p+r5KknpkJtWk8db45Kz+/sq
 D0xKfn26HAHjNKrnnjvaGJzSLp8VU+rQRCysa0YxoKe1n2sSEKDWmXtYVpd7yucUP0ox
 LpTllf+baQKr4cFhuKWb9KOigKmEx9UPdCIvMHjA4zhY7ZWn0NMRVfZSRMsE3b9fUzLp
 +hew==
X-Gm-Message-State: AOJu0YwzjHWbxNL/46SARJyxBrc/JFja0Pe58nxc0+lJjHVD9IszsotA
 rfZISNzAgiJwEoqAdqfr9R/H5A==
X-Google-Smtp-Source: AGHT+IEEQqKKRkfwV8AXgw0T8YYELB2QgO1EgCdg5LIXh4nB7ck7edioCoOyJrHhjH/Uarsbe4K5fg==
X-Received: by 2002:a19:e047:0:b0:503:17d6:7dac with SMTP id
 g7-20020a19e047000000b0050317d67dacmr5313068lfj.42.1695310667404; 
 Thu, 21 Sep 2023 08:37:47 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 l20-20020a19c214000000b0050422588213sm331492lfc.209.2023.09.21.08.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 08:37:46 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>, u-boot@lists.denx.de,
 Artur Rojek <artur@conclusive.pl>
Subject: [PATCH 0/2] Conclusive KSTR-SAMA5D27 support
Date: Thu, 21 Sep 2023 17:37:18 +0200
Message-ID: <20230921153720.542101-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Sep 2023 17:43:58 +0200
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

Hi all,

this series adds support for Conclusive KSTR-SAMA5D27, a Microchip
SAMA5D27 SoC based Single Board Computer by Conclusive Engineering.

Patch [1/2] adds a missing prototype for populate_serial_number(), which
is used by KSTR-SAMA5D27 in order to read its serial number embedded in
EEPROM TLV.

Patch [2/2] introduces KSTR-SAMA5D27 support, including board init,
Device Tree and defconfig files. An appropriate MAINTAINERS entry is
also provided. A new board/conclusive subdirectory is added in
anticipation of future support of our other products.

Note that the "if (IS_ENABLED(CONFIG...))" checkpatch warnings for this
patch are considered by me as false positives.

Artur Rojek (2):
  common: add prototype for populate_serial_number()
  board: Add support for Conclusive KSTR-SAMA5D27

 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/at91-kstr-sama5d27.dts           | 310 ++++++++++++++++++
 arch/arm/mach-at91/Kconfig                    |  13 +
 board/conclusive/kstr-sama5d27/Kconfig        |  15 +
 board/conclusive/kstr-sama5d27/MAINTAINERS    |   8 +
 board/conclusive/kstr-sama5d27/Makefile       |   5 +
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  | 235 +++++++++++++
 configs/kstr_sama5d27_defconfig               |  79 +++++
 include/configs/kstr-sama5d27.h               |  15 +
 include/init.h                                |   1 +
 10 files changed, 684 insertions(+)
 create mode 100644 arch/arm/dts/at91-kstr-sama5d27.dts
 create mode 100644 board/conclusive/kstr-sama5d27/Kconfig
 create mode 100644 board/conclusive/kstr-sama5d27/MAINTAINERS
 create mode 100644 board/conclusive/kstr-sama5d27/Makefile
 create mode 100644 board/conclusive/kstr-sama5d27/kstr-sama5d27.c
 create mode 100644 configs/kstr_sama5d27_defconfig
 create mode 100644 include/configs/kstr-sama5d27.h

-- 
2.42.0

