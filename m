Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CCDC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 05:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8B0882D3;
	Fri,  3 May 2024 07:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="OJa5PIKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF7688317; Fri,  3 May 2024 07:24:09 +0200 (CEST)
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com
 [192.19.144.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA795882D0
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 07:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net
 (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4C384C0000E2;
 Thu,  2 May 2024 22:24:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4C384C0000E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1714713845;
 bh=vIGh3MNXIrs93ncSMPdBb778AVdJ40InQuit9pAYijk=;
 h=From:To:Cc:Subject:Date:From;
 b=OJa5PIKu9hAF9vjxdNsKJXcna5ud9utOi2cR6AZw/BNOjIhPaRSvh3U+lDaEHCXx/
 2wE+tobWVUMW61Qpb5Bcy8BLkPpWPCSeViSxqCjp/wQkOkRqfcF0DQAvoKiKQYDPWe
 Ealb4F4MJvPSFN4iqStFvYA5Lxk7boDJM/3rYghQ=
Received: from bcacpedev-irv-3.lvn.broadcom.net
 (bcacpedev-irv-3.lvn.broadcom.net [10.173.232.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 7BC2818041CAC4;
 Thu,  2 May 2024 22:24:03 -0700 (PDT)
From: William Zhang <william.zhang@broadcom.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	trini@konsulko.com
Cc: dan.beygelman@broadcom.com, philippe.reynes@softathome.com,
 kursad.oney@broadcom.com, anand.gore@broadcom.com,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Sumit Garg <sumit.garg@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] MAINTAINERS: update Broadcom BCMBCA maintainer
Date: Thu,  2 May 2024 22:23:43 -0700
Message-Id: <20240503052344.195819-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
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

Joel is no longer with Broadcom. Remove his email from bcmbca maintainer
list and replace him with myself for stack protection maintainer.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 921ce05755a6..7a3b4d3712c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -224,7 +224,6 @@ ARM BROADCOM BCMBCA
 M:	Anand Gore <anand.gore@broadcom.com>
 M:	William Zhang <william.zhang@broadcom.com>
 M:	Kursad Oney <kursad.oney@broadcom.com>
-M:	Joel Peshkin <joel.peshkin@broadcom.com>
 M:	Philippe Reynes <philippe.reynes@softathome.com>
 S:	Maintained
 F:	arch/arm/mach-bcmbca/
@@ -1568,7 +1567,7 @@ F:	cmd/sqfs.c
 F:	test/py/tests/test_fs/test_squashfs/
 
 STACKPROTECTOR
-M:	Joel Peshkin <joel.peshkin@broadcom.com>
+M:	William Zhang <william.zhang@broadcom.com>
 S:	Maintained
 F:	common/stackprot.c
 F:	cmd/stackprot_test.c
-- 
2.37.3

