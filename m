Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4CAC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B346882A2;
	Thu, 16 May 2024 13:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="q+VUqN9X";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+IEZQCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60248717A; Thu, 16 May 2024 13:40:44 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B850887C40
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id B8FE71140078;
 Thu, 16 May 2024 07:40:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 16 May 2024 07:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715859640; x=1715946040; bh=nE
 5vV8Yz/FQWUP3vl+6otuodFUuF87dbelSHmWBtVvI=; b=q+VUqN9XCIyU4abSyn
 OVPWPWOrrPGa8QMJiVHkhaTufkJ70trYEOsACgFH5IAvdiP21LghZYzUvkvJW7kj
 9Dn1L9jc0cwm0aJe2XKA1ljgv5NOdCqDC6ukjxHO/kjPOWtY8mvoKfhnu52URJvF
 lI4dQCDqT0D/kgHWxgNe5xseVgnSBtNH2wIIAUBfcZeZh+AmwVpYmIbaKP1Rh2lA
 1rQjg1rxJsyf1Q0rZOiQXTbrLaUzsWuOSTPJVywv+18ce4kD+ytMPuF5SwHDGAgh
 eoseM9YPmOa4WXvxHX8GRodp8AMl6lFUqK+SYjV8yJA2os4kpdSi0sCsvXK2ANkh
 6smQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715859640; x=1715946040; bh=nE5vV8Yz/FQWU
 P3vl+6otuodFUuF87dbelSHmWBtVvI=; b=k+IEZQCwgrro90vf19x1h+jiufs2b
 1HLhQtmasQDLmKdcfnVMYl3VO2fNA02GLWr1YwZgva0YtJCy9Kay1Xc39WtfRB1w
 w2baHVZ7AqjNYd2RY2yLDdJnwxoG5fmqGoCsM7jff6oUr3ap+Fdjuxl81CY8pha9
 /u3xJli7Fc3Hm0JBfFFW50r26KQ9yjF5JJULlDw3kBQFuKcJupb2j88VEFa1VIfn
 3iPcLmJYUsVEtUPY9zlhI0W/1hoos8PNdhu4q9ufiPMb7JJ2OuMUDHO2lpk6uhcy
 4m86BfNVQXpQRuv7ZTI5iTGFAFTAQoqh10ghWdEKKYdhPUvCXb5N+pWpg==
X-ME-Sender: <xms:uPBFZv1qD1OvlQONBrVOUZBKb7F2IG4KpYrjy8_rMjyvX1tdIXh0bQ>
 <xme:uPBFZuH34YaAhbVbT5vUtDK-IpHyzxa4bmqwi13iwTiQarmJ8P31JBrQvUmTfBukT
 vfvzx2r-snvACNg5zo>
X-ME-Received: <xmr:uPBFZv4ItwvD9VB_k_di-yiwn-pMRC6_9OcBRCsQfxfjpW7z2Xe6YL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
 kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:uPBFZk10DkIxBUfkYgnoTIU4AESe9e6pgZOUyQ783Vt3JbVAhmk8fg>
 <xmx:uPBFZiF35FVZ0dWJ6Lv2BhhgDbVlTsLKQcTlM93W_gpwD8LA4nyOSA>
 <xmx:uPBFZl_7oMZlIplxjqa9JCzpvlHMJj3X-MF3Mb_7n61DIqN59RwU4A>
 <xmx:uPBFZvnyk8TCLE4HQN2JsjwURpYxVFmW7o3pnVZiGaMej_uI4_VTrA>
 <xmx:uPBFZq8TS4NPMWNWtHZHzd46YHXTBQpfZxCsekgERQWwtGdDrOAFUEvC>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:39 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 00/12] MIPS: Boston: Various enhancements
Date: Thu, 16 May 2024 12:40:20 +0100
Message-Id: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTwRWYC/22MTQ7CIBgFr9KwFsNfUVx5D9MF0I+WREsDDbFpu
 Lu0O6PLeXkzG0oQPSR0azYUIfvkw1SBnRpkRz0NgH1fGTHCBGkpxyakJUxYtOAk9JZR5VA9zxG
 cfx+hR1d59PUW16Ob6b7+JDLFBBtCGAhjORh5d891CHo52/Dam38Fp62Sil8FvcCX0JVSPq+60
 17PAAAA
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=n6Sl99F/n3cbf4r2Ej9sApIs51gAdG3CrZiKiKJis2w=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDztSU5yvKp1O1jN5yye6N8PJz0vEsSV8kcTCpFXZL
 xXP8TN3lLIwiHEwyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwEROSDAyLLnkWscs7NRSxpbH
 sfXr4evnF/584+n/SknB2eHF3u0t5xn+KbRcuTRvwtMXV6yum2XXMDjcTNcudfJduNXetu+Rg0M
 TKwA=
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

Hi all,

This is a huge series which promoted MIPS/Boston target into a
usable state, with fixes to drivers and general framework issues
I found in this process.

I also converted the target to OF_UPSTREAM.

This target is covered by QEMU, to test on QEMU:
```
make boston64r6el_defconfig
make
qemu-system-mips64el -M boston -cpu I6500 -bios ./u-boot.bin -nographic
```

This is my first u-boot contribution, please kindly advise if you
have any comments.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Drop "[PATCH 09/13] syscon: Probe device first in syscon_get_regmap"
  in flavour of fixing the driver device life cycle (Jonas)
- Link to v1: https://lore.kernel.org/r/20240513-boston-v1-0-fac96938417e@flygoat.com

---
Jiaxun Yang (12):
      pci: xilinx: Handle size of ecam region properly
      pci: auto: Reduce bridge mem alignment boundary for boston
      pci: Enable PCI_MAP_SYSTEM_MEMORY when ARCH_MAP_SYSMEM is not set
      ahci: DMA addressing fixes
      ahci: dwc_ahsata: Generalize the driver
      MIPS: Provide dummy acpi_table.h
      MIPS: boston: Imply various options
      MIPS: boston: Provide default env vars
      clk: boston: Allow to get regmap from parent device
      dts/upstream: Add Makefile for MIPS
      MIPS: boston: Migrate to OF_UPSTREAM
      mailmap: Update email for Paul Burton

 .mailmap                           |   3 +-
 arch/mips/Kconfig                  |  28 +++++
 arch/mips/dts/Makefile             |   1 -
 arch/mips/dts/boston-u-boot.dtsi   |  10 ++
 arch/mips/dts/img,boston.dts       | 222 -------------------------------------
 arch/mips/include/asm/acpi_table.h |  10 ++
 board/imgtec/boston/Kconfig        |   4 +
 board/imgtec/boston/MAINTAINERS    |   3 +-
 board/imgtec/boston/boston.env     |   9 ++
 board/imgtec/malta/MAINTAINERS     |   2 +-
 configs/boston32r2_defconfig       |   2 +-
 configs/boston32r2el_defconfig     |   2 +-
 configs/boston32r6_defconfig       |   2 +-
 configs/boston32r6el_defconfig     |   2 +-
 configs/boston64r2_defconfig       |   2 +-
 configs/boston64r2el_defconfig     |   2 +-
 configs/boston64r6_defconfig       |   2 +-
 configs/boston64r6el_defconfig     |   2 +-
 drivers/ata/ahci.c                 |  34 +++---
 drivers/ata/dwc_ahsata.c           |  82 +++++++++-----
 drivers/ata/dwc_ahsata_priv.h      |   2 -
 drivers/clk/clk_boston.c           |  37 +++++--
 drivers/pci/Kconfig                |  10 ++
 drivers/pci/pci_auto.c             |  16 +--
 drivers/pci/pcie_xilinx.c          |  53 ++++++---
 dts/upstream/src/mips/Makefile     |  14 +++
 include/ahci.h                     |   4 +-
 27 files changed, 245 insertions(+), 315 deletions(-)
---
base-commit: c8ffd1356d42223cbb8c86280a083cc3c93e6426
change-id: 20240513-boston-45ef6edc219f

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

