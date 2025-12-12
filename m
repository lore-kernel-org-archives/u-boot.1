Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360F0D59D78
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7E6839A5;
	Fri, 12 Dec 2025 17:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DQHpRUj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D7D28367F; Fri, 12 Dec 2025 17:23:56 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC73A835B3
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7DBA81A2138;
 Fri, 12 Dec 2025 16:23:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4090C606DF;
 Fri, 12 Dec 2025 16:23:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C02D3103C8DFF; Fri, 12 Dec 2025 17:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1765556621; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HagzqjzkAUUgVc48ZuqZ4nX3NxDnP/5GhQY8qvyFtkE=;
 b=DQHpRUj+r85TdjPyaJqBZrxTm/MfBOXcIww9tIVg8gful1YZC8A+ZgaPqCdPkcOv5q85xC
 cznZz/sdPPUwOImHv51O7GwwC4auyCDpU1N0+Dt7hPd0pCBxUfNM6kBVP4hD2HWRSaA0r0
 JN0ZY4vUirgylKGSOMfn07EF8a0GHmDgGz6L/jSQjJSnhhJi6KMGEJFnWwW8heDRvgzgNY
 PlaMlmUFECSr98ugUvXmdsO1WyY9uLqlYz8N3vpOggmiv4hba7Ats41V06FmPSjFwqLDQk
 Tk3tib/OxBLntAyb/ab+DVjQ57M9SuNG8YeGoQKGoVfkd4hvXGEPaURSRzxFVw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 12 Dec 2025 17:23:26 +0100
Subject: [PATCH v2 1/6] tools: gitignore: Add mkfwumdata to the git ignore file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-feature_fwumdata-v2-1-ad51572fbe79@bootlin.com>
References: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
In-Reply-To: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
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

