Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BADCD13D2
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 183D883FB5;
	Thu, 30 Apr 2026 23:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="jgJ4t9hT";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZgOJN2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D6984099; Thu, 30 Apr 2026 23:30:11 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AE880086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 1129E1D00094;
 Thu, 30 Apr 2026 17:30:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 30 Apr 2026 17:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777584607; x=1777671007; bh=Pv
 88ei5e8TO617Zpb1XGDzeNqMnZRdn+rzAU25XDGkw=; b=jgJ4t9hTQA9957w4Qu
 E1IGx6UPC79ZHvynhtkGF76X4jJRG4D+Fl57+R4IW3zVTzOJZ9nRs6AnUhbUNLzF
 ZHAu7hBJqUmpYylPkrCtHDfqd+hHFX3X96fg7FRagW1DtkN68pZlR/7/j6Dhx/uH
 Gt8b4fd7pR2cIxHrYR3DXpi3OjwpkODWzFclfPusmJ/1E8SuesCkPIQ800Y2vPG9
 ucfQ8TjLjOnyUtXGMI+GqvAjbls2yb4QyOdzZdrPXRAowr33I/iZh9qUSpT3IU9K
 SSJTRw+7Ad4q4x3g7GgZEJ8Skue/UqVjmq4Rr0FV1BkocZrYFhYI/YTGd9Hhui9U
 WdgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777584607; x=1777671007; bh=Pv88ei5e8TO617Zpb1XGDzeNqMnZ
 Rdn+rzAU25XDGkw=; b=RZgOJN2l98FLzrL3aoPpvpId8e0RHbOp52c3LGn05g8N
 8gBMToNMlvKkE9pDWsv5cWI7MvIDGBk3dzvhUuoQmolp0TKH1RT+nsSAhHEP3Iux
 CyCGh63be86FSjZqz1ifhVImu9LJ6G8vqlsB8vrb04ClfAFiPWPWOKC4gQqdMTnb
 sPvEveO7Zn+mfIMQG9c6dJ9OER1Go/ZMIZgj29K2FyWocINj44C8iPe6HMiuLuV3
 +Rex0jUEgYpoO5Fekh4TEBmmNB3TpYGS04I+7JkaoaSScnDyKqW61sJnsFeGWp2C
 8+Sn3YEXebs3irmngKHFI09gaQ7vO316cQBAWe08rg==
X-ME-Sender: <xms:38nzaaRCHT4eg9SFQxEmwNzCGkIUwo837MzAsqfi2fjGIfTFihk43A>
 <xme:38nzaWx4s8Y-1moAJFnDlFybXLtooZXcTh-qh0KQ1p1a4EghZmcPMqLLlbeoJsd_F
 4GRx9dyFTZrWnpAU-kxSEdTKQEV2caJJoxp9wPGtB33w3Ruqqz0z2c>
X-ME-Received: <xmr:38nzac1bFfJdw_da9BOHUUI5eMkTbkWiu3wx3ENRdf9hKGGjpVNFUwzaiazqptt3k-MX9oNI3mhj3lmIEdq7pzEPn9itmJQ09LYCUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefheeltd
 ehfeetjeefvdehteeutddtteelgeduueetjeevteeifeeuvdefffdvieenucffohhmrghi
 nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtph
 htthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprhgtphhtthhopehtrhhi
 nhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtsh
 druggvnhigrdguvg
X-ME-Proxy: <xmx:38nzaU5SroM9uyRXcumk6UBg7HM_yBiHGEJ0pM_BLIRRrRc1hibCSw>
 <xmx:38nzafVUVOBvVyp5NAXhTrPwl8u8qW80j0uIgNiCArAjVx43ObIvlg>
 <xmx:38nzaTCYrl67WdcwO018a7M8XZRCUTZw1gJZptyE2frx8Qnk9zixsQ>
 <xmx:38nzae7_PKE5j5j8xC6QPNRHbmO8JKgfzj4yf9ShvFFEv2KfGjHgog>
 <xmx:38nzaaz-oUe-WXE9kgRNZKsTUKWkcGLBiFJeed_S5pZUApuTi6oZr3h4>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:30:05 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:29:55 +0200
Subject: [PATCH] pinctrl: apple: Add "apple,t8103-pinctrl" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-apple-compat-pinctrl-v1-1-f214a79616a2@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1gbSOhTxKuKi1HQmoDW0IkLx7
 pZZvsX/FQpn4QJTVyHzJUWO1GD6DsLPpy+jrM1gyTr6DIRedWMMx67+RJUUzryhc2Q9RcPRjNB
 SzRzl/m/n5XlecyPUFmYAAAA=
X-Change-ID: 20260430-apple-compat-pinctrl-6602a0f1ef18
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=fPi9kvj7xM+zW/Sh613IUs8PnkNbPwiY8R9G5XubCLk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPJ2+seLFytkv1itAi89D2x5pi26uj5svM2cC2Kj/hX
 4ur7uG6jlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABP5epqRoetI3kM+w50TPm06
 d2OejQDTwjPXtEU4purtuLVGtaZu2XaGf/oX+JV9OPb4r/jhGRnkmDaz5KxkhTRzwa80E/P+Xdf
 38QMA
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
lists with the generic compatible "apple,pinctrl" anymore [1]. Use
"apple,t8103-pinctrl" as fallback compatible as it is the SoC driver and
bindings were originally written for.
The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
compatible as fallback instead of "apple,t8103-pinctrl".

Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/pinctrl/pinctrl-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-apple.c b/drivers/pinctrl/pinctrl-apple.c
index f373afde58e..083ea6d6cd5 100644
--- a/drivers/pinctrl/pinctrl-apple.c
+++ b/drivers/pinctrl/pinctrl-apple.c
@@ -192,6 +192,7 @@ static struct pinctrl_ops apple_pinctrl_ops = {
 };
 
 static const struct udevice_id apple_pinctrl_ids[] = {
+	{ .compatible = "apple,t8103-pinctrl" },
 	{ .compatible = "apple,pinctrl" },
 	{ /* sentinel */ }
 };

---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260430-apple-compat-pinctrl-6602a0f1ef18

Best regards,
-- 
Janne Grunau <j@jannau.net>

