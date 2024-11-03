Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4758BD11195
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E0C88F94;
	Sun,  3 Nov 2024 23:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YptZJQJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEBF8911D; Sun,  3 Nov 2024 23:42:37 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1984D88EE1
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-238.46.114.pool.telefonica.de
 [46.114.105.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0C9863F1A8; 
 Sun,  3 Nov 2024 22:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730673753;
 bh=R05tUXMX8aqYiIzPK+tI+tHK2NzxuKmhRxHozB0F9Tw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YptZJQJoQrHVP08iFgQ4OG4m6tQzgoOZaECQYSOuwLGBUUslXhs5qbk6lxHQu+t2X
 INMIwhn8hHglQxsgBsbBGnGBUlCLz+CW3S59Bvvoq/W7nKPm2dsh8KaBFKaBJ4MjyP
 1daCS8yELa+ZLsdOOtyQeNB9nIRmE9nB3r5R+YaleIvtGYvjncq/RjdLqnPMkYEaQP
 X9qK0JMUbxVVSN3XiZ4tdPL/m0IERYaI3Jn/gvLv6O+aM6oC88CT8iKc3mw4woX6FV
 dBFBD2Eat8IyE37gd2+EZdZWSMhQDlcf/oTNEaBBed5qIMK6qjaMyd6I/9aVXCYC06
 DGPgM+90BS57A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
Date: Sun,  3 Nov 2024 23:42:19 +0100
Message-ID: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
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

The lib_test_uuid_to_le and lib lib_test_dynamic_uuid tests fail on
32-bit systems. But we never caught this in our CI because we never
ran any of our C unit tests on 32-bit.

Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.

hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
Use the new function hextoull() instead.

v2:
	fix uuid_str_to_bin() too

Heinrich Schuchardt (4):
  lib: provide function hextoull()
  lib: uuid: fix uuid_str_to_le_bin() on 32-bit
  lib: uuid: fix uuid_str_to_bin() on 32-bit
  configs: enable UNIT_TEST on qemu_arm_defconfig

 configs/qemu_arm_defconfig |  1 +
 include/vsprintf.h         | 13 +++++++++++++
 lib/strto.c                |  5 +++++
 lib/uuid.c                 |  5 +++--
 4 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.45.2

