Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556A1CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45EEA84D3A;
	Sat,  9 May 2026 17:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qITzNCNF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vwdEl3O9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4867C84CFE; Sat,  9 May 2026 17:13:23 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CC6484D23
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gCTyS15rbz9stw;
 Sat,  9 May 2026 17:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqYF7MmPqYkvLA2ROD3CyjMZf/lgfJEPEC8skBHgn58=;
 b=qITzNCNFs2XXuTOa4Id6dzugfsn9RikhB8goSZ2Wl6CF8l5Jm+YU3J+ZI0cDAIvWjL2NF+
 N6Ezz2c1oIE/smpD3NZQVfisZhHLVuJys7yVM94mrlhS+6/s3uv8Xs06DNbLA913Kv0vqB
 GBvhnlOGQ4mQk5+ERZpehZINdxz+k5sHjZAXMcKKTcMQZj/N8ul9R3kZ6JYfo2/I2LFCmv
 CJPrnJ4OeHocbFq0c5H3oXrZmpWqQ3rDnLi21SdY1JfnJxxZOSukZmLS/EncZJN6jg27Ik
 smgg0sbrWmaqqaihTi0hEaFAuIjNwybcgdI4aht7I/+GnO3DuBuGkmi4FIeSpg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vwdEl3O9;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EqYF7MmPqYkvLA2ROD3CyjMZf/lgfJEPEC8skBHgn58=;
 b=vwdEl3O9qdiOwQowIn1rsG00axQqfZg16XbVzQx274Wk0xQrnJBI5kFkJH4A39fBugfLZ4
 +qu4hTtRuSuCBO95OgOsl8MbI4OZr+kcxAaMowufaMLfxVzUCj9toPsezV93RULWxtWAWG
 f+x8SAtuumHEosN9qLGhUWX+/hW59ZVfjlpvLvodNpi/njVEZNPlbyGrf5p6qDRzRgk9Bv
 KuK3/OV/vK0BEmpxeb1BkGkIJZWM8GTM8WUn5LVPYHTUy15vXF5LwY9Hft89bj5bENanWC
 0DL56DNjt3I0J1Etva8uwdVEFkV9NTp9ZCUfUklvFyWSy/ACU+Eurjc78Pk9rg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/14] reset: dra7: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:28 +0200
Message-ID: <20260509151308.23067-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 643c17b209e554cb565
X-MBO-RS-META: rd51mh1ahrz96m6q9s8nzzrund69hw5c
X-Rspamd-Queue-Id: 4gCTyS15rbz9stw
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/reset-dra7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-dra7.c b/drivers/reset/reset-dra7.c
index 2f0ec4c042f..6b570d87d23 100644
--- a/drivers/reset/reset-dra7.c
+++ b/drivers/reset/reset-dra7.c
@@ -51,7 +51,7 @@ static int dra7_reset_assert(struct reset_ctl *reset_ctl)
 	return 0;
 }
 
-struct reset_ops dra7_reset_ops = {
+static const struct reset_ops dra7_reset_ops = {
 	.rst_assert = dra7_reset_assert,
 	.rst_deassert = dra7_reset_deassert,
 };
-- 
2.53.0

