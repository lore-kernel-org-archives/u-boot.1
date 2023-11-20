Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA5FC54FB9
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 00:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C588754B;
	Mon, 20 Nov 2023 01:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2281C87540; Mon, 20 Nov 2023 01:21:34 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337D787556
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 01:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=simon@holesch.de
Received: from localhost ([80.209.221.177]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MulyX-1rM7no3rfP-00rnH0; Mon, 20 Nov 2023 01:21:04 +0100
From: Simon Holesch <simon@holesch.de>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: Simon Holesch <simon@holesch.de>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/2] usb: fastboot: Add missing newline in pr_err
Date: Mon, 20 Nov 2023 01:08:35 +0100
Message-ID: <20231120002024.32865-2-simon@holesch.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120002024.32865-1-simon@holesch.de>
References: <20231120002024.32865-1-simon@holesch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UqTJOTtZI60E5YfiXnuI/smFNwKKk1nL0iILpEKd+R04IAp4UTC
 debNQM8HcatqbwCcnLS5SahkwcZc/r0TgsSg2+fKgxLcJwRW+lpgOKambGOWN+NGA+7bOpv
 EiVxOl/Rbtp1UbnxshbhlCJjj+JF4+NPxh4pCF8hC6ZCBltg94Vzg2gHRoYUroOp8iAktzM
 0PelyZLF+htUjRDBlOodg==
UI-OutboundReport: notjunk:1;M01:P0:FhKwL8XK/Tc=;gIP5X5VL3psXh/0fkcB+cegJOZs
 O6vusocq1CnfiROa8eQ3uOAiCR8ABL9cx49Xbk/7QBy5//EfpEruzL/H4kTdrFqGWVuIwofV5
 qyc5rAt4ambpicjG5ZO5UPGglxH+F1EF70yU37DT81CRJtlLL7cOzQcOtsTNSvD8eoKa26R1N
 jKd8mMbwaUZi0g9etDqrPzm39bmFRNERM0RDaS3qcPcMQ2VwH17r9omN1FnTg3SIjnPLeWGnb
 JGFvhQpzvRUn1U7anguOU+PGZLiji7Y4sqLAAwmxRCaAf6uOrhtPj+IO1iH+JCDbLZ2EvNw26
 QvCLxKtfWffPeuvIPQEyQA5c6yNcLZTjneOTTYkc/SsmpAKYVBctxdo/CuGDwrSAas21k1aiF
 VZSJTjjU2fPmQupTg9dDpR4yQDqr4G2RkeKKdLtpqFA1gxlSTmeRX8H1znXIWsl71cjeobp37
 xcp/ODii1ET1beuhIJoNTjdPws1y1yhrFHbPaCLVfEgD54xdq8FytyJ/0a+o4lQY8tPfn6gaD
 Oz8WuwJA4qWRQVMs4Bl/AuN6hkpUWkBZwx63vbUsouddu1pH3+j41ADFT/Rstp76YY/xZDXL8
 SkryZSA0mvj8n4/3QSXKyVZuesGLPuyEUyzi4ZnAvKQ/Ft11QQN9VjghOY/+03BwPweERW+xc
 iJZscDZVhVdAPiS+dI0uzBB+107KQ20g1RfnMd3i/iQ5hnjiTWkcl6De+UnOMJ0dz66nJ+uHH
 SsAGU08YYY3NAqa75JusKknRUAuYoo/4fPmn+TBm80jpCKXgDrwmDejcBzdSGstcOQk9fgvzo
 8gIIQcshq72UhI7WEsW8t6ZayUo7jWwa7JYx8LkaEaArIzntGLY8YMiuFaoqFOFTv7wvsJHyk
 xu66n7Sjkp//GuQ==
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

Add missing newline in pr_err.

Signed-off-by: Simon Holesch <simon@holesch.de>
Reviewed-by: Marek Vasut <marex@denx.de>
---

Changes in v2:
- add commit message body

Thanks for the review!

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

