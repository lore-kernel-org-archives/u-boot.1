Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E298CC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 22:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B66883C9;
	Wed, 19 Jun 2024 00:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C8zw9nbq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hd+XyhZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6186F87E2E; Wed, 19 Jun 2024 00:55:35 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7BE883B3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W3htD0nGQz9tKs
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lt5vZBJp8fNva4HDZddG7wEqfKDoFN9cG7cLv1L8Lqk=;
 b=C8zw9nbqUMtphkRrl2cGFe2+ly6enRGA/n8Na719YhaXntbxMWWfTFo/Togdrnc0JHa4Rv
 +9OVJVhQf8QMd2FFaPbeDlFD1zVKX/sXXdESewbbHDjWZ0EEE3gYSGkx4XZPF11EXua+/5
 vw/YuwZE9gj39Yv4cxxpO1NkDYnq1p0EVqMciKFqgjUZN19xQrIm0xVnCky8hPp+coGQKa
 T0Mv3wwmFUNKJ+DjRgwig2/r+jw/cRqwN3I7ZpjBl0FH4m/aRVgs1EwLkBDwLcXwxe9F25
 PcdBL1AyeHCMRaF6icZrE18I9z9JkrtMurMbq2ati/vOJhKP1N/yDPAmz4l2Zw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lt5vZBJp8fNva4HDZddG7wEqfKDoFN9cG7cLv1L8Lqk=;
 b=Hd+XyhZMFLyMfl14Borcitkivvm/biwzkBV0j2g1KmCMxcEOg9Qv+V42nQcZY1y2ba74Nz
 seLZKSRm/ZRxBfsQc4DkfBL23qxwUY95hXruUW6XKj+KCYHuw/PiM7ox8BIStpzSyCoQxC
 ptt+7zcZpT5KB/BIP8rL0Ir+l+OgL86z8S0oVZaBACVLBMUlWohlhhpXLaGRGKsGyRMSQS
 ut2xZMyJpaPT9Xg4rUKu2Yvzv6I98PQa5hM4fAaMifGP/gAW9KKJRIN708O6grDxVDmtGZ
 FHD2sub+W/vP5djkjhrnUD7Bcb4p8D9JxRN19/606mzbQ1TEfGeaY9PvuKfxtQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 2/6] clk: renesas: Synchronize R-Car R8A779A0 V3U clock tables
 with Linux 6.9.3
Date: Wed, 19 Jun 2024 00:54:16 +0200
Message-ID: <20240618225505.154437-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
References: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8qpfshpqk5f457815myd89gtazpzg1cu
X-MBO-RS-ID: 81ce60ee28d114b0d02
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

Synchronize R-Car R8A779A0 V3U clock tables with Linux 6.9.3,
commit 1b4861e32e461b6fae14dc49ed0f1c7f20af5146 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a779a0-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
index ba086be0268..b44d5603edd 100644
--- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
@@ -133,7 +133,7 @@ static const struct mssr_mod_clk r8a779a0_mod_clks[] __initconst = {
 	DEF_MOD("avb3",		214,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb4",		215,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb5",		216,	R8A779A0_CLK_S3D2),
-	DEF_MOD("canfd0",	328,	R8A779A0_CLK_CANFD),
+	DEF_MOD("canfd0",	328,	R8A779A0_CLK_S3D2),
 	DEF_MOD("csi40",	331,	R8A779A0_CLK_CSI0),
 	DEF_MOD("csi41",	400,	R8A779A0_CLK_CSI0),
 	DEF_MOD("csi42",	401,	R8A779A0_CLK_CSI0),
-- 
2.43.0

