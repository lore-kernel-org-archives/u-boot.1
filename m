Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DF6C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 08:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C69875DF;
	Sun,  3 Dec 2023 09:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="LiRXHOX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF6187600; Sun,  3 Dec 2023 09:31:24 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1451F875B9
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 09:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231203083113epoutp04258c78e36b0e156490d11c86bcacbe06~dRSgrxL4_1977619776epoutp04U
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 08:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231203083113epoutp04258c78e36b0e156490d11c86bcacbe06~dRSgrxL4_1977619776epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1701592273;
 bh=qF/p9h3616naUn3SS7noBbvTD8HGLdT+ipnZQpk2S5Y=;
 h=From:To:Cc:Subject:Date:References:From;
 b=LiRXHOX6Dv/4Q1DiNWcWM9A8VYjY1IRQClTte0dSlgfYWQE64Bk3TlstRrdivGpZQ
 IwVthO/9b5thyeQy9Eop7deKRq14SOLfJp5F6L47M7iZfIPGNrxZJcLHgcT+iV2pJ0
 /u34wuY8b0xxiWgxsqfX+qlJL7qnItM7fWrRhlUc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231203083111epcas2p1efa4be68f42dc3ccddc70eacf9eac96b~dRSfpzgXU1996119961epcas2p1Z;
 Sun,  3 Dec 2023 08:31:11 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Sjg4H2n33z4x9Pp; Sun,  3 Dec
 2023 08:31:11 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 0C.BB.09607.FCC3C656; Sun,  3 Dec 2023 17:31:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231203083110epcas2p334ced52c055603ce66b4452fe4cd5586~dRSetxxvN0607706077epcas2p3d;
 Sun,  3 Dec 2023 08:31:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231203083110epsmtrp163ff3264f9188a323bf2b7397cab9044~dRSetLfJ02011020110epsmtrp1s;
 Sun,  3 Dec 2023 08:31:10 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-0b-656c3ccf7762
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A9.E8.08817.ECC3C656; Sun,  3 Dec 2023 17:31:10 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231203083110epsmtip18c1385cb0ae2e2a786826c638342889c~dRSejbPKv3090230902epsmtip1L;
 Sun,  3 Dec 2023 08:31:10 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2] watchdog: Correct watchdog timeout print message
Date: Sun,  3 Dec 2023 17:30:40 +0900
Message-Id: <20231203083040.3113114-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmhe55m5xUg6OXBSwu79e2+LZlG6PF
 yXUfmCze7u1kd2DxmN1wkcVj3qwTLB5n7+xg9OjbsooxgCUq2yYjNTEltUghNS85PyUzL91W
 yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
 I7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjzK0brAXbuCua511gbGCczdnF
 yMEhIWAicfxZRBcjF4eQwA5GicMfvjFCOJ8YJdYun84G4XxjlPj28RRQhhOs413zNSaIxF5G
 iU+/TzJDONOYJM6vucAOUsUmoCux5fkrsA4RgVCJfe9uMYPYzALaEp2fp7CD7BYWcJHo2JMO
 EmYRUJV4dmQ6E4jNK+Ag0fHnLBvEefISix9IQIQFJU7OfMICMUVeonnrbLC1EgLb2CVebV/F
 BnGci8StSYuZIGxhiVfHt7BD2FISL/vb2CFmlkvsWJYE0dvCKNHctocZosZe4sfNKawgNcwC
 mhLrd+lDlCtLHLkFtZZPouPwX6gpvBIdbUIQjeoSB7ZPZ4GwZSW653xmhbA9JG6cewF2gJBA
 rMSjP9NYJzDKz0LyzCwkz8xC2LuAkXkVo1hqQXFuemqxUYEJPEaT83M3MYKTnJbHDsbZbz/o
 HWJk4mA8xCjBwawkwjvvVnaqEG9KYmVValF+fFFpTmrxIUZTYOhOZJYSTc4Hptm8knhDE0sD
 EzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqYgnKfFAse/mHy57D88Xa9PNmH
 p3/PrL795P4Lg1U2U78yd6Srus19UVF57mr5zsXVG0uX3Fh0aZORcgFb3ptjujPWbf4atnrd
 9k/n1C3PHD8nvunmB0E7u41tdZ1lhvpGVSYKaoEKqXpTxY8+4Wv5n2P1Jn7FUePnSvdsZ9k9
 Pnhn1uplF+R4JKU/v/nk8n89z2ynu8fOykxZ2xx3/9R65uyXSVPXOV478yNY4elZpQbmCd/X
 cXMIakYL8LIrXlGVMrEVYVtpte5lCGMCQ5X3RtupdkEOGss2HIuOTmy55Lwun8VCv0dksiO7
 WHrqElaFsG+LNueeF553QnHBdjHXEKdZjcdrShpOMSQFh1x5qsRSnJFoqMVcVJwIAOFkTS37
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSnO45m5xUg44uU4vL+7Utvm3Zxmhx
 ct0HJou3ezvZHVg8ZjdcZPGYN+sEi8fZOzsYPfq2rGIMYInisklJzcksSy3St0vgyjhz6wZr
 wTbuiuZ5FxgbGGdzdjFyckgImEi8a77G1MXIxSEksJtR4t2j9YwQCVmJZ+92sEPYwhL3W46w
 QhRNYpKYd+wHK0iCTUBXYsvzV2ANIgLhEu1Pt7KB2MwC2hKdn6cANXNwCAu4SHTsSQcJswio
 Sjw7Mp0JxOYVcJDo+HOWDaREQkBeYvEDCYiwoMTJmU9YIKbISzRvnc08gZFvFpLULCSpBYxM
 qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgkNPS2sH455VH/QOMTJxMB5ilOBgVhLh
 nXcrO1WINyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGpolm
 UnucDj2ykL3mkVbuUNKYxx+o8ebR/JnfZVXNHP4v47AJ073B73Wo02d9yueyaQtvGcX8/PfP
 JmFJrUUld8nilJUbZxi6sG3O2nv3SfW0mFuHGN5MFlmwve7u2rWHpE9pMrlkcjBtnsp3mPV2
 w23L3E5ZccYY24LC3c1vRDaxrEzmev1ww7c79x+yzj4We0emSfLTnPkFkz5bnV35zrDvQ3my
 fO76ik9nmSZMqT/+Y/O+I9EzgvgmPJk+M0bErXzPiksrKmr+LVr938WyL9rv7OdtImazDGfp
 fp//3by6ekOxvZHLJSHzh5v3Mf74W6U4M6lS8Efz39sP+C75Bfc7LLZyPWw+4x7PhW8MtpVK
 LMUZiYZazEXFiQDDz0m6rAIAAA==
X-CMS-MailID: 20231203083110epcas2p334ced52c055603ce66b4452fe4cd5586
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231203083110epcas2p334ced52c055603ce66b4452fe4cd5586
References: <CGME20231203083110epcas2p334ced52c055603ce66b4452fe4cd5586@epcas2p3.samsung.com>
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

The wdt_start function takes timeout_ms as a parameter and starts the
watchdog with this value. However, when you output the message, it shows
the default timeout value for the watchdog device.
So this patch fixes that part to output the correct timeout value.

Before -->
StarFive # wdt start 3000
WDT:   Started watchdog@13070000 without servicing  (60s timeout)

After -->
StarFive # wdt start 3000
WDT:   Started watchdog@13070000 without servicing  (3s timeout)

Fixes: c2fd0ca1a822 ("watchdog: Integrate watchdog triggering into the cyclic framework")
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Change from v1:
- Use lldiv to fix a build error of m68k arch

 drivers/watchdog/wdt-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index ed329284decb..417e8d7eef95 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <cyclic.h>
+#include <div64.h>
 #include <dm.h>
 #include <errno.h>
 #include <hang.h>
@@ -141,7 +142,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
-		       str, priv->timeout);
+		       str, (u32)lldiv(timeout_ms, 1000));
 	}
 
 	return ret;
-- 
2.39.2

