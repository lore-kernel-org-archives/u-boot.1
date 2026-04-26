Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2A0FF8864
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 12:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0F884120;
	Sun, 26 Apr 2026 14:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJI5BDJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 366EF84099; Sun, 26 Apr 2026 09:43:45 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FFC83FDB
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 09:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so47503125e9.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777189422; x=1777794222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Li1QmMda8RYfXk13Zqbj4DSv30FeDgb2ZuBjRR1/Qh8=;
 b=KJI5BDJc0oxgZEi4rrugtW2vUHUy0LzuBxvkTjSDEaB6SllqZKD/Vbh13Bx6qXCAYZ
 1rr4erDNOd+fd6K/AyMfELUOJ3tWdZHGci3WszFy4oNVcymLu5DuqewcRZiiggvkkxYI
 0XCHSEMYL0b4n5cdnNxDFfKf+rZdjpBT7gSzMyg7G8EDbh8Qt4VDGI9jqEXwJ3kHAnUw
 ayM9ExnzfUUq9LhC+yRnR/DndZRWUIaHTUQxtp+HZ7+Y9SuxE0OtQ9/YEKAhKjcnjdB3
 taPey9pfUGIYB9d1zvBtwSirJ/z4rjjPIoFl6TSOnjoXD1P3CC8ugPBVvjNO2/YNEyrO
 +S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777189422; x=1777794222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Li1QmMda8RYfXk13Zqbj4DSv30FeDgb2ZuBjRR1/Qh8=;
 b=SjDQ8mm8nCfoWOWOxT6opYk9xcovEixVzPu5lNy7n6AWn4YaEB6A0zZvz017x+FYhm
 oibwuHgFWuMVpn3Ma6ROpQ3YzLT4lIDid8KALHfmxxTLUSFCtF6029u0NO+3pt+nf86I
 Lpr5pFdiULE7bRnyU2g2cf+nCYU0tpG9V2/LzC8Vl2hFqe6tvrLIdX/5Ws44wXJFgVmU
 kUdwEZ2Qgd+fkpu5D7iHAuCaYlYL4S7HgWPaCxEySWYV0Gv15CE1FfI3OM547W4gncQI
 jf3gfuLGe5cx7gwJh02yiSH16Y1uSYCzwWngvoZKCselQ37VboIV5WToVSyS1O6N2OBN
 uorw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/543vWsGODiUdtblcchYSFCLytShbPNVVgwoolumaPaDC/uS1v/LNu3hWpTB34H4Qq1PZYG9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyNanip1cQsd6YIhGkB73W1d3IZ5QyxWHaUPB4mjspFpefsckVq
 Sg362y8M0Nh+nlBprX0f8/onOyHI8IczNHoKD0Lof7qUoZGH0p9HjwCf
X-Gm-Gg: AeBDiesflcZYXQogx5v4T8VpNBU5eQPHptuPmYlVvmz5Ebh6vP385rx6O1MzWR3MAmW
 GQehJylhLzsTyB8XLSCXev4kA0s8EyUO6MsSgeM6lei+zP6Fr090KN56TuYv2vBKSnlnJZsXq4z
 v+h4N3XSC111AnxbRFPNfOWA6GJ4ahAX8v7tPQj2ipr3KcAlOs9gEnfr9jC1iO/7ktK1EwO31gy
 gZ5PfYknUOSmHivIxEQll5/c+fVnIE8og7RaXVKo5VptlnPkfDpg8hQxceYHTHHVyT9f1JakhhP
 799dnnK+kq22mCVbIz8fx9pgxIM+nVQzq74Wzrqa2bQa5vtOSngKWYH0+ClDtjFbiPprLPomCTJ
 KtXHuGlSvVdmL1SgNgE7ceJMU1jP5gD1qm/Y5XbfT5YMJuEJ1C3/lldl/npkeHpkMx3bTE6dNg0
 i2jgJvB9b24QAAXRv/e4uZU6QrqlGAdZat0bLcqXlSg4vOzPydsX0=
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488fb8b91a7mr496601555e9.12.1777189422258; 
 Sun, 26 Apr 2026 00:43:42 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm76748031f8f.7.2026.04.26.00.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 00:43:41 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v7 0/3] usb: gadget: rcar: Add RZ/G2L support and lifecycle
 fixes
Date: Sun, 26 Apr 2026 09:43:16 +0200
Message-Id: <20260426074319.5819-1-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 14:57:25 +0200
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

This series adds support for the Renesas RZ/G2L (R9A07G044) USBHS
controller. During development, several lifecycle and resource 
management issues were identified and addressed to satisfy RZ/G2L 
hardware requirements and prevent resource leaks across the driver.

The series is split into three logical parts to ensure bisectability:
1. A bugfix for the gadget deletion sequence during driver remove.
2. The addition of reset controller infrastructure and proper 
   clock/reset teardown logic.
3. The RZ/G2L specific hardware parameters, SYSCFG logic, and 
   compatible strings.

Changes in v7:
- Fixed RB tags

Changes in v6:
- Fixed teardown order in usbhs_udc_otg_remove() to ensure PHY shutdown 
  occurs before reset assertion and clock disablement.
- Added explicit reset_release_bulk() and clk_release_bulk() to both 
  the remove path and the probe error paths.
- Sorted header inclusions alphabetically as requested.
- Fixed a bug in the clock enable error path where resources were 
  not properly released.
- Carried over the Reviewed-by tags

Changes in v5:
- Simplified usbhs_probe() signature to only take struct udevice *dev,
  deriving private data internally as requested.
- Fixed resource leak in usbhs_udc_otg_probe() error paths by adding 
  reset_assert_bulk() to the teardown sequence.
- Standardized resource management by ensuring the probe error path 
  perfectly mirrors the removal path.

Changes in v4:
- Split the monolithic patch into a 3-patch series as requested.
- Added usb_del_gadget_udc() to fix resource leak on driver remove.
- Implemented bulk reset controller support (required for RZ/G2L).
- Improved error handling in probe() to ensure clocks are disabled 
  if reset initialization or deassertion fails.
- Moved reset and clock handles to private data to ensure persistence.
- Reorganized hunks to ensure each patch in the series compiles 
  independently (bisectability).

Michele Bisogno (3):
  usb: gadget: rcar: Fix gadget registration lifecycle in remove
  usb: gadget: rcar: Add support for reset controller
  usb: gadget: rcar: Add support for RZ/G2L (R9A07G044)

 drivers/usb/gadget/rcar/common.c      | 65 +++++++++++++++++++++++----
 drivers/usb/gadget/rcar/renesas_usb.h |  1 +
 2 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.34.1

