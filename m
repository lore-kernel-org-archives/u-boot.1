Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F1FC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95249807D6;
	Mon, 10 Feb 2025 17:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PEILNB7m";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="Sdmx4Zln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8764A807D6; Mon, 10 Feb 2025 16:29:56 +0100 (CET)
Received: from a7-40.smtp-out.eu-west-1.amazonses.com
 (a7-40.smtp-out.eu-west-1.amazonses.com [54.240.7.40])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E81803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020194f07b3323-afacb0f8-267a-465d-b377-390312be437e-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1739201393;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
 bh=i/hBI6Yt8DV3YCDvsm3gyvazjt5mjHsXRZNwQEfTH9A=;
 b=PEILNB7mXniHHdKEPA0B9/CfsrbZSI0KKYLb4mI2NQW5ol3n6J+USE6kuXe7gr5V
 OjP637c9RH38GVY7CDNcXxV7+gdPPs1ciJ83NtU20YAFXUnkznigm0MM1lZYlAL9TdX
 /A19r37waaNS9gg5JL+RV72TBO5mmuuL1Cv68/RFU1+/tv6+FRIGj8jW7q7spYYYpns
 R0uYP8EKHndvaXSOtCedJyL6PPLCMVwpgyryxq7TueCO24UFK8TR8MOUTq+L7cK0y0W
 zA6MNHs0ifqzBajEUHB8TJBiPFFsec+lHEhy3G1IRBq4rQDhPox2TKcNvAp9ifi0GrM
 Tj3aD6ew0w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1739201393;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=i/hBI6Yt8DV3YCDvsm3gyvazjt5mjHsXRZNwQEfTH9A=;
 b=Sdmx4Zlni+Va8Ai4SiYRv+Awh/U8ExF4sgkucu8/B3gJWRUqhiilipnbjToAlRNK
 G60uNW+cTecijIKtanCDrL8Nuw+SoPgPgaqrTW/DkMvkrArVYzAvlJB/5cQPAshHaMx
 r3BID0M+fKnWdEo+K1v1tHPvHkngzEbhVn9GA+vc=
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>
Subject: [PATCH 0/6] roc-pc-rk3399: Add SPL_DFU support
Date: Mon, 10 Feb 2025 15:29:53 +0000
Message-ID: <01020194f07b3323-afacb0f8-267a-465d-b377-390312be437e-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.02.10-54.240.7.40
X-Mailman-Approved-At: Mon, 10 Feb 2025 17:47:57 +0100
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

This patch series aims at allowing to boot u-boot proper over DFU on
roc-pc-rk3399.
While the changes are pretty generic, I wanted to enable the device I've
tested. I may try later to test that on my pinebook pro.

What I tried was to boot u-boot TPL+SPL with the device in maskrom mode,
downloaded over the otg port with a file generated with Rockchip boot_merger.
Then u-boot SPL is downloading/booting over DFU the u-boot proper (uboot.itb).

Arnaud Patard (6):
  drivers/Makefile: Fix TPL build with dwc3 generic
  arch/arm/mach-rockchip/spl-boot-order.c:  Add DFU boot media
  arch/arm/mach-rockchip/rk3399/rk3399.c: Add gadget device to boot
    devices
  include/configs/rk3399_common.h: define CFG_EXTRA_ENV_SETTINGS in XPL
    build
  arch/arm/dts/rk3399-roc-pc-u-boot.dtsi: Prepare for SPL DFU
  configs/roc-pc-rk3399_defconfig: Enable SPL DFU for roc-pc-rk3399

 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi  | 23 +++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3399/rk3399.c  |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c |  3 +++
 configs/roc-pc-rk3399_defconfig         | 14 +++++++++++++-
 drivers/Makefile                        |  1 +
 include/configs/rk3399_common.h         | 18 ++++++++++++++++--
 6 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.39.5

