Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61528CF3186
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D900D8397A;
	Wed, 19 Nov 2025 10:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dD0mEnwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD15583E1B; Wed, 19 Nov 2025 06:14:19 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACA98397A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Takahiro.Kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 38ABA60203;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0C9AC116B1;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763529255;
 bh=89mLq7jie3MLaBNSYTnKuDeA/Rgz3c2z5ponCL5nMdw=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=dD0mEnwaDSwlpxtT5x05+Kk+ICqkZaW46KIHMNq8mNxKzWDWxUOj9WrRj/H3Q2F3F
 V5y6UsPexkDacKTPfLxsoDCn48lkZQz3Euj1wGFJg2j30+XXvwfXdFu+MXQOUrclEU
 aPnfPuxfYYGyos+tS9h4Xjc7iOy5NwRCI6F5nNHcVnrK1mJI8fEf1zFzp1d7sgi6HZ
 wKO3D9Q5th6WP8hpxunyqLgu4mHfnZSpuImcZIFNPPkIVGUxcBouIm0cVdBVniICMr
 EmGTBArbWbcM6aITZSAO0/ZhIzKjI2JaAdqMJh3x/kAw5PlEFKXntllkHhEbKLK+AS
 ov216/CYOYaxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 69D09CF2570;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+Takahiro.Kuwano.infineon.com@kernel.org>
Subject: [PATCH 00/11] mtd: spi-nor: Isolate stacked/parallel support from core
Date: Wed, 19 Nov 2025 14:12:59 +0900
Message-Id: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANtRHWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0ML3cTcFN3knNTEvNIC3WQLAyNjC3OjVOPkNCWgjoKi1LTMCrBp0bG
 1tQAn32xhXQAAAA==
X-Change-ID: 20251118-amd-cleanup-c8023872e3cf
To: u-boot@lists.denx.de, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Vignesh R <vigneshr@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Havish Mutya <havish.mutya@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Daassi Bacem <Bacem.Daassi@infineon.com>, 
 Shinsuke Okada <Shinsuke.Okada@infineon.com>, 
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>, 
 Takahiro Kuwano <tkuw584924@gmail.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763529253; l=1974;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=89mLq7jie3MLaBNSYTnKuDeA/Rgz3c2z5ponCL5nMdw=;
 b=XOysCSdz7SPm34RJzyKvjnjkTbrMnpazB6msxhzgWxhol7ggAXODsHOqdpnB+y1/76y3fI6RC
 Pzy6Kb1le/YDnuhHEIUEa51TcreyC4We1jNnhurxQ9FArsmWkv/hNE4
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for Takahiro.Kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
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
Reply-To: Takahiro.Kuwano@infineon.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series suggests to isolate stacked/parallel support from
spi-nor-core by moving that to SPI controllers and new modules under
mtd/spi.

The patchset mainly focuses on removing references to stacked/parallel
related items from core. The stacked/parallel support logic itself may
have rooms to improve. Rework or further cleanup in stacked/parallel
support would be done by other patches after this series is applied.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
Takahiro Kuwano (11):
      spi: zynqmp-gqspi: Set priv->is_parallel in child_pre_probe()
      spi: zynqmp_gqspi: Remove reference to SPI_XFER_LOWER flag.
      spi: zynqmp_gqspi: Read two bytes of SR and FSR in parallel mode
      spi: zynq-qspi: Set priv->is_parallel/stacked in child_pre_probe()
      spi: zynq_qspi: Remove reference to SPI_XFER_LOWER flag.
      spi: zynq_qspi: Read two bytes of SR and FSR in parallel mode
      mtd: spi-nor: Migrate stacked/parallel part to new modules
      mtd: spi-nor: stacked: Cleanup stacked/parallel flags
      mtd: spi-nor: parallel: Cleanup stacked/parallel flags
      mtd: spi-nor: Revert stacked/parallel related commits
      mtd: spi-nor: Call stacked/parallel post init fixups

 drivers/mtd/spi/Makefile       |   4 +
 drivers/mtd/spi/parallel.c     | 412 ++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi/sf_internal.h  |  18 ++
 drivers/mtd/spi/spi-nor-core.c | 422 +++++++----------------------------------
 drivers/mtd/spi/stacked.c      | 389 +++++++++++++++++++++++++++++++++++++
 drivers/spi/zynq_qspi.c        |  47 +++--
 drivers/spi/zynqmp_gqspi.c     |  55 ++++--
 include/linux/mtd/spi-nor.h    |  10 -
 include/spi.h                  |   2 -
 9 files changed, 973 insertions(+), 386 deletions(-)
---
base-commit: e2d51f8db207f7db70dd8104fa1da2cffda419f2
change-id: 20251118-amd-cleanup-c8023872e3cf

Best regards,
-- 
Takahiro Kuwano <Takahiro.Kuwano@infineon.com>


