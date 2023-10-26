Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E02C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A51887B5B;
	Thu, 26 Oct 2023 14:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEB987599; Thu, 26 Oct 2023 14:51:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F318087614
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A962F4;
 Thu, 26 Oct 2023 05:51:43 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.2.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763F63F64C;
 Thu, 26 Oct 2023 05:51:00 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: nd@arm.com, trini@konsulko.com,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Xueliang Zhong <Xueliang.Zhong@arm.com>
Subject: [PATCH 0/3] Corstone-1000: enable platform specific configs
Date: Thu, 26 Oct 2023 13:50:48 +0100
Message-Id: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

This patchset enables configs needed by the Corstone-1000 platform.

The enabled configs allow the following:

- unzip the kernel before executing it (the kernel has become too large
   to fit in the available storage)
- enable distro_bootcmd (needed to boot distros from storage devices)
- enable PSCI reset (Corstone-1000 needs the PSCI reset interface for
   the system reset)

The corstone1000_defconfig is generated using savedefconfig.

Cheers,
Abdellatif

Cc: Tom Rini <trini@konsulko.com>
Cc: Xueliang Zhong <Xueliang.Zhong@arm.com>

Abdellatif El Khlifi (2):
  corstone1000: add compressed kernel support
  corstone1000: enable distro booting command

Emekcan Aras (1):
  corstone1000: enable PSCI reset

 configs/corstone1000_defconfig | 1551 +++++++++++++++++++++++++++++++-
 include/configs/corstone1000.h |    3 +-
 2 files changed, 1552 insertions(+), 2 deletions(-)

-- 
2.25.1

