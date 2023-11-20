Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E981C072A2
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 00:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17F387558;
	Mon, 20 Nov 2023 01:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2396087525; Mon, 20 Nov 2023 01:21:23 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B418756C
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 01:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=simon@holesch.de
Received: from localhost ([80.209.221.177]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mq2Sa-1rhlHg2sKI-00n93g; Mon, 20 Nov 2023 01:21:02 +0100
From: Simon Holesch <simon@holesch.de>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Simon Holesch <simon@holesch.de>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/2] usb: ci: Fix gadget reinit
Date: Mon, 20 Nov 2023 01:08:34 +0100
Message-ID: <20231120002024.32865-1-simon@holesch.de>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5yafAO9ryahOvF2mRe3BOdUBXNoo7/S0gAD6sAc2HlJkbacXnAe
 bs/ZkwC3RSI6Pijz7WezF9IMXxr82rlJEYrHCxuj4HizeZ+geFCInAynjDM88I4BmB9KMj2
 zR5W0XsRBp/7ZjcHLX6wqYdCaC9Dqb8nid/gqYSpWLZLRPiADW+XNx9SEkVJ89L6hUhTAi+
 q0kT4WrlfYBy+6jmQN9bg==
UI-OutboundReport: notjunk:1;M01:P0:8sDGuqunn4I=;ze/5gF5sokfTDlWxeQ9I3B/KDak
 SdSPkbDF/U73NmvhkwBqSO99rcgz4nKDp8oEvKC0/FYDeZvpplVesulqDrEQnt83Y4BIiWIPp
 j09pn0pYhQPLb0SEjngRf3WBaGhozr66y+e6WDH2UucLxUWAfr00E5z44OedkJ5P1LAmEUF7p
 nSnAvmigv/mDv3CAd9pVbN+XGsM7scroJaHdntOwG/NYpUI87UijHzLXEJlDZ8ge4y+vRqxQn
 1TJ4S7DzMbpenG4QxY5dKSKO26Z8NdsWfyRy40EdHq+GJLRPCfWQBmT8JHM3biVCi1RVxakmu
 RSNEZS/aMe6gfI+1bgTwIJfJ2w7PAKNLoRz23IpyetKv5LN30pZxLsiosP3bvL/lIgfRVkKI3
 DblOnNzyHCwrxvDSe+LRva/IaCm8GGCFPnE2XexRgkcvEVr8xBvJOCfFCogdozDRN7b2q28NB
 KtoSh9Cofln8WE+NMGQCLlgRL248xiwlPKRjslmU0eTT9CCiK/6Tnv/F9FTEZtrwsB+/lMXkm
 bbNZMUCp2VWMyODwHVO8HX0RFzflG/vinndanTYQt+YI73idRVQGcQmDU4kABCkJLcBaadnqR
 1MbUlwvN9xNniLH7tgdEbAvJ0Yom06z/1GpHoyoBnkz9qDfHQW9AxsWri7ctLiVODzoUO5N+A
 Uh+AmKrrV2ZzaHdBDETyuaZQrp0IZECfiMFAF+XNV5OUoS8BROn2UQ4J/71hHLmFjr62bgDQG
 q17KXkCbrVLYTtO3oznsyKafE9ajmnMwQCrz4UF1nSWy/dz0z7wSU0NaaZCAeSE9z63BIPHr1
 yiAKAIFNwiSJRteCgaqu8TUO80ppvlwUSYBxCBlWcXHiNVZbNaetypmwx2qJGsTZg13umB6ir
 OnsSVaU2nDPmVkw==
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

The ChipIdea device controller wasn't properly cleaned up when disabled.
So enabling it again left it in a broken state. The problem occurred for
example when the host unbinds the driver and binds it again.

During the first setup, when the out request is queued, the endpoint is
primed (`epprime`). If the endpoint is then disabled, it stayed primed
with the initial buffer. So after the endpoint is re-enabled, the device
controller and device driver were out of sync: the new out request was
in the driver queue head, yet not submitted, but the "complete" function
was still called, since the endpoint was primed with the old buffer.

With the fastboot function this error led to the (rather confusing)
error message "buffer overflow".

Fixed by clearing the primed buffers with the `epflush` (`ENDPTFLUSH`)
register.

Signed-off-by: Simon Holesch <simon@holesch.de>
Reviewed-by: Marek Vasut <marex@denx.de>
---

Changes in v2:
- use wait_for_bit_le32(), clrbits_le32

I didn't use setbits_le32(), because the epflush register ignores 0 bits.

Thanks for the review!

 drivers/usb/gadget/ci_udc.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 2bfacfe59f..750d471487 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -13,6 +13,7 @@
 #include <cpu_func.h>
 #include <net.h>
 #include <malloc.h>
+#include <wait_bit.h>
 #include <asm/byteorder.h>
 #include <asm/cache.h>
 #include <linux/delay.h>
@@ -354,12 +355,49 @@ static int ci_ep_enable(struct usb_ep *ep,
 	return 0;
 }
 
+static int ep_disable(int num, int in)
+{
+	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
+	unsigned int ep_bit, enable_bit;
+	int err;
+
+	if (in) {
+		ep_bit = EPT_TX(num);
+		enable_bit = CTRL_TXE;
+	} else {
+		ep_bit = EPT_RX(num);
+		enable_bit = CTRL_RXE;
+	}
+
+	/* clear primed buffers */
+	do {
+		writel(ep_bit, &udc->epflush);
+		err = wait_for_bit_le32(&udc->epflush, ep_bit, false, 1000, false);
+		if (err)
+			return err;
+	} while (readl(&udc->epstat) & ep_bit);
+
+	/* clear enable bit */
+	clrbits_le32(&udc->epctrl[num], enable_bit);
+
+	return 0;
+}
+
 static int ci_ep_disable(struct usb_ep *ep)
 {
 	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
+	int num, in, err;
+
+	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
+
+	err = ep_disable(num, in);
+	if (err)
+		return err;
 
 	ci_ep->desc = NULL;
 	ep->desc = NULL;
+	ci_ep->req_primed = false;
 	return 0;
 }
 
-- 
2.42.1

