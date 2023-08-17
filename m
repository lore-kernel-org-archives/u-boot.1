Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F385AEB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 06:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE3E186A63;
	Thu, 17 Aug 2023 08:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="XvOqTjNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA14186A63; Thu, 17 Aug 2023 08:04:38 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1750586A45
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=gWAOWpgG66jBlgnYACjRRfpv2xR95eLP9s1jmAsSN6k=;
 b=XvOqTjNoResqYATareP0MGchFOkyDKQa9vkAZxahddTPuvt8Xco928j27vKob/+payPS
 XuhJZ3yFrUC08GT+f7luGdCIHPwzDUdhPL5SN+IaohQ9cCyIbG+mXVBSFH912sEh66DeCU
 KaQYuWZgT/9bW+VdMmFKMrHrKRTYh2jnPEDI/ufZUUlEufEDqFfjJNuWIZyR8lovmPMXjP
 5Hg5LVq6MSmk181PunOlN+TFnuV7F7PR3pt4nObmZpNtMdyGPWhZlPu4RAGej+KAn6rKeA
 XEMJJH7ddQpO20Kz6sGh60feHMJqNGl7/DnXpALG5qVgzMVjxuLqKP38OyAAZYBw==
Received: by filterdrecv-66949dbc98-2wdbb with SMTP id
 filterdrecv-66949dbc98-2wdbb-1-64DDB872-1B
 2023-08-17 06:04:34.607999567 +0000 UTC m=+8490281.895247968
Received: from bionic.localdomain (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id nDKkVH-STSiQipTIqgjXiQ Thu, 17 Aug 2023 06:04:34.421 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/3] doc: rockchip: Add supported RK3566/RK3568 boards
Date: Thu, 17 Aug 2023 06:04:34 +0000 (UTC)
Message-ID: <20230817060422.477759-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817060422.477759-1-jonas@kwiboo.se>
References: <20230817060422.477759-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h6p72mrMXJRtQePd+?=
 =?us-ascii?Q?f3pdCSGddb9ibDJf=2FM4PpI1jQy1llLTqmKRP9gF?=
 =?us-ascii?Q?YPxo=2FI9EgISonT2OwjRxKlR8pbuQf75MZ7WdEHM?=
 =?us-ascii?Q?KF6RB50PA9ZI24OAaUAvHg6+M9=2FpEJuX4Tlui75?=
 =?us-ascii?Q?dVgCahSkZqYFzRNpucGkQYcExSiiF4J=2F+n4MNa?=
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

Update Rockchip documentation to include RK3566/RK3568 boards already
supported. Also list Pine64 boards under RK3566 and drop defconfig to
match other listed boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 doc/board/rockchip/rockchip.rst | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 31aeb8567607..4668e598515e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -91,18 +91,22 @@ List of mainline supported Rockchip boards:
      - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
 
 * rk3566
-     - Anbernic RGxx3 (rgxx3-rk3566)
+     - Anbernic RGxx3 (anbernic-rgxx3)
+     - Pine64 Quartz64-A Board (quartz64-a-rk3566)
+     - Pine64 Quartz64-B Board (quartz64-b-rk3566)
+     - Pine64 SOQuartz on Blade (soquartz-blade-rk3566)
+     - Pine64 SOQuartz on CM4-IO (soquartz-cm4-rk3566)
+     - Pine64 SOQuartz on Model A (soquartz-model-a-rk3566)
+     - Radxa CM3 IO Board (radxa-cm3-io-rk3566)
 
 * rk3568
      - Rockchip Evb-RK3568 (evb-rk3568)
-     - EmbedFire Lubancat 2 (lubancat-2-rk3568_defconfig)
+     - EmbedFire LubanCat 2 (lubancat-2-rk3568)
+     - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
+     - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
      - Hardkernel ODROID-M1 (odroid-m1-rk3568)
-     - Pine64 Quartz64-A Board (quartz64-a-rk3566_defconfig)
-     - Pine64 Quartz64-B Board (quartz64-b-rk3566_defconfig)
-     - Pine64 SOQuartz on Blade (soquartz-blade-rk3566_defconfig)
-     - Pine64 SOQuartz on CM4-IO (soquartz-cm4-rk3566_defconfig)
-     - Pine64 SOQuartz on Model A (soquartz-model-a-rk3566_defconfig)
-     - Radxa E25 Carrier Board (radxa-e25-rk3568_defconfig)
+     - Radxa E25 Carrier Board (radxa-e25-rk3568)
+     - Radxa ROCK 3 Model A (rock-3a-rk3568)
 
 * rk3588
      - Rockchip EVB (evb-rk3588)
-- 
2.41.0

