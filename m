Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1CDE67806
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 07:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48EA890F6;
	Sun,  3 Nov 2024 08:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lKR5v+F4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2FC890B9; Sun,  3 Nov 2024 08:12:09 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BA7890FC
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 08:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3F6BC408EA; 
 Sun,  3 Nov 2024 07:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730617926;
 bh=+V7JRx85YJ6qt5GteTnYgEHOJjklt/1KJJjRuX9zbCs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lKR5v+F4rkulDq30gfXrt21SXvoKDHR30BlJfqDOZMMYobY2JLXOXvvYd8sLyZMD+
 Jihe+9+CAuuVbp+040rcA6n/zRifYtOaGld5XsJNknG25n330pHDqtFgbnEqHAO85a
 e0n/4cVDQyurZSWCkKyBK34eWQgsNDePLL1uZ1wOA2JMLiSFxDBzwsF6RUi8DdP9iz
 D+rc6x5BJZ5SPgmBDmha3iU4EsHK61qfH5TSPlQL/o4aoC2uKjrbAc7ycSQl2RBxgD
 5f9kP2cagW87JHAvBpk/HeSarv5CBkQvAmxa5x/KsEQFtN2bugBPvAlPAiVWKNKfdE
 f/wgmEoAoN0gw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
Date: Sun,  3 Nov 2024 08:11:57 +0100
Message-ID: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The lib_test_uuid_to_le test fails on 32-bit systems. But we never caught
this in our CI because we never ran any of our C unit tests on 32-bit.

Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.

hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
Use the new function hextoull() instead.

Heinrich Schuchardt (3):
  lib: provide function hextoull()
  lib: uuid: fix uuid_str_to_le_bin() on 32-bit
  configs: enable UNIT_TEST on qemu_arm_defconfig

 configs/qemu_arm_defconfig |  1 +
 include/vsprintf.h         | 13 +++++++++++++
 lib/strto.c                |  5 +++++
 lib/uuid.c                 |  3 ++-
 4 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.45.2

