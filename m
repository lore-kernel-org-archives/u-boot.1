Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A32DC25B74
	for <u-boot@archiver.kernel.org>; Sun,  2 Jun 2024 12:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14EA87F4B;
	Sun,  2 Jun 2024 14:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NpAebTpx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LTPgcsNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B603E87F8C; Sun,  2 Jun 2024 14:51:59 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9401587F33
 for <u-boot@lists.denx.de>; Sun,  2 Jun 2024 14:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VscF92SlTz9sSx;
 Sun,  2 Jun 2024 14:51:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717332717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FYTjZ1kfLG6ZUC/c790VEnAQxX3rCCGgvh5W9rnsGic=;
 b=NpAebTpxfmp/69MX8+A6iSqztd67no0HsPGt2HbZN2WJbBTp7Bxqfk3LKL1dlTMi9YsjLm
 jeouaov2k6TpMooT3/DBcfSL6PNuhwUz2A3XsPWWoqqgpQz/yRJB2vSs9xpgl0ZLXLXntl
 j0m5H9fZioVe+ciTCU8qbub4Llj9pMFYRdOozjWxFvkasBO8Uu/UKPHsmeopLUizA1tPh0
 DzImEf+atJwCikru7zbR8bVV6yvPJB7nmRXWqzRyW70Lf8sU6G4D7jG/jI0kB+M9XdiSzc
 d2Vj/KfJvQd0RYC32r8s3CnuKpO/fWVYhCDDbj8tR1Z0JQnk/Hu4zeAbNm7FOw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717332715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FYTjZ1kfLG6ZUC/c790VEnAQxX3rCCGgvh5W9rnsGic=;
 b=LTPgcsNk2K36R1VPERGRcrjIs/2/jYcMu9Z/aYkAcvQG3/JA1ZahvlYbyJtFp0iyXhW1/S
 XWIsPO5GWvUduim2hUPRz3dZEk0mS1TUIqeb8CIqoPVLh7L89FMA+sqUQV6wjeU0Vhcwdu
 GP3060vVrj6YQDFVYnDorDOAy5YMWHhHV9ovdESUzzMRXA5Qpl8Z8KcJFKWVY5KLJmhnhe
 wg21vjbmF7JA3oDGPPdQ2vrQ4JatEgMxeFQ5jJOu14rw7l84tJCvUJuFh+hpDac2APbBdV
 GJSun+0MaripOOu2FruFasIfs5SsLZvI8Gottr1yTXsdqBC0OWMJDPXjF2cYaA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next-cleanup
Date: Sun,  2 Jun 2024 14:51:15 +0200
Message-ID: <20240602125146.12460-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 283ae38d624d9179137
X-MBO-RS-META: dnjkbaqytbnzpbh7c6gttgu9z3qymmcw
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

The following changes since commit 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf:

  Merge patch series "FWU: Add support for FWU metadata version 2" (2024-05-24 13:42:07 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next-cleanup

for you to fetch changes up to 63da3a795e86dcf0906beb99865e3d4139114872:

  ARM: dts: renesas: Drop R8A779H0 V4M DTs with OF_UPSTREAM counterparts (2024-06-02 02:30:13 +0200)

----------------------------------------------------------------
Marek Vasut (2):
      ARM: dts: renesas: Switch to using upstream DT on Renesas R8A779H0 V4M
      ARM: dts: renesas: Drop R8A779H0 V4M DTs with OF_UPSTREAM counterparts

 arch/arm/dts/Makefile                         |   3 -
 arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi      | 166 ----------
 arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi  |  15 -
 arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi |  15 -
 arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi   |  41 ---
 arch/arm/dts/r8a779h0-gray-hawk.dts           |  25 --
 arch/arm/dts/r8a779h0-u-boot.dtsi             |  27 --
 arch/arm/dts/r8a779h0.dtsi                    | 460 --------------------------
 configs/r8a779h0_grayhawk_defconfig           |   3 +-
 9 files changed, 1 insertion(+), 754 deletions(-)
 delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
 delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
 delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
 delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779h0-gray-hawk.dts
 delete mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a779h0.dtsi
