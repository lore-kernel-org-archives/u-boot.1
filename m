Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5014F5A8A2
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0795B8429E;
	Tue, 21 Apr 2026 02:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="Z88FfU20";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQEcvnuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8AD8412A; Tue, 21 Apr 2026 02:04:52 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98F048421A
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 750B61D0024A;
 Mon, 20 Apr 2026 20:04:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 20:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776729889; x=1776816289; bh=MTqCGwBG7zX9gnsWmWUr0rrvR+YSjXNk
 QNQC4D+VNuk=; b=Z88FfU20pwQNXW15xiKsX9tn+QqTvSy14O+JtQBIYXPftMmD
 7zy9VLYomF7jITcg29EsNNg3eBUDmwjlFwcdXVqETxTV30T76Qta/SOHPkWVgWkD
 QmeBcfL8YDi3FLlrA0GL0XRLLsZE/jMib5Auzn9XTTopXzYOmus6U8sYZWYa+s9P
 f3g1sy9T7YIRTu0Ad1Kz8fpzNh6x/REIa3qzyHMT4VwzUyDzCkltOikMhkBzT4Dh
 DRq/gclAJbZV9p6HVIiEs8hy0mOL9nbkyQKhhdQJa6OSVtfuZwlzLp9B7I8yHyop
 77No0EAjdvwjZglXWzKHa8hlKlvJ1G8LXwnhTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776729889; x=
 1776816289; bh=MTqCGwBG7zX9gnsWmWUr0rrvR+YSjXNkQNQC4D+VNuk=; b=s
 QEcvnuhkPOUwjemDFRoMvSj+giBftIdszMtUfVyP6Dgvj37EObT2qE8VDn1dQ7c8
 qYSp7cUsl5tRWK2yitUT57T7IeT/XUBFXDcQbbPI3vgluGFc4YeBen+G6YM7icdT
 nKPXnFIewnj1OQL/t1YvIfTlo06gqmfZbC6vSD0c42b3H0mBzwyoZI9oH9hwefFy
 crYW6+IAEhk6e6yz8FSZdGmG+fKYq6KInQNB+iwp62Lsu+OxWa2YwTPyzFrj3nSs
 0H2ihd3jPx037GUhHI1Y7Z1l742fLXL85M8+QorP3GElCwPsHDuIGLfUr4z1OxgZ
 lohMCP1caRS7HN66uOrRQ==
X-ME-Sender: <xms:Ib_maeJCUq-38tb_simjszro19dX3fkurGYdB4Pt2tiNbV1voF9sKw>
 <xme:Ib_mabE7AkD1Nxgk6D6sZsvfT_85Ch-5o00tufpS10jfoPmhIXUn8TWh8iMg4DNxY
 gTLmpP5c5TvXLuP49nzc_m2h7LmrzeXSRuG_tG2s04iYYm69qqvY78>
X-ME-Received: <xmr:Ib_maS-gQEndfZwpTIKgo1sws8n5hXgC9qM_6YMDNFW9utqFBIb2pcFA8i46V6754vZWpweCWSA9JaXiHOc9hrmR5rwkWWP-hbLVChUMwBWZye6xBbggpGQJ>
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
X-ME-Proxy: <xmx:Ib_maTIkZL_69u0sGBNtJEH5u35jGsp6C75DucAFDD7rNnrJtOmT-g>
 <xmx:Ib_maYtRR_nYndhRnExa4umPM-dhx0jhThB_lqCwA9o3wYtx0wt2fQ>
 <xmx:Ib_maSCBkGQ5lY7Sgo_PpqDwfc_jIKC7zl0wiipx2IvTG1tRaiP72w>
 <xmx:Ib_maYPzr-LsYD7gnWlJq8odX1SDzimCueXISxmg4lmy-L1eXaL89Q>
 <xmx:Ib_maVsf_5ISUXKMPKow8fdraPY276IXWYvL-eoaeQ9h0h-2IhPF17q_>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:04:46 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Tue, 21 Apr 2026 10:04:34 +1000
Subject: [PATCH v2 1/8] usb: onboard-hub: fix compile issue with gpio.h import
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ten64-add-usb5744-v2-1-eaa81288e393@traverse.com.au>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=1090;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=nYLsCBc2iTJo5flSRUX4Pz7DH3uHzY0jfAbiPVDv17Y=;
 b=1C0mGevL/isHumVB1Mv+CaFsAslQTHRiGmKQCbfP2+TWye9qDJPdMGpOel70VrhrTJrtog52C
 TXtJoMjyeW9B4Qv2IExDZBijOS5LFDlGrynDoADNhoZ1D1rmV96Hs2Q
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

Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

