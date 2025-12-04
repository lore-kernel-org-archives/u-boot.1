Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4C2D1F9DA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4642B84065;
	Thu,  4 Dec 2025 13:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pVVick+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285CE84008; Thu,  4 Dec 2025 11:26:36 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A92D883AEF
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b7277324054so111510866b.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764843993; x=1765448793;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ARuiWx7KmE+wQQUcRilZyTzZgYutNJBed3m+BkgAJ8Y=;
 b=pVVick+g3AYPg9558I/U/VBjUHx72OWmISfsFNJxJ6XqXywSZ0R52wwN/zF2hOaNUO
 8oCHoAuLW3ZeVgZaRlEckWD5axkrx2yNfqh5NciT4MWAN37fMrv9rZL19FVRP7T1dQ6g
 Gas++J5fvbnNPAXJBFsp5Nc9H5f3pAIInJVC/beKIXEwiZ5ofAHove0tOeW/F8XQlgBh
 a/5N7uKPDECLzEGyWj8ZRpHH7REQScOCejI0bDKi9lAFCEvoVjZyRG0c4bqIHVW6F2S2
 kMYCdL46sdAmdzOTWly/rqhFiI46JmOfIx3D6vGq7LylbLYWJhnjlU4UKDeUBg1rGcaK
 mPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764843993; x=1765448793;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARuiWx7KmE+wQQUcRilZyTzZgYutNJBed3m+BkgAJ8Y=;
 b=lKRyXFMX4CUdpFV08U5XYQm/4A1yUSxc1e0XTVozL0FDAbjynvSxPIt1bmYuk/rbXz
 SG6bPZWzZ6+j85IlNT0eJW1kx9XgnPgOImMESUg0cLx1C3OBPem2GzFasQfYJn6TzZY0
 9chpu9LtIpcfgIEiVRt7JiQM2Jj6IX3bPp9CIEAiq4Va0SclA+7txbHnaUBMpw8MNzHE
 A8uYKzgxwSrWN27LGrw7whGhfCEJJiKYBUCSPnEku+/h4xLnR+HKACuMTcqnS7jZyjVU
 6YQWBTvAUsuir9Hu4AUR+RBJHTUZM8nci93ENYrj0toO6Ai3uM3s+r/iA2dkAwqVb8LQ
 wHHA==
X-Gm-Message-State: AOJu0Yz96JrsccKAm+Y7cNzvczPmGCOFTsQXDeqaIn9eJoTlJcZjnKc7
 sgmneRgLxxneRN2NmWWWFEJW0UZ37QZ8JjabP0JZ9WhDqhEnr/ksNnQfGXgkiRmjq5s=
X-Gm-Gg: ASbGnctWN4vhc81X7kiKHLCjhcSVt6j3oBFJ9dy74bubQ6vEzUH03VKQ8tes6N59tKH
 12Srd7gNb/1UOWBsahgMJ+nh2ya0SjwmvRkIK2/aw91KFxZm0ZAykaoEPIYqpb+L8Lebjuo1GDw
 pEbJl0c0/ZjuIsFMylQNuyHC+wNB5YufqGBALYr3DvSWzyWp4HsHZM2BCt+9rNa4eg1KG/oZ36D
 mpXdRD7FXRyAYB4AFJUBgug5CJxTzVdwy73ZcpVUCCIxddSm7YApbw1E1+l+MRYNIpFiqd2ZJcP
 AIU+KvKNTzZbtx/c6SLaAMBBoXtfVpxVYttbkFrKdF7/z8hqy03vX9TBr8kU+XEry0sxmIHy0p/
 Y5+T3IVTRIvGFfm7JaVUkcPtLwqZeVZxXR2GyjQMiJQZ2RN2TffZCEUfFEUJAL8qjPHihBVBa56
 1+fg0F7rw=
X-Google-Smtp-Source: AGHT+IEpzU+E80g4GHGl7HsWtmhRsPbGlEq2MbrEnYlqP4svevo6rKXx3AXgm47cXv1AHBXDNtpI8Q==
X-Received: by 2002:a17:907:7210:b0:b73:7710:fe03 with SMTP id
 a640c23a62f3a-b79dc77e2a6mr666893466b.58.1764843992932; 
 Thu, 04 Dec 2025 02:26:32 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4457a42sm97412166b.14.2025.12.04.02.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:32 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v3 0/9] arm: am335x: Switch to upstream devicetree
Date: Thu, 04 Dec 2025 11:25:36 +0100
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBhMWkC/43Ry27DIBAF0F+JWHciHo5DvOp/VF3AMKSoJlBwr
 FZR/r0kfSSq+lqOEYc71wdWqQSqbFgcWKE51JB2bVA3C4YPZrclCK7NTHK5EkJomFIOCCYqBTR
 HSH4qRDC38x64ADJrLogrr9GzhuRCPjyfH7i7b/NDqFMqL+f3ZnH6+m96FsBhI5CEwr4XJG+te
 RmDLbTEFNlJn+WVKP8WZRM7aXSvFO+6jf4iHt8WKPS0b8VMb1swaypBO49hGhZna9msgopdlzY
 s3lOsrlPg+AiFttFkcJQvSWSvpVEbS+TM0Lb4VYr7aiGXZMNueyGE6pT3Xot1b4dW7bfERyU1x
 DwS5Ah2XyHlqf12M7Z4CR/rlYlOaeu0U07/aX7WPKK7EJx3ft0Ziejxx80+iHQqJpd4uY6bNUq
 ObkXGnBLcH4+v2tQPZrQCAAA=
X-Change-ID: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5273; i=msp@baylibre.com;
 h=from:subject:message-id; bh=aeiSrVDWCqqtuBdfNntsMcR9GoWJkCXDjlS7xcNbzLQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxGU+hp31HsoVmQ/iH6nvK5rVxpGqpBHy5d782xJ3r
 +3e0draUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABOxrmBkaPp4cbOynPCWnJrM
 c2G53x2uBPxhXMX79/Mhy1SvA3rnvjAy9LtMqCl0zD4oo+MUk7165d3WgFsFYnfZObg25WXzFd5
 gAwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

The series is split into two logical groups:

- Patches 1-4: Fixes for am335x-evm to boot and support the LCD panel
  with the current u-boot devicetree.
- Patches 5-8: Make upstream devicetree working with uboot. This
  adds tick-timer, adds compatibility of the board code for different
  USB probing and updates the defconfig.

The series has been tested on am335x-evm. Note that I don't have all
other boards built with the am335x_*evm_*defconfig, so tests are
appreciated. buildman reports builds are working.

Dependencies:
  - clk: ti: Cleanup common functions and omap-cm
      https://lore.kernel.org/r/20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com
  - dm: core: Support same compatible in host/gadget musb drivers
      https://lore.kernel.org/r/20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com
  - simple-pm-bus: Make clocks optional
      https://lore.kernel.org/r/20251128-topic-simple-pm-bus-optional-clocks-v2026-01-v1-1-e38040c88b6d@baylibre.com
  - video: simple_panel support for am335x evm panel
      https://lore.kernel.org/r/20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com
  - power: domain: Add ti-omap-prm stub
      https://lore.kernel.org/r/20251128-topic-omap-prm-v2026-01-v1-1-72c5cc4c7728@baylibre.com

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Changes in v3:
- Add patch to unify all config variants for the am335x-evm and similar
  boards. This also updates the upstream defconfig enablement patch to
  effectively switch all config variants to OF_UPSTREAM.
- Link to v2: https://lore.kernel.org/r/20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com

Changes in v2:
- Most of the independent patches were extracted in smaller series
- Added patch to add vidconsole for am335x-evm
- Add chosen tick-timer to all devicetrees that are used with the
  am335x_evm_defconfig
- Link to v1: https://lore.kernel.org/r/20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com

---
Markus Schneider-Pargmann (TI.com) (9):
      arm: dts: am335x-evm: Add backlight to the panel
      configs: am335x_evm_defconfig: Enable panel
      include: configs: am335x_evm: Enable vidconsole
      configs: am335x_evm: Unify evm board defconfigs
      am33xx: Avoid hard failure on USB probe issue
      arm: dts: am335x-*-u-boot: Add chosen tick-timer
      am33xx: Fix comment about config symbols
      am33xx: Support upstream devicetree USB device
      configs: am335x_evm_defconfig: Switch to upstream devicetree

 arch/arm/dts/am335x-bone-common-u-boot.dtsi        | 14 ++++
 arch/arm/dts/am335x-bone-u-boot.dtsi               |  6 ++
 arch/arm/dts/am335x-boneblack-u-boot.dtsi          |  6 ++
 arch/arm/dts/am335x-bonegreen-u-boot.dtsi          |  6 ++
 arch/arm/dts/am335x-evm-u-boot.dtsi                |  6 ++
 arch/arm/dts/am335x-evm.dts                        |  3 +-
 arch/arm/dts/am335x-evmsk-u-boot.dtsi              |  6 ++
 arch/arm/dts/am335x-icev2-u-boot.dtsi              |  4 +
 arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi       |  6 ++
 .../am335x-sancloud-bbe-extended-wifi-u-boot.dtsi  |  6 ++
 arch/arm/mach-omap2/am33xx/board.c                 | 21 +++--
 configs/am335x_evm.config                          | 85 +++++++++++++++++++
 configs/am335x_evm_defconfig                       | 96 ++++------------------
 configs/am335x_evm_spiboot_defconfig               | 85 +------------------
 configs/am335x_hs_evm.config                       | 14 ++++
 configs/am335x_hs_evm_defconfig                    | 95 +--------------------
 configs/am335x_hs_evm_uart_defconfig               | 94 +--------------------
 include/configs/am335x_evm.h                       |  2 +
 18 files changed, 200 insertions(+), 355 deletions(-)
---
base-commit: f4cc2a9f36bdc1b9731aa285cc305d76c48ec79c
change-id: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
prerequisite-change-id: 20251125-topic-am33-clk-regmap-dep-v2026-01-2682a39beeda:v2
prerequisite-patch-id: adc433677bb6413c278d00b9e1d6b04b12d4a825
prerequisite-patch-id: 949cc619ccbb8cca5b29ab30ac37377e45ae607f
prerequisite-change-id: 20251125-topic-musb-probing-v2026-01-1343fff8176b:v1
prerequisite-patch-id: b8514a3b43228ff9ef6812dc5fe5eb53e2f141ae
prerequisite-patch-id: abfdeaa1999e4cbf98229c4eeafa9dd8dac4509e
prerequisite-patch-id: c6cc3f7eba8b785fbb8ea91cea349517c7c364fe
prerequisite-patch-id: 37352dffe91e2aef085c2a08fcbc922723dae7c1
prerequisite-change-id: 20251128-topic-simple-pm-bus-optional-clocks-v2026-01-1cd38bd8d3d8:v1
prerequisite-patch-id: af032219347b46e51f58b7d26dac1f59de77fda9
prerequisite-change-id: 20251128-topic-am33-evm-lcd-v2026-01-004f74a2ccfc:v2
prerequisite-patch-id: 8fb4900ad4d09bcd2018ca4a1cf3066352a0c62c
prerequisite-patch-id: 08f3d2573f9574db8df2489d9637806362022fde
prerequisite-patch-id: e3832aecf03b9de58a4903c0372a20d9f9db86f6
prerequisite-patch-id: 65efd192958e9b5f852dc4bafb30afe526624649
prerequisite-change-id: 20251128-topic-omap-prm-v2026-01-c97c20cd5eaa:v1
prerequisite-patch-id: 92857feb9e8685fe0e68a0e8e18dcdb57df56634

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

