Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC68D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 09:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C4683A8C;
	Mon,  1 Dec 2025 10:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E3A683A8F; Mon,  1 Dec 2025 10:05:00 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4E7B283A2B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 10:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frazer.carsley@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18F0C497;
 Mon,  1 Dec 2025 01:04:49 -0800 (PST)
Received: from e138143.cambridge.arm.com (e138143.arm.com [10.1.39.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 416573F73B;
 Mon,  1 Dec 2025 01:04:55 -0800 (PST)
From: Frazer Carsley <frazer.carsley@arm.com>
To: frazer.carsley@arm.com
Cc: abdellatif.elkhlifi@arm.com, harsimransingh.tungal@arm.com,
 hugues.kambampiana@arm.com, u-boot@lists.denx.de
Subject: [PATCHv2 0/1] corstone1000: Add Cortex-A320 support on FVP
Date: Mon,  1 Dec 2025 09:04:21 +0000
Message-ID: <20251201090424.34519-1-frazer.carsley@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127154752.589691-1-frazer.carsley@arm.com>
References: <20251127154752.589691-1-frazer.carsley@arm.com>
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

This new patch series simply removes the yocto-compliant
"Upstream-Status" tag from the patch commit message.

Frazer Carsley (1):
  corstone1000: Add Cortex-A320 support on FVP

 arch/arm/dts/corstone1000-fvp-u-boot.dtsi | 18 +++++-
 arch/arm/dts/corstone1000-u-boot.dtsi     | 76 +++++++++++++++++++++++
 arch/arm/include/asm/armv8/cpu.h          |  1 +
 board/armltd/corstone1000/Kconfig         |  7 +++
 4 files changed, 99 insertions(+), 3 deletions(-)

