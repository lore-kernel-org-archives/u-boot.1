Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FF0CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 22:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9658467E;
	Thu,  4 Jun 2026 00:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="a6Ry76Sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B97184868; Thu,  4 Jun 2026 00:32:53 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D1A83FF5
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 00:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA62410EC24; Thu,  4 Jun 2026 00:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780525969; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Mtl9/jXE89QbukKBay9iPBTjpDG44SFrd/aNEAGdDj8=;
 b=a6Ry76SvTRCE/MSy6msy0X3+AQgvIVPyZ3pjdz9SFwIzjfnXd8kIN6ETpQYSEytKj5izDq
 euXXQ8pyLgLdo6yCV1jqJK1oODjUwlKQrPCCBcFHZmBh5gQbxMiUEemfVvU9pVwc4hsAUi
 WV5nOtVkGoPCUr3zILiayFDUz8e9tSzLgx6beLrHta6ytNIWt98d9/NfIFWqpDe4yv6bAG
 nOUF6PnaW5antg4jgpUgBmGDsfiCY718llgpdHSWW+qsBjRSWcmBc5htcaRqXyUQh/ZT2Q
 dak7YNpGFHsjiezP8eCnqi0w0b+9sL/gLuv2cmpeP8NCcqVRoDak2wQz+p0LqQ==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Fedor Ross <fedor.ross@ifm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Simona Toaca <simona.toaca@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] tools: imx8image: Fix FSPI alignment to 4 kiB
Date: Thu,  4 Jun 2026 00:32:12 +0200
Message-ID: <20260603223245.137065-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
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

The SPI NOR minimum subsector size is 4 kiB, update the alignment.
THis is particularly important in case of embedded DUMMY_DDR, which
must be at at least 4 kiB aligned offset.

Fixes: a2b96ece5be1 ("tools: add i.MX8/8X image support")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fedor Ross <fedor.ross@ifm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simona Toaca <simona.toaca@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 tools/imx8image.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/imx8image.c b/tools/imx8image.c
index 84f46bcaf37..bb1b8667971 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -80,7 +80,7 @@ static table_entry_t imx8image_core_entries[] = {
 static table_entry_t imx8image_sector_size[] = {
 	{0x400,		"sd",			"sd/emmc",},
 	{0x400,		"emmc_fastboot",	"emmc fastboot",},
-	{0x400,		"fspi",			"flexspi",	},
+	{0x1000,	"fspi",			"flexspi",	},
 	{0x1000,	"nand_4k",		"nand 4K",	},
 	{0x2000,	"nand_8k",		"nand 8K",	},
 	{0x4000,	"nand_16k",		"nand 16K",	},
-- 
2.53.0

