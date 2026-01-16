Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137A5D489A3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 13:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D90683623;
	Fri, 16 Jan 2026 14:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="O/5Z3fKy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="uc0IR85Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6858367F; Fri, 16 Jan 2026 14:35:27 +0100 (CET)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA2082BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D22B07A0148;
 Fri, 16 Jan 2026 08:35:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 08:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1768570522; x=1768656922; bh=qd
 2NSspqGHueGVy2NakxU92uR20g/epJLHkcNutb6fc=; b=O/5Z3fKymAt03DCJtF
 XC4DwM9D2CJQYBvqeQMBAc8qNa4ewjQYWo2HnCLkIre5YcNHBXIGLZxGWTEFMwMq
 PpoacZjv8qr0NnK1IVf0cWoejFRkmhtp3YBaWtIiOOLGDYJAJwBiRWEyi8g1H0R2
 ++Cooh5oruYtNN/2v3dXXUWvjiR/2xlhVzjufVa13HtKdqFXvbE6+uMsoCKomFVA
 eZ1LKyNonaswTCF8q6s3fJF+QJixbSbf9GB+1M/HYeB1XYEzE8G5nqKh7TzM5ZXl
 nHPAfaTKzcICCfgitKMa+MI7ranhS/m9Acvfr0POPAVJHCMgPyRx1FiLsD9hWzUD
 31GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1768570522; x=1768656922; bh=qd2NSspqGHueGVy2NakxU92uR20g
 /epJLHkcNutb6fc=; b=uc0IR85YbsLkTcsQEvaVUvpd7p1lWQruFXUDrgISGwZJ
 KhkSJYIg3/UTMvXsr6+iHGN27znxPaF+leqr/eAoWp4JefdFn5Fc7Bn+4qO4qV3Z
 CsCF+JUY+Lyv8jFcQGKR9rcDH77qEt08QhomTE4J0n6/bI7hjEhhFcSskrOC+Xc2
 WnO9zjKqGTO8+4SIcZaiL4DpIa4dX8N+hnxIHmX50BXBmM3yzXWv8OeWWSQm5QPq
 Zl+H280W+jh1c8VGXpAFq+T+WPW8gR4Cpuus3IuKtkAtuWwfp2KW92bO3LXxEAuw
 G1uqCksMx1q6AqxQ0vKsjMC99IGE07BoSsoekMRMtQ==
X-ME-Sender: <xms:mT5qaaT3xqZlu6HwRJv1C2JK_DPVsH1-SMA8rd0PYA17lEW8qturaA>
 <xme:mT5qaS3K2XiLSKcZoTHuiUV-o1HPvWUJ1YCvjVtFCG8QT4OU22CmEwJ5e62vWpTWY
 TglpHXbWQ_Uiobj-Mtg3qS-6FI3rjuxyupl-u_1gdzSvjPc6YyBrHc>
X-ME-Received: <xmr:mT5qaSdb-ePCI3ozSV1oitoB734xxb2umpxe8UBUnMB4a03IolrH-T-6wxVc2snmA8IRtuEvrDq-zL4oVR8j2mlRv35E6qIlZezySw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeltdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
 rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfeehle
 dtheefteejfedvheetuedttdetleegudeuteejveetieefuedvfeffvdeinecuffhomhgr
 ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepuddt
 pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvh
 dprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehmrghrvgigsegu
 vghngidruggvpdhrtghpthhtohepmhgrrhhkrdhkvghtthgvnhhishesgihsgegrlhhlrd
 hnlhdprhgtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhr
 tghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepth
 hrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepkhgvthhtvghnihhsseho
 phgvnhgsshgurdhorhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugi
 druggvvh
X-ME-Proxy: <xmx:mj5qaSNRB8wvEbrR02lBTKGyluxKo5cQEpDDIQdoehN4is7JVnT2BA>
 <xmx:mj5qaeVmBywwu4T8eIxTXw-D1NL9F-CCaPKEMvydxjrG3mU46aX0rA>
 <xmx:mj5qaSyeJpnsITgwhE6-SkM-Xlgg_pw0V1QKgvRJc8tjcPccAv_kqg>
 <xmx:mj5qad-il2kUHu7SBPCwLJLhIxq1WNfnKp3HWG29WdaMcSL_zDjztg>
 <xmx:mj5qaeolfg8NWAMIZd2AA-aKaEf-WWb6XYny0ObncXkIZ7brhzt9rNJh>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 08:35:21 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Fri, 16 Jan 2026 14:35:06 +0100
Subject: [PATCH v2] usb: xhci-dwc3: Add "apple,t8103-dwc3" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-usb-dwc3-apple-compat-linux-v2-1-36ac33108d43@jannau.net>
X-B4-Tracking: v=1; b=H4sIAIk+amkC/43NQQ6CMBCF4auQWTuGVovIynsYFm0ZZAyWpgXEE
 O5u5QQuv7f43wqRAlOEKlsh0MyRB5cgDxnYTrsHITfJIHNZ5CK/4hQNNm97Qu19T2iHl9cj9uy
 mBUspiC7KkD2XkAo+UMvLXr/XyR3HcQif/WwWv/W/7ixQoClIKmUUKd3ento5PR0djVBv2/YFT
 Ea7VscAAAA=
X-Change-ID: 20260109-usb-dwc3-apple-compat-linux-821ee75bec48
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>, 
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=bap0HXtcufe/1Iu3vBFTopD3YZm/eVDQ9pb4KCiUABw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhswsu2k/DWaFlP9k3S5q9lvcscnGYx3X/HXqLT5Xv39I4
 vf+fqGwo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwEReWDD8lbi/N+rAvifi+c/c
 yme/qt45X7OhZ6vi3i2n1u++qFt0OYCRYTV/4Y0Mv94tcr3VwmH5U3MUi0Q7W7OPPjK5P6Pql60
 dIwA=
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
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- sorted the entries in xhci_dwc3_ids alphabetically
- imported Reviewed-by: trailers
- Link to v1: https://lore.kernel.org/r/20260109-usb-dwc3-apple-compat-linux-v1-1-b6e255b5e5af@jannau.net
---
 drivers/usb/host/xhci-dwc3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index e3e0ceff43e6abdb8643f265819eff28c2c802f4..8ad07a4b98c9574a5fa0cbfe83f5567e0f49f364 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -237,6 +237,7 @@ static int xhci_dwc3_remove(struct udevice *dev)
 }
 
 static const struct udevice_id xhci_dwc3_ids[] = {
+	{ .compatible = "apple,t8103-dwc3" },
 	{ .compatible = "snps,dwc3" },
 	{ }
 };

---
base-commit: 127a42c7257a6ffbbd1575ed1cbaa8f5408a44b3
change-id: 20260109-usb-dwc3-apple-compat-linux-821ee75bec48

Best regards,
-- 
Janne Grunau <j@jannau.net>

