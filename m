Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651B5CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F658004F;
	Tue,  4 Nov 2025 13:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="qdH3hO5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D644832AD; Tue,  4 Nov 2025 13:56:09 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66CFE8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6A2BCC9D1E; Tue,  4 Nov 2025 13:56:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762260966; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=tWJEbEYE4BmkZoQPNiwqR7l20efB+K9n8H37unxArrI=;
 b=qdH3hO5MDSTgwIhaRQN5xyqu/MFWeXvbkxUTyfj+5HGQGB7bN56H254SHMj36xFsjI8dI6
 uPcdppbgTxRr3ax1PL1zvm/sd3NTdN8JOvjWvvBwY9FSRfaMlh7AM5f4ngiKk3HScheQA/
 3A+HmUbJVcjyl+l6aVdRLbuzPuNEYMnnRSk4m3Wig6gPl95Ex5tyNNhiebh3aZhPo8s/nE
 F6WEhPmgaZn0mznFfPL1C8o2ZalfRQxthv/TUuL7LuXhKmRfl9HRZPvKeldiyg0owG7Zt9
 h6jLT4yoJuOpw6UalfBirmB6GpaHpC9eS6QZa1JGNqDRyqbKdWIVVgYrtIZmag==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Annette Kobou <annette.kobou@kontron.de>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oualid Derouiche <oualid.derouiche@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/4] imx: kontron: Add support for HW UIDs in OTPs
Date: Tue,  4 Nov 2025 13:54:24 +0100
Message-ID: <20251104125441.138131-1-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

SoMs and boards that are manufactured at Kontron Electronics
Germany (KED) get UIDs programmed to the OTP fuses. This adds support
for extracting them from the fuses and exporting them to the serial
console and Linux.

Frieder Schrempf (4):
  imx: kontron-sl-mx6ul: Enable CONFIG_BOARD_LATE_INIT to fix auto
    fastboot
  imx: kontron: Add common function to get HW UIDs from OTPs
  imx: kontron-sl-mx6ul: Add support for reading HW UIDs
  imx: kontron-sl-mx8mm: Add support for reading HW UIDs

 board/kontron/common/Kconfig       | 14 ++++++
 board/kontron/common/Makefile      |  1 +
 board/kontron/common/hw-uid.c      | 75 ++++++++++++++++++++++++++++++
 board/kontron/common/hw-uid.h      | 26 +++++++++++
 board/kontron/sl-mx6ul/Kconfig     |  2 +
 board/kontron/sl-mx6ul/sl-mx6ul.c  | 32 +++++++++++++
 board/kontron/sl-mx8mm/Kconfig     |  2 +
 board/kontron/sl-mx8mm/sl-mx8mm.c  | 32 +++++++++++++
 configs/kontron-sl-mx6ul_defconfig |  2 +
 configs/kontron-sl-mx8mm_defconfig |  1 +
 10 files changed, 187 insertions(+)
 create mode 100644 board/kontron/common/Kconfig
 create mode 100644 board/kontron/common/Makefile
 create mode 100644 board/kontron/common/hw-uid.c
 create mode 100644 board/kontron/common/hw-uid.h

-- 
2.51.0

