Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53550C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA671879CC;
	Mon, 22 Jan 2024 13:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="p4XKJola";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQhNfTT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C91879CC; Mon, 22 Jan 2024 13:46:41 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263CF879FB
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 5423B5C0117;
 Mon, 22 Jan 2024 07:46:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 22 Jan 2024 07:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1705927598; x=
 1706013998; bh=xTifUcPZUOwG/qSlThWr1ysrkOdEAwvuBBRDl9WUR8o=; b=p
 4XKJolaGEAr4EkjjtUvAz/zzyZ2p0YTckmQ3ULQwcHGdxhTcqQKnFyjo4HHWnZyt
 Lk7Wzrr7MmpS49JkmbUxWilWKQ96pfezPqDqaHGnpp2wTTuSSSqFSZEMY3KliGm4
 ljri/cswA5LrQwjSjyHYxMB3Z87hzKO09DIIqUb6mtwGOYZoc2O1Pthm4zrj8mwh
 2VOaCVITFvR9jGNaisIAHTK29N9kEpj+wVqAw2Y7s7dj+g/QgHxGpuYK8v09Pm26
 VL0DZAXO8cPDTT4Q5C84arIJ+ArnVtw4rp5cnEVhlRnOEnj45548qUm4vT4cmOHE
 cb965Q6UZaT0XSGGNEbGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705927598; x=
 1706013998; bh=xTifUcPZUOwG/qSlThWr1ysrkOdEAwvuBBRDl9WUR8o=; b=M
 QhNfTT8aZ1CTCXu840dN703EWcmuNw+3YK1uJhsLt5JH/dHjEEstfB3EvmesmtvZ
 0r+j+vjZdH6T9qRZlce+a2In+G/GqorDzt4+UE7YVtA/sCm9PyCJIaXo+unDmTDm
 Mz9K6mm8Ssp5946wu63/H9X6Mh4UnXnjyTNjGaA7HS1RFiar7GP8f8beQ14wkQ85
 3mAPO9sSyHIcXBDk6LUeN2a4J/icwRxHsnqHo07A7/yfUy1pX8nldkyNi4ha30ze
 +zBOoBqzCwmmjE82D4slZoV2f+viB3Ote2ZsKdYZw0ccrHRheFHK6Als8pVvh302
 czp8ch+zxN4iu4mA42KOQ==
X-ME-Sender: <xms:rmOuZXc0de8G_7-nsG58P36ZFPB_h6mTGpyvqMHS_tgBuU_MBwY0_g>
 <xme:rmOuZdNctBm5icmU-uwaFk-Ez-JEkqCEPdG5gpk_hfumHDFIvgFWnaNr2R4AltAQN
 MHs8I5ARA>
X-ME-Received: <xmr:rmOuZQhwFYHTA6ctRAzgbXRpMHcSXbhiqI0wXWVDpPaOXBC8NO3tU908L8-_D8ya6p1YhUn2Y_l6r3Ovc-ZACdJDjYDuMuZFk6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:rmOuZY9PC7UqUCJyv2SywY1jOA99co-GnfxvbyGC6nNxenDzlmSMOw>
 <xmx:rmOuZTseY9W9pmX9UO9BNGEUfO8I959ngS0DyMBvk5CLnoaDYOtL9g>
 <xmx:rmOuZXF9p3FE-W-jjfAtb9A_8JwFekYOpZtJL4MWr5fboXGpLcIkiQ>
 <xmx:rmOuZZXbrYBCPO--3Zp9DipRNsz8h88ZwFl6kx6SQXM4EU68VEaX0Q>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 07:46:34 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Mon, 22 Jan 2024 23:46:31 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] ram: rockchip: Add rv1126 ddr4 support
Date: Mon, 22 Jan 2024 23:46:00 +1100
Message-Id: <20240122124603.3341988-3-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122124603.3341988-1-tim@feathertop.org>
References: <20240122124603.3341988-1-tim@feathertop.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add support for ddr4 on rv1126. Timing detection files are imported
from downstream Rockchip BSP u-boot. Allow selecting ddr4 ram with
define CONFIG_RAM_ROCKCHIP_DDR4.

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 .../sdram-rv1126-ddr4-detect-1056.inc         | 75 +++++++++++++++++++
 .../rockchip/sdram-rv1126-ddr4-detect-328.inc | 75 +++++++++++++++++++
 .../rockchip/sdram-rv1126-ddr4-detect-396.inc | 75 +++++++++++++++++++
 .../rockchip/sdram-rv1126-ddr4-detect-528.inc | 75 +++++++++++++++++++
 .../rockchip/sdram-rv1126-ddr4-detect-664.inc | 75 +++++++++++++++++++
 .../rockchip/sdram-rv1126-ddr4-detect-784.inc | 75 +++++++++++++++++++
 .../rockchip/sdram-rv1126-ddr4-detect-924.inc | 75 +++++++++++++++++++
 drivers/ram/rockchip/sdram_rv1126.c           |  8 ++
 8 files changed, 533 insertions(+)
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-1056.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-328.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-396.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-528.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-664.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-784.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-924.inc

diff --git a/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-1056.inc b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-1056.inc
new file mode 100644
index 0000000000..295b0871e0
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-1056.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 0x1,
+			.col = 0xA,
+			.bk = 0x2,
+			.bw = 0x1,
+			.dbw = 0x0,
+			.row_3_4 = 0x0,
+			.cs0_row = 0x11,
+			.cs1_row = 0x0,
+			.cs0_high16bit_row = 0x11,
+			.cs1_high16bit_row = 0x0,
+			.ddrconfig = 0
+		},
+		{
+			{0x561d1219},
+			{0x10030703},
+			{0x00000002},
+			{0x00001111},
+			{0x0000000c},
+			{0x0000034b},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 1056,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 1
+	},
+	{
+		{
+			{0x00000000, 0x43041010},	/* MSTR */
+			{0x00000064, 0x008000b9},	/* RFSHTMG */
+			{0x000000d0, 0x00020103},	/* INIT0 */
+			{0x000000d4, 0x00690000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x07340401},	/* INIT3 */
+			{0x000000e0, 0x00100000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000800},	/* INIT7 */
+			{0x000000f4, 0x000f011f},	/* RANKCTL */
+			{0x00000100, 0x0f102411},	/* DRAMTMG0 */
+			{0x00000104, 0x0004041a},	/* DRAMTMG1 */
+			{0x00000108, 0x0608060d},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x08030409},	/* DRAMTMG4 */
+			{0x00000114, 0x06060403},	/* DRAMTMG5 */
+			{0x00000120, 0x07070d07},	/* DRAMTMG8 */
+			{0x00000124, 0x00020309},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07060004},	/* DFITMG0 */
+			{0x00000198, 0x07000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000614},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000004, 0x0000008c},	/* PHYREG01 */
+			{0x00000014, 0x00000010},	/* PHYREG05 */
+			{0x00000018, 0x00000000},	/* PHYREG06 */
+			{0x0000001c, 0x0000000b},	/* PHYREG07 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-328.inc b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-328.inc
new file mode 100644
index 0000000000..4b424fb440
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-328.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 0x1,
+			.col = 0xA,
+			.bk = 0x2,
+			.bw = 0x1,
+			.dbw = 0x0,
+			.row_3_4 = 0x0,
+			.cs0_row = 0x11,
+			.cs1_row = 0x0,
+			.cs0_high16bit_row = 0x11,
+			.cs1_high16bit_row = 0x0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d110a08},
+			{0x06020501},
+			{0x00000002},
+			{0x00001111},
+			{0x0000000c},
+			{0x00000232},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 328,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x43049010},	/* MSTR */
+			{0x00000064, 0x0027003a},	/* RFSHTMG */
+			{0x000000d0, 0x00020052},	/* INIT0 */
+			{0x000000d4, 0x00220000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x00040000},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000400},	/* INIT7 */
+			{0x000000f4, 0x000f011f},	/* RANKCTL */
+			{0x00000100, 0x09060b06},	/* DRAMTMG0 */
+			{0x00000104, 0x00020209},	/* DRAMTMG1 */
+			{0x00000108, 0x0505040a},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x05030206},	/* DRAMTMG4 */
+			{0x00000114, 0x03030202},	/* DRAMTMG5 */
+			{0x00000120, 0x03030b03},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07030003},	/* DFITMG0 */
+			{0x00000198, 0x07000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000604},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000004, 0x0000008c},	/* PHYREG01 */
+			{0x00000014, 0x0000000a},	/* PHYREG05 */
+			{0x00000018, 0x00000000},	/* PHYREG06 */
+			{0x0000001c, 0x00000009},	/* PHYREG07 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-396.inc b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-396.inc
new file mode 100644
index 0000000000..980be8cf18
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-396.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 0x1,
+			.col = 0xA,
+			.bk = 0x2,
+			.bw = 0x1,
+			.dbw = 0x0,
+			.row_3_4 = 0x0,
+			.cs0_row = 0x11,
+			.cs1_row = 0x0,
+			.cs0_high16bit_row = 0x11,
+			.cs1_high16bit_row = 0x0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d110a0a},
+			{0x07020501},
+			{0x00000002},
+			{0x00001111},
+			{0x0000000c},
+			{0x00000232},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 396,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x43049010},	/* MSTR */
+			{0x00000064, 0x00300046},	/* RFSHTMG */
+			{0x000000d0, 0x00020062},	/* INIT0 */
+			{0x000000d4, 0x00280000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x00040000},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000400},	/* INIT7 */
+			{0x000000f4, 0x000f011f},	/* RANKCTL */
+			{0x00000100, 0x09070d07},	/* DRAMTMG0 */
+			{0x00000104, 0x0002020a},	/* DRAMTMG1 */
+			{0x00000108, 0x0505040a},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x05030206},	/* DRAMTMG4 */
+			{0x00000114, 0x03030202},	/* DRAMTMG5 */
+			{0x00000120, 0x04040b04},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07030003},	/* DFITMG0 */
+			{0x00000198, 0x07000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000604},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000004, 0x0000008c},	/* PHYREG01 */
+			{0x00000014, 0x0000000a},	/* PHYREG05 */
+			{0x00000018, 0x00000000},	/* PHYREG06 */
+			{0x0000001c, 0x00000009},	/* PHYREG07 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-528.inc b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-528.inc
new file mode 100644
index 0000000000..3bde055e8d
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-528.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 0x1,
+			.col = 0xA,
+			.bk = 0x2,
+			.bw = 0x1,
+			.dbw = 0x0,
+			.row_3_4 = 0x0,
+			.cs0_row = 0x11,
+			.cs1_row = 0x0,
+			.cs0_high16bit_row = 0x11,
+			.cs1_high16bit_row = 0x0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d120a0d},
+			{0x09020501},
+			{0x00000002},
+			{0x00001111},
+			{0x0000000c},
+			{0x00000232},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 528,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 0
+	},
+	{
+		{
+			{0x00000000, 0x43049010},	/* MSTR */
+			{0x00000064, 0x0040005d},	/* RFSHTMG */
+			{0x000000d0, 0x00020082},	/* INIT0 */
+			{0x000000d4, 0x00350000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x00040000},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000400},	/* INIT7 */
+			{0x000000f4, 0x000f011f},	/* RANKCTL */
+			{0x00000100, 0x0a0a1209},	/* DRAMTMG0 */
+			{0x00000104, 0x0002020e},	/* DRAMTMG1 */
+			{0x00000108, 0x0505040a},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x05030206},	/* DRAMTMG4 */
+			{0x00000114, 0x03030202},	/* DRAMTMG5 */
+			{0x00000120, 0x04040b04},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07030003},	/* DFITMG0 */
+			{0x00000198, 0x07000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000604},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000004, 0x0000008c},	/* PHYREG01 */
+			{0x00000014, 0x0000000a},	/* PHYREG05 */
+			{0x00000018, 0x00000000},	/* PHYREG06 */
+			{0x0000001c, 0x00000009},	/* PHYREG07 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-664.inc b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-664.inc
new file mode 100644
index 0000000000..c9341166d6
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-664.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 0x1,
+			.col = 0xA,
+			.bk = 0x2,
+			.bw = 0x1,
+			.dbw = 0x0,
+			.row_3_4 = 0x0,
+			.cs0_row = 0x11,
+			.cs1_row = 0x0,
+			.cs0_high16bit_row = 0x11,
+			.cs1_high16bit_row = 0x0,
+			.ddrconfig = 0
+		},
+		{
+			{0x4d130a11},
+			{0x0c020501},
+			{0x00000002},
+			{0x00001111},
+			{0x0000000c},
+			{0x0000023a},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 664,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 1
+	},
+	{
+		{
+			{0x00000000, 0x43041010},	/* MSTR */
+			{0x00000064, 0x00500075},	/* RFSHTMG */
+			{0x000000d0, 0x000200a4},	/* INIT0 */
+			{0x000000d4, 0x00420000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x01040401},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000400},	/* INIT7 */
+			{0x000000f4, 0x000f011f},	/* RANKCTL */
+			{0x00000100, 0x0b0c160c},	/* DRAMTMG0 */
+			{0x00000104, 0x00020211},	/* DRAMTMG1 */
+			{0x00000108, 0x0505040a},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x05030306},	/* DRAMTMG4 */
+			{0x00000114, 0x04040302},	/* DRAMTMG5 */
+			{0x00000120, 0x05050b05},	/* DRAMTMG8 */
+			{0x00000124, 0x00020208},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07030003},	/* DFITMG0 */
+			{0x00000198, 0x07000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000604},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000004, 0x0000008c},	/* PHYREG01 */
+			{0x00000014, 0x0000000a},	/* PHYREG05 */
+			{0x00000018, 0x00000000},	/* PHYREG06 */
+			{0x0000001c, 0x00000009},	/* PHYREG07 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-784.inc b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-784.inc
new file mode 100644
index 0000000000..ef2e9347bf
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-784.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 0x1,
+			.col = 0xA,
+			.bk = 0x2,
+			.bw = 0x1,
+			.dbw = 0x0,
+			.row_3_4 = 0x0,
+			.cs0_row = 0x11,
+			.cs1_row = 0x0,
+			.cs0_high16bit_row = 0x11,
+			.cs1_high16bit_row = 0x0,
+			.ddrconfig = 0
+		},
+		{
+			{0x50160d14},
+			{0x0e020502},
+			{0x00000002},
+			{0x00001111},
+			{0x0000000c},
+			{0x0000033a},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 784,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 1
+	},
+	{
+		{
+			{0x00000000, 0x43041010},	/* MSTR */
+			{0x00000064, 0x005f008a},	/* RFSHTMG */
+			{0x000000d0, 0x000200c1},	/* INIT0 */
+			{0x000000d4, 0x004e0000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x03140401},	/* INIT3 */
+			{0x000000e0, 0x00000000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000400},	/* INIT7 */
+			{0x000000f4, 0x000f011f},	/* RANKCTL */
+			{0x00000100, 0x0c0e1a0e},	/* DRAMTMG0 */
+			{0x00000104, 0x00030314},	/* DRAMTMG1 */
+			{0x00000108, 0x0506050b},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x06030307},	/* DRAMTMG4 */
+			{0x00000114, 0x04040302},	/* DRAMTMG5 */
+			{0x00000120, 0x06060b06},	/* DRAMTMG8 */
+			{0x00000124, 0x00020308},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07040003},	/* DFITMG0 */
+			{0x00000198, 0x07000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x0600060c},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000004, 0x0000008c},	/* PHYREG01 */
+			{0x00000014, 0x0000000c},	/* PHYREG05 */
+			{0x00000018, 0x00000000},	/* PHYREG06 */
+			{0x0000001c, 0x00000009},	/* PHYREG07 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-924.inc b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-924.inc
new file mode 100644
index 0000000000..acb33bd315
--- /dev/null
+++ b/drivers/ram/rockchip/sdram-rv1126-ddr4-detect-924.inc
@@ -0,0 +1,75 @@
+{
+	{
+		{
+			.rank = 0x1,
+			.col = 0xA,
+			.bk = 0x2,
+			.bw = 0x1,
+			.dbw = 0x0,
+			.row_3_4 = 0x0,
+			.cs0_row = 0x11,
+			.cs1_row = 0x0,
+			.cs0_high16bit_row = 0x11,
+			.cs1_high16bit_row = 0x0,
+			.ddrconfig = 0
+		},
+		{
+			{0x531a0f17},
+			{0x0e020603},
+			{0x00000002},
+			{0x00001111},
+			{0x0000000c},
+			{0x00000342},
+			0x000000ff
+		}
+	},
+	{
+		.ddr_freq = 924,	/* clock rate(MHz) */
+		.dramtype = DDR4,
+		.num_channels = 1,
+		.stride = 0,
+		.odt = 1
+	},
+	{
+		{
+			{0x00000000, 0x43041010},	/* MSTR */
+			{0x00000064, 0x007000a2},	/* RFSHTMG */
+			{0x000000d0, 0x000200e3},	/* INIT0 */
+			{0x000000d4, 0x005c0000},	/* INIT1 */
+			{0x000000d8, 0x00000100},	/* INIT2 */
+			{0x000000dc, 0x05240401},	/* INIT3 */
+			{0x000000e0, 0x00080000},	/* INIT4 */
+			{0x000000e4, 0x00110000},	/* INIT5 */
+			{0x000000e8, 0x00000420},	/* INIT6 */
+			{0x000000ec, 0x00000400},	/* INIT7 */
+			{0x000000f4, 0x000f011f},	/* RANKCTL */
+			{0x00000100, 0x0e0e1f10},	/* DRAMTMG0 */
+			{0x00000104, 0x00030317},	/* DRAMTMG1 */
+			{0x00000108, 0x0507050c},	/* DRAMTMG2 */
+			{0x0000010c, 0x0040400c},	/* DRAMTMG3 */
+			{0x00000110, 0x07030308},	/* DRAMTMG4 */
+			{0x00000114, 0x05050303},	/* DRAMTMG5 */
+			{0x00000120, 0x07070b07},	/* DRAMTMG8 */
+			{0x00000124, 0x00020309},	/* DRAMTMG9 */
+			{0x00000180, 0x01000040},	/* ZQCTL0 */
+			{0x00000184, 0x00000000},	/* ZQCTL1 */
+			{0x00000190, 0x07050003},	/* DFITMG0 */
+			{0x00000198, 0x07000101},	/* DFILPCFG0 */
+			{0x000001a0, 0xc0400003},	/* DFIUPD0 */
+			{0x00000240, 0x06000610},	/* ODTCFG */
+			{0x00000244, 0x00000201},	/* ODTMAP */
+			{0x00000250, 0x00001f00},	/* SCHED */
+			{0x00000490, 0x00000001},	/* PCTRL_0 */
+			{0xffffffff, 0xffffffff}
+		}
+	},
+	{
+		{
+			{0x00000004, 0x0000008c},	/* PHYREG01 */
+			{0x00000014, 0x0000000e},	/* PHYREG05 */
+			{0x00000018, 0x00000000},	/* PHYREG06 */
+			{0x0000001c, 0x0000000a},	/* PHYREG07 */
+			{0xffffffff, 0xffffffff}
+		}
+	}
+},
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 9e1376a940..0a78e18c73 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -76,6 +76,14 @@ struct rv1126_sdram_params sdram_configs[] = {
 # include	"sdram-rv1126-lpddr4-detect-784.inc"
 # include	"sdram-rv1126-lpddr4-detect-924.inc"
 # include	"sdram-rv1126-lpddr4-detect-1056.inc"
+#elif defined(CONFIG_RAM_ROCKCHIP_DDR4)
+# include	"sdram-rv1126-ddr4-detect-328.inc"
+# include	"sdram-rv1126-ddr4-detect-396.inc"
+# include	"sdram-rv1126-ddr4-detect-528.inc"
+# include	"sdram-rv1126-ddr4-detect-664.inc"
+# include	"sdram-rv1126-ddr4-detect-784.inc"
+# include	"sdram-rv1126-ddr4-detect-924.inc"
+# include	"sdram-rv1126-ddr4-detect-1056.inc"
 #else
 # include	"sdram-rv1126-ddr3-detect-328.inc"
 # include	"sdram-rv1126-ddr3-detect-396.inc"
-- 
2.40.1

