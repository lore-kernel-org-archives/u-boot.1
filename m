Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E227C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7946C88335;
	Thu, 16 May 2024 13:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="pc5yNP1/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIRuI13D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0BB88365; Thu, 16 May 2024 13:41:04 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C0F882D9
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 5A0EE138027E;
 Thu, 16 May 2024 07:40:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 16 May 2024 07:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859656;
 x=1715946056; bh=5ZULVxPEZagq2ZnSNGWIOYhd4uhOIL+SqRKibJ4Sqyo=; b=
 pc5yNP1/GVLoFwCt0YTkzsR97maYIyWAzmg0AsgSzxzy1SJvhOI0R602VVMGcKcN
 BbmH4YT6JBsADpWQmsImnnqCEGdBfOqMhirJ7MA2RuGaKCH8XMVM/04Ph+Gso3Aq
 hXsJw2qNlHIkRFpby5Z19wAtb3JCFzlYoooSzVh2H/s4rCRWyAuxmyo6Ce5YIAku
 TFjswsIeDQbPruW4VPlAKIeOWwtBsTXvuFB2Q/E15kZ2Q4sdvSYer054V/VjOqfX
 fPtgcK/naUhdN2bm1ziXQ0b4czi/+6aZHA/dlJK66A7lkdSoU79O6pB9o7BvS7ep
 EO5JWv0o+Y61etvIAoftbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859656; x=
 1715946056; bh=5ZULVxPEZagq2ZnSNGWIOYhd4uhOIL+SqRKibJ4Sqyo=; b=e
 IRuI13De20hlUHCeqE2n6+9Fz1oUm29K5Xt9kamLFa8e0XkvJY/hwfxXYdlWUFfh
 x1LeuZUOvO8EaNzAx4/wisWnd2eSu4zlIKT8fcMCMpDWmfp377DOU/oWxaERWwZB
 pC3PdP5u8iKD97jvo8vHSZw53iCiN50J4zP8CBgayH08kxJ3RxF4H/bxQzPABSmc
 Z2NXcNjRLmsURRReNLodvTrwUsxAIKAtVnUNJikwhwE3ubzAlTVZyH625OXpQ1F0
 oY0EeG/Sw6BlAZMOVqYHkGIebdKFDzpA60STV+O2jc2yBxDMtVZODWMB0K9h7VPs
 /GPKJdqoHU5QUCobX774Q==
X-ME-Sender: <xms:yPBFZjmrD8s-xSBsU0DvYOLmNXvvSwf6K2cGt5BshpBT8oeb1BxvAA>
 <xme:yPBFZm05AxgZlnjAjlOIbcqf1NCDIltRRCFvs9dHKvT44fQwAE30AgKsDLSqBNT4Y
 O02YXGWxHHJoqfBOuY>
X-ME-Received: <xmr:yPBFZpq504yM66xNAJqnpLA0tox_69RrUBamTfqELlw00qd5Y5L1nbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:yPBFZrnOwRk3YYm5FNEHsd8X08HQwcLqJZXz9zqEbTczeG-D8hn2ZA>
 <xmx:yPBFZh3_DlSZ5hdyMDRMaxmjJvVmEvlqU3SU3OCr794y4nyxZMVBGw>
 <xmx:yPBFZqtJORkV_Rn-FCK65mAWL-TbE7p-PP8dw1lFVY9m_Zi9ZdVZFA>
 <xmx:yPBFZlWR1duneGvngswsTS9l1PtBBvQJ-ZAKJ24QRY6RpJ-am90cqg>
 <xmx:yPBFZquSV3_aQAtcW58TZgOWM_RXYu95YTEDwX91X6vBDuR0vSYEkRcb>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:55 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:30 +0100
Subject: [PATCH v2 10/12] dts/upstream: Add Makefile for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-10-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=749;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=aGEutvGebadnVo5ZyrZMCSxsH5tJeb6Tq/GIekBoQGA=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzv+/Aj9Evw9l7VsnkXh6eoyxq0bPjhk3b5u7Wi5r
 KBja8vTjlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIvBfDP3X1n87XIjTmcFdI
 /Zv33Ny1ge+08o71/y717z/fblfhNYHhD1/DlanPu2r2Hja4KuYiP0dywYQr3Yv7w972PlOqao8
 L4QIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

It is required to make OF_UPSTREAM work.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 dts/upstream/src/mips/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dts/upstream/src/mips/Makefile b/dts/upstream/src/mips/Makefile
new file mode 100644
index 000000000000..9a8f6aa35846
--- /dev/null
+++ b/dts/upstream/src/mips/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -a 0x8
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := */*.dtb */*.dtbo

-- 
2.34.1

