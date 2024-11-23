Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1966DE66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE7F891B1;
	Sat, 23 Nov 2024 22:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UglmoL8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FA288EA8; Sat, 23 Nov 2024 22:44:13 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CEF88EA8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CD82A5C23D2;
 Sat, 23 Nov 2024 21:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1096C4CECD;
 Sat, 23 Nov 2024 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732398246;
 bh=vECMh0vXT2dkLSajgRKTGZ08ybszK/IzrNZIMpbD/Pg=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=UglmoL8YODpOv7MwIh68+4sL3VjD98QAudjFesaO7ZnGeHvDZt3q2odIlFJc+vnRW
 SrrFEgCJqLCnzXGMj3SRHp5Q2k6NOjxA/8ofSztDneZA6u+yCIY1H9s42ePKyUDO17
 tRtMEJ4aUyfOIN7/zy0+oMQyHyWbTnEpRt1mSNTlASmnZi3A1CSdo2IUhST2RYylWY
 9DL2XrFnxEQpCY6yxn0I7qPhhkzJks6h0KErW4U3D+D0jcU26IWH8RLlbFbyZCssMW
 +wCgfnSq1W+n5FVo0J2h6e12ymsh/U6Tg5rnWMRR/Ex/lRRM6kNA9alki0qnJJsaXo
 NM6orfrhiNr3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BB6FBE66882;
 Sat, 23 Nov 2024 21:44:06 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH v2 0/2] Fix device removal order for Apple dart iommu
Date: Sat, 23 Nov 2024 22:44:03 +0100
Message-Id: <20241123-iommu_apple_dart_ordering-v2-0-cc2ade6dde97@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKNMQmcC/42NQQ6CMBBFr0JmbQ2tUJCV9zCEVDvCGGmbthAN6
 d2tnMDle8l/f4OAnjBAV2zgcaVA1mQQhwLukzIjMtKZQZSi4uWJM7LzvAzKuRcOWvk4WK9zwoy
 srluUQja85gLy3nl80HtvX/vME4Vo/We/WvnP/lNdOStZq2TbNOdKanm7PJUxajkajNCnlL6zw
 bBJwwAAAA==
X-Change-ID: 20241031-iommu_apple_dart_ordering-558e62671512
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=vECMh0vXT2dkLSajgRKTGZ08ybszK/IzrNZIMpbD/Pg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQnn6X7VDR4Z5/iXz5zX9Lxc0eONgguY/0y+8aPD4u3r
 LjPH3LNpKOUhUGMi0FWTJElSftlB8PqGsWY2gdhMHNYmUCGMHBxCsBEdDIZ/ifNuFRo23v8ROfO
 MsuOJ/ICtTuvrHwYmOMpw23PG1i7dSLD/8zpn96J+Orna926LPxinqeFU2rsZ65viwqDV2XZtaS
 I8wAA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Starting with v2024.10 dev_iommu_dma_unmap calls during device removal
trigger a NULL pointer dereference in the Apple dart iommu driver. The
iommu device is removed before its user. The sparsely used DM_FLAG_VITAL
flag is intended to describe this dependency. Add it to the driver.

Adding this flag is unfortunately not enough since the boot routines
except the arm one simply remove all drivers. Add and use a new function
which calls
    dm_remove_devioce_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
    dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
to ensure this order dependency is head consistently.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- added Mark's Ab: for Patch 1
- add dm_remove_device_active() and replace existing
  dm_remove_device_flags(DM_REMOVE_ACTIVE_ALL) with it (ignoring test
  code)
- Link to v1: https://lore.kernel.org/r/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net

---
Janne Grunau (2):
      iommu: apple: Mark device with DM_FLAG_VITAL
      dm: Add dm_remove_devices_active() for ordered device removal

 arch/arm/lib/bootm.c          |  7 +++---
 arch/riscv/lib/bootm.c        |  2 +-
 arch/x86/lib/bootm.c          |  2 +-
 drivers/core/root.c           |  7 ++++++
 drivers/iommu/apple_dart.c    |  2 +-
 include/dm/root.h             | 10 +++++++++
 lib/efi_loader/efi_boottime.c |  2 +-
 test/dm/core.c                | 50 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 74 insertions(+), 8 deletions(-)
---
base-commit: cca05617a8f585f3a98a8fa82f75cc68a530d771
change-id: 20241031-iommu_apple_dart_ordering-558e62671512

Best regards,
-- 
Janne Grunau <j@jannau.net>


