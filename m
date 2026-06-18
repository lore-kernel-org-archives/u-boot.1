Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CB0CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 09:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF0184874;
	Thu, 18 Jun 2026 11:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="MuvBQpBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA5818499C; Thu, 18 Jun 2026 11:29:48 +0200 (CEST)
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA23847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 11:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=geanix.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sean@geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1781774986; x=1782034186;
 bh=OI6S6Fntp75HDKJ0WilhyzZNSqYTkL5lR0c6zq0ShIg=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=MuvBQpBJdy6QIIkiwe0G+qvkAeaURciqwInJMiwEKukNAdr842l5lXTKgid3geSf5
 yl/U7Am6WG6XMZu4EfaGL0iTMX/6gjftXRC2WEKu+NHnd4zAandv9vyxc6XXENJ8AY
 f1PJW8QsqNeJg3uXp8z3JsdrQPXWOBL1Q1z6F/k0p7boKaLtpyqBty1LtBoX9Ofhsm
 b68PGyCH/RIKpehVwGmOa0b0bal5BlNZVe/Iyy3So0eAJJcoheJu4HxZK0sZ+3TP4Y
 5uxMHK8d/MiXgVe1t4gFz7upvAr+mS1RisKqov38qSeWvl7TMT2RfzdxADYzy/sjaN
 cmLT46trZUVyg==
X-Pm-Submission-Id: 4ggwRX4F05z2ScXX
From: Sean Nyekjaer <sean@geanix.com>
To: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Sean Nyekjaer <sean@geanix.com>, uboot-stm32@st-md-mailman.stormreply.com,
 u-boot@lists.denx.de
Subject: [PATCH] stm32mp1: use debug() for image entry point message
Date: Thu, 18 Jun 2026 11:29:19 +0200
Message-ID: <20260618092921.3702970-1-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
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

The stm32mp1 specific code prints the image entry point unconditionally
before jumping to the next-stage image, unlike the generic SPL
implementation in common/spl/spl.c.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/mach-stm32mp/stm32mp1/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 252aef1852e..ea5d8a648df 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -361,7 +361,7 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 	image_entry_stm32_t image_entry =
 		(image_entry_stm32_t)spl_image->entry_point;
 
-	printf("image entry point: 0x%lx\n", spl_image->entry_point);
+	debug("image entry point: 0x%lx\n", spl_image->entry_point);
 	image_entry(romapi);
 }
 #endif
-- 
2.52.0

