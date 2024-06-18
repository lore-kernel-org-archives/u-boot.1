Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B86C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B69E987CDA;
	Tue, 18 Jun 2024 15:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="fAVylleb";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QN8BNOXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86451882EF; Tue, 18 Jun 2024 15:56:27 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC4D88348
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.west.internal (Postfix) with ESMTP id B2A8718000DA;
 Tue, 18 Jun 2024 09:56:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 18 Jun 2024 09:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718982;
 x=1718805382; bh=WbkI63z+2Uk4GCTfnoCXCiJWAk3DFRVb75t6MyMVUVY=; b=
 fAVyllebbTbJ3WD8QYYI2oSglmzOshj+ci3YRE7wz2xBydY7W+CAokTo+dwkr20w
 ApPGAXVX8thjCueVvcyAo02KBoVYXZIkRwOW8hyB8pjT3hJoZyFtXndSmONSXboK
 SS2e28lrCOvYHuW+duOEQ5O3vMJCYSreMs2fHMAsgZAcIPovTPeZ7Wlbi+1ju0OV
 rS3vZCpZLXCErSj2TgWvatsqQuTFJ5ieoj+XcTlOUHEhBCo3cdYyuwt34/vvetIl
 olBlUkwM/3d85KNQio6IwFYiupsTEfFZElqeXQVH73W/vDZdcM2bxvM1Dh7JV0iS
 a1qoeY+uczhL/II6YkvheA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718982; x=
 1718805382; bh=WbkI63z+2Uk4GCTfnoCXCiJWAk3DFRVb75t6MyMVUVY=; b=Q
 N8BNOXeYh8ZWtyRsBo0vJBSTOqz6Joe7Emrxi+KhEAy3M8NlAqyYh6zVj4I23K13
 MFFA1uhYR51V4aWXdzRI0SaWxid4w6Kj1wjbF7nvYIWvjopu0qgC4S8WkwEacuWP
 GT4lhVRMiWgS1iAVjVNW0Z2S8g4B6e7tpXSm94rNt2Flf9Ha8jOji/Z0KYZwJ99k
 Jbts+jrCbk+seqTJNst2lz31PtShTVXzUiTqSLM0KJjxqGfspRfsyzKU484wphoX
 kgLf9HO3WUkMmkPs/WWB44emRqECcWFUyTdzkyN24svUzVt0wtZU7K1uGjkdYybh
 I5DIkDjf49Ms4N89TIw9Q==
X-ME-Sender: <xms:BpJxZjFJCPLEe8xJcdTxzrnqFB03AfXj441wSA863vvz9qtakUseqw>
 <xme:BpJxZgVMa74EJxYMnWaD1LYhoK4515zt8BchcD4RazYbL6zmxzNgIiu3MamHjc1u8
 90HJWcDG4qt4EM93YI>
X-ME-Received: <xmr:BpJxZlI0-Nv-RwBJbHCxtqhWNWo59qmUIdOzLBpi3fXlyaNETkRFCUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:BpJxZhFfK0TZTtrIgdjdFslfxcWlYZ8aBphez3VTZOvKSVvsYVhayA>
 <xmx:BpJxZpWE0Jsnt9nB6C-AFDYB2avEn9MlesSzJicP5vv8aIld7beTQQ>
 <xmx:BpJxZsPtKJ--YXEKeCpo1p2hCCrRgCcT63q6y5GWhvG9RwDu0I4_fg>
 <xmx:BpJxZo3_a0agr7ltvrciU35OjtWo-wbs2kuAgpnzfvy93ylghc8DrA>
 <xmx:BpJxZrJcTrqOcdyOTO4k2TastiPSUxaUCgTwrqnENf4fgQbkHeAo7tWR>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:21 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:02 +0100
Subject: [PATCH v3 02/12] xtensa: Correct define of _end symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-2-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=G+bopndiRJTk3OXuMr7GY66S9FraQsbXRlczJmyMNkA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYwiGlF79s5j/OXO+8HvoLvqW68/9gcTi9Q/9aw/8
 +2o4c6wjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIPF6G/27TXyy44199dFmF
 gdKesp7Fx4TmzL6+rmfvn5o3D08u+jqHkeGkQuTZJTJs0RO/Kr744zrT+90+6UO9N9Py5zUdT51
 T5MIGAA==
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

So U-Boot is using _end symbol to detect location of devicetree
appended at the end of the ROM.

It needs to be calculated based on end of .data load address,
as in our lds .current address is address in RAM.

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/xtensa/cpu/u-boot.lds         | 2 ++
 arch/xtensa/include/asm/ldscript.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/cpu/u-boot.lds b/arch/xtensa/cpu/u-boot.lds
index 84ba32c04444..72e4b9a706e5 100644
--- a/arch/xtensa/cpu/u-boot.lds
+++ b/arch/xtensa/cpu/u-boot.lds
@@ -82,6 +82,8 @@ SECTIONS
 
   __reloc_end = .;
   __init_end = .;
+  /* Calculation to get end address in ROM */
+  _end = LOADADDR(.data) + (_data_end - _data_start);
 
   SECTION_bss(__init_end (OVERLAY),)
 
diff --git a/arch/xtensa/include/asm/ldscript.h b/arch/xtensa/include/asm/ldscript.h
index 78a0b230bdaa..bcf0fd5a7443 100644
--- a/arch/xtensa/include/asm/ldscript.h
+++ b/arch/xtensa/include/asm/ldscript.h
@@ -165,7 +165,6 @@
 		. = ALIGN(8);						\
 		_bss_end = ABSOLUTE(.);					\
 		__bss_end = ABSOLUTE(.);				\
-		_end = ALIGN(0x8);					\
 		PROVIDE(end = ALIGN(0x8));				\
 		_stack_sentry = ALIGN(0x8);				\
 	}

-- 
2.43.0

