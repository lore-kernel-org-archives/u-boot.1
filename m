Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEB1EA4FBB
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 13:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEA283C39;
	Mon, 23 Feb 2026 14:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WALEOrR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9081083D17; Mon, 23 Feb 2026 14:19:36 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAF683BC9
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 14:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 906C4C143C7;
 Mon, 23 Feb 2026 13:19:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6D8C75FD43;
 Mon, 23 Feb 2026 13:19:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 692B510368EF5; Mon, 23 Feb 2026 14:19:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771852773; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HagzqjzkAUUgVc48ZuqZ4nX3NxDnP/5GhQY8qvyFtkE=;
 b=WALEOrR9yJAm/o8KHy7932/FdOTRFPuXE/ktR7oSJnF0R0PRfowtuzLaznZjna80MN+4e/
 DoEGeMG2qRUJUVJRFt2MJGK6TLFdKV0MyAl8yT5PAsO6Pj7ce4gpBN1f0+ON6KY1+uDQt1
 Y7zi14jPjvPUxPq1j56cedCVMoi48RpNePAjQqoQfucOl9tyY6jJKgg77Lj3fzI6mlPkd5
 mvSA617dR7K7m8/5yGbPSeeZfUYc06/PjFUKrMZ1LQxXX/fhhV9MxEwbZh43lw+c48UiyC
 kPEk+re+CVvpE64skZyeTpSroX8aBLQcouxPHOtaK0w9DOQYUItma/x21dEBpQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 23 Feb 2026 14:18:35 +0100
Subject: [PATCH v4 1/6] tools: gitignore: Add mkfwumdata to the git ignore file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-feature_fwumdata-v4-1-680ea4ad6ce6@bootlin.com>
References: <20260223-feature_fwumdata-v4-0-680ea4ad6ce6@bootlin.com>
In-Reply-To: <20260223-feature_fwumdata-v4-0-680ea4ad6ce6@bootlin.com>
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

