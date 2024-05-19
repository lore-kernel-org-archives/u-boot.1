Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD299C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB7608815E;
	Sun, 19 May 2024 22:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="vmTPx0++";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFPI3Ilw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBFA881EA; Sun, 19 May 2024 22:53:56 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19CD88813F
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 4FC6213808CB;
 Sun, 19 May 2024 16:53:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 19 May 2024 16:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152032;
 x=1716238432; bh=ZdmKnQ9YhE1iT9cs+BdkdUsgu8lxjLTjqPwY0i0EsXk=; b=
 vmTPx0++231QxGQZuiwAX++H0olhtrIoHBk/qZYM35GTEP6ay6YcuZZuxB8RLS7v
 Dukocc5aOBqQFILQG9CaEeKxgl27njk7rBtxufnPNnmHenHuljz7Sg+VBPc4yYcX
 w+dI4JDpwiEVLh41OAlNh54cCk+OZXsilKuXEm2qjB5xBWgYXXLXBVXueJL1+fex
 +kJCpEcz0VQT7X0d8aH9vpB5DNCIsjj35Igou4HsUk/gbekzdjytSA0SmYt7w0IV
 IXyo4E4wlyoZCAxfcYkNK+vlTWYfq5ovhwIMwoaZbjTyRiQ5gz/TUZDprPOithWw
 e5kEg61doj04AKuxolk45A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152032; x=
 1716238432; bh=ZdmKnQ9YhE1iT9cs+BdkdUsgu8lxjLTjqPwY0i0EsXk=; b=V
 FPI3IlwAxcV5Wd8Eoef1M0HKuv2j9eAynLQyi4klT4OCO5CwtaRyxL1g9Ymy01TF
 L8E4XjGPm301K8z6V9WxfbbQNk9/TQO1A3RlCSePKi27tKIaNWJdECc/L3GyYP6K
 p4IdGRpQY8rO3KjQYq5cME25nkhtVUeVZiw9t+99xGrg37x7NV09fsi1p97atDi3
 i4Fpink+aqC67KvoeBp3icIk34icSsozCKF2Zli4xOXK9/2PzqBHKwuDuAPFOaX+
 st9HmCdwKcllzTEUjquoOw5RF3hq+46aca11SMhLDOdfPnddaDuNjHxCoVoPtaHF
 VtdjxNg7IFl22B2c5bMHg==
X-ME-Sender: <xms:4GZKZn4PWRtYAzVoUTvn3Pr9C1rwA0PjtAQxOJNAawY1PWE4VXhEcA>
 <xme:4GZKZs7o9HzL685dhF2T3S5r8fUYQudxUamq3pO9jpyA3DAWoHP09q_5Ely5lCAvl
 nksWojn7CvHWWc153U>
X-ME-Received: <xmr:4GZKZueLuHZGR9MYmyGSGlD6TsyGiCf3Sp68NJK-KKTbnR_cdA_FP6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:4GZKZoKHHOpX-wLTzYwIRpx-LOdchmN6KykMPmjMW3N6yv8al68I9Q>
 <xmx:4GZKZrJCADSdK1js8vgESbqTS54pukDUtwVsxJ44UZllpXVHjOYSXg>
 <xmx:4GZKZhzuBrkrQHwowppCOtfgO0YwUHsa9-BDri6evF9sWg3_p7JiHg>
 <xmx:4GZKZnIbTj43A-3tQyYlIZ-AsV9uxa2uZV5SR3gpE83OjHEDC7FN1g>
 <xmx:4GZKZj9QQZRIsv8AoifB_dxJS3oqYkk1ookUoeXSnepr4em8Ulrg8CA1>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:53:51 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:48 +0100
Subject: [PATCH 01/10] xtensa: Move dram_init to xtfpga board file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-1-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=930;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=GANoPz/dvriQAaXUB4/yZbULtnGNWF6683sB1ucNN2s=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHt6kvbPa5s0tG/9D+Nhs6s21fh8i/9jllZwKfsSW
 QW9jF8dpSwMYlwMsmKKLCECSn0bGi8uuP4g6w/MHFYmkCEMXJwCMJHYQIb/5a5zndQX3rkf//IB
 W1iVaWHIzSRGHlHDuvZ9d/dKsRatYfhfwLt3hq5j8J+ieNGZormzlzmf2yLSbDJ53wMX9fgZfqt
 YAA==
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

This is a board level stuff.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/xtensa/cpu/cpu.c         | 5 -----
 board/cadence/xtfpga/xtfpga.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/cpu/cpu.c b/arch/xtensa/cpu/cpu.c
index abcd8f7984fa..d2266812229c 100644
--- a/arch/xtensa/cpu/cpu.c
+++ b/arch/xtensa/cpu/cpu.c
@@ -48,8 +48,3 @@ int arch_cpu_init(void)
 	gd->ram_size = CFG_SYS_SDRAM_SIZE;
 	return 0;
 }
-
-int dram_init(void)
-{
-	return 0;
-}
diff --git a/board/cadence/xtfpga/xtfpga.c b/board/cadence/xtfpga/xtfpga.c
index 5110fed31194..6b92fe31c0e0 100644
--- a/board/cadence/xtfpga/xtfpga.c
+++ b/board/cadence/xtfpga/xtfpga.c
@@ -66,6 +66,11 @@ unsigned long get_board_sys_clk(void)
 #endif
 }
 
+int dram_init(void)
+{
+	return 0;
+}
+
 int board_postclk_init(void)
 {
 	gd->cpu_clk = get_board_sys_clk();

-- 
2.43.0

