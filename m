Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BE1D1171E
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 17:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B889E83E8E;
	Tue,  2 Dec 2025 18:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hxpSo4Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B71A283C64; Tue,  2 Dec 2025 18:29:04 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD04283EA6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 18:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 585D44E419E6;
 Tue,  2 Dec 2025 17:29:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2D317606D6;
 Tue,  2 Dec 2025 17:29:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3485111919F0B; Tue,  2 Dec 2025 18:28:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764696540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=keBGrGoLQ1oZdEi83j8RcWAFSXWUXrkBmAykWO+af3w=;
 b=hxpSo4YrgUI7exJHyCtMFDogRMU0HAsrfwHTiV2uCL6+fE271CLiEM/O2Nfuk4DfCI1O7I
 EOrSdJ88sOCOXjBZfwd/oANYggRvcRLDk5dnRnSF8yuA7QVFw95jI0aMGAAmlRcKqrixSL
 9216AuGnHebKNEZTYTSscCZLGxOBIuW7IOEUlU0FE1PPHVMLk5ej/dInFRvK8yF+HNygx5
 LCFQDDsF3qNzBbpB43Nk7o6HvGKu+KEoWLbgTJM9pD7YonXzipnR73jMLoLF2ZicCab4Xx
 lGx8bvg4LLJ2vODLtwCQY9epGqSEYq4nb2R3Y8kvhrSALksX8o3b5NP7oB9JGQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 02 Dec 2025 18:28:28 +0100
Subject: [PATCH 3/6] tools: mkfwumdata: Improve error message specificity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-feature_fwumdata-v1-3-d55154de4103@bootlin.com>
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

Replace the generic error message with a more informative one.
This helps users quickly understand the correct command-line argument
format when the tool reports an error.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 tools/fwumdata_src/mkfwumdata.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/fwumdata_src/mkfwumdata.c b/tools/fwumdata_src/mkfwumdata.c
index fbc2067bc12..5ceec7a2980 100644
--- a/tools/fwumdata_src/mkfwumdata.c
+++ b/tools/fwumdata_src/mkfwumdata.c
@@ -473,7 +473,9 @@ int main(int argc, char *argv[])
 
 	/* This command takes UUIDs * images and output file. */
 	if (optind + images + 1 != argc) {
-		fprintf(stderr, "Error: UUID list or output file is not specified or too much.\n");
+		fprintf(stderr,
+			"Error: Expected %ld UUID string(s) and 1 output file, got %d argument(s).\n",
+			images, argc - optind);
 		print_usage();
 		return -ERANGE;
 	}

-- 
2.43.0

