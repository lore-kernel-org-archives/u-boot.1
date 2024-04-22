Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078CAC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D61188398;
	Mon, 22 Apr 2024 11:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ltts.com header.i=@ltts.com header.b="IX6sZXHt";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="c6D4GYCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60F6883E0; Mon, 22 Apr 2024 11:45:53 +0200 (CEST)
Received: from c180-40.smtp-out.ap-south-1.amazonses.com
 (c180-40.smtp-out.ap-south-1.amazonses.com [76.223.180.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D0C88379
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713779149;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
 bh=mtPv5hAAXg3SCkj8H1amGTMlIL2BrChEHnHosx22x/Y=;
 b=IX6sZXHtSYQeDsmNcdMbtZvSM5lXDl5ylLdHA6Jv5+V4z4O154/DrKd/LHmmYnbm
 P9vUDPBb9bEwki5x8SSlIEDIRVY+K49gpR9qZLoFld9vlizegF9unkHjxVXwd7SKsVy
 Bk/CwKmR8fSj28PpDfj2I98XyXhPOHGY7RWkhq+V1/Pj5cAWHW7B+tVtJlQul1YKlMs
 lRy3u43Je8HJ/PNq3meTWnGThnapTNX9dR3lpDklmOpx9SaNe5qnJ/YY7SCeMHd4w68
 BTey/sJUjhc2fWf9Gx6ECNru+g2gUWsARD09afOcmrMu+kcbCM4Pjp7/T2wd9W0NRvk
 1O4/d5QviQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1713779149;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=mtPv5hAAXg3SCkj8H1amGTMlIL2BrChEHnHosx22x/Y=;
 b=c6D4GYCraobn7ZvQ1CFlz5UpUbftJZfN3QDIk2SBEbbOuS4heMHNDuFuU5BwEP+v
 cZDfkWlV+314DPpHD7WXGti4XOM5IWK+coyyNxVYnNGBcZ+osFEm37YJEpkjTQopciV
 gbCUhWzcqEM/E/Co6xTte3yMufcfKrXu35+CVAmk=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, jh80.chung@samsung.com, 
 sjg@chromium.org, trini@konsulko.com, m.nirmaladevi@ltts.com, 
 Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v4 0/5] Add support for TI TPS65224 PMIC
Date: Mon, 22 Apr 2024 09:45:49 +0000
Message-ID: <0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.22-76.223.180.40
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

TPS65224 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ADC, ESMs (Error Signal Monitor),
and PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC
can communicate through the I2C.

Data Sheet for TPS65224: https://www.ti.com/product/TPS65224-Q1

Reusing the TPS65941 PMIC driver to add support for TPS65224 PMIC 
in U-boot. This includes driver for PMIC and regulator.

The driver was tested on Ti's custom AM62P EVM using U-boot's
pmic list, regulator list, regulator status and regulator value commands.
Since, support for Ti's AM62P is absent in u-boot next, the patches
were applied on ti-u-boot ti-u-boot-2023.04-next and tested.

Changelog v3 -> v4:
- refactoring ldo probe function: removed a redundant branch

Bhargav Raviprakash (5):
  power: tps65941: Add macros of TPS65224 PMIC
  power: pmic: tps65941: Add TI TPS65224 PMIC
  power: regulator: tps65941: Added macros for BUCK ID
  power: regulator: tps65941: use function callbacks for conversion ops
  power: regulator: tps65941: Add TPS65224 PMIC regulator support

 drivers/power/pmic/tps65941.c                |   1 +
 drivers/power/regulator/tps65941_regulator.c | 381 +++++++++++++++++--
 include/power/tps65941.h                     |  30 ++
 3 files changed, 381 insertions(+), 31 deletions(-)

-- 
2.25.1

