Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB3EE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 16:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85ABF805EA;
	Fri, 10 Jan 2025 17:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="kx+CxG1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32F68036B; Fri, 10 Jan 2025 14:56:36 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0084800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736517386; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RCKTxRWJKwYFGBjPpwQ243cyEKYbsqFiwABh1Kkzt1XrBvad9M98b38oWGjAuOyZy1tiCyqpZ+0qUHAeBf+Kobvydgd70sfnFyuuK41KpIPZypTsC7WlZvb2+1uzM9tFokef04pbQ2XhgKwWukKiB20OOCmccTFW+LB+mIBFpgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736517386;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5x5vAZR8PP2gRqk2nA3zHT4NuIwx/2j+LonQ7HFJs6w=; 
 b=XuxCbj3znpC0S2JgEi+JyySKs1GKngeCATTif9guAJimN/yjcEUC3yWR38zw523YiadfiVlY1nXvrLiRCW22vkrK92IDZB16w6t+cgEey0cVcB5AA0B35KnkpKOpe+skhTdYz18mZ1IzQx+cLIy+KCaGMF4bXV46XnbWAyT/IhM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736517386; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=5x5vAZR8PP2gRqk2nA3zHT4NuIwx/2j+LonQ7HFJs6w=;
 b=kx+CxG1bg80HErsbKxlufn6kswztqgYE+YWDEACtdrPfsipI6alBaGfzPtbpIIzc
 BcXeSYMXpdHGs70D61d2LOT9sBpZbrLB+vi5EvHQAqUeNOYKMmSF0+Gqz1thasAst6t
 ZSOqdbnB1sESoFBg3orebX7SdaWMZ73iWGXz/h5U=
Received: by mx.zohomail.com with SMTPS id 173651738008879.30885425891347;
 Fri, 10 Jan 2025 05:56:20 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v4 0/8] usb: dwc2: Refactor and update USB DWC2 driver
Date: Fri, 10 Jan 2025 21:55:19 +0800
Message-Id: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcmgWcC/02OQW7DIBBFrxKxLhYzQIOz8j2qLDCe2qg4ROCSR
 JHvHmKpTZZv9N/T3Fmm5Cmzw+7OEhWffTxVUB875iZ7Gon7oTJDgQoQDB8uDvlAhbdaOwRrAMC
 wOj8n+vbXLfV1rDz5vMR028oFntctIjQiKJQADeylBg48k80ThQCAUimtu3G2PjQuzuwZKvgv1
 4F4fVCQSw7ohrY3FqU2XfxdQow/L1X+qVqAUG+q5DWkeuwdtO0nqe7sxzkmG5qF3MSO67o+AD2
 TgCIcAQAA
X-Change-ID: 20241218-dwc2-dev-955c21a81118
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com, 
 junhui.liu@pigmoral.tech
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736517373; l=3262;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=pxRxqxazfHoZNRkr6mvSlwNxR0/T4iqmpfuTsFl485Q=;
 b=lWw9lmm1KGvQeZDkgYpZQDP9V881clacb14cLMcrDfb7Yu7pyNVyQ+P+EABtVhPfqkdUyoaDP
 pPufTFTGnaZB4T5rbvugT+J2Dnx9WA2lR5e1GF1TVsH7ESLEQYxyCih
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 10 Jan 2025 17:13:21 +0100
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

This series improves the USB DWC2 driver by extracting register
definitions into a common file for better readability and updating the
reset method to reflect changes in version 4.20a, including the new
GRSTCTL_CSFTRST_DONE bit for reset completion indication.

This series has been tested on two platforms:
- MK808 with RK3066 SoC and dwc2 v2.91a, tested with USB flash drive and
  connected the board to the PC through the rockusb command. Test log [1].
- K230-CanMV with K230 SoC [2] and dwc2 v4.30a, tested with the onboard
  rtl8152 USB to net chip and an external rtl8152 adapter connected to
  the onboard USB-C interface via USB hub. Test log [3].

[1] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-mk808-md
[2] https://developer.canaan-creative.com/k230/en/dev/CanMV_K230_Tutorial.html
[3] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-k230-canmv-md

---
Changes in v4:
- Fixed typo from dwc2_core_reg to dwc2_core_regs in patch 1&5.
- Restored `struct dwc2_usbotg_phy` definition that was incorrectly
  removed in patch 6.
- Updated copyright headers to include 2025 in patch 7.
- Expanded comments to clarify PHY clock delay in patch 7.
- Link to v3: https://lore.kernel.org/r/20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech

Changes in v3:
- Handled warnings from checkpatch.pl (add spaces around '<<' and
  replace 'x' with '(x)' for macro argument).
- Add return ret; when timeout happens.
- Link to v2: https://lore.kernel.org/r/20241230-dwc2-dev-v2-3-12cd9b8a2358@outlook.com

Changes in v2:
- Reorganized structures, renamed macros, and moved code for better
  clarity and maintainability.
- Added a fix for the incorrect ULPI_UTMI_SEL bit setting.
- Added a fix for incorrectly calculating HBstLen for external DMA mode.
- Extend the changes that replace uint32 with u32 to also include u8 and
  u16.
- Link to v1: https://lore.kernel.org/r/20240522142311.17351-1-seashell11234455@gmail.com

---
Junhui Liu (1):
      usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting

Kongyang Liu (7):
      usb: dwc2: Extract register definitions to common header file
      usb: dwc2: Fix HBstLen setting for external DMA mode
      usb: dwc2: Clean up with bitfield macros
      usb: dwc2: Align macros with Linux kernel definitions
      usb: dwc2: Extract macro definitions to common header
      usb: dwc2: Unify flush and reset logic with v4.20a support
      usb: dwc2: Replace uint<x>_t types with u<x>

 drivers/usb/common/Makefile                |   2 +
 drivers/usb/common/dwc2_core.c             | 131 +++++
 drivers/usb/common/dwc2_core.h             | 560 +++++++++++++++++++++
 drivers/usb/gadget/dwc2_udc_otg.c          | 125 ++---
 drivers/usb/gadget/dwc2_udc_otg_regs.h     | 289 ++---------
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 306 ++++++------
 drivers/usb/host/dwc2.c                    | 494 ++++++++-----------
 drivers/usb/host/dwc2.h                    | 750 +----------------------------
 8 files changed, 1154 insertions(+), 1503 deletions(-)
---
base-commit: 38a371110308ebeb277e20531a7b698b7981bbfa
change-id: 20241218-dwc2-dev-955c21a81118

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

