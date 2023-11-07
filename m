Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A8FC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 00:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B352F87098;
	Tue,  7 Nov 2023 01:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699315828;
	bh=112CpSsKEJ0rW27arXJge8yZmbNz7lcQa9CMNuA3af0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bMUQ++eCxH1JuSqjHSMwzxaRe+04x+n5fHr55bCWIYuqZbgi0WDrcZ03uKlBEWr2k
	 pf3jbhs27RGvL2oIaCPj7sAUOBQRSfekd1k0kg84ihD2oMjBTITuh3lDrjZu1k+Qj6
	 ZJ8wDqPfOQs9dmPAhBXlxLljmvC5a//kUhcvGWs0BXHB5juZwjlxAp9I7gpMTn8F31
	 PQxwYUCCzoTlVho8gj9WL3wxiKA5X2yDbEgXDyM4rh/gDlEdfh47zgLK+3kCaVlb7Z
	 KZ56bMCUAV9mPjBnohP4TDkkFtFNJqvWdPh+j3bUOMj06Dej4eKoZpzpUCQAiS0A4b
	 /To3XgB+lrXMQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1E4A086CB1;
 Tue,  7 Nov 2023 01:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699315827;
 bh=112CpSsKEJ0rW27arXJge8yZmbNz7lcQa9CMNuA3af0=;
 h=From:To:Cc:Subject:Date:From;
 b=d/F75+oun57K7gm5ToMKB9/jjzJk9ULONWWB8qX/2u9RhpJaTrWApS49eyE1yi17R
 Gukk1I7+iva+PJI24egGtli/QcXEgri6tt4ZMbqBvwDA5dCbk7PF76pqb4KpW7zVHa
 Cf2CBbljpTk4U4Q1Ylw38q2OB4yDjeRV0vahgCSquhfdbBUYC7RVFBZYghMFDOU64z
 pgB7X+TQ0lhDhfWCT34L4W9ldcfeiWwtiYILn0hwqJ08q5aN1H+xW/G40G7whwtsR/
 aQ8tg1d3BkiLwlxxsfWGcoPvLuCPz+ENgVd6Rjgk2oZ8rVZSaaBMdjfQ71BWA8vHlY
 YMnCAgT+ztbvw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH] usb: gadget: f_mass_storage: Stop ums on START-STOP UNIT SCSI
 command
Date: Tue,  7 Nov 2023 01:09:59 +0100
Message-ID: <20231107001018.55640-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Exit the UMS handler loop in case START-STOP UNIT SCSI command is
received. This is sent e.g. by the util-linux eject(1) command and
indicates to the device that it is supposed to spin down the media
and enter low power state.

This effectively adds support for exitting the 'ums' command from
host using 'eject /dev/sdN' that is on par with 'dfu-util -e' .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/usb/gadget/f_mass_storage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 1d17331cb03..c725aed3f62 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -327,6 +327,7 @@ struct fsg_common {
 	unsigned int		short_packet_received:1;
 	unsigned int		bad_lun_okay:1;
 	unsigned int		running:1;
+	unsigned int		eject:1;
 
 	int			thread_wakeup_needed;
 	struct completion	thread_notifier;
@@ -669,6 +670,10 @@ static int sleep_thread(struct fsg_common *common)
 		}
 
 		if (k == 10) {
+			/* Handle START-STOP UNIT */
+			if (common->eject)
+				return -EPIPE;
+
 			/* Handle CTRL+C */
 			if (ctrlc())
 				return -EPIPE;
@@ -1325,6 +1330,8 @@ static int do_start_stop(struct fsg_common *common)
 		return -EINVAL;
 	}
 
+	common->eject = 1;
+
 	return 0;
 }
 
-- 
2.42.0

