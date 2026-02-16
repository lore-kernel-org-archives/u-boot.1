Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE55E7BDBC
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 13:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A3883CB1;
	Mon, 16 Feb 2026 14:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aK91SNRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD7683B8A; Mon, 16 Feb 2026 14:35:58 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A3B83B8A
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 14:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7E8031A0FC0;
 Mon, 16 Feb 2026 13:35:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4C887606CF;
 Mon, 16 Feb 2026 13:35:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 141461036914F; Mon, 16 Feb 2026 14:35:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771248954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HagzqjzkAUUgVc48ZuqZ4nX3NxDnP/5GhQY8qvyFtkE=;
 b=aK91SNREiaMJ6uCpfwbqSv3h9Aeh03hiW6E9w7e5HN4fJYnRAiVimAdPVztgwiUPTnt+CG
 v84RufaZDeIjomH2kSPyYnhB2QtPx4UCWYFbsGN9mvCEMg/ThV4wwbXcA8Oh+F45TLLTWg
 CqWeHfMoeJ4GnUK1yFFsGVK8s6OkmlW8TcE4iLx5p6F/muZUBz11R8xoxpJNftkYupXuAo
 6U7eUl/PtvsIsgV6IHbD9d8T/+il2/XWovrrjyTpErG6N6qQgRl8yC8AftYwlmVgOWNzb1
 MqbcTOnDIaRF85fNix3RL5UtfCZaGI5G8R11IiCo1ZlXoIuCfuDUKng5zQaogw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 16 Feb 2026 14:35:31 +0100
Subject: [PATCH v3 1/6] tools: gitignore: Add mkfwumdata to the git ignore file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-feature_fwumdata-v3-1-9ecc5b10456d@bootlin.com>
References: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
In-Reply-To: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.14-dev-d4707
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

mkfwumdata is a built image. Add it to .gitignore.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 tools/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/.gitignore b/tools/.gitignore
index 6a5c613f772..e8daa24a52d 100644
--- a/tools/.gitignore
+++ b/tools/.gitignore
@@ -24,6 +24,7 @@
 /mkeficapsule
 /mkenvimage
 /mkexynosspl
+/mkfwumdata
 /mkimage
 /mksunxiboot
 /mxsboot

-- 
2.43.0

