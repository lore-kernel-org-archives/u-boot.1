Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A92C6FD35
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D853E88B6D;
	Thu, 29 Aug 2024 10:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GLlu5z2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F4988B5F; Thu, 29 Aug 2024 10:08:57 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D6C88950
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B2DA7A43C65;
 Thu, 29 Aug 2024 08:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D93C4CEC1;
 Thu, 29 Aug 2024 08:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724918933;
 bh=lENNgOGW6BODha8L5dePNApGzc2Y6hJKe5wHx67bZng=;
 h=From:To:Cc:Subject:Date:From;
 b=GLlu5z2XqgXZyZHl+vJa3pjZ9PL3m/TVTODBdN0bmLbmauF91Q8NUiZmnMehqMkSX
 W8qdGLOOph9nkHRLLNeaZSUyxCI6w2vtwtgG2DuDffaW/DSrDA51bCWAzZpFvs1o+r
 NZMqTUSUbfZYLnf2RUlMXb80Bl+/QM+OmH6S7Q5dCAl7WF44ygXGuEFkPb8OC2z9Gm
 Qv7rTq0YBaYBMGmRKDAAiQGXrQkPw6wAqmFvkZB31QuS3HX2l4V9jpFoZrtQSnJfXU
 VwLsr4WX0rjVnwOtBprax3ebtFKOIIMF7O6qVw7iLFdw162JHSRRMyZl0lF13vNdwb
 hjV0bWZLP8t7Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 0/3] Turris Omnia DDR speed change with reset
 button (for 2024.10)
Date: Thu, 29 Aug 2024 10:08:46 +0200
Message-ID: <20240829080849.20276-1-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hello Stefan,

this series adds the ability to select 1333H DDR speed mode for DDR
training (instead of the default 1600K) with the factory reset button.

If possible, I would like if this series went for U-Boot 2024.10
release. The heavy stuff to support DDR speed change is already in,
this just adds the ability to do it with reset button instead of
console command (which is inconvenient for most users).

On Omnia, the user can select factory reset type by pressing the reset
button on the rear panel and holding it. The front LEDs light on in
sequence, representing a counter. Every ~2.5 second another LED lights
on. When only the first LED is on, the board will do a standard reboot.
Then different kinds of factory reboot will happen for reset types 1 to
7 (when 1, 2, ... or 7 LEDs are on) [1].

This series adds another reset type, number 10, which will make the
board boot in 1333H DDR speed mode, and also write this setting to
EEPROM, so that subsequent boots will also train in 1333H mode.

The user can set back the default mode with the `eeprom` U-Boot command,
or with the `omnia-eeprom` Linux command.

Marek

[1] https://docs.turris.cz/hw/omnia/rescue-modes/

Marek Behún (3):
  arm: mvebu: turris_omnia: Rename variable holding EEPROM udevice
  arm: mvebu: turris_omnia: Use the i2c_eeprom misc driver for EEPROM
    reading in U-Boot proper
  arm: mvebu: turris_omnia: Switch DDR speed to 1333H when reset 9 is
    selected

 arch/arm/mach-mvebu/Kconfig              |   1 +
 board/CZ.NIC/turris_omnia/turris_omnia.c | 101 +++++++++++++++++++----
 configs/turris_omnia_defconfig           |   1 -
 3 files changed, 86 insertions(+), 17 deletions(-)

-- 
2.44.2

