Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A5EC25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 06:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD2E881B8;
	Wed, 15 May 2024 08:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715754289;
	bh=S1/g2iNjILQm+mVcc8HUfE4cyNYHjUs1aFkgSmjdeJc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xpFzidtn5Eqj16kKrm3PeJOWQFr12uklaniIhQ2hm/vsr+WLGdgoxIQ2pMPJ4Uzyc
	 Csdpb6C7kRsj2EEpwns3E7XS3bfhkyr7g5spayI0FxAGl6YwAMBz101xl3fEQLxKJa
	 yDUB1rbpBZxEOu+Q/46yaYTEaJ7Dvb6Vy2NcAtUwCJ+ugZrAZ9p3GsX1bWA36zP685
	 UcuGlWA5Vkoz2SciDsfXo8Iu1MRivAJmDZWQOykHvVEm38WYRfkLisyxl2UL9iT7uV
	 HOgsjJKSsfYPCV2LV0KPADD+zS2CFRRHJX2HmCY4U3CfXmmR2eEWEwTHAkjsvFGUSu
	 NPKPjtHVk0jww==
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de
 [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: noc@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 580E28817B
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 08:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715754288;
 bh=S1/g2iNjILQm+mVcc8HUfE4cyNYHjUs1aFkgSmjdeJc=;
 h=From:To:Cc:Subject:Date:From;
 b=Tj/IMEoybx3c9tuEVOl04JR+FSq5VCc6PnYbEckwNxmDfgDiLtx0crn6HF9XNC79R
 0qkX9giKX8DIACf1x0cTftq81rnuqFJGxb6u9wm3VhKURxasNVEEmqYEWkJVT+Fvnq
 9K6ktgidwVL8sR41czvalV4Wv1KWdnMaPP6Hm8xC6gdZK3DXFJwP+IVrU9j/G41p5Q
 ypEfa5XQmSbVyCD2hhlf5JfmiT9CUD/zqpTnGr2XdOGxTTpAm7Y9iHYf1u88GkgjwU
 65h0RhYY8f3k44lXSTsT9zcWRtOT5umLO9ZNBqxZU8+sBk1VFrqiTt0/zYnhiKLufo
 RVD2Zb7urx7iQ==
Received: from pollux.denx.de (pollux [192.168.1.1])
 by mail-internal.denx.de (Postfix) with ESMTPS id 8DBDD180A69;
 Wed, 15 May 2024 08:24:44 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
 id 5DAE21A8BFE; Wed, 15 May 2024 08:24:44 +0200 (CEST)
From: Heiko Schocher <hs@denx.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>
Subject: [PATCH v1] usb: remove not used variable in usb_ether_curr_dev
Date: Wed, 15 May 2024 08:24:41 +0200
Message-Id: <20240515062442.9667-1-hs@denx.de>
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

grepping for usb_ether_curr_dev in u-boot source code shows

$ grep -r usb_ether_curr_dev .
./cmd/usb.c:static int __maybe_unused usb_ether_curr_dev = -1; /* current ethernet device */
$

only declared but never used, so it can safely
removed from code.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
azure build started for it, see:

https://dev.azure.com/hs0298/hs/_build/results?buildId=112&view=results

 cmd/usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/cmd/usb.c b/cmd/usb.c
index 3a3764a5b8..225d929176 100644
--- a/cmd/usb.c
+++ b/cmd/usb.c
@@ -25,9 +25,6 @@
 #ifdef CONFIG_USB_STORAGE
 static int usb_stor_curr_dev = -1; /* current device */
 #endif
-#if defined(CONFIG_USB_HOST_ETHER) && !defined(CONFIG_DM_ETH)
-static int __maybe_unused usb_ether_curr_dev = -1; /* current ethernet device */
-#endif
 
 /* some display routines (info command) */
 static char *usb_get_class_desc(unsigned char dclass)
-- 
2.37.3

