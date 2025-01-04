Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61451E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 13:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 846F7803DC;
	Sat,  4 Jan 2025 14:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="b35B20ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45D68035E; Sat,  4 Jan 2025 04:38:17 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7914580079
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1735961889; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WOtWF0coiaAeM1IqduliIY32YwoILoF597/skkDmlNVZUGqVRY7YjsEMp+YQrOqTpCcQwnnWwL38A8KyuYeJm0lbOzuJeElbdqjdY2Uu4u2ZFF3bsB5WitoLbX0v5yiD+tzYjdhZnm03lIgDjWLUXb5L1JHCtRvfIt1yGQVk0Z0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1735961889;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SuM2Mr1h3marXkngvGUnNpLblD7i1JYlCQ9BwUXwOd0=; 
 b=lc1NiKRwJEaDz6c6gvNGJyPN+5krwjSy8+F0jSPSVYjsC7f7JLldFSuh8KOoCnhxjzftLgdi/AA5BulIsTkNMbNOYLQL3InrsAEiJ9nbf3oixm9bjT9vzNhBxSLZSqFFVTkUnB2E9f+Gfj8QZ9jcY/yKnjbIKv9jwHrnouZ98Fo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735961889; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=SuM2Mr1h3marXkngvGUnNpLblD7i1JYlCQ9BwUXwOd0=;
 b=b35B20mse8ZO8pepva87Su6u92uencYSNxy+6UBjT67Y6SyS38FE/vLEUzKzGn2W
 Umny4p1DqLnE70HqDBEY08hZfCHLia9MppmliZ6A5cyuapW2j9LOKTycn6ev+v6VqEc
 BonRDRx/a0AgH8lSsRgSElrhWB2rs7BG+BI62uoI=
Received: by mx.zohomail.com with SMTPS id 173596188687689.67679109230289;
 Fri, 3 Jan 2025 19:38:06 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v3 0/8] usb: dwc2: Refactor and update USB DWC2 driver
Date: Sat, 04 Jan 2025 11:37:14 +0800
Message-Id: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqseGcC/0WOQQ7CIBREr9Kwlqb/A5G66j2MCwRsiVQMVNQ0v
 bu0Jrp8k5mXmUmy0dlEDtVMos0uuXArwHYV0YO69ZY6U5hggxwQJDVPjdTYTFshNIKSACBJqd+
 jvbjXpjqeCg8uTSG+N3OGNd0kjUAEjgyghj0TQIEmq9JgvQdAxrkQXT8q52sdRrKKMv7GpdD8H
 2SkjAJq056lQiZkFx6TD+H6nS7L8gFaq1RZ3wAAAA==
X-Change-ID: 20241218-dwc2-dev-955c21a81118
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com, 
 junhui.liu@pigmoral.tech
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735961880; l=2879;
 i=junhui.liu@pigmoral.tech; s=20250103; h=from:subject:message-id;
 bh=g3wztwu4k9ueRucAaUxywMhC0D0ogeau4OYfyoV8smE=;
 b=1/WCrZSu1XQ9qDloNyoOCVfHMK76FSW3I5Vqe12irLGl6K7mHIyKePXCfXh5Utadc2Qo2IVN6
 puVTl/NTTJrAInfH+Rxq1n4sGRbiD7k3MRE2l+Y+YKk+QZjiH7Bm1hS
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=wBBo5nYsVNm/3oBEpRGTEbyW0tknGZANOEVccmcXtOw=
X-ZohoMailClient: External
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:18:05 +0100
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
      USB: dwc2: Fix HBstLen setting for external DMA mode
      usb: dwc2: Clean up with bitfield macros
      usb: dwc2: Align macros with Linux kernel definitions
      usb: dwc2: Extract macro definitions to common header
      usb: dwc2: Unify flush and reset logic with v4.20a support
      usb: dwc2: Replace uint<x>_t types with u<x>

 drivers/usb/common/Makefile                |   2 +
 drivers/usb/common/dwc2_core.c             | 115 +++++
 drivers/usb/common/dwc2_core.h             | 560 +++++++++++++++++++++
 drivers/usb/gadget/dwc2_udc_otg.c          | 125 ++---
 drivers/usb/gadget/dwc2_udc_otg_regs.h     | 293 ++---------
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 306 ++++++------
 drivers/usb/host/dwc2.c                    | 494 ++++++++-----------
 drivers/usb/host/dwc2.h                    | 750 +----------------------------
 8 files changed, 1137 insertions(+), 1508 deletions(-)
---
base-commit: e7713a78829250b925d6377ee26c7b0745727feb
change-id: 20241218-dwc2-dev-955c21a81118

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

