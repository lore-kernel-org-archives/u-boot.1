Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C5EE9E30F
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 14:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020FD83A5A;
	Wed, 11 Feb 2026 15:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aSPxKE/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D2183B30; Wed, 11 Feb 2026 15:13:09 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A4683015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 15:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B0BF543D6A;
 Wed, 11 Feb 2026 14:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F8EC4CEF7;
 Wed, 11 Feb 2026 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770819185;
 bh=GYjbYtqKJI8XR8hcP35aemNf9Wlhr4U9aaS5MGHtISE=;
 h=From:To:Cc:Subject:Date:From;
 b=aSPxKE/oufKdMWG6rBGpJxpl6KvKhkQmDhu9NDrBYC+F6AshhZs1wwyZhOKZJDJNF
 7wDKulgXoIjYb2CqanetKBI3WNzNGSZmrLsIeq9TaVu3s99jHojb/vJ4bPmYaFePya
 +nRUvVQriTAw3lEIQ9fLmt9hAYBBN4QLwUUsDxUYfThJI/kk9PTRfhUMiDzO25WTiZ
 n9oZIK8rDxbG8Y2NTLvokkozIlg2jTcn1odS6JFg0VcIrvHfQMKTizgPlT3W8t1oG6
 oD/rGiGQfqp5/w0HpWnH6yuoyz2/g0l8Cog+gWaI9kKkcSekBmtSuOCI73H9x73FtP
 Uw4cojLJwlgHw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Chris Morgan <macroalpha82@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [GIT PULL] Please pull u-boot-dfu-20260211 into master
Date: Wed, 11 Feb 2026 15:13:03 +0100
Message-ID: <87ms1fl66o.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Here is a PR for master

USB Gadget:
* dwc3: Support ip and version type
* dwc3: Increase controller halt timeout
* dwc3: Don't send unintended link state change
* dwc3: Improve reset sequence
* dwc2: Move dr_mode check to bind to support RK3288/RK3506 with
  2 DWC2 controllers

CI:
* https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/29259

Regards,
Mattijs

The following changes since commit eed514b11d04a2f8a949521ad3bffba3ec98bd2f:

  video: correct label for cyclic video_idle (2026-01-29 10:00:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20260211

for you to fetch changes up to e69841fa71d67c560d767b786f956bb6f2873130:

  usb: gadget: dwc2: Move dr_mode check from of_to_plat() to bind() (2026-01-30 09:01:42 +0100)

----------------------------------------------------------------
u-boot-dfu-20260211

USB Gadget:
* dwc3: Support ip and version type
* dwc3: Increase controller halt timeout
* dwc3: Don't send unintended link state change
* dwc3: Improve reset sequence
* dwc2: Move dr_mode check to bind to support RK3288/RK3506 with
  2 DWC2 controllers

----------------------------------------------------------------
Chris Morgan (4):
      usb: dwc3: core: Add ip and version_type support from Linux
      usb: dwc3: Increase DWC3 controller halt timeout
      usb: dwc3: gadget: Don't send unintended link state change
      usb: dwc3: core: improve reset sequence

Jonas Karlman (1):
      usb: gadget: dwc2: Move dr_mode check from of_to_plat() to bind()

 drivers/usb/dwc3/core.c           | 92 +++++++++++++++++++++++++--------------
 drivers/usb/dwc3/core.h           | 60 +++++++++++++++++++++++++
 drivers/usb/dwc3/gadget.c         | 20 ++++-----
 drivers/usb/dwc3/gadget.h         | 14 ++++++
 drivers/usb/gadget/dwc2_udc_otg.c | 19 +++++---
 5 files changed, 156 insertions(+), 49 deletions(-)

