Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DE0CD13DE
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 01:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403ED83A91;
	Fri,  1 May 2026 03:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="TQpmwlgm";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kickeYzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47ABC843D4; Fri,  1 May 2026 03:36:20 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3DE839D5
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 03:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8B7CE14000B2;
 Thu, 30 Apr 2026 21:36:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 21:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777599377; x=1777685777; bh=s5CzRRE5oSlKir55IYhFzAAb4QdoeJCd
 hohUueNhuVU=; b=TQpmwlgmm5deKxq91cSA6r8FJazUXNRHs5n5+DaqxNOWTRyK
 GLqeQJMJNz8IVca+GY2HuR7tJv8tSIEuiDB8tZJmTZ2v/PSqiuN3dkr2mPeSV26Q
 QLTZwn73RfYCVY4jDp/K2ZL3ypxNlK3Zf1tFE5aD4LzEt2VMJj7mVKM9oE8EDhD9
 qapJ2t7oYyyu/3w0kO0v30uXja9Zvf9ylTeWT9/wLw2gC2NTVq+jKIn4cjpzDUAI
 yFfBygL5h9zc/XzzpwJV8Ihlyl+az0SZm89eCQbJj8W5GMaH1OgyrLU4f5b0EeUk
 uS7pynpP6TKXHLOySBmJoK1jkn7q68MYfYjNWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777599377; x=
 1777685777; bh=s5CzRRE5oSlKir55IYhFzAAb4QdoeJCdhohUueNhuVU=; b=k
 ickeYzlm6Ilc8zVvq4ppGEcuZNxl5NL3v0NVWSlh5rcx1XpzBOdFF6rd0T7TfE/O
 TSPNZfpBqSZeG2Bfgyeb2TfTUieudmlXkKVWpNLa7Q0wAt5liXAYSX4Ki0BVMe1I
 Lz+1cFD9SFn8EK+Pry8ncjheis5VCUXVmvoYZj8iOqd3Q8msblbylQYthk3rMK8A
 AqlmTjSmXWXNnnjbOz9QMHOUGrp83IFmxQLzmi7ioP3A65LVX8Aue78Grc5LcRlt
 yP7wPC26P9AzBR7tAEA45bSp2qMMyLmPHCABq/rbMlLloWUsdlEauIjxEfTtJMmu
 OCr1G6PducVk+QPojyzrQ==
X-ME-Sender: <xms:kQP0adMu4B-1vwiW5jgc8Fv6_fY_9KHrFVy5RXMdqauVxr4BaR6cog>
 <xme:kQP0aTCDflHcdmXbJAHVczYw7OWoH9NP66I6n1zlKQhJubKHWqg3aV9f5bGcZw53d
 YRPIjPbW0q8LO3AIoXZNnXov5oIiLFt0O98znlamqYYGTvISzAzgufH>
X-ME-Received: <xmr:kQP0aW7TGElKP5JResmnYrW3y3LRAeUUT-cyiOAM3MP1F1wj12WENN5Ix6yxujYH8IEk3rfIKykfo1EHk-3wLusPwJUjSxaoCrzx6bC5omlZDYpk1EoU9DDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepuddt
 pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrd
 gtohhmrdgruhdprhgtphhtthhopehluhhkrghsiidrtgiivggthhhofihskhhisehthhgr
 uhhmrghtvggtrdgtohhmpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpd
 hrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohep
 mhhitghhrghlrdhsihhmvghksegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhgvkhdrvh
 grshhuthesmhgrihhlsghogidrohhrghdprhgtphhtthhopehprggumhgrrhgrohdrsggv
 ghgrrhhisegrmhgurdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtoh
 hmpdhrtghpthhtohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggv
X-ME-Proxy: <xmx:kQP0aV5R8ZOut7ylNQUsBhQWy-1n8zQMNHyaRP8wWJ9ukAMFrcQmZA>
 <xmx:kQP0aQSCQuc0CJ9rkHUiY21RZ02gwafquGTSQVcBIlW6cUiQXGhMqg>
 <xmx:kQP0aV8EQ05LKYtgtY04-7YVZSgla474qt1WgBc9cJQt7g0BrSaICw>
 <xmx:kQP0aZb4hHti4X5i-tTIW210dfXSL6poR9eDmUR3DcIXw_NNI7ZTUg>
 <xmx:kQP0aQLZsphtCQVDdEW32biL7nFPUU_OyL5BHkSWvkkZ9m5CSA2Y0abg>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 21:36:14 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Fri, 01 May 2026 11:36:03 +1000
Subject: [PATCH v3 2/8] board: ten64: add fdt fixup to hide usb hub
 topology
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ten64-add-usb5744-v3-2-234c5b2f8c6f@traverse.com.au>
References: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
In-Reply-To: <20260501-ten64-add-usb5744-v3-0-234c5b2f8c6f@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777599366; l=3027;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=JDvtegEwryJLKC2uFgGsfv2hKajLJEvf4JWmN1hiI6U=;
 b=o68defjjDuT30zzxk0o1b6Wean0nXueHujmBiwTmOwzIULTgsGk3XSmyAJ0nACPeIWurN0Nuz
 8opuGA4DRUeBFPc2d9AM82da5rVb2eK1V676fS69RxaGxBmQGZNFsX3
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

The USB Hub (microchip,usb5744) can enter a dis-/reconnect loop
if a driver tries to re-initialise the hub over I2C.

On the Ten64 board, this process only needs to be run once
per system reset cycle, which is carried out by U-Boot.

As there are distributions shipping with the affected
driver by default, the best solution is to remove
the USB hub topology information from the FDT passed
to the operating system, so the OS won't attempt
to re-initialise the USB hub under any circumstance.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 board/traverse/ten64/ten64.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index d41bd2e9dee..c5fbf4b4a04 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -186,6 +186,58 @@ void fdt_fixup_board_enet(void *fdt)
 		fdt_status_fail(fdt, offset);
 }
 
+/* The onboard USB hub driver (microchip,usb5744)
+ * can cause a disconnect-reconnect loop if the operating system
+ * attempts to re-initialise the hub after U-Boot has already done it.
+ * (This process only needs to be done once per system RESET cycle)
+ *
+ * To avoid this condition, make the hub topology invisible
+ * to the operating system.
+ * It is also required to remove the hub on boards
+ * without it (RevD).
+ *
+ * The USB hub fixup may fail for legitimate reasons:
+ * 1. FDT has already been fixed. For example, the control
+ *    FDT previously modified by board_fix_fdt is
+ *    re-used for bootflow.
+ * 2. The FDT blob is based on an older version
+ *    without the hub topology, such as older OpenWrt
+ *    FIT images with their own device tree.
+ */
+int fdt_fixup_usb_hub(void *fdt)
+{
+	int usb1_hub2744_offset, usb1_hub5744_offset;
+	int i2c_usb5744_offset;
+	int err;
+
+	usb1_hub2744_offset = fdt_path_offset(fdt, "/soc/usb@3110000/hub@1");
+
+	if (usb1_hub2744_offset < 0)
+		return usb1_hub2744_offset;
+
+	err = fdt_del_node(fdt, usb1_hub2744_offset);
+	if (err)
+		return err;
+
+	usb1_hub5744_offset = fdt_path_offset(fdt, "/soc/usb@3110000/hub@2");
+	if (usb1_hub5744_offset < 0)
+		return usb1_hub5744_offset;
+
+	err = fdt_del_node(fdt, usb1_hub5744_offset);
+	if (err)
+		return err;
+
+	i2c_usb5744_offset = fdt_path_offset(fdt, "/soc/i2c@2000000/usb-hub@2d");
+	if (i2c_usb5744_offset < 0)
+		return i2c_usb5744_offset;
+
+	err = fdt_setprop_string(fdt, i2c_usb5744_offset, "status", "disabled");
+	if (err)
+		return err;
+
+	return 0;
+}
+
 /* Called after SoC board_late_init in fsl-layerscape/soc.c */
 int fsl_board_late_init(void)
 {
@@ -251,6 +303,11 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	fdt_fixup_icid(blob);
 
+	/* This fixup may fail for legitimate
+	 * reasons (see comments for fdt_fixup_usb_hub).
+	 * Hence, errors with it are silently ignored.
+	 */
+	fdt_fixup_usb_hub(blob);
 	return 0;
 }
 

-- 
2.52.0

