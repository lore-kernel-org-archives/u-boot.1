Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC1ACCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF3E83A91;
	Thu, 30 Apr 2026 23:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="NA5vSXOW";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="v3/ciPV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E73D84255; Thu, 30 Apr 2026 23:34:49 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBCEC83936
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 99FB97A00AC;
 Thu, 30 Apr 2026 17:34:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 30 Apr 2026 17:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777584885; x=1777671285; bh=o+
 E1SzBEoF9OI1BA/huDMmfvNOgB8zFAp5hkSbvGpTU=; b=NA5vSXOWPs6OmdIXUn
 +xYziDaufUwPMdLHSQhNnuyBWxuTi67Zu+gvswgzy13dYvuZOKRSrMte1DLWtID8
 Xv+Ek70NzH0MQJ8IlhkXXBx1zGx9wI7hVWVLFlN7GCKwXDeXQAjQSn3jM+gaW5h5
 N7tDZfZzvQyBQAJtjzneueSYOLcoU/qgHoU5o4L9KL/PXGdInk9Re6mvoaduEiJ8
 OvjKZQNMf+2o07dcVmwx3eQINItwqNmKqRNiQPeTq0NqkEyfKlsr0MdPDrCroXMC
 SxL9VNnEHBTuW0ir0+WA8mTPt6ijt8iYIWVnDgd0fAebsY9xQD+/U6tfTQ3ngNiz
 eziA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777584885; x=1777671285; bh=o+E1SzBEoF9OI1BA/huDMmfvNOgB
 8zFAp5hkSbvGpTU=; b=v3/ciPV0GXE96DmuBFyt4ReRqlCo6ubl4jb/sVcPxVMd
 TB9Ktp9FroZp2dm4hBRMe+wz1a5UPCDIJOwqpZ5396TwoTdygQjlUeUywoiZYiDA
 56GucXlxuqMqsYMI6Uz5ARSgS0XaCzmosBIGAxEbSy1izPVfrPio78BcD75wLAwL
 BPfuhKVBxTulvwiZ4TApVgZlkYOX0YnUO7ShIo9vLkYYwPduFUJtXb5VHd4/5h89
 UncGsCK4XOl3/Pv2VGcMCG74o7XU8YX4CylCckHaxGS4cO4rI/5xfwAnKz7ERzCi
 QsOPQMUxEH7Y7H25J+lOvIP+USCq2VdM+6Mbhbm5pA==
X-ME-Sender: <xms:9crzaQI-TUzQeQbGG5l7lnY3tcvVRxGoQO9_tlCzDdM9eA4tIrjQxw>
 <xme:9crzaXAZnuMKTKpUlMcjYeV7c4vTa0Mofa08iOiwDPqZ6GIMJdT1XdMlNh6r9kuWM
 whTlfLv_sdWThpBJy6tLqIEp25zUD5eWWkJH3RYb3gxUz08Rmt-Ag>
X-ME-Received: <xmr:9crzaZAHfisqxNApT7L8L70B1EOlAbCx9oftgCMvUCl4F6pp-j5u4Fs3sMZfdrZ5jCQ63M8kcijH01RDDWlFn-zXPOXXOCgRqDwSfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefheeltd
 ehfeetjeefvdehteeutddtteelgeduueetjeevteeifeeuvdefffdvieenucffohhmrghi
 nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtg
 homhdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhopehsthgvfhgr
 nhdrrhhovghsvgesmhgrihhlsghogidrohhrghdprhgtphhtthhopehuqdgsohhotheslh
 hishhtshdruggvnhigrdguvgdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghs
 ugdrohhrgh
X-ME-Proxy: <xmx:9crzaZDC1R06emuVo9LIuVTQJzUTVC5Bh8noNUGwjyWiAJgdvzlVdA>
 <xmx:9crzaUr0pjKGvbc9-30QUNDuKTrA4FAjTYN7PE161p2dD6J_pFu0TQ>
 <xmx:9crzaTnZxPQXzuokd8mepQbuVTu5y4-oMZget77qFm1zuqvkE8DXcQ>
 <xmx:9crzaUz7vhco7iZfWF0hmMp0Y24xKgCSMhA5rkjZ0I1uuZF28sDMEw>
 <xmx:9crzaXk5XMb0916iXviVPoDbayAA6YxYyytWnoFNJ0JvO6JLygMP2gB2>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:34:44 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:34:43 +0200
Subject: [PATCH] watchdog: apple: Add "apple,t8103-wdt" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-apple-compat-watchdog-v1-1-dbb6da4cec6a@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1gaqVSleRVzENmpAbWllRhDvb
 nH5Fv/fkDgKJ+iLGyL/JIk/MqqyALvSsTCKy4Za1Z1qtEIKYWO0fg904p9Ouzq/oHZsqFKtnoy
 B3IbIs1zfdxif5wWLsuUjZwAAAA==
X-Change-ID: 20260430-apple-compat-watchdog-3de8a1053b88
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=fn0puoACRTtcgCNaMxDu7Mppyh+8YBcDjcKDyqhwcLY=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPpz7/zf5641d+h8vGvDMWJ7nttv35WLsqec7NFU+Zf
 ROk+gr2dZSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZhIuwbDf/d8bcGKU2GXY+at
 fLB+WerV5T2HH6oYKcgesXh9zY476SYjwze72QdP8HX/ndGVcSN4xeWvvwLyI7ZpVHMdv1zA6bn
 xPhcA
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
lists with the generic compatible "apple,wdt" anymore [1]. Use
"apple,t8103-wdt" as base compatible as it is the SoC driver and
bindings were originally written for.
The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
compatible as fallback instead of "apple,wdt".

Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/watchdog/apple_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
index c7307f41cb7..9e998994216 100644
--- a/drivers/watchdog/apple_wdt.c
+++ b/drivers/watchdog/apple_wdt.c
@@ -78,6 +78,7 @@ static const struct wdt_ops apple_wdt_ops = {
 };
 
 static const struct udevice_id apple_wdt_ids[] = {
+	{ .compatible = "apple,t8103-wdt" },
 	{ .compatible = "apple,wdt" },
 	{ /* sentinel */ }
 };

---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260430-apple-compat-watchdog-3de8a1053b88

Best regards,
-- 
Janne Grunau <j@jannau.net>

