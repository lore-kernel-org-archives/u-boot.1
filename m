Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF9010FC45F
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 00:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65E6840B0;
	Thu,  9 Apr 2026 02:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="A8u//LUZ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="tvtVYfhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDD484118; Thu,  9 Apr 2026 02:06:45 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A907983D8A
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 02:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 907F21400199;
 Wed,  8 Apr 2026 20:06:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 08 Apr 2026 20:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775693200; x=1775779600; bh=YloZlTjucwL2mz3h0NoWR0AzOQPoYlOm
 ZEAj8zmf05I=; b=A8u//LUZihLZ9MRjofmuECR6k8SHmOg1JaS2QCzsH7Mf+3kU
 K/otQjHO5eOB4KnLkD3HlBNlNrOEbsOqrGGlDSjxVQwierI1n3wcFJM/uMJH6pvT
 TbCI9xaTtyN42QaRGHpR3qFtAqHF26KIyXMaZ9skjScAWaLJtJfMNsUhQmXPVXlA
 YYiDrXHCIBaiTO5eRRISQZiwUdAroMcO00dnscyclR49d2GKrHKx7vxJKHGVczS5
 l6SMK6ViL/6epMWqPZF381LqRCc/v2vkeg9HnZIe7Iyw0FkcbGaWm1k5ZZTm8tOa
 QTJB8LT9DICjW9mX1jAwsh8yAMF3omejoWcJJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775693200; x=
 1775779600; bh=YloZlTjucwL2mz3h0NoWR0AzOQPoYlOmZEAj8zmf05I=; b=t
 vtVYfhVP5TN1MIQeuuhbkThmjajNeLd2665kMhufKi369NIQHsEFOvPS0voFbWGs
 EkMdQDkv1v06Typ/thAZd/mewAOcPkDaPQ/UmA0++zoA8ymMmVYzEBJ5Mb51fLi0
 P4SOJ/OmIrg6vbD+hdzxay0wHbJTx9/DT162FykwkMkopdVQHm9pR+O4RVZlcYNF
 COFkttU2P13BaEUTY7P6GZsDgIhTdOisaL8ysA5Itv5xlDcX/T9YIBKzRi4MglLY
 1NPYWuSkSpCs5hCddthvTMsVTjYXx5mTR+lp43LGed94yVpvNEKOrFC2Fuq9egWF
 XhNgue5MAX21n4zh4AmIg==
X-ME-Sender: <xms:kO3WaZcHXSuiDxMVDY6iSIz5YKQ3-m66mnRKV6v4qe14Y5ci_zUFHQ>
 <xme:kO3WaVIufCQO6yU1rtDvK7L_Llp2N9lWzyUAFa-s9dTM2dAbE9ZLWc2RJZn5KkIpZ
 F4sXLNleO7rn1evxU9MtT2Mbcwv8VPOj_xfOk6XAlE55fP4z8aF>
X-ME-Received: <xmr:kO3WaaHi29MeGCiMolin1hu1kpVwdKd2BHy93UkrC7ChbVHG_DjUPUGpSOIYOBq-m_XRklvudBZ4gJ3AFYwWGtBsUF3QmY4lzh2xJV3rHSkccBZ6izj396-p>
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
X-ME-Proxy: <xmx:kO3WafoPQOoJWADT5zFBUtC9LpTL-nsqEE5fgA3mzT0pE3u9MS-9CA>
 <xmx:kO3WaTQcrq2NjTOAxTiTVpnlXVYR3OzQeu5rSc23A6QjVS5lzlI_7Q>
 <xmx:kO3WacOxOiqpbTWJmmQCZER4ABgV11pP2a2WM5Wr92Bs_-gdjFg4eg>
 <xmx:kO3WaWPq9OThiAoj5nCAjXJiczxOOBuJdTT7ZNLXsWLV2hkC2MN93Q>
 <xmx:kO3Waae5pcvZEeYos_ipuMne2EVxv4il6PAz51R8FnyfhgBO7sTpY0LI>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 20:06:39 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Thu, 09 Apr 2026 10:06:31 +1000
Subject: [PATCH 1/5] usb: onboard-hub: fix compile issue with gpio.h import
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ten64-add-usb5744-v1-1-2094496f72c8@traverse.com.au>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
In-Reply-To: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775693197; l=1048;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=IuuW+MxtiEMfJxPh/m4KuKzvztdF/R0qJP5fYgRHzzE=;
 b=O/IkE5Gyrm8GXgCE6Oh6Iy56djcrgQxEd2nAxZ6KaJEXU+Ripjyrdy/s4jiYs6wLOfjKvfOBm
 xoTJO5CUKEpDi/SdwG6wQPmrNOjCqq88wO2Nw6Vp7u6c55eneCOJmMR
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

This resolves the following compile error when compiling
ten64_tfa_defconfig:

In file included from ./arch/arm/include/asm/gpio.h:2,
		 from common/usb_onboard_hub.c:10:
./arch/arm/include/asm/arch/gpio.h:17:9: error: unknown type name 'ulong'
   17 |         ulong addr;
./arch/arm/include/asm/arch/gpio.h:18:9: error: unknown type name 'ulong'
   18 |         ulong size;
./arch/arm/include/asm/arch/gpio.h:19:9: error: unknown type name 'uint'
   19 |         uint ngpios;

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 common/usb_onboard_hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6fc34489a98..1b23bbb2afc 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -7,7 +7,7 @@
  * Mostly inspired by Linux kernel v6.1 onboard_usb_hub driver
  */
 
-#include <asm/gpio.h>
+#include <asm-generic/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/uclass-internal.h>

-- 
2.52.0

