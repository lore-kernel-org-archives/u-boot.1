Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32971C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A004A888AB;
	Wed, 22 May 2024 19:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="sXaSgv7J";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jfr5qsg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E21738888B; Wed, 22 May 2024 19:08:09 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CAF388856
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id 4CC3F18000B7;
 Wed, 22 May 2024 13:08:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 22 May 2024 13:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397683;
 x=1716484083; bh=HGGhjdIBzktfsrN6a24IH5ftL75XU3nRJyM+d4Ewis8=; b=
 sXaSgv7Jsqk88DwnkR0UUxDje1qlIU0MiUVqXIKr4wDQYoL0xf5mnn8hvPaVKtRl
 D4OTP5PBDTjVnPMb6wpkOaoxUkQK6w27mKsGPG9ZD2FJemJFFkCkIbrY4+nXahIf
 JMLjgk+BRCi5Wp86e0cwo7kMlvIC8plU//Mb4tMjzTKtU9EYA9rJa/aKzrgQlo2g
 m/NB8VFWSVYmvEFE35EMF2N6wKljgg6A4myCFeGQoPACEHUyaA6P0/d9/TBU5seu
 2MUx17KHtaH689EDus7UyLuPQ9RdWXy/ijCXfhdXEp0M4vyC3cyF++Da6IpTeSBm
 pE1SzGiJ3JBX5aLvFsXd6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397683; x=
 1716484083; bh=HGGhjdIBzktfsrN6a24IH5ftL75XU3nRJyM+d4Ewis8=; b=j
 fr5qsg/lLSWfewGylU+qMKMS1qvDlAaOL44bQCJ5KkBjxZBBLm0Cp1WN3kK5hls6
 +aag8h28kBdDZe94FpUKZ6KDu/zYXqlBLsQc1o5JmCoLWkoh7/fkxRxStds2Hb4a
 o7mHwpY1+FgqaPhJQLgnUcbyFtwNSL2Ul0D0Pi3d648zi+nFYmNbjl5dH+0ixCLw
 R1+xN2n/RZqup8QRQaaMvQQ7oJAaLp0evsC6tvmEAHTx7Qif3LNVJ4XyAw6qTFAL
 jxJ61cIhWhhpuvOBsN+WdEM84vpEZFsmQkFDNIsurdWztBK6+BKVW261ENxBHeD8
 n5xLXZ9M2QNuGYefTgFFg==
X-ME-Sender: <xms:cyZOZmahgOiZ-7Q1f6BFMTIc84z1IGpUFMwQJN0iCU2PZi_hph4Scw>
 <xme:cyZOZpZ4xBWRBNdL9g-FR8pOrpGDUV7Jp5GrYcAvFSYr7_YzbDK1jhjECFZShs_0o
 cFMmx3Y0T1bsEtmeR8>
X-ME-Received: <xmr:cyZOZg90pv6p5NQKr3xyGoMD_P8awXvhLTtFRSZaTVbWIYgWud1WGJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:cyZOZopQ3D1dR43xwjAy7TwCrGJIUFLsE3lD0jUXtEq3_iFlQ8V0PQ>
 <xmx:cyZOZhoLpm7H0PokrYgq8j62Udt4-hIhFiqVlX43wCjy1Tfo5_yXPw>
 <xmx:cyZOZmSyipPgvhI3sGQCmHbDcE6vF1SsXIz431nmpGty88iKSDkk7g>
 <xmx:cyZOZhpeIQ3fWiJ7b6w_tw9Ug4ibXGlE0q8mNM8VFAEzjVCQGnNBnA>
 <xmx:cyZOZicskRf2jnkMw2c310LJvBga6Yy4g7IM_2NMJSFb1ZPZhncuyNGe>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:02 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:07:58 +0100
Subject: [PATCH v2 02/10] xtensa: Correct define of _end symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-2-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CMOosrUZ8OvYNRpXGbk3SzLd/lJWJFV/k1N3YY0PTxU=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tTyeD50OZ1I2vt7qLp7kt/yYgoPI50/cPpeOyhgnc
 5pqX3PrKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIkssWP4X9f7V9uE/bHhhs5S
 /6Ofxabm5M196T8jyP2XY6SsquAMY4b/ueH2xrw/Go90PT9ry5ql0Dzxr7wal/GSlu4/cnd8lG2
 4AA==
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

