Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFECC25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78838849D;
	Sun, 19 May 2024 14:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="NxBmjfK5";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WX5/M27s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FC588291; Sun, 19 May 2024 14:57:11 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6F28849D
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id D55211C000E0;
 Sun, 19 May 2024 08:57:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Sun, 19 May 2024 08:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123426;
 x=1716209826; bh=Y3JDJGNjbgPdvW/klwko4Whyi5RiOGrZtj3GHQI0YEU=; b=
 NxBmjfK5Rmrd55aIFldriFk+LJ9r7q63aIBDPVljObibJjfW5ZswUWRmaKmeIY8p
 fs8nVNFQudwwXlhESNgCJ8JClKCebllIDQtR272pbfMvjlTcmvel1brEz2pHqFAI
 +xj71hH73PQt+eDgttVspwc3J1oqkY7rWYV25DNMbEMyhKb8f5uK0t2BofJU+Uam
 DpDJxMzctZAFa3VKU1mfo21wEl0cDslGwosmDpg4bto7c6H0cBFk0wivTb1/beaa
 /JG7BkqyV/X7vR4TDlftoSD68mRYk0YODk6zDhJDDh6QA4LH04PW7FYBrOSTZJHJ
 YKUAWETFVodU3d4OSRuuRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123426; x=
 1716209826; bh=Y3JDJGNjbgPdvW/klwko4Whyi5RiOGrZtj3GHQI0YEU=; b=W
 X5/M27sXrfmiBbkqBk+4omnGP72e3uQbOgPu8RtG6UfZDpol6RfyPPAfasBH0Mop
 tViV3DG1AUXyCT0CnBpprHc2+3D6hmLbz7K9tYhbminr5vE5QFITnLhbtNtDvtQu
 XjGGsUJOG4IQc+ST6n83+RpiVUgn7cHjTYRP4FgHcNXhjbvdrQsNjM2fsRnSL9VW
 nJgHwfLg3RPaBS4zCx6qvLToZ/BTpxVhOE23wqEaZ7zEfVTVK10RUE9hf3y2fbZO
 FscGTNzTSCIMCDz1EVhZWTsH4s/XKusXhzHIjebl31CtjHv8wqeszj0REGW52vTM
 1lsRe1y6uiEoMKhq0YbIg==
X-ME-Sender: <xms:IvdJZnlhB4adFYR3iwR0VqjxCSKM-Hted8Sk-mj2LNgeGM8X1Dal4w>
 <xme:IvdJZq1SOcQtuWgJ5TTBnfrWQQMfsNAZ7yM8ZICPyzWTs5TV9f0Jv6fE7HwebzXsw
 GJKWSMjxi4_OmenJ6o>
X-ME-Received: <xmr:IvdJZtr5i0Hk8imwrBhyhdoP4zmaqSZh4Nv_2KNEG5WaEbYt7rxdE4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:IvdJZvmp7lAHu7AZD2VL-FlU6JGrbCHGsXC9m2YtCzoiB5OLItm6Gg>
 <xmx:IvdJZl3ZI75875BrQSbg_5f5BKNzZk97aWHsWlshbV6WXOtwnPO34w>
 <xmx:IvdJZuu2L7O0qmelZ0xGZbUeyUfLpZx2DEzaSYTuzOvu6dvU9KCMWg>
 <xmx:IvdJZpWV6QbO2MyMRGGOQAJ3gOOvhCJshUHXoLz45B09H3UAbxTg9Q>
 <xmx:IvdJZh56vpvTIGHjjPzxwrjnmgQu2Jw0wjKn0cJvppQS_3jSamVYbfXD>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:04 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:49 +0100
Subject: [PATCH 04/13] arm: Introduce CPU_LE/CPU_BE macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-4-75cc328eddfa@flygoat.com>
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=893;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=kGsgGTBZ106TsL9GUHooMBgOEinV0JHsE2itsMGv4ms=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7/yFPOsWf0talj8/9+RLV9vmbQxbju053/f4wZ8X9
 hf9cy9JdZSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBENkxk+CsWFdFpd9G0uavu
 0Um5/6kPv3pYRmTOMIt6MWWvBe/xun5GhverLyQtLVn3iS0iacnmzwxRSfK7Xr04VHNi1/aDB6Y
 7dfMCAA==
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

They come from the same header in Linux.
They are used to conditional select code on different endianness.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/include/asm/assembler.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index c3b8f34dd0af..2a3858d15d4e 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -93,4 +93,22 @@
 #define CALGN(code...) code
 #endif
 
+/*
+ * Select code when configured for BE.
+ */
+#if CONFIG_IS_ENABLED(SYS_BIG_ENDIAN)
+#define CPU_BE(code...) code
+#else
+#define CPU_BE(code...)
+#endif
+
+/*
+ * Select code when configured for LE.
+ */
+#if CONFIG_IS_ENABLED(SYS_BIG_ENDIAN)
+#define CPU_LE(code...)
+#else
+#define CPU_LE(code...) code
+#endif
+
 #endif

-- 
2.43.0

