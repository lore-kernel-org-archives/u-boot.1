Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FD210FC45F
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 00:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4654B84118;
	Thu,  9 Apr 2026 02:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="N3eUiDPh";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="i39JOlQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8456B84105; Thu,  9 Apr 2026 02:06:47 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4708413A
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 02:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C199F14001A7;
 Wed,  8 Apr 2026 20:06:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 08 Apr 2026 20:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775693204; x=1775779604; bh=fsEwBQOO/8zheNf8B0wHyE5dqfN9Myxn
 VkwGcSjMPs4=; b=N3eUiDPhpg9DOqcrHeQmyHlkB9mkUe/suh391bGWxaSgICm9
 okFYB5rP/JP3QcqGuuOhFSFcjckZIzE2nEsRnusek+UU5szEvTiSLT3218iCfeAQ
 ni4eZpIkQnU1KoiR7RwZqz854aypmS0WoUPIr/xo1teoWNb+ZCeng54dY4XDc3gd
 HdwYXIL5S2fTtJO3wI1FM3hasR4wJTsB4+Kqt8RJ+xw2flaG07JI4ofE94ch1Z4W
 xK93dswDBNw7n0YYj5fOUp4UL1fveIJUNXLyoFv1U/PznIVG6tZKH8LXMqn2FTQg
 ZAJ3EWFxQRsKmN4nH9EIc08o2ZGgkaRWpUD7ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775693204; x=
 1775779604; bh=fsEwBQOO/8zheNf8B0wHyE5dqfN9MyxnVkwGcSjMPs4=; b=i
 39JOlQJkK8sjYjdPWCCIkaLEEVZmdfac8aGJG/8lehAGxoO9UcH/mK6axAlKOr4X
 mRFAJhuvvxMl8ln8xB4Ov5DYxpbhu0tP65SFKSI0jFEIgeApcj9UFkz4vPqnrRbq
 L39NKhCyXYZobg3CeNrEihIjd9udqVvXNQv6F6hcrfS7lqhrw/Vt4BJP0nY6ipWY
 bFs5t0L710xgvByP74s/b9ukvEUgeWztpW3PIL8aP1DYOlGMSABf29swXIyYRBHP
 1Up4P30c2vnLNddMhIYsvHelSTTzc0OFGDkbwzkzWR7l7qEtfKccwBx+TnlJcxif
 ZT8rDEd6uEYpiF8D/DaXA==
X-ME-Sender: <xms:lO3WaT2jdzn5q0Pk-iTDY5wSagC1yU27eFWXpq_FNEpal1OADax12Q>
 <xme:lO3WaQCYr347CcBmGLFVWbNxAwBF4g9thHPrNlcO4A17L5wOvq28uRtCiowLbLf4o
 QaV7Vx-jjMORArNYUTdW0NlnzQk1e2iuYhywLtYR8Fm7ebRQsZTQgk>
X-ME-Received: <xmr:lO3Wabc1Gr388E80XFBpqm_Rq_GQGnQJ2huQqxKP8kanaH_dTpQKwNIaFfMfziMPWF3jdP_hyrHo31JeSs_HglsuT5S5ikQO0x8SGGykO0W2B7BbmhHICLH8>
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
X-ME-Proxy: <xmx:lO3WaVg0t-QW1Nrij7YWQt9h5cDk4_U4nyQF_nHfVxh0ucx-JDQSwA>
 <xmx:lO3WaToMvWePOzyS8IyP37073GX5nI0DrPeniMxAXhSD43daUJM_og>
 <xmx:lO3WaVFIxEe0RZTxWD1PQvUhk5ed6fkwVL8WN7KzKDZNxH57WJNeVA>
 <xmx:lO3WadmYtQR-ZjDvtLMtT-wnENiIhJG7aHBlBLH8_Cy2IPQRFNoabQ>
 <xmx:lO3WaY1JVamphyEmYzibcIm30jEadnu4WjZ-4CTKsQOycR35XxFXjyAs>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 20:06:43 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Thu, 09 Apr 2026 10:06:34 +1000
Subject: [PATCH 4/5] configs: ten64: enable USB_ONBOARD_HUB (USB5744)
 option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ten64-add-usb5744-v1-4-2094496f72c8@traverse.com.au>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
In-Reply-To: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775693197; l=826;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=xqfGELWr3YWR0XrA+jEVGwlCeyPwqVneeCCrUQn1BO0=;
 b=HuLcSOoLcUCQd2YJkxLy4CHL/YlSlMUWJAsj7liqG1IjWQgLTTnByJ+NsdGWbrGdeLjZ/g4kM
 EAhPv5X1k/eBrmugMeNSY08U3P3RfELXcCe//hfrgnJ0xNIWRtwqgs7
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

Ten64 board revs A through C have a Microchip USB5744
hub on the board, which must be configured over I2C
at boot time to become usable.

This function has not been part of the mainline
U-Boot for this board until now, as a mainline driver
and device-tree binding is now available for the USB5744.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 configs/ten64_tfa_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index a65209e8335..2c5227193c0 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -89,6 +89,7 @@ CONFIG_FSL_DSPI=y
 CONFIG_FSL_QSPI=y
 CONFIG_TPM_ATMEL_TWI=y
 CONFIG_USB=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y

-- 
2.52.0

