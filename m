Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E44C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 03:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7719787135;
	Sun, 19 Nov 2023 04:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 830FB86EDA; Sun, 19 Nov 2023 02:05:55 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40958615A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 02:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=simon@holesch.de
Received: from localhost ([80.209.221.177]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MvazO-1rNpYf2ewg-00seBk; Sun, 19 Nov 2023 02:05:51 +0100
From: Simon Holesch <simon@holesch.de>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: Simon Holesch <simon@holesch.de>,
	u-boot@lists.denx.de
Subject: [PATCH 2/2] usb: fastboot: Add missing newline in pr_err
Date: Sun, 19 Nov 2023 02:04:52 +0100
Message-ID: <20231119010453.294168-2-simon@holesch.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231119010453.294168-1-simon@holesch.de>
References: <20231119010453.294168-1-simon@holesch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jQpX8OllIcIdfzxumFivXxUQXlCBIYW7+aHg/dGG2vqCWWjK5TV
 1tQ6llmphVBRy5pMRBk0JMR73b1rqa6gyTf/CkNNZO3MC92SEcbbfdH6j1XwLbchVc/0G0S
 k+BT6SDEN5gr19ggI1s8b5vwCnNN2Ucni3xk4ZXp8pFJjEUw2C1cD6LSO+O3vdCmeEGOWV7
 waPvK7TbZGZIHafVQEcQw==
UI-OutboundReport: notjunk:1;M01:P0:t35fld2IJqc=;ASS46yxUNIsXdsC22GLOZCCfAW/
 5zFd6uMm6AGsa7PDgNugSdy405OQSDCW5d57fpoagBF2/p9vqYZ4HXSd1zljl3hz3dWFS+/0u
 vr8PnqSWmux6bFYd98zk+f023UZ0VkavPM4vq9YvZ36eCuTYWa8aNNXeKv/lhvDrXzjhMLEI3
 fAaCJS47eF5Barn/2zu2l8H4hG246dZqRRvI+M+shJwmzUE5hSUKdpsG52VEqQ4t2S/yZaKyG
 Ptd8sf3z2wM3QYRTMmjz6EuQEiEBfrb7Z12Lv92bsmyx01yPPQLob7/2BybbgGTFBSnAS7LgZ
 otK/Id9pyCicH2MGbGn3pSC89au6+OsNo5gGE+MHxsEBVVwLZk+Njq/vUqXJGt7PwRSlxPJ44
 cr9mqtZxt4QmTBGwt01kE4xfz2mYvG+D6aoyLtHCvgkh2tYEz726HdrnzPYCDrq77liDDsDkc
 cu983rFWdGsmVfIrvRYAbFPJGlCEB9dr7kUIcfQrrhNxcNgAPkkMAA68vEynWwiWCAdXH2e4y
 w+AF+JRIBc9ZV41YGPN5vbNsGZd9JxirgqRfb7ucGCoa5NHIwGs7RsNAnNe2WrnvszVZBjKID
 eN4NwgiAhw+bRfgppG8DP7ktPScCy5Ij3j1K+hKRdH4O8gBCTG/xXpiFvyiIqPQm7pjSv9hhO
 n7jmWGfKmB5XSvCRzYzQicP+EerEGKJRLEZ5PX8wMiRWTtf/2SgXj+ItLCLLqO+eFdu4hfM3X
 otGPHZD/YbDlJ9vqpLnuKyaD0NTFWu0i/97JcnHku34xkwUM8PVfjmUy3P9i4Syfdq0gixCdI
 jsD2qHshk7LShYu+nI3zxQe3T0ytoafaWgAk32icaVyX2LpB+64e1H3TSqHpIiFZ/7v8CMMBd
 DglJNcp+hH2tdCA==
X-Mailman-Approved-At: Sun, 19 Nov 2023 04:54:02 +0100
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

Signed-off-by: Simon Holesch <simon@holesch.de>
---
 drivers/usb/gadget/f_fastboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 741775a7bc..9f322c9550 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -520,7 +520,7 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
 		cmdbuf[req->actual] = '\0';
 		cmd = fastboot_handle_command(cmdbuf, response);
 	} else {
-		pr_err("buffer overflow");
+		pr_err("buffer overflow\n");
 		fastboot_fail("buffer overflow", response);
 	}
 
-- 
2.42.1

