Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F0910FC45F
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 00:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53E0F83DC9;
	Thu,  9 Apr 2026 02:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="jRP3IM8g";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="vsJvcPWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CB884120; Thu,  9 Apr 2026 02:06:44 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A17983CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 02:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 263D0EC0105;
 Wed,  8 Apr 2026 20:06:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 08 Apr 2026 20:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1775693199; x=
 1775779599; bh=4X9+LlFmPbVKDELSbtEoqghDVYKaVyqok1sA6Sdms84=; b=j
 RP3IM8g0x3vM7bkXYCwRWuyWw9/MgU98uG5eUwnUoR4HtQRZspEZl47JbWX6miUM
 zek99Z2mhocl6oAugz5cH1lTaO83dpWK6yOTIX+sAy7vUMM071kU8ylwDGiZcbSH
 svp6n0IpiX4P897sP9gR4q6OISym3tzPM/AQy9oSUDj2oQ9DIVn0PXy2SSuJceaZ
 vPxmsnPv8qBI1C1EaClNgL5W1sYuGJp+zKNA8YdfVVK/vdjdyLR/KQymquweM0gK
 SsiiYI5fYrW01utReYfhntnyee9dWhT5OufhPYbE3UHtGMZT146bb8GW76I/V1zL
 oZH0nr3K8VOpbhQRjZDWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1775693199; x=1775779599; bh=4X9+LlFmPbVKDELSbtEoqghDVYKa
 Vyqok1sA6Sdms84=; b=vsJvcPWcsilRsbehwmvdJYISFoRS/cyS0ta3YciBTyOd
 7acR8kjm0T+pGKJTD5dn63oQh4XR5XqDBXYGDS1fXssNhUM7j4Yu22MbhyZiWw0j
 ksTz6VaOw6MyneFu4WFO3VWhQ0VJuBMm32HRZHNlabftee5rnWE3vjUreLKmKm5I
 zMt3o3UtlMGgVqT6mlTd+m9OKY3OzyJyfY195l+5XFqGxVbyL8NGFgp51H7RDk96
 JkxtbI2gavW3xWGygY1LkXzH86IlJWwrwVVFJ5AgHQ9XOmoXpluudrsqGngxYnei
 5U5FYv7Ju/tIeV/mvqfSJftYAlQuyspQCF7Y4rjfyg==
X-ME-Sender: <xms:ju3WaUmRbgS3pflTfVFgOXfUdUaVRIwkN0E_IwnQUdaxAdNHPq1hqQ>
 <xme:ju3WaRy7wZ4bH4lieVTeox1BZUDOUXJpAO6PnXib5bu0Jp3n2qGklz-20_eqlvu33
 qQLmPCCzbs5-RpkDjXvwGkv6xQIAhiY4h7CzdOdVMAyFJ-DxgfgDQ>
X-ME-Received: <xmr:ju3WaaNQLlay6IJDPWCj203xLYndlphOs57QHJKdwC6V_k3paHkfvXx-HEQtKkmNtNmVztkfORmvdchLQoTeTmrBaORjr0uJs3xmew6Aujfjk5MX_q_xc2mM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeelkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
 ejnecuhfhrohhmpeforghthhgvficuofgtuehrihguvgcuoehmrghtthesthhrrghvvghr
 shgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepgffgvdfhteeujedvueehiefgke
 dvkeehgfeugeeludejffegfffffffhtddugfelnecuffhomhgrihhnpehgihhthhhusgdr
 tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomh
 drrghupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:ju3WadSyBpzv7WNiP_2Rf4VHAKqHPcGO-5REjRD_-se9gjfJjav6pw>
 <xmx:ju3WaQZPiQL6P9u3rsR0Knq7e2vylzUDdon9OqtolQdV_Em4tCLj7g>
 <xmx:ju3WaS0B0DB5A5AFfERfdWInBuiBW_V_64xREo1VeiVqR0YGfupNiQ>
 <xmx:ju3WaYX2mPlCTfUx31P7deGO5U9MqD4wy0DquB8rGVJW6iBx888rfQ>
 <xmx:j-3WaRlo_1a4Si93sjGJ_kHt1uW28MT7M-HtmPpro0iEIxzLo0FmIBCz>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 20:06:37 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Subject: [PATCH 0/5] board: ten64: add USB Hub (USB5744) management support
Date: Thu, 09 Apr 2026 10:06:30 +1000
Message-Id: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbt1mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwML3ZLUPDMT3cSUFN3S4iRTcxMTXYPEFNM0s8QUyzQTAyWgvoKi1LT
 MCrCZ0bG1tQBd1akeYwAAAA==
X-Change-ID: 20260408-ten64-add-usb5744-0ad5f6ad9f40
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775693197; l=1979;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=irxCV+c0OXP6OAmCnJRYzQVujz6+oZ+tzmBwmsvW3Pk=;
 b=BfdMSxpcgcao/6gV0n39fcHp8audcjauuYwuMjTdXRSLuZHaFUtmEjog1EsNyqy+gqo1sLRcb
 +HhSE3PqQQ7Dy1xr4iFq0wNu1o9aCj7O1CBCk6Oxvm/Is+GXw4YKExD
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
Mathew McBride (5):
      usb: onboard-hub: fix compile issue with gpio.h import
      board: ten64: add fdt fixup to hide usb hub topology
      board: ten64: remove USB hub references from internal FDT when needed
      configs: ten64: enable USB_ONBOARD_HUB (USB5744) option
      configs: ten64: switch to OF_UPSTREAM

 board/traverse/ten64/ten64.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 common/usb_onboard_hub.c     |  2 +-
 configs/ten64_tfa_defconfig  |  4 ++-
 3 files changed, 66 insertions(+), 2 deletions(-)
---
base-commit: 0a7e2a90ad4df4235946c2349fc9430e87428d4f
change-id: 20260408-ten64-add-usb5744-0ad5f6ad9f40

Best regards,
-- 
Mathew McBride <matt@traverse.com.au>

