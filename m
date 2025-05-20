Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F1BC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 14:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6638082CF4;
	Tue, 20 May 2025 16:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IWW12DzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23AF82C55; Tue, 20 May 2025 16:26:04 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E5682C2F
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 16:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 17C8C4505B;
 Tue, 20 May 2025 14:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6500C4CEE9;
 Tue, 20 May 2025 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747751158;
 bh=FGMvhL5VzJ+FRv+Wa1Xojc0aHPnOaZO+iDim/8NByws=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=IWW12DzE4nZkQFFG8HtGpTv8G6AGkRRUGf61EiVlfKq9u7vkCWTndxUCC8ZpUgyk6
 ArFzWR+FWFqAlkdk9ZZZna589ehctiLew0Yl84CUYeK1FEH8P0/k3+L+uJrvg2o8Ts
 DkSBcRTSdRGF+0EfLy9nanzZKhtxIpYvZnxxQgcFK/NNRJGMf3zTt6Pm1lDZFmJtaQ
 bwuDTEO4/6wEwJtLaH34W4ojJt88M9/MjeF2Vs32gxOAHNfAMFrh+J01qY1Z+nH1MN
 zOWJVG850H/D9tTaVRUl7iDVs5IGUO6gxj3NQ0FHfcoezW7iKlfBYbVVV3JVOf0NxH
 CGq38US7/SONA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D5D59C3DA6D;
 Tue, 20 May 2025 14:25:58 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Subject: [PATCH 0/4] A series of patch for enable sc7180 android boot
Date: Tue, 20 May 2025 22:25:55 +0800
Message-Id: <20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSQLGgC/x3MQQqAIBBA0avErBtQUZKuEi1Mx5qNhkYE0t2Tl
 m/xf4NKhanCPDQodHPlnDrkOIA/XNoJOXSDEsoIowRWP0kr0KVQMgfccr7QWW3IR22dttDLs1D
 k578u6/t+A/ESvGUAAAA=
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>, Vitalii Skorkin <nikroks@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747751157; l=1755;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=FGMvhL5VzJ+FRv+Wa1Xojc0aHPnOaZO+iDim/8NByws=;
 b=KC/bYCrZM7IzlfMx9GLPIzy29T/JQFMbkMdexijPcjYu4Jrf9GIkEraj+qyOhBTW8RPxf3NSX
 VEfjmCEtIqCBCODX71AxzMlTvNLYhsNKbit+cF0hbb0qNgJAdcsJrJt
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Tue, 20 May 2025 16:26:13 +0200
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

Some one-liners patch is included to enable device driver for sc7180
soc. It is about iommu for usb, usb gadget vendor/product id, and
abootimg dependency.

Worth mentioning is as always, the EL1 jump_linux[2] logic to boot.

[1]https://lists.denx.de/pipermail/u-boot/2025-May/588828.html
[2]https://lists.denx.de/pipermail/u-boot/2025-April/585995.html

Signed-off-by: George Chan <gchan9527@gmail.com>
---
George Chan (4):
      image-android: Prepend/postpend default bootargs value with given bootcmd
      iommu: qcom-smmu: Introduce sc7180 compatible string
      boot: bootmeth_android: Conditionally dependent on abootimg
      usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM

 boot/Kconfig                  |  8 ++++++++
 boot/bootmeth_android.c       |  4 +++-
 boot/image-android.c          | 10 ++++++++--
 drivers/iommu/qcom-hyp-smmu.c |  1 +
 drivers/usb/gadget/Kconfig    |  2 ++
 5 files changed, 22 insertions(+), 3 deletions(-)
---
base-commit: 126a88d49bcae04bbfc0d6723097cd6341355ade
change-id: 20250520-sc7180-android-boot-a845ecf48a48

Best regards,
-- 
George Chan <gchan9527@gmail.com>


