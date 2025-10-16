Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4440ECCD194
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 12:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D499883655;
	Thu, 16 Oct 2025 14:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MjPSoLQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35769836C1; Thu, 16 Oct 2025 14:34:53 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C2C83631
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 14:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cnS885zFvz9tSP;
 Thu, 16 Oct 2025 14:34:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760618088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eurTkKHcThZK7xZvQCN0vVEJRh5wEOKHUA3qIuAfOVo=;
 b=MjPSoLQnDOxuPWmNzrpztfcx0Q5BuySqlKaZxGKjRat7BuW++xIjh/zFjXCn4by14zz1hB
 jmFKrIwv13vImJJTGL74a7RTeSYZITqRg9aQ9mxa0OpNo98G/wkJ8p49LCEpgLgki8UF32
 DW8xGmJLF2Up9ebcXgExsqMtehqcPeOygtRf7XNk3Vc2IogcfKLW76LgWm7yzfjnjfKBX+
 PbqwZNWha0NcvPv5pe3/vJ30tIJTYEHuK+GqSCRADD6+lI73nia3CoQMFD25zaW/hfDdHa
 KNzfH0ckDmURhcKTP8ccHRPAzAAV2MTULaKJeG+0rPvkFq8czFUi50nS/sH5sg==
Message-ID: <bef2d7bb-25d5-4d41-821f-6aad1f565c95@mailbox.org>
Date: Thu, 16 Oct 2025 14:34:48 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <stefan.roese@mailbox.org>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xa9k4zfch4mdc731f3f7qyhreykodeum
X-MBO-RS-ID: 11ae1ec0501b32c9f63
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

please pull this batch of WDT Kconfig related fixes:

----------------------------------------------------------------
- watchdog: Tighten some driver dependencies in Kconfig (Tom)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=400&view=results

Thanks,
Stefan

The following changes since commit 2ba64e303b2706e5c42a6bf982326d632342ca66:

   Merge patch series "fix an7581 panic caused by attempt to support 
multiple RAM size" (2025-10-15 15:08:27 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-watchdog.git 
tags/u-boot-watchdog-20251016

for you to fetch changes up to df2220c946f593892c1bd60535c777e4a18448ac:

   watchdog: Tighten dependencies on WDT_DAVINCI (2025-10-16 09:16:36 +0200)

----------------------------------------------------------------
Tom Rini (2):
       watchdog: Tighten some watchdog driver dependencies
       watchdog: Tighten dependencies on WDT_DAVINCI

  drivers/watchdog/Kconfig | 20 +++++++++++---------
  1 file changed, 11 insertions(+), 9 deletions(-)
