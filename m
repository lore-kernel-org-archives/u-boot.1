Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E256CD8C8C
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E26B83314;
	Sat,  6 Jun 2026 14:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile.com header.i=@hifiphile.com header.b="eKr4XEo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28FFA840ED; Sat,  6 Jun 2026 10:27:18 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9631E838D7
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 10:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490b43e2b95so22023965e9.0
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile.com; s=google; t=1780734435; x=1781339235; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o0zewTcnr19TRfYpjBNWAAtzECscqQbzkLXZMsph5kY=;
 b=eKr4XEo7hUAApAZGLfgrk9GZQxKUy/dZDQVYhtxpd1ifLlq1L+yFR4oSxOFh3QFKm3
 06w98b0uo2RECrHYBsQEQSZ627pbDPdpPB5yBywwhjnnKZ3q6aDe6E7S4Ou0wy1nqZE8
 KyHPFLT390WgK3WWrPWK6CgFIYNrnui9bfEOubfnNXH5zfbUsZxUj7vxVr8eyYkM46EB
 nZJUqHKM4EjFVNe+41ikZltHKClty+edhtOxSf4UBZpyEa3+Gp7jd6cbcjSvUaoVHhvp
 bf16OBjkA1UDcfdOf62BWlcWOvWrkgCZLmV4uvgIQMZF+nTuJgzrpRT9aI0g6BMs/AJo
 ablg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780734435; x=1781339235;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0zewTcnr19TRfYpjBNWAAtzECscqQbzkLXZMsph5kY=;
 b=ovK6Io3Y1RAu1t3ApSI3TgVwpEsTCoJ0tPpZNplua7Q0Jtc81fnwSeUlgv/1rG5hQT
 DfLE69v83bQUEGkKcmH1t9VtAHXyOlUat55JYeS09UQlgHztXAhUGh00OK64FD13lV2k
 UC8F0N43jNHdPXZX5JHoocZh8MiPBBZZ+2rSIqDh5htaYJHs3xs2PRC/9LMdRcZDz2Tq
 WgQP90nxS+kPUHDSA0ZcINe8Q9dahUtC/DTYA5vK4ClrzP2rpVwIHv5L4zySFKWTN7Mj
 8Dvci9Cwl0aXM0mHd/+UtHcPwqCqO4JfFabS0UTPEiSrt2GST3EpA6nt67nrXmfsXzoo
 4Jgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NYRAthYUWJb9F4yFYR8vAYassVVT3GJcr9oXyQ7cT52LktLx3YRa7gScblye+LOqIFXYojyw=@lists.denx.de
X-Gm-Message-State: AOJu0YywHG10+lymTbHaKeeVwDQklcQa1YVcKVbNFbAGK5HC+145a8cv
 Jwde7MRb3r7etyodpgvj2DDaCilZyem2BD2YRiL84tQzhR3FfyT7et04PQMQEhiLjPw=
X-Gm-Gg: Acq92OGb1RN+m25/2kCyIUvJYWkKdhJi01JHVB+aDjga/aDaMswG+kskiPUIpcOPNXI
 kkpEYQYybdmUrRN0DS//9soXqFU1RsCYWi/Tbsl6G7WnDFJyUAdjjxqmz0qHCvCb/1ZmVvBAxdI
 5C5xNyuqFdiU0l95Ghh3eHoEcSb7vX9edQX5s8sIOms5rxRsQVbr2Jo4vcC2pVubnP78apFTzxt
 K/Q1p7jmI9Vz6E3V9HePtZsB87k7p2U9c/8wqVQIiuuFswllgObcZb5EA6gMZu/C7l/B+HtI3cd
 89JBkpjtbWZihzgZGsJV2rV3Q+xW1Az0vJGmyTSj9wOFNZLXRs3Pkd8w+S/qrsLvGU4iu469Elz
 ugu0LC8mEl+CtuC95UvVtf6U2sPXOzPqHoAKpNHHYur0ZxyqTvQHt0Ww2N0ZC66ANe6HAVnMC7b
 10nqitEJZyLrl6gWkK2OJgn2mOQce79wObje5hz/UDIwU=
X-Received: by 2002:a05:600c:83c3:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-490c25a5970mr129780065e9.11.1780734434793; 
 Sat, 06 Jun 2026 01:27:14 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-490bc39eb04sm218604825e9.6.2026.06.06.01.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 01:27:14 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Sat, 06 Jun 2026 10:27:09 +0200
Subject: [PATCH v2] usb: gadget: atmel: use calloc() to allocate endpoint list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-udc_malloc-v2-1-1155326b182b@hifiphile.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBAFf4Xs2Zq2BlI9+R+EmNJu7RqgpAWiI
 f13Aa8eJ5k3b4WEkTDBrVgh4kKJwrCBPBVgvB6eyMhuDJLLipdSsNmaR6+7LhiGrbqUpeVKO4R
 tMEZ09D5idfPjNLcvNNNe2A1PaQrxc7wtYvf+hhfBBGsrIZRT/KqtvntyNHrq8GxCD03O+QtLQ
 qXIugAAAA==
X-Change-ID: 20260521-udc_malloc-eb8355d08afe
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 06 Jun 2026 14:46:23 +0200
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

malloc() doesn't zero out memory, leaving ep->ep.enabled uninitiated,
which could make this flag falsely true.

In next usb_ep_enable() call since this flag is true, ep->ops->enable()
will be skipped. Then usb_ep_queue() will fail on uninitialized endpoint.

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
Signed-off-by: Zixun LI <admin@hifiphile.com>
---
On SAM9X60 I had a problem with unreliable usb_ether functionality,
sometimes 'dhcp' command returns with error 'rx submit --> -108'.
---
Changes in v2:
- Add more details to commit message.
- Link to v1: https://patch.msgid.link/20260521-udc_malloc-v1-1-b6118f809ada@hifiphile.com
---
 drivers/usb/gadget/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f7a92ded6da..a5a2252dee9 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1219,7 +1219,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 	struct usba_ep *eps;
 	int i;
 
-	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
+	eps = calloc(pdata->num_ep, sizeof(struct usba_ep));
 	if (!eps) {
 		log_err("failed to alloc eps\n");
 		return NULL;

---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260521-udc_malloc-eb8355d08afe

Best regards,
--  
Zixun LI <admin@hifiphile.com>

