Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8440606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z5uE2JMC;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pDQsbpaP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BFE340807;
	Mon, 16 Nov 2026 17:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tmZk7tG8C02O; Mon, 16 Nov 2026 17:41:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1923140583
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850860;
	b=rDzujgx5588iKC2CLnL6E9/958rfRt189GadRXHhQXK0mmT6tJ3IgIHM0/yXOQY+UFe+
	 ABe/DPBoyN4WiKcyctRRAfn9n1xOtkHhbHpj+XHKIz9bYCIiJFod/1UDsI9w/ipYPVd69
	 cwcbKdq8PArhq3ZG9A3TzF96PpMP/BkHipObuUuMvdeP9YGi33ppGByi3TasZ3YWB8H3I
	 +l+eGgXWeBJb+LGgYRPtKU9tDkZdDvCa7ud75G/C+VuZz+VxEubeq+TUamxIcPzvwKq3g
	 MEY17alDGxAZ61AxFXW0SjwWCYjHrtx1stmzgc7Q/nfF8hYIo/cC+gR9VETeB9c8hXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4PEOsb0Cd5/68vqwNpTCxWQENO+GoAHo4NP0dNUlN58=;
	b=sZ3h+23uFqe9oz6xAtT7kbelrJAfAMx2yFjidysR619G+MhWYerlEZKjUjqcRJWRUUMc
	 MEtH5WhEJj5QrXVGwo/5+ktdyuo7ptYwvPdp+T9gfGWwCAIoRfb7cFJths6kkVaW5trgA
	 nfUvV8xq0+dQsoDEYbrx7E7EPIsktqJ3zTpVoLVlaKtiC37JnH9SIilCgjyKPKpJeqJps
	 IBi8IaQ6Pu2PY/Fg6RqvyVbhTrpvE4aAGD5chmfMg9iIiNq4gNnia0biUjnq9LC5EiP2S
	 HB9MRUfNErdXvGz6e3CHHx9YOtr25FG2T669TSidPt7sjGvGK3jmZ525INsE0zEwTQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pDQsbpaP;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850860;
	bh=4PEOsb0Cd5/68vqwNpTCxWQENO+GoAHo4NP0dNUlN58=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z5uE2JMCY1+h307LoabR89fTuGAs8S+cqZa3OGwPY9qgaGu7vdXB6lG6LXCimzMW9
	 Y94m6hoYddn8czdJsu4andOQIf5mvU8oHFKu9bOH9cdHHdRwdzcdyl+3S+z6OkjQH0
	 CgVJIPF0fNx0V/C/CmQUjme/8s7+o0VrXJY7VkpRyBtGezXVKl0a1lI9/f5slBRzhY
	 SonEu8Cf4+HHMOrCmtrpNqZmK9+zJvmdsbZyO7Ljq108kPQ0r/8Gm7VDy0euRVRLxv
	 do85p3vYMVS0UfBIHAV7fv3G/RJAMI35fquGkh+rphuzVoY7dHq+/p8w4DUWtsu7X7
	 hgcPPnk3qZeIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1923140583;
	Mon, 16 Nov 2026 17:41:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 52CBF169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44A0D40583
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:40:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xZ8rR-gJWDMd for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:40:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B63CE4056F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=pDQsbpaP
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B63CE4056F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:40:57 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSwBZ4c1gzMllW;
 Mon, 16 Nov 2026 18:40:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4PEOsb0Cd5/68vqwNpTCxWQENO+GoAHo4NP0dNUlN58=;
 b=pDQsbpaPH46UKk2726LPpHGUh4RT8pchnXP1/NSQhorLvc15CRF/zG6woo6+OD3gkm64l0
 UWvlW6mOEnDAUDcd8ZoMH+8CX1nkj9NnUmZYyU7Qbuzd9KJ/N4lzYFXOgZ3f9Bni/csqVq
 B27WGE6R+P8ZNS55Kv/KvTaupDWStcpv3vVd2/QyQ8BgSMSiQRWGncIHOtG/szi6DjN+Bk
 FEmFC1Pg8Np/8d7G8Gu3AU9d1G+u436ne9MJRovcMJ0pT7sl9jBAZzwPrblvBfAU9/Kcyw
 AZswiHFbrcGFiWvoCQrHfA0TkwfXgIYisarLwiYhF4HQDjeTX6VU5xCr+1MpnQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 David Lechner <dlechner@baylibre.com>, Eugen Hristev <ehristev@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Janne Grunau <j@jannau.net>,
 Joel Stanley <joel@jms.id.au>, Mark Kettenis <kettenis@openbsd.org>,
 Matthias Brugger <mbrugger@suse.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefan Bosch <stefan_b@posteo.net>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] pinctrl: Constify driver ops
Date: Mon, 16 Nov 2026 18:40:38 +0100
Message-ID: <20261116174048.3488151-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 256e3c8aa8e62a8d1c6
X-MBO-RS-META: 4wskzhxq7sj4zjo75ot6bxxk547hrnmc
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Eugen Hristev <ehristev@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Janne Grunau <j@jannau.net>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Bosch <stefan_b@posteo.net>
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/pinctrl/aspeed/pinctrl_ast2500.c    | 2 +-
 drivers/pinctrl/aspeed/pinctrl_ast2600.c    | 2 +-
 drivers/pinctrl/broadcom/pinctrl-bcm283x.c  | 2 +-
 drivers/pinctrl/exynos/pinctrl-exynos7420.c | 2 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c       | 2 +-
 drivers/pinctrl/nexell/pinctrl-s5pxx18.c    | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c   | 2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c   | 2 +-
 drivers/pinctrl/nxp/pinctrl-mxs.c           | 2 +-
 drivers/pinctrl/pinctrl-apple.c             | 4 ++--
 drivers/pinctrl/pinctrl-at91.c              | 8 ++++----
 drivers/pinctrl/pinctrl-scmi.c              | 2 +-
 drivers/pinctrl/pinctrl-sx150x.c            | 4 ++--
 drivers/pinctrl/pinctrl-zynqmp.c            | 2 +-
 drivers/pinctrl/pinctrl_pic32.c             | 2 +-
 drivers/pinctrl/pinctrl_stm32.c             | 2 +-
 drivers/pinctrl/renesas/pfc.c               | 2 +-
 drivers/pinctrl/renesas/pinctrl-rzn1.c      | 2 +-
 18 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2500.c b/drivers/pinctrl/aspeed/pinctrl_ast2500.c
index 5ecd3f262b9..69e5d5b5618 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2500.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2500.c
@@ -104,7 +104,7 @@ static int ast2500_pinctrl_group_set(struct udevice *dev, unsigned selector,
 	return 0;
 }
 
-static struct pinctrl_ops ast2500_pinctrl_ops = {
+static const struct pinctrl_ops ast2500_pinctrl_ops = {
 	.set_state = pinctrl_generic_set_state,
 	.get_groups_count = ast2500_pinctrl_get_groups_count,
 	.get_group_name = ast2500_pinctrl_get_group_name,
diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2600.c b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
index af3eeacba51..51f2c8e83ef 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2600.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
@@ -593,7 +593,7 @@ static int ast2600_pinctrl_group_set(struct udevice *dev, unsigned selector, uns
 	return 0;
 }
 
-static struct pinctrl_ops ast2600_pinctrl_ops = {
+static const struct pinctrl_ops ast2600_pinctrl_ops = {
 	.set_state = pinctrl_generic_set_state,
 	.get_groups_count = ast2600_pinctrl_get_groups_count,
 	.get_group_name = ast2600_pinctrl_get_group_name,
diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
index 90eee88eb13..ab6306bff14 100644
--- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
+++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
@@ -254,7 +254,7 @@ int bcm283x_pinctl_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct pinctrl_ops bcm283x_pinctrl_ops = {
+static const struct pinctrl_ops bcm283x_pinctrl_ops = {
 	.set_state	= bcm283x_pinctrl_set_state,
 	.get_gpio_mux	= bcm283x_pinctrl_get_gpio_mux,
 };
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos7420.c b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
index b1d983fd383..3c73d0e1b7e 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos7420.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
@@ -48,7 +48,7 @@ static int exynos7420_pinctrl_request(struct udevice *dev, int peripheral,
 	return 0;
 }
 
-static struct pinctrl_ops exynos7420_pinctrl_ops = {
+static const struct pinctrl_ops exynos7420_pinctrl_ops = {
 	.set_state	= exynos_pinctrl_set_state,
 	.request	= exynos7420_pinctrl_request,
 };
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index 0d5fa4ceb9c..2d1621d16d7 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -214,7 +214,7 @@ int mvebu_pinctl_probe(struct udevice *dev)
 	return mvebu_pinctrl_set_state_all(dev, dev);
 }
 
-static struct pinctrl_ops mvebu_pinctrl_ops = {
+static const struct pinctrl_ops mvebu_pinctrl_ops = {
 	.set_state	= mvebu_pinctrl_set_state
 };
 
diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
index aeed3f1e1e1..a6e9bc0ea0d 100644
--- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
+++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
@@ -179,7 +179,7 @@ static int s5pxx18_pinctrl_set_state(struct udevice *dev,
 	return 0;
 }
 
-static struct pinctrl_ops s5pxx18_pinctrl_ops = {
+static const struct pinctrl_ops s5pxx18_pinctrl_ops = {
 	.set_state	= s5pxx18_pinctrl_set_state,
 };
 
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 92513822e70..8d7a9641230 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1594,7 +1594,7 @@ static int npcm7xx_pinconf_set(struct udevice *dev, unsigned int pin,
 
 #endif
 
-static struct pinctrl_ops npcm7xx_pinctrl_ops = {
+static const struct pinctrl_ops npcm7xx_pinctrl_ops = {
 	.set_state	= pinctrl_generic_set_state,
 	.get_pins_count = npcm7xx_get_pins_count,
 	.get_pin_name = npcm7xx_get_pin_name,
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 29536f556ad..55c322aa604 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -984,7 +984,7 @@ static void npcm8xx_pinctrl_clear_events(struct npcm8xx_pinctrl_priv *priv)
 	}
 }
 
-static struct pinctrl_ops npcm8xx_pinctrl_ops = {
+static const struct pinctrl_ops npcm8xx_pinctrl_ops = {
 	.set_state	= pinctrl_generic_set_state,
 	.get_pins_count = npcm8xx_get_pins_count,
 	.get_pin_name = npcm8xx_get_pin_name,
diff --git a/drivers/pinctrl/nxp/pinctrl-mxs.c b/drivers/pinctrl/nxp/pinctrl-mxs.c
index 8b764738014..fdecc3f359d 100644
--- a/drivers/pinctrl/nxp/pinctrl-mxs.c
+++ b/drivers/pinctrl/nxp/pinctrl-mxs.c
@@ -145,7 +145,7 @@ static int mxs_pinctrl_set_state(struct udevice *dev, struct udevice *conf)
 	return 0;
 }
 
-static struct pinctrl_ops mxs_pinctrl_ops = {
+static const struct pinctrl_ops mxs_pinctrl_ops = {
 	.set_state = mxs_pinctrl_set_state,
 };
 
diff --git a/drivers/pinctrl/pinctrl-apple.c b/drivers/pinctrl/pinctrl-apple.c
index 083ea6d6cd5..78999233df4 100644
--- a/drivers/pinctrl/pinctrl-apple.c
+++ b/drivers/pinctrl/pinctrl-apple.c
@@ -96,7 +96,7 @@ static int apple_gpio_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_gpio_ops apple_gpio_ops = {
+static const struct dm_gpio_ops apple_gpio_ops = {
 	.get_value = apple_gpio_get_value,
 	.set_value = apple_gpio_set_value,
 	.get_function = apple_gpio_get_direction,
@@ -182,7 +182,7 @@ static int apple_pinctrl_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct pinctrl_ops apple_pinctrl_ops = {
+static const struct pinctrl_ops apple_pinctrl_ops = {
 	.set_state = pinctrl_generic_set_state,
 	.get_pins_count = apple_pinctrl_get_pins_count,
 	.get_pin_name = apple_pinctrl_get_pin_name,
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 50a130d700f..300c912b928 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -304,13 +304,13 @@ static void at91_mux_sam9x60_set_slewrate(struct at91_port *pio, u32 pin,
 	writel(tmp, reg);
 }
 
-static struct at91_pinctrl_mux_ops at91rm9200_ops = {
+static const struct at91_pinctrl_mux_ops at91rm9200_ops = {
 	.mux_A_periph	= at91_mux_set_A_periph,
 	.mux_B_periph	= at91_mux_set_B_periph,
 	.set_deglitch	= at91_mux_set_deglitch,
 };
 
-static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
+static const struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 	.mux_A_periph	= at91_mux_pio3_set_A_periph,
 	.mux_B_periph	= at91_mux_pio3_set_B_periph,
 	.mux_C_periph	= at91_mux_pio3_set_C_periph,
@@ -322,7 +322,7 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
 	.set_drivestrength = at91_mux_sam9x5_set_drivestrength,
 };
 
-static struct at91_pinctrl_mux_ops sama5d3_ops = {
+static const struct at91_pinctrl_mux_ops sama5d3_ops = {
 	.mux_A_periph	= at91_mux_pio3_set_A_periph,
 	.mux_B_periph	= at91_mux_pio3_set_B_periph,
 	.mux_C_periph	= at91_mux_pio3_set_C_periph,
@@ -334,7 +334,7 @@ static struct at91_pinctrl_mux_ops sama5d3_ops = {
 	.set_drivestrength = at91_mux_sama5d3_set_drivestrength,
 };
 
-static struct at91_pinctrl_mux_ops sam9x60_ops = {
+static const struct at91_pinctrl_mux_ops sam9x60_ops = {
 	.mux_A_periph	= at91_mux_pio3_set_A_periph,
 	.mux_B_periph	= at91_mux_pio3_set_B_periph,
 	.mux_C_periph	= at91_mux_pio3_set_C_periph,
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index fa31b573f31..5e4305d7f76 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -196,7 +196,7 @@ static int pinctrl_scmi_pinconf_group_set(struct udevice *dev, u32 group, u32 pa
 	return scmi_pinctrl_settings_configure_one(dev, SCMI_GROUP, group, param, argument);
 }
 
-static struct pinctrl_ops scmi_pinctrl_ops = {
+static const struct pinctrl_ops scmi_pinctrl_ops = {
 	.get_pins_count = pinctrl_scmi_get_pins_count,
 	.get_pin_name = pinctrl_scmi_get_pin_name,
 
diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 0d64f4d5ad6..f41656b1b67 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -692,7 +692,7 @@ static int sx150x_gpio_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct dm_gpio_ops sx150x_gpio_ops = {
+static const struct dm_gpio_ops sx150x_gpio_ops = {
 	.get_value = sx150x_gpio_get_value,
 	.set_value = sx150x_gpio_set_value,
 	.get_function = sx150x_gpio_get_direction,
@@ -886,7 +886,7 @@ static int sx150x_pinctrl_probe(struct udevice *dev)
 	return 0;
 }
 
-static struct pinctrl_ops sx150x_pinctrl_ops = {
+static const struct pinctrl_ops sx150x_pinctrl_ops = {
 	.set_state = pinctrl_generic_set_state,
 	.get_pins_count = sx150x_pinctrl_get_pins_count,
 	.get_pin_name = sx150x_pinctrl_get_pin_name,
diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 0b936684f8a..2a16dec80a2 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -630,7 +630,7 @@ static const struct pinconf_param zynqmp_conf_params[] = {
 	{"schmitt-cmos", PIN_CONFIG_SCHMITTCMOS, PM_PINCTRL_INPUT_TYPE_SCHMITT},
 };
 
-static struct pinctrl_ops zynqmp_pinctrl_ops = {
+static const struct pinctrl_ops zynqmp_pinctrl_ops = {
 	.get_pins_count = zynqmp_pinctrl_get_pins_count,
 	.get_pin_name = zynqmp_pinctrl_get_pin_name,
 	.get_pin_muxing = zynqmp_pinctrl_get_pin_muxing,
diff --git a/drivers/pinctrl/pinctrl_pic32.c b/drivers/pinctrl/pinctrl_pic32.c
index 090351072d8..00e85b6cbeb 100644
--- a/drivers/pinctrl/pinctrl_pic32.c
+++ b/drivers/pinctrl/pinctrl_pic32.c
@@ -327,7 +327,7 @@ static int pic32_pinctrl_set_state_simple(struct udevice *dev,
 	return pic32_pinctrl_request(dev, func, 0);
 }
 
-static struct pinctrl_ops pic32_pinctrl_ops = {
+static const struct pinctrl_ops pic32_pinctrl_ops = {
 	.set_state_simple	= pic32_pinctrl_set_state_simple,
 	.request		= pic32_pinctrl_request,
 	.get_periph_id		= pic32_pinctrl_get_periph_id,
diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
index 1758f9a909c..1db111628d9 100644
--- a/drivers/pinctrl/pinctrl_stm32.c
+++ b/drivers/pinctrl/pinctrl_stm32.c
@@ -533,7 +533,7 @@ static int stm32_pinctrl_set_state_simple(struct udevice *dev,
 }
 #endif /* PINCTRL_FULL */
 
-static struct pinctrl_ops stm32_pinctrl_ops = {
+static const struct pinctrl_ops stm32_pinctrl_ops = {
 #if CONFIG_IS_ENABLED(PINCTRL_FULL)
 	.set_state		= stm32_pinctrl_set_state,
 #else /* PINCTRL_FULL */
diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
index 1e0fc3f563d..03f1524e9e4 100644
--- a/drivers/pinctrl/renesas/pfc.c
+++ b/drivers/pinctrl/renesas/pfc.c
@@ -909,7 +909,7 @@ static int sh_pfc_pinconf_group_set(struct udevice *dev,
 }
 #endif
 
-static struct pinctrl_ops sh_pfc_pinctrl_ops = {
+static const struct pinctrl_ops sh_pfc_pinctrl_ops = {
 	.get_pins_count		= sh_pfc_pinctrl_get_pins_count,
 	.get_pin_name		= sh_pfc_pinctrl_get_pin_name,
 	.get_groups_count	= sh_pfc_pinctrl_get_groups_count,
diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index fdc43c8e714..2bb00aaab5d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -341,7 +341,7 @@ static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	return 0;
 }
 
-static struct pinctrl_ops rzn1_pinctrl_ops = {
+static const struct pinctrl_ops rzn1_pinctrl_ops = {
 	.set_state = rzn1_pinctrl_set_state,
 };
 
-- 
2.53.0

