Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0B2C9832F
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 21:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9550C6066D;
	Sat, 26 Sep 2026 21:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ausGuFj89gb; Sat, 26 Sep 2026 21:46:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A3D516065C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790459210;
	b=FAy0BmUlW3NcYXIBM4PdmEARBAHVhAjNU2n+FzEpGUhNCJDv4hxYiLsZhI2OHdLcDEr5
	 bgQEIPcHhA8EY3pNpkTPllV5da/YJPRyeYZsr1a5uTU1DYGVOp+UgHEBEASTKhuJHrNT8
	 rYEaAWLJjhi9X1tCidP6Fp/ynuf7XuDp34/FfiUy7xJDGz4ZE2cf1a/DQ3EE44P+tn0Nz
	 Wo7BiSsUSrme8hnA5HeOokpREWmThKFuwJToxxlcDRM8ijsnEAGczdS6hgv5yip9ZGqQq
	 4RVNSjhCJISz5Xxw/FM7XKFeuI00IR6RC26GLLjyvg0463fUKcUZNS0TTT4vf0EQzUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790459210;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=blMk7/b24qJahN28+WP4Ee3B98c8C6b3BXwJIZN1cYo=;
	b=rAzMLmUjGByIDLzxl7/xrvHQALUrvMaepqH1mivgXU9+ZgBOM3pyas/kkFHcYmVSihdT
	 c1KB/Ud65bwaECSZLEGHj4OQQ/wsw3ooxHG+eUu2IqNeawBm/Q4os9KDfsO3nB3kMXz5j
	 NnAUtwhf41rPSQaj1iAwYwYPK5q6eQdshfR3/ZZi99rUSxHvvMLcF0XVxOPacJ2OKihES
	 RqWWIsrmO1400uI9Iowx+pvr6TCfZ1yxcRcmLSSdPmSKfc3N2epPuIqjHg/HTOSGsRfaz
	 qdRTffo30VM1QMZ3Mvbj74J7wzP+xJuwhkqfIgZQkR82F16d3jaI9lK5y6kmcWI/qaw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ACPTCngm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790459210;
	bh=blMk7/b24qJahN28+WP4Ee3B98c8C6b3BXwJIZN1cYo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Us2Q9pjoAGL3wObtDQAjCNE0uvkwN31hZk3rkL9exdX/KFxFIsXs33VAi4B7RNI/9
	 dbPY/KA+e6kTzZuVXp094RImoL3n3Qg0aguklVx4KlL8hZdNivH+vn6FG4rfvbWEbz
	 989Mq15K3b1ITGNRJtg6W3ggMPOQxowbFxykdYeHfajJDHR4MycNjlhUEFFsXp5W+M
	 uoHSRfWAgAZhtvJPsCzuzVpPu8bjS92wL/2to3N2MG6CGEY69nFKBN58p5qbTz8SGO
	 OvcQ7uNIlr+E+sCoE6e4yjqXVcpoXO/Lgq4IIowO+cdXIxrg7Aa3bi0kC5uWMwKAl+
	 I4E3JsNEORN/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3D516065C;
	Sat, 26 Sep 2026 21:46:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 20F802B6
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 21:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1275C6065C
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 21:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sqi_2UitD8mC for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 21:46:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1CE726065A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790459208;
 b=N07xv4roASKnlbrOfus+ajMS+WMTLtglAM0TLEjMGL70+v97Tk2D2+Q6LMey0g7UixdR
 PqSud9wYMX46/KjncD7LBWEBxwVpHG7+v6Fm7RCXE7gMvOkVDfYB6LpFRhx/R8VRzrWMm
 KELyMt5OQTZLPD6OyNklxSo0+hj7uP+EHJioPKVRup33J+mUHbjw70IIRJjaH6eiyq4fW
 Hqv3vPLwe9owJhBPvz8eUTtYvOR8yryz769GKN/Bdsqwnp86KbLuwYRYO9KhWCmXbZSBy
 pBYIXazOtH3gzpm9UIeWlXk/SA8fkfOJeMWcoC33ttOgg6YEfVVPBgH64igDO1hxbbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790459208;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=blMk7/b24qJahN28+WP4Ee3B98c8C6b3BXwJIZN1cYo=;
 b=hlYnI6tsWS1lNt1KwfUpuzav9yp9awU7kcW5oUgWoUtNuTg8GfJWioJuSiRS99wCMivz
 rkjWQ6EPTXt7eHQVOzbGyGTSrtLWXArhvcjGG+Da9Xr4h7P8aAWopyJN95mPFzmvULLvR
 xJww0CRN8a4OV6GnfQGfkDvmmD2l2j6Hq0N5hvHb3TE3HrdNxz+TZGyEA8M0obUcagD/h
 S+52yoQEZrLE1ay0qsJRPjYfZsJKao/1WJaU5xMMaqO9xlkcF+TfWxubP0/iQ5aMR+neI
 jeOl1bkKX3nB0i18ocd3eq1fZ6MZsU7QA9h6qSSFMcBayj8BSMgEQajMiJxDF+Znabw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ACPTCngm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ACPTCngm
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CE726065A
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 21:46:47 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-343479e6005so299031eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790459207; x=1791064007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=blMk7/b24qJahN28+WP4Ee3B98c8C6b3BXwJIZN1cYo=;
 b=ACPTCngm5HW0od+6zseGyQeREDh6V3IpIM95iQtjwnIlki4ME50CX59Rt0BvwZrcQ3
 j6BczAw17K9bHKLRO6bOWMNRKXb2O7Xk33VVM/n/hOADAx4zKJEjgeZxOMOS8kqcu4f6
 wu/TXE9T1j5EQx+ii+oBd8uZjhHRCYQ1lWY9wLm2vW4pINIvdHN8BGuqFfYlEqMrTctA
 6gEMk3UeLy1M5/Lsk0A7ov1+KuPeZeLE0mhHlyRGJksUPLBQb+OpUEAjpDODuswcRfKA
 wqcOoqHcVnex/rEuRRkvPgoc0LtuibkL+P6PouN3vjA1VOtsYq+MjxF7HtjVSgav2qot
 REfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790459207; x=1791064007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=blMk7/b24qJahN28+WP4Ee3B98c8C6b3BXwJIZN1cYo=;
 b=tB540pyCdI/B0XQdmUoK6juh5eHKi9nxi7AJO02EVr8frwxZu9v7thXHQFG9lL0kC6
 TERqTHnPToXcBHkAGQTCxJn+omYBOXGwUhHdQ8IWNzBjeo/XZ3SZtoHulEGjMmh5EIrv
 lQxSpXyakm1INfg78i5SO2AaFRWZMy5M9PUtiHotBWBRmjA4Pdj1Pre4pqijXvuO/BUr
 5N3bck9V/U8WtJtOcp3vlSPMQUWw9LtVjccbwzbakqQoCJ8V6J0dOQGE8nvyDXZwizMc
 6chtThKkzpDGG3vnbkKugKhu6wRmnVsFB0TZzZHUIDdrfKtmxePYdXYN3GM0jrgBMb+/
 xp6Q==
X-Gm-Message-State: AFuF++k32MY2xJjUt8cEJkaQukoKQwUEcGOUkrOM3EmrnRLQdKCq6AoI
 +oWJz86AW1n5zZJcFaR0SSvr3Bettjue6yHcA72jaGYvKFF15pgzT2nc
X-Gm-Gg: AYBFou1dO0D/q009YVVURA9OSVeVCf8hNBwVcllWnDqZbi1O4RAtQ1DhxNURktCdXtm
 X1rQR6BLZvTbjD/84hppj+UynIPOsee8wvXwx7TCuyGB3pkoJKd519V4Z5uiW1YozMiACW8J3VS
 lw0Sa5pWjwHDpT5lEJqSLiwbzCqUQrriq1sbtqkAkQzEayLM2gFbvba3m1hsqhDrsYB+jzLPwTS
 3Te+eMqf39E3orphGV/VhsKgBii1JyPb8RUXsKcqRSS64bZMgPxHlmMwdre7d57jOCQxbTDqHzD
 fqy5SQmGHTfRgj0GYNnpVlTerVVW5WPPc1Upl3tWasZPu31YGYj2bep/NAnZLGZLDS9iauZTlwE
 cjRAABtaszSNPez52ECVajS7YXzhihcMGG3MRcZVTm4PROhJj+5TJT9RXSQrYJON/jMj8dKmce4
 lbtcmAbsT4ZxKPab8l5UNrKYPf0LiCzBIfBoQTuXwz2D8w6D3hU8F0LbTU2pdvgZ10qQz4e4uNg
 maoeZr68K84i8stFdUjXD5RGK6UA+OoHmfJvBFUkWYoXw==
X-Received: by 2002:a05:7301:906:b0:343:5f5f:eef0 with SMTP id
 5a478bee46e88-3435f5ff2camr2543974eec.21.1790459205432; 
 Sat, 26 Sep 2026 14:46:45 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a800:4bea:de63:fe7b:f67:a24e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm27004504eec.9.2026.09.26.14.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 14:46:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, primoz.fiser@norik.com,
 siddharth.menon@machinesoul.in, Tom.Hsieh@advantech.com, ye.li@nxp.com
Subject: [GIT PULL] Please pull u-boot-imx-next-20260926
Date: Sat, 26 Sep 2026 18:46:39 -0300
Message-ID: <20260926214640.34726-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 9e002445cd0d47d3965312f12e97a18e1ed8bd53:

  Merge tag 'u-boot-stm32-20260922' of https://git.u-boot-project.org/u-boot/custodians/u-boot-stm into next (2026-09-22 08:59:41 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20260926

for you to fetch changes up to 486e40aef6c44cc67220833574e6c17b40bbce23:

  nxp: imx9{5,4,52} evk/frdm : Enable caches in SPL (2026-09-26 15:35:01 -0300)

u-boot-imx-next-20260926
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/1378

- Migrate pcm058 to OF_UPSTREAM, enable Winbond SPI NOR flash and thermal support.
- Add SNVS ON/OFF power key driver.
- Add USB PHY tuning support like the kernel.
- Enable caches in SPL on imx9{5,4,52} evk/frdm.
----------------------------------------------------------------
Primoz Fiser (3):
      ARM: dts: phytec: pcm058: Migrate to OF_UPSTREAM
      configs: pcm058_defconfig: Enable Winbond SPI NOR flash support
      configs: pcm058_defconfig: Enable i.MX on-chip thermal sensor

Siddharth Menon (2):
      button: imx: add SNVS ON/OFF power key driver
      imx8mp/mq_evk: enable SNVS power button

Tom Hsieh (1):
      phy: phy-imx8mq-usb: add USB PHY tuning support

Ye Li (4):
      imx9: scmi: Move WDOG and GPIO init out of arch_cpu_init
      imx9: scmi: Support early caches enable in SPL and u-boot
      spl_imx_container: Fix verify image after SPL dcache enabled
      nxp: imx9{5,4,52} evk/frdm : Enable caches in SPL

 arch/arm/dts/Makefile                             |   1 -
 arch/arm/dts/imx6q-phytec-mira-rdk-nand.dts       |  75 ----
 arch/arm/dts/imx6qdl-phytec-mira-peb-av-02.dtsi   | 119 -------
 arch/arm/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi |  71 ----
 arch/arm/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi |  85 -----
 arch/arm/dts/imx6qdl-phytec-mira.dtsi             | 412 ----------------------
 arch/arm/dts/imx6qdl-phytec-phycore-som.dtsi      | 311 ----------------
 arch/arm/mach-imx/imx9/scmi/soc.c                 | 156 +++++++-
 arch/arm/mach-imx/mx6/Kconfig                     |   1 +
 board/nxp/imx94_evk/spl.c                         |   4 +-
 board/nxp/imx952_evk/spl.c                        |   4 +-
 board/nxp/imx95_evk/spl.c                         |   4 +-
 board/nxp/imx95_frdm/spl.c                        |   4 +-
 common/spl/spl_imx_container.c                    |   2 +
 configs/imx8mp_evk_defconfig                      |   2 +
 configs/imx8mq_evk_defconfig                      |   2 +
 configs/pcm058_defconfig                          |   5 +-
 drivers/button/Kconfig                            |   8 +
 drivers/button/Makefile                           |   3 +-
 drivers/button/button-snvs-pwrkey.c               | 154 ++++++++
 drivers/phy/phy-imx8mq-usb.c                      | 283 +++++++++++++++
 include/configs/imx94_evk.h                       |   3 +
 include/configs/imx952_evk.h                      |   2 +-
 include/configs/imx95_evk.h                       |   3 +
 include/configs/imx95_frdm.h                      |   3 +
 25 files changed, 629 insertions(+), 1088 deletions(-)
 delete mode 100644 arch/arm/dts/imx6q-phytec-mira-rdk-nand.dts
 delete mode 100644 arch/arm/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-phytec-mira-peb-eval-01.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-phytec-mira.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-phytec-phycore-som.dtsi
 create mode 100644 drivers/button/button-snvs-pwrkey.c
