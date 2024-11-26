Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C601D3B98D
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 13:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B9589684;
	Tue, 26 Nov 2024 14:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ghpXeCm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C56C89C61; Tue, 26 Nov 2024 11:51:48 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BA589C64
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 11:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQApaf8817288
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2024 04:51:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732618296;
 bh=iT0IkTdLKdbnaVYhMQtmwK2tk8iijpDRgRxK/nZf6po=;
 h=From:To:CC:Subject:Date;
 b=ghpXeCm3+adKOxaWTpHvSx+00tSgv2gVyf/pBmDu3DG6xvfDyyZUP/JW8rZyYFH4j
 Q964l3fOx2rPWed+X+d7ezEPjjOG+I8NLlFRcCQKIVIG24aDa7n3hRlc6jCvRDL9Y0
 crWfjJMT52/PLo8uy54Jb5rqsGTR17B+BtQgZPec=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQApafb048263
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Nov 2024 04:51:36 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 04:51:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 04:51:36 -0600
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.52])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQApXPP104864;
 Tue, 26 Nov 2024 04:51:34 -0600
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>
CC: <sjg@chromium.org>, <rasmus.villemoes@prevas.dk>, <sr@denx.de>,
 <pbrobinson@gmail.com>, <jonas@kwiboo.se>, <u-boot@lists.denx.de>, Gokul
 Praveen <g-praveen@ti.com>
Subject: [PATCH 0/2] UART support for higher baudrate
Date: Tue, 26 Nov 2024 16:21:29 +0530
Message-ID: <20241126105131.43359-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 26 Nov 2024 14:09:03 +0100
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

The OMAP specific UART driver is changed from a generic implementation of
certain ops functions to an OMAP specific implementation of it to add
support for higher baudrates for OMAP devices.

Hence to support the above change, static functionality of ops functions
in generic ns16550 UART U-Boot driver is removed and also migrated certain
macros to its header file for usage in device-specific drivers.

Boot logs link :

https://gist.github.com/GOKU-THUG/8b90117c963e5da5c1b6caeee427c82c

Gokul Praveen (2):
  serial: ns16550: Increase scope of ops functions
  drivers: serial: serial_omap: Fix TI OMAP UART U-Boot driver to
    support higher baudrates

 drivers/serial/ns16550.c     | 25 ++++++----------
 drivers/serial/serial_omap.c | 56 +++++++++++++++++++++++++++++++++++-
 include/ns16550.h            | 18 ++++++++++++
 3 files changed, 81 insertions(+), 18 deletions(-)

-- 
2.34.1

