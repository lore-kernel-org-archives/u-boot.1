Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942CCD5C0C4
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D82892A1;
	Fri,  8 Nov 2024 14:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=khoahoang.com header.i=admin@khoahoang.com header.b="c9bsSyR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB7288EC6; Fri,  8 Nov 2024 06:52:02 +0100 (CET)
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com
 [136.143.188.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094F688F62
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 06:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=admin@khoahoang.com
ARC-Seal: i=1; a=rsa-sha256; t=1731045116; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZtrXAK4edjOL22Dr56eKexGJDHeOgO9Aqv2npQNx6HaqFpCr97yztQ55pxKdmSoq/kplVemv0sm4dMb87qU62VSZCLIpqXYP2G29SjzOTK5Zt4ZBKE1a90Jx/KgEuHPBWZjmpaQAvoiKQxRCZ7j80DciVpDopnTrzsSBa9FNflQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731045116;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=A1gqrSULPiggcOLbxa7zhSLRJB4v88u870K402nXWu8=; 
 b=gmelbcWLilPtLFy3Pm8QFBZC/5a8D6s8jny4+vjBX/d2itVMD9ZIMQYX4CyObhhBZizoUTlXqOoLsTvdggkJnI8QtHXrTg7a23o2E43X9eNvrDTy2v2tPzzxcaeKxMneAWeAEz1NhG96pDJ2rvmt4ECwD/KpY1pHYnL4kpq5sRU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=khoahoang.com;
 spf=pass  smtp.mailfrom=admin@khoahoang.com;
 dmarc=pass header.from=<admin@khoahoang.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731045116; 
 s=zoho; d=khoahoang.com; i=admin@khoahoang.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
 bh=A1gqrSULPiggcOLbxa7zhSLRJB4v88u870K402nXWu8=;
 b=c9bsSyR2umSU8gyQoxKHOcwPvfDZBi8P8ey9xWetb2iBGIAWV3SuElaxMArCG61d
 QwgkZNp8y454nsiQY4Xc7M3gagQtJTbJY5+tPfKtEqcGSZyk/JQmaUGIWXYqF8l0Oyu
 +6D8EWgSktnOPu8ETBPex3xR5diyigKRZMybo0Xs=
Received: by mx.zohomail.com with SMTPS id 1731045115659419.042082439511;
 Thu, 7 Nov 2024 21:51:55 -0800 (PST)
From: Khoa Hoang <admin@khoahoang.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Khoa Hoang <admin@khoahoang.com>
Subject: [PATCH v2 0/2] eth: asix88179: Fixes for ASIX AX88179A variant
Date: Thu,  7 Nov 2024 21:51:34 -0800
Message-Id: <20241108055136.50701-1-admin@khoahoang.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

This series provides fixes for the ASIX AX88179A Ethernet driver in
U-Boot, addressing issues with PHY hang and stalling when handling
large fragmented packets on the ASIX AX88179A variant.

v1 -> v2:
    - Fix PHY reset and auto-negotiation restart logic
    - Remove ADVERTISE_NPAGE bit from MII_ADVERTISE register
    - Add reproduction steps for large fragmented packet stall
    - Adjust AX_RX_URB_SIZE to align with updated bulk-in size

Tested on a Raspberry Pi 3 Model B V1.2 with the following adapters:
 - Amazon Basics USB 3.0 to Gigabit Ethernet (B00M77HMU0) - ASIX AX88179
 - Hiearcool USB C Hub with Gigabit Ethernet (UCN3610) - ASIX AX88179A
 - Plugable USB C to Ethernet Adapter (USBC-E1000) - ASIX AX88179

Khoa Hoang (2):
  eth: asix88179: Fix ASIX AX88179A PHY hang
  eth: asix88179: packet drop when receiving large fragmented packets

 drivers/usb/eth/asix88179.c | 45 ++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

-- 
2.39.2

