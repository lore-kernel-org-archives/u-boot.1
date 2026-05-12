Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903D0CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 16:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E516683DBF;
	Tue, 12 May 2026 18:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile.com header.i=@hifiphile.com header.b="RfHrSVAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8383D8341A; Tue, 12 May 2026 15:11:20 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD87C80398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso64113235e9.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile.com; s=google; t=1778591478; x=1779196278; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VSvHUn6x6IU+aLHBxPbQLEaYZd8w3t0mah0fF4PIkJw=;
 b=RfHrSVAvwoNKuS09rpcUZJgXMxT5bTXZIaJiOJLK4sNH3wyN+3RMvqbAr+8Ac4ZRe4
 38gfqej3+s81jW9vTyeR9LmTmrwEClvG5Ms8TA8Dc7agIave/ITl+mkwnkBH9b7dX6Ze
 JkhwbL/aX4BGwxbdAJZHDrH9hcEZHW6tBo3jEJvtlWu0mmZ4HDx0Lipiad6Ohotgh6zJ
 vKfFK+17w+YFlozgjwHFHKRzuXTyHeNfSsP9TbLTkADB84KAdd4LmQf+2n+S5Br/mD9l
 YKV/WgzEDJ4qzW3U8JDLFcdCRA8LNYasVIIr8TBLbpVMqb37yS2DZa4VDJZvjSbD4lbX
 FkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778591478; x=1779196278;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSvHUn6x6IU+aLHBxPbQLEaYZd8w3t0mah0fF4PIkJw=;
 b=Ywdxg2NSNRe0+K64fvLdO9468ZBhknvEfikgEx3iUZ7+wT13lrUh23kgfIjc8MS8xC
 jz6/OQkDMuCZjnC8VzZTa7CJPr91rvNdzsy4DC2lHymCSQG7PXJI45fNuc7JEj20fQkJ
 tbt3bhtgM/I8Jo7hgDGWLtTRzpdxZ/+xcWL7WnErzSHon2PQH2qv8GHEi61RIeuhVM2v
 2vboxbooI35xhCXzh/o9i77e44AuSUo2nFB6a9eHgeMy0rbmChgWGMjqgn99zv1K4hOI
 AcEwDNqFOh27GGbz+HaeE6FMUfceXJm6uFHVtPnDG1Fk49Yq99B03/1Izy2GAvOJDYDs
 yEPQ==
X-Gm-Message-State: AOJu0YymE3OyKHjrEKz1+phamC2rS2eYFluEHDpSTjoy6dk20WtAQKut
 uZmak62yuNVP81rFZiJr46r0F1BNkq6FL2djLiWIqSkoYIlh0G9u7mpU25Mn6HNQbU4=
X-Gm-Gg: Acq92OEcXonXYhqkwN6pRlT0FTwvCjBphnSocdz+/8g66jC2J0I1mzoGqjQI6IDVQSS
 46QaV/1pYYgassPtmdbP7alZl3Qp+4HDOEKXBVOM1RCIXk3VJGGQuVh1FDLv1aW/iCLIFY8nV6Q
 RPdOEPU/8NkomjdNo7SEdPHp8eVSBBkUXdLqaIoMiJP8ji9mdP5rUWXramh6Sgjj92H3D2XMVOe
 QqM6X3eyAo4ByGYSqqhPQbzQ3MJZz/ScK6MgSRiD+UJ9xtl4JCqzyHdD5MuHw94n6rB7aBhQkcB
 FLOf4htsddBCprxs7jmOINwgRrqFoJwOFtG2W9X7CziqXWQuuUcKgOG1w4xmfgoo9Sn1G5X+0tL
 rdXXMJ1rEg69lUSKjb0GvtyX2FY/yRI3cLJ5q4Iw1waSDz1br+3KDY3Uu5mpAT+3GisVhobOQRW
 iaNrFqoMMrvkz7qOmg2VsBNQ==
X-Received: by 2002:a05:600c:3f0a:b0:48f:81ea:ebbb with SMTP id
 5b1f17b1804b1-48f81eaebc5mr8355155e9.6.1778591477856; 
 Tue, 12 May 2026 06:11:17 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48e9052cd24sm43035775e9.3.2026.05.12.06.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:11:17 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 12 May 2026 15:11:16 +0200
Subject: [PATCH] usb: gadget: atmel: do not disable endpoints in
 reset_all_endpoints()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-udc_ep-v1-1-8a783e44cf7f@hifiphile.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avIrBPSyKCrRITaWNPCRCuC6O5ZL
 T/437sgYSRM0LILIh6UaPUZomBgZ+0n5DRmgyylKmsh+T7aAQOvha5co5VBZyDHIaKj8zvq+t9
 pNwva7V3DfT/r45JpagAAAA==
X-Change-ID: 20260512-udc_ep-51a3f7a6befb
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Zixun LI <zli@ogga.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 12 May 2026 18:11:03 +0200
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

Endpoints should not be disabled on bus reset event inside UDC driver,
otherwise a racing condition will happen between gadget driver. Gadget
driver will free the requests and disable endpoints in disconnect ops
later.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f7a92ded6da..b0de22961de 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -571,20 +571,6 @@ static void reset_all_endpoints(struct usba_udc *udc)
 		list_del_init(&req->queue);
 		request_complete(ep, req, -ECONNRESET);
 	}
-
-	/* NOTE:  normally, the next call to the gadget driver is in
-	 * charge of disabling endpoints... usually disconnect().
-	 * The exception would be entering a high speed test mode.
-	 *
-	 * FIXME remove this code ... and retest thoroughly.
-	 */
-	list_for_each_entry(ep, &udc->gadget.ep_list, ep.ep_list) {
-		if (ep->desc) {
-			spin_unlock(&udc->lock);
-			usba_ep_disable(&ep->ep);
-			spin_lock(&udc->lock);
-		}
-	}
 }
 
 static struct usba_ep *get_ep_by_addr(struct usba_udc *udc, u16 wIndex)

---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260512-udc_ep-51a3f7a6befb

Best regards,
--  
Zixun LI <admin@hifiphile.com>

