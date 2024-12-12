Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A1EE77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AE48021A;
	Thu, 12 Dec 2024 14:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="fs7YAplz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44DC9801EB; Thu, 12 Dec 2024 07:28:37 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AD8801DB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vvmitrofanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 2304912001D;
 Thu, 12 Dec 2024 09:28:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2304912001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733984914;
 bh=6xcHeLshMtWxl8koLUnLLilvuc64fXhwLV9oGJhBgLU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=fs7YAplzxO4EOj4+ZJ2oxrT/PByik2UXT/P8ZVvgBI70Y6DmmefL4Qre8hrgIut6V
 zmyqV/mMG/4ZrrrbiG7WypYzRtIXP77sIkiAPVl2LHYq3EDnVE/G3BCO/zlXwqFbyD
 9WZHYfcKYGjN+8L0h3P88KFSgknNZBfF1oa/c0jsqTp5pIFuqoZPiWqRoFoEqANvbV
 kqzTHbM4v6nhgLGelHgEG1y4qBsUcnRh9X8YjSvM/riC8kCZPqMve2VGPz6Pghv58x
 hPEMV+Dk8xADRqPFITTxZSasZywC7e+A/dV42opGxRRve9u0bjVDla6nBFCK2jS9ZI
 +wiidJAto+xnQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Dec 2024 09:28:33 +0300 (MSK)
From: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
To: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?q?=C5=81ukasz=20Majewski?=
 <l.majewski@samsung.com>
CC: <kernel@salutedevices.com>, <nonameletters@gmail.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] drivers: usb: gadget: composite: add checking for interface
 number
Date: Thu, 12 Dec 2024 09:27:51 +0300
Message-ID: <20241212062752.3769114-1-vvmitrofanov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.160.88]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189782 [Dec 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: vvmitrofanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/12 03:57:00 #26879486
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:14:07 +0100
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

Some proprietary protocols uses "w_index" field not by the rules.
When we set "intf = w_index & 0xFF" variable without check it may
exceed maximum number of interfaces. Not all code cases below check
the range of this variable. In some protocols it is usefull to
guaranty that "intf" not exceed MAX_CONFIG_INTERFACES.

Fixes: 7010f5b94fa3 ("usb:gadget:composite USB composite gadget support")
Signed-off-by: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
---
 drivers/usb/gadget/composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 04b8541993..4bb2afa833 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1011,7 +1011,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	u16				w_index = le16_to_cpu(ctrl->wIndex);
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	struct usb_composite_dev	*cdev = get_gadget_data(gadget);
-	u8				intf = w_index & 0xFF;
+	u8				intf = min_t(u8, w_index & 0xFF, MAX_CONFIG_INTERFACES - 1);
 	int				value = -EOPNOTSUPP;
 	struct usb_request		*req = cdev->req;
 	struct usb_function		*f = NULL;
-- 
2.43.0

