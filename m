Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44130EE57F8
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 13:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE85488FAF;
	Thu, 12 Sep 2024 15:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=motor-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B505B88F9D; Thu, 12 Sep 2024 14:02:42 +0200 (CEST)
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com
 [115.124.28.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBCCD88F4B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 14:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=motor-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Frank.Sae@motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com
 fp:SMTPD_---.ZHPh8a3_1726142549) by smtp.aliyun-inc.com;
 Thu, 12 Sep 2024 20:02:33 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 trini@konsulko.com, Frank.Sae@motor-comm.com, ycliang@andestech.com,
 tekieli.lukasz@gmail.com, frattaroli.nicolas@gmail.com
Cc: yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
 jie.han@motor-comm.com
Subject: [PATCH v1 0/2] Add driver for Motorcomm YT8821 2.5G ethernet phy
Date: Thu, 12 Sep 2024 05:02:23 -0700
Message-Id: <20240912120225.28884-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 15:11:43 +0200
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

YT8531 as Gigabit transceiver uses bit15:14(bit9 reserved default 0) as phy
speed mask, YT8821 as 2.5 Gigabit transceiver uses bit9 bit15:14 as phy
speed mask.

Be compatible to YT8821, reform phy speed mask and phy speed macro.

Based on update above, add YT8821 2.5G phy driver.

Frank Sae (2):
  net: phy: motorcomm: Optimize phy speed mask to be compatible to
    YT8821
  net: phy: motorcomm: Add driver for Motorcomm YT8821 2.5G ethernet phy

 drivers/net/phy/motorcomm.c | 505 +++++++++++++++++++++++++++++++++++-
 1 file changed, 499 insertions(+), 6 deletions(-)

-- 
2.34.1

