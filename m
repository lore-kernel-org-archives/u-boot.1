Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E611CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 10:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C992B835B3;
	Wed,  3 Sep 2025 12:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756897063;
	bh=lh0dZeQ5rR64YEC3Tu6ADEbhyOC8incpiXN8Bv7H8VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=azuVegTzB6zZELZvg9zAY1nJBZUFR4AkN9bQ+ItDw60J8ICBFfp49D4cZAdWkyuio
	 lg+lxVVr6/FDWMFJViiyOcuQXVNrMyAcleeaE9dkGx+EFAo69paQAuH+XVoMKPD7Yv
	 65hxquehXt7r4XhhcqEjIpNugtA9IgfZGgFsaMUuoZ7R391pSy84urqz0JZ9LrLt8S
	 ns8sYMHr/qODiAqCe2qBvWiGjgJJLQ3Qt9lvoUaUksUcab9pbmPzJCQLAQ68W6BB7G
	 KbJH39z1ZKQ0S6L4o2l9makexxDbkiTqBsOsewuDdWYx+eotGMU9Y+gBL6DWVo06aQ
	 beKLe6b5MXKdA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E18B835B9; Wed,  3 Sep 2025 12:57:42 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2457835B2
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 12:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hbvgil2P"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1026E10246D8B; 
 Wed,  3 Sep 2025 12:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756897060; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=lh0dZeQ5rR64YEC3Tu6ADEbhyOC8incpiXN8Bv7H8VA=;
 b=hbvgil2PmETeWEOsj4pLBKjYjRCaaGrjvjnKIVDot1ucIszsDAjusYHZ3RVCl4xsGmCZlN
 FKpdiVbzlH+VFrCIB0j4b0NMFquTetdGUNAZypUz84S4lwArBq9EYdzz9iIvr+7MRB5Cv2
 dyRiHadcGq8eWHs31LljXdZWrCOPEhAmOCVRXtmQaq63lGArDhNfIuUGDIcJjPUGIGQ84F
 wz3bzyjASJewXVxJDVppKBq09r7bezYRe8yNuJrB8B23uYNeueRIKn6e+Lp1ZPTgB7pNKb
 LzNL9qb1NM+cx/btPHvEZp/NEpwItglkrIN8ETLdPS84OuAwFjy4n1qF6jsKxA==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 5/5] Image size checks: Simplify SPL_SIZE_LIMIT logic
Date: Wed,  3 Sep 2025 12:56:53 +0200
Message-Id: <20250903105653.335417-6-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250903105653.335417-1-pro@denx.de>
References: <20250903105653.335417-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Simplify the depends-on logic for SPL_SIZE_LIMIT. No functional change.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index aa00669ba20..343299eed50 100644
--- a/Kconfig
+++ b/Kconfig
@@ -588,8 +588,8 @@ config HAS_SPL_SIZE_LIMIT
 config SPL_SIZE_LIMIT
 	hex "Maximum size of SPL image in bytes"
 	depends on HAS_SPL_SIZE_LIMIT
-	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
+	default 0x11000 if ARCH_MX6
 	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
 	help
 	  Maximum size of the SPL image. When defined, the build system checks
-- 
2.39.5

