Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C776C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 05:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447A7846F8;
	Mon,  6 Jul 2026 07:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.b="DaZstREJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6541846B4; Mon,  6 Jul 2026 03:44:49 +0200 (CEST)
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4718384105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 03:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhuxu_ran@zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1783302281; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lL8Mx9gQ/QjQFx86qvRwCT87TaR118mPSukLcAUE5LPCu5BfVyUXYXSxstOCVbyBokxfA7l6zfdjHrNeWYgNVSrHgUPkDz0jTrBYdBwDa4ndn9bt9jhmUzNfQWmiXC1sl88mw+MsKfCQqS9z/m8z58ma6iEpKpYGw0WBf85jdgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783302281;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Im6fUPbnWpSSFo+nQnsV3hAwIz01/vO19n3d9b7X8tw=; 
 b=DBJPjFSGzVpdEB+RC0ljuqmE4xaZL5J5RzKgln7/rTriiYufPc9dTghRcql5vzZm3ueRKBFpPOVJOFM3Nqe84DCeCqWP3hWc75UtPdCOlZiEtC+FMipN1H4vz6k5wGuDWgrb7omecvbKlEfk2q9PqmVXnvdqRK90BEyfjQTAYLU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783302281; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=Im6fUPbnWpSSFo+nQnsV3hAwIz01/vO19n3d9b7X8tw=;
 b=DaZstREJrtBPLeZxK7cM8l22WLRFJj4HT8FX3TD8wHYeEP79fhaHfewXo12SifhU
 jIKwBs/NBhsiSH3aMuVt7HHU1EX5l8sBUOW6uJBUZKxJvg5ZWeo4P0cKqn9NlPzWuui
 dX2cCP62DhS/OspCNasR+JHkn3G94B+LwsIY4KJg=
Received: by mx.zohomail.com with SMTPS id 1783302280414673.966298901033;
 Sun, 5 Jul 2026 18:44:40 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: [PATCH 0/3] riscv: milkv_duo: Use upstream devicetree
Date: Mon, 06 Jul 2026 09:43:40 +0800
Message-Id: <20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDuQBKvgVUoXMRnr+E8mEUG8u
 2m7/BbvnSAUmASa4oRAOwuvS4Z+FOB6u3wI2WeDUaZStTI48zTu6NOKaZMYyM7oo2D7LC35Une
 u0pDjLVDHx2/8ev8tqR3Ixe8NrusGYfN8ZXoAAAA=
X-Change-ID: 20260702-milkv-duo-upstream-dts-b54aed41fc61
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, Yao Zi <me@ziyao.cc>, 
 Andreas Schwab <schwab@suse.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112274d702c04ee84f5df68080d1e0000aaf1768d898b798af2118dc59d53622603f52774726bf0e81b:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:06:30 +0200
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

This series switches the Milk-V Duo board to the upstream CV1800B
devicetree.

Patch 1 adds the missing clock-controller compatible used by the
upstream CV1800B devicetree. Patch 2 switches the board defconfig to
CONFIG_OF_UPSTREAM and adds a small U-Boot override to keep Ethernet
enabled. Patch 3 removes the now-unused local Milk-V Duo devicetree
files.

Tested on Milk-V Duo:
- U-Boot boots with the upstream control FDT
- serial console works
- MMC is detected and can read the SD card
- Ethernet is probed and DHCP/TFTP work
- Linux boots via TFTP with Image, initramfs and DTB

Build-tested:
- make CROSS_COMPILE=riscv64-linux-gnu- milkv_duo_defconfig
- make CROSS_COMPILE=riscv64-linux-gnu- -j$(nproc)

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
Zhuxu Ran (3):
      clk: sophgo: cv1800b: Add cv1800b clock compatible
      riscv: milkv_duo: Use upstream devicetree
      riscv: dts: milkv_duo: Drop local devicetree files

 arch/riscv/dts/Makefile                      |  1 -
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi | 12 ++++++
 arch/riscv/dts/cv1800b-milkv-duo.dts         | 64 ----------------------------
 arch/riscv/dts/cv1800b.dtsi                  | 22 ----------
 configs/milkv_duo_defconfig                  |  3 +-
 drivers/clk/sophgo/clk-cv1800b.c             |  1 +
 6 files changed, 15 insertions(+), 88 deletions(-)
---
base-commit: 780084d7c07f511da4a39b43277c573156ed42e0
change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61

Best regards,
--  
Zhuxu Ran <zhuxu_ran@zohomail.com>

