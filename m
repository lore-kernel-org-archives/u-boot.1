Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFF6D216BF
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40FAB88730;
	Tue, 15 Oct 2024 16:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC78884D2; Tue, 15 Oct 2024 16:54:35 +0200 (CEST)
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com
 [136.143.188.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287EC881FD
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=alexey@sgainnovations.com
ARC-Seal: i=1; a=rsa-sha256; t=1729004070; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F6LoCcw8zV3oByjFC98zCI7t/2QIm9tFISIVgYWT76K0HBFJ8we79EKqGceDJyxFveMGbLOz1oPDYvp0YwDkcK+gbRsX5Ch5IEDsT+7ybZDaTumkATfLTqeYWen8pH0no4yGPO7L4+HJGq7zxLnan2V72HYK3olzFBqVhBvVyR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729004070;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=08aSvMalsBmhgnXeiujSMwSJK+uEMbdu4JOSDNT7R88=; 
 b=MO/096VuwyFXZY/xXv5HQioYUngULF6BuEzVAwFetlt3WAnts8GxDO+6s+ifc5+40CU4ndASZs2j81AXgHK+DwZRQxH9wQDkXhqIZzFAXKt2jMWJgan0tII7bcQPnQPskQ5gr1VOvIIW8m6GTykbortxhZ54yAKMLfl2+zW1s4c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=alexey@sgainnovations.com;
 dmarc=pass header.from=<alexey@all4bambi.com>
Received: by mx.zohomail.com with SMTPS id 1729004069117504.18316297582953;
 Tue, 15 Oct 2024 07:54:29 -0700 (PDT)
From: Alexey Tsirlin <alexey@all4bambi.com>
To: u-boot@lists.denx.de
Cc: eugen.hristev@microchip.com,
	Alexey Tsirlin <alexey@all4bambi.com>
Subject: [PATCH 0/1] sama5d3.dtsi pinctrl section fix
Date: Tue, 15 Oct 2024 17:53:06 +0300
Message-Id: <20241015145307.118784-1-alexey@all4bambi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 15 Oct 2024 16:58:22 +0200
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


At present, there are no PIO sections inside pinctrl DTS section in constradiction to the same file used in kernel.
This problem causes the pinctrl driver in u-boot to wrongly detect number of pio ports to be zero which in
turn causes the driver to deny any PIO configuration presented in any section of the DTS, for example Ethernet will
not work because of wrong PIO configuration.



Alexey Tsirlin (1):
  Fixed sama5d3 dts file so PIO sections are inside pinctrl as in kernel
    dts

 arch/arm/dts/sama5d3.dtsi | 111 +++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 55 deletions(-)

-- 
2.34.1

