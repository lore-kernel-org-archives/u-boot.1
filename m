Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBE9C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9372587EDE;
	Mon, 26 Feb 2024 14:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FKwPvCTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0638D87EFE; Mon, 26 Feb 2024 14:30:18 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F72387EDC
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 14:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1708954215; x=1711546215;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lkhct33U1DRe4k6cbnx5RCB46WgY22edFk85ShYxvU4=;
 b=FKwPvCTntCEKCabUdYzm0xSwxsrVUnHsJWTnOKol4iSHuNRiVXoBhweYPOwfd84c
 E0eONwCc9BWXufLVy1mb4tEoU0j9Wo1viPfxc+uBZH9CdRVrovr2e/7Ru/46C4fB
 Z1+8Utx0FOuddIwAxB256EH/jubbSXeX/D27atHlqCQ=;
X-AuditID: ac14000a-fadff7000000290d-e2-65dc9267a349
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F0.B8.10509.7629CD56;
 Mon, 26 Feb 2024 14:30:15 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Feb
 2024 14:30:40 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>
Subject: [PATCH 0/2] *** Introduce get_boot_device() for K3 platform ***
Date: Mon, 26 Feb 2024 14:30:04 +0100
Message-ID: <20240226133006.3279993-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWyRpKBRzd90p1Ug12PuCzmvjnAavHmx1km
 i7d7O9ktut+pO7B4nL2zg9Gjv7uF1eP4je1MAcxRXDYpqTmZZalF+nYJXBlbTs5gKXjIXvHy
 zAKmBsZnrF2MnBwSAiYS605cA7K5OIQEFjNJ3Gr6wgySEBJ4zChxYJUpiM0moC5xZ8M3sAYR
 ASmJl50bwWqYBSwkzp24wgZiCwt4SFx7/ZcFxGYRUJU4cOw7WJxXwFLixqR7jBDL5CVmXvrO
 DhEXlDg58wkLxBx5ieats6FmSkgcfPEC6gZ5iReXlrPA9E4795oZwg6V2PplO9MERoFZSEbN
 QjJqFpJRCxiZVzEK5WYmZ6cWZWbrFWRUlqQm66WkbmIEBasIA9cOxr45HocYmTgYDzFKcDAr
 ifCGy9xMFeJNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cBo
 +veUmFgJu/LrzCVMSTPDy01SEtyKtjT+MeXdEB2y7cuFycaCJ29LWFs8e8z1x++74KNsHe7w
 gLPFNwN3Lrrz9e9O6btuElcKIuSWpvjx3EycJfz0veHMC0q6C4TK6jbfXZG6wur0zakpzwsL
 m8XlFmy09vxnuPjDSZOWbzPe+etwCE+2nrRNiaU4I9FQi7moOBEAlHK0XEQCAAA=
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

It is handy to have some u-boot environment variables set based on
the current booting device.
Provide a way to obtain the boot device for non SPLs by factoring out
spl_boot_device() into an own function get_boot_device().

Wadim Egorov (2):
  arm: mach-k3: am625: copy bootindex to OCRAM for main domain SPL
  arm: mach-k3: am625: Provide a way to obtain boot device for non SPLs

 arch/arm/mach-k3/Kconfig                      |   3 +-
 arch/arm/mach-k3/Makefile                     |   1 +
 arch/arm/mach-k3/am625_init.c                 | 110 +++---------------
 arch/arm/mach-k3/am62x/Makefile               |   2 +
 arch/arm/mach-k3/am62x/boot.c                 | 103 ++++++++++++++++
 arch/arm/mach-k3/include/mach/am62_hardware.h |  15 +++
 arch/arm/mach-k3/include/mach/hardware.h      |   1 +
 7 files changed, 138 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62x/Makefile
 create mode 100644 arch/arm/mach-k3/am62x/boot.c

-- 
2.34.1

