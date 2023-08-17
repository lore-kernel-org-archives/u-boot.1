Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6512BC27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 05:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3038786A18;
	Thu, 17 Aug 2023 07:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="X2ig2ap2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBF086A33; Thu, 17 Aug 2023 07:45:06 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1B686A45
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:mime-version:to:cc:content-transfer-encoding:
 content-type:cc:content-type:from:subject:to;
 s=s1; bh=5IYNqnjIl+SM53TqLBseV/YTS8g+ZQqiawiOe3bVa7k=;
 b=X2ig2ap2siYU+D5cH7V5DVEesuOA2joQAepfIrPTL5RXKw+pt8pg3wBXeI4NUHhrN7GC
 /3Fj58gEn8+PyocI5Akcymij7GdCjfVWJha9GT02K/xGxn9KF8YuK4FS3hEBmMYZowY/MG
 w0Hn7S9CLM5bOHUV7AcAl3h4EfGIDzS+U9r4z09h7oI7k0zkkXnDfMSntVVt2KUdIFlbiy
 zODFI7KuPX6Rr1c5CwkNkIe38aM+RExJ3nztlmBBBiABca9+OGGmPCIL7lU9iPStnfWUqY
 GdlniajTIiSwgRTe2XR/ECoZdy9rSsY7PCFtJzJekWmlxRnyiDbNm1C5Oq9S+ltA==
Received: by filterdrecv-65f68489c8-nnkmk with SMTP id
 filterdrecv-65f68489c8-nnkmk-1-64DDB3DD-D
 2023-08-17 05:45:01.158452216 +0000 UTC m=+8489343.094585337
Received: from bionic.localdomain (unknown) by geopod-ismtpd-canary-0 (SG)
 with ESMTP id 3xj0WBfNTS-AQuRMXP7e6Q
 Thu, 17 Aug 2023 05:45:00.828 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] rockchip: rk356x: Enable poweroff command
Date: Thu, 17 Aug 2023 05:45:01 +0000 (UTC)
Message-ID: <20230817054457.472342-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h4dmEpP8WKXy=2FmeIM?=
 =?us-ascii?Q?sKnwSSBFbKlWSJAupYsn1wmXbUPgEpURR53XjQy?=
 =?us-ascii?Q?7uioxuEpkdB0G3PAYRlvDscVc7MURMSAkHDS0+A?=
 =?us-ascii?Q?JWiv44aJ5YPLZhvwC9K1GW4sAgyh8qmoMMrgdua?=
 =?us-ascii?Q?u96zhtVMC1gQZTcO6BFucUO2a7JvyWG9fukLlZ?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

This series enable CMD_POWEROFF on a few RK356x boards that have a power
button wired to PMIC pwron.

The poweroff command is useful for testing and make it possible to
poweroff the device from U-Boot and have it turn back on when the power
button is pressed.

First patch ensure sysreset poweroff implementation is used.
Second patch enable poweroff cmd on a few RK356x boards.

Changes in v2:
- Split patch
- Collect r-b tag

Jonas Karlman (2):
  power: pmic: rk8xx: Use sysreset implementation of the poweroff
    command
  rockchip: rk356x: Enable poweroff command

 configs/quartz64-a-rk3566_defconfig       | 1 +
 configs/quartz64-b-rk3566_defconfig       | 1 +
 configs/rock-3a-rk3568_defconfig          | 1 +
 configs/soquartz-model-a-rk3566_defconfig | 1 +
 drivers/power/pmic/Kconfig                | 1 +
 5 files changed, 5 insertions(+)

-- 
2.41.0

