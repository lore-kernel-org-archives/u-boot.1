Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF807C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B305888BF;
	Wed, 22 May 2024 19:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="YA/sZOfB";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="iQFJgndn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A088888B; Wed, 22 May 2024 19:08:14 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5740388856
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.west.internal (Postfix) with ESMTP id 8F179180012A;
 Wed, 22 May 2024 13:08:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 22 May 2024 13:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397688;
 x=1716484088; bh=38s+PjgRLhFiXFMhKRJmr7D43iEixqksMOEkhrWF4ZQ=; b=
 YA/sZOfBosSJtkZTKplOLPBugOGb/drxIPtc10XSkcXMUVD5P+GbaU/lUAmZYfGG
 n7m3SGMfZjIkO1HF3nOw1A8zSP7OPGr48/QhkcSv9e8sf66ZJIrYWQmXBXgTlQia
 mwYVFe4Bkitj6zavMD/be8oriGoP7w4jozlAxbRT9pGRzgw7+awliRgKS1cS7Yr9
 mgjgZ4cuAi4Ye3XKr1UYViopwFraz7aUzuykti+P8z8aE8f2U9QRzrLlS7Tg+lzK
 //bz0B5cQLgiGK1GDHE3lgkJpD+OfC3P08m+u7lT7y5jfx0D2kh7hVzTR0soDSWe
 TvfnquMXxceIKuE+ePqH/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397688; x=
 1716484088; bh=38s+PjgRLhFiXFMhKRJmr7D43iEixqksMOEkhrWF4ZQ=; b=i
 QFJgndnITUbrN+R0DslVX4+/Xm6yZKdbd51g8//r9ed0kZn/zLhgek/3d7sG+4zb
 FYsXZTwMU6fvBQU+JGvQ/kggboyDeLt9e62hH47sFoRTOCi6mRSJQ9/KSzl/RtH6
 p9z73EXyNQKnLYgeUuqZyHfKaqqFJn43IyBmdiFVH7E7Z190CTQd3YpwvXpcddz+
 aIHUUe5Qq9tqsUdXV3r9aSFTfmOG2tivwKHkxOuVw+gdqVl47g0t/uAWc8GYzh+J
 BtinouyxihLIjxmEJmNYkcwNfc3n4YaWSet/OR/32vFsovcHJ3SZAnBqrfOpPADN
 gEcMBGn2auJl6HdfYpS2g==
X-ME-Sender: <xms:dyZOZmjAUKnn185j7omGMI92rY9RK3LQv1L04MZxNopiUE_cEQYMIQ>
 <xme:dyZOZnB4FXx45J74zhoWGpV8jF0nefL1_iODB2-do4_rqAWe8J2wyw4XNnxxegAal
 tTRrLYBWEboUuS_1XI>
X-ME-Received: <xmr:dyZOZuE_-T02cBw1rkYBg7ygYTCvJk_p219_2mfHq15DEZ9SeWNaj40>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:eCZOZvTE05iY0aQ27Wvc8K_2X1Tz5Z025M6ciCWAhD2InjZ375xWXA>
 <xmx:eCZOZjzYUbowhwkF90E-6Pn9D78N_LDD1R4nbNJYQscuxtXqGmOnPQ>
 <xmx:eCZOZt6VVb1QhTeNT8dkXeAwgjfe6yVx_PBNC3otPO_h6YzkL6-BAg>
 <xmx:eCZOZgzVW6H52NQxj3DezPOPkatA4ZuTSknzSo5jGXAaAAAhx73Yhg>
 <xmx:eCZOZqkPj3nsllTfcMf8_VtDNwKprX-WB1TFESkSWbTShBKLltX8cmY->
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:07 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:08:00 +0100
Subject: [PATCH v2 04/10] xtensa: Define PLATFORM_ELFFLAGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-4-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=923;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Bg0T7Gy8iHeHB/+kjZ88tCd5dyYSS6oL0X9OHgcMNuY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tbxt4j/Ss9TSzap95ZcULfZ+ESd6wefQh+cX7q5Qf
 /furnB5RykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExE6iIjw5I5KgHuMse0WKPz
 zwur6Pd/l7wyzaXT7tPSNct4rFY8mM7IcIWdfQ4z69NNb1gn+Bp0ZZ3aaFRXci0nsLiqV/irqvQ
 qVgA=
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

u-boot.elf target requires it to work.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2:
	- Concerning big endian CPU

Note: CONFIG_SYS_BIG_ENDIAN will never be set for xtensa
for now, but as we don't have big endian headers for xtensa
core either I think it's fine for now. This will be improved
after my arm64be work get merged.
---
 arch/xtensa/config.mk | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/xtensa/config.mk b/arch/xtensa/config.mk
index b0809999e403..200b66f85047 100644
--- a/arch/xtensa/config.mk
+++ b/arch/xtensa/config.mk
@@ -7,3 +7,9 @@ PLATFORM_CPPFLAGS += -D__XTENSA__ -mlongcalls -mforce-no-pic \
 		     -ffunction-sections -fdata-sections
 
 LDFLAGS_FINAL += --gc-sections
+
+ifeq ($(CONFIG_SYS_BIG_ENDIAN),y)
+PLATFORM_CPPFLAGS += -B xtensa -O elf32-xtensa-be
+else
+PLATFORM_ELFFLAGS += -B xtensa -O elf32-xtensa-le
+endif

-- 
2.43.0

