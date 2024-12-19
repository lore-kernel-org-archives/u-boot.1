Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B85E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 19:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEAA38031D;
	Thu, 19 Dec 2024 20:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="KoC8MyHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 544FD80312; Thu, 19 Dec 2024 19:50:05 +0100 (CET)
Received: from mail-qv1-xf63.google.com (mail-qv1-xf63.google.com
 [IPv6:2607:f8b0:4864:20::f63])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE9BD8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-qv1-xf63.google.com with SMTP id
 6a1803df08f44-6dada7c89d9so553976d6.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1734634201; x=1735239001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=x2F+UPW1u+YZ78LfqeKZTNHT4PwRYEL9lwXR6/K07ho=;
 b=KoC8MyHZZA+uZVohwxoHuoRk9qHqBRMXDwc0NxNobrr1m3x+3HbkWSl2/CkKZGoQAE
 6AsYiQa0KsJMgp8kHsXYa8cXY9Zt2WW4TqZM1C0WP2RRy74t8xr4uD/3JrnUU4ajdV0g
 /52kuGWP8I1nVsnb9hRgt9LSi/pnj7+N41dNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734634201; x=1735239001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x2F+UPW1u+YZ78LfqeKZTNHT4PwRYEL9lwXR6/K07ho=;
 b=S5LsVYZwRH9OL+7wNg49EfoXldrXU+m8uX8uL78SVYDAGou2Tx3IQk+EGzpFy4zX1Z
 nOWdS5bFyxmlKT4RyFMLJIBw2auG4doBw+M6pZRdAO4sNjovtEqGkTJ65tiIaZwgR0rj
 vit51xwXtRpT4W0d40psJi2pE1WhlaRBwNX2G37Rb2Dn7Cr4X1m928C/q7Djiu2Lnyli
 4PB1V0W1SEoJiIqsQs5QFR8JSkMsHHTjc6KWzXD3+ezEHoAgchFaog7mAkV4g0EU9gzQ
 ITaQv7c9XBiD6hD7C8EY6jZZQR2yL7bU0ZSeKeP19REHdD+siw3a/K3vsK8fVnGb5Nrh
 rxxQ==
X-Gm-Message-State: AOJu0Yy91Qr72MultQyT1eNdlo/Ny2TDfsSEq4f4ad7UtsWmO+h6ZmA3
 2AZYmlhmh7ktRGy6Ft+jNrMnfsnSmOYDfWhABTEe+Bhv2f9f8o93jF95r2DLSE3+WRGq/e6PKTE
 roJ0WXZtnH8KQ5vkN6+vxYJPzYiv4sR/UpY0H/JdDTvUe8eXosH5JPY2wCioKeitRyS09gs/ydE
 nrsGhltBe8Ca78JWGGBpdIXHvTydW95xAGax1uy41lTvJDjmBCNJWGuP7rcDCvSZ0fqcbH
X-Gm-Gg: ASbGncs5ROw337AkIaBlQgiIMr6J8eiEhK/4gNAPDRyjrmWCsYIjsGZajWPQeq/NPtp
 j5v+JgQoEkdIR5TLfIigxZ5zkcgIysmYji3pcEe1SM4LNn/fQ0sfzrt972kSuN4Nz7oA9jDT4RM
 D3w+nC4PZ6yhjZnqP/K3bKtVExcaXRZdMpp/pRmgxgYLmTNZWsB13Nr5ToqCMEwuhAr7PkVCzhI
 F05i3iHU/Xf0Jhy2kt+Kh2almqHE0/ZUzXUNhLchXximqja3rM2YRzbFcxtTL8y5HPheYphZZ1l
 QEc/h3/FtgeQLmVCssVFa3p2+5QFaOw=
X-Google-Smtp-Source: AGHT+IFs6ImKWhn8t9tgyMByl+O/AsVyToiXT+JXxN9bK3eqK8lA69umIMJfZnJleiA9wShbE5ajsR0Ik1mu
X-Received: by 2002:a05:6214:4007:b0:6da:dbf0:9645 with SMTP id
 6a1803df08f44-6dd23317478mr5056d6.3.1734634200662; 
 Thu, 19 Dec 2024 10:50:00 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-6dd180f0c0dsm981206d6.27.2024.12.19.10.49.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Dec 2024 10:50:00 -0800 (PST)
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
Subject: [PATCH 0/2] Broadcom bcmbca dts updates
Date: Thu, 19 Dec 2024 10:49:51 -0800
Message-Id: <20241219184953.226978-1-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Dec 2024 20:41:51 +0100
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
update bcmbca dts to current nand node naming convention.

david regan (2):
  arm: dts: Use upstream dts
  arm: dts: Update nand node

 arch/arm/dts/bcm4908.dtsi             | 127 ----------------------
 arch/arm/dts/bcm63138.dtsi            | 149 --------------------------
 arch/arm/dts/bcm63148.dtsi            | 103 ------------------
 arch/arm/dts/bcm94908.dts             |  30 ------
 arch/arm/dts/bcm963138.dts            |  30 ------
 arch/arm/dts/bcm963148.dts            |  30 ------
 arch/arm/dts/bcm96753ref.dts          |  19 ++--
 arch/arm/dts/bcm968360bg.dts          |  19 ++--
 arch/arm/dts/bcm968580xref.dts        |  19 ++--
 arch/arm/mach-bcmbca/bcm4908/Kconfig  |   1 +
 arch/arm/mach-bcmbca/bcm63138/Kconfig |   1 +
 arch/arm/mach-bcmbca/bcm63148/Kconfig |   1 +
 configs/bcm94908_defconfig            |  11 +-
 configs/bcm963138_defconfig           |  11 +-
 configs/bcm963148_defconfig           |  11 +-
 15 files changed, 57 insertions(+), 505 deletions(-)
 delete mode 100644 arch/arm/dts/bcm4908.dtsi
 delete mode 100644 arch/arm/dts/bcm63138.dtsi
 delete mode 100644 arch/arm/dts/bcm63148.dtsi
 delete mode 100644 arch/arm/dts/bcm94908.dts
 delete mode 100644 arch/arm/dts/bcm963138.dts
 delete mode 100644 arch/arm/dts/bcm963148.dts

-- 
2.37.3

