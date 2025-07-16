Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2EAC83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 10:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58293831D3;
	Wed, 16 Jul 2025 12:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tJW2fBKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C67831D7; Wed, 16 Jul 2025 12:08:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF71D831AC
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 12:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EFFE046585;
 Wed, 16 Jul 2025 10:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBEDC4CEF0;
 Wed, 16 Jul 2025 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752660495;
 bh=Zh6KlQDFkebEAxE8DCOM0d0J2kOW3bKZ0O0q2xvoag0=;
 h=From:To:Cc:Subject:Date:From;
 b=tJW2fBKucSv3JzosrC4RcnFbKDdddMwRj8CKWqt51C19SRxiXDx0Qu7DQyi1AxcGB
 buVlmj1vQOSMTu4A6yAlWNTh4mndXRMFRVX5teVP+j55q7xSKPFSwykMI9DAFXr4sC
 91mFebc4r9JnEQGj6ijmtt9D9iLdMI82MUJ/Wu5Jo5jEEkzGpCuDBPpT1ISl6vVd0h
 8WOk90knujWmnjWa7p2DPQGYNHqDKsTWflYPHc8oqJYNRp4r55G9X7vrpsijprw0vn
 PPS65tbkv/ME6kkycMw6AvfCsCbSRp6JX+PmpF3cCpkZk0+ht3Kn40ZRRjSy6cDBa4
 AmMj6zEZxlCMQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sam Protsenko <semen.protsenko@linaro.org>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20250716 into master
Date: Wed, 16 Jul 2025 12:08:12 +0200
Message-ID: <87y0so30tv.fsf@kernel.org>
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

Please find the following fixes for master:

Android:
- Fix printing lbaint_t format in AVB and android_ab messages

DFU:
- Fix dfu_config_interfaces() for single interface DFU syntax

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/27074

Please note that this is probably my last pull request before my
paternity leave. I plan to be out in August and September.
Becoming a dad will be a life-changing event for me, so I'd like to
not be on my computer for the early months :)

As we discussed on IRC, thanks a lot for keeping an eye out for
fastboot, android AB/AVB, USB gadget and DFU.

Regards,
Mattijs

The following changes since commit b379335f141e3ddca0cdbb5d9d39af0444530542:

  configs: Resync with savedefconfig (2025-07-07 14:15:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20250716

for you to fetch changes up to 772526fb9f55a1fea439ea3a6923136cd121cc88:

  dfu: Fix dfu_config_interfaces() for single interface DFU syntax (2025-07-15 11:27:19 +0200)

----------------------------------------------------------------
u-boot-dfu-20250716

Android:
- Fix printing lbaint_t format in AVB and android_ab messages

DFU:
- Fix dfu_config_interfaces() for single interface DFU syntax

----------------------------------------------------------------
Sam Protsenko (1):
      dfu: Fix dfu_config_interfaces() for single interface DFU syntax

Tom Rini (2):
      boot/android_ab.c: Make use of LBAF for printing lbaint_t
      common/avb_verify.c: Make use of LBAF for printing lbaint_t

 boot/android_ab.c   | 3 +--
 common/avb_verify.c | 4 ++--
 drivers/dfu/dfu.c   | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)
