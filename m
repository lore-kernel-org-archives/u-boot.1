Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19623EA4FAE
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 13:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD95883BC9;
	Mon, 23 Feb 2026 14:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zgJZtHg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A842583E13; Mon, 23 Feb 2026 14:19:43 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76DBE80077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 14:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 4C057C143C6;
 Mon, 23 Feb 2026 13:19:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2966F5FD43;
 Mon, 23 Feb 2026 13:19:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F1A5810368EF5; Mon, 23 Feb 2026 14:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771852779; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=keBGrGoLQ1oZdEi83j8RcWAFSXWUXrkBmAykWO+af3w=;
 b=zgJZtHg9rpl9MUMkPqfhcmKimnAyOjToCmQNTt8i6uN49hl/zU9UvIqcxzX2H2srHMoE73
 ffUf27D4Hp9tFLdl0mi7lxlsl7rnVVLeL3lYpPvf1/qbBuZv0iLyWHWA2UXUIT+NVMrNUd
 mEIm7VhngD/ZzZme4rmQGrz/92TpEk7/fKsgdj2yX9TKvpxnwT6VugFsg99HY4ccx3Ll71
 XTQzMmgcB4aqri1N1FzOpp/RSvjDg/2e8n5WC+lZspj6tUIYm0urh3QA9R3nZQz4CbrSy1
 n3wVfgoFzFn/dEpui8KiRZLTTIV8KNyQ/k1Y6q42FxQ05ZFqoB9WI3uumN7gRQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 23 Feb 2026 14:18:37 +0100
Subject: [PATCH v4 3/6] tools: mkfwumdata: Improve error message
 specificity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-feature_fwumdata-v4-3-680ea4ad6ce6@bootlin.com>
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

