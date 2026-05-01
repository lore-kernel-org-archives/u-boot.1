Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90387FF886F
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 01:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6A4803C6;
	Fri,  1 May 2026 03:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="ua3YEh5V";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZC7gPQce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA87C83E36; Fri,  1 May 2026 03:36:15 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11EB80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 03:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AFFE21400157;
 Thu, 30 Apr 2026 21:36:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 21:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1777599370; x=
 1777685770; bh=0UQjB10QWM2+eiIy+0xtIzo2g6+Vm1p1dtT+0Jeln3Y=; b=u
 a3YEh5VQDtPkmXPE4e4SQbpLR7Xb72rLZJ78C4M+9IhZPfKwpfbF4/iR+oZyYRfY
 HQFxEJWx58Uqtd4tjXr+54arIspMxyWV6dj1u0wHhI9ePh6B+c57TRJNBI1cIojj
 c+rt64c3JEGllprEukxR87hG7Mtzju0b5zE1Ir9iOCTLwiZqv9tlKbYArNGyHKrA
 GdwSMhyCedBUj6MuworfdFYbZAVTl4dMBE6kvgZZt38lF0NCBwQtQQ080RwL0/9M
 +7RSLNoBe2+PmhPGoP6WyE62jM41QeUaSiG9XzsVGhhCoN+mQDM6+PQHXjjr3wom
 vvwfdyPGJw3UP15V6ftlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777599370; x=1777685770; bh=0UQjB10QWM2+eiIy+0xtIzo2g6+V
 m1p1dtT+0Jeln3Y=; b=ZC7gPQceEMLKX9Y0CiWuETZcmmdHNbRzTZd9QSBYTMIO
 O+Gl2a2oRQZnZ6PE4MiLKf0LcXdHhNuHFn35EGcZaNUoWyYBAMlgw+p0x9rfCUWC
 UwyIO+YjMGAs9JruMvt6MrbzZNkB1SqjY39CkMeAJUd9lQZM3TMU6944GWITHgqV
 gqR1m0wARVxl+Y3/gVRoOTudi1S587+J97QTZJgez2cqc3p3g3twjT1a9KxFDVyg
 7nDxWU6ZZy8dNqdrbYJjr+xJg/rl6SaKAJGXgJ4ejOfVBfI/t1jlC97UuB9kU7+d
 z2YjpApV8Y7z2vwUmuj3mO4jzKUpoYCgU8njjy0byw==
X-ME-Sender: <xms:iQP0aW5PDzl_3JU2G8xX0imgovzroVwXn3evLf_HJ5kSL1ZXXqVLVw>
 <xme:iQP0aS-nvtp3wmwJJQ9NlyAl_q3xlQI9OakPywusIJcI7rvZuwGn7MGWyNnWbZM9E
 X26q9WFd8gcVD5_BUDi4fzO2W_upcfuE3tnDDEgT7z1Vce072MmucI>
X-ME-Received: <xmr:iQP0aQFB06rpDrkV0nFnIvXY3RTS7XSJ1MaBV4vxsZglECMfyfJ7y5cjuPeVNKQ0sLoV7mlWUbA96p6o3kCl4htFgCTAuqcwhL1midBJwPqCeMgl_aEg_0UW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeklecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgifucfo
 tgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtffrrg
 htthgvrhhnpedvhfefhfeiledttedvkeffudfhfeethfdutdejleeggffhfeeuudejhfeu
 uefgudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghtthes
 thhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepuddtpdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdp
 rhgtphhtthhopehluhhkrghsiidrtgiivggthhhofihskhhisehthhgruhhmrghtvggtrd
 gtohhmpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohep
 uhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepmhhitghhrghlrd
 hsihhmvghksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthesmhgr
 ihhlsghogidrohhrghdprhgtphhtthhopehprggumhgrrhgrohdrsggvghgrrhhisegrmh
 gurdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtohhmpdhrtghpthht
 ohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggv
X-ME-Proxy: <xmx:iQP0afUKSCy_Elbs-NWDLm4UmoDwrYNzdE5d584r9Lq0yL3m0GxwhA>
 <xmx:iQP0aU8xIbhN1lwn7XcyLdstxmmFGcxLAbunbx8sZfbYhAFbTjrTrw>
 <xmx:iQP0aU4JtfEdyL6O9tGIzz9YjVbysRZVUwu4UxurTFUzFGB_5TuoIA>
 <xmx:iQP0aVnM01Fg0wltQoYZds6NkVKeK-oLw4LeKpPMkrSbFuQmlrnLfQ>
 <xmx:igP0aeUGuUwUS5m1OWcOlovbNks4-ZgYsxuukVCneGyzD_2nP7MtOBHg>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:36:06 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Subject: [PATCH v3 0/8] board: ten64: add USB Hub (USB5744) management support
Date: Fri, 01 May 2026 11:36:01 +1000
Message-Id: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIED9GkC/23NQQ6CMBCF4auYri0pQymtK+9hXIx0Kl0IpoVGQ
 7i7hcTERJb/S+abmUUKniI7HWYWKPnohz5HdTywtsP+Ttzb3AwEKCGF5iP1SnK0lk/xVjdScoG
 2dgqtcVKwfPcM5PxrMy/X3J2P4xDe24tUrutXMztaKrngIIyURrkGWn0eAyYKkYp2eBQ4sdVM8
 ONAuedAdghRl6A1Vab6d5Zl+QD3rqHcAAEAAA==
X-Change-ID: 20260408-ten64-add-usb5744-0ad5f6ad9f40
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777599366; l=3753;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=uiR3efrskKAau2x15qSMR7fTawiOOnuaOTB/gpJrV5s=;
 b=uCmBUUgq3gG22km92H/l3xqv+nnfmWxef4uvesMO/yxzlRYtoeqzVbd/eFEfbBBoBm0X0Xthx
 E39fL++1o3oA5bAocbm5p9UGlz1pxv9D7F173gqih1/z/aq8d+6Ywn2
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
Enabling USB_ONBOARD_HUB triggered a compile error
which required touching arch/arm/asm/gpio.h (see below).
No build failures for other boards were detected by CI
as a result.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
Changes in v3:
- Change how the compile error in usb/common-hub is fixed,
  by including linux/types.h in arm/asm/gpio.h, which
  should resolve problems with non-C90 types being used in
  soc/machine specific gpio.h. This change was suggested
  by Quentin Schulz.
- Change from a hardcoded usb_init() call to adding "usb start"
  to preboot (thanks Fabio for the suggestion)
- Fix some typos
- Add explanation about why the fdt fixup errors can
  (generally) be ignored (thanks to Simon for suggesting)
- Link to v2: https://lore.kernel.org/r/20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au

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
      arm: gpio: include integer type definitions for gpio.h
      board: ten64: add fdt fixup to hide usb hub topology
      board: ten64: remove USB hub references from internal FDT when needed
      configs: ten64: enable OF_BOARD_FIXUP
      configs: ten64: enable USB_ONBOARD_HUB (USB5744) option
      configs: ten64: switch to OF_UPSTREAM
      arm: dts: remove local copy of Ten64 board DTS
      configs: ten64: add USB start to preboot

 arch/arm/dts/fsl-ls1088a-ten64-u-boot.dtsi |   8 -
 arch/arm/dts/fsl-ls1088a-ten64.dts         | 388 -----------------------------
 arch/arm/include/asm/gpio.h                |   2 +
 board/traverse/ten64/ten64.c               |  70 ++++++
 configs/ten64_tfa_defconfig                |   7 +-
 5 files changed, 78 insertions(+), 397 deletions(-)
---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260408-ten64-add-usb5744-0ad5f6ad9f40

Best regards,
-- 
Mathew McBride <matt@traverse.com.au>

