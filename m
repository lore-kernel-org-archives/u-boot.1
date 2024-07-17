Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F7EC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00338811C;
	Wed, 17 Jul 2024 10:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Cg0EFyMB";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nckkK+v2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE78488049; Wed, 17 Jul 2024 10:07:16 +0200 (CEST)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4944287F51
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 150BA11402EA;
 Wed, 17 Jul 2024 04:07:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 17 Jul 2024 04:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1721203633; x=1721290033; bh=vw
 HY9wQ6CVMq6F0t6KjDQ2iuUO2nN5K9t1/6BfFp3rw=; b=Cg0EFyMBx6tLpfBstx
 Rw2cB04JlSpvb/b6wIGnyNGhiAnrXdzrNijehKSpn8t7Pu4RFmTVQ1TO91HDbwrP
 Fqc+5QhQOk+79KtMIo/Nk/TosNRl8RNTyhyI4+R3murCLInFM8l4vN/egc/Jicv+
 5T/2QykE433TLxxITvk2HfhTWon/BRrox0d+U2FZ1gL+L9+U1FbuvKadZ5NBPY/c
 43bGlha6fVXfQquZ7jir7wXEHU+Vl5xrezAK+FuG7W1d1F5u9koAXUtZpriG92tr
 TlinNqX6ofgZH7jEDLvQY+9Eu3utXOxq329a1E6ego6cSpZv+58oTo5zt4PHl3Ud
 z2ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1721203633; x=1721290033; bh=vwHY9wQ6CVMq6
 F0t6KjDQ2iuUO2nN5K9t1/6BfFp3rw=; b=nckkK+v2ELh0SzkXQhUXh3HpLGKd6
 w+xBKyjjUqhXntIJXTKlRHWmNwcTAOlNKb6pE/T5JrT958I1EqTE9RE1gRJcipQM
 w2YYRRp3b4GtHW0SQVM6OjxXfhh+Err5N7XZhHntJD0+3w28Th4fcKbvZFoXcdsw
 fdJ10Dxy0s3OXyoisB1Hgq7wRdpDXaRShXaFThaVBRYAzm4ye5reqwrfLQ6zkaQO
 kduD60pryjCy197DdzWENhYTvt3Ym+wu4Jz3SdcHYUB4YDsK5/RsD11EV4oJxqu3
 AGleA180SzYIsj+Rits2JSd+XyWSEpPeXS5pn3XeqdaqSHy5h14BKURrg==
X-ME-Sender: <xms:r3uXZqSID9feKc-JA3IJ9O00Ey_ttih0lSHW3NKTSo2LZzsfwYJN_w>
 <xme:r3uXZvyhhv04mUPLvas-UsmdDpJO-weO-fBTD0XYqCD2MSqOm5jfIiOdvw0cdg32I
 xF_-UG4xjSWxFSwxkg>
X-ME-Received: <xmr:r3uXZn24i7skVudtuwaaaq-FvAm_U6AwQRSsC2Rg6HAXnt8oEfvEnn1Jq8XdP3X13uo7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeehgddufedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeetfeegieeijeehfeekheek
 veduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:r3uXZmBHXSCypX57cVZPO77tUmbWRygOPFL5tD9_QUoMv5SF9vgGEA>
 <xmx:r3uXZjhom95WSGtEBysrTovEnNc0IbjixyBhMnGp5QIdD90k6WYsFA>
 <xmx:r3uXZipMVIxyUP3-QuCJIqMfChr0j7dUgnYdoI7XxKAlK8Gb2I1mPQ>
 <xmx:r3uXZmi7p5HFkkVNAumoKqUvvXwZ8hjV5qNGrOSXX9BeMKet5zjfDg>
 <xmx:sXuXZuS06UqMDiqAP4EPTF5Gu8AQWWMLTL1CDz5ZWyygLgOb8lQXrAq9>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 04:07:07 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] Endian Kconfig improvements
Date: Wed, 17 Jul 2024 16:07:01 +0800
Message-Id: <20240717-edian-v1-0-3cd4896edf2d@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKV7l2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0Nz3dSUzMQ83bTExLQ0w5REs1QTEyWg2oKi1LTMCrA50bG1tQA5RyK
 CVwAAAA==
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ccsyCZQVMGALn/HC4HMKLBs1oE7gJEEI1A8bZt62/FY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTp1avrm5yjEr/7RUgtcuKekO8zO9Yl3Uqm2aQlLnH7p
 YtvFYU6SlkYxLgYZMUUWUIElPo2NF5ccP1B1h+YOaxMIEMYuDgFYCL/ljL8T5zJcffhjRU8FsLx
 h2+xGPalPJl43YhHstOWgcUz+rVQNsP/3Hi2j1Mbr/U+ly7fv67LK+aX76kbRsc6XqcePRBsunI
 3BwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

This is a subset of my previous arm64_be work.

I wish this could be merged first so it would be easier to work
against xtensa and arm64 be support.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (2):
      Kconfig: Unify endian support option
      config: Use CONFIG_SYS_BIG_ENDIAN in code whenever possible

 Makefile                                           |  2 +-
 arch/Kconfig                                       | 34 +++++++++++++++++-----
 arch/arc/include/asm/arc-bcr.h                     | 10 +++----
 .../arm/cpu/armv8/linux-kernel-image-header-vars.h |  4 +--
 arch/mips/Kconfig                                  | 20 +++++--------
 arch/mips/mach-ath79/Kconfig                       |  8 ++---
 arch/mips/mach-bmips/Kconfig                       | 20 ++++++-------
 arch/mips/mach-jz47xx/Kconfig                      |  2 +-
 arch/mips/mach-mscc/Kconfig                        |  4 +--
 arch/mips/mach-pic32/Kconfig                       |  2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           |  2 +-
 scripts/Makefile.build                             |  2 +-
 12 files changed, 61 insertions(+), 49 deletions(-)
---
base-commit: 902d8ee94ce29a088a325da6e69eeb1a25f1fec7
change-id: 20240717-edian-faaff1da6e44

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

