Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE529C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E75C82F7F;
	Sat, 28 Jun 2025 14:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fANkoJlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5BF82D21; Sat, 28 Jun 2025 14:25:34 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E7C801BE
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 14:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 25DF360052;
 Sat, 28 Jun 2025 12:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B2CBC4CEEA;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751113522;
 bh=gCSljJ75fN3p+b6XSSkDiC+DB7wH6kriXptRXxQrOFI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=fANkoJlH3rtAzOEVq49ChtSSrn79yB7P8rd9sbukyRhDcAZBm4yUO2sJaEnhbXTJH
 48ZBVN+dtwuH7KK1xPzR/Ayw6t1ZxhtJe2Cz+l3YlMF7TUyVm6AhYUT83mnWI1Jj12
 LJYSSRUyR4wif+IfkQIIA6Dk6KkAsMtsN0oPb0PC3RGlQw6trAmD5FrZugnvkFL+rw
 9gT2YIPulgOC/qlMSbvXwO//Hg43X7W3rf7KNomMqYqA3M36kvPel0RSA7FtavZ7st
 nKbfsjjvv1HEFwvI2LYaG/InKIILFbATi4I9P+STbeyheQn93PLb+mfY5+HLy1pHAl
 WN3UIgeUI8nwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 62689C54ED1;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Subject: [PATCH v3 0/7] A series of patch for enable sc7180 android boot
Date: Sat, 28 Jun 2025 20:25:18 +0800
Message-Id: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC7fX2gC/33NTQrCMBCG4auUrI1M0qSJrryHuIj5aQe0kaQEp
 fTupt2IIC7fD+aZmWSf0GdybGaSfMGMcazR7hpiBzP2nqKrTThwCZIDzVYxDdSMLkV09BrjRI0
 W0tsgtBGa1MtH8gGfm3q+1B4wTzG9tieFret/rzAKtAUlK+wNHMSpvxu87W28k9Ur/GN0oH4bv
 BrcBelU6BjjX8ayLG9/BZh9+gAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com, 
 Vitalii Skorkin <nikroks@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751113519; l=3144;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=gCSljJ75fN3p+b6XSSkDiC+DB7wH6kriXptRXxQrOFI=;
 b=tDAFTr0b3S6JGxxIm41af5HVQUa33b272JWLBQISmBMg1wD6EmCMMWkQRx6rqfBjCBb0w3G9Y
 2oxeEPqz6xiBaJQIS2Z7W/ygplKDT53hdawatFbbnPA0xfNRqvR4Y1n
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:07 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Since attempt[1] to embed android specific boot param into fdt bootargs,
a new idea is formed as to make use of env file to contain default param
value. Current code logic is already working fine, unless the priority
of param at begining is higher than at tail. From env file, bootargs is
treated important, and prepend at begining. So there is a need to
reverse the logic, and make sure default bootargs value at the end, and
let androidboot img bootargs value sit at begining.

So a new kconfig item is introduced. Once enabled, the bootargs strcat
param will get reversed.

A similar logic is needed for fastboot->bootm glue function, so split 
function of patch #1 into 2 functions as #2, fixed some issues #3, and 
apply #4 with same trick to glue function too.

Some one-liners patch is included to enable device driver for sc7180
soc. It is about iommu for usb, usb gadget vendor/product id.

Reduce dependency on abootimg when androidboot v3 or greater is not
needed. Since Tom suggested to reduce __maybe_unused directive and 
use IS_ENABLE() instead; two __weak func proto need to add into image.h

[1]https://lists.denx.de/pipermail/u-boot/2025-May/588828.html
[2]https://lists.denx.de/pipermail/u-boot/2025-May/589926.html

Signed-off-by: George Chan <gchan9527@gmail.com>
---
Changes in v3:
- Collect acks-by and review-by.
- Split function and replace old #2 into #2-#4, code reuse in #4
- Modify changelog and Kconfig description of #1, suggested by Mattijs
- Slightly modify #5, add back line break.
- Rebase to latest next
- Link to v2: https://lore.kernel.org/r/20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com

Changes in v2:
- Add new patch #2 that is same trick as #1 to fastboot->bootm glue layer.
- Remove default n to patch #1, suggested by Tom.
- Use IS_ENABLE() instead, suggested by Tom.
- Collect review-by from Casey and Neil.
- Rebase to u-boot/next branch.
- CCing myself too.
- Link to v1: https://lore.kernel.org/r/20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com

---
George Chan (7):
      image-android: Prepend/postpend default bootargs value with given bootcmd
      boot/image-android.c: Split android_image_get_kernel into two functions
      image-android.c: Add null check to bootargs and cmdline
      bootm: Append bootargs value when bootmeth_android provide cmdline
      boot: bootmeth_android: Conditionally dependent on abootimg
      iommu: qcom-smmu: Introduce sc7180 compatible string
      usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM

 boot/Kconfig                  |   9 ++++
 boot/bootm.c                  |   2 +-
 boot/bootmeth_android.c       |   2 +-
 boot/image-android.c          | 107 +++++++++++++++++++++++++++++-------------
 drivers/iommu/qcom-hyp-smmu.c |   1 +
 drivers/usb/gadget/Kconfig    |   2 +
 include/image.h               |  14 ++++++
 7 files changed, 102 insertions(+), 35 deletions(-)
---
base-commit: 490ae8ceae2d5999c9de863e014e463f5c1495a6
change-id: 20250520-sc7180-android-boot-a845ecf48a48

Best regards,
-- 
George Chan <gchan9527@gmail.com>


