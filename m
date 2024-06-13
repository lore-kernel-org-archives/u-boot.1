Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633EDC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 20:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE738895A;
	Thu, 13 Jun 2024 22:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G19Vh6OZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC9E88953; Thu, 13 Jun 2024 22:28:21 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D412A888C0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 22:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DKS70W084963;
 Thu, 13 Jun 2024 15:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718310487;
 bh=Un60AIECsI+3xUo2ce8rH23YYqNRVWXUPuIy5gwbeAc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=G19Vh6OZB7sBE8j46xJKPmLi3R+KMKFi+K/+52ITvPpbfzzpN3VYdmf6k/5+nvJiJ
 I9Ro1+lMYbNQtG/L8T4XuQYe0AjfhjR6A1k4VQe2hKcyHNkJS6ta0xRIgXocSlF8hh
 PVohKY6zXS9HrWVLRispiWJvcX8YiBlhrTWshuBw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DKS7eZ014338
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Jun 2024 15:28:07 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 15:28:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 15:28:07 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DKS7XN090011;
 Thu, 13 Jun 2024 15:28:07 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Sumit Garg <sumit.garg@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Joshua Watt <jpewhacker@gmail.com>, Caleb
 Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>, Simon Glass
 <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 1/2] scripts/Makefile.lib: fixes: Embed capsule public key
 in platform's dtb
Date: Thu, 13 Jun 2024 15:27:52 -0500
Message-ID: <20240613202753.2528889-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613202753.2528889-1-j-humphreys@ti.com>
References: <20240613202753.2528889-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The call to cmd_capsule_esl_gen was made directly rather than using the
"cmd,xxx" syntax.

Fixes: c7d4dfcd ("scripts/Makefile.lib: Embed capsule public key in
platform's dtb")

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 62f87517c09..af97fcfe4bb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -351,7 +351,7 @@ ifeq ($(CONFIG_EFI_CAPSULE_ESL_FILE),"")
 	$(error "CONFIG_EFI_CAPSULE_ESL_FILE is empty, EFI capsule authentication \
 	public key must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled")
 else
-	$(call cmd_capsule_esl_gen)
+	$(call cmd,capsule_esl_gen)
 endif
 
 capsule_esl_input_file=$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
-- 
2.34.1

