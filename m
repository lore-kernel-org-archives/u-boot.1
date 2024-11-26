Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E42D5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 04:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ACBD89C1B;
	Tue, 26 Nov 2024 05:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.b="T0FdPxO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1968A89430; Tue, 26 Nov 2024 03:30:35 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC6189338
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 03:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hau@realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AQ2UTaL4290999,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
 t=1732588230; bh=JOvTLdzRP2fhnFSkqpg/GkUFKftrRY8+/3Bstj1tz4I=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=T0FdPxO53X6yrUJcMBDVp3+7xXI42D9Lo04nKKcYfs79mS/0T1bu1AW86Jky4MgWT
 xm7KWoCPQIC8Cy98J/CV0FvD+qg3QwOAXN/YMhWlbrByKRZxp6OeC1Wg70QidlYELQ
 lDokPiQKP80MgtVk+8PBFMHntPox4ps28O6E8r+Zt75oGA3DPuVjNcCcllwOqHdw0h
 Kk4AA7fNhObsH3OJewpYA84qfJzU/uYRRETRFjCptneS+9NKntvznXuuzGmSLRJ+Lj
 lRS0xSDO/h9GZa25HDwB6rM6OE1NAkLPMwwB6adZTsj8+TV+TXcBd9lDIj2vI/YqzL
 Nc9rc6rivsGDA==
Received: from RSEXMBS03.realsil.com.cn ([172.29.17.197])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AQ2UTaL4290999
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:30:30 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RSEXMBS03.realsil.com.cn (172.29.17.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Nov 2024 10:30:29 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 26 Nov 2024 10:25:29 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 26 Nov 2024 10:25:29 +0800
From: ChunHao Lin <hau@realtek.com>
To: <u-boot@lists.denx.de>
CC: ChunHao Lin <hau@realtek.com>
Subject: [PATCH 0/5] usb: eth: r8152: support more chips
Date: Tue, 26 Nov 2024 10:25:10 +0800
Message-ID: <20241126022515.4043-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 26 Nov 2024 05:50:13 +0100
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

This series of patches are used to support rtl8153c/rtl8156/rtl8157.

ChunHao Lin (5):
  usb: eth: r8152: Add helper functions
  usb: eth: r8152: Add support for rtl8156 and rtl8156b
  usb: eth: r8152: Add support for rtl8153c
  usb: eth: r8152: Use variable to store descritpor size
  usb: eth: r8152: Add support for rtl8157

 drivers/usb/eth/r8152.c    | 2137 ++++++++-
 drivers/usb/eth/r8152.h    |  243 +-
 drivers/usb/eth/r8152_fw.c | 9330 +++++++++++++++++++++++++++++++++++-
 3 files changed, 11602 insertions(+), 108 deletions(-)

-- 
2.43.0

