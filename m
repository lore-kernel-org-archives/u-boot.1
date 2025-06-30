Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3AAC7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 08:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48B9682F30;
	Mon, 30 Jun 2025 10:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U/AJZafE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E64D80B9B; Mon, 30 Jun 2025 09:57:17 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294E781FEE
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BF2D45B52;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75396C4CEE3;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751270225;
 bh=TEIhbyiLASh+uLslJ10eWzVDzNJXy0lerC1nZOO4DwY=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=U/AJZafEl1pw6Z15RiElYr9n0N48kNDBTqe5pjVK4DBQjdD2r38e5QrcRb0VMXVOM
 sNFb4iLtta4fQJR7zIYKo5TaJDwlg/klq5NkolI5sAxXxeN5t4GsTHhj3ljsn97J4P
 tsryQXyuwWA/4gb7IHAqnjuSM//Dzg//9yw3pSn7A/kbp9ZrwZHNkBiHly7Jnu/TIO
 zd2CVOBerj8HoXhn1T8FROHEBw3JPKeQXVlAHxT1mO9oGi36KQwxSytiTaOs+w8NRx
 mtT1dvvK72B353eym8Dhns+8BQ57k63J6LUL6sjhDbBi83MJPr4e21LjEfWUDuO5Rp
 aNvtqFDabH6aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 636FFC7EE2A;
 Mon, 30 Jun 2025 07:57:05 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Subject: [PATCH v4 0/6] A series of patch for enable sc7180 android boot
Date: Mon, 30 Jun 2025 15:56:49 +0800
Message-Id: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEFDYmgC/33NTQ7CIBCG4asY1mIGCoW68h7GBfLTkthioCGap
 neXdmMTG5fvl8wzE0o2epvQ+TChaLNPPgwl2PGAdKeG1mJvSiMKlAOngJMWRAJWg4nBG3wPYcR
 KMm61Y1IxicrlM1rnX6t6vZXufBpDfK9PMlnW/14mGHAFghfYKmjYpe2Vf5x06NHiZfo1ahD7B
 i0GNY4b4WpC6I9RbQwq942qGAQ4NFKRhtR8a8zz/AF6aLvaPgEAAA==
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com, 
 Vitalii Skorkin <nikroks@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751270223; l=3271;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=TEIhbyiLASh+uLslJ10eWzVDzNJXy0lerC1nZOO4DwY=;
 b=VcB1DrC1z5YA7NYypQ1BBBPkQ/pgjWM2hYFmugGt7fIHykt48bIzEnfqhDlBiB/8Ro037Ofuu
 XRtZ2++HajED7UBbaojROQ6jKbVloMuch+kuF1pDfdf01IOzeRnOjiW
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 30 Jun 2025 10:02:49 +0200
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
Changes in v4:
- Drop patch #3.
- Refine #2 to remove intermediate variables and code style.
- Link to v3: https://lore.kernel.org/r/20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com

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
George Chan (6):
      image-android: Prepend/postpend default bootargs value with given bootcmd
      boot/image-android.c: Split android_image_get_kernel into two functions
      bootm: Append bootargs value when bootmeth_android provide cmdline
      boot: bootmeth_android: Conditionally dependent on abootimg
      iommu: qcom-smmu: Introduce sc7180 compatible string
      usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM

 boot/Kconfig                  |  9 ++++
 boot/bootm.c                  |  2 +-
 boot/bootmeth_android.c       |  2 +-
 boot/image-android.c          | 97 ++++++++++++++++++++++++++++---------------
 drivers/iommu/qcom-hyp-smmu.c |  1 +
 drivers/usb/gadget/Kconfig    |  2 +
 include/image.h               | 14 +++++++
 7 files changed, 92 insertions(+), 35 deletions(-)
---
base-commit: 490ae8ceae2d5999c9de863e014e463f5c1495a6
change-id: 20250520-sc7180-android-boot-a845ecf48a48

Best regards,
-- 
George Chan <gchan9527@gmail.com>


