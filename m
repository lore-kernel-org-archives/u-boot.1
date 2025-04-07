Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C499AC3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 13:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0255D82CFD;
	Mon,  7 Apr 2025 15:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="r4Sae0P8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4AC382E40; Mon,  7 Apr 2025 15:28:37 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD1D82B8E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CC91F61130;
 Mon,  7 Apr 2025 13:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB93C4CEE7;
 Mon,  7 Apr 2025 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744032513;
 bh=HuCVaieEE3p7b9TALCU6i6ktOiSZNyFY32ZyJDvm9dw=;
 h=From:To:Cc:Subject:Date:From;
 b=r4Sae0P8uq4QXkMID96pc4BBzv9Cdpdtp/ncp2tjGXgncB9EVNS+fN5b+E6RT7qfw
 SQwTeOJWnjGwMwVu4haBNcziWDNbv0NuVmnr0JV8OOEz8t7QzJZ1EMMFYVqlqbjRjv
 wH0umuTEysu7vLf4FuvlAE3oXMyyCizCFilpi47OV/rqD6UdBhhjRa9jZddkbMWZDG
 gwnOkSgXO9hTKc2X2Q8VSiBGAr/jdxOC4MhJV9CKyUbfsqHJ2UAqlwCgE8RT29ricn
 U5P71vDAi/vwiJ7HFAT2v+9K+Nb2mk77wLTpm6qR4olYGgvKN+MGEQrW0hIqbXpOEs
 T2zwB1l5CFQuA==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 0/2] RB1 fixes
Date: Mon,  7 Apr 2025 18:58:08 +0530
Message-ID: <20250407132810.35149-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

The eMMC on RB1 boards supports HS200 mode but currently the msm_shdci
driver in U-Boot is missing DLL configuration required for HS200 mode to
work. Hence disable HS200 for now until proper support is in place.

Apart from that, add DT override for USB to work in host mode as otg
mode isn't supported. Along with that disable sdhci_2 which doesn't work
as of now.

There is another patch related to clk_stub posted here [1] which allows
the MMC clocks to be probed properly.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250407120536.236003-4-jorge.ramirez@oss.qualcomm.com/

Sumit Garg (2):
  arm: dts: Add override for RB1
  qcom_defconfig: Disable MMC HS200 mode support

 arch/arm/dts/qrb2210-rb1-u-boot.dtsi | 11 +++++++++++
 configs/qcom_defconfig               |  1 -
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/qrb2210-rb1-u-boot.dtsi

-- 
2.43.0

