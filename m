Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6273CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 09:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B81E8318E;
	Wed, 10 Sep 2025 11:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D955783214; Wed, 10 Sep 2025 11:23:41 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 79F0D830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 10 Sep 2025 18:23:34 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id A653C2091499;
 Wed, 10 Sep 2025 18:23:34 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Wed, 10 Sep 2025 18:23:34 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
 by kinkan3.css.socionext.com (Postfix) with ESMTP id 1DC331757;
 Wed, 10 Sep 2025 18:23:34 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: u-boot@lists.denx.de
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] qemu-sbsa: Fix GIC enablement
Date: Wed, 10 Sep 2025 18:23:25 +0900
Message-Id: <20250910092327.279749-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In the qemu-sbsa configuration, the GICv3 definition is disabled due to
a typo. After fixing the typo, GICv3 is enabled, however, the GIC register
base address definitions are missing, resulting in a build failure.

This series enables GICv3 and resolves this build error.
Confirming that U-Boot successfully starts up in QEMU SBSA environment
after the fix.

Kunihiko Hayashi (2):
  configs: qemu-sbsa: Define GIC register base address
  board: qemu-sbsa: Fix mistyped GICV3 definition

 board/emulation/qemu-sbsa/Kconfig | 2 +-
 include/configs/qemu-sbsa.h       | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1

