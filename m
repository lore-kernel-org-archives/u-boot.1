Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796D5C61DB9
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 10:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 067E360621;
	Sun, 30 Aug 2026 10:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYrQIBfoJoPg; Sun, 30 Aug 2026 10:18:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788085131;
	bh=7y7jhSlTwNBR5dD50OfmQNXxlxJ8h7GKx2tAuemkYL0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V26xwWUvSlkr3KQL0a71tFBx+mVQ2/JUArEy5kqqnOGyJhr9OvtO67H3TbzVXGU+Z
	 ACwDlYuzTlYQdq0630VAqqnu4zBjf361JOCqKNXA5izxlMVgKzKjOVNhS1KoHvVcZT
	 fcjQTBMPoPT11QRuj5B5x4V6f/KspO7XdjSr4rxrCAMHGHCFEG/xociNmpiFUAzJBl
	 8XbnM9Cel9KDSaRS0PZq5/1wZ/d6yycTr1l2RAx1zyH5p50pX8L9KhrnkH8/N/R0Dv
	 YbBs76tb7OrDFskvdLfxqzF08bSiBaQCQHkI54EUYg20ZZQkloxgJ+ZRTFP3QTmyHp
	 yyqXWQh+N7ysw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7206960611;
	Sun, 30 Aug 2026 10:18:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CFCD2FD
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2E3380E09
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9bm7Ezsze-G7 for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 10:18:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jeFsBgYJ
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 510DD80E07
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:18:46 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so2113921f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788085124; x=1788689924;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7y7jhSlTwNBR5dD50OfmQNXxlxJ8h7GKx2tAuemkYL0=;
 b=jeFsBgYJDEn2E8o1aW1hNJQvhMfD9d2t/EULexx1+/wke4aS77S1yASC9WeodQH7Ln
 dIKBsOvhrbDcYgsSCeb4X10KPAcUpQZZUH4AzSiF9j32ND5J3+JDAPIZAo7KF00DKDwG
 HMANKSjDv8mGcEqDP7iapf+ntezvgSKNeM0bdn3nuM+ftO13mgDIDLVVf7QjazbnE30c
 gIsedS2CsyLpZq/ipJk13aC4pOTH5U2rOLWsWwHkyRUNVbbnztaFUY83L109+O+EWwKE
 pNeFOKwNCvRUYaxrZ8s8Fq6/kbA21U/84IvTlmetd8wxAYxZTiCrjzvVkkBQsxHsxbDP
 IgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788085124; x=1788689924;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7y7jhSlTwNBR5dD50OfmQNXxlxJ8h7GKx2tAuemkYL0=;
 b=PCZtr23GaI/McIYGPvRBo2hLr5EQjpv926aPLCyVWOqzBliZct/Qi488Ihs5IYMxDf
 DtOpllZ8bVC75o1bPLqsz8SjSxilS3xr0jqdr7eyi4que8xeXmcdcw/eQZ5nASkjFhvk
 6Juf1bWiWHNqnRl4cIttoobd1UwIc+2mgqTsrhzMNhcHrPaiRHyuEam40Ev6LkdADWDl
 fq87iaG5daYXvgft0bBKrd/ODxrThJa6knRh55M3IXh+jfx74t/t50/oLfSWw6zIqq96
 bPxzpAgz7/jvZN2Oh05ysoRInHxwpqEvXZrj1BtB/fVEIvexN1fGDmJ03w+lkqo7hELn
 2Ojg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzC5+OTbb8YSpgOYARVPjwBsk1exIbNAmGHb4Je3bZKzrdyODbNrJuNiM7yqk6VR3hvFpPhrw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lLsl5y9zikxAuvJ/nUw5DE7RkDRGYzHtOSru/p13pfdXSN4lEU
 G9RCVPNyPG0lJZYz3DnPmdh8To/HjHT8N4B6N2W9Tf218nO1JLMsC8jYEpD1f0eAq0U=
X-Gm-Gg: AYBFou16sV5WpnMgSdWew4ps3uTef53XFgAyP2a/eskNauNPPQzu3ynuSCGs6TGMpyH
 HgJP5fuWMRfZQSCgm+Rs2IVUDXvhhX/XHgcjQqG9Nu2Q0ll5vmo/3NOByz3NWyhPtjwMqlzC7BN
 BMejUGuJjVNelYHFPaLcf10H3hWr6JEO9ceaYxOUdugoeoXVpO1Bg4JUphXjCVXzEGPI9UaSIOl
 NAlY6RjQUjHnviYZuwDdfvDhY1RJj4dJ/XmCp5zLlQzvxB+f8TwP7/PBMAiFZ40llqV+Z0mg7RU
 ks0hK6ECPJKcUgVDQ8bah4Obbms6eQ00IDc3HadzOVmF5jNOo48XSxi+h1XL6p2YK3979y0Ze4R
 t7q26pxJXkV7yELZ2D80d5ca7NBzQPzWUzmsBFPnP8fTZsc2KbcDMYByYDiOvumNG2FPljN7cyM
 +YPIlDZsoMRc2j4aXTOgNAmjyr1rGx1PfAMmvKtWV78Z4YDSIxn0SXsRaXAFcbvizkzVi0ryvkq
 Vy34XUGeS07uU6+m79Tst6huI5P2IMYlJNdUThwqhROgJyNV9YynxtfT+yC7jeL5w8bZ6i7+j17
 H0cB
X-Received: by 2002:a05:6000:2f8a:b0:481:5021:33cd with SMTP id
 ffacd0b85a97d-482f799da69mr26646699f8f.3.1788085124072; 
 Sun, 30 Aug 2026 03:18:44 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3fcesm14644619f8f.5.2026.08.30.03.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 03:18:43 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/3] Add RITY devicetree preparation support
Date: Sun, 30 Aug 2026 12:18:38 +0200
Message-Id: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOzQ6CMBAGX8X07JrSCFZPvofhsC1bqcpPtoVIC
 O9uwXj2OJvJNzuLQOwpiMtuFkyjD75rE6j9Ttga2zuBrxILJVUhtTqBtZgUgqEPkQkbaOITXBW
 hZ+qRCQrt8gxzVylCkWbS3fn3lriVXw6DeZCN6+5q1D7EjqfthzFbvV9O/8+NGUgwTktz1Gcy0
 l0NTi9vmA62a0S5LMsHEdEZBeUAAAA=
X-Change-ID: 20260827-ccaione-upstream-mtk-fdt-prepare-68f51a5fd2ea
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Ramax_Lo_=28=E7=BE=85=E6=98=8E=E9=81=A0=29?= <Ramax.Lo@mediatek.com>,
 =?utf-8?q?Chris-qj_Chen_=28=E9=99=B3=E5=A5=87=E9=80=B2=29?=
 <Chris-qj.Chen@mediatek.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

RITY images select a base devicetree and an ordered list of overlays
through the storage, storage_dev, dtb_path, boot_dtb, fdtfile and list_dtbo
environment variables. EFI boot needs the selected tree to be assembled
and published through fdt_addr before the operating system is started.

The environment interface, source-discovery rules and appended-image layout
form a MediaTek-specific RITY contract. The referenced data uses existing
U-Boot image formats, filesystems and storage stacks.

Add MediaTek support to consume that interface. It locates the selected
source on GPT block partitions or on the RITY UBI/UBIFS NOR layout, loads
the base DTB, applies list_dtbo in order and publishes the completed tree.
Both raw and authenticated DTB and DTBO inputs are supported.

Expose mtk_fdt_prepare for interactive use. Retain the dtbprobe and
fdtprobe command names and positional arguments used by RITY EFI boot
environments. Also provide bootembedded for legacy boot. It locates and
runs the appended RITY boot script through the standard source command,
leaving the legacy policy and authentication to source and bootm.

The command entry points live under cmd/mediatek and are documented under
doc/usage/cmd. The implementation uses existing block, MTD, UBI/UBIFS,
libfdt overlay, image verification, source and bootm services.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Clarify that the RITY contract is MediaTek-specific and uses existing
  U-Boot formats and storage stacks.
- Move command entry points and command configuration under cmd/mediatek.
- Add documentation for mtk_fdt_prepare, dtbprobe, fdtprobe and
  bootembedded.
- Rebase onto commit 658fc6aee957 ("fs/squashfs: fix directory table integer
  overflow" series merge).
- Link to v1: https://patch.msgid.link/20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com

---
Carlo Caione (3):
      arm: mediatek: add RITY devicetree preparation
      arm: mediatek: add RITY devicetree compatibility commands
      arm: mediatek: add bootembedded compatibility command

 MAINTAINERS                                      |   3 +
 arch/arm/include/asm/arch-mediatek/fdt_prepare.h |  10 +
 arch/arm/mach-mediatek/Kconfig                   |  25 ++
 arch/arm/mach-mediatek/Makefile                  |   1 +
 arch/arm/mach-mediatek/fdt_prepare.c             | 501 +++++++++++++++++++++++
 cmd/Kconfig                                      |   1 +
 cmd/Makefile                                     |   3 +
 cmd/mediatek/Kconfig                             |  31 ++
 cmd/mediatek/Makefile                            |   4 +
 cmd/mediatek/bootembedded.c                      |  59 +++
 cmd/mediatek/fdt_prepare.c                       |  65 +++
 doc/usage/cmd/bootembedded.rst                   |  51 +++
 doc/usage/cmd/mtk_fdt_prepare.rst                |  90 ++++
 13 files changed, 844 insertions(+)
---
base-commit: 658fc6aee95784139f070f9945cb3bc5da8d7d22
change-id: 20260827-ccaione-upstream-mtk-fdt-prepare-68f51a5fd2ea

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

