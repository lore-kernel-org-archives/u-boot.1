Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F5CD3424
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 14:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8C5280F0E;
	Fri,  1 May 2026 16:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="eXdVA/J7";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwuZTNcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD38E83A91; Fri,  1 May 2026 16:07:25 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE0080086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 16:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ED67C140005F;
 Fri,  1 May 2026 10:07:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 01 May 2026 10:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777644441; x=1777730841; bh=gi
 jzOehdlwSt/0jQumJRZuDxd3FidnaDWBDguREWsy0=; b=eXdVA/J7QqKd25A218
 DTwCkO5Wwi6O/iVOyeqRrT5AhC+0YTCkCvAVEzZuP4GckEXM/uYkR9LwXmx7GhS+
 oa1hmy6b9vl46CRw4LaojcLo5fi/rTddNrZplgaWuK/mVZCIyA8ii55lViPgVhvs
 mcUuRIqufkhN5TMns2V5PljixXYMa73WvXNxIq/nDIh3bKiH6p8voQL8vSPB8Eyq
 DyziJb85k+en4jMpnGiFlILt1BGXCrL9wnfMdY1Jzh8QuJQrJfL8jCIEMOjgG2r4
 1tyKx4BR4juQGDSwop4p1+XEmoLHhMx0Cy/+S2rkSY+DhE8Pty94NGL5OxlnjFxW
 uUiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1777644441; x=1777730841; bh=gijzOehdlwSt/0jQumJRZuDxd3Fi
 dnaDWBDguREWsy0=; b=XwuZTNcN4cfhQ0JdOIAjBTW0lVEpaqR2tmlqSzG+2FHF
 20OLm9/mR4xE+M+ZDCPsGEjoo4/MTFYCcrRnFj6j2TdCc69WUT1YqYEbFjgiQS34
 bJMotUL/CsDc7oMED/LUQ9IiYxzljzprXPqMVOOyx4ELGiN9oUHn6qdJy8Tx5GPC
 niRDN56XRRoJwFIjOWnM1pTHLKhOx4BxvdBpxLXtdj5w6BgYgsOo6JwyONstzr1K
 oqxGudxyYjYPynKHnzoYaFqNlKy6g0pqgBW8tR5NzPiuK47sPgvOqbstcciX4qtz
 qQ+IQcfKzHsBivtDExw5XJlXrGiKOVI289Ek7yzPww==
X-ME-Sender: <xms:mbP0aTrZzlK5L1GaUSaJTlqLaqClTR9oghutFCdMEe3OYBsY0cDtuw>
 <xme:mbP0acuUHTUOygLOJKNmSDNcjNgdOpXATHmuUuc0VTj4dMUBowC_scFGVt_1tuC8R
 8jDb7C232x7lI4hWCui5sU2VMllLPvUMlT48iHUjRD_L8M6SNMpQ0dU>
X-ME-Received: <xmr:mbP0aWZ69_nS_Ifg-Y5lSTXCznZkWscvtmCOz6DIe4eKSTtLSDyuMwzqP76DZiMQhs0kpsZMIA0ep8UlfyQdbg5ydywFEr0ZKjhd9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltdegtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgffeiff
 etueffteeugfeghffghedthfekgfdtjeeuuedvveekteevvedvffekheenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnh
 gvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 mhhkohhrphgvrhhshhhovghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhghh
 hoshhhrdhgrghnuhesrghrmhdrtghomhdprhgtphhtthhopehkvghtthgvnhhishesohhp
 vghnsghsugdrohhrghdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtth
 hopehjvghrohhmvgdrfhhorhhishhsihgvrhesrghrmhdrtghomhdprhgtphhtthhopehi
 lhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuh
 dqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepthhrihhniheskhho
 nhhsuhhlkhhordgtohhm
X-ME-Proxy: <xmx:mbP0aTbfR4UnMUwY2Tny_TDWjzAWhPAUrKHUz9VFHYj3djEZg8aZzQ>
 <xmx:mbP0aXkcKxTbmxxA99HjxRXvUuzc9n9FAZDjbFdVc_hyz2RG-VYILA>
 <xmx:mbP0aW3TM2B-TN5Cx-tzld4ErhS9zWweRZBH0I7tLxCmLH9gyUIXmg>
 <xmx:mbP0af1DRHewsGG6hDH5zRCnD93Y_GIWScO54deWz8tVuWbB79WGfA>
 <xmx:mbP0aY1RP6A1lCptpGl8_eRytlZ0kMtA93a7qlvXIj33_TSkITAY6L31>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 10:07:21 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 01 May 2026 16:07:16 +0200
Subject: [PATCH] arm: apple: Add Apple M3 (t8122) support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-apple-m3-support-v1-1-4165bc2a73f4@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwND3cSCgpxU3Vxj3eLSgoL8ohJdy7RkI9PEJHNL4xQTJaC2gqLUtMw
 KsJHRsbW1AL+x3NViAAAA
X-Change-ID: 20260501-apple-m3-support-9fc25ab793d4
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=N32YiN/BHOD11xeiOHlKPC4MopXE6X30UvrSFmY+ObQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhswvm6dvEv8S94SLN7HO423B58PCYmWG85seiP0xVb656
 Hd164cjHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACay6h/D/3rP6VmLf2/NW5r+
 rGOtRqp8XziL3sZthn/s8j+pfV9u8JXhn/0Lw7Parisip7kuumWzp1T2KmfewYRriTWLQ4yXZb9
 9xwkA
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

Apple's M3 SoC is similar to M1 and M2 but uses a different memory map.
The main difference is that RAM starts at 0x100_0000_0000 like on t600x
and t602x (M1 and M2 Pro/Max/Ultra). Otherwise IO blocks have been
rearranged.
U-boot's existing drivers are compatible with the hardware and M3 device
trees will carry "apple,t8103-*" compatible strings. Only
apple-atcphy-reset might need a new compatible due to USB4 / DisplayPort
changes the Linux driver has to deal with.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm/mach-apple/board.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 4cd8979bdc2..914b4581e7d 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -85,6 +85,75 @@ static struct mm_region t8103_mem_map[] = {
 	}
 };
 
+/* Apple M3 */
+
+static struct mm_region t8122_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x210000000,
+		.phys = 0x210000000,
+		.size = 4UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 8UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
 /* Apple M1 Pro/Max */
 
 static struct mm_region t6000_mem_map[] = {
@@ -710,6 +779,8 @@ void build_mem_map(void)
 	if (of_machine_is_compatible("apple,t8103") ||
 	    of_machine_is_compatible("apple,t8112"))
 		mem_map = t8103_mem_map;
+	else if (of_machine_is_compatible("apple,t8122"))
+		mem_map = t8122_mem_map;
 	else if (of_machine_is_compatible("apple,t6000") ||
 		 of_machine_is_compatible("apple,t6001"))
 		mem_map = t6000_mem_map;

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260501-apple-m3-support-9fc25ab793d4

Best regards,
-- 
Janne Grunau <j@jannau.net>

