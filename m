Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA89CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D078468B;
	Thu,  7 May 2026 10:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="e7Cswyxt";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="NblZyMHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3725284A37; Thu,  7 May 2026 10:41:48 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE7484687
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0627A14000E9;
 Thu,  7 May 2026 04:41:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Thu, 07 May 2026 04:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1778143305; x=1778229705; bh=vi
 jA+KYw2A9L7E0HuHn8t7EtORiIbtnTerV5CqS4Jss=; b=e7CswyxtwQyo8TdryZ
 ZHydMQN4gwzxKqrr8glW16GLKu2Sw5KsWe5xqqlH7Uc0Yznti3bAcq6Qqfpt4X8+
 nk3wckPWYcc/WsNqTZQq8N7KE2v0PYOi+wnWEm+L3ilFiJvsvUJs79UhahV+WG+p
 +9RUavpJtA/6fQaR5HCTSW3xA5tx7dZUbqP+ZBWP1BOiRueU20VgKLa1fK9d3HDu
 X7Kqsg59dPnkWkL3knov0ve8wZq3YVsTgQ9RZDuIOFeFaap5cDv4nK77HNlPjuze
 TsD013ZW3Tofb6hVH39drAOic5PceWLIG1968zcnNDF5+5nK0xuCnhlq5a8F5tOt
 TRrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1778143305; x=1778229705; bh=vijA+KYw2A9L7E0HuHn8t7EtORiI
 btnTerV5CqS4Jss=; b=NblZyMHnJzOl/fzREFiPUax7ausDpj4UjCAeEfPashbH
 KOpvA0UT1laudwZHCswbsDvEPYyTtV7thcqoYw+lTfxdWqfJdAYNP3/aXEotnADV
 X1JwSm/H6gfD3TY8ScuM3q0SwlHxVtotNOC1EtmIjIcnP+nwGEH1JN1HaRzTtIaD
 vLa/xOSALpqR797AfasA1afSIngssBAIUZW99omD/UEaYyzYEamzMxQnqpNNpI95
 gCvncBcsy2oSk+Z0N99GySF+E2WMDHlDwbOypBWk2JQyca6et9uQ3YjYS9WfNiWc
 yBKA8jHSEqT2LvxowAhkG46i1u6e2305fabBUdKWCg==
X-ME-Sender: <xms:SFD8aYS38NjUIqKzYlcVYm44SQMc-7dRnIGJpyIimuMyHHQpY_Ci-w>
 <xme:SFD8aU22d9eSyj4xrJgjycrx8NvM6s6ujunCcPoX1DoyA7sqCdE4aDjMOjJnjYKrx
 fik1OuvpNpBzTFOGIOt24cz-tlvAD79xdukmYz33wTDRx0ykD5j3gY>
X-ME-Received: <xmr:SFD8acCKSrTIwRGZmp_Pn_fbkk0sBmQ4PNhkFkG2Rbm0z1oCUHJTG7LDGeRFgijofCFdzcPqiJpR3Hl0E_iGllGQta2xUk7-EHfDvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejtdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
 rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepheehud
 ejheevffetveehvdffhefgleefvdffveeivdekteduheehudelveetvdeinecuffhomhgr
 ihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepkedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhughhhohhshhdrghgrnhhusegrrh
 hmrdgtohhmpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtohepmhhk
 ohhrphgvrhhshhhovghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrhhinhhise
 hkohhnshhulhhkohdrtghomhdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghs
 ugdrohhrghdprhgtphhtthhopehjvghrohhmvgdrfhhorhhishhsihgvrhesrghrmhdrtg
 homhdprhgtphhtthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordho
 rhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:SFD8aYixTpq3NaikiMzdGk9G3xW31_WPsiMUSUhurbMlooZC_buwSQ>
 <xmx:SFD8aWNVoChAmACyByldcVtr-gaCSdJNbX6YPeR9QT09DVMJ-KbqXQ>
 <xmx:SFD8aQ9L98rw5k3BzOUZ8TNfY5KwO6MLTu1HMge9F2t3e66RTm-tIw>
 <xmx:SFD8afe_UU_X2LTdOMB6mVJ-L9fJVdizeykNEbf4soRvyqIMfj6ozg>
 <xmx:SVD8afcPEp-b4SCLWgn9htbrhyA3Aa7IxEiwHLWuSmlzwvERACEZwx-o>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 04:41:44 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 07 May 2026 10:41:40 +0200
Subject: [PATCH v2] arm: apple: Add Apple M3 (t8122) support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-apple-m3-support-v2-1-ce3db1c9e3ec@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSw6CMBRFt0Le2GfoBwiO3IdhUOAhNdo2bWk0p
 Hu3sgCH5yT33B0CeU0BLtUOnpIO2poC/FTBtCpzJ9RzYeA1b+umZqicexK+BIbNOesj9svEGzV
 2vZgllJnztOj3kbwNhVcdovWf4yGxn/0TSwwZStY248RVJxZ5fShj1HY2FGHIOX8BPVgrSLEAA
 AA=
X-Change-ID: 20260501-apple-m3-support-9fc25ab793d4
To: u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3591; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=3ud0fU2oYDeu3PqaxUwx4OSmESuwzBl0LIfYxUAR8CA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsw/Ae7GOs5ZXtzx4UpFfN9zt1ZzXXnl3HUkMLw+7cacf
 T+1d9d2lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmMjyeYwMu3Rjm0yurDY5+Xua
 pkP3oa0xSf6mjCar04V8JidHanmyMDK0TS9drXd58pLIE8sPzK6Jvym/8xW7ycLX1j9ful7otDZ
 kAQA=
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
Changes in v2:
- aligned main MMIO region to SZ_1G
- split of NVMe region at 0x300000000
- sorted IO regions by address
- reordered M3 additions chronologically with other SoCs
- Link to v1: https://patch.msgid.link/20260501-apple-m3-support-v1-1-4165bc2a73f4@jannau.net
---
 arch/arm/mach-apple/board.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 4cd8979bdc2..20054f54089 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -673,6 +673,83 @@ static struct mm_region t6022_mem_map[] = {
 	}
 };
 
+/* Apple M3 */
+
+static struct mm_region t8122_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x200000000,
+		.phys = 0x200000000,
+		.size = 4UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* NVMe */
+		.virt = 0x300000000,
+		.phys = 0x300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
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
+		/* I/O ATC0 */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC1 */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
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
 struct mm_region *mem_map;
 
 int board_init(void)
@@ -720,6 +797,8 @@ void build_mem_map(void)
 		mem_map = t6020_mem_map;
 	else if (of_machine_is_compatible("apple,t6022"))
 		mem_map = t6022_mem_map;
+	else if (of_machine_is_compatible("apple,t8122"))
+		mem_map = t8122_mem_map;
 	else
 		panic("Unsupported SoC\n");
 

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260501-apple-m3-support-9fc25ab793d4

Best regards,
-- 
Janne Grunau <j@jannau.net>

