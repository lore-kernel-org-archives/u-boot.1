Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB84C27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E0E1889BB;
	Fri, 14 Jun 2024 18:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD1A88A08; Fri, 14 Jun 2024 18:54:34 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EE9F889B7
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W153W63PRzhv9;
 Fri, 14 Jun 2024 18:54:31 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W153V3fmjzK4n; Fri, 14 Jun 2024 18:54:30 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 0/3] rockchip: px30: add IO domain driver
Date: Fri, 14 Jun 2024 18:54:11 +0200
Message-Id: <20240614-px30-io-domain-v1-0-9552966d3911@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALN1bGYC/x3MQQqAIBBA0avErBsYU6K6SrSwnGoWaWiEEN09a
 fkW/z+QOAonGKoHIt+SJPgCVVew7NZvjOKKoaHGUKsMnlkTSkAXDiseqW81z50zpBWU6Iy8Sv6
 HI3jOF0zv+wHqp7E9ZgAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

This adds the IO domain driver for PX30 by importing the appropriate
bits from the Linux kernel driver, similarly to what's been done for
RK3399 in the past.

However for this driver to probe, syscon_px30 driver needs to be fixed
to probe children of its syscon DT nodes, so this is fixed as well.

Finally, enable this on PX30 Ringneck.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      rockchip: px30: bind sub-nodes for GRF (syscon)
      rockchip: io-domain: add support for PX30
      rockchip: ringneck-px30: enable IO domain

 arch/arm/mach-rockchip/px30/syscon_px30.c |  3 ++
 configs/ringneck-px30_defconfig           |  1 +
 drivers/misc/rockchip-io-domain.c         | 66 +++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
---
base-commit: 0f4e1025ad2ff19095b754229ffec4527380dae1
change-id: 20240614-px30-io-domain-0963eb8d4031

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

