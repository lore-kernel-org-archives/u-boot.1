Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89968F5A8CA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B265E8422D;
	Tue, 21 Apr 2026 02:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="maNP7omP";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="W/EfzMT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F63E8426E; Tue, 21 Apr 2026 02:04:52 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4538412A
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id A7D6E1D0016D;
 Mon, 20 Apr 2026 20:04:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 20:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1776729885; x=
 1776816285; bh=rmVVcIIXLfVFJeqa07nd76Q7baauJFr0u4a8P4AMFsw=; b=m
 aNP7omPnfz0ZpPohndGILTCWlba7+l9s7hiVRwmZNjk2cb8uX3vu6feio65Mk3sM
 9MG1K8Xu1HV3bgDWanOmWh6tlVjGqjuqOTZxcuHGsX8c30Vjb3H6U0B4KLBf2Uqp
 0TVXB8GTWZnYvOk6pGkaUdS0LN/ZtTbns17HZ2StmqhcfNiJPOxhziJq2d0p7EQC
 VP+6gwjIaX+rUKwjj6yj5xwlrgDRmq5P3Ido1cdLdNAMsmlkOcZblUNQcCwRxb8z
 faZtgdAIBWXsg4DDc6Du4Gfo/U+7dq2GBO1OARZmdBKCIgjJwyG1cXur3o5v1lxn
 nyw0iLcbYIV8Qkss+0Dtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1776729885; x=1776816285; bh=rmVVcIIXLfVFJeqa07nd76Q7baau
 JFr0u4a8P4AMFsw=; b=W/EfzMT0Tir1QxRdP4BdYc/T+T6UOMIyzsEg4KFdbWSQ
 VnAm5egrGMXWg3BXd5NRm61EH2PezjToGqW6LTfFsT4WG73llL02KHZnG4yPjw4w
 VzPMAXNcnniXnRtli6+HyKu37WSIxOd7tGv7j8huGeqanPDBiMu2AMvIfOW1MCST
 N/ND7GkvG6fGcd4Z6QP0SU4Daqp/o3F80FIc9zdxTvdn0oNthDUSQOY5mlHogbsC
 ixK2stVzxKwr8B3wkRQkGJkAxzKG7psUJlr+Qofu5+wZ20GtU58yTxAdNQttxW7n
 aghQbK8sk+xy5uDa6YqthEl/v+f3RzNUzM+WYrAiBA==
X-ME-Sender: <xms:HL_mafR3GtuPWo-qes_jlyA4MHsJ-QffyLI9RC0quVZj8uqW4K0Iag>
 <xme:HL_maVsAh0w3WN--gDZrqzko2z_1OXHqgi3jUNDUXY1Fg93j7Q0inirIUvNUpCvlz
 ZE7mViADG6b6SQQV5lSatYfm1IsXHVg4S4U_cHuqOv5sbJSfB4UwqM7>
X-ME-Received: <xmr:HL_maZEYMZ9M2YpYicI37Ovw1nX2RR1mHozScD7QZ56JajGbIS07Ro1Jibmi__NmRLeJKv8vYDq56YmYU4uFs7Km9p0O1gp_ByvTPksPxgDcK8dTm_5mFP8h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleelvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgifucfo
 tgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtffrrg
 htthgvrhhnpedvhfefhfeiledttedvkeffudfhfeethfdutdejleeggffhfeeuudejhfeu
 uefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghtthes
 thhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepledpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrihesrghmugdrtgho
 mhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghrrhihrdguvgdprh
 gtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmugdrtghomhdprhgtphhtthhopehm
 rghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhrtghpthhtohepuhdqsghooh
 htsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihp
 rdgtohhmpdhrtghpthhtoheplhhukhgrshiirdgtiigvtghhohifshhkihesthhhrghumh
 grthgvtgdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdp
 rhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:HL_maexxR1mN1cb_spEnM-oHW6UslUUfKmr6fwBpwR3A65nmXhOpOg>
 <xmx:HL_mab2FXKqBpbM4WXJXKrkQOWupjPfUb5CLb8dbDljJ1l3WG0VYNA>
 <xmx:HL_maWqmlFGxk1QxkBCN90mdueHPzDdyXG_q6cI-FusMerU4MCdX0A>
 <xmx:HL_maQVQLBOtRB4Bed8muTyrqY2oCGkyx_8ef6LDrwYVlkHJ_pbFew>
 <xmx:Hb_maYXWgMXkiyWF94gUsBqL0PY9MA8OjNzJegD7d-rPEBOp7bvlM1Vv>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:04:41 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Subject: [PATCH v2 0/8] board: ten64: add USB Hub (USB5744) management support
Date: Tue, 21 Apr 2026 10:04:33 +1000
Message-Id: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABG/5mkC/22NQQ6CMBBFr0JmbcnQDIW68h6GRaVT6UIwbWk0h
 LtbSdy5fC/5728QOXiOcK42CJx99MtcQJ4qGCcz31l4WxgkSoWEvUg8KxLGWrHGW9sRCTS2dcp
 Y7Qih7J6BnX8dzetQePIxLeF9XOTma381/aeWG4FCoibSynVy7C8pmMwhcj0uj9qsMOz7/gGJV
 LW8uAAAAA==
X-Change-ID: 20260408-ten64-add-usb5744-0ad5f6ad9f40
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=3114;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=MWgtyMnWNRPNIJfcsl64YLPEp1Q0WNPLM/7aA8W1PiY=;
 b=8Dw2GQ/sw4M3hjRQN7hkasIXK/dQA48bukyO0hlAUjoPSc3D0zBK+TPbYJISUKb+X1HVw/81/
 VSrSAEE1af9BvV8YBJsM+HTk2a7ptvwqldErUcO52vAJRSEQB9QId9k
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

The main public Ten64 board version (RevC) has a Microchip/SMSC
USB hub (USB5744) connected to the second USB controller on the
LS1088A.

The USB5744 is configured (by bootstrap pins) not to start automatically,
rather the firmware has to issue the start commands to the USB5744
over I2C.
The rationale for this is to allow certain ports to be disabled,
namely the M.2 Key B slot where the USB3 lanes need to be disabled
for a card that is PCI Express only (as the USB3 pins are shared
with a PCIe lane).
(The functionality for this scenario is not present in the mainline
USB5744 driver at this time).

Further testing revealed that some operating systems get stuck at boot
when they start their usb5744 driver, so we hide the USB Hub from
operating systems by deleting references (fixup) in the FDT prior to handover.

Similarly, references in U-Boot's internal FDT need to be deleted
when running on a board without the USB hub present.

CI pipeline results are here:
https://github.com/u-boot/u-boot/pull/924
I had to change the gpio.h #include in usb_onboard_hub.c to
asm-generic to fix a compile issue (missing stdint types).
The CI did not pick up any issues with this.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
Changes in v2:
- Add missing CONFIG_OF_BOARD_FIXUP to the board defconfig
  so that board_fix_fdt is called.
- Call usb_init late in the init sequence (before CLI / bootflow)
  to ensure the USB hub is initialized and usable before
  any downstream users.
- Remove 'local' copies of the board dts in arch/arm/dts that
  are no longer required after OF_UPSTREAM conversion.
  However, the board specific -u-boot.dtsi needs to remain
  to pick up the SoC specific -u-boot.dtsi.
  (Thanks to Fabio Estevam for pointing this out)
- Remove error print in ft_board_setup if USB hub nodes
  not found (e.g if the control FDT is passed to the OS,
  the fixup has already been done by board_fix_fdt,
  causing a false error notification).
- Link to v1: https://lore.kernel.org/r/20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au

---
Mathew McBride (8):
      usb: onboard-hub: fix compile issue with gpio.h import
      board: ten64: add fdt fixup to hide usb hub topology
      board: ten64: remove USB hub references from internal FDT when needed
      configs: ten64: enable OF_FIXUP
      configs: ten64: enable USB_ONBOARD_HUB (USB5744) option
      configs: ten64: switch to OF_UPSTREAM
      arm: dts: remove local copy Ten64 board DTS
      board: ten64: start USB stack in late init

 arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi |   8 -
 arch/arm/dts/fsl-ls1088a-ten64.dts         | 388 -----------------------------
 board/traverse/ten64/ten64.c               |  67 ++++-
 common/usb_onboard_hub.c                   |   2 +-
 configs/ten64_tfa_defconfig                |   5 +-
 5 files changed, 71 insertions(+), 399 deletions(-)
---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20260408-ten64-add-usb5744-0ad5f6ad9f40

Best regards,
-- 
Mathew McBride <matt@traverse.com.au>

