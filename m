Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F96C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C0183A24;
	Thu, 10 Apr 2025 10:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Akh6Pdru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFC883A22; Thu, 10 Apr 2025 10:00:43 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D69B83A1E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 759C56112C;
 Thu, 10 Apr 2025 08:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0291C4CEDD;
 Thu, 10 Apr 2025 08:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744272039;
 bh=bISf9ug2HyWtwqkJd87uu3s/CTYfgqjFoKGkY+Oedhs=;
 h=From:To:Cc:Subject:Date:From;
 b=Akh6PdruU4M0Nlukgcei6NP2OnmAT1N69TD7F8d8mgIvTlTeq/1jOmjYZ2GisnIVq
 ffr/jrn4kRGxt/21xGTpOJFsT5rDLKVuA66iLVJQu/oK3aChxgjqUIK6g2dmam+Jci
 qSO+zom2p0zBLZp90vaisdey0RcDI26mkfdpvXMCv8Vs95h41OgoFLnIs+Rhsx4ECH
 3r0OSJGx+SwNqfDOZHWtjnwq4UnPivpbRJdiZblahuccJHsv+j8faoFUoKa47/bweI
 pM1xJ+/IS3J7wh9vPVjGeBRDEQRIj+0azDchHMarbfQ4Ddiy6o1ow4QPl+J+Df9tHj
 Hyt9c/mgAhsKA==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 alexeymin@postmarketos.org, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v2 0/2] RB1 fixes
Date: Thu, 10 Apr 2025 13:30:25 +0530
Message-ID: <20250410080027.208674-1-sumit.garg@kernel.org>
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

The eMMC on RB1 boards supports HS200 mode but currently the msm_shdci
driver in U-Boot is missing DLL configuration required for HS200 mode to
work. Hence disable HS200 for now until proper support is in place.

Apart from that, add a fix for USB PHY power on sequence which got
broken by recent addition for SM660 platform support.

Changes in v2:
- Drop DT override patch as Caleb fixed SD card and enable USB DT fixup
  via OF_LIVE here [1].
- Expand commit message for eMMC fix.
- Add a patch to fix USB PHY power on sequence.

[1] https://lore.kernel.org/u-boot/20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org/

Sumit Garg (2):
  qcom_defconfig: Disable MMC HS200 mode support
  phy: phy-qcom-qusb2: Fix USB PHY power on sequence

 configs/qcom_defconfig            | 1 -
 drivers/phy/qcom/phy-qcom-qusb2.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

