Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D4CC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FB782ADA;
	Sat,  7 Jun 2025 14:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Skg20NyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C95828F8; Sat,  7 Jun 2025 07:25:31 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B578807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 07:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DAECB61136;
 Sat,  7 Jun 2025 05:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2949DC4CEE4;
 Sat,  7 Jun 2025 05:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749273926;
 bh=o6Dc3OjZTQDblXuNtvbL5BLeplo2kqAnNlOHfk1Scdk=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Skg20NyKZ5psmrOfWPfbB38WmwAcqW/7d5C/8phnxPv+y9HcdJgTAmFopbEn0qZnO
 cdVwbHgNm9QoT8XzlLuYkEdxRaypEzjp4JUIwrW+xYUQOETgkrQcxyOJOSCQfYj9lA
 y3hAEW9hfrxUY7JUM+uKtyKYXIkykOpYXohAkJ/cY8N6vP8F5QWiHs4tupfu53L4eF
 RMcnUtT/C2bjBqM/WM/8nXtTiZuaaYvbEBaY1g+WGJiV/AMB+P/5O/+zMJsdg1szny
 yRZdHgjjxLG4HwGtvV1Z/A++4LslxxFnQlzno6877//xXJ3BERORnglgInVZm/9gJ+
 CBb3aclvfp1/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 14E6FC5B543;
 Sat,  7 Jun 2025 05:25:26 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Subject: [PATCH v2 0/5] A series of patch for enable sc7180 android boot
Date: Sat, 07 Jun 2025 13:24:55 +0800
Message-Id: <20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfNQ2gC/32NQQ6CMBBFr0Jm7ZihtqG68h6GRW0HmEQoaQnRE
 O5u5QAu30v++xtkTsIZbtUGiVfJEqcC6lSBH9zUM0ooDIqUIaMIs29qS+imkKIEfMa4oLPasO+
 0ddpCWc6JO3kf1UdbeJC8xPQ5Ttb6Z//31hoJL9SYEmZHV33vRyevs48jtPu+fwFb2uv3tgAAA
 A==
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com, 
 Vitalii Skorkin <nikroks@mainlining.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749273923; l=2810;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=o6Dc3OjZTQDblXuNtvbL5BLeplo2kqAnNlOHfk1Scdk=;
 b=7nRmVit32kUOw/XBQJdkE3NFGuId3d2kxa2dPxkihwQTbDuki8bPZnxFdkMMTDPNgA1Mcub4q
 KSRrcSOglbYBUr0yRnYELBJDzb793RbimVfVKRdIVhlzw5PLgvEIFub
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sat, 07 Jun 2025 14:23:14 +0200
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

A similar logic is needed for fastboot->bootm glue function, so apply
same trick to glue function too.

Some one-liners patch is included to enable device driver for sc7180
soc. It is about iommu for usb, usb gadget vendor/product id.

Reduce dependency on abootimg when androidboot v3 or greater is not
needed. Since Tom suggested to reduce __maybe_unused directive and 
use IS_ENABLE() instead; two __weak func proto need to add into image.h

This series is independent, but modified boot/Kconfig that roughly same
location to another patch series[2], so directly apply both would fail.
Please let me know if maintainer wanna to let the one gets applied
first and rebase _OR_ combine two series as one.

[1]https://lists.denx.de/pipermail/u-boot/2025-May/588828.html
[2]https://lists.denx.de/pipermail/u-boot/2025-May/589926.html

Signed-off-by: George Chan <gchan9527@gmail.com>
---
Changes in v2:
- Add new patch #2 that is same trick as #1 to fastboot->bootm glue layer.
- Remove default n to patch #1, suggested by Tom.
- Use IS_ENABLE() instead, suggested by Tom.
- Collect review-by from Casey and Neil.
- Rebase to u-boot/next branch.
- CCing myself too.
- Link to v1: https://lore.kernel.org/r/20250520-sc7180-android-boot-v1-0-3075a84ea094@gmail.com

---
George Chan (5):
      image-android: Prepend/postpend default bootargs value with given bootcmd
      bootm: Append bootargs value when bootmeth_android provide cmdline
      boot: bootmeth_android: Conditionally dependent on abootimg
      iommu: qcom-smmu: Introduce sc7180 compatible string
      usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM

 boot/Kconfig                  |  7 +++++++
 boot/bootm.c                  | 29 ++++++++++++++++++++++++++++-
 boot/bootmeth_android.c       |  2 +-
 boot/image-android.c          | 10 ++++++++--
 drivers/iommu/qcom-hyp-smmu.c |  1 +
 drivers/usb/gadget/Kconfig    |  2 ++
 include/image.h               |  3 ++-
 7 files changed, 49 insertions(+), 5 deletions(-)
---
base-commit: a822b95da4b799bdc2a42c06923af4359238dc9e
change-id: 20250520-sc7180-android-boot-a845ecf48a48

Best regards,
-- 
George Chan <gchan9527@gmail.com>


