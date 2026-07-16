Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8DCC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD8884C0C;
	Thu, 16 Jul 2026 18:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DLcV0WBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5C184CF1; Thu, 16 Jul 2026 15:43:12 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C509C84C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c16111a9b8dso56465066b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209388; x=1784814188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CippOp5HjfiQnu9Ks2wM9htpNM1TIy/yqfkZgcYegW8=;
 b=DLcV0WBYoTEx/pjgda4UPu1OppIXbpVDW62rnW9xWeF79SI1tKSTid1aV2AfLUfxq2
 ppLK1tAHejrsWLkX8cdBoZlfEuUE65bWjykkSN5Wa8AN5so6BHXd+cAA1+TcfSqCQizX
 jfOGxFTpAlMnII/7l7lyWGUQkgM0rsJ7ElArvlHef87SBEcp2D4KnHj+h00q2s8PI0H0
 gEys3Tl8a7lwmJSfVcxDC/DbliXGGOc7kQlcA+O80RL/W0eP/C+a32FOji7mUjZl+HSC
 v+WI+HkP8s7C+lChPNeMrObo7n6PMqPSUONOrUkEBwgNoyWRIrgWx4Aow7y9OTUeTLH8
 XNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209388; x=1784814188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CippOp5HjfiQnu9Ks2wM9htpNM1TIy/yqfkZgcYegW8=;
 b=SEb5OexuuxAR0TJyhFvnpEJbIpHS4GBNULKYodhDD/bCMKYKHB+pb0DHCpp4nfYST8
 490nIPVt03Y28AN/NAQ/Z2l5Uz1tTchjBGtRWKYiKTPQKddC4IzaNAAoP565LiKMGTyz
 DsBkonAR4T5A8vxovbG6D8mK2C7JHDqPKx7dRkfuzXM8/xV2otwFAMgHuklS5LQsmJyF
 g01V/jmkUMvRKo9uGV2+8TT1eNIJ941iN7lEwgOl3Io26WWCHwtBsWyYnmY3PDHkQFYT
 7DI0AwMykwpRFvGuR1gPo+4KSHx2aY4KDI9TKFZbWv7zn3sIzoNrGVlzStq1BBR4K2Oc
 UqZA==
X-Gm-Message-State: AOJu0Yyq9yzJJepqiqz762EDG5T0XqjXcWGTgTwcRp5kol/Q60FVjl0L
 9xtdCpI9VvjXY6TWxmi8JLlJOgiaiSgtbTRJejL2XZcRXKX2YjWAt2oUj9AUkvtsBiq6HAoO/2a
 t4ETA
X-Gm-Gg: AfdE7cn/4StyRr5WGVMDBCBSFAcoK9+F2GEb4zh8pQ9GKKuPSgyaLL4qE+EhDVqpcqh
 ao1v7GTr6k6JkCk8pdxHKAGu2Ybx5H2h+Si1S/FWbCksCc/5rumr9Jx+R0N6r+uDuMHGidwCEyA
 J86QCbPj850vxnpyjyMXGq9AXSAqdHtH7IqKkcytE7gh+bw3HB7WTdA/h9AQrTpQf1YlsPjKcaH
 HTT18RniIOu3WMT2sLMZKmE0XEp0nUWuIeEDT3ervJRKG9DJMgCsZudNT5jpyIlVIp+/9DZbAvv
 ajTz44wT6cMgUmQvPnFJCV2YFPr+OonLqOe+Q/JPbK8jTDYCO67REEtaGAvRJtC862KOQ4dM8BU
 stjOLsc5zjqJLVReXAIPJea3HHp68GL4fl8fkD6xs8cIM5wYknuRH/4T1tCaosx+YOjFO84fe/7
 2c8BNrQ0oSnWlAyzmMKm5v6NpUNYm99bgmgqKlBg==
X-Received: by 2002:a17:906:f5a9:b0:c16:688c:87c8 with SMTP id
 a640c23a62f3a-c168dda17e7mr102762766b.6.1784209388109; 
 Thu, 16 Jul 2026 06:43:08 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e183sm218782666b.51.2026.07.16.06.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:07 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v5 00/75] usb: dwc3: sync code with Linux v6.16
Date: Thu, 16 Jul 2026 15:41:30 +0200
Message-ID: <20260716134305.614278-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

Hi,

This series syncs the DWC3 USB driver with Linux v6.16.

The driver was forked from the kernel v3.19-rc1 eleven years ago, in
commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
u-boot"). After that almost no kernel changes came back to U-Boot.

I split the work in three steps, so it is easy to follow:

1. Restore drivers/usb/dwc3 to a clean v3.19-rc1 state.

2. Import the dwc3 directory once per major kernel version, from v3.19
   up to v6.16. Each commit is a raw snapshot from that kernel.

3. Add back the U-Boot glue, the XHCI/UDC updates and the build fixes.
   This part builds on Jerome's work.

The import commits are raw kernel snapshots. They do not build on their
own, only the full series builds. This is on purpose. It makes it easy
to see what comes from which kernel version, and to compare each import
with the matching kernel release. The commit messages say this too.

This is compile-tested only.

The series needs the dwc2 endpoint fixes from Mattijs [3]. They are
already on the list and should go in first.

The branch is also available at [4].

[1] v4: https://lore.kernel.org/u-boot/20260629084507.3254232-1-jens.wiklander@linaro.org/
[2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[3] dwc2 prep: https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org/
[4] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v5

v4 -> v5:
- Split the big "fix build after resync" patch into smaller patches, one
  per area, so it is easier to review. Marek and Mattijs asked for this.
- Dropped the Tested-by tags from the import patches. They were only
  tested as a full series, not one by one.
- Removed the merge commits from the "import from kernel vN" changelogs.
- Some small cleanups in the new helpers: dropped a dead function, added
  a missing NULL check and changed spaces to tabs.
- Rebased on latest master.

Older changes are listed in v4 [1].

Cheers,
Anders

Anders Roxell (12):
  usb: add helpers needed by the resynced DWC3 code
  usb: gadget: trim the gadget API after the resync
  usb: gadget: udc: make udc-core build in u-boot
  usb: dwc3: make the core driver build in u-boot
  usb: dwc3: make gadget and ep0 build in u-boot
  usb: dwc3: make the am62 glue build in u-boot
  usb: gadget: ci_udc: drop code we do not use
  usb: gadget: dwc2_udc_otg: fix up after the resync
  usb: gadget: fix up the function drivers after the resync
  usb: gadget: fix up the last UDC drivers after the resync
  usb: fix up musb-new and mtu3 after the resync
  usb: host: fix up xhci and cdns3 after the resync

Jens Wiklander (60):
  usb: dwc3: restore to original v3.19-rc1 kernel import
  usb: dwc3: import from kernel v3.19
  usb: dwc3: import from kernel v4.0
  usb: dwc3: import from kernel v4.1
  usb: dwc3: import from kernel v4.2
  usb: dwc3: import from kernel v4.3
  usb: dwc3: import from kernel v4.4
  usb: dwc3: import from kernel v4.5
  usb: dwc3: import from kernel v4.6
  usb: dwc3: import from kernel v4.7
  usb: dwc3: import from kernel v4.8
  usb: dwc3: import from kernel v4.9
  usb: dwc3: import from kernel v4.10
  usb: dwc3: import from kernel v4.11
  usb: dwc3: import from kernel v4.12
  usb: dwc3: import from kernel v4.13
  usb: dwc3: import from kernel v4.14
  usb: dwc3: import from kernel v4.15
  usb: dwc3: import from kernel v4.16
  usb: dwc3: import from kernel v4.17
  usb: dwc3: import from kernel v4.18
  usb: dwc3: import from kernel v4.19
  usb: dwc3: import from kernel v4.20
  usb: dwc3: import from kernel v5.0
  usb: dwc3: import from kernel v5.1
  usb: dwc3: import from kernel v5.2
  usb: dwc3: import from kernel v5.3
  usb: dwc3: import from kernel v5.4
  usb: dwc3: import from kernel v5.5
  usb: dwc3: import from kernel v5.6
  usb: dwc3: import from kernel v5.7
  usb: dwc3: import from kernel v5.8
  usb: dwc3: import from kernel v5.9
  usb: dwc3: import from kernel v5.10
  usb: dwc3: import from kernel v5.11
  usb: dwc3: import from kernel v5.12
  usb: dwc3: import from kernel v5.13
  usb: dwc3: import from kernel v5.14
  usb: dwc3: import from kernel v5.15
  usb: dwc3: import from kernel v5.16
  usb: dwc3: import from kernel v5.17
  usb: dwc3: import from kernel v5.18
  usb: dwc3: import from kernel v5.19
  usb: dwc3: import from kernel v6.0
  usb: dwc3: import from kernel v6.1
  usb: dwc3: import from kernel v6.2
  usb: dwc3: import from kernel v6.3
  usb: dwc3: import from kernel v6.4
  usb: dwc3: import from kernel v6.5
  usb: dwc3: import from kernel v6.6
  usb: dwc3: import from kernel v6.7
  usb: dwc3: import from kernel v6.8
  usb: dwc3: import from kernel v6.9
  usb: dwc3: import from kernel v6.10
  usb: dwc3: import from kernel v6.11
  usb: dwc3: import from kernel v6.12
  usb: dwc3: import from kernel v6.13
  usb: dwc3: import from kernel v6.14
  usb: dwc3: import from kernel v6.15
  usb: dwc3: import from kernel v6.16

Jerome Forissier (3):
  usb: host: re-import xhci-ext-caps.h from kernel v6.16
  usb: gadget: re-import epautoconf.c from kernel v6.16
  usb: udc: re-import udc-core.c from kernel v6.16

 drivers/usb/cdns3/ep0.c                |    8 +-
 drivers/usb/dwc3/Makefile              |   57 +-
 drivers/usb/dwc3/core.c                | 1710 ++++++----
 drivers/usb/dwc3/core.h                | 1060 ++++--
 drivers/usb/dwc3/debug.h               |  432 +++
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  737 ++--
 drivers/usb/dwc3/gadget.c              | 4256 ++++++++++++++++--------
 drivers/usb/dwc3/gadget.h              |  112 +-
 drivers/usb/dwc3/glue.h                |   36 +
 drivers/usb/dwc3/io.h                  |   29 +-
 drivers/usb/dwc3/linux-compat.h        |   16 -
 drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
 drivers/usb/dwc3/ti_usb_phy.c          |    2 -
 drivers/usb/gadget/at91_udc.c          |   46 -
 drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
 drivers/usb/gadget/ci_udc.c            |  470 ---
 drivers/usb/gadget/composite.c         |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
 drivers/usb/gadget/epautoconf.c        |  289 +-
 drivers/usb/gadget/ether.c             |   21 +-
 drivers/usb/gadget/f_acm.c             |   20 +-
 drivers/usb/gadget/f_fastboot.c        |   10 +-
 drivers/usb/gadget/f_mass_storage.c    |    5 +-
 drivers/usb/gadget/f_rockusb.c         |   11 +-
 drivers/usb/gadget/f_sdp.c             |   12 +-
 drivers/usb/gadget/f_thor.c            |   19 +-
 drivers/usb/gadget/udc/Makefile        |    1 +
 drivers/usb/gadget/udc/udc-core.c      | 1099 +++++-
 drivers/usb/host/xhci-dwc3.c           |    4 +-
 drivers/usb/host/xhci-ext-caps.h       |  158 +
 drivers/usb/host/xhci-exynos5.c        |    2 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
 drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
 drivers/usb/musb-new/musb_uboot.c      |   39 -
 include/dm/device_compat.h             |   13 +
 include/dm/read.h                      |   51 +
 include/linux/compat.h                 |   15 +
 include/linux/usb/ch9.h                |   25 +-
 include/linux/usb/gadget.h             |  520 +--
 include/linux/usb/phy.h                |   56 +
 41 files changed, 7563 insertions(+), 4175 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/glue.h
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
 create mode 100644 drivers/usb/host/xhci-ext-caps.h

-- 
2.53.0

