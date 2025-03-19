Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58528C36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98589819B1;
	Wed, 19 Mar 2025 15:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i6FGPpYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E397C81CA8; Wed, 19 Mar 2025 15:03:45 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB9281951
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JE3WmT2961272
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 09:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742393013;
 bh=N0e0CQCJpqonmcHLUByQGijiINvK1WhHMi5Ply4I1Qs=;
 h=From:To:CC:Subject:Date;
 b=i6FGPpYdSBzSMBIY4QcKqis9BIzaty3fvpumkRq9pmVffxqg9PAsFgkUWgf/7/ouV
 HnxalMhPNBU6jaHzzUzAX7vIXAmY12gi9k/VeodVCFd4rgbBIcT3lgmYwYslS1/E9e
 hN++tEnVGcOfCbCbfAGKrsrqXjwBV6viTDY7YoRc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JE3W2W086018
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Mar 2025 09:03:32 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 09:03:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 09:03:32 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JE3RD8034958;
 Wed, 19 Mar 2025 09:03:28 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <u-kumar1@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <devarsht@ti.com>,
 <quentin.schulz@cherry.de>, <j-choudhary@ti.com>, <jonas@kwiboo.se>,
 <richard@nod.at>, <raymond.mao@linaro.org>, <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>
Subject: [PATCH v2 0/2] Change DRAM message and add RAM doc
Date: Wed, 19 Mar 2025 19:33:25 +0530
Message-ID: <20250319140327.301266-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This short series is an ongoing effort to make RAM utilization clearer for
easier debugging and understanding of code. Intention is for users to quickly
be able to identify the CONFIGs needed to modify for their RAM usecase.

Neha Malcom Francis (2):
  board_f: Modify DRAM message
  doc: memory: Add documentation for system RAM

 .gitattributes                        |   1 +
 common/board_f.c                      |   2 +-
 doc/develop/memory.rst                | 158 +++++++++++++++++++++++++-
 doc/develop/pics/spl_after_reloc.svg  | Bin 0 -> 193600 bytes
 doc/develop/pics/spl_before_reloc.svg | Bin 0 -> 224608 bytes
 5 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 doc/develop/pics/spl_after_reloc.svg
 create mode 100644 doc/develop/pics/spl_before_reloc.svg

-- 
2.34.1

