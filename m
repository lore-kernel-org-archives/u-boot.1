Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406CA10FC45F
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 00:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E12AE84189;
	Thu,  9 Apr 2026 02:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="Z9wT6afz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BOa4zrWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD4783D8A; Thu,  9 Apr 2026 02:06:47 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B775B84099
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 02:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0356B14001A7;
 Wed,  8 Apr 2026 20:06:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 20:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775693201; x=1775779601; bh=3G1Lc+XwRXdIJVWAaMdO8pWF7TueI2pr
 zm/g4V3xJHs=; b=Z9wT6afz1Xq8kO4CHAt9U2sQjix49lVX2jbKZGEpDNNWbfD8
 sGuHQ2sNXOBHVxg75PwKUsSyvqyWpk0nt8RQ+SuhUyIeqX++5n3Gnnj9x1AIaW/S
 ZyRo32za+ywdu/AZgAWLaaq2qGZvas+C0qnhf47a2qteEEel0C2UBvVmK6RCfX8t
 F69fWsmwdu7sBI+YAuqkORpntivtcgEQflc4DhLT86WnC5+FBDfGXZ+PMiAw0lD1
 oHYwvMl1Gh3yDJ/3w0TcMsq9TWw22cVUbNIZBYD88tlhR7KXbDmKLeptvTC9Hg4j
 01Z9BV3GGOpdQy0YkQ93PeVFXXJcCdxV8IDrVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775693201; x=
 1775779601; bh=3G1Lc+XwRXdIJVWAaMdO8pWF7TueI2przm/g4V3xJHs=; b=B
 Oa4zrWyu8dHOsP9PDoBEGizthe9WSxuxJoJ3RDVXEEmaLHJ/M7gyzKOzKyXvDPm2
 n7RM+2CLTXGQP9xcYVtn199GyNC6YcoEALezu0VSIPNCp4YbXBv3BmSSqNbo6Lmq
 s98skM4Aqgt0HQliIQzcH6IqRxEc9iQvwALxmDvBtao361yDB+jIeAwFsWcTSPla
 ojVS0ROeiGmZ/tG3JJcl7g8qeh15o2EV8kY6i1LXDCpF+UwMMbJRrvQyhUyDB6oh
 DCUplnnY7w9TlMca+Udt8AlXSiPjKrQU6ApGLDyIGw7aZrNALto+DEiBkNp/U9X8
 M0ihoh6k+F67gpJTr5BVg==
X-ME-Sender: <xms:ke3WaWJZV54nGoGumf-zkX4VKrexYRWyFEsGvk_MPGM1345tgOry9w>
 <xme:ke3WacFjsW_jFkJW9Lql16hG2ohq4J3b_PsxmY-JdZ4eRrMVEZIhs-mnotFSlG8lg
 xv-V1obcwm8Bb0EhBuX_0-x-Jdabiy10kLo67DjE7NZFaCA5yMYUVM>
X-ME-Received: <xmr:ke3WaeRc2SvzKMcPRtpnWp37zBUpbxjWIaSZIH5e4rzVZP_G2vAs8PZg_mRk3qIojPdTZ1MYW5DgheTAwEVPBQH8o06CWg2ZiuOi0qVUAoWZEs2UoIdeb8Sp>
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
X-ME-Proxy: <xmx:ke3WaYFQyewDDM1hIiErQSRVKTHZ0l2wVQgoWwur6u-QOuVoHBiuYA>
 <xmx:ke3Waa_fi6CSNanOJ2-DSIzFLmtwPvwS8C9yX079JVFDWViGRF4wIg>
 <xmx:ke3WaSJvq6_rfNcX-2XD8A4qqfhVyoo_8ePPrQ7Z_8JC9qEt5bOI-w>
 <xmx:ke3WadblrPVAlPi6vt5Cp6EDW5UgOug2iZ88TbByfJMPp_E1bOqBlQ>
 <xmx:ke3WaecLfuWI2OOMoaX_YvhF9d9hc9YJe7LogTw0-ddF6jYMGU4ZJlTR>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 20:06:40 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Thu, 09 Apr 2026 10:06:32 +1000
Subject: [PATCH 2/5] board: ten64: add fdt fixup to hide usb hub topology
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ten64-add-usb5744-v1-2-2094496f72c8@traverse.com.au>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
In-Reply-To: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775693197; l=2821;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=mcQd5OPelGex/Ipyd3otSRFAN5sOAFEofHbQ/JPhP6g=;
 b=mbNH7PlR1sKmd8wUrZgbQNFbuju4YDfK4ro0Q8EIvTXBFwlxPSTa/kiKVwWzlRHXJ6l8badue
 vtE7RQOqxWKD0uYdHYXmr+EQmTSMRMJWPV9U8Fd7pMS0L8v72Gwi/lv
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
the USB hub toplogy information from the FDT passed
to the operating system, so the OS won't attempt
to re-initialise the USB hub under any circumstance.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 board/traverse/ten64/ten64.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index d41bd2e9dee..69632fdc31e 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -186,6 +186,50 @@ void fdt_fixup_board_enet(void *fdt)
 		fdt_status_fail(fdt, offset);
 }
 
+/* The onboard USB hub driver (microchip,usb5744)
+ * can cause a disconnect-reconnect loop if the operating system
+ * attempts to re-initalise the hub after U-Boot has already done it.
+ * (This process only needs to be done once per system RESET cycle)
+ *
+ * To avoid this condition, make the hub topology invisible
+ * to the operating system.
+ * It is also required to remove the hub on boards
+ * without it (RevD).
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
@@ -208,6 +252,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	u64 mc_memory_base = 0;
 	u64 mc_memory_size = 0;
 	u16 total_memory_banks;
+	int err;
 
 	debug("%s blob=0x%p\n", __func__, blob);
 
@@ -251,6 +296,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	fdt_fixup_icid(blob);
 
+	err = fdt_fixup_usb_hub(blob);
+	if (err)
+		printf("%s: error %d fixing up usb-hub fdt\n", __func__, err);
+
 	return 0;
 }
 

-- 
2.52.0

