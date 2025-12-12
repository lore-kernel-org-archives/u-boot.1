Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90880D59D6F
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE723839D5;
	Fri, 12 Dec 2025 17:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1X3Bwvo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 909F5839A5; Fri, 12 Dec 2025 17:23:58 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021BB83837
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8DFE7C19356;
 Fri, 12 Dec 2025 16:23:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AA126606DF;
 Fri, 12 Dec 2025 16:23:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 11281103C8E13; Fri, 12 Dec 2025 17:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1765556633; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=H6eANGEZqLlTrROt4is2CaAPAuVK1VG7ko0TOaWvLqs=;
 b=1X3Bwvo4kDmOZ+NSYIkmfY/V5anzlKtrQtZ435omXnZn+1jtVkkaEdzmxSZzph1YFd/QyQ
 K0jhBHxSqoR8P6vdh6iQuRy40pBIn1r7Gdnow0HuClRNhjVo5bhcBTXVhsTjBxGOvmBH1O
 hAHKZPtt+QkKDSUNkCOhjgOEp6/xVfduqEhydkt5nfRgPj9GlZ1IPy4bpSBQwgvvFC5TUL
 arwOZ7XmroS+fkX+Rv1sbwz+HBf71ILdR9nhas5SB+N489+qVE1l/N6iByeKMHoARrTI7E
 sUtoBTbBrqzNWjv8cN2qT1WFgWdt1c1rp+U5mHPt5cbDskrOMJKMS3jNhIgOQA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 12 Dec 2025 17:23:29 +0100
Subject: [PATCH v2 4/6] tools: mkfwumdata: Add bank count validation for
 FWU metadata v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-feature_fwumdata-v2-4-ad51572fbe79@bootlin.com>
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

