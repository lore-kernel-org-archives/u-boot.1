Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDAEC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D987830F3;
	Thu, 17 Apr 2025 20:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BAs9V/Px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C2F830EB; Thu, 17 Apr 2025 20:16:58 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E9482CFD
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-861d7a09c88so14047339f.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913814; x=1745518614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRuvVvSef3hD29ehRVDJArn6X3/uP3Vorkl2VwR+IvE=;
 b=BAs9V/PxPTt34uaovzKIPliee/XdhqO1a76afU7ioFi+r2pyN9gN52XrwHJTFnKXeF
 whpC9JTCqqABw5DUo3eb9f5i189leXbYPEvY/c/HOnpD3rkTH49ylPQBDwIPwXL2sT2S
 sfUc5nAeCZ4/wk/yws11XuWKhs/nWFC2fHa8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913814; x=1745518614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRuvVvSef3hD29ehRVDJArn6X3/uP3Vorkl2VwR+IvE=;
 b=cQSYaJR7W87I0sdliqjnrQEAgOA1ik7vNzRlJoMwCXOBeKDoPXTgsIyv1vdkJst36K
 geBcN47IDo4FtPw6VgTDSW5D9MmGboj4+KEogEVB77QVfqga9PbeJeisWSBnniItzkK0
 Ovy3gKYKHrwinkVK9L87+D9sRc6d0vVNzixt1/D2U81V6g09CskZLsWhU/z02NJXoyxa
 qXb8vVn4VTD2T4i/CHubzh9TGRB8vl8SRcYwlMKd2iRooNx534Odx5Fzkih8x4tJaeIH
 2zKhCRDVZMCEXfDEjY65sys2Y61sVJO1k51i4JXT8aGpSWg4rMd3NipPs/YN0x3AxOp9
 h4kQ==
X-Gm-Message-State: AOJu0YzFIWRSFFxEahrRh9K0UvE37Xbk9ly2VuNhEKGEM2Qi+NvVYngR
 YcxPTixb88hiaDNGrBDY8C/T+tLa1rJlZ4k2c20yk+B58IROEsQ4RnqRrwGkyMFaI1ofCOwl6Fc
 =
X-Gm-Gg: ASbGncupWuqobLyx19RPiapmS22ype3VLX7LGBivjLlUlUxlg2dUmcbkUwlAFolIFKO
 9N+qGtznXhypJmJREJ5Y2jdF5ShC1uHTpSvc5oe/641hBM8/qGpY3ZLYv1p9T0w95H+BAVuy2gw
 9XJVhcVknX70ZryEclK+bdQLsKGwHz28UJu7T1Tge/qPGfs1SM/jDGRGrW5ErWFkTmYz3RKJ/Nk
 M+2fkh5oVpSqR9vNBOeu4mIHqtuH1qfh2DW7vmhRG1tFC9Wbi/u4LvwvgRV+IpmJYmE+flg8AAh
 DCmui9k3UojkiMyrYnml66KzocsOFrHOxKbD1mJ02qoq2wm02T8UjdM60oswkohuOyh4W80nd2Q
 vXQ==
X-Google-Smtp-Source: AGHT+IGY5pomcnvdr4QpC47ACFZzg25PZW65/6IhmZTBxXJqnPZReJzyxUCdOThRPankjRgulVOBTw==
X-Received: by 2002:a05:6602:29aa:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-861c50ae1ecmr906061439f.6.1744913814468; 
 Thu, 17 Apr 2025 11:16:54 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 08/22] fdt: Support reading FDT from standard passage
Date: Thu, 17 Apr 2025 12:15:50 -0600
Message-ID: <20250417181613.1355024-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add an option to receive the FDT using standard passage from a previous
phase. Rename the FDT source to 'passage' to match the old terminology,
which was only partially added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/fdtdec.h |  4 ++--
 lib/fdtdec.c     | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed2..7f7e13cb904 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -72,7 +72,7 @@ struct bd_info;
  *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
  * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. This should
  *	be used for debugging/development only
- * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
+ * @FDTSRC_PASSAGE: Provided by a bloblist from an earlier phase
  */
 enum fdt_source_t {
 	FDTSRC_SEPARATE,
@@ -80,7 +80,7 @@ enum fdt_source_t {
 	FDTSRC_BOARD,
 	FDTSRC_EMBED,
 	FDTSRC_ENV,
-	FDTSRC_BLOBLIST,
+	FDTSRC_PASSAGE,
 };
 
 /*
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 8559616873b..178b1b1247d 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -19,6 +19,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
+#include <passage.h>
 #include <spl.h>
 #include <env.h>
 #include <errno.h>
@@ -90,7 +91,7 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_BOARD] = "board",
 	[FDTSRC_EMBED] = "embed",
 	[FDTSRC_ENV] = "env",
-	[FDTSRC_BLOBLIST] = "bloblist",
+	[FDTSRC_PASSAGE] = "passage",
 };
 
 extern u8 __dtb_dt_begin[];	/* embedded device tree blob */
@@ -1691,9 +1692,16 @@ int fdtdec_setup(void)
 {
 	int ret;
 
-	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
-		printf("Previous phase failed to provide standard passage\n");
-		return -ENOENT;
+	/* The devicetree is typically appended to U-Boot */
+	if (CONFIG_IS_ENABLED(OF_PASSAGE)) {
+		if (!passage_valid()) {
+			printf("Previous phase failed to provide standard passage\n");
+			bloblist_show_list();
+			return -ENOENT;
+		}
+		gd->fdt_blob = map_sysmem(gd_passage_dtb(), 0);
+		gd->fdt_src = FDTSRC_PASSAGE;
+		log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
 	} else {
 		/* The devicetree is typically appended to U-Boot */
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-- 
2.43.0

