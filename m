Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3859BD1171E
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 17:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0057183EC6;
	Tue,  2 Dec 2025 18:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cElrfKU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 018F783ED7; Tue,  2 Dec 2025 18:29:09 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D4B183EBA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 18:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 92B7CC16A21;
 Tue,  2 Dec 2025 17:28:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CD4FF606D6;
 Tue,  2 Dec 2025 17:29:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4395B11919E6F; Tue,  2 Dec 2025 18:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764696545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=H6eANGEZqLlTrROt4is2CaAPAuVK1VG7ko0TOaWvLqs=;
 b=cElrfKU1Tc5waVV9tQp1UWICZnbmrNKvH+3cAXg6xlBq1fbVsehrUFfl6oWZG1eJQxubgJ
 /CalyQ3RGGz0a6gBFk7pUPBTF/aloRghI+gEu0bBzjMuDzLpPKD0ahLc4BnJV0QiZ+Uasb
 0mmOdbiPyxHfhsLUVil8UlmrfnyA+ZQZT0huYsanmGlFQRgZxlnYB7hlk1nCC6QfciLgGR
 0qRtWLnOKXtHbesFDUuer6mhv44S21NrMDyR6Epsbc+iFJDTY95eudzOMdbrHuNGGEmADI
 IVxUiI2G/52ha7cTv3NgQVnUtrSqeeUNL/7Q0MmjEk2JHXbuVcSlHkhRWUGlYQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 02 Dec 2025 18:28:29 +0100
Subject: [PATCH 4/6] tools: mkfwumdata: Add bank count validation for FWU
 metadata v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-feature_fwumdata-v1-4-d55154de4103@bootlin.com>
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
In-Reply-To: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
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

The FWU metadata specification version 2 supports a maximum of 4 banks.
Add validation to enforce this limit and prevent creation of non-compliant
metadata structures when using version 2.

Without this check, users could inadvertently create invalid metadata by
specifying more than 4 banks, leading to potential compatibility issues
with FWU-compliant firmware update implementations.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 tools/fwumdata_src/mkfwumdata.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/fwumdata_src/mkfwumdata.c b/tools/fwumdata_src/mkfwumdata.c
index 5ceec7a2980..8b25539fd57 100644
--- a/tools/fwumdata_src/mkfwumdata.c
+++ b/tools/fwumdata_src/mkfwumdata.c
@@ -471,6 +471,12 @@ int main(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if (version == 2 && banks > MAX_BANKS_V2) {
+		fprintf(stderr, "Error: Version 2 supports maximum %d banks, %ld requested.\n",
+			MAX_BANKS_V2, banks);
+		return -EINVAL;
+	}
+
 	/* This command takes UUIDs * images and output file. */
 	if (optind + images + 1 != argc) {
 		fprintf(stderr,

-- 
2.43.0

