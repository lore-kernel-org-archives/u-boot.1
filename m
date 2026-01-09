Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778A5D26D99
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E27A0843AD;
	Fri,  9 Jan 2026 20:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="mCihlSse";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lpAl6qdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B447B843C7; Fri,  9 Jan 2026 20:41:44 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D672784390
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B89A914000B6;
 Fri,  9 Jan 2026 14:41:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 14:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1767987700; x=1768074100; bh=OR
 EaD/86edDfuAsGZ40EvIcSkl4P/sExClwGjj/E0L8=; b=mCihlSsesBkkCVpehB
 liOwm45LYA89mvJSSKFcX6QBx/cBkXhQOQERvPOB1zVJIETqhBJcn7OO8BNKOLM2
 kSw9JjHZ5GYpuyqw7PKSZDqGgmhw/kb81CHYECciynBEu7wfPtXs5vltfvIyAauu
 9eOggNIhXo98CkqsY7wm3LWveEbc159pNX8Q8zpB2L8wVW8xgC28EAXdtEOa+Ruf
 v2SVn+p6vSXUlHQB851IPphq6A7CVNb5Ryodu/1ceAB1g17A75ONeEH8yJY2+V0M
 zk98vkujuJUIARekqbzGl3UQlvEHt/5M8q9zymswc5ZgaCOU1L6GqblPyjzg3c7K
 PWFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1767987700; x=1768074100; bh=OREaD/86edDfuAsGZ40EvIcSkl4P
 /sExClwGjj/E0L8=; b=lpAl6qduDZmLpQkOZR7stdPsQvTnSy0dybU7vuxt2FAI
 cXnaSLArrWVTiNhm8JC3vOwg6CeZz7NvjYGsE04CQbQ4XKiWDQhz6aUDaHh48DqE
 nNpfj14+OO6ZOwUU+E43Rlx5MqfQepzJyoD28tPyZeZ+WQVwe2FMI5P9x+1w1d4K
 d9oSah+Xe+9zT25XSIoPN1TZD60xLMhVslDDpsL73aRfRCeC+0aw+Vr3OfNVYh+j
 vdIEtAQ6+g29sPWinKK+5UjIETwbNmUxU8z/4rVdIgxmC2Ca9gzWR5O77125Fdlr
 mp5MegbVPblkxuxx5UeYjtRS1N90syjVrTFH3KA9dg==
X-ME-Sender: <xms:9FlhaZunQs24UlwfBtFhK_FLc_eOyTazoT7iCB3epmDnb1rML17ZbA>
 <xme:9FlhaTINisMi5yZ_NOG_xKsdUncwV6_RjItwX6z5YHVLeKL6IpPf_ye27txJG3ndS
 Bd93lDlB6ciJ5PNPL0PSpMor6xZ_vwl3fnKQC5Qdow3b4AWu30sGyqP>
X-ME-Received: <xmr:9Flhaa9ebxeH-WnYLK4cgQWPHkLKMn20HdN6KWMYdHYxpfi2BnpHe9K-2zmrbM8_lRHjCl8vPh7tTBl17l_EuiNgan8N5hxoB6TSTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
 rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfeehle
 dtheefteejfedvheetuedttdetleegudeuteejveetieefuedvfeffvdeinecuffhomhgr
 ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepjedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvg
 hngidruggvpdhrtghpthhtohepmhgrrhhkrdhkvghtthgvnhhishesgihsgegrlhhlrdhn
 lhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhope
 gsmhgvnhhgrdgtnhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrvgigseguvghn
 gidruggvpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprh
 gtphhtthhopehjsehjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:9FlhaUzqHWf7KTSkj73ACpih6Zce8PdpRMuQ-OrjATnbyHd01Nj2cQ>
 <xmx:9Flhaf5lJyI22bbOawx8weJtc9xPe9JyyZ93nqhgQCNP6MIkbqDMVQ>
 <xmx:9FlhaT-c-chs7uXd5kbK4ER2a2lUXXorad53RqHNHAiRP_iXf0gmRA>
 <xmx:9FlhacreSBRqgdfh-abzVplgggximmA2i5f_bZ1N4riFip53sZEU3g>
 <xmx:9FlhaY03NolbP9edPxUGdJOh4jBPUglQ0v63EVyCxpMuFC9NvUKY6c_t>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 14:41:39 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 09 Jan 2026 20:41:36 +0100
Subject: [PATCH] usb: xhci-dwc3: Add "apple,t8103-dwc3" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-usb-dwc3-apple-compat-linux-v1-1-b6e255b5e5af@jannau.net>
X-B4-Tracking: v=1; b=H4sIAO9ZYWkC/x3MTQqDMBAG0KvIrDuQRFu1V5EuYvxaBzSGpP6Ae
 PeGLt/mnZQQBYmexUkRmyRZfIa+FeRG6z9gGbLJKPNQWrW8pp6H3ZVsQ5jAbpmD/fIkfj24MRq
 o7z1c1VAeQsRbjv/eva7rB9b0/odtAAAA
X-Change-ID: 20260109-usb-dwc3-apple-compat-linux-821ee75bec48
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=1xZR13ZWgaLmj5Z6bVbcFZEJdTlPhond4y8NuvDtGos=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszEyA//bwZtqi1ovKvEutI4bdUmk9/H/k0RWbrok94GP
 k8fPf7kjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABOZMpGR4VAzY0HPCY7uxfsm
 qGsm1W+wqpHb8WzF9hn5LBZP9newXWT4n/7uycsHC72kvefeOrXN4XA0y/2bX37blnqbZM3VVJ5
 xgx8A
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

The Linux support for dwc3 on Apple silicon SoCs switched to using a
apple specific glue driver [1] that uses it own compatible string. The
glue driver handles platform specific requirements on the interaction
between dwc3 and the USB2/USB3 PHY and reset-controller for USB role
switches and plug events.
To keep USB working as before when the nodes still carried "snps,dwc3"
as compatible add "apple,t8103-dwc3" to the of match table. Eventually
it is probably advisable to add a dwc3-apple glue driver and write code
for the currently empty Apple Type-C PHY driver in phy-apple-atc.c.

Link: https://lore.kernel.org/asahi/20251015-b4-aplpe-dwc3-v2-0-cbd65a2d511a@kernel.org/ [1]
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/usb/host/xhci-dwc3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index e3e0ceff43e6abdb8643f265819eff28c2c802f4..ba42c3247654b7d9272c42ea9c4cf0bd9082915e 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -238,6 +238,7 @@ static int xhci_dwc3_remove(struct udevice *dev)
 
 static const struct udevice_id xhci_dwc3_ids[] = {
 	{ .compatible = "snps,dwc3" },
+	{ .compatible = "apple,t8103-dwc3" },
 	{ }
 };
 

---
base-commit: 127a42c7257a6ffbbd1575ed1cbaa8f5408a44b3
change-id: 20260109-usb-dwc3-apple-compat-linux-821ee75bec48

Best regards,
-- 
Janne Grunau <j@jannau.net>

