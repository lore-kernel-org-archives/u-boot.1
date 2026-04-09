Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E8D10FC456
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 00:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFCC8413A;
	Thu,  9 Apr 2026 02:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="MZ6uCXyr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BiHR/5b9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645D183D8A; Thu,  9 Apr 2026 02:06:46 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20426840D8
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 02:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 57BDD14001A7;
 Wed,  8 Apr 2026 20:06:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 20:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775693203; x=1775779603; bh=jzNUMy+A4fKpC4hrlkLD9Zz6+6IlUrTi
 jeatA1OFyX0=; b=MZ6uCXyrvV/nuJlkgMb6I++pVg5WUQGVZan8p5LuHiIhJ49t
 30Y2EOnvG7rWDMOlBjkqg+1m4V8X1k0P1UgpnZ57KeB5/6oNG9XRUBHYjUnq7WJ6
 xcVFEWct3Fju9RipLR5XgK8BvSZM8l2ENSjCkAuV2/CMpCkq6e5hDabvmfS0PIGz
 OE+xSOuzKyjkstOilAWMRv/u63819BIDYsypcsrfVOTRWokyx9sO4442BqyOSMFG
 ZayHVdyJ1OpyeutEz5nvY/84eZSJrh3Fr+p9Y9vDAmsemh/8yfq5q4ct/Hy7icFz
 AEllEsigeVMdNeG0dJXOxUCTbUb2MX5LxojYpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775693203; x=
 1775779603; bh=jzNUMy+A4fKpC4hrlkLD9Zz6+6IlUrTijeatA1OFyX0=; b=B
 iHR/5b9o5RSpsS7caCt9s0g5Is6ZGP2nDe2FVNdfJLdvGmp4qoJxdPh+iZhaAWXO
 sngcuNYSZuLEd7+OvjYhstuJZUxBfb398UI9rBORLqMvSB9uMQGm4fyJPpYWyI15
 WIqwm36EWRef92tV2lCqZrfyYvIBY2NCaWTApuUyccKrfSd5rxv+RXStjf33qrQc
 olexcet4H4BNGlCGwQqu8+Cp+LZxhiS9tNW7LbUJQIfIoX2wwjHeR9FNuDLnVe89
 D4PbGgzaTOlxlYESORCXB2B54AEVaQqbhLnLqlNB46sOv7UDo5ORPPvhMu39Dkt1
 YJoISzvJoYxluMMGlJKhg==
X-ME-Sender: <xms:k-3WaTzJCKeJkgFVTqAQouiBzmP3DGxo5KdPAEOrrt3_DTJmU4oLGQ>
 <xme:k-3WaZPfs7aUhowbR3oN_fti9cmGUeToEr_jDH7Kv4PdjQV1hWXW5ZMfm-9qNjZih
 qx0MGhEk_nBxPU38WMDC-zB2Ij3IAtc9FcfMEJbhw8YihJGEJw1klg>
X-ME-Received: <xmr:k-3WaU7BvuRihz_UILBCz3985-vkfi0V5qWP77DCTt2lqKOd6dOZ5OhdAnELEcgZmx0EWDqPbXvSw6NJ3xmP3PNC338f6lXuZ2tr4KxPTh6l9BeV-4lc27FG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeelkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
 ertdejnecuhfhrohhmpeforghthhgvficuofgtuehrihguvgcuoehmrghtthesthhrrghv
 vghrshgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepffdvtdfhkeelffffgfejke
 efteeuhefhiefgfffgkeduueejheffteffleetgfehnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomh
 drrghupdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdprhgtphhtthhopehuqdgsohhoth
 eslhhishhtshdruggvnhigrdguvg
X-ME-Proxy: <xmx:k-3WaaNNZDw_IyMr-YDe-Wg8ftLYVzimm9AdjVydvPWIaDkoNsVNxA>
 <xmx:k-3WaSkzTpxRpLquPzswdesLz6J1_9EEaBvc_ANJQezmFePro97G5A>
 <xmx:k-3WaRSW4Dh5eGhpXiAwqUruAwrv08-KZ0QeVdEr2-5Ac4lCbOldbw>
 <xmx:k-3WaeDmY-XtRmOlYGqbRtKUFWs7N_6CCaFyIxfYk4qBhSOu0szlKQ>
 <xmx:k-3WaSwGqyqpHetqfbK3D-HViBztkY8mIXb2qclETOBB4Jp7Hrpg_CL0>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 20:06:42 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Thu, 09 Apr 2026 10:06:33 +1000
Subject: [PATCH 3/5] board: ten64: remove USB hub references from internal
 FDT when needed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ten64-add-usb5744-v1-3-2094496f72c8@traverse.com.au>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
In-Reply-To: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775693197; l=1092;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=OvYD7TFPrMVuZl16HFWXPkcFO/YAQThjX1qg7OrDSQk=;
 b=25x8pBVYPJ1haSNiNZRAVRBmq/Qv9lDzoLtOdpuOJlXQn4Mn0jE7lgmbVIuDQBMlifMsIQVkH
 vGFhiYX+PjkBCMiqtK8JLAGfUJBtWyObbmZnnb4StT6ZVgJ+4gUdPJP
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

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 board/traverse/ten64/ten64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index 69632fdc31e..d8ba6ab71e0 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -303,6 +303,19 @@ int ft_board_setup(void *blob, struct bd_info *bd)
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

