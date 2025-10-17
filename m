Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F4CCCD184
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 23:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD66383804;
	Sat, 18 Oct 2025 01:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DG4LbVQb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h4Z/rvP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A048382E; Sat, 18 Oct 2025 01:28:18 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9465D83771
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 01:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cpLbh2hRtz9tQq;
 Sat, 18 Oct 2025 01:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760743696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8wKOL9lMGd3bpxUFFfT1u8ixsZ86lXvCNbFtuUiAbuM=;
 b=DG4LbVQbTc/k0/5dZn07G8GiqiXFv89J898F67WpMRjxDWUSEx+9Rk5L1V6rajx0Utfx+P
 zZDu4b/rDzGfE31SBP8a2ZdZsD6fOci4awIqx1e3q+9HfJQialV71itb4V757MaMC7pjtS
 xMIEkJt7YtH0gys+w0+cKIRxVm9lMX5upkdeOl2Wl0+x8IDPi12mPlnGh5J1t/fUfne1DV
 lxSojPu/gE/AV2GBHP2ijWghCwWMYXp6sr9b9l5ICNLMpIE+Yr3wSFt2FpiZ7hSBjtrZCY
 AChh9kGttC63l5S0YguOzZWGIM/DXjlVDwJWoNgpjgIJQN9+22sNN142lLKBSQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760743694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8wKOL9lMGd3bpxUFFfT1u8ixsZ86lXvCNbFtuUiAbuM=;
 b=h4Z/rvP8HJ6mmgUot2Qy2RlcrEGWhnzEXuTZQsaycyYrR8piIvVg9liav9YR4klEB3onGY
 f1TXFjn1Us0Q+1+uoLSXU/T2OVOXQ73leSErgL303XwSZYR0IP+eFJD64sTt2cMiWxToXx
 IpIyWLfSd7mjMUBjoEq7dUOnpySVf2MSN/cPJ2S3HKG0JDUQe6CzlkjReFkUzjwMZoucxt
 pWPgY1b9Q2rs7/G1+T+zDsjh6ECR1olMoDYghKaV1cfMcoWGjQl3SiyKV4WyFu/Ig2e66H
 mKi00ayH0UClns5cofm8gTtZm2/Q+h3RafCdXdGE9l7FrJGM2Aiuue2zod4obw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sat, 18 Oct 2025 01:25:52 +0200
Message-ID: <20251017232759.151857-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ac80796af2aaac11c22
X-MBO-RS-META: twhryx3d9841a8a5ix6rg8pktjfjsa1u
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

SH HSCIF FIFO fixes, R-Car V4H/V4M DT corrections, R-Car V4H Sparrow Hawk PCIe
shutdown support before booting Linux.

The following changes since commit bf1d8c1fec863b7da2f0d1ed4bd5526275d70dc2:

  test/py: Update to a newer pytest release (2025-10-16 18:03:27 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to b9efaf6729d06df94ded46710725746a41eaf0fc:

  ARM: dts: renesas: Disable RPC driver on R8A779H0 V4M Gray Hawk board (2025-10-18 00:19:03 +0200)

----------------------------------------------------------------
Marek Vasut (5):
      pci: pcie-rcar-gen4: Shut down controller on link down and remove
      arm64: renesas: r8a779g3: Reset PCIe before next stage on Retronix R-Car V4H Sparrow Hawk
      serial: sh: Handle HSCIF RX FIFO overflow
      ARM: dts: renesas: Disable R8A779G0 V4H White Hawk RPC SPI DT node again
      ARM: dts: renesas: Reinstate R8A779H0 V4M U-Boot DTs

Nguyen Tran (1):
      ARM: dts: renesas: Disable RPC driver on R8A779H0 V4M Gray Hawk board

 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi       |  2 ++
 arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi | 41 ++++++++++++++++++++++
 arch/arm/dts/r8a779h0-u-boot.dtsi                  | 11 ++++++
 board/renesas/sparrowhawk/sparrowhawk.c            | 27 ++++++++++++++
 drivers/pci/pci-rcar-gen4.c                        | 26 ++++++++++++++
 drivers/serial/serial_sh.c                         | 11 +++++-
 6 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi
