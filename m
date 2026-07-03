Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AFEC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B2D84A95;
	Fri,  3 Jul 2026 15:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q1qL1yHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD2784A5D; Fri,  3 Jul 2026 15:29:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E75884A4D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 15:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D54DB43A12;
 Fri,  3 Jul 2026 13:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8101F000E9;
 Fri,  3 Jul 2026 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783085393;
 bh=DlnhvNFrJal62hREYROn7y3CyNXQN9QCi57BCEFQ5oM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Q1qL1yHvvlOX1eC0F5kzBN7ZFj4EZA3fIolx0I/ODhafh7ZdQeJaZiCLTf+1NOFTd
 LOxLbZVWKPn7JWxFzVBos7bUc/Leo9tCmNstR2csTMUaHXs1R5YZbWjpmj0jlOQGs2
 KfDHG07+NQoqBAUIzvcb6dMeF6wFLOy7trgjD7LRyHGliJeDSYyhS2k+CGae5APzZH
 PgMl0QoL1j0qF3+ESw3d780YfW/Mce+DRBP71PuCREn7j5WeeSIPz7hC7xhZ5KchA7
 LnVCdAK0POMN4hJA7SUDhaZuQpZe25bVLsxjb/djdiyGQ59Cu7S0SpaA0MVSi7Bun8
 YSWzn2e/LPmeg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Fri, 03 Jul 2026 15:29:36 +0200
Subject: [PATCH 1/2] usb: gadget: dwc2: Use usb_ep_set_maxpacket_limit()
 for fifo sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-usb-prep-dwc3-sync-v1-1-1352bc238c9b@kernel.org>
References: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
In-Reply-To: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=BQnoh4nDX+2f6Lw2q7HxiYpYCby0q21coPJ8m705Zc0=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBqR7lMaUJcgn7K0jvDoIgn/NM3gmHt6vYYdx5mJ
 nUYmTJoTlCJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCake5TAAKCRAZDR20Zk4Z
 NbGNB/95V4jfmFZFLA6zWZbTcdGzai03ckaeQTSI+MP4HqEhCY1Qw7/0p9N+4o5AiTy1C2IZzY7
 QyfeWt2fiJiLpBkUTOTSYF9SIgLq8JfTVk6rBSlfAsnAtgq7KBoNwT98YBTGCc/wGN4G5jE7L3W
 tO8wYRS4B+cJLQR2+fJdsr3GJQ5uCUB8MVJmsDRvQzSOMUJiENSWJ8Hbaif1SY6nRnXZq+suEDL
 6ILCu6ugWxvG182HhLTtD4GD7y+2PoMYQ9CblVX66Zl6NHr1JCQYtPRNtOXyAAo5xNrbDq/7j8A
 POZiI6vvyCYzdeyezr4X8bfYNsrNKYCstjruVoMODRbn8URC
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

More recent versions of usb_ep_autoconfig() use the maxpacket_limit
field from struct usb_ep.

This field has been introduced in the linux kernel via commit
e117e742d310 ("usb: gadget: add "maxpacket_limit" field to struct usb_ep")
And has been ported to U-Boot via commit
747a0a5b387f ("usb: dwc3: gadget: make dwc3 gadget build in uboot")

However, the dwc2 gadget driver was not converted to use
usb_ep_set_maxpacket_limit().
This is harmless for now, but the driver will break once
usb_ep_autoconfig() is updated to a more recent version.

Set maxpacket_limit via the recommended helper function to prepare for
a core gadget update.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index e475b14b9ac3..9c85383fd62a 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -828,7 +828,6 @@ static struct dwc2_udc memory = {
 		.ep = {
 			.name = ep0name,
 			.ops = &dwc2_ep_ops,
-			.maxpacket = EP0_FIFO_SIZE,
 		},
 		.dev = &memory,
 
@@ -843,7 +842,6 @@ static struct dwc2_udc memory = {
 		.ep = {
 			.name = "ep1in-bulk",
 			.ops = &dwc2_ep_ops,
-			.maxpacket = EP_FIFO_SIZE,
 		},
 		.dev = &memory,
 
@@ -858,7 +856,6 @@ static struct dwc2_udc memory = {
 		.ep = {
 			.name = "ep2out-bulk",
 			.ops = &dwc2_ep_ops,
-			.maxpacket = EP_FIFO_SIZE,
 		},
 		.dev = &memory,
 
@@ -873,7 +870,6 @@ static struct dwc2_udc memory = {
 		.ep = {
 			.name = "ep3in-int",
 			.ops = &dwc2_ep_ops,
-			.maxpacket = EP_FIFO_SIZE,
 		},
 		.dev = &memory,
 
@@ -893,6 +889,7 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
 {
 	struct dwc2_udc *dev = &memory;
 	int retval = 0;
+	int i;
 
 	debug("%s: %p\n", __func__, pdata);
 
@@ -909,6 +906,10 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
 
 	the_controller = dev;
 
+	usb_ep_set_maxpacket_limit(&dev->ep[0].ep, EP0_FIFO_SIZE);
+	for (i = 1; i < DWC2_MAX_ENDPOINTS; i++)
+		usb_ep_set_maxpacket_limit(&dev->ep[i].ep, EP_FIFO_SIZE);
+
 	usb_ctrl = memalign(CONFIG_SYS_CACHELINE_SIZE,
 			    ROUND(sizeof(struct usb_ctrlrequest),
 				  CONFIG_SYS_CACHELINE_SIZE));

-- 
2.54.0

