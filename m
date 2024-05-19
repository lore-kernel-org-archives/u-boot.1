Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D022C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5888869A;
	Sun, 19 May 2024 14:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="P0R7Kjin";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3v7+d/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22438886A7; Sun, 19 May 2024 14:57:31 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F278869A
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.west.internal (Postfix) with ESMTP id 5E74C1C00099;
 Sun, 19 May 2024 08:57:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sun, 19 May 2024 08:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123446;
 x=1716209846; bh=8l6il8cuuasgynmA+dT2G4Ev5N2mVXWRyzKsDEZwueM=; b=
 P0R7KjinS5EoixsJXGJSLAkluDH400kjhZ3vJcKtjIEehtUuFwq60M7JvtjYn3U1
 DIJGxtOV3cX+pPwNxJj927do+glf0oC97NC3gTqmIoyyKfCi4kpDItIGW6dMdFqm
 HBcw95F7XhbV1NuG8GlBzuY4wHcV5CuelO04GxSz0SlVbgBo5Nt47xjicOP3G4P5
 mjLjnsUkEOQnx93jWboWbbZTBzhC90mUFZt6sOVEoPZ2MR77Nm4Sb4FLSiIQwzye
 X+pCfNWO+4o1vUWzEQ68S6Lqo3NU9CrpKPZ8DFAcRh57SMopcgqQAV/NBWzefBky
 pfAlXTE+x5nSkgTuQmfgcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123446; x=
 1716209846; bh=8l6il8cuuasgynmA+dT2G4Ev5N2mVXWRyzKsDEZwueM=; b=l
 3v7+d/tCIfYw5eXjQsXzF6728tadDDOzR1tYsUykmfK3WpwopYAJCGzRMiFOuGXE
 HHrXIJXyroF+ubqedYGdXl+j0KTO3vzmRgFpjR5twDoy90Nhba3vNw+kvwIcAFCc
 Sn6euZ2XnB5+LUa8TzpN2j/LDs81kRaSFjMJlgBzErNhv89c1/y2WFEgElqcsFOh
 9fI+p7oYcHLaAVtkQQeHxjmMON5UptBjeOrZAFJbpp8rdPqz6jGJ3aye3Ku4PaeS
 KMZb/4YvpZEK529F2q36unXw44j6yP3Ciu1GpW8SyWaZRXaoldfQtgJVLnmXejRS
 0G4Wf8EZhjXZL7Y7Hff2w==
X-ME-Sender: <xms:NfdJZvEFBAuFnW74lK8wyGF763qEUrPlVHpqEqvSr9FvOKZkU-qI_g>
 <xme:NfdJZsUpLw6aAlHmybDyc6uAqnvDlMQR-Sj1fLmF_um78qK9TBEhUmd-MONNdwh-B
 mUjedM3aQee97KlB4w>
X-ME-Received: <xmr:NfdJZhIfmLgGrinzbygd9R3n2arA0zWTjr-rA3O80AplNwmQA8EwxOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepheetkeffffehieelueeftdegffeugfeftdethffgffeuheeg
 vdeiieekgfefteefnecuffhomhgrihhnpehsphhinhgpthgrsghlvggpvhekrdhssgenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihu
 nhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:NfdJZtHSKsq6EpEdOFugrTq9b1VroEDc5aP5TZ-JvDxyrPq2BgokRQ>
 <xmx:NfdJZlVNk2CjF52vXz4nCcjcZA7AmMOGvzxw9X6v2JkaFJX8DGSZDA>
 <xmx:NfdJZoPndPfcwT7_DVc04H4LnWitgpwVTbl1hYmY4eUiE9DP46Jo8g>
 <xmx:NfdJZk3WJ97k7HBwGcj8pxb_gcnVGsI7FpKxh_ANvBQYlMRSvslNkQ>
 <xmx:NvdJZvaLqIsE6lh7s7QxT9gN84M4bwPfDLL4DfYsf2VD8Co8lxOj3EXu>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:54 +0100
Subject: [PATCH 09/13] armv8: spin_table: Perform byte swap for jump
 address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-9-75cc328eddfa@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=654;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Wf5Gc/uhUaPSLNaAfAyKmOPA9dyUpZ0qW2sOmjDAvTo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7wKP/+b1br2yLURo/W7H69lFT2QzhSYfNdHxX5bU8
 ffdKeHXHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjARv4WMDI111kqGaW97070m
 PS9JXqqbtydih4LjF2/pLxfPrXF4dJDhr0CE83zp2/yXlY5a9F+8If7+USt7jey8V3eZXr+M27j
 7GRMA
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

Address comes from spin table is always little endian.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/cpu/armv8/spin_table_v8.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/cpu/armv8/spin_table_v8.S b/arch/arm/cpu/armv8/spin_table_v8.S
index 6d268432702f..023c82261ca6 100644
--- a/arch/arm/cpu/armv8/spin_table_v8.S
+++ b/arch/arm/cpu/armv8/spin_table_v8.S
@@ -12,6 +12,8 @@ spin_table_reserve_begin:
 0:	wfe
 	ldr	x0, spin_table_cpu_release_addr
 	cbz	x0, 0b
+	/* spin-table is always little endian */
+CPU_BE(	rev	x0, x0)
 	br	x0
 .globl spin_table_cpu_release_addr
 	.align	3

-- 
2.43.0

