Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E77ACD6E5B
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C0E86CE8;
	Wed, 11 Oct 2023 12:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9417886CA5; Wed, 11 Oct 2023 12:59:21 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0888886D10
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp84t1697021942twqfzoar
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 11 Oct 2023 18:58:25 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: znfcQSa1hKa4wj/gNrUgOnVCvxrAU08Vu5UvRtEJz6ORFtLeHsz7Teow8pvAK
 8f/mIB0fjjQoFzZk8mWIcjEXya555FWDioqtdpCGA0GHdaMNsqR7wJmo5xxrxwAp/PHmi+8
 7IWDt3Hq9Shmb1KapGFSLzd97Re3akGg/ege4KE0iMShkRImnLFpwryMg4/eYQf87wIXOz1
 X+cO29RcS0D49AbMWe9cqAYdENsQUxWwuxQ/cZPVRSmJxymHV2Fx1S/+xdl8p8CMctxNYVx
 4wkCgRelFAjqkFBK6fGISZJ5A/J3xG7T+CsqBEuxvZAqGSqIpfORKEoF9HQIiQLP/yA891a
 vJnwa89MPFek1NwylNTCoZ85ttnug==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10893672549903286429
From: Bin Meng <bmeng@tinylab.org>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] net: e1000: Drop e1000_eth_ids[]
Date: Wed, 11 Oct 2023 18:58:25 +0800
Message-Id: <20231011105825.2956485-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

e1000_eth_ids holds compatible strings for e1000 devices, but it
is meaningless as e1000 is a PCI device and there is no such
compatible string assigned to e1000 by the DT bindings community.

Drop it.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 drivers/net/e1000.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/e1000.c b/drivers/net/e1000.c
index 41e6ba760e..84a2a7cf90 100644
--- a/drivers/net/e1000.c
+++ b/drivers/net/e1000.c
@@ -5718,15 +5718,9 @@ static const struct eth_ops e1000_eth_ops = {
 	.write_hwaddr = e1000_write_hwaddr,
 };
 
-static const struct udevice_id e1000_eth_ids[] = {
-	{ .compatible = "intel,e1000" },
-	{ }
-};
-
 U_BOOT_DRIVER(eth_e1000) = {
 	.name	= "eth_e1000",
 	.id	= UCLASS_ETH,
-	.of_match = e1000_eth_ids,
 	.bind	= e1000_eth_bind,
 	.probe	= e1000_eth_probe,
 	.ops	= &e1000_eth_ops,
-- 
2.34.1

