Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF078C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287D88061B;
	Tue, 14 Jan 2025 06:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="DAykfhrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF6DE80658; Tue, 14 Jan 2025 05:54:34 +0100 (CET)
Received: from mail-qv1-xf62.google.com (mail-qv1-xf62.google.com
 [IPv6:2607:f8b0:4864:20::f62])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60390805DA
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-qv1-xf62.google.com with SMTP id
 6a1803df08f44-6df8f7f9442so7074316d6.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1736830471; x=1737435271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CqbqvEHluLEmHOSxd539wUkLjBz1A/GSnvSV+e6vbK8=;
 b=DAykfhrveS3f/b/jgNlI50B2KJm+jHNoJX6fnVBXRTaEuWk6pCgkCZ2rdT2TnVMgL6
 P5A/RpMm7R3rnvqyrq2dWlv9KxkO3g19ewkyn1ymRHo1aJiFNazhW1Dv14zbr3bwE1fZ
 1mfoslfLKaO8SQ0Y2p95oRXeKv5p+WN73wCNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736830471; x=1737435271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CqbqvEHluLEmHOSxd539wUkLjBz1A/GSnvSV+e6vbK8=;
 b=LqeB48mvUW39Hd9gdn+lXVQg01mo6tlrJ76MpoEl1DVDhoABg8HZL0Fi41UkpO2+JL
 vL4kAPj0F/Wzke5pZ0D9nycQf3GHfIQU6mMErT9FbfbU2OvhGBqEGDg2qAVJURoCOTTC
 QEdKt+cbYuHJdUnWgXbKO2VEiUECA5JLhqUR8xA5NIaZ5xb2zoLVIWR8bACWi4ggJxIX
 /X95RA2ZdH8P8dnDz+FdEMWE+iRVeoanS96Vm3mzo1oXj5nsQdhZn6Xnje74XYmKrlJO
 xAhhd8/l+ggcVKvcQD90N/rcNVa8e+KbN+VQAkw/3Ql9HCs5N0Sw8QxFCVc3r6fcwW03
 v8mQ==
X-Gm-Message-State: AOJu0YyPjBAlAYKrvBvIrVK5dPm4e4xp9LVbV96sQuKTzW8vx3fksOsX
 b/+NHCVKmfuhvf2HwFi2ZhGMoPzEFrihE0xWk93rj0xN6jGwBopgl8JfHHQUT5IGVedy4k6tn5L
 Ypr7rMIgV/bmnOAaRe09E1b9xk+9Y+Y/Odt2+At6w8EY3YOu/E5gFQEibrLOIYf7JS9VUgFtfXp
 FJeaku8FhDskDKFNoz3+HfcmmWaRH7qoGw88rBrOdrD4Xgvcf/P4DWvHOaEnyKFF1Bj4EW
X-Gm-Gg: ASbGncs3nGu+b4dwOanlkN2+UZjQ9kx0FCnyiluk8LqWrfa9O5IAbvEdAxlUX06J9I1
 I5sllNKnt2DOKsVR20jPDaghgxDSpMjztzLVuHwrp1yqGWFHheqyV/uxTyzQ8fD6m1MD/vnjIMa
 WX4mflIpALI5yaFGGsleALzFcBscf/0fVkTiRYMIeTvSdUJjCPE8danWzITRBRAINeM4o+Wpf9w
 JFHWTNy2i3cnChu/cDGxDvG1C+Tx1etT0wwbrQScsuV953wuSbEwBIU9Qh9TQBNfITvH4jVe1n8
 miSZICqR6nbMTD9w1ti0rEeN4Aqizj8=
X-Google-Smtp-Source: AGHT+IGjcntI1RiNdDk5PglCFF2+n6yB6B9bWLUIRqIOlnlLx9vv9+dEGDpYxsVYmhIhzv+iL4V1ns8RdzE2
X-Received: by 2002:ac8:5751:0:b0:467:613d:c9bb with SMTP id
 d75a77b69052e-46c710a8dc3mr138674781cf.8.1736830471084; 
 Mon, 13 Jan 2025 20:54:31 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-46c8731f2d6sm2613821cf.3.2025.01.13.20.54.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2025 20:54:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com, dregan@broadcom.com
Subject: [PATCH v2 0/3] Broadcom bcmbca dts updates
Date: Mon, 13 Jan 2025 20:54:22 -0800
Message-Id: <20250114045425.148801-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Jan 2025 06:35:58 +0100
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

Updates for Broadcom bcmbca devices,
make use of OF_UPSTREAM which uses Linux dts,
update bcmbca dts to current nand node naming convention,
enable basic nand functionality for bcmbca devices.

Changes in v2:
- Removed addition of nand-on-flash-bbt parameter
- Moved enabling of nand functionality to a new patch added to the
  series

david regan (3):
  arm: dts: Use upstream dts for additional bcmbca devices
  arm: dts: Update nand node for bcmbca board dts
  arm: dts: Enable basic nand functionality for bcmbca devices

 arch/arm/dts/bcm4908.dtsi             | 127 ----------------------
 arch/arm/dts/bcm63138.dtsi            | 149 --------------------------
 arch/arm/dts/bcm63148.dtsi            | 103 ------------------
 arch/arm/dts/bcm94908.dts             |  30 ------
 arch/arm/dts/bcm963138.dts            |  30 ------
 arch/arm/dts/bcm963148.dts            |  30 ------
 arch/arm/dts/bcm96753ref.dts          |  18 ++--
 arch/arm/dts/bcm968360bg.dts          |  18 ++--
 arch/arm/dts/bcm968580xref.dts        |  18 ++--
 arch/arm/mach-bcmbca/bcm4908/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm63138/Kconfig |   1 +
 arch/arm/mach-bcmbca/bcm63148/Kconfig |   1 +
 configs/bcm94908_defconfig            |  11 +-
 configs/bcm963138_defconfig           |  11 +-
 configs/bcm963148_defconfig           |  11 +-
 15 files changed, 54 insertions(+), 505 deletions(-)
 delete mode 100644 arch/arm/dts/bcm4908.dtsi
 delete mode 100644 arch/arm/dts/bcm63138.dtsi
 delete mode 100644 arch/arm/dts/bcm63148.dtsi
 delete mode 100644 arch/arm/dts/bcm94908.dts
 delete mode 100644 arch/arm/dts/bcm963138.dts
 delete mode 100644 arch/arm/dts/bcm963148.dts

-- 
2.37.3

