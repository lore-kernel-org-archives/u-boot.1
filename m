Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD28F5A8A2
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5AB842C7;
	Tue, 21 Apr 2026 02:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="c2dS4MaY";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hra547AQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2E68412A; Tue, 21 Apr 2026 02:05:05 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D01A78412A
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C4B437A0148;
 Mon, 20 Apr 2026 20:04:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 20 Apr 2026 20:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776729896; x=1776816296; bh=JH1Ul8ZvUccWgvyTD+OeaHi2667j5tY4
 IVyUbVMK2Hs=; b=c2dS4MaY4xBZ4zDTStguzJYpFZjCd3aQXbwPVyGMPQzWRMr9
 cY1jSf6OXQgsYhNCW67Y8rne2dJQkPBcDAPRjlz15jZqt+FWpZv78lSA3Lhtq4sm
 r8a7jM/zQAdqbQ/RaLdbDVovqvZ18tHqwROZQHf/xOpz5xdrp6qorc0FXd21B1NT
 HwVBmJ32qHhCRByrDSz2radw0ebo0PXyZWv9BwC2qVQ2DymcBExmn5BQ/1uFp/Wf
 6/L+pgp+2Wf7jPnsTrTLF9wly+eMTLj72HTe2jGuv4m7vViHZnJSXxVdQb8zPDpW
 wE3iRURc8hKaNo94V/k1tIFf6hIAlaP3q7R3nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776729896; x=
 1776816296; bh=JH1Ul8ZvUccWgvyTD+OeaHi2667j5tY4IVyUbVMK2Hs=; b=H
 ra547AQx5ZfcBZQOVHHFCpuubvwucTqilbWixBoCwSDohc6QDhngDLYRd57967Ob
 V2StD+fbbFBCzvbHv7o7+Y7NDmGbbqYBgO9UJhFhtDdTczSD8ZqXXTvBGRvxJFZd
 dDE1zPXYULKU8r4YvJksPkmyI8ti/AMDycN4i/ggUvZc38bgTkNAQnDXWSX7TYmo
 jEubm09UbC7QABH4qPgtQxNxooYXu8vy4qLI2WnH4GtaeF+ZXdnE97+qe6bFqRsM
 OhH3NCKUK6fL1U3q+/FPgu0qHiV8vUhsPDJ2onQgMv6Xar2QTKmNpLGbRjs3qOkR
 /i3HzhoweZd7pGMThJ+RA==
X-ME-Sender: <xms:KL_maSdL-bEAeNG8Vbk3ZjqO-g2tum2dLeBECbxVDJ6EiQOOw6kPjA>
 <xme:KL_maRK_KuiYxfD6tgTzxD6lslzzLEXTpPoGu_ZIMug6iri4VTUg2Vfgvyj6TAcFS
 24XIG-YF02H8dLB8G3laguFY9-BS8FbF4hrQfLbrO_JO9mbcdnXBc4>
X-ME-Received: <xmr:KL_maXy29YPerjOXtGAvxamEsfK_HKCrdObE5FUcftnsDrGOeQgo2KpeErpK8qHBxnJXlH6vXVU4H-A334MQlxPxMfonh7L6QQjxz3FkcOst_71tV9LKT_c6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleelvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepledp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrih
 esrghmugdrtghomhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghr
 rhihrdguvgdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmugdrtghomhdprh
 gtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepphgvnhhgrd
 hfrghnsehngihprdgtohhmpdhrtghpthhtoheplhhukhgrshiirdgtiigvtghhohifshhk
 ihesthhhrghumhgrthgvtgdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulh
 hkohdrtghomhdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:KL_mafvQg8V147cwOeP9ArNpOrhe1Iw70ZdXg9Cvb5jrKjA4jLTlcg>
 <xmx:KL_maSB5TKHhyGdOoPTdgahNI47r4CDbhGVgdbscmHK3bvG0GIkJtw>
 <xmx:KL_maZE5rkPASrSG9I3a_KqXi9X08IQPVndg7Zdo9Y9oPiQ-D87jjA>
 <xmx:KL_maaABOZw37SlrVvNg3Bg7v13sz01WBHtJm161g7_7zxFjqH_cew>
 <xmx:KL_mafxOvn8UbkteEu0fvzdi4NOfbVncwlJ5Be9h4y8OG8DL78LxNOcm>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:04:53 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Tue, 21 Apr 2026 10:04:36 +1000
Subject: [PATCH v2 3/8] board: ten64: remove USB hub references from
 internal FDT when needed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ten64-add-usb5744-v2-3-eaa81288e393@traverse.com.au>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=1134;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=WV6GYVqXLSV+2x45ckFUP2N6DlfmsQw4qsf2PK8W5Bo=;
 b=9vaNcQMzmYDyOjZ0mT4vHmG4nG3NJfylPYLSLmBz6G9GvMz0O5Qiivw9VqT2WAEVE6XPo/dWv
 zxhxHfSgQwhCbotkYYsHK/Ga2/jMEEDdUWXYaeCaVyRXC4yHRO89Zaa
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

More recent revisions of the Ten64 board do not have a USB Hub
(USB5744). The references to the USB5744 need to be removed in U-Boot's
internal FDT to avoid the USB5744 setup being invoked on these boards.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 board/traverse/ten64/ten64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index 1f531d34fc8..ee2a4005739 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -299,6 +299,19 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 
+/* board_fix_fdt: fixup function for internal (U-Boot) FDT */
+int board_fix_fdt(void *fdt)
+{
+	u32 board_rev = ten64_get_board_rev();
+
+	/* Delete USB Hub references in U-Boot's FDT on
+	 * boards without one.
+	 */
+	if (board_rev == TEN64_BOARD_REV_D)
+		fdt_fixup_usb_hub(fdt);
+	return 0;
+}
+
 #define MACADDRBITS(a, b) (u8)(((a) >> (b)) & 0xFF)
 
 /** Probe and return a udevice for the Ten64 board microcontroller.

-- 
2.52.0

