Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BF9CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D37D803C6;
	Thu, 30 Apr 2026 23:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="BqRm/9hO";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSkWdv0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4FC83693; Thu, 30 Apr 2026 23:28:43 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF5380086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id EEE621D0007E;
 Thu, 30 Apr 2026 17:28:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 30 Apr 2026 17:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777584519; x=1777670919; bh=Yv
 WSI2/ndxKUkI08JOEW8G0U5uWqcJHyyf8IZOkLKUc=; b=BqRm/9hOaFjG8jXJB9
 My9EAtCsMz+BNI32qvTRDiHIP5fUQwp1nbUR5Xpd/+TaaJBxlQRebQIWEAL1TiCD
 LTjFMng5tu7iSXsJgo8zq63G3gmDV5R8rpWVwRDoiykc14BTZ+fD3Kp9KmHia8+U
 4UWms5f/UK9NuH3Uan4DWzjJgKP5bmvw1voaYbPiO77JBHCIwj55TwQZ5rJd/C7l
 YYJ8ncaUxv/dPcLVwi8xkS5MQbqcJUK5SGaVRgD1VXrEw6j+hwFJO+JKHL0ue+HX
 bJTAOEPkBjIb9atG0j34aU9mIG+nd0KsFlqMGdNfSY0Eqr5vHoWEOP27YQJ4J9fV
 rprg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777584519; x=1777670919; bh=YvWSI2/ndxKUkI08JOEW8G0U5uWq
 cJHyyf8IZOkLKUc=; b=SSkWdv0mlH0OqtFURitGMrV5DuQ0U5sSQhvuP/7h6bHS
 k7RHlsSc3wH1RcdWr0uJ/tdE55igKTQ2QcxMHFyUDaaOJS3BD6umQhGIYXY0BiOu
 68bwTCmmrpNk0fpBU4ncCDnkb8BPfj3qJdrCBtJ3V/3noMXZKeuC9uGqcq/TH9fL
 ujT6xsw7+FdOGkkXmAJvUpDMaJc1BWl64N/WGMBs/bmlY+i/UNyrni0WUunJuXWY
 ULt7jhzAaqTsWa02vaK+aLiCh6tIb3DKvTbSVjt0coB2JvuupZlzCSNuS2WqShDL
 JrUQgqu9ibs9zIo1uWUSIXajN/N5fpSkyZbZ948Ofw==
X-ME-Sender: <xms:h8nzaTb9FGURdkeaa4J6oq_N3SEdxFJuX62HU17iKQFv5VmOWHJb_w>
 <xme:h8nzaZQ6Y0KhRDeJZHvTYuifdCbYtFTZyaMSS52ULow3Chapmiq385FUylYrWpxr0
 dvKlaZyNnyzv04pPPz0a3Tlxw5rk_-JJNHCF6ViM6oZ3oYYJswvYfs>
X-ME-Received: <xmr:h8nzaeR7Y2Ye8GUFn6yUp5xRPAgJr0xn-Sm9j0XssOLaN38zmhFu9NXCAvOyrTI4NmtC6K3WDn0e0qYH1EsT3Oiffq3Z1RtUmfRdAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefheeltd
 ehfeetjeefvdehteeutddtteelgeduueetjeevteeifeeuvdefffdvieenucffohhmrghi
 nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghsug
 drohhrghdprhgtphhtthhopegsmhgvnhhgrdgtnhesghhmrghilhdrtghomhdprhgtphht
 thhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehuqdgsohhotheslhhishhtsh
 druggvnhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomh
X-ME-Proxy: <xmx:h8nzaVTCe22bYuXHZFljMN193Ih4OWJii6B9FZPmk-Dq4jRvtBR2sQ>
 <xmx:h8nzab7yzgDDmxV_9GHasF8_s-Mdhdfqf__PNLA6LwW1kasOWJA4QQ>
 <xmx:h8nzaZ1oWNVZq6nDkGfIuZwNaQT1loOPydNsDYZuCH99v3seaGgJWA>
 <xmx:h8nzaeDgljE0o8ivlIhy9o-9MzLwZC38-Rbvg-q3L0_5d6Y3Cg5xUw>
 <xmx:h8nzabT6ZnifYg3gff5IvhnoXsHPSXCt9EUfq0J__wW_tjc4sr5Aw2NT>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:28:39 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:28:36 +0200
Subject: [PATCH] nvme: apple: add "apple,t8103-nvme-ans2" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-apple-compat-nvme-v1-1-52c1e6e93aa6@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avIrBtQ+6OuEi3EphooFQ0JorsnL
 b/Few8kikwJRvFApMyJvStQlQC7G7cR8lIMWupONrVEE8JBaP0ZzIUun4S9snql3rSqGaB0IdL
 K9/+c5vf9AGlQhD9jAAAA
X-Change-ID: 20260430-apple-compat-nvme-71c2fe7a5149
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=0Y70vYnmI5PrApJSXdnAnl/pnAhex+4s190LJ7TjpI8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPJ9tSoxNdGJhOTJobF1B+8NHlu85GgR4VzOc+PWSq9
 BaWXxTVUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJKlxj+lx2ZtnhXxuuvNoZ7
 wlsDl7ydLB3tNvlI1ErT+0enaVU8NmJkaN217cjflT5Lbxjc1r9dmqd4+ULmV699tZ/TdJpnv09
 j4QQA
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

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
"apple,t8103-nvme-ans2" as fallback compatible as this is the SoC the
driver and bindings were originally written for.
The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
compatible as fallback instead of "apple,t8103-nvme-ans2".

Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/nvme/nvme_apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
index 7e7538553e3..48f82bc826c 100644
--- a/drivers/nvme/nvme_apple.c
+++ b/drivers/nvme/nvme_apple.c
@@ -287,6 +287,7 @@ static const struct nvme_ops apple_nvme_ops = {
 };
 
 static const struct udevice_id apple_nvme_ids[] = {
+	{ .compatible = "apple,t8103-nvme-ans2" },
 	{ .compatible = "apple,nvme-ans2" },
 	{ /* sentinel */ }
 };

---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260430-apple-compat-nvme-71c2fe7a5149

Best regards,
-- 
Janne Grunau <j@jannau.net>

