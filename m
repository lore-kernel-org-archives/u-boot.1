Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B68AC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 03:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF5E86F40;
	Sun, 19 Nov 2023 04:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277F486F45; Sun, 19 Nov 2023 02:05:52 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DC38615A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 02:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=simon@holesch.de
Received: from localhost ([80.209.221.177]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEF87-1rEAl52kQn-00ACLF; Sun, 19 Nov 2023 02:05:46 +0100
From: Simon Holesch <simon@holesch.de>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Simon Holesch <simon@holesch.de>,
	u-boot@lists.denx.de
Subject: [PATCH 1/2] usb: ci: Fix gadget reinit
Date: Sun, 19 Nov 2023 02:04:51 +0100
Message-ID: <20231119010453.294168-1-simon@holesch.de>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OmLxpIAZtx3fmDYLY5CkRsiLiGZtmFDfc7PaQC1CV5Un4pqcyu5
 t/5Lr+MgMBwv0YFmpG4jv9b79fQSu/h1GJLKqWAKd9tdWBW8YMr7xRnP3i552HruSq/ClIh
 iEt6/D7MuYquMJXe/0AxO1AxCVWZG7ICp85hXSnBjqwdOyHFRgvfLbeN6Vg5rmOojHrtJl8
 1DGitWk4ZfWFEBGqBtEGA==
UI-OutboundReport: notjunk:1;M01:P0:TkJ0RyFmaQw=;Yg2dm+/tjaraJ+k7kbkg1u7kkK8
 lYYp78LwaLz6wv4YRgCC5JymhVzfc/ml4sB4K3x/nNVQg58fcf4e5bVDTmk+RLlDWgjNfUdCp
 jkRk/GUSfpRNkJoHX26oiO8gTJo9qwlRupJNHOuwT+LI7czE02gziZCuhCBbxqiIPXtUk0bbE
 3oYuszEELo9oCozuB3+oKs/rvdyID7Y1a78cj56FySVIMVJ7SSqTw82YQJkNo4HxvC1vg09lg
 jFMPzycI7b2wlbEmqjQSIMBbU171qi2hQWE/h89PUtQvAm8HwpG83lwdJ0dyWlcVnQqems8vw
 7VM/8jCTuPUvMUy2XxMM//yqPuaXD1T56+H9cOGSXs3aTgokn645AlF2SH25Yzn3+9Zfl5uhl
 6MBGa0/4tpsfRyHmqH2gA01r6kNK0W8D7QH2i/9Nb6NBDU4ewLNUCNQhpH8YPKqlgqsvg6gqq
 AaF/A7knXt+3VGMRYqJ4FuBT7USEk0BBMEhiT4/dOHN+hJAD27WrPSQZ6w6R0UVQctxYag/aj
 RLmg37iG/0bFkIosN2sxeVTgymB7L+/FfEzDiEfkUYYGB5NJ+76BLyBd9IWnZHUOOi27o/Hte
 7od8pb5ECn1JIaZtTRLNJkJRl/3OwnfXiKLbcj9Br/i5Nb3q7GUxxSi5fxE+t3B80cer69a5o
 uVAPkCP/O8N5TzMlsPO8cUHlblod+pif990pId1SGvcWBNjCSBYIqICqPFsvLYrFEig1E7E7S
 suByKP2w31W/sUDePCuvVi5ALCxXM27qvJJZ4xZIWbRBzM8wDvjVgQ+KLdGz2NcEGGQ4CCueh
 eYhqFrTo0umcvr1l92jdvkPQY3wqikKGLof7uAuOcaJ9CvJpkk8b6NI0Lzb54+Id18qf83I9m
 9xUtlm1HCVPN5pw==
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
---
 drivers/usb/gadget/ci_udc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 2bfacfe59f..4ad991c72b 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -354,12 +354,45 @@ static int ci_ep_enable(struct usb_ep *ep,
 	return 0;
 }
 
+static void ep_disable(int num, int in)
+{
+	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
+	unsigned int ep_bit, n, enable_bit;
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
+		while (readl(&udc->epflush) & ep_bit)
+			;
+	} while (readl(&udc->epstat) & ep_bit);
+
+	/* clear enable bit */
+	n = readl(&udc->epctrl[num]);
+	n &= ~enable_bit;
+	writel(n, &udc->epctrl[num]);
+}
+
 static int ci_ep_disable(struct usb_ep *ep)
 {
 	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
+	int num, in;
+
+	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
+
+	ep_disable(num, in);
 
 	ci_ep->desc = NULL;
 	ep->desc = NULL;
+	ci_ep->req_primed = false;
 	return 0;
 }
 
-- 
2.42.1

