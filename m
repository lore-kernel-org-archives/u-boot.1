Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1877AC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0711F82B33;
	Tue, 10 Jun 2025 14:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LB6lRRdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81094805D7; Tue, 10 Jun 2025 09:41:37 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589AA80C83
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-236192f8770so15878175ad.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749541293; x=1750146093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUWqZEoeCOPi4kA8iZW60G/CH5kQ9HtU0Ua7T5EZUM0=;
 b=LB6lRRdFKmOJOHaBsVkUPOfKrudvOY6Bc0S+fxCbP2n6+Npzguy33JW2nnz+p/bPDF
 a0xPvGjnRejqvAms2jcFJfWWrcfCbx3vm5dR7c2ihz0wOaEfINcWiV6cZ+XsHX74G3sU
 5zSY9beiu0IhyAm+tkN9T1Pco9+AKtBwTu2LdJZKJNj9uO6L0/l16cO2CzWdniAmbYGC
 Ch82AtfQRgisM6VAKCezGiZ/tieUly0Q4So7x8Ns7j3mjG8CYhkD26CU9f/36hG4Qb9t
 AggsloOaAFm2ultlIeAwCLP9PBzQIgljF2S6PZHNYVMUEc8T+nOEPVqg90FAGJb7f622
 wUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541293; x=1750146093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUWqZEoeCOPi4kA8iZW60G/CH5kQ9HtU0Ua7T5EZUM0=;
 b=ia6JFG79ZgA2am3JDJo15woHrE4ZpI5PpUQi/GdmhArQaCT/VYQ2a6SEex0Zk4v5Jo
 kqpqrSWZO8n5Sz25hqtWC77UzUAUsyRaujZFPdBVwRCkfmrennYHMbyMcaxCipnkJ8Ha
 WKZTpNwIC4ZSeraNhSnG1a0tr//ppYZ9RUOVqsmlZLi51Lo2g1CHC1a8IMUn12Ms+c8b
 xhq50Uk87ryrG2wwEUh07OAdMdDCgOAFpbvgIJc4DspBbww3uuyMn6UHpvdDrto0c1C1
 1IniCUoBgrjeEZ9PcSv1rXU+FfjfTZhdhvKfkeD8vGr1h2BxO+L3RIdtioPLdanCOXvP
 tf4A==
X-Gm-Message-State: AOJu0Yx2qdJKXBQo99ia2olHplegyTkZv8kZB0qmJQg2aG6giX0oGeLo
 jlpYK2DBI9CReC2ObW432/njyzP2ornNz+socRs230Ell44k0+ztIJQE7lMw7zQr
X-Gm-Gg: ASbGnctHfALgNZFAu8Es+84Pd0SNzaPgdQGlDPY2ZB4k5RbHo57TR25iF6mIXirPrXe
 a+nr0XQRNy6RPIPVb0enEqcIKgdwjGHhRcY8LF9oVFubXlXTTe25oJXGailKNTUcN44L/vx2mfC
 xPRyLq0G66fuAC+uGiudMYkswKIeFZwQYsHXrbVm/NVMF6FNi3PSFfDPsXujddOw9bYeBXTpw4z
 THIcJbuPnXbuJBaAJSmxkRUxCvfe20Fh4woV8B175TYvAcStUni4jL+0hmm9tS61ruTCrvNCmgT
 kBHq0RS+mkJR4Qfb+duHPV+tUm1Q2kRJ0sZyJjk9RyKgcLDNuothFG0ELJwk9hVyYZsIoVEG6oA
 5PO+Zpv+k6MdTgelM0dBT/JzrSBs4yyuZAFo=
X-Google-Smtp-Source: AGHT+IHNsupu3mT6jvt0qOJ5v1d6DRRR+sMb/llIRpW7pDDwFjcjQQoOx/GIXkSqkDh5UDlFnvuK9g==
X-Received: by 2002:a17:902:f68b:b0:221:1497:7b08 with SMTP id
 d9443c01a7336-23635c9d70cmr40850545ad.23.1749541293458; 
 Tue, 10 Jun 2025 00:41:33 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603092640sm65201945ad.54.2025.06.10.00.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 00:41:33 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, quentin.schulz@cherry.de, ada@thorsis.com,
 paul.henrys_ext@softathome.com, d-gole@ti.com, afd@ti.com,
 d.schultz@phytec.de, nm@ti.com, n-francis@ti.com, alpernebiyasak@gmail.com
Subject: [PATCH v4 1/5] tools: mkimage: propagate error codes from
 fit_handle_file()
Date: Tue, 10 Jun 2025 07:41:17 +0000
Message-ID: <20250610074121.8308-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610074121.8308-1-aristo.chen@canonical.com>
References: <20250610074121.8308-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Jun 2025 14:57:04 +0200
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

The fit_handle_file() function previously returned a hardcoded -1 on
error. This change updates the logic to return the actual error code
stored in `ret`, allowing for error propagation.

This improves debuggability and enables downstream callers to
distinguish different failure causes, such as FDT_ERR_NOTFOUND or
other errors.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index caed8d5f901..3d2fbad3853 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -750,7 +750,7 @@ static int fit_handle_file(struct image_tool_params *params)
 	char bakfile[MKIMAGE_MAX_TMPFILE_LEN + 4] = {0};
 	char cmd[MKIMAGE_MAX_DTC_CMDLINE_LEN];
 	size_t size_inc;
-	int ret;
+	int ret = EXIT_FAILURE;
 
 	/* Flattened Image Tree (FIT) format  handling */
 	debug ("FIT format handling\n");
@@ -854,7 +854,7 @@ static int fit_handle_file(struct image_tool_params *params)
 err_system:
 	unlink(tmpfile);
 	unlink(bakfile);
-	return -1;
+	return ret;
 }
 
 /**
-- 
2.43.0

