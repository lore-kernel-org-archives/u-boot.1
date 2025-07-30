Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A686C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 10:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E904F81E13;
	Wed, 30 Jul 2025 12:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oBozJS1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5EE81F6B; Wed, 30 Jul 2025 12:17:31 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19344803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 12:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bsSnf6mQkz9sVt;
 Wed, 30 Jul 2025 12:17:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753870647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tgJDxe4kmsuddVcl1UmwY5/YfRhWLBwOJTkDD0yZyGw=;
 b=oBozJS1nGvEk04OJYRIPJ+s8p1TPfjbcolm04nshOBBRbcWXsJdykFpUYcIXKk1xvJQ0HJ
 2cZRE+evNKXCqZf8mfn72n5tWBq6QbrZa5pBd9dzqVoLi8zFt8YWGLsXZJIfzl1u1drBev
 kpp/wzkkt7oIEQsYadQCzo/To2EuuOiFg9kwMzDC8iTkMKRMxBgD2WAARXHB9JtLpf2F+j
 w2bsSjOpj2lb3YAVEHvMpAEwvcx0cwH6OwCOS3cp0hd+7iIzsFY8/tMokKryyy8fkeqTXl
 lBnXFhquQQ/RoNoi/Q5pnrr/5oMFTCMgB1pqhDdoSC/M6FNqyOxny8bOwfEKtw==
Message-ID: <84e083b7-fe7d-4067-919e-b3a64c287050@mailbox.org>
Date: Wed, 30 Jul 2025 12:17:26 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
Subject: Please pull u-boot-watchdog/master
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4ef2bee573bec339ce6
X-MBO-RS-META: duy8qqdne4p43unje9nfes6uei69ext1
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

Hi Tom,

please pull this next batch of watchdog related patches:

----------------------------------------------------------------
- watchdog for STM32MP family updates (Antonio, Clément and Patrice)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=395&view=results

Thanks,
Stefan

The following changes since commit a8f20bb6650df56d2600cda2c66f9349df9e49c8:

   Merge patch series "bios_emulator: Fix two issues found by Smatch" 
(2025-07-29 13:14:52 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-watchdog.git 
tags/u-boot-watchdog-20250730

for you to fetch changes up to 7e1e22c70d51d1594ddd3b54e943e511efd65a35:

   watchdog: don't autostart watchdog on STM32MP architecture 
(2025-07-30 08:01:11 +0200)

----------------------------------------------------------------
Antonio Borneo (2):
       watchdog: wdt-uclass.c: add wdt_set_force_autostart() helper
       watchdog: arm_smc_wdt: get wdt status through SMCWD_GET_TIMELEFT

Clément Le Goffic (1):
       watchdog: stm32mp: check the watchdog status

Patrice Chotard (1):
       watchdog: don't autostart watchdog on STM32MP architecture

  configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig |  1 +
  .../stm32mp15-icore-stm32mp1-edimm2.2_defconfig    |  1 +
  ...2mp15-microgea-stm32mp1-microdev2-of7_defconfig |  1 +
  ...stm32mp15-microgea-stm32mp1-microdev2_defconfig |  1 +
  configs/stm32mp15_basic_defconfig                  |  1 +
  configs/stm32mp15_dhsom.config                     |  1 +
  drivers/watchdog/Kconfig                           |  1 +
  drivers/watchdog/arm_smc_wdt.c                     | 17 +++++++++++
  drivers/watchdog/stm32mp_wdt.c                     | 33 
++++++++++++++++++++++
  drivers/watchdog/wdt-uclass.c                      |  9 ++++++
  include/wdt.h                                      |  9 ++++++
  11 files changed, 75 insertions(+)

