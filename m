Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96B8C36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37361830AF;
	Mon,  7 Apr 2025 20:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BAF682E40; Mon,  7 Apr 2025 15:22:17 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6CC482CEB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=u/I6=WZ=oss.qualcomm.com=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 620AC441F5;
 Mon,  7 Apr 2025 13:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24029C4CEDD;
 Mon,  7 Apr 2025 13:22:10 +0000 (UTC)
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 0/2] RB1 fixes
Date: Mon,  7 Apr 2025 18:51:55 +0530
Message-ID: <20250407132157.34628-1-sumit.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Apr 2025 20:15:00 +0200
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

